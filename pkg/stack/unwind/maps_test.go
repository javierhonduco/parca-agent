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
	"testing"

	"github.com/prometheus/procfs"
	"github.com/stretchr/testify/require"
)

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

func TestEmptyMappingsWorks(t *testing.T) {
	rawMaps := []*procfs.ProcMap{}
	result := ExecutableMappings(rawMaps)
	require.Equal(t, []*ExecutableMapping{}, result)
}

func TestMappingsWorks(t *testing.T) {
	rawMaps := []*procfs.ProcMap{{StartAddr: 0x0, EndAddr: 0x100, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: "./my_executable"}}
	result := ExecutableMappings(rawMaps)
	require.Equal(t, []*ExecutableMapping{
		{StartAddr: 0x0, EndAddr: 0x100, Executable: "./my_executable"},
	}, result)
	require.False(t, result[0].IsSpecial())
}

func TestMappingsWithSplitSectionsWorks(t *testing.T) {
	rawMaps := []*procfs.ProcMap{
		{StartAddr: 0x0, EndAddr: 0x100, Perms: &procfs.ProcMapPermissions{Read: true}, Pathname: "./my_executable"},
		{StartAddr: 0x100, EndAddr: 0x200, Perms: &procfs.ProcMapPermissions{Write: true}, Pathname: "./my_executable"},
		{StartAddr: 0x200, EndAddr: 0x300, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: "./my_executable"},
		{StartAddr: 0x300, EndAddr: 0x400, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: "libc"},
	}
	result := ExecutableMappings(rawMaps)
	require.Equal(t, &ExecutableMapping{LoadAddr: 0x0, StartAddr: 0x200, EndAddr: 0x300, Executable: "./my_executable"}, result[0])
}

func TestMappingsWithJittedSectionsWorks(t *testing.T) {
	rawMaps := []*procfs.ProcMap{
		{StartAddr: 0x0, EndAddr: 0x100, Perms: &procfs.ProcMapPermissions{Read: true}, Pathname: "./my_executable"},
		{StartAddr: 0x100, EndAddr: 0x200, Perms: &procfs.ProcMapPermissions{Write: true}, Pathname: "./my_executable"},
		{StartAddr: 0x200, EndAddr: 0x300, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: ""},
	}
	result := ExecutableMappings(rawMaps)
	require.Equal(t, &ExecutableMapping{LoadAddr: 0x0, StartAddr: 0x200, EndAddr: 0x300, Executable: ""}, result[0])
}

func TestMappingsJitDetectionWorks(t *testing.T) {
	rawMaps := []*procfs.ProcMap{
		{StartAddr: 0x0, EndAddr: 0x100, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: "./my_executable"},
		{StartAddr: 0x100, EndAddr: 0x200, Perms: &procfs.ProcMapPermissions{Execute: true}},
	}
	result := ExecutableMappings(rawMaps)
	require.Equal(t, 2, len(result))
	require.False(t, result[0].IsJitted())
	require.True(t, result[1].IsJitted())
}

func TestMappingsSpecialSectionDetectionWorks(t *testing.T) {
	rawMaps := []*procfs.ProcMap{
		{StartAddr: 0x0, EndAddr: 0x100, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: "[vdso]"},
	}
	result := ExecutableMappings(rawMaps)
	require.Equal(t, 1, len(result))
	require.True(t, result[0].IsSpecial())
}

func TestExecutableMappingCountWorks(t *testing.T) {
	rawMaps := []*procfs.ProcMap{}
	require.Equal(t, uint(0), executableMappingCount(rawMaps))

	rawMaps = []*procfs.ProcMap{
		{StartAddr: 0x0, EndAddr: 0x100, Perms: &procfs.ProcMapPermissions{Read: true}, Pathname: "./my_executable"},
		{StartAddr: 0x100, EndAddr: 0x200, Perms: &procfs.ProcMapPermissions{Write: true}, Pathname: "./my_executable"},
		{StartAddr: 0x200, EndAddr: 0x300, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: "./my_executable"},
		{StartAddr: 0x300, EndAddr: 0x400, Perms: &procfs.ProcMapPermissions{Execute: true}, Pathname: "libc"},
	}

	require.Equal(t, uint(2), executableMappingCount(rawMaps))
}

/*
func TestAllProcesses(t *testing.T) {
	procs, err := procfs.AllProcs()
	require.NoError(t, err)

	for _, proc := range procs {
		mappings, err := proc.ProcMaps()
		require.NoError(t, err)
		_ = ExecutableMappings(mappings)
	}

}
*/
