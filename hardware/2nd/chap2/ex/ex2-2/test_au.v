`timescale 1ns/1ns

module test_au();
	reg  [2:0] in;
	reg  [2:0] a, b;
	reg  [1:0] op;
	wire [2:0] y;
	wire ov, gt, lt, eq;
	
	au au0(.a(a), .b(b), .op(op), .y(y), .ov(ov), .gt(gt), .lt(lt), .eq(eq));
	
	initial begin
		$dumpfile("au.vcd");
		$dumpvars(0, test_au);
	end
	
	initial begin
		$monitor($time,, "a=%b b=%b op=%b y=%b ov=%b gt=%b lt=%b eq=%b", a, b, op, y, ov, gt, lt, eq);
	end
	
	initial begin
		
		$display($time,,"ADDU");
		for(in = 3'b000; in <= 3'b011; in += 1'b1) begin
		for(a = 3'b010; a <= 3'b101; a += 1'b1) begin
		for(b = 3'b010; b <= 3'b101; b += 1'b1) begin
			op = in[1:0]; #10;
		end
		end 
			$display(" ");
		end
		a = 3'bxxx; b = 3'bxxx; op = 2'bxx;
	end
	
endmodule
