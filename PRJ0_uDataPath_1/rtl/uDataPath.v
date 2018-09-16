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
module uDataPath #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATA_REGFIXED_INIT_0=8'b00000000, parameter DATAWIDTH_DECODER_OUT=38, parameter DATAWIDTH_MUX_SELECTION=6)(
	//////////// OUTPUTS //////////
	uDataPath_DataBUSDisplay_Out,
	uDataPath_Overflow_InLow,
	uDataPath_Carry_InLow,
	uDataPath_Negative_InLow,
	uDataPath_Zero_InLow,
	//////////// INPUTS //////////
	uDataPath_CLOCK_50,
	uDataPath_Reset_InHigh,
	uDataPath_DecoderSelectionWrite_Out,
	uDataPath_MUXSelectionBUSA_Out,
	uDataPath_MUXSelectionBUSB_Out,
	uDataPath_ALUSelection_Out
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output 	[DATAWIDTH_BUS-1:0]	uDataPath_DataBUSDisplay_Out;
	output 	uDataPath_Overflow_InLow;
	output 	uDataPath_Carry_InLow;
	output 	uDataPath_Negative_InLow;
	output 	uDataPath_Zero_InLow;
	//////////// INPUTS //////////
	input 	uDataPath_CLOCK_50;
	input 	uDataPath_Reset_InHigh;
	input 	[DATAWIDTH_DECODER_SELECTION-1:0]	uDataPath_DecoderSelectionWrite_Out;
	input 	[DATAWIDTH_MUX_SELECTION-1:0]	uDataPath_MUXSelectionBUSA_Out;
	input 	[DATAWIDTH_MUX_SELECTION-1:0]	uDataPath_MUXSelectionBUSB_Out;
	input 	[DATAWIDTH_ALU_SELECTION-1:0]	uDataPath_ALUSelection_Out;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// FIXED_REGISTERS OUTPUTS WIRES
	wire [DATAWIDTH_BUS-1:0] RegFIXED2MUX_DataBUS_R0; 
// GENERAL_REGISTERS OUTPUTS
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_Wire_0; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R1; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R2; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R3; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R4; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R5; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R6; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R7; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R8; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R9;
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R10;
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R11; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R12; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R13; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R14; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R15; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R16; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R17; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R18; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R19;
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R20;
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R21; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R22; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R23; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R24; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R25; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R26; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R27; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R28; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R29;
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R30; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_R31; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_PC; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_T0; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_T1; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_T2; 
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_T3;
	wire [DATAWIDTH_BUS-1:0] RegGENERAL2MUX_DataBUS_IR;
// SHIFT_REGISTER CONTROL
	//wire RegSHIFTER_LoadCONTROL_Wire;
	//wire [DATAWIDTH_REGSHIFTER_SELECTION-1:0] RegSHIFTER_ShiftSelectionCONTROL_Wire;
// ARCHITECTURE BUSES WIRES
	wire [DATAWIDTH_BUS-1:0] DataBUS_A_Wire;
	wire [DATAWIDTH_BUS-1:0] DataBUS_B_Wire; 
	wire [DATAWIDTH_BUS-1:0] ALU2RegSHIFTER_DataBUS_Wire;
	wire [DATAWIDTH_BUS-1:0] DataBus_C_Wire;
// DECODER CONTROL:  TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
	//wire [DATAWIDTH_DECODER_SELECTION-1:0] Decoder_SelectionCONTROL_Wire; 
	wire [DATAWIDTH_DECODER_OUT-1:0] Decoder_DataWrite_Wire;
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

