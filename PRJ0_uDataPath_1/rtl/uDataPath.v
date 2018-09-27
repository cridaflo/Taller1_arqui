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
module uDataPath #(parameter MIR_BUS_WIDTH = 41, parameter Direction_BUS_WIDTH = 11, parameter Decode_BUS_WIDTH = 8, parameter Selection_BUS_WIDTH = 2, parameter REG_BUS_WIDTH = 6, parameter COND_BUS_WIDTH = 3, parameter FLAGs_BUS_WIDTH = 4, parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=6, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATA_REGFIXED_INIT_0=32'h00000000, parameter DATA_REGGEN_INIT_0=32'h00000000,parameter DATA_REGPC_INIT=32'h00000800, parameter DATAWIDTH_DECODER_OUT=38, parameter DATAWIDTH_MUX_SELECTION=6, parameter DATAWIDTH_MIR_FIELD=6)(
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
	CC_MUX_REG_R1,
	ADRESS_MUX_OUT,
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
	output	CC_MUX_REG_R1;
	
	output   ADRESS_MUX_OUT;

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
	wire [DATAWIDTH_BUS-1:0] C_BUS_MUX_ALU_In;
// ARCHITECTURE BUSES WIRES - OUTPUT
	wire [DATAWIDTH_BUS-1:0] DataBUS_A_Out;
	wire [DATAWIDTH_BUS-1:0] DataBUS_B_Out;
	wire [DATAWIDTH_BUS-1:0] DataBUS_C_Out;
// MIR REGISTER
	wire [DATAWIDTH_MIR_FIELD-1:0] MIR_A_FIELD;
	wire [DATAWIDTH_MIR_FIELD-1:0] MIR_B_FIELD;
	wire [DATAWIDTH_MIR_FIELD-1:0] MIR_C_FIELD;
	wire [2:0] MIR_COND_OUT;
// MUX SELECT
	wire MUX_SELECT_A;
	wire MUX_SELECT_B;
	wire MUX_SELECT_C;
// DECODER CONTROL:  TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_A;
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_B;
	wire [DATAWIDTH_DECODER_SELECTION-1:0] MUX_TO_DECODER_C;
// JUMP WIRE
	wire [Direction_BUS_WIDTH-1:0] JUMP_TO_ADDRESS_MUX;
// MIR FLAGS
   wire [MIR_BUS_WIDTH-1:0]BUS_ROM_TO_MIR;
	wire RD_OUT;
	wire WR_OUT;
// ROM
	wire [Direction_BUS_WIDTH-1:0] ADRESS_MUX_OUT;
// CBL
   wire [Selection_BUS_WIDTH-1:0] CBL_TO_ADRESS_MUX;
	wire [Direction_BUS_WIDTH-1:0] CSAI_Direccion_OUT;
// BUS MUX
	wire [DATAWIDTH_BUS-1:0]BUS_MEM_TO_MUX;
// REGS
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R0;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R1;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R2;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R3;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R4;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R5;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R6;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R7;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R8;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R9;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R10;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R12;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R11;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R13;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R14;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R15;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R16;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R17;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R18;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R19;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R20;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R21;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R22;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R23;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R24;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R25;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R26;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R27;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R28;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R29;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R30;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R31;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R32;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R33;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R34;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R35;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R36;
	wire [DATAWIDTH_BUS-1:0] CC_MUX_REG_R37;
//=======================================================
//  Structural coding
//=======================================================

