`timescale 1ns/1ns

module test_mul();
	reg        clk, rst, ld;
	reg  [3:0] a, b;
	wire [7:0] y;
	
	mul u0(.clk(clk), .rst(rst), .ld(ld), .a(a), .b(b), .y(y));
	
	initial begin
		$dumpfile("mul.vcd");
		$dumpvars(0, test_mul);
	end
	
	initial begin
		$monitor($time,, "%b %b", u0.ra, u0.ry);
	end
	
	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	initial begin
		rst = 1'b0;
		#15
		rst = 1'b1;
		a = 4'b1101;
		b = 4'b1011;
		ld = 1'b1;
		$display($time,, "ld=%b a=%b b=%b", ld, a, b);
		#20
		a = 4'b0000;
		b = 4'b0000;
		ld = 1'b0;
		$display($time,, "ld=%b a=%b b=%b", ld, a, b);
		#100
		a = 4'b1001;
		b = 4'b0110;
		ld = 1'b1;
		$display($time,, "ld=%b a=%b b=%b", ld, a, b);
		#20
		a = 4'b0000;
		b = 4'b0000;
		ld = 1'b0;
		$display($time,, "ld=%b a=%b b=%b", ld, a, b);
		#100
		$finish();
	end
	
endmodule
