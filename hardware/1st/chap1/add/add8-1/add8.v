`timescale 1ns/1ns

module add8(a, b, ci, co, s);   /* define module */
	input  [7:0] a, b;			/* input port (8bit) */
	input        ci;            /* input port (1bit) */
	output       co;            /* output port (1bit) */
	output [7:0] s;             /* output port (8bit) */
	wire         w0;            /* wire (1bit) */
	wire   [3:0] wa0, wb0, ws0; /* wire (4bit) */
	wire   [3:0] wa1, wb1, ws1; /* wire (4bit) */
	
	/* assign wire */
	assign wa0 = a[3:0];
	assign wa1 = a[7:4];
	assign wb0 = b[3:0];
	assign wb1 = b[7:4];
	
	/* connect pre-difined module */
	add4 a0(.a(wa0), .b(wb0), .ci(ci), .co(w0), .s(ws0));
	add4 a1(.a(wa1), .b(wb1), .ci(w0), .co(co), .s(ws1));
	
	/* assing output */
	assign s = { ws1, ws0 };
	
endmodule
