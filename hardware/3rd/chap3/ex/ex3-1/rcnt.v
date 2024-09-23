`timescale 1ns/1ns

module rcnt(clk, ld, d, q);
	input        clk, ld;
	input  [7:0] d;
	output [7:0] q;
	reg    [7:0] q;
	
	always@(posedge clk) begin
		if(ld == 1'b1) begin
			q <= d;
		end else begin
	/* write answer below */

	/* write answer above */
		end
	end

endmodule
