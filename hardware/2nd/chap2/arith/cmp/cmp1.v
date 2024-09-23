`timescale 1ns/1ns

module cmp1(a, b, gt, lt, eq);
	input  [7:0] a, b;
	output       gt, lt, eq;
	reg          gt, lt, eq;
	
	always@(a or b) begin
		gt <= 1'b0;
		lt <= 1'b0;
		eq <= 1'b0;
		if(a > b) begin
			gt <= 1'b1;
		end else if(a < b) begin
			lt <= 1'b1;
		end else begin
			eq <= 1'b1;
		end
	end
	
endmodule
