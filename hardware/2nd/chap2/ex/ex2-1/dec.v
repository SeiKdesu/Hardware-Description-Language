`timescale 1ns/1ns

module dec(a, y);
	input  [1:0] a;
	output [3:0] y;
	reg    [3:0] y;
	
	always@(a) begin
		case(a)
			2'b00 :  y <= 4'b0001;
			2'b01 :  y <= 4'b0010;
			2'b10 :  y <= 4'b0100;
			2'b11 :  y <= 4'b1000;
			default: y <= 4'bxxxx;
		endcase
	end
	
endmodule
