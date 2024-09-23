`timescale 1ns/1ns

module mux4(a, b, c, d, s, y);
	input  [7:0] a, b, c, d;
	input  [1:0] s;
	output [7:0] y;
	reg    [7:0] y;
	
	always@(a or b or c or d or s) begin
		case(s)
			2'b00:   y <= a;
			2'b01:   y <= b;
			2'b10:   y <= c;
			2'b11:   y <= d;
			default: y <= 8'bxxxxxxxx;
		endcase
	end
	
endmodule
