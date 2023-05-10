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
	"syscall"
	"testing"
	"time"

	//bpf "github.com/aquasecurity/libbpfgo"
	//bpf "github.com/aquasecurity/libbpfgo"
	"github.com/go-kit/log"
	"github.com/go-kit/log/level"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/procfs"
	"github.com/prometheus/prometheus/model/relabel"

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

func rlimitNOFILE() (int, int, error) {
	var limit syscall.Rlimit
	if err := syscall.Getrlimit(syscall.RLIMIT_NOFILE, &limit); err != nil {
		return 0, 0, err
	}
	return int(limit.Cur), int(limit.Max), nil
}

func TestIntegration(t *testing.T) {
	loopDuration := time.Second * 5
	disableJit := true
	logLevel := "debug"
	logFormat := "logfmt"
	logger := logger.NewLogger(logLevel, logFormat, "parca-agent-tests")
	reg := prometheus.NewRegistry()
	pfs, err := procfs.NewDefaultFS()
	bpfProgramLoaded := make(chan bool, 1)
	debugNormalizeAddresses := false
	memlockRlimit := uint64(4000000)
	tempDir := t.TempDir()

	///
	profileWriter := profiler.NewFileProfileWriter(tempDir)

	if err != nil {
		panic(fmt.Errorf("failed to open procfs: %w", err))
	}
	curr, _, err := rlimitNOFILE()
	if err != nil {
		panic(fmt.Errorf("failed to get rlimit NOFILE: %w", err))
	}
	ofp := objectfile.NewPool(logger, reg, curr) // Probably we need a little less than this.
	defer ofp.Close()                            // Will make sure all the files are closed.

	vdsoCache, err := vdso.NewCache(ofp)
	if err != nil {
		level.Error(logger).Log("msg", "failed to initialize vdso cache", "err", err)
	}

	dbginfo := process.NoopDebuginfoManager{}
	labelsManager := labels.NewManager(
		logger,
		reg,
		// All the metadata providers work best-effort.
		[]metadata.Provider{
			/*    discoveryMetadata,
			      metadata.Target(flags.Node, flags.Metadata.ExternalLabels),
			      metadata.Compiler(logger, reg, ofp),
			      metadata.Process(pfs),
			      metadata.JavaProcess(logger),
			      metadata.System(),
			      metadata.PodHosts(), */
		},
		[]*relabel.Config{},
		loopDuration,
	)

	profiler := NewCPUProfiler(
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
		27,
		memlockRlimit,
		[]string{},
		false,
		true,
		bpfProgramLoaded,
	)

	ctx, cancel := context.Background()
	go func() {
		time.Sleep(5 * time.Second)
		cancel()
	}()

	profiler.Run(ctx)
}

// The intent of these tests is to ensure that libbpfgo behaves the
// way we expect.
//
// We also use them to ensure that different kernel versions load our
// BPF program.
/* func SetUpBpfProgram(t *testing.T) (*bpf.Module, error) {
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
*/
