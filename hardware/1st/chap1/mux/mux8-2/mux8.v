`timescale 1ns/1ns

module mux8(a, b, s, y); /* define module */
	input  [7:0] a, b;   /* input signal (8bit) */
	input        s;      /* input signal (1bit) */
	output [7:0] y;      /* output signal (8bit) */
	
	/* assign wire */
	assign y = (a & { 8{~s} }) | (b & { 8{s} });
	
endmodule
