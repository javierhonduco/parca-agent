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

	"github.com/parca-dev/parca-agent/internal/dwarf/frame"
)

type DwarfExpressionId int16

// Dwarf expressions that we recognise and harcode in the agent.
const (
	ExpressionUnknown DwarfExpressionId = iota
	ExpressionPlt1
	ExpressionPlt2
)

// sp + 8 + ((((ip & 15) >= 11)? 1 : 0) << 3
var Plt1 = [...]byte{
	frame.DW_OP_breg7,
	frame.DW_OP_const1u,
	frame.DW_OP_breg16,
	frame.DW_OP_lit15,
	frame.DW_OP_and,
	frame.DW_OP_lit11,
	frame.DW_OP_ge,
	frame.DW_OP_lit3,
	frame.DW_OP_shl,
	frame.DW_OP_plus,
}

// sp + 8 + ((((ip & 15) >= 10)? 1 : 0) << 3
var Plt2 = [...]byte{
	frame.DW_OP_breg7,
	frame.DW_OP_const1u,
	frame.DW_OP_breg16,
	frame.DW_OP_lit15,
	frame.DW_OP_and,
	frame.DW_OP_lit10,
	frame.DW_OP_ge,
	frame.DW_OP_lit3,
	frame.DW_OP_shl,
	frame.DW_OP_plus,
}

func equalBytes(a []byte, b []byte) bool {
	if len(a) != len(b) {
		return false
	}
	for i := range a {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

func ExpressionIdentifier(expression []byte) (DwarfExpressionId, error) {

	cleanedExpression := make([]byte, 0, len(expression))
	for _, opcode := range expression {
		if opcode == 0x0 {
			continue
		}
		cleanedExpression = append(cleanedExpression, opcode)
	}

	if equalBytes(Plt1[:], cleanedExpression) {
		return ExpressionPlt1, nil
	}

	if equalBytes(Plt2[:], cleanedExpression) {
		return ExpressionPlt2, nil
	}

	return ExpressionUnknown, fmt.Errorf("dwarf expression not recognised")
}
