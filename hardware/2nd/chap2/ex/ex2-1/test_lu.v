`timescale 1ns/1ns

module test_lu();
	reg  [7:0] a, b;
	reg  [1:0] op;
	wire [7:0] y1, y2, y3;
	
	lu1 l1(.a(a), .b(b), .op(op), .y(y1));
	lu2 l2(.a(a), .b(b), .op(op), .y(y2));
	lu3 l3(.a(a), .b(b), .op(op), .y(y3));
	
	initial begin
		$dumpfile("lu.vcd");
		$dumpvars(0, test_lu);
	end
	
	initial begin
		$monitor($time,, "a=%b b=%b op=%b y1=%b y2=%b y3=%b", a, b, op, y1, y2, y3);
	end
	
	initial begin
		a = 8'b11110000; b = 8'b11001100;
		op = 2'b00;
		#10
		op = 2'b01;
		#10
		op = 2'b10;
		#10
		op = 2'b11;
		#10
		a = 8'bxxxxxxxx; b = 8'bxxxxxxxx;
		op = 2'bxx;
		#10
		$finish();
	end
	
endmodule
