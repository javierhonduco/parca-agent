// Copyright 2022 The Parca Authors
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

import "C"

import (
	"bytes"
	"debug/elf"
	"encoding/binary"
	"errors"
	"fmt"
	"os"
	"path"
	"sort"
	"time"
	"unsafe"

	"github.com/parca-dev/parca-agent/pkg/buildid"
	"github.com/parca-dev/parca-agent/pkg/executable"
	"github.com/parca-dev/parca-agent/pkg/stack/unwind"
	"golang.org/x/exp/constraints"

	bpf "github.com/aquasecurity/libbpfgo"
)

const (
	debugPIDsMapName        = "debug_pids"
	stackCountsMapName      = "stack_counts"
	stackTracesMapName      = "stack_traces"
	unwindShardsMapName     = "unwind_shards"
	dwarfStackTracesMapName = "dwarf_stack_traces"
	unwindTablesMapName     = "unwind_tables"
	processInfoMapName      = "process_info"
	programsMapName         = "programs"

	// With the current row structure, the max items we can store is 262k per map.
	unwindTableMaxEntries = 100
	maxUnwindTableSize    = 250 * 1000 // Always needs to be sync with MAX_UNWIND_TABLE_SIZE in the BPF program.
	unwindTableShardCount = 30         // Always needs to be sync with MAX_SHARDS in the BPF program.
	maxUnwindSize         = maxUnwindTableSize * unwindTableShardCount
)

var (
	errMissing       = errors.New("missing stack trace")
	errUnwindFailed  = errors.New("stack ID is 0, probably stack unwinding failed")
	errUnrecoverable = errors.New("unrecoverable error")
)

type bpfMaps struct {
	module    *bpf.Module
	byteOrder binary.ByteOrder

	debugPIDs *bpf.BPFMap

	stackCounts      *bpf.BPFMap
	stackTraces      *bpf.BPFMap
	dwarfStackTraces *bpf.BPFMap
	processInfo      *bpf.BPFMap

	unwindShards *bpf.BPFMap
	unwindTables *bpf.BPFMap
	programs     *bpf.BPFMap

	// unwind stuff 🔬
	buildIdMapping map[string]uint64
	//	globalView []{shard_id:, [all the ranges it contains]}
	// which shard we are on
	shardIndex    uint64
	executableId  uint64
	unwindInfoBuf *bytes.Buffer
	// Account where we are within a shard
	lowIndex  int
	highIndex int
	// Other stats
	totalEntries       uint64
	uniqueMappings     uint64
	referencedMappings uint64
}

func min[T constraints.Ordered](a, b T) T {
	if a < b {
		return a
	}
	return b
}

func initializeMaps(m *bpf.Module, byteOrder binary.ByteOrder) (*bpfMaps, error) {
	if m == nil {
		return nil, fmt.Errorf("nil module")
	}

	unwindInfoArray := make([]byte, 0, maxUnwindTableSize)

	maps := &bpfMaps{
		module:         m,
		byteOrder:      byteOrder,
		unwindInfoBuf:  bytes.NewBuffer(unwindInfoArray),
		buildIdMapping: make(map[string]uint64),
	}

	return maps, nil
}

// adjustMapSizes updates unwinding maps' maximum size. By default, it tries to keep it as low
// as possible.
//
// Note: It must be called before `BPFLoadObject()`.
func (m *bpfMaps) adjustMapSizes(enableDWARFUnwinding bool) error {
	unwindTables, err := m.module.GetMap(unwindTablesMapName)
	if err != nil {
		return fmt.Errorf("get unwind tables map: %w", err)
	}

	// Adjust unwind tables size.
	if enableDWARFUnwinding {
		sizeBefore := unwindTables.GetMaxEntries()
		if err := unwindTables.Resize(unwindTableMaxEntries); err != nil {
			return fmt.Errorf("resize unwind tables map from %d to %d elements: %w", sizeBefore, unwindTableMaxEntries, err)
		}
	}

	return nil
}

