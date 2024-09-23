`timescale 1ns/1ns

module mul(clk, rst, ld, a, b, y);
	input        clk;
	input        rst;
	input        ld;
	input  [3:0] a;
	input  [3:0] b;
	output [7:0] y;
	
	reg [3:0] ra;
	reg [7:0] ry;
	wire [4:0] w_add;
	 
	assign w_add = ry[7:4] + ra;
	assign y = ry;
	
	always@(posedge clk) begin : multiplicand
		if(rst == 1'b0) begin
			ra <= 4'b0000;
		/* write answer below */

		/* write answer above */
		end
	end

	always@(posedge clk) begin : product_multiplier
		if(rst == 1'b0) begin
			ry <= 8'b00000000;
		/* write answer below */

		/* write answer above */
		end
	end
	
endmodule
