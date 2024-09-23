`timescale 1ns/1ns

module test_sub8();  /* define module */
	reg  [7:0] a, b; /* input signal (8bit) */
	reg        ci;   /* input signal (1bit) */
	wire       co;   /* output signal (1bit) */
	wire [7:0] s;    /* output signal (8bit) */
	
	/* connect module to be verified */
	sub8 s0(.a(a), .b(b), .ci(ci), .co(co), .s(s));
	
	/* waveform file */
	initial begin
		$dumpfile("sub8.vcd");
		$dumpvars(0, test_sub8);
	end
	
	/* standard output */
	initial begin
		$monitor($time,, "a=%b b=%b ci=%b co=%b s=%b", a, b, ci, co, s);
	end
	
	/* input signal patterns */
	initial begin
		a = 8'b00000001; b = 8'b00000001; ci = 1'b0;
		#10
		a = 8'b00000001; b = 8'b00000001; ci = 1'b1;
		#10
		a = 8'b00001000; b = 8'b00000111; ci = 1'b0;
		#10
		a = 8'b00001000; b = 8'b00000111; ci = 1'b1;
		#10
		a = 8'b10000000; b = 8'b01111111; ci = 1'b0;
		#10
		a = 8'b10000000; b = 8'b01111111; ci = 1'b1;
		#10
		a = 8'bxxxxxxxx; b = 8'bxxxxxxxx; ci = 1'bx;
	end
	
endmodule