func (m *bpfMaps) create() error {
	debugPIDs, err := m.module.GetMap(debugPIDsMapName)
	if err != nil {
		return fmt.Errorf("get debug pids map: %w", err)
	}

	stackCounts, err := m.module.GetMap(stackCountsMapName)
	if err != nil {
		return fmt.Errorf("get counts map: %w", err)
	}

	stackTraces, err := m.module.GetMap(stackTracesMapName)
	if err != nil {
		return fmt.Errorf("get stack traces map: %w", err)
	}

	unwindShards, err := m.module.GetMap(unwindShardsMapName)
	if err != nil {
		return fmt.Errorf("get unwind shards map: %w", err)
	}

	unwindTables, err := m.module.GetMap(unwindTablesMapName)
	if err != nil {
		return fmt.Errorf("get unwind tables map: %w", err)
	}

	dwarfStackTraces, err := m.module.GetMap(dwarfStackTracesMapName)
	if err != nil {
		return fmt.Errorf("get dwarf stack traces map: %w", err)
	}

	processInfo, err := m.module.GetMap(processInfoMapName)
	if err != nil {
		return fmt.Errorf("get process info map: %w", err)
	}

	m.debugPIDs = debugPIDs
	m.stackCounts = stackCounts
	m.stackTraces = stackTraces
	m.unwindShards = unwindShards
	m.unwindTables = unwindTables
	m.dwarfStackTraces = dwarfStackTraces
	m.processInfo = processInfo

	return nil
}

func (m *bpfMaps) setDebugPIDs(pids []int) error {
	// Clean up old debug pids.
	it := m.debugPIDs.Iterator()
	var prev []byte = nil
	for it.Next() {
		if prev != nil {
			err := m.debugPIDs.DeleteKey(unsafe.Pointer(&prev[0]))
			if err != nil {
				return fmt.Errorf("failed to delete debug pid: %w", err)
			}
		}

		key := it.Key()
		prev = make([]byte, len(key))
		copy(prev, key)
	}
	if prev != nil {
		err := m.debugPIDs.DeleteKey(unsafe.Pointer(&prev[0]))
		if err != nil {
			return fmt.Errorf("failed to delete debug pid: %w", err)
		}
	}
	// Set new debug pids.
	one := uint8(1)
	for _, pid := range pids {
		pid := int32(pid)
		if err := m.debugPIDs.Update(unsafe.Pointer(&pid), unsafe.Pointer(&one)); err != nil {
			return fmt.Errorf("failure setting debug pid %d: %w", pid, err)
		}
	}
	return nil
}

// readUserStack reads the user stack trace from the stacktraces ebpf map into the given buffer.
func (m *bpfMaps) readUserStack(userStackID int32, stack *combinedStack) error {
	if userStackID == 0 {
		return errUnwindFailed
	}

	stackBytes, err := m.stackTraces.GetValue(unsafe.Pointer(&userStackID))
	if err != nil {
		return fmt.Errorf("read user stack trace, %v: %w", err, errMissing)
	}

	if err := binary.Read(bytes.NewBuffer(stackBytes), m.byteOrder, stack[:stackDepth]); err != nil {
		return fmt.Errorf("read user stack bytes, %s: %w", err, errUnrecoverable)
	}

	return nil
}

// readUserStackWithDwarf reads the DWARF walked user stack traces into the given buffer.
func (m *bpfMaps) readUserStackWithDwarf(userStackID int32, stack *combinedStack) error {
	if userStackID == 0 {
		return errUnwindFailed
	}

	type dwarfStacktrace struct {
		Len   uint64
		Addrs [stackDepth]uint64
	}

	stackBytes, err := m.dwarfStackTraces.GetValue(unsafe.Pointer(&userStackID))
	if err != nil {
		return fmt.Errorf("read user stack trace, %v: %w", err, errMissing)
	}

	var dwarfStack dwarfStacktrace
	if err := binary.Read(bytes.NewBuffer(stackBytes), m.byteOrder, &dwarfStack); err != nil {
		return fmt.Errorf("read user stack bytes, %s: %w", err, errUnrecoverable)
	}

	userStack := stack[:stackDepth]
	for i := 0; i < stackDepth; i++ {
		if i < int(dwarfStack.Len) {
			userStack[i] = dwarfStack.Addrs[i]
		} else {
			userStack[i] = 0
		}
	}

	return nil
}

