module mul(clk, rst, ld, a, b, ra, rb, ry, q);
  input clk; /* クロック */
  input rst; /* リセット */
  input ld; /* ロード */
  input [3:0] a; /* 剰余 */11
  input [3:0] b; /* 除数 */2
  output [7:0] ra; /* レジスタ */
  output [3:0] rb; /* 乗数レジスタ */
  output [7:0] ry; /* 積レジスタ */
  output [3:0] q; /*カウンターレジスタ*/

  reg [3:0] q; /*カウンターレジスタ*/
  reg [7:0] ra; /* 被乗数レジスタ */ 11
  reg [3:0] rb; /* 乗数レジスタ */  2
  reg [3:0] ry; /* 商レジスタ */

  always @(posedge clk or negedge rst) begin
    if (rst == 1'b0) begin
      ry <= 4'b0000;
      ra <= 8'b0000;
      rb <= 8'b0000;
    end else if (ld == 1'b1) begin
      ra <= {4'b0000, a};
      rb <= {b,4'b0000};
      ry <= 4'b0000;
    end else if (ra >= rb) begin
      ra <= ra - rb;
      ry <= {ry[2:0], 1'b1};
      rb <= {1'b0, rb[7:1]};
    end else begin
      rb <= {1'b0, rb[7:1]};
      ry <= {ry[2:0], 1'b0};
    end
  end
endmodule