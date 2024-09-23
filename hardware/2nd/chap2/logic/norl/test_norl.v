`timescale 1ns/1ns

module test_norl();
	reg  [7:0] a, b;
	wire [7:0] y;
	
	norl n0(.a(a), .b(b), .y(y)); 
	
	initial begin
		$dumpfile("norl.vcd");
		$dumpvars(0, test_norl);
	end
	
	initial begin
		$monitor($time,, "a=%b b=%b y=%b",
		         a, b, y);
	end
	
	initial begin
		a = 8'b11110000; b = 8'b00000000;
		#10
		a = 8'b11110000; b = 8'b11111111;
		#10
		a = 8'b11110000; b = 8'b10101010;
		#10
		a = 8'bxxxxxxxx; b = 8'bxxxxxxxx;
		#10
		$finish();
	end
	
endmodule
