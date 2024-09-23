`timescale 1ns/1ns

module test_tribuf();
	reg  [7:0] a;
	reg        c;
	wire [7:0] y1, y2;
	
	tripos t1(.a(a), .c(c), .y(y1));
	trineg t2(.a(a), .c(c), .y(y2));
	
	initial begin
		$dumpfile("tribuf.vcd");
		$dumpvars(0, test_tribuf);
	end
	
	initial begin
		$monitor($time,, "a=%b c=%b y1=%b y2=%b", a, c, y1, y2);
	end
	
	initial begin
		a = 8'b00111100;
		c = 1'b0;
		#10
		c = 1'b1;
		#10
		a = 8'b00110011;
		#10
		c = 1'b0;
		#10
		a = 8'bxxxxxxxx;
		c = 1'bx;
		#10
		$finish();
	end
	
endmodule
