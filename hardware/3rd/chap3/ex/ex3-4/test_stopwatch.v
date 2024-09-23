`timescale 1ns/1ns

module test_stopwatch(); 
	reg        clk, rst, sw1, sw2, sw3;
	wire [7:0] dsp;
	
	stopwatch u0(.clk(clk), .rst(rst), .sw1(sw1), .sw2(sw2), .sw3(sw3), .dsp(dsp));
	
	initial begin
		$dumpfile( "stopwatch.vcd" );
		$dumpvars( 0, test_stopwatch );
	end
	
	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		$monitor( $time,, "clk=%b rst=%b sw1=%b sw2=%b sw3=%b next_st=%b st=%b cnt=%d dsp=%d",
		clk, rst, sw1, sw2, sw3, u0.c0.next_state, u0.c0.state, u0.d0.cnt, dsp );
	end
	
	initial begin
		sw1 = 1'b0;
		sw2 = 1'b0;
		sw3 = 1'b0;
		rst = 1'b0;
		#15
		rst = 1'b1;
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
