`timescale 1ns/1ns

module cmp3(a, b, gt, lt, eq);
	input  [7:0] a, b;
	output       gt, lt, eq;
	reg          gt, lt, eq;
	
	always@(a or b) begin : grater_than
		if(a > b) begin
			gt <= 1'b1;
		end else begin
			gt <= 1'b0;
		end
	end

	always@(a or b) begin : less_than
		if(a < b) begin
			lt <= 1'b1;
		end else begin
			lt <= 1'b0;
		end
	end

	always@(a or b) begin : equal
		if(a == b) begin
			eq <= 1'b1;
		end else begin
			eq <= 1'b0;
		end
	end
	
endmodule
