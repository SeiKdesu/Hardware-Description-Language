`timescale 1ns/1ns

module mux1(a, b, s, y); /* define module */
	input  a, b, s;      /* input signal (1bit) */
	output y;            /* output signal (1bit) */
	
	/* assign output */
	assign y  = (a & ~s) | (b & s);
	
endmodule
