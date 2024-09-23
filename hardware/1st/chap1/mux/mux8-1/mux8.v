`timescale 1ns/1ns

module mux8(a, b, s, y); /* define module */
	input  [7:0] a, b;   /* input signal (8bit) */
	input        s;      /* input signal (1bit) */
	output [7:0] y;      /* output signal (8bit) */
	
	/* connect pre-defined module */
	mux1 m0(.a(a[0]), .b(b[0]), .s(s), .y(y[0]));
	mux1 m1(.a(a[1]), .b(b[1]), .s(s), .y(y[1]));
	mux1 m2(.a(a[2]), .b(b[2]), .s(s), .y(y[2]));
	mux1 m3(.a(a[3]), .b(b[3]), .s(s), .y(y[3]));
	mux1 m4(.a(a[4]), .b(b[4]), .s(s), .y(y[4]));
	mux1 m5(.a(a[5]), .b(b[5]), .s(s), .y(y[5]));
	mux1 m6(.a(a[6]), .b(b[6]), .s(s), .y(y[6]));
	mux1 m7(.a(a[7]), .b(b[7]), .s(s), .y(y[7]));
	
endmodule
