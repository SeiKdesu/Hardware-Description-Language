module mul(clk, rst, ld, a, b, ra, rb, ry);
	input  clk;      /* クロック */
	input  rst;      /* リセット */
	input  ld;       /* ロード */
	input  [3:0] a;  /* 被乗数 */
	input  [3:0] b;  /* 乗数 */
	output [7:0] ra; /* 被乗数レジスタ */
	output [3:0] rb; /* 乗数レジスタ */
	output [7:0] ry; /* 積レジスタ */
	
	reg [7:0] ra;    /* 被乗数レジスタ */
	reg [3:0] rb;    /* 乗数レジスタ */
	reg [7:0] ry;    /* 積レジスタ */
	
	/* 以下を記述 */
	always@(posedge clk or negedge rst) begin
		if(rst==1'b0) begin
			ra <= 8'b00000000;
			rb <= 4'b0000;
			ry <= 8'b00000000;
		end else if(ld == 1'b1) begin
			ra <= {4'b0000, a};
			rb <= b[3:0];
			ry <= 8'b00000000;
	   end else if(rb[0]==1'b1) begin
			ry <= ry + ra;
			ra <= {ra[6:0], 1'b0};
			rb <= {1'b0, rb[3:1]};
		end else begin
			ra <= {ra[6:0], 1'b0};
			rb <= {1'b0, rb[3:1]};
		end
	end
	/* ここまで */
endmodule
