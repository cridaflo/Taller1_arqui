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
always@(negedge CSAI_CLOCK_50_ACK)
	assign CSAI_Direccion_OUT = CSAI_Direccion_IN + 1;
endmodule
