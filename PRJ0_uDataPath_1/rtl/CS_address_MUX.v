//=======================================================
//  MODULE Definition
//=======================================================
module CS_Address_MUX #(parameter Direction_BUS_WIDTH = 11, parameter Decode_BUS_WIDTH = 8, parameter Selection_BUS_WIDTH = 2)(
	//////////// INPUTS //////////
	CS_Addres_MUX_Next_IN,
	CS_Addres_MUX_Jump_IN,
	CS_Addres_MUX_Decode_IN,
	CS_Addres_MUX_Selection_IN,
	//////////// OUTPUTS //////////
   CS_Addres_MUX_Direccion_OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
   output reg [Direction_BUS_WIDTH-1:0]CS_Addres_MUX_Direccion_OUT;
	input [Direction_BUS_WIDTH-1:0]CS_Addres_MUX_Next_IN;
	input [Direction_BUS_WIDTH-1:0]CS_Addres_MUX_Jump_IN;
	input [Decode_BUS_WIDTH-1:0]CS_Addres_MUX_Decode_IN;
	input [Selection_BUS_WIDTH-1:0]CS_Addres_MUX_Selection_IN;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
always@(*)
	begin
	   case (CS_Addres_MUX_Selection_IN)
	   2'b00: CS_Addres_MUX_Direccion_OUT = CS_Addres_MUX_Next_IN; 
		2'b01: CS_Addres_MUX_Direccion_OUT = CS_Addres_MUX_Jump_IN; 
		2'b10: begin
		       CS_Addres_MUX_Direccion_OUT[Direction_BUS_WIDTH-1] = 1'b1;
             CS_Addres_MUX_Direccion_OUT[Decode_BUS_WIDTH+1:2] = CS_Addres_MUX_Decode_IN;
				 CS_Addres_MUX_Direccion_OUT[1:0] = 2'b00;
				 end
	   default: CS_Addres_MUX_Direccion_OUT = CS_Addres_MUX_Next_IN; 
		endcase
	end
endmodule
