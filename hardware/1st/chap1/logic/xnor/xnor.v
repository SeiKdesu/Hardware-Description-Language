`timescale 1ns/1ns

module test_xnor();  /* define module */
	reg a, b;        /* input */
	wire y1, y2, y3; /* output */

	/* connect the module to be verified */
	xnor1 m1(.a(a), .b(b), .y(y1));
	xnor2 m2(.a(a), .b(b), .y(y2));
	xnor3 m3(.a(a), .b(b), .y(y3));

	/* input signal patterns */
	initial begin
		a = 1'b0; b = 1'b0; /* input signals */
		#10 /* delay time */
		a = 1'b0; b = 1'b1;
		#10
		a = 1'b1; b = 1'b0;
		#10
		a = 1'b1; b = 1'b1;
		#10
		a = 1'bx; b = 1'bx; /* indeterminated values */
	end

	/* standard output */
	initial begin
		$monitor("a=%b b=%b y1=%b y2=%b y3=%b",
			a, b, y1, y2, y3);
	end

	/* waveform file */
	initial begin
		$dumpfile("xnor.vcd");
		$dumpvars(0,test_xnor);
	end

endmodule

module xnor1(a, b, y);
	input a, b;
	output y;
	wire w, x;
	/* assing wire and output */
	assign w = ~a & ~b;
	assign x =  a &  b;
	assign y = w | x;
endmodule

module xnor2(a, b, y);
	input a, b;
	output y;
	wire w, x;
	/* assing wire and output */
	assign w =  a | ~b;
	assign x = ~a |  b;
	assign y = w & x;
endmodule

module xnor3(a, b, y);
	input a, b;
	output y;
	/* assing wire and output */
	assign y = a ~^ b;
endmodule
