`timescale 1ns/1ns

module sub8(a, b, ci, co, s); /* define module */
	input  [7:0] a, b;        /* input port (8bit) */
	input        ci;          /* input port (1bit) */
	output       co;          /* output port (1bit) */
	output [7:0] s;           /* output port (8bit) */
	wire         w0;          /* wire (1bit) */
	
	/* connect pre-defined module */
	add8 a0(.a(a), .b(~b), .ci(ci), .co(w0), .s(s));
	
	/* assign output */
	assign co = ~w0;
	
endmodule
