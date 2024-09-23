`timescale 1ns/1ns

module full_sub(a, b, ci, co, s); /* define module */
	input  a, b, ci;              /* input port */
	output co, s;                 /* output port */
	wire   w0, w1, w2;            /* wire */
	
	/* connect pre-defined module */
	half_sub hs0(.a(a),  .b(b),  .co(w1), .s(w0));
	half_sub hs1(.a(w0), .b(ci), .co(w2), .s(s));
	
	/* assign output */
	assign co = w1 | w2;
	
endmodule