//-------------------------------------------------------
//GENERAL_REGISTERS
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r1 (
// port map - connection between master ports and signals/registers
    .SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R1),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[1]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r2 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R2),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[2]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r3 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R3),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[3]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r4 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R4),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[4]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r5 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R5),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[5]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r6 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R6),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[6]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r7 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R7),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[7]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r8 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R8),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[8]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r9 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R9),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[9]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r10 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R10),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[10]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r11 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R11),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[11]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r12 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R12),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[12]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r13 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R13),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[13]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r14 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R14),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[14]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r15 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R15),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[15]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r16 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R16),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[16]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r17 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R17),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[17]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r18 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R18),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[18]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r19 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R19),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[19]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r20 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R20),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[20]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r21 (
// port map - connection between master ports and signals/register
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R21),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[21]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r22 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R22),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[22]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r23 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R23),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[23]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r24 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R24),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[24]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r25 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R25),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[25]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r26 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R26),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[26]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r27 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R27),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[27]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r28 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R28),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[28]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r29 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R29),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[29]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r30 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R30),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[30]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_r31 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R31),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[31]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGPC_INIT)) SC_RegGENERAL_pc (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R32),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[32]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t0 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R33),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[33]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t1 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R34),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[34]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t2 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R35),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[35]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegGENERAL #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegGENERAL_t3 (
// port map - connection between master ports and signals/registers
	.SC_RegGENERAL_DataBUS_Out(CC_MUX_REG_R36),
	.SC_RegGENERAL_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegGENERAL_Reset_InHigh(uDataPath_Reset_InHigh),
	.SC_RegGENERAL_Write_InHigh(Decoder_DataWrite_Wire_C[35]),
	.SC_RegGENERAL_DataBUS_In(DataBUS_C_Out)
);
SC_RegIR #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGGEN_INIT(DATA_REGGEN_INIT_0)) SC_RegIR_ir (
// port map - connection between master ports and signals/registers
	.SC_RegIR_DataBUS_Out(CC_MUX_REG_R37),
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
	.SC_RegIR_DataBUS_In(DataBUS_C_Out)
);
//-------------------------------------------------------

