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
	"encoding/binary"
	"errors"
	"fmt"
	"path"
	"unsafe"

	"github.com/parca-dev/parca-agent/pkg/executable"
	"github.com/parca-dev/parca-agent/pkg/stack/unwind"

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
	unwindTableShardCount = 6          // Always needs to be sync with MAX_SHARDS in the BPF program.
	maxUnwindSize         = maxUnwindTableSize * unwindTableShardCount
)

var (
	executableId = 100
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
	unwindInfoBuf *bytes.Buffer
	// Account where we are within a shard
	lowIndex  int
	highIndex int
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
	for i, addr := range dwarfStack.Addrs {
		if i >= stackDepth || i >= int(dwarfStack.Len) || addr == 0 {
			break
		}
		userStack[i] = addr
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

// setUnwindTable updates the unwind tables with the given unwind table.
func (m *bpfMaps) setUnwindTable(pid int, ut unwind.CompactUnwindTable, mapping *unwind.ExecutableMapping, procInfoBuf *bytes.Buffer, lowUnwindPc uint64, highUnwindPc uint64) error {
	/* 	if len(ut) >= maxUnwindSize {
		return fmt.Errorf("maximum unwind table size reached. Table size %d, but max size is %d", len(ut), maxUnwindSize)
	} */

	fmt.Println("=> setUnwindTable called")

	////////////////

	// Memory mappings
	fullExecutablePath := path.Join(fmt.Sprintf("/proc/%d/root", pid), mapping.Executable)
	aslrElegible, err := executable.IsASLRElegible(fullExecutablePath)
	if err != nil {
		return fmt.Errorf("ASLR check failed with with: %w", err)
	}
	adjustedLoadAddress := uint64(0)
	if mapping.MainObject() {
		fmt.Println("!!!!!!! main object", mapping)
		if aslrElegible {
			adjustedLoadAddress = mapping.LoadAddr
		}
	} else {
		adjustedLoadAddress = mapping.LoadAddr
	}

	fmt.Println("=> adding memory mappings in table", executableId)

	// =================== MAPPINGS ===================
	// .load_address
	if err := binary.Write(procInfoBuf, m.byteOrder, adjustedLoadAddress); err != nil {
		return fmt.Errorf("write RBP offset bytes: %w", err)
	}
	// .begin
	if err := binary.Write(procInfoBuf, m.byteOrder, mapping.StartAddr); err != nil {
		return fmt.Errorf("write RBP offset bytes: %w", err)
	}
	// .end
	if err := binary.Write(procInfoBuf, m.byteOrder, mapping.EndAddr); err != nil {
		return fmt.Errorf("write RBP offset bytes: %w", err)
	}
	// .executable_id @nocommit: add caching here, right now treating them all as new
	if err := binary.Write(procInfoBuf, m.byteOrder, uint64(executableId)); err != nil {
		return fmt.Errorf("write RBP offset bytes: %w", err)
	}

	// =================== UNWIND TABLE ===================
	// Range-partition the unwind table in the different shards.

	availableSpace := m.unwindInfoBuf.Cap() - m.unwindInfoBuf.Len()

	if len(ut) <= availableSpace {
		// ========================= it fits =======================

		m.highIndex += len(ut)
		fmt.Println("======================= left", m.lowIndex, "right", m.highIndex)

		// ====================== Write unwind table =====================
		for _, row := range ut {
			if err := binary.Write(m.unwindInfoBuf, m.byteOrder, row); err != nil {
				panic(fmt.Errorf("write row: %w", err))
			}
		}

		// ======================== shard info ===============================
		// Set (executable ID) -> unwind table shards info
		keyBuf := new(bytes.Buffer)
		valBuf := new(bytes.Buffer)

		fmt.Println("============= executable", executableId, "mapping", mapping.Executable)
		if err := binary.Write(keyBuf, m.byteOrder, uint64(executableId)); err != nil {
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}

		// .len
		if err := binary.Write(valBuf, m.byteOrder, uint64(1)); err != nil {
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}

		// .low_pc
		if err := binary.Write(valBuf, m.byteOrder, uint64(lowUnwindPc)); err != nil { // note this might not be correct if using the unwind table info for the first or last items
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}

		// .high_pc
		if err := binary.Write(valBuf, m.byteOrder, uint64(highUnwindPc)); err != nil { // note this might not be correct if using the unwind table info for the first or last items
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}

		// .first_shard
		if err := binary.Write(valBuf, m.byteOrder, uint64(m.shardIndex)); err != nil {
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}

		// .last_shard
		if err := binary.Write(valBuf, m.byteOrder, uint64(m.shardIndex)); err != nil {
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}

		// .low_index
		if err := binary.Write(valBuf, m.byteOrder, uint64(m.lowIndex)); err != nil {
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}
		// .high_index
		if err := binary.Write(valBuf, m.byteOrder, uint64(m.highIndex)); err != nil {
			return fmt.Errorf("write RBP offset bytes: %w", err)
		}

		if err := m.unwindShards.Update(unsafe.Pointer(&keyBuf.Bytes()[0]), unsafe.Pointer(&valBuf.Bytes()[0])); err != nil {
			return fmt.Errorf("update unwind tables: %w", err)
		}

		m.lowIndex = m.highIndex
		executableId++

		// ==================== set unwind table =================
		leShardIndex := uint64(m.shardIndex)
		if err := m.unwindTables.Update(unsafe.Pointer(&leShardIndex), unsafe.Pointer(&m.unwindInfoBuf.Bytes()[0])); err != nil {
			return fmt.Errorf("update unwind tables: %w", err)
		}

		{

			availableSpace := m.unwindInfoBuf.Cap() - m.unwindInfoBuf.Len()
			if availableSpace == 0 {
				panic("run out of space in the 'live' shard, not handlign this")
			}
		}
	} else {
		// ========================= it doesn't fit, we need to chunk the unwind table ===========================
		fmt.Println("len(ut) <= availableSpace", len(ut), availableSpace)
		currentChunk := ut[:availableSpace]
		restChunks := ut[availableSpace:]
		fmt.Println("current chunk", len(currentChunk))
		fmt.Println("rest of chunks", len(restChunks))

		panic("not implemented yet")

	}
	// TODO: check if we are full and flush if that's the case

	return nil
}
