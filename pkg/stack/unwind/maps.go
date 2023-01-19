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

package unwind

import (
	"fmt"

	"github.com/prometheus/procfs"
)

type ExecutableMapping struct {
	LoadAddr   uint64
	StartAddr  uint64
	EndAddr    uint64
	Executable string
	mainExec   bool
}

// MainObject returns whether this executable is the "main object".
// which triggered the loading of all the other mappings.
//
// We care about this because if Linux ASLR is enabled, we have to
// modify the loaded addresses for the main object.
func (pm *ExecutableMapping) MainObject() bool {
	return pm.mainExec
}

// IsJitted returns whether an executable mapping is JITed or not.
// The detection is done by checking if the executable mapping is
// not backed by a file.
//
// We don't check for the writeable flag as `mprotect(2)` may be
// called to make it r+w only.
func (pm *ExecutableMapping) IsJitted() bool {
	return pm.Executable == ""
}

func (pm *ExecutableMapping) IsNotFileBacked() bool {
	return pm.IsJitted() || pm.IsSpecial()
}

// IsSpecial returns whether the file mapping is a "special" region,
// such as the mappings for vDSOs `[vdso]` and others.
func (pm *ExecutableMapping) IsSpecial() bool {
	return len(pm.Executable) > 0 && pm.Executable[0] == '['
}

func (pm *ExecutableMapping) String() string {
	return fmt.Sprintf("ExecutableMapping {LoadAddr: 0x%x, StartAddr: 0x%x, EndAddr: 0x%x, Executable:%s}", pm.LoadAddr, pm.StartAddr, pm.EndAddr, pm.Executable)
}

type ExecutableMappingsList []*ExecutableMapping

func (pm ExecutableMappingsList) HasJitted() bool {
	for _, execMapping := range pm {
		if execMapping.IsJitted() {
			return true
		}
	}
	return false
}

// executableMappingCount returns the number of executable mappings
// in the passed `rawMappings`.
func executableMappingCount(rawMappings []*procfs.ProcMap) uint {
	var executableMappingCount uint
	for _, rawMapping := range rawMappings {
		if rawMapping.Perms.Execute {
			executableMappingCount += 1
		}
	}
	return executableMappingCount
}

// ExecutableMappings returns the executable memory mappings with the appropriate
// loaded base address set for non-JIT code.
//
// The reason why we need to find the loaded base address is that ELF executables
// aren't typically loaded in one large executable section, but split in several
// mappings. For example, the .rodata section, as well as .eh_frame might go in
// sections without executable permissions, as they aren't needed.
func ExecutableMappings(rawMappings []*procfs.ProcMap) ExecutableMappingsList {
	result := make([]*ExecutableMapping, 0, executableMappingCount(rawMappings))
	firstSeen := false
	for idx, rawMapping := range rawMappings {
		if rawMapping.Perms.Execute {
			var LoadAddr uint64
			// We need the load base address for stack unwinding with DWARF
			// information. We don't know of any runtimes that emit said unwind
			// information for JITed code, so we set it to zero.
			if rawMappings[idx].Pathname != "" {
				for revIdx := idx; revIdx >= 0; revIdx-- {
					if rawMappings[revIdx].Pathname != rawMappings[idx].Pathname {
						break
					}
					LoadAddr = uint64(rawMappings[revIdx].StartAddr)
				}
			}

			result = append(result, &ExecutableMapping{
				LoadAddr:   LoadAddr,
				StartAddr:  uint64(rawMapping.StartAddr),
				EndAddr:    uint64(rawMapping.EndAddr),
				Executable: rawMapping.Pathname,
				mainExec:   !firstSeen,
			})

			firstSeen = true
		}
	}

	return result
}
