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
module WB_SYSTEM #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATA_REGFIXED_INIT_0=32'h00000000, parameter DATA_REGGEN_INIT_0=32'h00000000,parameter DATA_REGPC_INIT=32'h00000800, parameter DATAWIDTH_DECODER_OUT=38, parameter DATAWIDTH_MUX_SELECTION=6)(
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
	uDataPath #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATA_REGFIXED_INIT_0(DATA_REGFIXED_INIT_0), .DATA_REGGEN_INIT_0(DATA_REGGEN_INIT_0), .DATA_REGPC_INIT(DATA_REGPC_INIT) ,.DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION)) uDataPath_u0 (
// port map - connection between master ports and signals/registers   
	.uDataPath_DataBUSDisplay_Out(WB_SYSTEM_DataBUSDisplay_Out),
	.PSR_Overflow_InHigh(PSR_OverflowCONTROL_Wire),
	.PSR_Carry_InHigh(PSR_CarryCONTROL_Wire),
	.PSR_Negative_InHigh(PSR_NegativeCONTROL_Wire),
	.PSR_Zero_InHigh(PSR_ZeroCONTROL_Wire),
	
	.uDataPath_RegIR_OP(RegIR_OP_Wire),
	.uDataPath_RegIR_RD(RegIR_RD_Wire),
	.uDataPath_RegIR_OP2(RegIR_OP2_Wire),
	.uDataPath_RegIR_OP3(RegIR_OP3_Wire),
	.uDataPath_RegIR_RS1(RegIR_RS1_Wire),
	.uDataPath_RegIR_BIT13(RegIR_BIT13_Wire),
	.uDataPath_RegIR_RS2(RegIR_RS2_Wire),
	
	.uDataPath_CLOCK_50(WB_SYSTEM_CLOCK_50),
	.uDataPath_Reset_InHigh(WB_SYSTEM_Reset_InHigh),
	.uDataPath_DecoderSelectionWrite_Out(Decoder_SelectionCONTROL_Wire), 
	.uDataPath_MUXSelectionBUSA_Out(MUX_SelectionBUSACONTROL_Wire),
	.uDataPath_MUXSelectionBUSB_Out(MUX_SelectionBUSBCONTROL_Wire),
	.uDataPath_ALUSelection_Out(ALU_SelectionCONTROL_Wire)
);
uControl #() uControl_1(
	.uControl_CLOCK_50(WB_SYSTEM_CLOCK_50),
   .uControl_FLAGs_IN,
	.uControl_IR13_IN,
	.uControl_Decode,
   .uControl_A_OUT,
	.uControl_AMUX_OUT,
	.uControl_B_OUT,
	.uControl_BMUX_OUT,
	.uControl_C_OUT,
	.uControl_CMUX_OUT,
	.uControl_RD_OUT,
	.uControl_WR_OUT,
	.uControl_ALU_OUT
);

//	SC_STATEMACHINE #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION)) SC_STATEMACHINE_u0 (
//// port map - connection between master ports and signals/registers   
//	.SC_STATEMACHINE_DecoderSelectionWrite_Out(Decoder_SelectionCONTROL_Wire), 
//	.SC_STATEMACHINE_MUXSelectionBUSA_Out(MUX_SelectionBUSACONTROL_Wire),
//	.SC_STATEMACHINE_MUXSelectionBUSB_Out(MUX_SelectionBUSBCONTROL_Wire),
//	.SC_STATEMACHINE_ALUSelection_Out(ALU_SelectionCONTROL_Wire),
//	.SC_STATEMACHINE_RegSHIFTERLoad_OutHigh(RegSHIFTER_LoadCONTROL_Wire),
//	.SC_STATEMACHINE_RegSHIFTERShiftSelection_OutHigh(RegSHIFTER_ShiftSelectionCONTROL_Wire),
//	
//	.SC_STATEMACHINE_CLOCK_50(WB_SYSTEM_CLOCK_50),
//	.SC_STATEMACHINE_Reset_InHigh(WB_SYSTEM_Reset_InHigh),
//	.SC_STATEMACHINE_Overflow_InHigh(ALU_OverflowCONTROL_Wire),
//	.SC_STATEMACHINE_Carry_InHigh(ALU_CarryCONTROL_Wire),
//	.SC_STATEMACHINE_Negative_InHigh(ALU_NegativeCONTROL_Wire),
//	.SC_STATEMACHINE_Zero_InHigh(ALU_ZeroCONTROL_Wire)
//);
endmodule

