//=======================================================
//  MODULE Definition
//=======================================================
module uControl(
	//////////// CLOCK //////////
	uControl_CLOCK_50,
	//////////// INPUTS //////////
   uControl_FLAGs_IN,
	uControl_IR13_IN,
	uControl_Decode_IN,
	//////////// OUTPUTS //////////
   uControl_A_OUT,
	uControl_AMUX_OUT,
	uControl_B_OUT,
	uControl_BMUX_OUT,
	uControl_C_OUT,
	uControl_CMUX_OUT,
	uControl_RD_OUT,
	uControl_WR_OUT,
	uControl_ALU_OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================
   parameter Direction_BUS_WIDTH = 11;
	parameter Decode_BUS_WIDTH = 8;
	parameter Selection_BUS_WIDTH = 2;
	parameter MIR_BUS_WIDTH = 41;
	parameter REG_BUS_WIDTH = 6;
	parameter ALU_BUS_WIDTH = 4;
	parameter COND_BUS_WIDTH = 3;
	parameter FLAGs_BUS_WIDTH = 4;
//=======================================================
//  PORT declarations
//=======================================================
   output [REG_BUS_WIDTH-1:0]uControl_A_OUT;
	output uControl_AMUX_OUT;
	output [REG_BUS_WIDTH-1:0]uControl_B_OUT;
	output uControl_BMUX_OUT;
	output [REG_BUS_WIDTH-1:0]uControl_C_OUT;
	output uControl_CMUX_OUT;
	output uControl_RD_OUT;
	output uControl_WR_OUT;
	output [ALU_BUS_WIDTH-1:0]uControl_ALU_OUT;
	input [Decode_BUS_WIDTH-1:0]uControl_Decode_IN;
   input [FLAGs_BUS_WIDTH-1:0]uControl_FLAGs_IN;
	input uControl_CLOCK_50;
	input uControl_IR13_IN;
//=======================================================
//  REG/WIRE declarations
//=======================================================
   wire [MIR_BUS_WIDTH-1:0]uControl_MIR;
   wire [Direction_BUS_WIDTH-1:0]uControl_Direccion, uControl_Direccion_Next, uControl_JUMP_ADDR;
	wire [COND_BUS_WIDTH-1:0]uControl_COND;
	wire [Selection_BUS_WIDTH-1:0]uControl_CBL;
//=======================================================
//  Structural coding
//=======================================================

CSAI #(.Direction_BUS_WIDTH(Direction_BUS_WIDTH)) CSAI_0 (
   .CSAI_CLOCK_50_ACK(uControl_CLOCK_50),
	.CSAI_Direccion_IN(uControl_Direccion),
   .CSAI_Direccion_OUT(uControl_Direccion_Next)
);
CS_Address_MUX #(.Direction_BUS_WIDTH(Direction_BUS_WIDTH), .Decode_BUS_WIDTH(Decode_BUS_WIDTH), .Selection_BUS_WIDTH(Selection_BUS_WIDTH)) CS_Address_MUX_0 (
	.CS_Addres_MUX_Next_IN(uControl_Direccion_Next),
	.CS_Addres_MUX_Jump_IN(uControl_JUMP_ADDR),
	.CS_Addres_MUX_Decode_IN(uControl_Decode_IN),
	.CS_Addres_MUX_Selection_IN(uControl_CBL),
   .CS_Addres_MUX_Direccion_OUT(uControl_Direccion)  	 
);
ROM #(.MIR_BUS_WIDTH(MIR_BUS_WIDTH), .Direction_BUS_WIDTH(Direction_BUS_WIDTH)) ROM_0(
   .ROM_Direccion_IN(uControl_Direccion),
	.ROM_Microinstruccion_OUT(uControl_MIR)
);
MIR #(.MIR_BUS_WIDTH(MIR_BUS_WIDTH), .REG_BUS_WIDTH(REG_BUS_WIDTH), .ALU_BUS_WIDTH(ALU_BUS_WIDTH), .COND_BUS_WIDTH(COND_BUS_WIDTH), .JUMP_ADDR_BUS_WIDTH(Direction_BUS_WIDTH)) MIR_0(
	.MIR_CLOCK_50(uControl_CLOCK_50),
	.MIR_Microinstruccion_IN(uControl_MIR),
	.MIR_A_OUT(uControl_A_OUT),
	.MIR_AMUX_OUT(uControl_AMUX_OUT),
	.MIR_B_OUT(uControl_B_OUT),
	.MIR_BMUX_OUT(uControl_BMUX_OUT),
	.MIR_C_OUT(uControl_C_OUT),
	.MIR_CMUX_OUT(uControl_CMUX_OUT),
	.MIR_RD_OUT(uControl_RD_OUT),
	.MIR_WR_OUT(uControl_WR_OUT),
	.MIR_ALU_OUT(uControl_ALU_OUT),
	.MIR_COND_OUT(uControl_COND),
	.MIR_JUMP_ADDR_OUT(uControl_JUMP_ADDR)
);
CBL #(.FLAGs_BUS_WIDTH(FLAGs_BUS_WIDTH), .Cond_BUS_WIDTH(COND_BUS_WIDTH)) CBL_0(
	.CBL_IR13_IN(uControl_IR13_IN),
	.CBL_FLAGs_IN(uControl_FLAGs_IN),
	.CBL_Cond_IN(uControl_COND),
   .CBL_MUX_OUT(uControl_CBL)
);
endmodule

