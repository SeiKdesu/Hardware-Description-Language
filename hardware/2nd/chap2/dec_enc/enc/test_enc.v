`timescale 1ns/1ns

module test_enc();
	reg  [3:0] a; 
	wire [2:0] y1, y2, y3; 
	
	enc1 e1(.a(a), .y(y1)); 
	enc2 e2(.a(a), .y(y2)); 
	enc3 e3(.a(a), .y(y3)); 
	
	initial begin
		$dumpfile("enc.vcd");
		$dumpvars(0, test_enc);
	end
	
	initial begin
		$monitor($time,, "a=%b y1=%b y2=%b y3=%b", a, y1, y2, y3);
	end
	
	initial begin
		a = 4'b0001;
		#10
		a = 4'b1111;
		#10
		a = 4'b1010;
		#10
		a = 4'b1100;
		#10
		a = 4'b1000;
		#10
		a = 4'b0000;
		#10
		a = 4'bxxxx;
		#10
		$finish();
	end
	
endmodule
