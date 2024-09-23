`timescale 1ns/1ns

module test_cnt();
	reg        clk, ld;
	reg  [7:0] d;
	wire [7:0] q1, q2;
	
	rcnt c1(.clk(clk), .ld(ld), .d(d), .q(q1));
	jcnt c2(.clk(clk), .ld(ld), .d(d), .q(q2));
	
	initial begin
		$dumpfile("cnt.vcd");
		$dumpvars(0, test_cnt);
	end

	initial begin
		$monitor($time,, "clk=%b ld=%b d=%b q1=%b q2=%b", 
			clk, ld, d, q1, q2);
	end

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		ld = 1'b1; d = 8'b00000001;
		#15
		ld = 1'b0; d = 8'b00000000;
		#180
		$finish();
	end

endmodule
