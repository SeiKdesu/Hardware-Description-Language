`timescale 1ns/1ns

module mul(clk, a, b, p);
	input        clk;
	input  [3:0] a, b;
	output [7:0] p;
	reg    [5:0] p0;
	reg    [6:0] p1;
	reg    [7:0] p;
	wire   [3:0] w0, w1, w2, w3;
	
	assign w0 = a & {4{b[0]}};
	assign w1 = a & {4{b[1]}};
	assign w2 = a & {4{b[2]}};
	assign w3 = a & {4{b[3]}};
	
	always@(posedge clk) begin
		p0 <= w0 + {w1,1'b0};
	end
	
	always@(posedge clk) begin
		p1 <= p0 + {w2,2'b00};
	end
	
	always@(posedge clk) begin
		p  <= p1 + {w3,3'b000};
	end
	
endmodule
