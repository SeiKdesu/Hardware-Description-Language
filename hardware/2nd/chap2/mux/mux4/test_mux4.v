`timescale 1ns/1ns

module test_mux4();
	reg  [7:0] a, b, c, d;
	reg  [1:0] s;
	wire [7:0] y;
	
	mux4 m0(.a(a), .b(b), .c(c), .d(d), .s(s), .y(y));
	
	initial begin
		$dumpfile("mux4.vcd");
		$dumpvars(0, test_mux4);
	end
	
	initial begin
		$monitor($time,,"s=%b x=%b", s, y);
	end
	
	initial begin
		a = 8'b00000001;
		b = 8'b00000011;
		c = 8'b00000111;
		d = 8'b00001111;
		$display($time,, "a=%b b=%b c=%b d=%b", a, b, c, d);
		s  = 2'b00;
		#10
		s  = 2'b01;
		#10
		s  = 2'b10;
		#10
		s  = 2'b11;
		#10
		s  = 2'bxx;
		#10
		$finish();
	end
	
endmodule