//-------------------------------------------------------
// FIXED_REGISTERS
SC_RegFIXED #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATA_REGFIXED_INIT(DATA_REGFIXED_INIT_0)) SC_RegFIXED_r0 (
// port map - connection between master ports and signals/registers
	.SC_RegFIXED_DataBUS_Out(CC_MUX_REG_R0),
	.SC_RegFIXED_CLOCK_50(uDataPath_CLOCK_50),
	.SC_RegFIXED_Reset_InHigh(uDataPath_Reset_InHigh)
);

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
CC_MUX_REG #(.DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_MUX_REG_A(
	.CC_MUX_REG_TO_BUS_OUT(DataBUS_A_In),
	//////////// INPUTS //////////
	.REG_TO_MUX_R0(CC_MUX_REG_R0),
	.REG_TO_MUX_R1(CC_MUX_REG_R1),
	.REG_TO_MUX_R2(CC_MUX_REG_R2),
	.REG_TO_MUX_R3(CC_MUX_REG_R3),
	.REG_TO_MUX_R4(CC_MUX_REG_R4),
	.REG_TO_MUX_R5(CC_MUX_REG_R5),
	.REG_TO_MUX_R6(CC_MUX_REG_R6),
	.REG_TO_MUX_R7(CC_MUX_REG_R7),
	.REG_TO_MUX_R8(CC_MUX_REG_R8),
	.REG_TO_MUX_R9(CC_MUX_REG_R9),
	.REG_TO_MUX_R10(CC_MUX_REG_R10),
	.REG_TO_MUX_R11(CC_MUX_REG_R11),
	.REG_TO_MUX_R12(CC_MUX_REG_R12),
	.REG_TO_MUX_R13(CC_MUX_REG_R13),
	.REG_TO_MUX_R14(CC_MUX_REG_R14),
	.REG_TO_MUX_R15(CC_MUX_REG_R15),
	.REG_TO_MUX_R16(CC_MUX_REG_R16),
	.REG_TO_MUX_R17(CC_MUX_REG_R17),
	.REG_TO_MUX_R18(CC_MUX_REG_R18),
	.REG_TO_MUX_R19(CC_MUX_REG_R19),
	.REG_TO_MUX_R20(CC_MUX_REG_R20),
	.REG_TO_MUX_R21(CC_MUX_REG_R21),
	.REG_TO_MUX_R22(CC_MUX_REG_R22),
	.REG_TO_MUX_R23(CC_MUX_REG_R23),
	.REG_TO_MUX_R24(CC_MUX_REG_R24),
	.REG_TO_MUX_R25(CC_MUX_REG_R25),
	.REG_TO_MUX_R26(CC_MUX_REG_R26),
	.REG_TO_MUX_R27(CC_MUX_REG_R27),
	.REG_TO_MUX_R28(CC_MUX_REG_R28),
	.REG_TO_MUX_R29(CC_MUX_REG_R29),
	.REG_TO_MUX_R30(CC_MUX_REG_R30),
	.REG_TO_MUX_R31(CC_MUX_REG_R31),
	.REG_TO_MUX_R32(CC_MUX_REG_R32),
	.REG_TO_MUX_R33(CC_MUX_REG_R33),
	.REG_TO_MUX_R34(CC_MUX_REG_R34),
	.REG_TO_MUX_R35(CC_MUX_REG_R35),
	.REG_TO_MUX_R36(CC_MUX_REG_R36),
	.REG_TO_MUX_R37(CC_MUX_REG_R37),
	.CC_MUX_REG_DECOD_SELECTION(Decoder_DataWrite_Wire_A)
);
CC_MUX_REG #(.DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_MUX_REG_B(
	.CC_MUX_REG_TO_BUS_OUT(DataBUS_B_In),
	//////////// INPUTS //////////
	.REG_TO_MUX_R0(CC_MUX_REG_R0),
	.REG_TO_MUX_R1(CC_MUX_REG_R1),
	.REG_TO_MUX_R2(CC_MUX_REG_R2),
	.REG_TO_MUX_R3(CC_MUX_REG_R3),
	.REG_TO_MUX_R4(CC_MUX_REG_R4),
	.REG_TO_MUX_R5(CC_MUX_REG_R5),
	.REG_TO_MUX_R6(CC_MUX_REG_R6),
	.REG_TO_MUX_R7(CC_MUX_REG_R7),
	.REG_TO_MUX_R8(CC_MUX_REG_R8),
	.REG_TO_MUX_R9(CC_MUX_REG_R9),
	.REG_TO_MUX_R10(CC_MUX_REG_R10),
	.REG_TO_MUX_R11(CC_MUX_REG_R11),
	.REG_TO_MUX_R12(CC_MUX_REG_R12),
	.REG_TO_MUX_R13(CC_MUX_REG_R13),
	.REG_TO_MUX_R14(CC_MUX_REG_R14),
	.REG_TO_MUX_R15(CC_MUX_REG_R15),
	.REG_TO_MUX_R16(CC_MUX_REG_R16),
	.REG_TO_MUX_R17(CC_MUX_REG_R17),
	.REG_TO_MUX_R18(CC_MUX_REG_R18),
	.REG_TO_MUX_R19(CC_MUX_REG_R19),
	.REG_TO_MUX_R20(CC_MUX_REG_R20),
	.REG_TO_MUX_R21(CC_MUX_REG_R21),
	.REG_TO_MUX_R22(CC_MUX_REG_R22),
	.REG_TO_MUX_R23(CC_MUX_REG_R23),
	.REG_TO_MUX_R24(CC_MUX_REG_R24),
	.REG_TO_MUX_R25(CC_MUX_REG_R25),
	.REG_TO_MUX_R26(CC_MUX_REG_R26),
	.REG_TO_MUX_R27(CC_MUX_REG_R27),
	.REG_TO_MUX_R28(CC_MUX_REG_R28),
	.REG_TO_MUX_R29(CC_MUX_REG_R29),
	.REG_TO_MUX_R30(CC_MUX_REG_R30),
	.REG_TO_MUX_R31(CC_MUX_REG_R31),
	.REG_TO_MUX_R32(CC_MUX_REG_R32),
	.REG_TO_MUX_R33(CC_MUX_REG_R33),
	.REG_TO_MUX_R34(CC_MUX_REG_R34),
	.REG_TO_MUX_R35(CC_MUX_REG_R35),
	.REG_TO_MUX_R36(CC_MUX_REG_R36),
	.REG_TO_MUX_R37(CC_MUX_REG_R37),
	.CC_MUX_REG_DECOD_SELECTION(Decoder_DataWrite_Wire_B)
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
C_BUS_MUX #(DATAWIDTH_BUS) SC_C_BUS_MUX (
// port map - connection between master ports and signals/registers
	.IN_BUS_MEMORY(BUS_MEM_TO_MUX),
	.IN_BUS_ALU(C_BUS_MUX_ALU_In),
	.BUS_OUT(DataBUS_C_In),
	.IN_SELECT(RD_OUT)
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
	.CC_ALU_DataBUS_Out(C_BUS_MUX_ALU_In),
	.CC_ALU_DataBUSA_In(DataBUS_A_Out),
	.CC_ALU_DataBUSB_In(DataBUS_B_Out),
	.CC_ALU_Selection_In(uDataPath_ALUSelection)
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
MIR #(.MIR_BUS_WIDTH(MIR_BUS_WIDTH), .REG_BUS_WIDTH(REG_BUS_WIDTH), .ALU_BUS_WIDTH(DATAWIDTH_ALU_SELECTION), .COND_BUS_WIDTH(COND_BUS_WIDTH), .JUMP_ADDR_BUS_WIDTH(Direction_BUS_WIDTH)) SC_MIR (
// port map - connection between master ports and signals/registers
	.MIR_CLOCK_50(uDataPath_CLOCK_50),
	.MIR_Microinstruccion_IN(BUS_ROM_TO_MIR),
	.SC_RegMIR_Reset_InHigh(uDataPath_Reset_InHigh),
	.MIR_A_OUT(MIR_A_FIELD),
	.MIR_AMUX_OUT(MUX_SELECT_A),
	.MIR_B_OUT(MIR_B_FIELD),
	.MIR_BMUX_OUT(MUX_SELECT_B),
	.MIR_C_OUT(MUX_SELECT_C),
	.MIR_CMUX_OUT(MUX_SELECT_C),
	.MIR_RD_OUT(RD_OUT),
	.MIR_WR_OUT(WR_OUT),
	.MIR_ALU_OUT(uDataPath_ALUSelection),
	.MIR_COND_OUT(MIR_COND_OUT),
	.MIR_JUMP_ADDR_OUT(JUMP_TO_ADDRESS_MUX)

);
//-------------------------------------------------------

