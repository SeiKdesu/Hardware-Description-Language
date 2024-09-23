`timescale 1ns/1ns

module test_dec();
	reg  [1:0] a; 
	wire [3:0] y; 
	
	dec d0(.a(a), .y(y));
	
	initial begin
		$dumpfile("dec.vcd");
		$dumpvars(0, test_dec);
	end
	
	initial begin
		$monitor($time,, "a=%b y=%b", a, y);
	end
	
	initial begin
		a = 2'b00;
		#10
		a = 2'b01;
		#10
		a = 2'b10;
		#10
		a = 2'b11;
		#10
		a = 2'bxx;
		#10
		$finish();
	end
	
endmodule
