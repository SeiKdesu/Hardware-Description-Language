`timescale 1ns/1ns

module half_add(a, b, co, s); /* define module */
	input  a, b;              /* input port */
	output co, s;             /* output port */

	/* assing output */	
	assign s  = a ^ b;
	assign co = a & b;
	
endmodule
