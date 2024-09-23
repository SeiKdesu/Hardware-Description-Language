`timescale 1ns/1ns

module shreg(clk, ld, d, si, so, q);
	input        clk, ld;
	input  [7:0] d;
	input        si;
	output       so;
	output [7:0] q;
	reg    [7:0] q;
	
	always@(posedge clk) begin
		if(ld == 1'b1) begin
			q <= d;
		end else begin
			q <= {q[6:0], si};
		end
	end
	
	assign so = q[7];

endmodule
