`timescale 1ns/1ns

module enc1(a, y);
	input  [3:0] a;
	output [2:0] y;
	reg    [2:0] y;
	
	always@(a) begin
		case(a)
			4'b0001, 4'b0011, 4'b0101, 4'b0111,
			4'b1001, 4'b1011, 4'b1101, 4'b1111:
				y <= 3'b100;
			4'b0010, 4'b0110, 4'b1010, 4'b1110:
				y <= 3'b101;
			4'b0100, 4'b1100:
				y <= 3'b110;
			4'b1000:
				y <= 3'b111;
			default:
				y <= 3'b000;
		endcase
	end
	
endmodule
