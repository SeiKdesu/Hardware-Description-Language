`timescale 1ns/1ns

`define ADDU 2'b00
`define ADDS 2'b01
`define SUBU 2'b10
`define SUBS 2'b11

module au(a, b, op, y, ov, gt, lt, eq);
	input  [2:0] a, b;
	input  [1:0] op;
	output [2:0] y;
	output ov, gt, lt, eq;
	reg    [2:0] y;
	reg          co;
	
	/* write answer below */

	/* write ansower above */
	
endmodule
