module mul(clk, rst, ld, a, b, ra, rb, ry, q);
  input clk; /* クロック */
  input rst; /* リセット */
  input ld; /* ロード */
  input [3:0] a; /* 被乗数 */ 9
  input [3:0] b; /* 乗数 */ b
  output [7:0] ra; /* 被乗数レジスタ */
  output [3:0] rb; /* 乗数レジスタ */
  output [7:0] ry; /* 積レジスタ */
  output [3:0] q; /*カウンターレジスタ*/

  reg [3:0] q; /*カウンターレジスタ*/
  reg [7:0] ra; /* 被乗数レジスタ */
  reg [3:0] rb; /* 乗数レジスタ */
  reg [7:0] ry; /* 積レジスタ */

  always @(posedge clk or negedge rst) begin
    if (rst == 1'b0) begin
      ry <= 8'b00000000;
      ra <= 4b'0000;
      rb <= 4'b0000;
    end else if (ld == 1'b1) begin
      ra <= {4'b0000, a};
      rb <= b[3:0];
      ry <= 8'b00000000;
    end else if (rb[0] == 1'b1) begin
      ry <= ry + ra;
      ra <= {ra[6:0], 1'b0};
      rb <= {1'b0, rb[3:1]};
    end else begin
      ra <= {ra[6:0], 1'b0};
      rb <= {1'b0, rb[3:1]};
    end
  end
endmodule
  



    /*end else  if (ld == 1'b0) begin
      rb <= b[3:0];
    end else if (rb[0] == 1'b1) begin
      ry <= ry + ra;
     
    end else if (ld == 1'b1) begin
      ra <= {4'b0000, a};
      rb <= b;
      
      q <= 4'b0000;
    end else if (q > 4'b0011) begin
      // カウンタが最大に達したときの動作
    end else if (rb[0] == 1'b1) begin
      ry <= ry + ra;
      ra <= {ra[6:0], 1'b0};
      rb <= {1'b0, rb[3:1]};
      q <= q + 1;
    end else begin
      ra <= {ra[6:0], 1'b0};
      rb <= {1'b0, rb[3:1]};
      q <= q + 1;
    end
  end
endmodule*/
