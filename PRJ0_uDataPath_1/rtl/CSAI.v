//=======================================================
//  MODULE Definition
//=======================================================
module CSAI #(parameter Direction_BUS_WIDTH = 11)(
	//////////// INPUTS //////////
   CSAI_CLOCK_50_ACK,
	CSAI_Direccion_IN,
	//////////// OUTPUTS //////////
   CSAI_Direccion_OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
   output reg [Direction_BUS_WIDTH-1:0]CSAI_Direccion_OUT;
	input [Direction_BUS_WIDTH-1:0]CSAI_Direccion_IN;
	input CSAI_CLOCK_50_ACK;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
initial CSAI_Direccion_OUT = 8'b00000000;
always@(negedge CSAI_CLOCK_50_ACK)
	CSAI_Direccion_OUT = CSAI_Direccion_IN + 1'b1;
endmodule
