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
module WB_SYSTEM #(parameter MIR_BUS_WIDTH = 41, parameter Direction_BUS_WIDTH = 11, parameter Decode_BUS_WIDTH = 8, parameter Selection_BUS_WIDTH = 2, parameter REG_BUS_WIDTH = 6, parameter COND_BUS_WIDTH = 3, parameter FLAGs_BUS_WIDTH = 4, parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATA_REGFIXED_INIT_0=32'h00000000, parameter DATA_REGGEN_INIT_0=32'h00000000,parameter DATA_REGPC_INIT=32'h00000800, parameter DATAWIDTH_DECODER_OUT=38, parameter DATAWIDTH_MUX_SELECTION=6)(
//////////// OUTPUTS //////////
	WB_SYSTEM_DataBUSDisplay_Out,
//////////// INPUTS //////////
	WB_SYSTEM_CLOCK_50,
	WB_SYSTEM_Reset_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output	[DATAWIDTH_BUS-1:0] WB_SYSTEM_DataBUSDisplay_Out;
	input 	WB_SYSTEM_CLOCK_50;
	input 	WB_SYSTEM_Reset_InHigh;

//=======================================================
//  REG/WIRE declarations
//=======================================================
// SHIFT_REGISTER CONTROL
	wire RegSHIFTER_LoadCONTROL_Wire;
// DECODER CONTROL:  TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
	wire [DATAWIDTH_DECODER_SELECTION-1:0] Decoder_SelectionCONTROL_Wire; 

// MUX CONTROL: TO SELECT OUTPUT REGISTER TO BUS_A, BUS_B OR BOTH OF THEM
	wire [DATAWIDTH_MUX_SELECTION-1:0] MUX_SelectionBUSACONTROL_Wire;
	wire [DATAWIDTH_MUX_SELECTION-1:0] MUX_SelectionBUSBCONTROL_Wire;

//ALU CONTROL
	wire [DATAWIDTH_ALU_SELECTION-1:0] ALU_SelectionCONTROL_Wire;
	wire PSR_OverflowCONTROL_Wire;
	wire PSR_CarryCONTROL_Wire;
	wire PSR_NegativeCONTROL_Wire;
	wire PSR_ZeroCONTROL_Wire;
	
	wire RegIR_OP_Wire;
	wire RegIR_RD_Wire;
	wire RegIR_OP2_Wire;
	wire RegIR_OP3_Wire;
	wire RegIR_RS1_Wire;
	wire RegIR_BIT13_Wire;
	wire RegIR_RS2_Wire;

//=======================================================
//  Structural coding
//=======================================================
	uDataPath #(.MIR_BUS_WIDTH(MIR_BUS_WIDTH), .Direction_BUS_WIDTH(Direction_BUS_WIDTH), .Decode_BUS_WIDTH(Decode_BUS_WIDTH), .Selection_BUS_WIDTH(Selection_BUS_WIDTH), .REG_BUS_WIDTH(REG_BUS_WIDTH), .COND_BUS_WIDTH(COND_BUS_WIDTH), .FLAGs_BUS_WIDTH(FLAGs_BUS_WIDTH), .DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATA_REGFIXED_INIT_0(DATA_REGFIXED_INIT_0), .DATA_REGGEN_INIT_0(DATA_REGGEN_INIT_0), .DATA_REGPC_INIT(DATA_REGPC_INIT) ,.DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION), .DATAWIDTH_MIR_FIELD(DATAWIDTH_MUX_SELECTION)) uDataPath_u0 (
// port map - connection between master ports and signals/registers   
	.PSR_Overflow_InHigh(PSR_OverflowCONTROL_Wire),
	.PSR_Carry_InHigh(PSR_CarryCONTROL_Wire),
	.PSR_Negative_InHigh(PSR_NegativeCONTROL_Wire),
	.PSR_Zero_InHigh(PSR_ZeroCONTROL_Wire),
	
	.RegIR_OP(RegIR_OP_Wire),
	.RegIR_RD(RegIR_RD_Wire),
	.RegIR_OP2(RegIR_OP2_Wire),
	.RegIR_OP3(RegIR_OP3_Wire),
	.RegIR_RS1(RegIR_RS1_Wire),
	.RegIR_BIT13(RegIR_BIT13_Wire),
	.RegIR_RS2(RegIR_RS2_Wire),
	
	.uDataPath_CLOCK_50(WB_SYSTEM_CLOCK_50),
	.uDataPath_Reset_InHigh(WB_SYSTEM_Reset_InHigh)
);
endmodule

