//##########################################################################
//######					G0B1T HDL EXAMPLES											####
//######	Fredy Enrique Segura-Quijano fsegura@uniandes.edu.co				####   
//######																						####   
//######				MODIFICADO: Marzo de 2018 - FES								####   
//##########################################################################
//# G0B1T
//# Copyright (C) 2018 Bogotá, Colombia
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>.
//#/
//###########################################################################

//=======================================================
//  MODULE Definition
//=======================================================
module CC_MUX #(parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_IR_SELECTION=5)(
	//////////// OUTPUTS //////////
	CC_MUX_TO_DECODER_OUT,
	//////////// INPUTS //////////
	CC_MUX_MIR_FIELD,
	CC_MUX_IR_FIELD,
	CC_MUX_SELECT
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output	[DATAWIDTH_DECODER_SELECTION-1:0] CC_MUX_TO_DECODER_OUT;
	input			[DATAWIDTH_DECODER_SELECTION-1:0] CC_MUX_MIR_FIELD;
	input			[DATAWIDTH_IR_SELECTION-1:0] CC_MUX_IR_FIELD;
	input			CC_MUX_SELECT;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL

//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
assign CC_MUX_TO_DECODER_OUT = (CC_MUX_SELECT)? {0,CC_MUX_IR_FIELD} : CC_MUX_MIR_FIELD;
endmodule

