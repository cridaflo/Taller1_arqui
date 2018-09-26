module C_BUS_MUX #(parameter BUS_WITH = 32)(
IN_BUS_MEMORY,
 IN_BUS_ALU,
 BUS_OUT,
 IN_SELECT
 );

//=======================================================
//  PORT declarations
//=======================================================
	input [BUS_WITH-1:0] IN_BUS_MEMORY ;
	input [BUS_WITH-1:0] IN_BUS_ALU;
	input IN_SELECT;
	output reg [BUS_WITH-1:0] BUS_OUT ;

	//=======================================================
	//  Structural coding
	//=======================================================
	//INPUT LOGIC: COMBINATIONAL

	always @(*) begin
		if (IN_SELECT == 1)
			BUS_OUT = IN_BUS_MEMORY;
		else
			BUS_OUT = IN_BUS_ALU;			
	end 
endmodule