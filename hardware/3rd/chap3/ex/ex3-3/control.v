`timescale 1ns/1ns

`define IDLE  2'b00
`define COUNT 2'b01
`define LAP   2'b10
`define STOP  2'b11

module control (clk, sw1, sw2, sw3, ci, ld, clr);
	input   clk, sw1, sw2, sw3;
	output  ci, ld, clr;
	reg     ci, ld, clr;
	
	reg    [1:0] state, next_state;
	
	always@(sw1 or sw2 or sw3 or state) begin : next_state_calc
		case (state)
		/* write answer below */
			`IDLE : begin

			end
			`COUNT : begin

			end
			`LAP : begin

			end
			`STOP : begin

			end
		/* write ansowe above */
			default : begin
				next_state <= `IDLE;
			end
		endcase
	end
	
	always@(posedge clk) begin : state_register
		state <= next_state;
	end
	
	always@(state) begin : output_calc
		case(state)
		/* write answer below */
			`IDLE : begin

			end
			`COUNT : begin

			end
			`LAP : begin

			end
			`STOP : begin

			end
		/* write answer above */
			default : begin
				clr  <= 1'b1;
				ci   <= 1'b0;
				ld   <= 1'b0;
			end
		endcase
	end
endmodule
