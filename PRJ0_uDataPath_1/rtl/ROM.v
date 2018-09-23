//=======================================================
//  MODULE Definition
//=======================================================
module uControl #(parameter MIR_BUS_WIDTH = 41, parameter Direction_BUS_WIDTH = 11)(
	//////////// CLOCK //////////

	//////////// INPUTS //////////
   ROM_Direccion_IN
	//////////// OUTPUTS //////////
   ROM_Microinstruccion_OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================
   output [MIR_BUS_WIDTH-1:0]ROM_Microinstruccion_OUT;
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
always@(*)
   assign ROM_Microinstruccion_OUT = 52483572515;
endmodule
