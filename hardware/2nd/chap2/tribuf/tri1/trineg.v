`timescale 1ns/1ns

module trineg(a, c, y);
	input  [7:0] a;
	input        c;
	output [7:0] y;
	
	assign y = (c == 1'b0) ? a : 8'bzzzzzzzz;
	
endmodule