// readKernelStack reads the kernel stack trace from the stacktraces ebpf map into the given buffer.
func (m *bpfMaps) readKernelStack(kernelStackID int32, stack *combinedStack) error {
	if kernelStackID == 0 {
		return errUnwindFailed
	}

	stackBytes, err := m.stackTraces.GetValue(unsafe.Pointer(&kernelStackID))
	if err != nil {
		return fmt.Errorf("read kernel stack trace, %v: %w", err, errMissing)
	}

	if err := binary.Read(bytes.NewBuffer(stackBytes), m.byteOrder, stack[stackDepth:]); err != nil {
		return fmt.Errorf("read kernel stack bytes, %s: %w", err, errUnrecoverable)
	}

	return nil
}

// readStackCount reads the value of the given key from the counts ebpf map.
func (m *bpfMaps) readStackCount(keyBytes []byte) (uint64, error) {
	valueBytes, err := m.stackCounts.GetValue(unsafe.Pointer(&keyBytes[0]))
	if err != nil {
		return 0, fmt.Errorf("get count value: %w", err)
	}
	return m.byteOrder.Uint64(valueBytes), nil
}

func (m *bpfMaps) clean() error {
	// BPF iterators need the previous value to iterate to the next, so we
	// can only delete the "previous" item once we've already iterated to
	// the next.

	it := m.stackTraces.Iterator()
	var prev []byte = nil
	for it.Next() {
		if prev != nil {
			err := m.stackTraces.DeleteKey(unsafe.Pointer(&prev[0]))
			if err != nil {
				return fmt.Errorf("failed to delete stack trace: %w", err)
			}
		}

		key := it.Key()
		prev = make([]byte, len(key))
		copy(prev, key)
	}
	if prev != nil {
		err := m.stackTraces.DeleteKey(unsafe.Pointer(&prev[0]))
		if err != nil {
			return fmt.Errorf("failed to delete stack trace: %w", err)
		}
	}

	it = m.stackCounts.Iterator()
	prev = nil
	for it.Next() {
		if prev != nil {
			err := m.stackCounts.DeleteKey(unsafe.Pointer(&prev[0]))
			if err != nil {
				return fmt.Errorf("failed to delete count: %w", err)
			}
		}

		key := it.Key()
		prev = make([]byte, len(key))
		copy(prev, key)
	}
	if prev != nil {
		err := m.stackCounts.DeleteKey(unsafe.Pointer(&prev[0]))
		if err != nil {
			return fmt.Errorf("failed to delete count: %w", err)
		}
	}

	return nil
}

func (m *bpfMaps) generateCompactUnwindTable(fullExecutablePath string, mapping *unwind.ExecutableMapping) (unwind.CompactUnwindTable, uint64, uint64, error) {
	var minCoveredPc uint64
	var maxCoveredPc uint64
	var ut unwind.CompactUnwindTable

	// 1. Get FDEs
	fdes, err := unwind.ReadFDEs(fullExecutablePath) // @nocommit: this should accept an ELF file perhaps.
	if err != nil {
		return ut, 0, 0, err
	}

	sort.Sort(fdes) // hope this help with efficiency, too
	minCoveredPc = fdes[0].Begin()
	maxCoveredPc = fdes[len(fdes)-1].End()

	// 2. Build unwind table
	// 3. Get the compact, BPF-friendly representation
	ut = unwind.BuildCompactUnwindTable(fdes)
	sort.Sort(ut) // 2.5 Sort @nocommit: perhaps sorting the BPF friendly one will be faster

	// now we have a full compact unwind table that we have to split in different BPF maps.
	fmt.Println("=> found", len(ut), "unwind entries for", mapping.Executable, "low pc", fmt.Sprintf("%x", minCoveredPc), "high pc", fmt.Sprintf("%x", maxCoveredPc)) // @nocommit: remove

	return ut, minCoveredPc, maxCoveredPc, nil
}

