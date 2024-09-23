`timescale 1ns/1ns

module cnt8(clk, rst, ld, d, ci, co, q);
	input        clk, rst, ld;
	input  [7:0] d;
	input        ci;
	output       co;
	output [7:0] q;
	reg    [7:0] q;
	
	always@(posedge clk) begin
		if(rst == 1'b0) begin
			q <= 8'b00000000;
		end else if(ld == 1'b1) begin
			q <= d;
		end else begin
			q <= q + ci;
		end
	end
	
	assign co = &{q, ci};
	
endmodule
