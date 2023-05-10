// Copyright 2022-2023 The Parca Authors
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

package cpu

import (
	"context"
	"fmt"
	"os/exec"
	"strings"
	"syscall"
	"testing"
	"time"
	"unsafe"

	//bpf "github.com/aquasecurity/libbpfgo"
	//bpf "github.com/aquasecurity/libbpfgo"
	bpf "github.com/aquasecurity/libbpfgo"
	"github.com/go-kit/log"
	"github.com/google/pprof/profile"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/common/model"
	"github.com/prometheus/procfs"
	"github.com/prometheus/prometheus/model/relabel"
	"github.com/stretchr/testify/require"

	"github.com/parca-dev/parca-agent/pkg/address"
	"github.com/parca-dev/parca-agent/pkg/ksym"
	"github.com/parca-dev/parca-agent/pkg/logger"
	"github.com/parca-dev/parca-agent/pkg/metadata"
	"github.com/parca-dev/parca-agent/pkg/metadata/labels"
	"github.com/parca-dev/parca-agent/pkg/objectfile"
	"github.com/parca-dev/parca-agent/pkg/perf"
	"github.com/parca-dev/parca-agent/pkg/process"
	"github.com/parca-dev/parca-agent/pkg/profiler"
	"github.com/parca-dev/parca-agent/pkg/symbol"
	"github.com/parca-dev/parca-agent/pkg/vdso"
)

type Sample struct {
	labels  model.LabelSet
	profile *profile.Profile
}

type TestProfileWriter struct {
	samples []Sample
}

func NewTestProfileWriter() *TestProfileWriter {
	return &TestProfileWriter{samples: make([]Sample, 0)}
}

func (tpw *TestProfileWriter) Write(_ context.Context, labels model.LabelSet, profile *profile.Profile) error {
	tpw.samples = append(tpw.samples, Sample{
		labels:  labels,
		profile: profile,
	})
	return nil
}

func (tpw *TestProfileWriter) SampleForProcess(pid int) *Sample {

	for _, sample := range tpw.samples {
		if string(sample.labels["pid"]) == fmt.Sprint(pid) { // awful
			return &sample
		}
	}

	return nil
}

func prepareProfiler(t *testing.T, profileWriter profiler.ProfileWriter, logger log.Logger, tempDir string) (*CPU, *objectfile.Pool) {
	loopDuration := 1 * time.Second
	disableJit := true
	frequency := uint64(27)
	reg := prometheus.NewRegistry()
	pfs, err := procfs.NewDefaultFS()
	require.Nil(t, err)
	bpfProgramLoaded := make(chan bool, 1)
	debugNormalizeAddresses := false
	memlockRlimit := uint64(4000000)

	curr, _, err := profiler.Files()
	require.Nil(t, err)

	ofp := objectfile.NewPool(logger, reg, curr)

	vdsoCache, err := vdso.NewCache(ofp)
	require.Nil(t, err)

	dbginfo := process.NoopDebuginfoManager{}
	labelsManager := labels.NewManager(
		logger,
		reg,
		[]metadata.Provider{
			metadata.Compiler(logger, reg, ofp),
			metadata.Process(pfs),
			metadata.System(),
			metadata.PodHosts(),
		},
		[]*relabel.Config{},
		loopDuration,
	)

	return NewCPUProfiler(
		logger,
		reg,
		process.NewInfoManager(
			logger,
			reg,
			process.NewMapManager(pfs, ofp),
			dbginfo,
			labelsManager,
			loopDuration,
		),
		address.NewNormalizer(logger, reg, debugNormalizeAddresses),
		symbol.NewSymbolizer(
			log.With(logger, "component", "symbolizer"),
			perf.NewCache(logger),
			ksym.NewKsym(logger, reg, tempDir),
			vdsoCache,
			disableJit,
		),
		profileWriter,
		loopDuration,
		frequency,
		memlockRlimit,
		[]string{},
		false,
		true,
		bpfProgramLoaded,
	), ofp
}
func TestCPUProfilerWorks(t *testing.T) {
	profileWriter := NewTestProfileWriter()
	profileDuration := 3 * time.Second
	tempDir := t.TempDir()
	logger := logger.NewLogger("error", "logfmt", "parca-agent-tests")

	ctx, cancel := context.WithTimeout(context.Background(), profileDuration)
	defer cancel()

	profiler, ofp := prepareProfiler(t, profileWriter, logger, tempDir)
	defer ofp.Close()

	// Test that we get samples from the DWARF-based unwinder.
	dateCmd := exec.CommandContext(ctx, "../../../testdata/out/basic-cpp-plt")
	err := dateCmd.Start()
	require.Nil(t, err)
	dwarfUnwoundPid := dateCmd.Process.Pid

	err = profiler.Run(ctx)
	require.Equal(t, err, context.DeadlineExceeded)

	require.True(t, len(profileWriter.samples) > 0)

	sample := profileWriter.SampleForProcess(dwarfUnwoundPid)
	require.NotNil(t, sample)

	// Test expected metadata.
	require.Equal(t, string(sample.labels["comm"]), "basic-cpp-plt")
	require.True(t, strings.Contains(string(sample.labels["executable"]), "basic-cpp-plt"))
	require.True(t, strings.HasPrefix(string(sample.labels["compiler"]), "GCC"))
	require.NotEqual(t, string(sample.labels["kernel_release"]), "")
	require.NotEqual(t, string(sample.labels["cgroup_name"]), "")

	// Test basic profiler structure.
	require.True(t, sample.profile.DurationNanos < profileDuration.Nanoseconds())
	require.True(t, len(sample.profile.Sample) > 0)
	require.True(t, len(sample.profile.Location) > 0)
	require.True(t, len(sample.profile.Mapping) > 0)
}