func (m *bpfMaps) writeUnwindTableRow(buffer *bytes.Buffer, row unwind.CompactUnwindTableRow) error {
	// .pc
	if err := binary.Write(buffer, m.byteOrder, row.Pc()); err != nil {
		return fmt.Errorf("write unwind table .pc bytes: %w", err)
	}

	// .__reserved_do_not_use
	if err := binary.Write(buffer, m.byteOrder, row.ReservedDoNotUse()); err != nil {
		return fmt.Errorf("write unwind table __reserved_do_not_use bytes: %w", err)
	}

	// .cfa_type
	if err := binary.Write(buffer, m.byteOrder, row.CfaType()); err != nil {
		return fmt.Errorf("write unwind table cfa_type bytes: %w", err)
	}

	// .rbp_type
	if err := binary.Write(buffer, m.byteOrder, row.RbpType()); err != nil {
		return fmt.Errorf("write unwind table rbp_type bytes: %w", err)
	}

	// .cfa_offset
	if err := binary.Write(buffer, m.byteOrder, row.CfaOffset()); err != nil {
		return fmt.Errorf("write unwind table cfa_offset bytes: %w", err)
	}

	// .rbp_offset
	if err := binary.Write(buffer, m.byteOrder, row.RbpOffset()); err != nil {
		return fmt.Errorf("write unwind table rbp_offset bytes: %w", err)
	}
	return nil
}

func (m *bpfMaps) writeMapping(procInfoBuf *bytes.Buffer, loadAddress uint64, startAddr uint64, endAddr uint64, executableId uint64, type_ uint64) error {
	// .load_address
	if err := binary.Write(procInfoBuf, m.byteOrder, loadAddress); err != nil {
		return fmt.Errorf("write mappings .load_address bytes: %w", err)
	}
	// .begin
	if err := binary.Write(procInfoBuf, m.byteOrder, startAddr); err != nil {
		return fmt.Errorf("write mappings .begin bytes: %w", err)
	}
	// .end
	if err := binary.Write(procInfoBuf, m.byteOrder, endAddr); err != nil {
		return fmt.Errorf("write mappings .end bytes: %w", err)
	}
	// .executable_id
	if err := binary.Write(procInfoBuf, m.byteOrder, executableId); err != nil {
		return fmt.Errorf("write proc info .executable_id bytes: %w", err)
	}
	// .type
	if err := binary.Write(procInfoBuf, m.byteOrder, type_); err != nil {
		return fmt.Errorf("write proc info .jitted bytes: %w", err)
	}

	return nil
}

func (m *bpfMaps) getMappingId(buildId string) (uint64, bool) {
	_, alreadySeenMapping := m.buildIdMapping[buildId]
	if alreadySeenMapping {
		fmt.Println("-> caching - seen this mapping before")
		m.referencedMappings += 1
	} else {
		fmt.Println("-> caching - new mapping")

		m.buildIdMapping[buildId] = m.executableId
	}

	return m.buildIdMapping[buildId], alreadySeenMapping
}

func (m *bpfMaps) PersistUnwindTable() error {

	// ==================== set unwind table =================
	// @nocommit: only update when needed.

	totalRows := m.unwindInfoBuf.Len() / 16
	fmt.Println("unwind rows", totalRows)
	shardIndex := uint64(m.shardIndex)
	var err error
	for i := 0; i < 100; i++ {
		err = m.unwindTables.Update(unsafe.Pointer(&shardIndex), unsafe.Pointer(&m.unwindInfoBuf.Bytes()[0]))
		if err == nil {
			fmt.Println("~~ worked:, rows:", totalRows, "try:", i)
			return nil
		} else {
			fmt.Println("~~ failed:", err, "rows:", totalRows, "try:", i)
			time.Sleep(100 * time.Millisecond)
		}
	}

	return fmt.Errorf("update unwind tables: %w", err)
}

