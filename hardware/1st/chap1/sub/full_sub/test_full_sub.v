`timescale 1ns/1ns

module test_full_sub(); /* define module */
	reg  a, b, ci;      /* input signal */
	wire co, s;         /* output signal */
	
	/* connect the module to be verified */
	full_sub fs0(.a(a), .b(b), .ci(ci), .co(co), .s(s));
	
	/* waveform file */
	initial begin
		$dumpfile("full_sub.vcd");
		$dumpvars(0, test_full_sub);
	end
	
	/* standard output */
	initial begin
		$monitor($time,, "a=%b b=%b ci=%b co=%b s=%b", a, b, ci, co, s);
	end
	
	/* input signal patterns */
	initial begin
		a = 1'b0; b = 1'b0; ci = 1'b0;
		#10
		a = 1'b0; b = 1'b0; ci = 1'b1;
		#10
		a = 1'b0; b = 1'b1; ci = 1'b0;
		#10
		a = 1'b0; b = 1'b1; ci = 1'b1;
		#10
		a = 1'b1; b = 1'b0; ci = 1'b0;
		#10
		a = 1'b1; b = 1'b0; ci = 1'b1;
		#10
		a = 1'b1; b = 1'b1; ci = 1'b0;
		#10
		a = 1'b1; b = 1'b1; ci = 1'b1;
		#10
		a = 1'bx; b = 1'bx; ci = 1'bx;
	end
	
endmodule
