`timescale 1ns/1ns

module test_sub();
	reg  [7:0] a, b;
	reg        ci;
	wire [7:0] y;
	wire       co;
	
	sub s0(.a(a), .b(b), .ci(ci), .co(co), .y(y)); 
	
	initial begin
		$dumpfile("sub.vcd");
		$dumpvars(0, test_sub);
	end
	
	initial begin
		$monitor($time,, "a=%b b=%b ci=%b co=%b y=%b",
		         a, b, ci, co, y);
	end
	
	initial begin
		a = 8'b00000001; b = 8'b00000001; ci = 1'b0;
		#10
		ci = 1'b1;
		#10
		a = 8'b10000001; ci = 1'b0;
		#10
		ci = 1'b1;
		#10
		a = 8'b01111111; b = 8'b11111111; ci = 1'b0;
		#10
		a = 8'bxxxxxxxx; b = 8'bxxxxxxxx;
		ci = 1'bx;
		#10
		$finish();
	end
	
endmodule
