module rom(
	adrs, dout, rd );
	
	input  [7:0] adrs;
	output [7:0] dout;
	input  rd;
	
	reg    [7:0] rom_data;
	
	
	/*buzzer
	always @(*) begin
    case (adrs)
        8'h00 : rom_data = 8'b00000010; // LD
        8'h01 : rom_data = 8'b00100100; // GR <= #24
        8'h02 : rom_data = 8'b00000100; // ADD
        8'h03 : rom_data = 8'b00100101; // GR <= GR + #25
        8'h04 : rom_data = 8'b00000101; // ST
        8'h05 : rom_data = 8'b00100111; // #27 <= GR
        8'h06 : rom_data = 8'b00000110; // JUMP
        8'h07 : rom_data = 8'b00000000; // 8'h00
        8'h08 : rom_data = 8'h00;       // 0
        8'h09 : rom_data = 8'h00;       // 0
        default : rom_data = 8'bxxxxxxxx; // 未定義の場合
    endcase
end*/

	/*
	//Sn+1 = sn + n
	always @(*) begin
    case (adrs)
        8'h00 : rom_data = 8'b00000001; // LDI  //01
        8'h01 : rom_data = 8'h00;       // 0   
        8'h02 : rom_data = 8'b00000101; // ST  //05
        8'h03 : rom_data = 8'b00100001; // Sn#21 = 0 //21
        8'h04 : rom_data = 8'b00000001; // LDI //01
        8'h05 : rom_data = 8'b00000001; // 1   //1
        8'h06 : rom_data = 8'b00000101; // ST //05
        8'h07 : rom_data = 8'b00100000; // GR #20 <= 1 //20
        8'h08 : rom_data = 8'b00000100; // ADD   //04
        8'h09 : rom_data = 8'b00100001; // GR <= Sn#21 + 1 //21
        8'h0A : rom_data = 8'b00000101; // ST //05
        8'h0B : rom_data = 8'b00100001; // Sn#21 <= GR 
        8'h0C : rom_data = 8'b00000010; // LD
        8'h0D : rom_data = 8'b00100000; // GR <= n#20
        8'h0E : rom_data = 8'b00000011; // ADDI
        8'h0F : rom_data = 8'b00000001; // GR <= GR + 1
        8'h10 : rom_data = 8'b00000101; // ST
        8'h11 : rom_data = 8'b00100000; // n#20 <= GR
        8'h12 : rom_data = 8'b00000110; // JUMP
        8'h13 : rom_data = 8'h08;       // 8'h08 の行へ
        default : rom_data = 8'bxxxxxxxx; // 未定義の場合
    endcase
end*/
/*
	//an = an-2 + an-2  ?
	always @(*) begin
    case (adrs)
        8'h00 : rom_data = 8'b00000001; // LDI
        8'h01 : rom_data = 8'h03;       // 3
        8'h02 : rom_data = 8'b00000101; // ST
        8'h03 : rom_data = 8'b00100000; // n#20 <= 3
        8'h04 : rom_data = 8'b00000001; // LDI
        8'h05 : rom_data = 8'h01;       // 1
        8'h06 : rom_data = 8'b00000101; // ST
        8'h07 : rom_data = 8'b00100010; // a1#22 <= 1
        8'h08 : rom_data = 8'b00000101; // ST
        8'h09 : rom_data = 8'b00100011; // a2#23 <= 1
        8'h0A : rom_data = 8'b00000100; // ADD
        8'h0B : rom_data = 8'b00100011; // GR <= GR + a2#23
        8'h0C : rom_data = 8'b00000101; // ST
        8'h0D : rom_data = 8'b00100001; // an#21 <= GR
        8'h0E : rom_data = 8'b00000010; // LD
        8'h0F : rom_data = 8'b00100010; // GR <= a1#22
        8'h10 : rom_data = 8'b00000101; // ST
        8'h11 : rom_data = 8'b00100011; // a2#23 <= GR
        8'h12 : rom_data = 8'b00000010; // LD
        8'h13 : rom_data = 8'b00100001; // GR <= an#21
        8'h14 : rom_data = 8'b00000101; // ST
        8'h15 : rom_data = 8'b00100010; // a1#22 <= GR
        8'h16 : rom_data = 8'b00000010; // LD
        8'h17 : rom_data = 8'b00100000; // GR <= n#20
        8'h18 : rom_data = 8'b00000011; // ADDI
        8'h19 : rom_data = 8'h01;       // GR <= GR + 1
        8'h1A : rom_data = 8'b00000101; // ST
        8'h1B : rom_data = 8'b00100000; // n#20 <= GR
        8'h1C : rom_data = 8'b00000010; // LD
        8'h1D : rom_data = 8'b00100010; // GR <= a1#22
        8'h1E : rom_data = 8'b00000110; // JUMP
        8'h1F : rom_data = 8'b00001010; // 8'h0A の行へ
        default : rom_data = 8'bxxxxxxxx; // 未定義の場合
    endcase
end
*/
	
	
	
	assign dout = ( rd == 1'b1 ) ? rom_data : 8'bxxxxxxxx;
	
endmodule
