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
module CC_MUXX #(parameter DATAWIDTH_MUX_SELECTION=6, parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	CC_MUX_DataBUS_Out,
	//////////// INPUTS //////////
	CC_MUX_DataBUS_In_0,
	CC_MUX_DataBUS_In_1,
	CC_MUX_DataBUS_In_2,	
	CC_MUX_DataBUS_In_3,	
	CC_MUX_DataBUS_In_4,	
	CC_MUX_DataBUS_In_5,	
	CC_MUX_DataBUS_In_6,	
	CC_MUX_DataBUS_In_7,	
	CC_MUX_DataBUS_In_8,	
	CC_MUX_DataBUS_In_9,	
	CC_MUX_DataBUS_In_10,
	CC_MUX_DataBUS_In_11,
	CC_MUX_DataBUS_In_12,	
	CC_MUX_DataBUS_In_13,	
	CC_MUX_DataBUS_In_14,	
	CC_MUX_DataBUS_In_15,	
	CC_MUX_DataBUS_In_16,	
	CC_MUX_DataBUS_In_17,	
	CC_MUX_DataBUS_In_18,	
	CC_MUX_DataBUS_In_19,	
	CC_MUX_DataBUS_In_20,
	CC_MUX_DataBUS_In_21,
	CC_MUX_DataBUS_In_22,	
	CC_MUX_DataBUS_In_23,	
	CC_MUX_DataBUS_In_24,	
	CC_MUX_DataBUS_In_25,	
	CC_MUX_DataBUS_In_26,	
	CC_MUX_DataBUS_In_27,	
	CC_MUX_DataBUS_In_28,	
	CC_MUX_DataBUS_In_29,	
	CC_MUX_DataBUS_In_30,
	CC_MUX_DataBUS_In_31,
	CC_MUX_DataBUS_In_32,	
	CC_MUX_DataBUS_In_33,	
	CC_MUX_DataBUS_In_34,	
	CC_MUX_DataBUS_In_35,	
	CC_MUX_DataBUS_In_36,	
	CC_MUX_DataBUS_In_37,	
	CC_MUX_Selection_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output reg	[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_Out;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_0;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_1;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_2;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_3;	
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_4;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_5;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_6;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_7;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_8;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_9;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_10;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_11;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_12;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_13;	
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_14;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_15;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_16;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_17;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_18;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_19;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_20;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_21;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_22;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_23;	
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_24;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_25;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_26;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_27;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_28;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_29;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_30;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_31;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_32;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_33;	
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_34;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_35;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_36;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_37;
	input			[DATAWIDTH_MUX_SELECTION-1:0] CC_MUX_Selection_In;	
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(*)
	begin
	case (CC_MUX_Selection_In)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		6'b000000: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_0;
		6'b000001: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_1;
		6'b000010: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_2;
		6'b000011: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_3;
		6'b000100: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_4;
		6'b000101: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_5;
		6'b000110: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_6;
		6'b000111: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_7;
		6'b001000: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_8;
		6'b001001: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_9;
		6'b001010: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_10;
		6'b001011: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_11;
		6'b001100: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_12;
		6'b001101: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_13;
		6'b001110: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_14;
		6'b001111: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_15;
		6'b010000: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_16;
		6'b010001: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_17;
		6'b010010: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_18;
		6'b010011: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_19;
		6'b010100: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_20;
		6'b010101: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_21;
		6'b010110: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_22;
		6'b010111: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_23;
		6'b011000: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_24;
		6'b011001: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_25;
		6'b011010: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_26;
		6'b011011: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_27;
		6'b011100: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_28;
		6'b011101: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_29;
		6'b011110: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_30;
		6'b011111: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_31;
		6'b100000: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_32;
		6'b100001: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_33;
		6'b100010: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_34;
		6'b100011: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_35;
		6'b100100: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_36;
		6'b100101: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_37;
		default :   CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_0; // channel 0 is selected 
		endcase
	end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule

