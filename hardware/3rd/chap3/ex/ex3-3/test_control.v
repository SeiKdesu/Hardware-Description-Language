`timescale 1ns/1ns

module test_control(); 
	reg  clk, sw1, sw2, sw3;
	wire ci, ld, clr;
	
	control c0(.clk(clk), .sw1(sw1), .sw2(sw2), .sw3(sw3), .ci(ci), .ld(ld), .clr(clr));
	
	initial begin
		$dumpfile( "control.vcd" );
		$dumpvars( 0, test_control );
	end
	
	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		$monitor( $time,, "clk=%b sw1=%b sw2=%b sw3=%b next_st=%b st=%b ci=%b ld=%b clr=%b",
		clk, sw1, sw2, sw3, c0.next_state, c0.state, ci, ld, clr );
	end
	
	initial begin
		sw1 = 1'b0;
		sw2 = 1'b0;
		sw3 = 1'b0;
		#15
		#10
		sw1 = 1'b1;
		#20
		sw1 = 1'b0;
		#50
		sw3 = 1'b1;
		#20
		sw3 = 1'b0;
		#20
		sw1 = 1'b1;
		#20
		sw1 = 1'b0;
		#30
		sw3 = 1'b1;
		#20
		sw3 = 1'b0;
		#40
		sw2 = 1'b1;
		#20
		sw2 = 1'b0;
		#20
		sw1 = 1'b1;
		#20
		sw1 = 1'b0;
		#50
		sw2 = 1'b1;
		#20
		sw2 = 1'b0;
		#20
		sw3 = 1'b1;
		#20
		sw3 = 1'b0;
		#20
		$finish();
	end
	
endmodule
