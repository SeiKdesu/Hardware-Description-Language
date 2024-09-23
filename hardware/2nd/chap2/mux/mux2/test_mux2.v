`timescale 1ns/1ns

module test_mux2();
	reg  [7:0] a, b;
	reg        s; 
	wire [7:0] y;
	
	mux2 m0(.a(a), .b(b), .s(s), .y(y));
	
	initial begin
		$dumpfile("mux2.vcd");
		$dumpvars(0, test_mux2);
	end
	
	initial begin
		$monitor($time,, "a=%b b=%b s=%b y=%b", a, b, s, y);
	end
	
	initial begin
		a = 8'b11110000; b = 8'b00001111;
		s = 1'b0;
		#10
		s = 1'b1;
		#10
		a = 8'b10000000;
		b = 8'b00000001;
		#10
		s = 1'b0;
		#10
		a = 8'bxxxxxxxx; b = 8'bxxxxxxxx;
		s = 1'bx;
		#10
		$finish();
	end
	
endmodule
