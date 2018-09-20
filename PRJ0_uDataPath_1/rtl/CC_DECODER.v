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
module CC_DECODER #(parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_DECODER_OUT=38)(
	//////////// OUTPUTS //////////
	CC_DECODER_DataDecoder_Out,
	//////////// INPUTS //////////
	CC_DECODER_Selection_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output reg	[DATAWIDTH_DECODER_OUT-1:0] CC_DECODER_DataDecoder_Out;
	input			[DATAWIDTH_DECODER_SELECTION-1:0] CC_DECODER_Selection_In;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(*)
	begin
	case (CC_DECODER_Selection_In)	
		6'b000000: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000000000001;
		6'b000001: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000000000010;
		6'b000010: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000000000100;
		6'b000011: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000000001000;
		6'b000100: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000000010000;
		6'b000101: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000000100000;
		6'b000110: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000001000000;
		6'b000111: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000010000000;
		6'b001000: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000100000000;
		6'b001001: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000001000000000;
		6'b001010: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000010000000000;
		6'b001011: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000100000000000;
		6'b001100: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000001000000000000;
		6'b001101: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000010000000000000;
		6'b001110: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000100000000000000;
		6'b001111: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000001000000000000000;
		6'b010000: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000010000000000000000;
		6'b010001: CC_DECODER_DataDecoder_Out = 38'b00000000000000000000100000000000000000;
		6'b010010: CC_DECODER_DataDecoder_Out = 38'b00000000000000000001000000000000000000;
		6'b010011: CC_DECODER_DataDecoder_Out = 38'b00000000000000000010000000000000000000;
		6'b010100: CC_DECODER_DataDecoder_Out = 38'b00000000000000000100000000000000000000;
		6'b010101: CC_DECODER_DataDecoder_Out = 38'b00000000000000001000000000000000000000;
		6'b010110: CC_DECODER_DataDecoder_Out = 38'b00000000000000010000000000000000000000;
		6'b010111: CC_DECODER_DataDecoder_Out = 38'b00000000000000100000000000000000000000;
		6'b011000: CC_DECODER_DataDecoder_Out = 38'b00000000000001000000000000000000000000;
		6'b011001: CC_DECODER_DataDecoder_Out = 38'b00000000000010000000000000000000000000;
		6'b011010: CC_DECODER_DataDecoder_Out = 38'b00000000000100000000000000000000000000;
		6'b011011: CC_DECODER_DataDecoder_Out = 38'b00000000001000000000000000000000000000;
		6'b011100: CC_DECODER_DataDecoder_Out = 38'b00000000010000000000000000000000000000;
		6'b011101: CC_DECODER_DataDecoder_Out = 38'b00000000100000000000000000000000000000;
		6'b011110: CC_DECODER_DataDecoder_Out = 38'b00000001000000000000000000000000000000;
		6'b011111: CC_DECODER_DataDecoder_Out = 38'b00000010000000000000000000000000000000;
		6'b100000: CC_DECODER_DataDecoder_Out = 38'b00000100000000000000000000000000000000;
		6'b100001: CC_DECODER_DataDecoder_Out = 38'b00001000000000000000000000000000000000;
		6'b100010: CC_DECODER_DataDecoder_Out = 38'b00010000000000000000000000000000000000;
		6'b100011: CC_DECODER_DataDecoder_Out = 38'b00100000000000000000000000000000000000;
		6'b100100: CC_DECODER_DataDecoder_Out = 38'b01000000000000000000000000000000000000;
		6'b100101: CC_DECODER_DataDecoder_Out = 38'b10000000000000000000000000000000000000;
		default : CC_DECODER_DataDecoder_Out = 38'b00000000000000000000000000000000000000;
		endcase
	end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule