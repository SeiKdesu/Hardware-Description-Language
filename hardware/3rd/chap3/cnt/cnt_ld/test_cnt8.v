`timescale 1ns/1ns

module test_cnt8();
	reg        clk, rst, ld;
	reg  [7:0] d;
	reg        ci;
	wire       co;
	wire [7:0] q;
	
	cnt8 c0(.clk(clk), .rst(rst), .ld(ld), .d(d), 
               .ci(ci), .co(co), .q(q));
	
	initial begin
		$dumpfile("cnt8.vcd");
		$dumpvars(0, test_cnt8);
	end
	
	initial begin
		$monitor($time,, "clk=%b ld=%b d=%b ci=%b co=%b q=%b", clk, ld, d, ci, co, q);
	end
	
	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	initial begin
		rst = 1'b1;
		$display($time,, "rst=%b", rst);
		#5
		rst = 1'b0;
		$display($time,, "rst=%b", rst);
		#10
		rst = 1'b1;
		$display($time,, "rst=%b", rst);
	end
	
	initial begin
		ld = 1'b0; d = 8'b00000000; ci = 1'b1;
		#105
		ld = 1'b1; d = 8'b11111110; ci = 1'b0;
		#10
		ld = 1'b0; d = 8'b00000000; ci = 1'b1;
		#100
		ld = 1'b0; d = 8'b00000000; ci = 1'b0;
		#60
		$finish();
	end
	
endmodule
