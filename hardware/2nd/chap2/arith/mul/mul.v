`timescale 1ns/1ns

module mul(a, b, y);
	input  [ 7:0] a, b;
	output [15:0] y;
	reg    [15:0] y;
	
	always@( a or b ) begin
		y <= a * b;
	end
	
endmodule
