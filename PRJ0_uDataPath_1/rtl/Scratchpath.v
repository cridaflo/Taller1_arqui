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
module Scratchpath #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATA_REGFIXED_INIT_0=32'h00000000, parameter DATA_REGGEN_INIT_0=32'h00000000,parameter DATA_REGPC_INIT=32'h00000800, parameter DATAWIDTH_DECODER_OUT=38)(
	//////////// OUTPUTS //////////
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
	DataBus_A_Wire,
	DataBus_B_Wire,
	DataBus_C_Wire,
	DecoderSelectionWrite_Out_A,
	DecoderSelectionWrite_Out_B,
	DecoderSelectionWrite_Out_C
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
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
	output		[DATAWIDTH_BUS-1:0] DataBus_A_Wire;
	output		[DATAWIDTH_BUS-1:0] DataBus_B_Wire;
	input		[DATAWIDTH_BUS-1:0] DataBus_C_Wire;
	
	input [DATAWIDTH_DECODER_SELECTION-1:0] DecoderSelectionWrite_Out_A;
	input [DATAWIDTH_DECODER_SELECTION-1:0] DecoderSelectionWrite_Out_B;
	input [DATAWIDTH_DECODER_SELECTION-1:0] DecoderSelectionWrite_Out_C;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// GENERAL_REGISTERS OUTPUTS
	wire [DATAWIDTH_DECODER_OUT-1:0] Decoder_DataWrite_Wire_A; 
	wire [DATAWIDTH_DECODER_OUT-1:0] Decoder_DataWrite_Wire_B; 
	wire [DATAWIDTH_DECODER_OUT-1:0] Decoder_DataWrite_Wire_C; 

//=======================================================
//  Structural coding
//=======================================================

//-------------------------------------------------------
//GENERAL_REGISTERS
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r1 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(RegR1),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[1]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[1]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[1]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r2 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[2]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[2]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[2]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r3 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[3]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[3]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[3]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r4 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[4]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[4]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[4]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r5 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[5]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[5]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[5]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r6 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[6]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[6]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[6]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r7 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[7]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[7]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[7]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r8 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[8]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[8]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[8]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r9 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[9]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[9]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[9]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r10 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[10]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[10]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[10]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r11 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[11]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[11]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[11]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r12 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[12]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[12]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[12]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r13 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[13]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[13]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[13]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r14 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[14]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[14]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[14]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r15 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[15]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[15]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[15]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r16 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[16]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[16]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[16]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r17 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[17]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[17]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[17]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r18 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[18]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[18]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[18]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r19 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[19]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[19]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[19]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r20 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[20]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[20]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[20]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r21 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[21]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[21]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[21]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r22 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[22]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[22]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[22]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r23 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[23]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[23]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[23]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r24 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[24]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[24]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[24]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r25 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[25]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[25]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[25]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r26 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[26]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[26]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[26]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r27 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[27]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[27]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[27]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r28 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[28]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[28]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[28]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r29 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[29]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[29]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[29]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r30 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[30]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[30]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[30]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r31 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[31]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[31]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[31]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGPC_INIT)) SC_RegGENERAL_pc (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[32]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[32]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[32]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t0 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[33]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[33]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[33]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t1 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[34]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[34]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[34]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t2 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[35]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[35]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[35]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t3 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegGENERAL_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegGENERAL_DataBUS_Out(),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[36]),
	.SC_RegGENERAL_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[36]),
	.SC_RegGENERAL_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[36]),
	.SC_RegGENERAL_DataBUS_In(DataBus_C_Wire)
);
SC_RegIR #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegIR_ir (
// port map - connection between master ports and signals/registers   
	.SC_RegIR_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegIR_DataBUS_Out_B(DataBus_B_Wire),
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
	.SC_RegIR_DataBUS_In(DataBus_C_Wire)
);
//-------------------------------------------------------

//-------------------------------------------------------
// FIXED_REGISTERS
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_0)) SC_RegFIXED_r0 (
// port map - connection between master ports and signals/registers   
	.SC_RegFIXED_DataBUS_Out_A(DataBus_A_Wire),
	.SC_RegFIXED_DataBUS_Out_B(DataBus_B_Wire),
	.SC_RegFIXED_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegFIXED_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegFIXED_ENABLE_BUS_A(Decoder_DataWrite_Wire_A[37]),
	.SC_RegFIXED_ENABLE_BUS_B(Decoder_DataWrite_Wire_B[37]),
//-------------------------------------------------------

//-------------------------------------------------------
// DECODER TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA TO DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_A
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_DataDecoder_Out(Decoder_DataWrite_Wire_A),
	.CC_DECODER_Selection_In(DecoderSelectionWrite_Out_A)
);

// DECODER TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA TO DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_B
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_DataDecoder_Out(Decoder_DataWrite_Wire_B),
	.CC_DECODER_Selection_In(DecoderSelectionWrite_Out_B)
);

// DECODER TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA TO DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_C
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_DataDecoder_Out(Decoder_DataWrite_Wire_C),
	.CC_DECODER_Selection_In(DecoderSelectionWrite_Out_C)
);
//-------------------------------------------------------

endmodule

