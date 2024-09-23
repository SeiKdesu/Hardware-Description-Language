`timescale 1ns/1ns

module mux2(a, b, s, y);
	input  [7:0] a, b;
	input        s;
	output [7:0] y;
	reg    [7:0] y;
	
	always@(a or b or s) begin
		if(s == 1'b0) begin
			y <= a;
		end else begin
			y <= b;
		end
	end
	
endmodule
