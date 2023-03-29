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
package cpu

import (
	"testing"
	"unsafe"

	"github.com/stretchr/testify/require"
)

func TestBpfBindings(t *testing.T) {
	require.Equal(t, int(unsafe.Sizeof(stack_trace_t{})), 1024)
	require.Equal(t, int(unsafe.Sizeof(stack_count_key_t{})), 20)
	//require.Equal(t, int(unsafe.Sizeof(stack_unwind_row_t{})), 14) // Incorrect codegen for packed structs.
	require.Equal(t, int(unsafe.Sizeof(mapping_t{})), 40)
	require.Equal(t, int(unsafe.Sizeof(process_info_t{})), 10016)      // Double check this one.
	require.Equal(t, int(unsafe.Sizeof(unwind_info_chunks_t{})), 1200) // Double check this one.
	require.Equal(t, int(unsafe.Sizeof(chunk_info_t{})), 40)           // Double check this one.
}
