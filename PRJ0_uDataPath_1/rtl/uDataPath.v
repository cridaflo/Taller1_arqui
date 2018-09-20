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
module uDataPath #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATA_REGFIXED_INIT_0=32'h00000000, parameter DATA_REGGEN_INIT_0=32'h00000000,parameter DATA_REGPC_INIT=32'h00000800, parameter DATAWIDTH_DECODER_OUT=38, parameter DATAWIDTH_MUX_SELECTION=6)(
	//////////// OUTPUTS //////////
	uDataPath_DataBUSDisplay_Out,
	PSR_Overflow_InHigh,
	PSR_Carry_InHigh,
	PSR_Negative_InHigh,
	PSR_Zero_InHigh,
	Scratchpath_RegIR_OP,
	Scratchpath_RegIR_RD,
	Scratchpath_RegIR_OP2,
	Scratchpath_RegIR_OP3,
	Scratchpath_RegIR_RS1,
	Scratchpath_RegIR_BIT13,
	Scratchpath_RegIR_RS2,
	//////////// INPUTS //////////
	uDataPath_CLOCK_50,
	uDataPath_Reset_InHigh,
	uDataPath_ALUSelection_Out,
	MIR_A_FIELD,
	MIR_B_FIELD,
	MIR_C_FIELD,
	MUX_SELECT_A,
	MUX_SELECT_B,
	MUX_SELECT_C
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output 	[DATAWIDTH_BUS-1:0]	uDataPath_DataBUSDisplay_Out;
	output 	PSR_Overflow_InHigh;
	output 	PSR_Carry_InHigh;
	output 	PSR_Negative_InHigh;
	output 	PSR_Zero_InHigh;
	output  	Scratchpath_RegIR_OP;
	output	Scratchpath_RegIR_RD;
	output	Scratchpath_RegIR_OP2;
	output	Scratchpath_RegIR_OP3;
	output	Scratchpath_RegIR_RS1;
	output	Scratchpath_RegIR_BIT13;
	output	Scratchpath_RegIR_RS2;
	//////////// INPUTS //////////
	input 	uDataPath_CLOCK_50;
	input 	uDataPath_Reset_InHigh;
	input 	[DATAWIDTH_DECODER_SELECTION-1:0]	DecoderSelection_A;
	input 	[DATAWIDTH_DECODER_SELECTION-1:0]	DecoderSelection_B;
	input 	[DATAWIDTH_DECODER_SELECTION-1:0]	DecoderSelection_C;
	input 	[DATAWIDTH_MUX_SELECTION-1:0]	DataBUS_A_Out;
	input 	[DATAWIDTH_MUX_SELECTION-1:0]	DataBUS_A_Out;
	input 	[DATAWIDTH_ALU_SELECTION-1:0]	uDataPath_ALUSelection_Out;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// FLAGS FROM ALU TO PSR
	wire uDataPath_Overflow_InHigh;
	wire uDataPath_Carry_InHigh;
	wire uDataPath_Negative_InHigh;
	wire uDataPath_Zero_InHigh;
// Wires to get register from PSR
	wire [DATAWIDTH_BUS-13:0] psr_left; // Variable usada para la operación suma y para determinar las flags
	wire [DATAWIDTH_BUS-25:0] pst_right;		// Variable usada para la operación suma y para determinar las flags
// SHIFT_REGISTER CONTROL
	//wire RegSHIFTER_LoadCONTROL_Wire;
	//wire [DATAWIDTH_REGSHIFTER_SELECTION-1:0] RegSHIFTER_ShiftSelectionCONTROL_Wire;
// ARCHITECTURE BUSES WIRES
	wire [DATAWIDTH_BUS-1:0] DataBUS_A_Out;
	wire [DATAWIDTH_BUS-1:0] DataBUS_B_Out;
	wire [DATAWIDTH_BUS-1:0] DataBUS_C_Out;
// DECODER CONTROL:  TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
	//wire [DATAWIDTH_DECODER_SELECTION-1:0] Decoder_SelectionCONTROL_Wire; 
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_A;
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_B;
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_C;
// MUX CONTROL: TO SELECT OUTPUT REGISTER TO BUS_A, BUS_B OR BOTH OF THEM
	//wire [DATAWIDTH_MUX_SELECTION-1:0] MUX_SelectionBUSACONTROL_Wire;
	//wire [DATAWIDTH_MUX_SELECTION-1:0] MUX_SelectionBUSBCONTROL_Wire;
//ALU CONTROL
	//wire [DATAWIDTH_ALU_SELECTION-1:0] ALU_SelectionCONTROL_Wire;
	//wire ALU_OverflowCONTROL_Wire;
	//wire ALU_CarryCONTROL_Wire;
	//wire ALU_NegativeCONTROL_Wire;
	//wire ALU_ZeroCONTROL_Wire;

