`timescale 1ns/1ns

module sub8(a, b, ci, co, s);   /* define module */
	input  [7:0] a, b;			/* input port (8bit) */
	input        ci;            /* input port (1bit) */
	output       co;            /* output port (1bit) */
	output [7:0] s;             /* output port (8bit) */
	wire         w0;            /* wire (1bit) */
	
	/* connect pre-difined module */
	sub4 s0(.a(a[3:0]), .b(b[3:0]), .ci(ci), .co(w0), .s(s[3:0]));
	sub4 s1(.a(a[7:4]), .b(b[7:4]), .ci(w0), .co(co), .s(s[7:4]));
	
endmodule
