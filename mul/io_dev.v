/***************************************
   プッシュスイッチ制御回路
 ***************************************/

module io_psw(
	clk, rst, 
	psw_a, psw_b, psw_c, psw_d, psw_val, psw_fn );
	
	input         clk, rst;
	input  [ 4:0] psw_a, psw_b, psw_c, psw_d;
	output [ 3:0] psw_val;
	output [ 3:0] psw_fn;
	
	wire          ld;
	wire   [19:0] psw_in;
	
	assign psw_in = { psw_d, psw_c, psw_b, psw_a };
	
	psw_pulse pp( .clk(clk), .rst(rst), .co(ld) );
	
	psw_detecter pd( .clk(clk), .rst(rst), .ld(ld), .psw_in(psw_in), 
	                 .psw_val(psw_val), .psw_fn(psw_fn) );
	
endmodule
/*
 * 周期パルス出力回路
 *
 * 周期5msのパルスを出力
 *
 */
module psw_pulse(
	clk, rst, co );
	
	input  clk, rst;
	output co;
	reg    [16:0] cnt;
	
	assign co = ( cnt == 17'd100000 );
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			cnt <= 17'h0;
		end else if( co == 1'b1 ) begin
			/* しきい値に達したらカウンタを初期化 */
			cnt <= 17'h1;
		end else begin
			/* カウントを繰り返す */
			cnt <= cnt + 17'h1; 
		end
	end
	
endmodule
/*
 * キー入力検出回路
 *
 * シフトレジスタでスイッチ入力を検出
 * 検出したら一定時間経過後にパルスを1回だけ出力
 *
 */
module psw_detecter(
	clk, rst, ld, psw_in, psw_val, psw_fn );
	
	input  clk, rst;
	input  ld;
	input  [19:0] psw_in;
	output [ 3:0] psw_val;
	output [ 3:0] psw_fn;
	
	reg    [ 3:0] psw_val;
	reg    [ 3:0] psw_fn;
	reg    [ 4:0] psw_id;
	reg    [ 1:0] dly;
	reg    [ 2:0] cnt;
	wire          max;
	
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			dly <= 2'b11;
		end else if( ld == 1'b1 ) begin
			/* シフトレジスタでスイッチ入力を検出 */
			dly <= { dly[0], ~&psw_in };
		end
	end
	
	assign max = &cnt;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			cnt <= 3'h0;
			psw_id <= 5'h0;
		end else if( dly[0] == 1'b0 ) begin /* 10 or 00 */
			/* スイッチ入力がなければカウント停止 */
			cnt <= 3'h0;
			psw_id <= 5'h0;
		end else if( dly[1] == 1'b0 ) begin /* 01 */
			/* スイッチ入力を検出したらカウント開始 */
			cnt <= 3'h1;
			psw_id[0] <= ~(psw_in[ 1] & psw_in[ 3]
			             & psw_in[ 6] & psw_in[ 8]
			             & psw_in[11] & psw_in[13]
			             & psw_in[16] & psw_in[18]
			             & psw_in[ 9] & psw_in[19]);
			psw_id[1] <= ~(psw_in[ 2] & psw_in[ 3]
			             & psw_in[ 7] & psw_in[ 8]
			             & psw_in[12] & psw_in[13]
			             & psw_in[17] & psw_in[18]
			             & psw_in[14] & psw_in[19]);
			psw_id[2] <= ~(psw_in[ 5] & psw_in[ 6]
			             & psw_in[ 7] & psw_in[ 8]
			             & psw_in[15] & psw_in[16]
			             & psw_in[17] & psw_in[18]);
			psw_id[3] <= ~(psw_in[10] & psw_in[11]
			             & psw_in[12] & psw_in[13]
			             & psw_in[15] & psw_in[16]
			             & psw_in[17] & psw_in[18]);
			psw_id[4] <= ~(psw_in[ 4] & psw_in[ 9]
			             & psw_in[14] & psw_in[19]);
		end else if( max == 1'b1 ) begin
			/* しきい値に達したらカウント停止 */
			cnt <= 3'h0;
			psw_id <= 5'h0;
		end else if( cnt != 3'h0 ) begin
			/* 停止状態でなければカウントを繰り返す */
			cnt <= cnt + 3'h1;
		end
	end
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			psw_val <= 4'h0;
		end else if( max == 1'b1 && psw_id[4] == 1'b0 ) begin
			psw_val <= psw_id[3:0];
		end
	end
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			psw_fn <= 4'b1000;
		end else if( max == 1'b1 && psw_id[4] == 1'b1 ) begin
			psw_fn[psw_id[1:0]] <= ~psw_fn[psw_id[1:0]];
		end
	end
	
endmodule

/***************************************
   ブザー制御回路
 ***************************************/

module io_bz(
	clk, rst, 
	start, val, bz );
	
	input  clk;
	input  rst;
	input  start;
	input  [7:0] val;
	output bz;
	
	wire   enable, pitch;
	
	bz_time bt( .clk(clk), .rst(rst), .start(start), .val(val[7:4]), .enable(enable) );
	bz_pitch bp( .clk(clk), .rst(rst), .val(val[3:0]), .pitch(pitch) );
	
	assign bz = enable & pitch;
	
endmodule
/*
 * 音価生成回路
 *
 * トリガ入力の立ち上がりから
 * 入力値に応じた長さのイネーブル信号を出力
 */
module bz_time(
	clk, rst, start, val, enable );
	
	input clk, rst;
	input start;
	input [3:0] val;
	output enable;
	reg    [ 1:0] dly;
	reg    [23:0] cnt;
	reg    [23:0] cref;
	wire   max;
	
	/* 入力値に応じてカウンタのしきい値を設定 */
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			cref <= 24'd0;
		end else begin
			case( val )                        /* sec */
				4'b0000: cref <= 24'd01000000; /* 0.1 */
				4'b0001: cref <= 24'd02000000; /* 0.2 */
				4'b0010: cref <= 24'd03000000; /* 0.3 */
				4'b0011: cref <= 24'd04000000; /* 0.4 */
				4'b0100: cref <= 24'd05000000; /* 0.5 */
				4'b0101: cref <= 24'd06000000; /* 0.6 */
				4'b0110: cref <= 24'd07000000; /* 0.7 */
				4'b0111: cref <= 24'd08000000; /* 0.8 */
				4'b1000: cref <= 24'd09000000; /* 0.9 */
				4'b1001: cref <= 24'd10000000; /* 1.0 */
				4'b1010: cref <= 24'd11000000; /* 1.1 */
				4'b1011: cref <= 24'd12000000; /* 1.2 */
				4'b1100: cref <= 24'd13000000; /* 1.3 */
				4'b1101: cref <= 24'd14000000; /* 1.4 */
				4'b1110: cref <= 24'd15000000; /* 1.5 */
				4'b1111: cref <= 24'd16000000; /* 1.6 */
				default: cref <= 24'd0;
			endcase
		end
	end
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			dly <= 2'b00;
		end else begin
			/* トリガ入力の立ち上がりを検出 */
			dly <= { dly[0], start };
		end
	end
	
	assign max = ( cnt == cref );
	assign enable = ( cnt != 24'h0 );
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			cnt <= 24'd0;
		end else if( dly == 2'b01 ) begin
			/* トリガ入力を検出したらカウンタの動作開始 */
			cnt <= 24'd1;
		end else if( max == 1'b1 ) begin
			/* しきい値に達したらカウンタの動作停止 */
			cnt <= 24'd0;
		end else begin
			/* カウンタが停止するまでイネーブル信号を立ち上げる */
			cnt <= cnt + enable;
		end
	end
	
endmodule
/*
 * 音程生成回路
 *
 * 入力値に応じた周波数のピッチ信号を出力
 *
 */
module bz_pitch( 
	clk, rst, val, pitch );
	
	input  clk, rst;
	input  [3:0] val;
	output pitch;
	reg    pitch;
	reg    [15:0] cnt;
	reg    [15:0] cref;
	wire   max, zero;
	
	/* 入力値に応じてカウンタのしきい値を設定 */
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin	
			cref <= 16'hFFFF;
		end else begin
			case( val )                     /*        Hz */
				4'b0000: cref <= 16'hFFFF;  /* R    0.00 */
				4'b0001: cref <= 16'd38223; /* C  261.62 */
				4'b0010: cref <= 16'd34053; /* D  293.66 */
				4'b0011: cref <= 16'd30338; /* E  329.62 */
				4'b0100: cref <= 16'd28635; /* F  349.22 */
				4'b0101: cref <= 16'd25511; /* G  391.99 */
				4'b0110: cref <= 16'd22727; /* A  440.00 */
				4'b0111: cref <= 16'd20248; /* B  493.88 */
				4'b1000: cref <= 16'd19111; /* C  523.25 */
				4'b1001: cref <= 16'd17026; /* D  587.32 */
				4'b1010: cref <= 16'd15169; /* E  659.25 */
				4'b1011: cref <= 16'd14317; /* F  698.45 */
				4'b1100: cref <= 16'd12755; /* G  783.99 */
				4'b1101: cref <= 16'd11364; /* A  880.00 */
				4'b1110: cref <= 16'd10124; /* B  987.76 */
				4'b1111: cref <= 16'd09556; /* C 1046.50 */
				default: cref <= 16'hFFFF;
			endcase
		end
	end
	
	assign max = ( cnt == cref );
	assign zero = ( val == 4'h0 );
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			cnt <= 16'h0;
		end else if( zero == 1'b1 ) begin
			/* 入力値が0の場合はカウンタを停止 */
			cnt <= 16'h0;
		end else if( max == 1'b1 ) begin
			/* しきい値に達したらカウンタを初期化 */
			cnt <= 16'h1;
		end else begin
			/* カウントを繰り返す */
			cnt <= cnt + 16'h1; 
		end
	end
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			pitch <= 1'b0;
		end else if( zero == 1'b1 ) begin
			/* 入力値が0の場合はピッチ信号を停止 */
			pitch <= 1'b0;
		end else if( max == 1'b1 ) begin
			/* カウンタからのパルスでピッチ信号を反転 */
			pitch <= ~pitch;
		end
	end
	
endmodule

/***************************************
   7セグメントLED制御回路
 ***************************************/

module io_seg(
	clk, rst, sa, sb, d, qa, qb );
	
	input  clk;
	input  rst;
	output [ 3:0] sa, sb;
	input  [31:0] d;
	output [ 7:0] qa, qb;
	
	wire   [ 3:0] va, vb;
	wire   [ 3:0] sel;
	
	assign sa = sel;
	assign sb = sel;
	
	seg_selecter ss( .clk(clk), .rst(rst), .sel(sel) );
	
	seg_register sra( .clk(clk), .rst(rst), .sel(sel), .din(d[31:16]), .dout(va) );
	seg_register srb( .clk(clk), .rst(rst), .sel(sel), .din(d[15: 0]), .dout(vb) );
	
	seg_decoder sda( .clk(clk), .rst(rst), .val(va), .seg(qa) );
	seg_decoder sdb( .clk(clk), .rst(rst), .val(vb), .seg(qb) );
	
endmodule

/*
 * 7セグメントLED選択回路
 *
 * 一定時間ごとに出力先の7セグメントLEDの選択信号を切り換える
 *
 */

module seg_selecter(
	clk, rst, sel );
	
	input  clk, rst;
	output [ 3:0] sel;
	
	reg    [ 3:0] sel;
	reg    [13:0] cnt;
	wire   max;
	
	assign max = ( cnt == 14'h3000 );
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			cnt <= 14'h1;
		end else if( cnt == max ) begin
			/* しきい値に達したらパルスを出力 */
			cnt <= 14'h1;
		end else begin
			/* カウントを繰り返す */
			cnt <= cnt + 14'h1;
		end
	end
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			sel <= 4'b0000;
		end else if( sel <= 4'b0000 ) begin
			sel <= 4'b1110;
		end else if( max == 1'b1 ) begin
			/* カウンタからのパルスで選択信号を変更 */
			sel <= { sel[2:0], sel[3] };
		end
	end
	
endmodule

/*
 * 入力信号選択回路
 *
 * 入力信号を選択して出力する
 *
 */

module seg_register(
	clk, rst, sel, din, dout );
	
	input  clk, rst;
	input  [ 3:0] sel;
	input  [15:0] din;
	output [ 3:0] dout;
	
	reg    [ 3:0] dout;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			dout <= 4'h0;
		end else begin
			case( sel )
				4'b1110: dout <= din[15:12];
				4'b1101: dout <= din[11: 8];
				4'b1011: dout <= din[ 7: 4];
				4'b0111: dout <= din[ 3: 0];
				default: dout <= 4'hx;
			endcase
		end
	end
	
endmodule

/*
 * 7セグメントLEDデコーダ
 *
 * 入力された信号を7セグメントLEDの表示パターンにデコードする
 *
 */

module seg_decoder(
	clk, rst, val, seg );
	
	input  clk, rst;
	input  [3:0] val;
	output [7:0] seg;
	
	reg    [7:0] seg;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			seg <= 8'h0;
		end else begin
			case( val )
				4'h0: seg <= 8'b11111100;
				4'h1: seg <= 8'b01100000;
				4'h2: seg <= 8'b11011010;
				4'h3: seg <= 8'b11110010;
				4'h4: seg <= 8'b01100110;
				4'h5: seg <= 8'b10110110;
				4'h6: seg <= 8'b10111110;
				4'h7: seg <= 8'b11100000;
				4'h8: seg <= 8'b11111110;
				4'h9: seg <= 8'b11110110;
				4'hA: seg <= 8'b11101110;
				4'hB: seg <= 8'b00111110;
				4'hC: seg <= 8'b00011010;
				4'hD: seg <= 8'b01111010;
				4'hE: seg <= 8'b10011110;
				4'hF: seg <= 8'b10001110;
				default: seg <= 8'hxx;
			endcase
		end
	end
	
endmodule

/***************************************
   ロータリースイッチ制御回路
 ***************************************/

module io_rtsw(
	clk, rst, din, dout );
	
	input  clk, rst;
	input  [3:0] din;
	output [3:0] dout;
	reg    [3:0] dout;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			dout <= 4'h0;
		end else begin
			dout <= din;
		end
	end
	
endmodule

/***************************************
   DIPスイッチ制御回路
 ***************************************/

module io_dipsw(
	clk, rst, din, dout );
	
	input  clk, rst;
	input  [7:0] din;
	output [7:0] dout;
	reg    [7:0] dout;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			dout <= 8'h0;
		end else begin
			dout <= ~din;
		end
	end
	
endmodule

/***************************************
   LED制御回路
 ***************************************/

module io_led(
	clk, rst, din, dout );
	
	input  clk, rst;
	input  [7:0] din;
	output [7:0] dout;
	reg    [7:0] dout;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			dout <= 8'h0;
		end else begin
			dout <= din;
		end
	end
	
endmodule
