`timescale 1ns/1ns

module test_half_add(); /* define module */
	reg  a, b;          /* input signal */
	wire co, s;         /* output signal */
	
	/* connect the module to be verified */
	half_add ha0(.a(a), .b(b), .co(co), .s(s));
	
	/* waveform file */
	initial begin
		$dumpfile("half_add.vcd");
		$dumpvars(0, test_half_add);
	end
	
	/* standard output */
	initial begin
		$monitor($time,, "a=%b b=%b co=%b s=%b", a, b, co, s);
	end
	
	/* input signal patterns */
	initial begin
		a = 1'b0; b = 1'b0; /* input singals */
		#10 /* delay time */
		a = 1'b0; b = 1'b1;
		#10
		a = 1'b1; b = 1'b0;
		#10
		a = 1'b1; b = 1'b1;
		#10
		a = 1'bx; b = 1'bx; /* indeterminated values */
	end
	
endmodule
