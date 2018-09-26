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
module uDataPath #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATA_REGFIXED_INIT_0=32'h00000000, parameter DATA_REGGEN_INIT_0=32'h00000000,parameter DATA_REGPC_INIT=32'h00000800, parameter DATAWIDTH_DECODER_OUT=38, parameter DATAWIDTH_MUX_SELECTION=6, parameter DATAWIDTH_MIR_FIELD=6)(
	//////////// OUTPUTS //////////
	PSR_Overflow_InHigh,
	PSR_Carry_InHigh,
	PSR_Negative_InHigh,
	PSR_Zero_InHigh,
	RegIR_OP,
	RegIR_RD,
	RegIR_OP2,
	RegIR_OP3,
	RegIR_RS1,
	RegIR_BIT13,
	RegIR_RS2,
	RegR1,
	//////////// INPUTS //////////
	uDataPath_CLOCK_50,
	uDataPath_Reset_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output 	PSR_Overflow_InHigh;
	output 	PSR_Carry_InHigh;
	output 	PSR_Negative_InHigh;
	output 	PSR_Zero_InHigh;
	
	output   RegIR_OP;
	output	RegIR_RD;
	output	RegIR_OP2;
	output	RegIR_OP3;
	output	RegIR_RS1;
	output	RegIR_BIT13;
	output	RegIR_RS2;
	output	RegR1;
	//////////// INPUTS //////////
	input 	uDataPath_CLOCK_50;
	input 	uDataPath_Reset_InHigh;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// DECODERS
	wire [DATAWIDTH_DECODER_OUT-1:0] Decoder_DataWrite_Wire_A; 
	wire [DATAWIDTH_DECODER_OUT-1:0] Decoder_DataWrite_Wire_B; 
	wire [DATAWIDTH_DECODER_OUT-1:0] Decoder_DataWrite_Wire_C; 
// ALU
	wire [DATAWIDTH_ALU_SELECTION-1:0] uDataPath_ALUSelection;
// FLAGS FROM ALU TO PSR
	wire uDataPath_Overflow_InHigh;
	wire uDataPath_Carry_InHigh;
	wire uDataPath_Negative_InHigh;
	wire uDataPath_Zero_InHigh;
// Wires to get register from PSR
	wire [DATAWIDTH_BUS-13:0] psr_left; // Variable usada para la operación suma y para determinar las flags
	wire [DATAWIDTH_BUS-25:0] pst_right;		// Variable usada para la operación suma y para determinar las flags
// ARCHITECTURE BUSES WIRES - INPUT
	wire [DATAWIDTH_BUS-1:0] DataBUS_A_In;
	wire [DATAWIDTH_BUS-1:0] DataBUS_B_In;
	wire [DATAWIDTH_BUS-1:0] DataBUS_C_In;
// ARCHITECTURE BUSES WIRES - OUTPUT
	wire [DATAWIDTH_BUS-1:0] DataBUS_A_Out;
	wire [DATAWIDTH_BUS-1:0] DataBUS_B_Out;
	wire [DATAWIDTH_BUS-1:0] DataBUS_C_Out;
// MIR REGISTER
	wire [DATAWIDTH_MIR_FIELD-1:0] MIR_A_FIELD;
	wire [DATAWIDTH_MIR_FIELD-1:0] MIR_B_FIELD;
	wire [DATAWIDTH_MIR_FIELD-1:0] MIR_C_FIELD;
// MUX SELECT
	wire MUX_SELECT_A;
	wire MUX_SELECT_B;
	wire MUX_SELECT_C;
// DECODER CONTROL:  TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_A;
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_B;
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_C;

//=======================================================
//  Structural coding
//=======================================================

//-------------------------------------------------------
//GENERAL_REGISTERS
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r1 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(RegR1),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[1]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[1]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[1]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r2 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[2]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[2]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[2]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r3 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[3]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[3]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[3]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r4 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[4]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[4]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[4]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r5 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[5]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[5]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[5]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r6 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[6]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[6]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[6]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r7 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[7]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[7]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[7]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r8 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[8]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[8]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[8]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r9 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[9]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[9]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[9]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r10 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[10]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[10]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[10]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r11 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[11]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[11]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[11]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r12 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[12]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[12]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[12]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r13 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[13]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[13]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[13]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r14 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[14]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[14]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[14]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r15 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[15]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[15]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[15]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r16 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[16]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[16]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[16]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r17 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[17]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[17]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[17]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r18 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[18]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[18]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[18]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r19 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[19]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[19]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[19]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r20 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[20]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[20]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[20]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r21 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[21]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[21]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[21]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r22 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[22]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[22]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[22]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r23 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[23]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[23]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[23]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r24 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[24]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[24]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[24]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r25 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[25]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[25]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[25]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r26 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[26]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[26]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[26]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r27 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[27]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[27]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[27]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r28 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[28]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[28]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[28]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r29 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[29]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[29]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[29]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r30 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[30]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[30]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[30]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r31 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[31]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[31]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[31]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGPC_INIT)) SC_RegGENERAL_pc (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[32]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[32]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[32]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t0 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[33]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[33]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[33]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t1 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[34]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[34]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[34]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t2 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[35]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[35]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[35]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t3 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegGENERAL_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[35]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[36]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[36]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegIR #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegIR_ir (
// port map - connection between master ports and signals/registers   
	.SC_RegIR_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegIR_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegIR_OP(RegIR_OP),
	.SC_RegIR_RD(RegIR_RD),
	.SC_RegIR_OP2(RegIR_OP2),
	.SC_RegIR_OP3(RegIR_OP3),
	.SC_RegIR_RS1(RegIR_RS1),
	.SC_RegIR_BIT13(RegIR_BIT13),
	.SC_RegIR_RS2(RegIR_RS2),
	.SC_RegIR_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegIR_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegIR_Write_InHigh(Decoder_DataWrite_Wire_C[37]),
	.SC_RegIR_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[37]),
	.SC_RegIR_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[37]),
	.SC_RegIR_DataBUS_In(DataBUS_C_Out)
);
//-------------------------------------------------------

