//=======================================================
//  MODULE Definition
//=======================================================
module CBL #(parameter FLAGs_BUS_WIDTH = 4, parameter Cond_BUS_WIDTH = 3)(
   //////////// CLOCK //////////
	//////////// INPUTS //////////
	CBL_IR13_IN,
	CBL_FLAGs_IN,
	CBL_Cond_IN,
	//////////// OUTPUTS //////////
   CBL_MUX_OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================
    parameter [1:0]Next = 2'b00;
	 parameter [1:0]Jump = 2'b01;
	 parameter [1:0]Decode = 2'b10;
//=======================================================
//  PORT declarations
//=======================================================
   output reg [1:0]CBL_MUX_OUT;
	input [FLAGs_BUS_WIDTH-1:0]CBL_FLAGs_IN;
	input [Cond_BUS_WIDTH-1:0]CBL_Cond_IN;
	input CBL_IR13_IN;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
always@(*)
	begin
	   case (CBL_Cond_IN)
		3'b000: CBL_MUX_OUT = Next;
		3'b001: if(CBL_FLAGs_IN[0] == 1'b1) CBL_MUX_OUT = Jump;
		        else CBL_MUX_OUT = Next;
		3'b010: if(CBL_FLAGs_IN[1] == 1'b1) CBL_MUX_OUT = Jump;
		        else CBL_MUX_OUT = Next;
		3'b011: if(CBL_FLAGs_IN[2] == 1'b1) CBL_MUX_OUT = Jump;
		        else CBL_MUX_OUT = Next;
		3'b100: if(CBL_FLAGs_IN[3] == 1'b1) CBL_MUX_OUT = Jump;
		        else CBL_MUX_OUT = Next;
		3'b101: if(CBL_IR13_IN == 1'b1) CBL_MUX_OUT = Jump;
		        else CBL_MUX_OUT = Next;
		3'b110: CBL_MUX_OUT = Jump;
		3'b111: CBL_MUX_OUT = Decode;
	   default: CBL_MUX_OUT = Next; 
		endcase
	end
endmodule
