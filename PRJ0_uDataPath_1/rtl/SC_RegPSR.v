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
module SC_RegPSR #(parameter DATAWIDTH_BUS=32, parameter DATA_REGGEN_INIT=32'h00000000)(
	//////////// OUTPUTS //////////
	PSR_Negative_InHigh,
	PSR_Zero_InHigh,
	PSR_Overflow_InHigh,
	PSR_Carry_InHigh,
	//////////// INPUTS //////////
	SC_RegPSR_CLOCK_50,
	SC_RegPSR_Reset_InHigh,
	SC_RegPSR_Write_InHigh,
	uDataPath_Negative_InHigh,
	uDataPath_Zero_InHigh,
	uDataPath_Overflow_InHigh,
	uDataPath_Carry_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output PSR_Negative_InHigh;
	output PSR_Zero_InHigh;
	output PSR_Overflow_InHigh;
	output PSR_Carry_InHigh;
	input			SC_RegPSR_CLOCK_50;
	input			SC_RegPSR_Reset_InHigh;
	input			SC_RegPSR_Write_InHigh;
	input			uDataPath_Negative_InHigh;
	input			uDataPath_Zero_InHigh;
	input			uDataPath_Overflow_InHigh;
	input			uDataPath_Carry_InHigh;
//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [DATAWIDTH_BUS-1:0] RegPSR_Register;
	reg [DATAWIDTH_BUS-1:0] RegPSR_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always @ (*)
	if (SC_RegPSR_Write_InHigh == 1)	
		RegPSR_Signal = {8'b0, uDataPath_Negative_InHigh, uDataPath_Zero_InHigh, uDataPath_Overflow_InHigh,uDataPath_Carry_InHigh ,20'b0};
	else 	
		RegPSR_Signal = RegPSR_Register;

// REGISTER : SEQUENTIAL
	always @ ( negedge SC_RegPSR_CLOCK_50 , posedge SC_RegPSR_Reset_InHigh)
	if (SC_RegPSR_Reset_InHigh==1)
		RegPSR_Register <= DATA_REGGEN_INIT;
	else
		RegPSR_Register <= RegPSR_Signal;
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
// OUTPUT GENERAL- ONLY USED WITH R1
	assign PSR_Negative_InHigh =RegPSR_Register[23];
	assign PSR_Zero_InHigh =RegPSR_Register[22];
	assign PSR_Overflow_InHigh =RegPSR_Register[21];
	assign PSR_Carry_InHigh =RegPSR_Register[20];
endmodule

