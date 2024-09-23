`timescale 1ns/1ns

module andl(a, b, y);
	input  [7:0] a, b;
	output [7:0] y;
	
	assign	y = a & b;
	
endmodule