//-------------------------------------------------------
//GENERAL_REGISTERS
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r1 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R1),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[1]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r2 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R2),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[2]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r3 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R3),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[3]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r4 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R4),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[4]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r5 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R5),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[5]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r6 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R6),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[6]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r7 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R7),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[7]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r8 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R8),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[8]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r9 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R9),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[9]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r10 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R10),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[10]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r11 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R11),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[11]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r12 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R12),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[12]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r13 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R13),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[13]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r14 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R14),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[14]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r15 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R15),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[15]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r16 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R16),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[16]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r17 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R17),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[17]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r18 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R18),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[18]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r19 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R19),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[19]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r20 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R20),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[20]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r21 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R21),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[21]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r22 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R22),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[22]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r23 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R23),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[23]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r24 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R24),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[24]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r25 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R25),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[25]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r26 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R26),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[26]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r27 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R27),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[27]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r28 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R28),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[28]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r29 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R29),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[29]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r30 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R30),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[30]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_r31 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_R31),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[31]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_pc (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_PC),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[32]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_t0 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_T0),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[33]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_t1 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_T1),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[34]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_t2 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_T2),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[35]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_t3 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_T3),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[36]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) SC_RegGENERAL_ir (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out(RegGENERAL2MUX_DataBUS_IR),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire[37]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
//-------------------------------------------------------

//-------------------------------------------------------
// FIXED_REGISTERS
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_0)) SC_RegFIXED_r0 (
// port map - connection between master ports and signals/registers   
	.SC_RegFIXED_DataBUS_Out(RegFIXED2MUX_DataBUS_R0),
	.SC_RegFIXED_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegFIXED_Reset_InHigh(uDataPath_Reset_InHigh)
);
//-------------------------------------------------------

//-------------------------------------------------------
// SHIFT_REGISTER
//SC_RegSHIFTER #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_REGSHIFTER_SELECTION(DATAWIDTH_REGSHIFTER_SELECTION)) SC_RegSHIFTER_r0 (
//// port map - connection between master ports and signals/registers   
//	.SC_RegSHIFTER_DataBUS_Out(DataBus_C_Wire),
//	.SC_RegSHIFTER_CLOCK_50(uDataPath_CLOCK_50),
//	.SC_RegSHIFTER_Reset_InHigh(uDataPath_Reset_InHigh),
//	.SC_RegSHIFTER_Load_InLow(uDataPath_RegSHIFTERLoad_OutLow),
//	.SC_RegSHIFTER_ShiftSelection_InLow(uDataPath_RegSHIFTERShiftSelection_OutLow),
//	.SC_RegSHIFTER_DataBUS_In(ALU2RegSHIFTER_DataBUS_Wire)
//);
//-------------------------------------------------------

//-------------------------------------------------------
// DECODER TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA TO DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_u0
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_DataDecoder_Out(Decoder_DataWrite_Wire),
	.CC_DECODER_Selection_In(uDataPath_DecoderSelectionWrite_Out)
);
//-------------------------------------------------------

