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
module SC_RegIR #(parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	SC_RegIR_DataBUS_Out,
	SC_RegIR_OP,
	SC_RegIR_RD,
	SC_RegIR_OP2,
	SC_RegIR_OP3,
	SC_RegIR_RS1,
	SC_RegIR_BIT13,
	SC_RegIR_RS2,
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
	output reg	[DATAWIDTH_BUS-1:0] SC_RegIR_DataBUS_Out;
	output 	[1:0] SC_RegIR_OP;
	output 	[4:0] SC_RegIR_RD;
	output 	[2:0] SC_RegIR_OP2;
	output 	[5:0] SC_RegIR_OP3;
	output 	[4:0] SC_RegIR_RS1;
	output  SC_RegIR_BIT13;
	output 	[4:0] SC_RegIR_RS2;
	input			SC_RegIR_CLOCK_50;
	input			SC_RegIR_Reset_InHigh;
	input			SC_RegIR_Write_InHigh;
	input 		[DATAWIDTH_BUS-1:0] SC_RegIR_DataBUS_In;
//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [DATAWIDTH_BUS-1:0] RegGENERAL_Register;
	reg [DATAWIDTH_BUS-1:0] RegGENERAL_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always @ (*)
	if (SC_RegIR_Write_InHigh == 1)	
		RegGENERAL_Signal = SC_RegIR_DataBUS_In;
	else 	
		RegGENERAL_Signal = RegGENERAL_Register;

// REGISTER : SEQUENTIAL
	always @ ( negedge SC_RegIR_CLOCK_50 , posedge SC_RegIR_Reset_InHigh)
	if (SC_RegIR_Reset_InHigh==1)
		RegGENERAL_Register <= 0;
	else
		RegGENERAL_Register <= RegGENERAL_Signal;
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
	always @ (*)
		SC_RegIR_DataBUS_Out = RegGENERAL_Register; 
	
assign SC_RegIR_OP= SC_RegIR_DataBUS_Out[31:30];
assign SC_RegIR_RD= SC_RegIR_DataBUS_Out[29:25];
assign SC_RegIR_OP2=	SC_RegIR_DataBUS_Out[24:22];
assign SC_RegIR_OP3=	SC_RegIR_DataBUS_Out[24:19];
assign SC_RegIR_RS1=	SC_RegIR_DataBUS_Out[18:14];
assign SC_RegIR_BIT13=	SC_RegIR_DataBUS_Out[13];
assign SC_RegIR_RS2=	SC_RegIR_DataBUS_Out[4:0];	

endmodule

