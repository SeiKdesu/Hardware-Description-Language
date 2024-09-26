`timescale 1ns/1ns

module top(
	rx_clk, rk_clk, rx_rst,
	psw_a, psw_b, psw_c, psw_d, 
	rtsw_a, rtsw_b, dipsw_a, dipsw_b,
	bz, led, seg_a, seg_b, seg_sela, seg_selb
);
	
	input  rx_clk, rk_clk, rx_rst;
	input  [ 4:0] psw_a, psw_b, psw_c, psw_d;
	input  [ 3:0] rtsw_a, rtsw_b;
	input  [ 7:0] dipsw_a, dipsw_b;
	output bz;
	output [ 7:0] led;
	output [ 7:0] seg_a, seg_b;
	output [ 3:0] seg_sela, seg_selb;
	
	/***** 入力デバイス *****/
	
	/* プッシュスイッチ */
	wire [3:0] psw_val;
	wire [3:0] psw_fn;
	io_psw io_psw( .clk(rx_clk), .rst(rx_rst), 
	               .psw_a(psw_a), .psw_b(psw_b), .psw_c(psw_c), .psw_d(psw_d), 
	               .psw_val(psw_val), .psw_fn(psw_fn) );
	
	/***** 出力デバイス *****/
	
	/* ブザー */
	wire bz_wr;
	wire [7:0] bz_val;
	io_bz io_bz( .clk(rx_clk), .rst(rx_rst), .start(bz_wr), .val(bz_val), .bz(bz) );
	
	/* 7セグメントLED */
	wire [31:0] seg_val;
	io_seg io_seg( .clk(rx_clk), .rst(rx_rst), .sa(seg_sela), .sb(seg_selb), 
	               .d(seg_val), .qa(seg_a), .qb(seg_b) );
	
	/***** ユーザーデバイス *****/
	
	wire clk, rst, ld;
	wire [3:0] a, b, ry;
	wire [7:0] ra, rb;
	/* fn0: 0→1で立ち上がりパルス供給 */
	/* fn1: 1のときクロック供給, 0のときクロック停止 */
	assign clk     = rk_clk & psw_fn[1] | psw_fn[0];
	assign rst     = rx_rst;
	/* fn3: 1のとき初期化, 0のとき除算動作 */
	assign ld      = psw_fn[3];
	assign a       = rtsw_a;
	assign b       = rtsw_b;
	
	div div( .clk(clk), .rst(rst), .ld(ld), .a(a), .b(b), .ra(ra), .rb(rb), .ry(ry) );
	
	assign led     = {clk, ~rst, ld, 5'h0};
	assign seg_val = {a, b, ra, rb, 4'h0, ry};
	
endmodule
