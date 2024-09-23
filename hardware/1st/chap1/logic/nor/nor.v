`timescale 1ns/1ns

module test_nor();       /* define module */
	reg a, b;            /* input */
	wire y1, y2, y3, y4; /* output */

	/* connect the module to be verified */
	nor1 m1(.a(a), .b(b), .y(y1));
	nor2 m2(.a(a), .b(b), .y(y2));
	nor3 m3(.a(a), .b(b), .y(y3));
	nor4 m4(.a(a), .b(b), .y(y4));

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
		$monitor("a=%b b=%b y1=%b y2=%b y3=%b y4=%b",
			a, b, y1, y2, y3, y4);
	end

	/* waveform file */
	initial begin
		$dumpfile("nor.vcd");
		$dumpvars(0,test_nor);
	end

endmodule

module nor1(a, b, y);
	input a, b;
	output y;
	wire w;
	/* assing wire and output */
	assign w = a | b;
	assign y = ~w;
endmodule

module nor2(a, b, y);
	input a, b;
	output y;
	wire w, x;
	/* assing wire and output */
	assign w = ~a;
	assign x = ~b;
	assign y = w & x;
endmodule

module nor3(a, b, y);
	input a, b;
	output y;
	/* assing wire and output */
	assign y = ~(a | b);
endmodule

module nor4(a, b, y);
	input a, b;
	output y;
	/* assing wire and output */
	assign y = ~a & ~b;
endmodule