// setUnwindTable updates the unwind tables with the given unwind table.
func (m *bpfMaps) setUnwindTable(pid int, mapping *unwind.ExecutableMapping, procInfoBuf *bytes.Buffer) error {
	fmt.Println("========================================================================================")
	fmt.Println("setUnwindTable called (total shards:", m.shardIndex, ", total entries:", m.totalEntries, ")")
	fmt.Println("========================================================================================")

	// Deal with mappings that are not filed backed.
	if mapping.IsNotFileBacked() {
		var type_ uint64
		if mapping.IsJitted() {
			fmt.Println("JIT section")
			type_ = 1
		}
		if mapping.IsSpecial() {
			fmt.Println("Special section")
			type_ = 2
		}

		err := m.writeMapping(procInfoBuf, mapping.LoadAddr, mapping.StartAddr, mapping.EndAddr, uint64(0), type_)
		if err != nil {
			panic(fmt.Errorf("writting mappings failed with %w", err))
		}
		return nil
	}

	// Deal with mappings that are backed by a file.
	fullExecutablePath := path.Join(fmt.Sprintf("/proc/%d/root", pid), mapping.Executable)

	elfFile, err := elf.Open(fullExecutablePath)
	if err != nil {
		if errors.Is(err, os.ErrNotExist) {
			return nil
		}
		return err
	}
	buildId, err := buildid.BuildID(&buildid.ElfFile{File: elfFile, Path: fullExecutablePath})
	if err != nil {
		return fmt.Errorf("BuildID failed %s: %w", fullExecutablePath, err)
	}

	// Memory mappings
	aslrElegible := executable.IsASLRElegibleElf(elfFile)

	adjustedLoadAddress := uint64(0)
	if mapping.MainObject() {
		fmt.Println("!!!!!!! main object", mapping)
		if aslrElegible {
			adjustedLoadAddress = mapping.LoadAddr
		}
	} else {
		adjustedLoadAddress = mapping.LoadAddr
	}

	fmt.Println("[info] adding memory mappings in for executable with ID", m.executableId, "buildId", buildId, "exec", mapping.Executable)

	// =================== MAPPINGS ===================

	foundExecutableId, mappingAlreadySeen := m.getMappingId(buildId)

	err = m.writeMapping(procInfoBuf, adjustedLoadAddress, mapping.StartAddr, mapping.EndAddr, uint64(foundExecutableId), uint64(0))
	if err != nil {
		panic(fmt.Errorf("writting mappings failed with %w", err))
	}

	// =================== UNWIND TABLE ===================
	// Range-partition the unwind table in the different shards.

	availableSpace := func() int {
		// tried this using the buffer's methods
		// but didn't succeed?
		return maxUnwindTableSize - m.highIndex
	}

	assertInvariants := func() {
		if m.lowIndex < 0 {
			panic("m.lowIndex < 0, this is not ok")
		}
		if m.highIndex > maxUnwindTableSize {
			panic("m.highIndex > 250k, this is not ok")
		}
	}

	if !mappingAlreadySeen {

		unwindShardsKeyBuf := new(bytes.Buffer)
		unwindShardsValBuf := new(bytes.Buffer)

		chunkIndex := 0

		// ==================================== generate unwind table

		ut, minCoveredPc, maxCoveredPc, err := m.generateCompactUnwindTable(fullExecutablePath, mapping)
		if err != nil {
			if err == unwind.ErrNoFDEsFound {
				// is it ok to return here?
				return nil
			}
			if err == unwind.ErrEhFrameSectionNotFound {
				// is it ok to return here?
				return nil
			}
			return nil
		}

		threshold := min(len(ut), availableSpace())
		currentChunk := ut[:threshold]
		restChunks := ut[threshold:]

		numShards := 1 + len(restChunks)/maxUnwindTableSize // @nocommit: verify this

		// .len
		if err := binary.Write(unwindShardsValBuf, m.byteOrder, uint64(numShards)); err != nil {
			return fmt.Errorf("write shards .len bytes: %w", err)
		}

		for {
			assertInvariants()

			fmt.Println("- current chunk size", len(currentChunk))
			fmt.Println("- rest of chunk size", len(restChunks))

			m.totalEntries += uint64(len(currentChunk))

			if len(currentChunk) == 0 {
				fmt.Println("!! done with the last chunk")
				break
			}

			if chunkIndex > 10 {
				panic("had to split too many times")
			}

			m.highIndex += len(currentChunk)
			fmt.Println("- lowindex [", m.lowIndex, ":", m.highIndex, "] highIndex")

			// ======================== shard info ===============================
			// Set (executable ID) -> unwind table shards info
			// basically have the info

			fmt.Println("- executable", m.executableId, "mapping", mapping.Executable, "shard", chunkIndex)
			if err := binary.Write(unwindShardsKeyBuf, m.byteOrder, uint64(m.executableId)); err != nil {
				return fmt.Errorf("write shards key bytes: %w", err)
			}

			// note this might not be correct if using the unwind table info for the first or last items
			minPc := currentChunk[0].Pc()
			if chunkIndex == 0 {
				minPc = uint64(minCoveredPc)
			}
			// .low_pc
			if err := binary.Write(unwindShardsValBuf, m.byteOrder, minPc); err != nil {
				return fmt.Errorf("write shards .low_pc bytes: %w", err)
			}

			// note this might not be correct if using the unwind table info for the first or last items
			maxPc := currentChunk[len(currentChunk)-1].Pc()
			if chunkIndex == numShards {
				maxPc = uint64(maxCoveredPc)
			}
			// .high_pc
			if err := binary.Write(unwindShardsValBuf, m.byteOrder, maxPc); err != nil {
				return fmt.Errorf("write shards .high_pc bytes: %w", err)
			}

			// .shard_index
			if err := binary.Write(unwindShardsValBuf, m.byteOrder, uint64(m.shardIndex)); err != nil {
				return fmt.Errorf("write shards .shard_index bytes: %w", err)
			}

			// .low_index
			if err := binary.Write(unwindShardsValBuf, m.byteOrder, uint64(m.lowIndex)); err != nil {
				return fmt.Errorf("write shards .low_index bytes: %w", err)
			}
			// .high_index
			if err := binary.Write(unwindShardsValBuf, m.byteOrder, uint64(m.highIndex)); err != nil {
				return fmt.Errorf("write shards .high_index bytes: %w", err)
			}

			m.lowIndex = m.highIndex // @nocommit this is wrong???

			// ====================== Write unwind table =====================
			for _, row := range currentChunk {
				if err := m.writeUnwindTableRow(m.unwindInfoBuf, row); err != nil {
					panic(fmt.Errorf("writting a row: %w", err))
				}
			}

			// Need a new shard?
			if availableSpace() == 0 {
				fmt.Println("run out of space in the 'live' shard, creating a new one")
				err := m.PersistUnwindTable()
				if err != nil {
					panic(err)
				}
				m.shardIndex++
				m.unwindInfoBuf.Reset() // @nocommit is it stored??
				m.lowIndex = 0
				m.highIndex = 0

				if m.shardIndex == unwindTableShardCount {
					fmt.Println(m.buildIdMapping)
					fmt.Println("Not enough shards - this is not implemented but we should deal with this")
				}
			}

			// Recalculate for next iteration
			threshold := min(len(restChunks), availableSpace())
			currentChunk = restChunks[:threshold]
			restChunks = restChunks[threshold:]

			chunkIndex++
		}

		if err := m.unwindShards.Update(
			unsafe.Pointer(&unwindShardsKeyBuf.Bytes()[0]),
			unsafe.Pointer(&unwindShardsValBuf.Bytes()[0])); err != nil {
			return fmt.Errorf("update unwind tables: %w", err)
		}

		m.executableId++
		m.uniqueMappings++
	}

	assertInvariants()

	// @nocommit NO SPACE LEFT
	if availableSpace() == 0 {
		panic("no space left, this should never happen")
	}

	// @nocommit TODO: check if we are full and flush if that's the case
	return nil
}
