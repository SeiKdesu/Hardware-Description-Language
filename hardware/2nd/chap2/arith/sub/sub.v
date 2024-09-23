`timescale 1ns/1ns

module sub(a, b, ci, co, y);
	input  [7:0] a, b;
	input        ci;
	output       co;
	output [7:0] y;
	reg          co;
	reg    [7:0] y;
	
	always@( a or b or ci ) begin
		{co, y} <= a - b - ci;
	end
	
endmodule
