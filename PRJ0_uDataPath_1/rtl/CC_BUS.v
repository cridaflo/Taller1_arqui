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
module CC_BUS #(parameter DATAWIDTH_BUS=32)(
	//////////// OUTPUTS //////////
	CC_BUS_DataBUS_Out,
	//////////// INPUTS //////////
	CC_BUS_DataBUS_In_REG,
	CC_MUX_DataBUS_SELECT
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output reg	[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_Out;
	input			[DATAWIDTH_BUS-1:0] CC_BUS_DataBUS_In_REG;
	input			CC_MUX_DataBUS_SELECT;	
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(*)
	begin
	case (CC_MUX_DataBUS_SELECT)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		1'b1: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_0;
		1'b0: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_1;
		default :   CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_0; // channel 0 is selected 
		endcase
	end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule

