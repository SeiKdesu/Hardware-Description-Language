`timescale 1ns/1ns

module test_add4();  /* define module */
	reg  [3:0] a, b; /* input signal (4bit) */
	reg        ci;   /* input signal (1bit) */
	wire       co;   /* output signal (1bit) */
	wire [3:0] s;    /* output signal (4bit) */
	
	/* connect the module to be verified */
	add4 a0(.a(a), .b(b), .ci(ci), .co(co), .s(s));
	
	/* waveform file */
	initial begin
		$dumpfile("add4.vcd");
		$dumpvars(0, test_add4);
	end
	
	/* standart output */
	initial begin
		$monitor($time,, "a=%b b=%b ci=%b co=%b s=%b", a, b, ci, co, s);
	end
	
	/* input signal patterns */
	initial begin
		a = 4'b0001; b = 4'b0001; ci = 1'b0;
		#10
		a = 4'b0001; b = 4'b0001; ci = 1'b1;
		#10
		a = 4'b0111; b = 4'b1000; ci = 1'b0;
		#10
		a = 4'b0111; b = 4'b1000; ci = 1'b1;
		#10
		a = 4'bxxxx; b = 4'bxxxx; ci = 1'bx;
	end
	
endmodule
