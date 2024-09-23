`timescale 1ns/1ns

module add8(a, b, ci, co, s);   /* define module */
	input  [7:0] a, b;			/* input port (8bit) */
	input        ci;            /* input port (1bit) */
	output       co;            /* output port (1bit) */
	output [7:0] s;             /* output port (8bit) */
	wire   [6:0] w;             /* wire (7bit) */
	
	/* connect pre-difined module */
	full_add fa0(.a(a[0]), .b(b[0]), .ci(ci),   .co(w[0]), .s(s[0]));
	full_add fa1(.a(a[1]), .b(b[1]), .ci(w[0]), .co(w[1]), .s(s[1]));
	full_add fa2(.a(a[2]), .b(b[2]), .ci(w[1]), .co(w[2]), .s(s[2]));
	full_add fa3(.a(a[3]), .b(b[3]), .ci(w[2]), .co(w[3]), .s(s[3]));
	full_add fa4(.a(a[4]), .b(b[4]), .ci(w[3]), .co(w[4]), .s(s[4]));
	full_add fa5(.a(a[5]), .b(b[5]), .ci(w[4]), .co(w[5]), .s(s[5]));
	full_add fa6(.a(a[6]), .b(b[6]), .ci(w[5]), .co(w[6]), .s(s[6]));
	full_add fa7(.a(a[7]), .b(b[7]), .ci(w[6]), .co(co),   .s(s[7]));
	
endmodule
