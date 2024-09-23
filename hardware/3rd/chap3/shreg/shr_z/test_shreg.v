`timescale 1ns/1ns

module test_shreg();
	reg        clk, ld;
	reg  [7:0] d;
	wire [7:0] q;
	
	shreg s0(.clk(clk), .ld(ld), .d(d), .q(q));
	
	initial begin
		$dumpfile("shreg.vcd");
		$dumpvars(0, test_shreg);
	end

	initial begin
		$monitor($time,, "clk=%b ld=%b d=%b q=%b", clk, ld, d, q);
	end

	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial begin
		ld = 1'b0; d = 8'b00000000;
		#105
		ld = 1'b1; d = 8'b01111111;
		#10
		ld = 1'b0; d = 8'b00000000;
		#100
		ld = 1'b0; d = 8'b00000000;
		#60
		$finish();
	end

endmodule
