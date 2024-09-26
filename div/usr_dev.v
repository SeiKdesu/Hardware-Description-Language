module div(clk, rst, ld, a, b, ra, rb, ry);
	input  clk;      /* クロック */
	input  rst;      /* リセット */
	input  ld;       /* ロード */
	input  [3:0] a;  /* 剰余(被除数) */
	input  [3:0] b;  /* 除数 */
	output [7:0] ra; /* 剰余レジスタ */
	output [7:0] rb; /* 除数レジスタ */
	output [3:0] ry; /* 商レジスタ */
	
	reg [7:0] ra;    /* 剰余レジスタ */
	reg [7:0] rb;    /* 除数レジスタ */
	reg [3:0] ry;    /* 商レジスタ */
	
	/* 以下を記述 */
	always@(posedge clk or negedge rst) begin
		if(rst==1'b0) begin
			ra <= 8'b00000000;
			rb <= 8'b00000000;
			ry <= 4'b0000;
		end else if(ld == 1'b1) begin
			ra <= {4'b0000, a};
			rb <= {b, 4'b0000};
			ry <= 4'b0000;
	   end else if(ra >= rb) begin
			ra <= ra - rb;
			ry <= {ry[2:0], 1'b1};
			rb <= {1'b0, rb[7:1]};
		end else begin
			rb <= {1'b0, rb[7:1]};
			ry <= {ry[2:0], 1'b0};
		end
	end
	/* ここまで */
endmodule