//-------------------------------------------------------
//ROM
ROM #(.DATA_BUS_IN(Direction_BUS_WIDTH), .DATA_BUS_OUT(MIR_BUS_WIDTH)) SC_ROM(
// port map - connection between master ports and signals/registers
	.BUS_IN(ADRESS_MUX_OUT),
	.BUS_OUT(BUS_ROM_TO_MIR)
);
//-------------------------------------------------------

//-------------------------------------------------------
// CS_ADDRESS_MUS
CS_Address_MUX #(.Direction_BUS_WIDTH(Direction_BUS_WIDTH), .Decode_BUS_WIDTH(Decode_BUS_WIDTH), .Selection_BUS_WIDTH(Selection_BUS_WIDTH)) SC_ADDRESS_MUX (
	//////////// INPUTS //////////
	.CS_Addres_MUX_Next_IN(CSAI_Direccion_OUT),
	.CS_Addres_MUX_Jump_IN(JUMP_TO_ADDRESS_MUX),
	.CS_Addres_MUX_Decode_IN({RegIR_OP,RegIR_OP3}),
	.CS_Addres_MUX_Selection_IN(CBL_TO_ADRESS_MUX),
	//////////// OUTPUTS //////////
   .CS_Addres_MUX_Direccion_OUT(ADRESS_MUX_OUT)
);
//-------------------------------------------------------

//-------------------------------------------------------
// CSAI
CSAI #(.Direction_BUS_WIDTH(Direction_BUS_WIDTH)) SC_CSAI (
	//////////// INPUTS //////////
   .CSAI_CLOCK_50_ACK(uDataPath_CLOCK_50),
	.CSAI_Direccion_IN(ADRESS_MUX_OUT),
	//////////// OUTPUTS //////////
   .CSAI_Direccion_OUT(CSAI_Direccion_OUT)
);
//-------------------------------------------------------

//-------------------------------------------------------
// CBL
CBL #(.FLAGs_BUS_WIDTH(FLAGs_BUS_WIDTH), .Cond_BUS_WIDTH(COND_BUS_WIDTH)) SC_CBL (
   //////////// CLOCK //////////
	//////////// INPUTS //////////
	.CBL_IR13_IN(RegIR_BIT13),
	.CBL_FLAGs_IN({PSR_Negative_InHigh,PSR_Zero_InHigh,PSR_Overflow_InHigh,PSR_Carry_InHigh}),
	.CBL_Cond_IN(MIR_COND_OUT),
	//////////// OUTPUTS //////////
   .CBL_MUX_OUT(CBL_TO_ADRESS_MUX)
);
//-------------------------------------------------------

//-------------------------------------------------------
// MEMORY
programMem #(.DATAWIDTH_BUS(DATAWIDTH_BUS)) PROGRAM_MEM(
// ------------- Inputs ---------------
   .BusDirecciones(DataBUS_A_Out),
	.RD(RD_OUT),
	.WR(WR_OUT),
// ------------ Outputs ---------------

	.BusDatos(BUS_MEM_TO_MUX)
);
endmodule