// The intent of these tests is to ensure that libbpfgo behaves the
// way we expect.
//
// We also use them to ensure that different kernel versions load our
// BPF program.
func SetUpBpfProgram(t *testing.T) (*bpf.Module, error) {
	t.Helper()
	logger := logger.NewLogger("debug", logger.LogFormatLogfmt, "parca-cpu-test")

	memLock := uint64(1200 * 1024 * 1024) // ~1.2GiB
	m, _, err := loadBpfProgram(logger, prometheus.NewRegistry(), true, true, memLock)
	require.NoError(t, err)

	return m, err
}

func TestDeleteNonExistentKeyReturnsEnoent(t *testing.T) {
	m, err := SetUpBpfProgram(t)
	require.NoError(t, err)
	t.Cleanup(m.Close)
	bpfMap, err := m.GetMap(stackCountsMapName)
	require.NoError(t, err)

	stackID := int32(1234)

	// Delete should fail as the key doesn't exist.
	err = bpfMap.DeleteKey(unsafe.Pointer(&stackID))
	require.Error(t, err)
	require.ErrorIs(t, err, syscall.ENOENT)
}

func TestDeleteExistentKey(t *testing.T) {
	m, err := SetUpBpfProgram(t)
	require.NoError(t, err)
	t.Cleanup(m.Close)
	bpfMap, err := m.GetMap(stackCountsMapName)
	require.NoError(t, err)

	stackID := int32(1234)

	// Insert some element that will be later deleted.
	value := []byte{'a'}
	err = bpfMap.Update(unsafe.Pointer(&stackID), unsafe.Pointer(&value[0]))
	require.NoError(t, err)

	// Delete should work.
	err = bpfMap.DeleteKey(unsafe.Pointer(&stackID))
	require.NoError(t, err)
}

func hasBatchOperations(t *testing.T) bool {
	t.Helper()

	m, err := SetUpBpfProgram(t)
	require.NoError(t, err)
	t.Cleanup(m.Close)
	bpfMap, err := m.GetMap(stackCountsMapName)
	require.NoError(t, err)

	keys := make([]stackCountKey, bpfMap.GetMaxEntries())
	countKeysPtr := unsafe.Pointer(&keys[0])
	nextCountKey := uintptr(1)
	batchSize := bpfMap.GetMaxEntries()
	_, err = bpfMap.GetValueAndDeleteBatch(countKeysPtr, nil, unsafe.Pointer(&nextCountKey), batchSize)

	return err == nil
}

func TestGetValueAndDeleteBatchWithEmptyMap(t *testing.T) {
	if !hasBatchOperations(t) {
		t.Skip("Skipping testing of batched operations as they aren't supported")
	}

	m, err := SetUpBpfProgram(t)
	require.NoError(t, err)
	t.Cleanup(m.Close)
	bpfMap, err := m.GetMap(stackCountsMapName)
	require.NoError(t, err)

	keys := make([]stackCountKey, bpfMap.GetMaxEntries())
	countKeysPtr := unsafe.Pointer(&keys[0])
	nextCountKey := uintptr(1)
	batchSize := bpfMap.GetMaxEntries()
	values, err := bpfMap.GetValueAndDeleteBatch(countKeysPtr, nil, unsafe.Pointer(&nextCountKey), batchSize)
	require.NoError(t, err)
	require.Equal(t, 0, len(values))
}

func TestGetValueAndDeleteBatchFewerElementsThanCount(t *testing.T) {
	if !hasBatchOperations(t) {
		t.Skip("Skipping testing of batched operations as they aren't supported")
	}

	m, err := SetUpBpfProgram(t)
	require.NoError(t, err)
	t.Cleanup(m.Close)
	bpfMap, err := m.GetMap(stackCountsMapName)
	require.NoError(t, err)

	stackID := int32(1234)

	// Insert some element that will be later deleted.
	value := []byte{'a'}
	err = bpfMap.Update(unsafe.Pointer(&stackID), unsafe.Pointer(&value[0]))
	require.NoError(t, err)

	// Request more elements than we have, this should return and delete everything.
	keys := make([]stackCountKey, bpfMap.GetMaxEntries())
	countKeysPtr := unsafe.Pointer(&keys[0])
	nextCountKey := uintptr(1)
	batchSize := bpfMap.GetMaxEntries()
	values, err := bpfMap.GetValueAndDeleteBatch(countKeysPtr, nil, unsafe.Pointer(&nextCountKey), batchSize)
	require.NoError(t, err)
	require.Equal(t, 1, len(values))
}

func TestGetValueAndDeleteBatchExactElements(t *testing.T) {
	if !hasBatchOperations(t) {
		t.Skip("Skipping testing of batched operations as they aren't supported")
	}

	m, err := SetUpBpfProgram(t)
	require.NoError(t, err)
	t.Cleanup(m.Close)
	bpfMap, err := m.GetMap(stackCountsMapName)
	require.NoError(t, err)

	stackID := int32(1234)

	// Insert some element that will be later deleted.
	value := []byte{'a'}
	err = bpfMap.Update(unsafe.Pointer(&stackID), unsafe.Pointer(&value[0]))
	require.NoError(t, err)

	// Request exactly the elements we have.
	keys := make([]stackCountKey, 1)
	countKeysPtr := unsafe.Pointer(&keys[0])
	nextCountKey := uintptr(1)
	batchSize := uint32(1)
	values, err := bpfMap.GetValueAndDeleteBatch(countKeysPtr, nil, unsafe.Pointer(&nextCountKey), batchSize)
	require.NoError(t, err)
	require.Equal(t, 1, len(values))
}
