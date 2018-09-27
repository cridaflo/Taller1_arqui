//=======================================================
//  MODULE Definition
//=======================================================
module MIR #(parameter MIR_BUS_WIDTH = 41, parameter REG_BUS_WIDTH = 6, parameter ALU_BUS_WIDTH = 4, parameter COND_BUS_WIDTH = 3, parameter JUMP_ADDR_BUS_WIDTH = 11)(
   //////////// CLOCK //////////
	MIR_CLOCK_50,
	//////////// INPUTS //////////
	MIR_Microinstruccion_IN,
	SC_RegMIR_Reset_InHigh,
	//////////// OUTPUTS //////////
	MIR_A_OUT,
	MIR_AMUX_OUT,
	MIR_B_OUT,
	MIR_BMUX_OUT,
	MIR_C_OUT,
	MIR_CMUX_OUT,
	MIR_RD_OUT,
	MIR_WR_OUT,
	MIR_ALU_OUT,
	MIR_COND_OUT,
	MIR_JUMP_ADDR_OUT
	
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
   output reg [REG_BUS_WIDTH-1:0] MIR_A_OUT;
	output reg [REG_BUS_WIDTH-1:0] MIR_B_OUT;
	output reg [REG_BUS_WIDTH-1:0] MIR_C_OUT;
	output reg MIR_AMUX_OUT;
	output reg MIR_BMUX_OUT;
	output reg MIR_CMUX_OUT;
	output reg MIR_RD_OUT;
	output reg MIR_WR_OUT;
	output reg [ALU_BUS_WIDTH-1:0] MIR_ALU_OUT;
	output reg [COND_BUS_WIDTH-1:0] MIR_COND_OUT;
	output reg [JUMP_ADDR_BUS_WIDTH-1:0] MIR_JUMP_ADDR_OUT;
	input [MIR_BUS_WIDTH-1:0]MIR_Microinstruccion_IN;
	input MIR_CLOCK_50;
	input SC_RegMIR_Reset_InHigh;
//=======================================================
//  REG/WIRE declarations
//=======================================================
   reg [MIR_BUS_WIDTH-1:0] ceros; 
//=======================================================
//  Structural coding
//=======================================================
initial ceros = 0;
always@(negedge MIR_CLOCK_50)
begin
	if (SC_RegMIR_Reset_InHigh==1)
			begin
		MIR_JUMP_ADDR_OUT = ceros[JUMP_ADDR_BUS_WIDTH-1:0];
		MIR_COND_OUT = ceros[COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH-1:JUMP_ADDR_BUS_WIDTH];
		MIR_ALU_OUT = ceros[ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH-1:COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_WR_OUT = ceros[ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_RD_OUT = ceros[1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_CMUX_OUT = ceros[1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_C_OUT = ceros[REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH-1:1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_BMUX_OUT = ceros[REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_B_OUT = ceros[REG_BUS_WIDTH+1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH-1:1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_AMUX_OUT = ceros[REG_BUS_WIDTH+1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_A_OUT = ceros[MIR_BUS_WIDTH-1:1+REG_BUS_WIDTH+1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
			end
	else
			begin 
		MIR_JUMP_ADDR_OUT = MIR_Microinstruccion_IN[JUMP_ADDR_BUS_WIDTH-1:0];
		MIR_COND_OUT = MIR_Microinstruccion_IN[COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH-1:JUMP_ADDR_BUS_WIDTH];
		MIR_ALU_OUT = MIR_Microinstruccion_IN[ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH-1:COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_WR_OUT = MIR_Microinstruccion_IN[ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_RD_OUT = MIR_Microinstruccion_IN[1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_CMUX_OUT = MIR_Microinstruccion_IN[1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_C_OUT = MIR_Microinstruccion_IN[26:21];
		MIR_BMUX_OUT = MIR_Microinstruccion_IN[REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_B_OUT = MIR_Microinstruccion_IN[REG_BUS_WIDTH+1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH-1:1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_AMUX_OUT = MIR_Microinstruccion_IN[REG_BUS_WIDTH+1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
		MIR_A_OUT = MIR_Microinstruccion_IN[MIR_BUS_WIDTH-1:1+REG_BUS_WIDTH+1+REG_BUS_WIDTH+1+1+1+ALU_BUS_WIDTH+COND_BUS_WIDTH+JUMP_ADDR_BUS_WIDTH];
			end
end
endmodule
