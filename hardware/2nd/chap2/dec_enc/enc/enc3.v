`timescale 1ns/1ns

module enc3(a, y);
	input  [3:0] a;
	output [2:0] y;
	reg    [2:0] y;
	
	always@(a) begin
		if(a[0] == 1'b1) begin
			y <= 3'b100;
		end else if(a[1] == 1'b1) begin
			y <= 3'b101;
		end else if(a[2] == 1'b1) begin
			y <= 3'b110;
		end else if(a[3] == 1'b1) begin
			y <= 3'b111;
		end else begin
			y <= 3'b000;
		end
	end
	
endmodule
