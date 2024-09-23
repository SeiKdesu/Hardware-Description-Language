`timescale 1ns/1ns

module test_display(); 
	reg        clk, rst, ci, ld, clr;
	wire [7:0] dsp;
	
	display d0(.clk(clk), .rst(rst), .ci(ci), .ld(ld), .clr(clr), .dsp(dsp));
	
	initial begin
		$dumpfile( "display.vcd" );
		$dumpvars( 0, test_display );
	end
	
	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		$monitor( $time,, "clk=%b rst=%b ci=%b ld=%b clr=%b cnt=%d dsp=%d",
		clk, rst, ci, ld, clr, d0.cnt, dsp );
	end
	
	initial begin
		ci = 1'b0; ld = 1'b0; clr = 1'b1; // idle
		rst = 1'b0;
		#15 // 15
		rst = 1'b1;
		#21 // 46
		ci = 1'b1; ld = 1'b1; clr = 1'b0; // count
		#70 // 106
		ci = 1'b1; ld = 1'b0; clr = 1'b0; // lap
		#40 // 146
		ci = 1'b1; ld = 1'b1; clr = 1'b0; // count
		#50 // 196
		ci = 1'b1; ld = 1'b0; clr = 1'b0; // lap
		#60 // 256
		ci = 1'b0; ld = 1'b1; clr = 1'b0; // stop
		#40 // 296
		ci = 1'b1; ld = 1'b1; clr = 1'b0; // count
		#70 // 366
		ci = 1'b0; ld = 1'b1; clr = 1'b0; // stop
		#40 // 406
		ci = 1'b0; ld = 1'b0; clr = 1'b1; // idle
		#30 // 436
		$finish();
	end
	
endmodule
