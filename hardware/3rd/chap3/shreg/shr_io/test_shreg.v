`timescale 1ns/1ns

module test_shreg();
	reg        clk, ld;
	reg  [7:0] d;
	reg        si;
	wire       so;
	wire [7:0] q;
	
	shreg s0(.clk(clk), .ld(ld), .d(d), 
             .si(si), .so(so), .q(q));
	
	initial begin
		$dumpfile("shreg.vcd");
		$dumpvars(0, test_shreg);
	end

	initial begin
		$monitor($time,, "clk=%b ld=%b si=%b d=%b q=%b so=%b", clk, ld, si, d, q, so);
	end

	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial begin
		ld = 1'b0; d = 8'b00000000; si = 1'b1;
		#105
		ld = 1'b1; d = 8'b01111111; si = 1'b0;
		#10
		ld = 1'b0; d = 8'b00000000; si = 1'b1;
		#100
		ld = 1'b0; d = 8'b00000000; si = 1'b0;
		#60
		$finish();
	end

endmodule
