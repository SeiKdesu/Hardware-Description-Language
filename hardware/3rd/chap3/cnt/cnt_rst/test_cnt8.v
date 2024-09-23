`timescale 1ns/1ns

module test_cnt8();
	reg        clk, rst;
	reg        ci;
	wire       co;
	wire [7:0] q;
	
	cnt8 c0(.clk(clk), .rst(rst),
               .ci(ci), .co(co), .q(q));
	
	initial begin
		$dumpfile("cnt8.vcd");
		$dumpvars(0, test_cnt8);
	end
	
	initial begin
		$monitor($time,, "clk=%b ci=%b co=%b q=%b", clk, ci, co, q);
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
		ci = 1'b1;
		#105
		ci = 1'b0;
		#10
		ci = 1'b1;
		#100
		ci = 1'b0;
		#60
		$finish();
	end
	
endmodule
