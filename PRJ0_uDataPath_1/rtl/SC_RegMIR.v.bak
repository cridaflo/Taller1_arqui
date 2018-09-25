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
module SC_RegIR #(parameter DATAWIDTH_BUS_OUT=41, parameter DATA_REGGEN_INIT=41'h00000000)(
	//////////// OUTPUTS //////////
	A,
	AMUX,
	B,
	BMUX,
	C,
	CMUX
	RD,
	WR,
	ALU,
	COND,
	JMP_ADDR,
	//////////// INPUTS //////////
	SC_RegIR_CLOCK_50,
	SC_RegIR_Reset_InHigh,
	SC_RegIR_Write_InHigh,
	SC_RegIR_DataBUS_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output [5:0] A;
	output AMUX;
	output [5:0] B;
	output BMUX;
	output [5:0] C;
	output CMUX;
	output RD;
	output WR;
	output [3:0] ALU;
	output [2:0] COND;
	output [10:0] JMP_ADDR
	input	      SC_RegIR_CLOCK_50;
	input			SC_RegIR_Reset_InHigh;
	input			SC_RegIR_Write_InHigh;
	input 		[DATAWIDTH_BUS-1:0] SC_RegIR_DataBUS_In;
//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [DATAWIDTH_BUS-1:0] RegIR_Register;
	reg [DATAWIDTH_BUS-1:0] RegIR_Signal;
	reg [DATAWIDTH_BUS-1:0] SC_RegIR_DataBUS_Out;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always @ (*)
	if (SC_RegIR_Write_InHigh == 1)	
		RegIR_Signal = SC_RegIR_DataBUS_In;
	else 	
		RegIR_Signal = RegIR_Register;

// REGISTER : SEQUENTIAL
	always @ ( negedge SC_RegIR_CLOCK_50 , posedge SC_RegIR_Reset_InHigh)
	if (SC_RegIR_Reset_InHigh==1)
		RegIR_Register <= DATA_REGGEN_INIT;
	else
		RegIR_Register <= RegIR_Signal;
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
	always @ (*)
		SC_RegIR_DataBUS_Out = RegIR_Register; 
	
assign A    =  SC_RegIR_DataBUS_Out[40:35];
assign AMUX =  SC_RegIR_DataBUS_Out[34];
assign B    =	SC_RegIR_DataBUS_Out[33:28];
assign BMUX =	SC_RegIR_DataBUS_Out[27];
assign C    =	SC_RegIR_DataBUS_Out[26:21];
assign CMUX =	SC_RegIR_DataBUS_Out[20];
assign RD   =	SC_RegIR_DataBUS_Out[19];	
assign WR   =  SC_RegIR_DataBUS_Out[18];	
assign ALU  =	SC_RegIR_DataBUS_Out[17:14];
assign COND =	SC_RegIR_DataBUS_Out[13:11];
assign JMP_ADDR   =	SC_RegIR_DataBUS_Out[10:0];

endmodule
