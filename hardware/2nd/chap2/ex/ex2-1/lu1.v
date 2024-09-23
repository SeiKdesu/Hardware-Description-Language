`timescale 1ns/1ns

`define AND 2'b00
`define OR  2'b01
`define XOR 2'b10
`define NOR 2'b11

module lu1(y, a, b, op);
	input  [7:0] a, b;
	input  [1:0] op;
	output [7:0] y;
	reg    [7:0] y;
	
	always@(a or b or op) begin
		case(op)
			`AND    : y <= a & b;
			`OR     : y <= a | b;
			`XOR    : y <= a ^ b;
			`NOR    : y <= a ~| b;
			default : y <= 8'bxxxxxxxx;
		endcase
	end
	
endmodule
