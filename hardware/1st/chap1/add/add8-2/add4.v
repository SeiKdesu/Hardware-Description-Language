`timescale 1ns/1ns

module add4(a, b, ci, co, s); /* define module */
	input  [3:0] a, b;        /* input port (4bit) */
	input        ci;          /* input port (1bit) */
	output       co;          /* output port (1bit) */
	output [3:0] s;           /* output port (4bit) */
	wire   [2:0] w;           /* wire (3bit) */
	
	/* connect pre-defined module */
	full_add fa0(.a(a[0]), .b(b[0]), .ci(ci),   .co(w[0]), .s(s[0]));
	full_add fa1(.a(a[1]), .b(b[1]), .ci(w[0]), .co(w[1]), .s(s[1]));
	full_add fa2(.a(a[2]), .b(b[2]), .ci(w[1]), .co(w[2]), .s(s[2]));
	full_add fa3(.a(a[3]), .b(b[3]), .ci(w[2]), .co(co),   .s(s[3]));
	
endmodule
