`timescale 1ns/1ns

module enc2(a, y);
	input  [3:0] a;
	output [2:0] y;
	reg    [2:0] y;
	
	always@(a) begin
		casex(a)
			4'b???1: y <= 3'b100;
			4'b??10: y <= 3'b101;
			4'b?100: y <= 3'b110;
			4'b1000: y <= 3'b111;
			default: y <= 3'b000;
		endcase
	end
	
endmodule