//-------------------------------------------------------
// FIXED_REGISTERS
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_0)) SC_RegFIXED_r0 (
// port map - connection between master ports and signals/registers   
	.SC_RegFIXED_DataBUS_Out_A(DataBUS_A_In),
	.SC_RegFIXED_DataBUS_Out_B(DataBUS_B_In),
	.SC_RegFIXED_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegFIXED_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegFIXED_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[0]),
	.SC_RegFIXED_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[0])
);
//-------------------------------------------------------

//-------------------------------------------------------
// DECODER TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA TO DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_A
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_DataDecoder_Out(Decoder_DataWrite_Wire_A),
	.CC_DECODER_Selection_In(MUX_TO_DECODER_A)
);

// DECODER TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA TO DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_B
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_DataDecoder_Out(Decoder_DataWrite_Wire_B),
	.CC_DECODER_Selection_In(MUX_TO_DECODER_B)
);

// DECODER TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA TO DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_C
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_DataDecoder_Out(Decoder_DataWrite_Wire_C),
	.CC_DECODER_Selection_In(MUX_TO_DECODER_C)
);

//-------------------------------------------------------

//-------------------------------------------------------

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
	.CC_MUX_MIR_FIELD(MIR_A_FIELD),
	.CC_MUX_IR_FIELD(RegIR_RS1),
	.CC_MUX_SELECT(MUX_SELECT_A)
);

CC_MUX #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_BUS), .DATAWIDTH_IR_SELECTION(5)) CC_MUX_b
(
// port map - connection between master ports and signals/registers  
	.CC_MUX_TO_DECODER_OUT(MUX_TO_DECODER_B), 
	.CC_MUX_MIR_FIELD(MIR_B_FIELD),
	.CC_MUX_IR_FIELD(RegIR_RS2),
	.CC_MUX_SELECT(MUX_SELECT_B)
);

CC_MUX #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_BUS), .DATAWIDTH_IR_SELECTION(5)) CC_MUX_c
(
// port map - connection between master ports and signals/registers  
	.CC_MUX_TO_DECODER_OUT(MUX_TO_DECODER_C), 
	.CC_MUX_MIR_FIELD(MIR_C_FIELD),
	.CC_MUX_IR_FIELD(RegIR_RD),
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
SC_RegPSR #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_psr (
// port map - connection between master ports and signals/registers   
	.PSR_Negative_InHigh(PSR_Negative_InHigh),
	.PSR_Zero_InHigh(PSR_Zero_InHigh),
	.PSR_Overflow_InHigh(PSR_Overflow_InHigh),
	.PSR_Carry_InHigh(PSR_Carry_InHigh),
	.SC_RegPSR_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegPSR_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegPSR_Write_InHigh(~(DATAWIDTH_ALU_SELECTION[DATAWIDTH_ALU_SELECTION-1] | DATAWIDTH_ALU_SELECTION[DATAWIDTH_ALU_SELECTION-2])),
	.uDataPath_Negative_InHigh(uDataPath_Negative_InHigh),
	.uDataPath_Zero_InHigh(uDataPath_Zero_InHigh),
	.uDataPath_Overflow_InHigh(uDataPath_Overflow_InHigh),
	.uDataPath_Carry_InHigh(uDataPath_Carry_InHigh)
	
);
//-------------------------------------------------------

//-------------------------------------------------------
//MIR
MIR #(DATAWITH_MIR_BUS, DATAWIDTH_MIR_FIELD, DATAWIDTH_ALU_SELECTION, COND_BUS_WIDTH, JUMP_ADDR_BUS_WIDTH) SC_MIR (
	MIR_CLOCK_50(uDataPath_CLOCK_50),
	MIR_Microinstruccion_IN(BUS_ROM_TO_MIR),
	MIR_A_OUT(MIR_A_FIELD),
	MIR_AMUX_OUT(MUX_SELECT_A),
	MIR_B_OUT(MIR_B_FIELD),
	MIR_BMUX_OUT(MUX_SELECT_B),
	MIR_C_OUT(MUX_SELECT_C),
	MIR_CMUX_OUT(MUX_SELECT_C),
	MIR_RD_OUT,
	MIR_WR_OUT,
	MIR_ALU_OUT(uDataPath_ALUSelection),
	MIR_COND_OUT,
	MIR_JUMP_ADDR_OUT
	
);
//-------------------------------------------------------

//-------------------------------------------------------
//ROM
MI_ROM #(JUMP_ADDR_BUS_WIDTH, DATAWITH_MIR_BUS) SC_ROM(
BUS_IN(),
BUS_OUT(BUS_ROM_TO_MIR)
);
//-------------------------------------------------------

//-------------------------------------------------------
// CS_ADDRESS_MUS
CS_Address_MUX #(parameter Direction_BUS_WIDTH = 11, parameter Decode_BUS_WIDTH = 8, parameter Selection_BUS_WIDTH = 2)(
	//////////// INPUTS //////////
	CS_Addres_MUX_Next_IN,
	CS_Addres_MUX_Jump_IN,
	CS_Addres_MUX_Decode_IN,
	CS_Addres_MUX_Selection_IN,
	//////////// OUTPUTS //////////
   CS_Addres_MUX_Direccion_OUT()
);
endmodule
endmodule

