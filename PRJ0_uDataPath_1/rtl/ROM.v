//=======================================================
//  MODULE Definition
//=======================================================
module ROM #(parameter MIR_BUS_WIDTH = 41, parameter Direction_BUS_WIDTH = 11)(
	//////////// CLOCK //////////

	//////////// INPUTS //////////
   ROM_Direccion_IN,
	//////////// OUTPUTS //////////
   ROM_Microinstruccion_OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================
   output reg [MIR_BUS_WIDTH-1:0]ROM_Microinstruccion_OUT;
	input [Direction_BUS_WIDTH-1:0]ROM_Direccion_IN;
//=======================================================
//  PORT declarations
//=======================================================

//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
initial ROM_Microinstruccion_OUT = 41'b10010100000000000000100101001111111111111;
always@(*)
   ROM_Microinstruccion_OUT = 41'b10010100000000000000100101001111111111111;
endmodule
