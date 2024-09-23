`timescale 1ns/1ns

module shreg(clk, ld, d, q);
	input        clk, ld;
	input  [7:0] d;
	output [7:0] q;
	reg    [7:0] q;
	
	always@(posedge clk) begin
		if(ld == 1'b1) begin
			q <= d;
		end else begin
			q <= {1'b0, q[7:1]};
		end
	end

endmodule
