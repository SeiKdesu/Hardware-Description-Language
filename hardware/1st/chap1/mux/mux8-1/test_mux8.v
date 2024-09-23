`timescale 1ns/1ns

module test_mux8();  /* define module */
	reg  [7:0] a, b; /* input signal (8bit) */
	reg        s;    /* input signal (1bit) */
	wire [7:0] y;    /* output signal (8bit) */
	
	/* connect the module to be verified */
	mux8 m0(.a(a), .b(b), .s(s), .y(y));
	
	/* waveform file */
	initial begin
		$dumpfile("mux8.vcd");
		$dumpvars(0, test_mux8);
	end
	
	/* standart output */
	initial begin
		$monitor($time,, "a=%b b=%b s=%b y=%b", a, b, s, y);
	end
	
	/* input signal patterns */
	initial begin
		a = 8'b11110000; b = 8'b00001111;
		s = 1'b0;
		#10
		s = 1'b1;
		#10
		a = 8'b10000000; b = 8'b00000001;
		#10
		s = 1'b0;
		#10
		a = 8'bxxxxxxxx; b = 8'bxxxxxxxx;
		s = 1'bx;
	end
	
endmodule
