`timescale 1ns/1ns

module test_mul();
	reg        clk;
	reg  [3:0] a, b;
	wire [7:0] p;
	
	mul u0(.clk(clk), .a(a), .b(b), .p(p));
	
	initial begin
		$dumpfile("mul.vcd");
		$dumpvars(0, test_mul);
	end
	
	initial begin
		$monitor($time,, "clk=%b a=%b b=%b p=%b %b %b", 
		clk, a, b, u0.p0, u0.p1, p);
	end
	
	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	initial begin
		a = 4'b1101; b = 4'b1011;
		#20
		a = 4'b1001; b = 4'b0110;
		#20
		a = 4'b0010; b = 4'b0011;
		#100
		$finish();
	end
	
endmodule