//=======================================================
//  Structural coding
//=======================================================
// SCRATCHPATH
Scratchpath #(.DATAWIDTH_BUS(DATAWIDTH_BUS),.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_BUS), .DATA_REGFIXED_INIT_0(DATA_REGFIXED_INIT_0), .DATA_REGGEN_INIT_0(DATA_REGGEN_INIT_0), .DATA_REGPC_INIT(DATA_REGPC_INIT), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) Scratchpath (
	//////////// OUTPUTS //////////
	.Scratchpath_RegIR_OP(Scratchpath_RegIR_OP),
	.Scratchpath_RegIR_RD(Scratchpath_RegIR_RD),
	.Scratchpath_RegIR_OP2(Scratchpath_RegIR_OP2),
	.Scratchpath_RegIR_OP3(Scratchpath_RegIR_OP3),
	.Scratchpath_RegIR_RS1(Scratchpath_RegIR_RS1),
	.Scratchpath_RegIR_BIT13(Scratchpath_RegIR_BIT13),
	.Scratchpath_RegIR_RS2(Scratchpath_RegIR_RS2),
	//////////// INPUTS //////////
	uDataPath_CLOCK_50(uDataPath_CLOCK_50),
	uDataPath_Reset_InHigh(uDataPath_Reset_InHigh),
	DataBus_A_Wire(DataBUS_A_Out),
	DataBus_B_Wire(DataBUS_B_Out),
	DataBus_C_Wire(DataBUS_C_Out),
	DecoderSelectionWrite_Out_A(MUX_TO_DECODER_A),
	DecoderSelectionWrite_Out_B(MUX_TO_DECODER_B),
	DecoderSelectionWrite_Out_C(MUX_TO_DECODER_C)
);


// BUS: CONNECTS REGISTER, ALU AND MEMORY
CC_BUS #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_BUS_A
(
// port map - connection between master ports and signals/registers  
	.CC_BUS_DataBUS_Out(DataBUS_A_Out), 
	.CC_BUS_DataBUS_In(DataBUS_A_In)
);

CC_BUS #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_BUS_B
(
// port map - connection between master ports and signals/registers  
	.CC_BUS_DataBUS_Out(DataBUS_B_Out), 
	.CC_BUS_DataBUS_In(DataBUS_B_In)
);

CC_BUS #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_BUS_C
(
// port map - connection between master ports and signals/registers  
	.CC_BUS_DataBUS_Out(DataBUS_C_Out), 
	.CC_BUS_DataBUS_In(DataBUS_C_In)
);
//-------------------------------------------------------

//-------------------------------------------------------
// MUX CONTROL
CC_MUX #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_BUS), .DATAWIDTH_IR_SELECTION(5)) CC_MUX_A
(
// port map - connection between master ports and signals/registers  
	.CC_MUX_TO_DECODER_OUT(MUX_TO_DECODER_A), 
	.CC_MUX_MIR_FIELD(MIR_A_FIELD)
	.CC_MUX_IR_FIELD(Scratchpath_RegIR_RS1),
	.CC_MUX_SELECT(MUX_SELECT_A)
);

CC_MUX #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_BUS), .DATAWIDTH_IR_SELECTION(5)) CC_MUX_b
(
// port map - connection between master ports and signals/registers  
	.CC_MUX_TO_DECODER_OUT(MUX_TO_DECODER_B), 
	.CC_MUX_MIR_FIELD(MIR_B_FIELD)
	.CC_MUX_IR_FIELD(Scratchpath_RegIR_RS2),
	.CC_MUX_SELECT(MUX_SELECT_B)
);

CC_MUX #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_BUS), .DATAWIDTH_IR_SELECTION(5)) CC_MUX_c
(
// port map - connection between master ports and signals/registers  
	.CC_MUX_TO_DECODER_OUT(MUX_TO_DECODER_C), 
	.CC_MUX_MIR_FIELD(MIR_C_FIELD)
	.CC_MUX_IR_FIELD(Scratchpath_RegIR_RD),
	.CC_MUX_SELECT(MUX_SELECT_C)
);
//-------------------------------------------------------

//-------------------------------------------------------
// ALU
CC_ALU #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION)) CC_ALU_u0
(
// port map - connection between master ports and signals/registers   
	.CC_ALU_Overflow_OutHigh(uDataPath_Overflow_InHigh), 
	.CC_ALU_Carry_OutHigh(uDataPath_Carry_InHigh), 
	.CC_ALU_Negative_OutHigh(uDataPath_Negative_InHigh), 
	.CC_ALU_Zero_OutHigh(uDataPath_Zero_InHigh),
	.CC_ALU_DataBUS_Out(DataBUS_C_In),
	.CC_ALU_DataBUSA_In(DataBUS_A_Out), 
	.CC_ALU_DataBUSB_In(DataBUS_B_Out),
	.CC_ALU_Selection_In(uDataPath_ALUSelection_Out)
);
//-------------------------------------------------------

//-------------------------------------------------------
//PSR REGISTER
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_psr (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out({8'b0,PSR_Negative_InHigh,PSR_Zero_InHigh,PSR_Overflow_InHigh,PSR_Carry_InHigh,20'b0}),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(~(DATAWIDTH_ALU_SELECTION[DATAWIDTH_ALU_SELECTION-1] | DATAWIDTH_ALU_SELECTION[DATAWIDTH_ALU_SELECTION-2])),
	.SC_RegGENERAL_DataBUS_In({8'b0, uDataPath_Negative_InHigh, uDataPath_Zero_InHigh, uDataPath_Overflow_InHigh,uDataPath_Carry_InHigh ,20'b0})
);
assign uDataPath_DataBUSDisplay_Out = RegGENERAL2MUX_DataBUS_R1;

endmodule

