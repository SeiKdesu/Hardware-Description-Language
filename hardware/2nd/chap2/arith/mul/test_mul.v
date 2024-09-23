`timescale 1ns/1ns

module test_mul();
	reg  [ 7:0] a, b;
	wire [15:0] y;
	wire [ 7:0] yu, yl;

	assign yu = y[15:8];
	assign yl = y[ 7:0];
	
	mul m0(.a(a), .b(b), .y(y));
	
	initial begin
		$dumpfile("mul.vcd");
		$dumpvars(0, test_mul);
	end
	
	initial begin
		$monitor($time,, "a=%b b=%b y=%b %b", a, b, yu, yl);
	end
	
	initial begin
		a = 8'b00000010; b = 8'b00000010;
		#10
		a = 8'b00000010; b = 8'b01000000;
		#10
		a = 8'b10000000; b = 8'b10000000;
		#10
		a = 8'b11111111; b = 8'b11111111;
		#10
		a = 8'bxxxxxxxx; b = 8'bxxxxxxxx;
		#10
		$finish();
	end
	
endmodule
