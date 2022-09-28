// Copyright 2021 The Parca Authors
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

package unwind

import (
	"testing"

	"github.com/go-kit/log"
	"github.com/stretchr/testify/require"

	"github.com/parca-dev/parca-agent/pkg/process"
)

func TestBuildUnwindTable(t *testing.T) {
	logger := log.NewNopLogger()
	ptb := NewUnwindTableBuilder(logger, process.NewMappingFileCache(logger))

	fdes, err := ptb.readFDEs("testdata/pie-dynamic", 0)
	require.NoError(t, err)

	UnwindTable := buildTable(fdes, 0)
	require.Equal(t, 313127, len(UnwindTable))
	require.Equal(t, uint64(0xfb6960), UnwindTable[0].Loc)
	require.Equal(t, Instruction{Op: OpCFAOffset, Offset: -8}, UnwindTable[0].RA)
	require.Equal(t, Instruction{Op: 3, Reg: 0x7, Offset: 8}, UnwindTable[0].CFA)
}

var rawExpressionResult []byte
var rbpOffsetResult int64
var insResult Instruction

func BenchmarkParsingLibcDwarfUnwindInformation(b *testing.B) {
	b.ReportAllocs()

	logger := log.NewNopLogger()
	ptb := NewUnwindTableBuilder(logger, process.NewMappingFileCache(logger))

	var rawExpression []byte
	var rbpOffset int64
	var ins Instruction

	for n := 0; n < b.N; n++ {
		fdes, err := ptb.readFDEs("../../../testdata/libc.so.6", 0)
		if err != nil {
			panic("could not read FDEs")
		}

		for _, fde := range fdes {
			tableRows := buildTableRows(fde, 0)
			for _, tableRow := range tableRows {
				switch tableRow.CFA.(type) {
				case Instruction:
					ins = tableRow.CFA.(Instruction)
				case []byte:
					rawExpression = tableRow.CFA.([]byte)
				}

				if tableRow.RBP.Op == OpUnimplemented || tableRow.RBP.Offset == 0 {
					// u
					rbpOffset = 0
				} else {
					rbpOffset = tableRow.RBP.Offset
				}
			}
		}
	}
	// Make sure that the compiler can't optimise out the benchmark.
	rawExpressionResult = rawExpression
	rbpOffsetResult = rbpOffset
	insResult = ins
}

func BenchmarkParsingLibPythonDwarfUnwindInformation(b *testing.B) {
	b.ReportAllocs()

	logger := log.NewNopLogger()
	ptb := NewUnwindTableBuilder(logger, process.NewMappingFileCache(logger))

	var rawExpression []byte
	var rbpOffset int64
	var ins Instruction

	for n := 0; n < b.N; n++ {
		fdes, err := ptb.readFDEs("../../../testdata/libpython3.10.so.1.0", 0)
		if err != nil {
			panic("could not read FDEs")
		}

		for _, fde := range fdes {
			tableRows := buildTableRows(fde, 0)
			for _, tableRow := range tableRows {
				switch tableRow.CFA.(type) {
				case Instruction:
					ins = tableRow.CFA.(Instruction)
				case []byte:
					rawExpression = tableRow.CFA.([]byte)
				}

				if tableRow.RBP.Op == OpUnimplemented || tableRow.RBP.Offset == 0 {
					// u
					rbpOffset = 0
				} else {
					rbpOffset = tableRow.RBP.Offset
				}
			}
		}
	}
	// Make sure that the compiler can't optimise out the benchmark.
	rawExpressionResult = rawExpression
	rbpOffsetResult = rbpOffset
	insResult = ins
}