//-------------------------------------------------------
// MUX CONTROL: TO SELECT OUTPUT REGISTER TO BUS_A, BUS_B OR BOTH OF THEM
CC_MUXX #(.DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_MUXX_u0
(
// port map - connection between master ports and signals/registers   
	.CC_MUX_DataBUS_Out(DataBUS_A_Wire),
	.CC_MUX_DataBUS_In_0(RegFIXED2MUX_DataBUS_R0), 
	.CC_MUX_DataBUS_In_1(RegGENERAL2MUX_DataBUS_R1), 
	.CC_MUX_DataBUS_In_2(RegGENERAL2MUX_DataBUS_R2), 
	.CC_MUX_DataBUS_In_3(RegGENERAL2MUX_DataBUS_R3), 
	.CC_MUX_DataBUS_In_4(RegGENERAL2MUX_DataBUS_R4),
	.CC_MUX_DataBUS_In_5(RegGENERAL2MUX_DataBUS_R5), 
	.CC_MUX_DataBUS_In_6(RegGENERAL2MUX_DataBUS_R6), 
	.CC_MUX_DataBUS_In_7(RegGENERAL2MUX_DataBUS_R7),
	.CC_MUX_DataBUS_In_8(RegGENERAL2MUX_DataBUS_R8), 
	.CC_MUX_DataBUS_In_9(RegGENERAL2MUX_DataBUS_R9),
	.CC_MUX_DataBUS_In_10(RegGENERAL2MUX_DataBUS_R10), 
	.CC_MUX_DataBUS_In_11(RegGENERAL2MUX_DataBUS_R11), 
	.CC_MUX_DataBUS_In_12(RegGENERAL2MUX_DataBUS_R12), 
	.CC_MUX_DataBUS_In_13(RegGENERAL2MUX_DataBUS_R13), 
	.CC_MUX_DataBUS_In_14(RegGENERAL2MUX_DataBUS_R14),
	.CC_MUX_DataBUS_In_15(RegGENERAL2MUX_DataBUS_R15), 
	.CC_MUX_DataBUS_In_16(RegGENERAL2MUX_DataBUS_R16), 
	.CC_MUX_DataBUS_In_17(RegGENERAL2MUX_DataBUS_R17),
	.CC_MUX_DataBUS_In_18(RegGENERAL2MUX_DataBUS_R18), 
	.CC_MUX_DataBUS_In_19(RegGENERAL2MUX_DataBUS_R19),
	.CC_MUX_DataBUS_In_20(RegGENERAL2MUX_DataBUS_R20),
	.CC_MUX_DataBUS_In_21(RegGENERAL2MUX_DataBUS_R21), 
	.CC_MUX_DataBUS_In_22(RegGENERAL2MUX_DataBUS_R22), 
	.CC_MUX_DataBUS_In_23(RegGENERAL2MUX_DataBUS_R23), 
	.CC_MUX_DataBUS_In_24(RegGENERAL2MUX_DataBUS_R24),
	.CC_MUX_DataBUS_In_25(RegGENERAL2MUX_DataBUS_R25), 
	.CC_MUX_DataBUS_In_26(RegGENERAL2MUX_DataBUS_R26), 
	.CC_MUX_DataBUS_In_27(RegGENERAL2MUX_DataBUS_R27),
	.CC_MUX_DataBUS_In_28(RegGENERAL2MUX_DataBUS_R28), 
	.CC_MUX_DataBUS_In_29(RegGENERAL2MUX_DataBUS_R29),
	.CC_MUX_DataBUS_In_30(RegGENERAL2MUX_DataBUS_R30),
	.CC_MUX_DataBUS_In_31(RegGENERAL2MUX_DataBUS_R31), 
	.CC_MUX_DataBUS_In_32(RegGENERAL2MUX_DataBUS_PC), 
	.CC_MUX_DataBUS_In_33(RegGENERAL2MUX_DataBUS_T0), 
	.CC_MUX_DataBUS_In_34(RegGENERAL2MUX_DataBUS_T1),
	.CC_MUX_DataBUS_In_35(RegGENERAL2MUX_DataBUS_T2), 
	.CC_MUX_DataBUS_In_36(RegGENERAL2MUX_DataBUS_T3), 
	.CC_MUX_DataBUS_In_37(RegGENERAL2MUX_DataBUS_IR),
	.CC_MUX_Selection_In(uDataPath_MUXSelectionBUSA_Out)

);
// MUX CONTROL: TO SELECT OUTPUT REGISTER TO BUS_A, BUS_B OR BOTH OF THEM
CC_MUXX #(.DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_MUXX_u1
(
// port map - connection between master ports and signals/registers   
	.CC_MUX_DataBUS_Out(DataBUS_B_Wire),
	.CC_MUX_DataBUS_In_0(RegFIXED2MUX_DataBUS_R0), 
	.CC_MUX_DataBUS_In_1(RegGENERAL2MUX_DataBUS_R1), 
	.CC_MUX_DataBUS_In_2(RegGENERAL2MUX_DataBUS_R2), 
	.CC_MUX_DataBUS_In_3(RegGENERAL2MUX_DataBUS_R3), 
	.CC_MUX_DataBUS_In_4(RegGENERAL2MUX_DataBUS_R4),
	.CC_MUX_DataBUS_In_5(RegGENERAL2MUX_DataBUS_R5), 
	.CC_MUX_DataBUS_In_6(RegGENERAL2MUX_DataBUS_R6), 
	.CC_MUX_DataBUS_In_7(RegGENERAL2MUX_DataBUS_R7),
	.CC_MUX_DataBUS_In_8(RegGENERAL2MUX_DataBUS_R8), 
	.CC_MUX_DataBUS_In_9(RegGENERAL2MUX_DataBUS_R9),
	.CC_MUX_DataBUS_In_10(RegGENERAL2MUX_DataBUS_R10), 
	.CC_MUX_DataBUS_In_11(RegGENERAL2MUX_DataBUS_R11), 
	.CC_MUX_DataBUS_In_12(RegGENERAL2MUX_DataBUS_R12), 
	.CC_MUX_DataBUS_In_13(RegGENERAL2MUX_DataBUS_R13), 
	.CC_MUX_DataBUS_In_14(RegGENERAL2MUX_DataBUS_R14),
	.CC_MUX_DataBUS_In_15(RegGENERAL2MUX_DataBUS_R15), 
	.CC_MUX_DataBUS_In_16(RegGENERAL2MUX_DataBUS_R16), 
	.CC_MUX_DataBUS_In_17(RegGENERAL2MUX_DataBUS_R17),
	.CC_MUX_DataBUS_In_18(RegGENERAL2MUX_DataBUS_R18), 
	.CC_MUX_DataBUS_In_19(RegGENERAL2MUX_DataBUS_R19),
	.CC_MUX_DataBUS_In_20(RegGENERAL2MUX_DataBUS_R20),
	.CC_MUX_DataBUS_In_21(RegGENERAL2MUX_DataBUS_R21), 
	.CC_MUX_DataBUS_In_22(RegGENERAL2MUX_DataBUS_R22), 
	.CC_MUX_DataBUS_In_23(RegGENERAL2MUX_DataBUS_R23), 
	.CC_MUX_DataBUS_In_24(RegGENERAL2MUX_DataBUS_R24),
	.CC_MUX_DataBUS_In_25(RegGENERAL2MUX_DataBUS_R25), 
	.CC_MUX_DataBUS_In_26(RegGENERAL2MUX_DataBUS_R26), 
	.CC_MUX_DataBUS_In_27(RegGENERAL2MUX_DataBUS_R27),
	.CC_MUX_DataBUS_In_28(RegGENERAL2MUX_DataBUS_R28), 
	.CC_MUX_DataBUS_In_29(RegGENERAL2MUX_DataBUS_R29),
	.CC_MUX_DataBUS_In_30(RegGENERAL2MUX_DataBUS_R30),
	.CC_MUX_DataBUS_In_31(RegGENERAL2MUX_DataBUS_R31), 
	.CC_MUX_DataBUS_In_32(RegGENERAL2MUX_DataBUS_PC), 
	.CC_MUX_DataBUS_In_33(RegGENERAL2MUX_DataBUS_T0), 
	.CC_MUX_DataBUS_In_34(RegGENERAL2MUX_DataBUS_T1),
	.CC_MUX_DataBUS_In_35(RegGENERAL2MUX_DataBUS_T2), 
	.CC_MUX_DataBUS_In_36(RegGENERAL2MUX_DataBUS_T3), 
	.CC_MUX_DataBUS_In_37(RegGENERAL2MUX_DataBUS_IR),
	.CC_MUX_Selection_In(uDataPath_MUXSelectionBUSB_Out)
);
//-------------------------------------------------------

//-------------------------------------------------------
//
CC_ALU #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION)) CC_ALU_u0
(
// port map - connection between master ports and signals/registers   
	.CC_ALU_Overflow_OutLow(uDataPath_Overflow_InLow), 
	.CC_ALU_Carry_OutLow(uDataPath_Carry_InLow), 
	.CC_ALU_Negative_OutLow(uDataPath_Negative_InLow), 
	.CC_ALU_Zero_OutLow(uDataPath_Zero_InLow),
	.CC_ALU_DataBUS_Out(DataBus_C_Wire),
	.CC_ALU_DataBUSA_In(DataBUS_A_Wire), 
	.CC_ALU_DataBUSB_In(DataBUS_B_Wire),
	.CC_ALU_Selection_In(uDataPath_ALUSelection_Out)
);
//-------------------------------------------------------
assign uDataPath_DataBUSDisplay_Out = RegGENERAL2MUX_DataBUS_R1;

endmodule

