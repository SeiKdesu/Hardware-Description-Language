`timescale 1ns/1ns

module trisel(a, b, c, y);
	input  [7:0] a, b;
	input        c;
	output [7:0] y;
	
	assign y = (c == 1'b0) ? a : 8'bzzzzzzzz;
	assign y = (c == 1'b1) ? b : 8'bzzzzzzzz;
	
endmodule
