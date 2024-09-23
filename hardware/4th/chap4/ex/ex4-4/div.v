`timescale 1ns/1ns

module div(clk, rst, ld, a, b, y);
	input        clk;
	input        rst;
	input        ld;
	input  [3:0] a;
	input  [3:0] b;
	output [3:0] y;
	
	reg [3:0] rb;
	reg [7:0] ry;
	wire [4:0] w_sub;
	
	assign w_sub = ry[6:3] - rb;
	assign y = ry;
		
	always@(posedge clk) begin : divisor
		if(rst == 1'b0) begin
			rb <= 4'b0000;
		/* write answer below */

		/* write answer above */
		end
	end

	always@(posedge clk) begin : reminder_quotient
		if(rst == 1'b0) begin
			ry <= 8'b00000000;
		/* write answer below */

		/* write answer above */
		end
	end
	
endmodule
