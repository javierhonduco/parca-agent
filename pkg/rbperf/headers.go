// Copyright 2023 The Parca Authors
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

// nolint: stylecheck, unused, misspell
package rbperf

const (
	STACK_COMPLETE   = 0
	STACK_INCOMPLETE = 1
)

const (
	RBPERF_EVENT_UNKNOWN         = 0
	RBPERF_EVENT_ON_CPU_SAMPLING = 1
	RBPERF_EVENT_SYSCALL         = 2
)

type (
	s8  = int8
	u8  = uint8
	s16 = int16
	u16 = uint16
	s32 = int32
	u32 = uint32
	s64 = int64
	u64 = uint64
)

type RubyFrame struct {
	Lineno      u32
	Method_name [50]uint8
	Path        [150]uint8
}

type ProcessData struct {
	Rb_frame_addr u64
	Rb_version    u32
	Padding_      [4]byte
	Start_time    u64
}

type RubyVersionOffsets struct {
	Major_version          int32
	Minor_version          int32
	Patch_version          int32
	Vm_offset              int32
	Vm_size_offset         int32
	Control_frame_t_sizeof int32
	Cfp_offset             int32
	Label_offset           int32
	Path_flavour           int32
	Line_info_size_offset  int32
	Line_info_table_offset int32
	Lineno_offset          int32
	Main_thread_offset     int32
	Ec_offset              int32
}
