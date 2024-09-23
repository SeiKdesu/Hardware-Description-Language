`timescale 1ns/1ns

module test_cmp();
	reg  [7:0] a, b;
	wire       gt1, lt1, eq1;
	wire       gt2, lt2, eq2;
	wire       gt3, lt3, eq3;
	
	cmp1 c1(.a(a), .b(b), .gt(gt1), .lt(lt1), .eq(eq1));
	cmp2 c2(.a(a), .b(b), .gt(gt2), .lt(lt2), .eq(eq2));
	cmp3 c3(.a(a), .b(b), .gt(gt3), .lt(lt3), .eq(eq3));
	
	initial begin
		$dumpfile("cmp.vcd");
		$dumpvars(0, test_cmp);
	end
	
	initial begin
		$monitor($time,, "a=%b b=%b gt=%b,%b,%b lt=%b,%b,%b eq=%b,%b,%b",
		         a, b, gt1, gt2, gt3, lt1, lt2, lt3, eq1, eq2, eq3);
	end
	
	initial begin
		a = 8'b10000000;
		b = 8'b00000001;
		#10
		b = 8'b11111111;
		#10
		b = 8'b10000000;
		#10
		a = 8'bxxxxxxxx;
		b = 8'bxxxxxxxx;
		#10
		$finish();
	end
	
endmodule
