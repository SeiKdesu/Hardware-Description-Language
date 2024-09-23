`timescale 1ns/1ns

module reg8(clk, rst, d, q);
	input        clk, rst;
	input  [7:0] d;
	output [7:0] q;
	reg    [7:0] q;
	
	always@(posedge clk) begin
		if(rst == 1'b0) begin
			q <= 8'b00000000;
		end else begin
			q <= d;
		end
	end
	
endmodule
