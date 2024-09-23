`timescale 1ns/1ns

module display (clk, rst, ci, ld, clr, dsp);
	input   clk, rst, ci, ld, clr;
	output [7:0] dsp;
	reg    [7:0] dsp, cnt;

	always@(posedge clk) begin : counter
		if (rst == 1'b0) begin
			cnt <= 8'b00000000;
		end
		/* write answer below */

		/* write answer above */
	end
	
	always@(posedge clk) begin : register
		if (rst == 1'b0) begin
			dsp <= 8'b00000000;
		end
		/* write answer below */

		/* write answer above */
	end
	
endmodule
