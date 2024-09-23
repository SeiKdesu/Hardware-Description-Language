`timescale 1ns/1ns

module test_mux1(); /* define module */
	reg  a, b, s;   /* input signal (1bit) */
	wire y;         /* output signal (1bit) */
	
	/* connect the module to be verified */
	mux1 m0(.a(a), .b(b), .s(s), .y(y));
	
	/* waveform file */
	initial begin
		$dumpfile("mux1.vcd");
		$dumpvars(0, test_mux1);
	end
	
	/* standard output */
	initial begin
		$monitor($time,, "a=%b b=%b s=%b y=%b", a, b, s, y);
	end
	
	/* input signal patterns */
	initial begin
		a = 1'b1; b = 1'b0;
		s = 1'b0;
		#10
		s = 1'b1;
		#10
		a = 1'b0; b = 1'b1;
		#10
		s = 1'b0;
		#10
		a = 1'bx; b = 1'bx;
		s = 1'bx;
	end
	
endmodule
