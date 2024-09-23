`timescale 1ns/1ns

module test_div();
	reg        clk, rst, ld;
	reg  [3:0] a, b;
	wire [3:0] y;
	
	div u0(.clk(clk), .rst(rst), .ld(ld), .a(a), .b(b), .y(y));
	
	initial begin
		$dumpfile("div.vcd");
		$dumpvars(0, test_div);
	end
	
	initial begin
		$monitor($time,, "%b %b", u0.ry, u0.rb);
	end
	
	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	initial begin
		rst = 1'b0;
		#15
		rst = 1'b1;
		a = 4'b1011;
		b = 4'b0010;
		ld = 1'b1;
		$display($time,, "ld=%b a=%b b=%b", ld, a, b);
		#20
		a = 4'b0000;
		b = 4'b0000;
		ld = 1'b0;
		$display($time,, "ld=%b a=%b b=%b", ld, a, b);
		#100
		a = 4'b1001;
		b = 4'b1000;
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
