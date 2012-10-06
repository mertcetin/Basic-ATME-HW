`timescale 1ns / 1ps
module SAD_Calculation(clk, reset, search, current, SADOUT);
	
	input clk, reset;
	
	input [((8*16*16)-1):0] search;
	input [((8*16*16)-1):0] current;
	output [15:0] SADOUT;
	
	reg [11:0] SAD01, SAD02, SAD03, SAD04, SAD05, SAD06, SAD07, SAD08, SAD09, SAD10, SAD11, SAD12, SAD13, SAD14, SAD15, SAD16;
	
	reg [13:0] SAD33_delay, SAD34_delay, SAD35_delay, SAD36_delay;
	
	wire [14:0] SAD37_delay, SAD38_delay, SAD39_delay, SAD40_delay;
		
	wire [7:0] search_matrix [15:0][15:0];
	wire [7:0] current_matrix [15:0][15:0];
	wire [7:0] difference_matrix [15:0][15:0];
	
	reg [9:0] add01, add02, add03, add04, add05, add06, add07, add08, add09, add10, add11, add12, add13, add14, add15, add16, add17, add18, add19, add20, add21, add22, add23, add24, add25, add26, add27, add28, add29, add30, add31, add32;
	reg [9:0] add33, add34, add35, add36, add37, add38, add39, add40, add41, add42, add43, add44, add45, add46, add47, add48, add49, add50, add51, add52, add53, add54, add55, add56, add57, add58, add59, add60, add61, add62, add63, add64;
	
	assign search_matrix [0][0][7:0] = search[((8*((16*0)+1))-1):(8*((16*0)))];
	assign search_matrix [0][1][7:0] = search [((8*((16*0)+2))-1):(8*((16*0)+1))];
	assign search_matrix [0][2][7:0] = search [((8*((16*0)+3))-1):(8*((16*0)+2))];
	assign search_matrix [0][3][7:0] = search [((8*((16*0)+4))-1):(8*((16*0)+3))];
	assign search_matrix [0][4][7:0] = search [((8*((16*0)+5))-1):(8*((16*0)+4))];
	assign search_matrix [0][5][7:0] = search [((8*((16*0)+6))-1):(8*((16*0)+5))];
	assign search_matrix [0][6][7:0] = search [((8*((16*0)+7))-1):(8*((16*0)+6))];
	assign search_matrix [0][7][7:0] = search [((8*((16*0)+8))-1):(8*((16*0)+7))];
	assign search_matrix [0][8][7:0] = search [((8*((16*0)+9))-1):(8*((16*0)+8))];
	assign search_matrix [0][9][7:0] = search [((8*((16*0)+10))-1):(8*((16*0)+9))];
	assign search_matrix [0][10][7:0] = search [((8*((16*0)+11))-1):(8*((16*0)+10))];
	assign search_matrix [0][11][7:0] = search [((8*((16*0)+12))-1):(8*((16*0)+11))];
	assign search_matrix [0][12][7:0] = search [((8*((16*0)+13))-1):(8*((16*0)+12))];
	assign search_matrix [0][13][7:0] = search [((8*((16*0)+14))-1):(8*((16*0)+13))];
	assign search_matrix [0][14][7:0] = search [((8*((16*0)+15))-1):(8*((16*0)+14))];
	assign search_matrix [0][15][7:0] = search [((8*((16*0)+16))-1):(8*((16*0)+15))];
	//assign search_matrix [0][15][7:0] = search [((8*((16*0)+17))-1):(8*((16*0)+16))];
	
	assign search_matrix [1][0][7:0] = search[((8*((16*1)+1))-1):(8*((16*1)))];
	assign search_matrix [1][1][7:0] = search [((8*((16*1)+2))-1):(8*((16*1)+1))];
	assign search_matrix [1][2][7:0] = search [((8*((16*1)+3))-1):(8*((16*1)+2))];
	assign search_matrix [1][3][7:0] = search [((8*((16*1)+4))-1):(8*((16*1)+3))];
	assign search_matrix [1][4][7:0] = search [((8*((16*1)+5))-1):(8*((16*1)+4))];
	assign search_matrix [1][5][7:0] = search [((8*((16*1)+6))-1):(8*((16*1)+5))];
	assign search_matrix [1][6][7:0] = search [((8*((16*1)+7))-1):(8*((16*1)+6))];
	assign search_matrix [1][7][7:0] = search [((8*((16*1)+8))-1):(8*((16*1)+7))];
	assign search_matrix [1][8][7:0] = search [((8*((16*1)+9))-1):(8*((16*1)+8))];
	assign search_matrix [1][9][7:0] = search [((8*((16*1)+10))-1):(8*((16*1)+9))];
	assign search_matrix [1][10][7:0] = search [((8*((16*1)+11))-1):(8*((16*1)+10))];
	assign search_matrix [1][11][7:0] = search [((8*((16*1)+12))-1):(8*((16*1)+11))];
	assign search_matrix [1][12][7:0] = search [((8*((16*1)+13))-1):(8*((16*1)+12))];
	assign search_matrix [1][13][7:0] = search [((8*((16*1)+14))-1):(8*((16*1)+13))];
	assign search_matrix [1][14][7:0] = search [((8*((16*1)+15))-1):(8*((16*1)+14))];
	assign search_matrix [1][15][7:0] = search [((8*((16*1)+16))-1):(8*((16*1)+15))];
	//assign search_matrix [1][16][7:0] = search [((8*((16*1)+17))-1):(8*((16*1)+16))];
	
	assign search_matrix [2][0][7:0] = search[((8*((16*2)+1))-1):(8*((16*2)))];
	assign search_matrix [2][1][7:0] = search [((8*((16*2)+2))-1):(8*((16*2)+1))];
	assign search_matrix [2][2][7:0] = search [((8*((16*2)+3))-1):(8*((16*2)+2))];
	assign search_matrix [2][3][7:0] = search [((8*((16*2)+4))-1):(8*((16*2)+3))];
	assign search_matrix [2][4][7:0] = search [((8*((16*2)+5))-1):(8*((16*2)+4))];
	assign search_matrix [2][5][7:0] = search [((8*((16*2)+6))-1):(8*((16*2)+5))];
	assign search_matrix [2][6][7:0] = search [((8*((16*2)+7))-1):(8*((16*2)+6))];
	assign search_matrix [2][7][7:0] = search [((8*((16*2)+8))-1):(8*((16*2)+7))];
	assign search_matrix [2][8][7:0] = search [((8*((16*2)+9))-1):(8*((16*2)+8))];
	assign search_matrix [2][9][7:0] = search [((8*((16*2)+10))-1):(8*((16*2)+9))];
	assign search_matrix [2][10][7:0] = search [((8*((16*2)+11))-1):(8*((16*2)+10))];
	assign search_matrix [2][11][7:0] = search [((8*((16*2)+12))-1):(8*((16*2)+11))];
	assign search_matrix [2][12][7:0] = search [((8*((16*2)+13))-1):(8*((16*2)+12))];
	assign search_matrix [2][13][7:0] = search [((8*((16*2)+14))-1):(8*((16*2)+13))];
	assign search_matrix [2][14][7:0] = search [((8*((16*2)+15))-1):(8*((16*2)+14))];
	assign search_matrix [2][15][7:0] = search [((8*((16*2)+16))-1):(8*((16*2)+15))];
	//assign search_matrix [2][15][7:0] = search [((8*((16*2)+17))-1):(8*((16*2)+16))];
	
	assign search_matrix [3][0][7:0] = search[((8*((16*3)+1))-1):(8*((16*3)))];
	assign search_matrix [3][1][7:0] = search [((8*((16*3)+2))-1):(8*((16*3)+1))];
	assign search_matrix [3][2][7:0] = search [((8*((16*3)+3))-1):(8*((16*3)+2))];
	assign search_matrix [3][3][7:0] = search [((8*((16*3)+4))-1):(8*((16*3)+3))];
	assign search_matrix [3][4][7:0] = search [((8*((16*3)+5))-1):(8*((16*3)+4))];
	assign search_matrix [3][5][7:0] = search [((8*((16*3)+6))-1):(8*((16*3)+5))];
	assign search_matrix [3][6][7:0] = search [((8*((16*3)+7))-1):(8*((16*3)+6))];
	assign search_matrix [3][7][7:0] = search [((8*((16*3)+8))-1):(8*((16*3)+7))];
	assign search_matrix [3][8][7:0] = search [((8*((16*3)+9))-1):(8*((16*3)+8))];
	assign search_matrix [3][9][7:0] = search [((8*((16*3)+10))-1):(8*((16*3)+9))];
	assign search_matrix [3][10][7:0] = search [((8*((16*3)+11))-1):(8*((16*3)+10))];
	assign search_matrix [3][11][7:0] = search [((8*((16*3)+12))-1):(8*((16*3)+11))];
	assign search_matrix [3][12][7:0] = search [((8*((16*3)+13))-1):(8*((16*3)+12))];
	assign search_matrix [3][13][7:0] = search [((8*((16*3)+14))-1):(8*((16*3)+13))];
	assign search_matrix [3][14][7:0] = search [((8*((16*3)+15))-1):(8*((16*3)+14))];
	assign search_matrix [3][15][7:0] = search [((8*((16*3)+16))-1):(8*((16*3)+15))];
	//assign search_matrix [3][15][7:0] = search [((8*((16*3)+17))-1):(8*((16*3)+16))];
	
	assign search_matrix [4][0][7:0] = search [((8*((16*4)+1))-1):(8*((16*4)+0))];
	assign search_matrix [4][1][7:0] = search [((8*((16*4)+2))-1):(8*((16*4)+1))];
	assign search_matrix [4][2][7:0] = search [((8*((16*4)+3))-1):(8*((16*4)+2))];
	assign search_matrix [4][3][7:0] = search [((8*((16*4)+4))-1):(8*((16*4)+3))];
	assign search_matrix [4][4][7:0] = search [((8*((16*4)+5))-1):(8*((16*4)+4))];
	assign search_matrix [4][5][7:0] = search [((8*((16*4)+6))-1):(8*((16*4)+5))];
	assign search_matrix [4][6][7:0] = search [((8*((16*4)+7))-1):(8*((16*4)+6))];
	assign search_matrix [4][7][7:0] = search [((8*((16*4)+8))-1):(8*((16*4)+7))];
	assign search_matrix [4][8][7:0] = search [((8*((16*4)+9))-1):(8*((16*4)+8))];
	assign search_matrix [4][9][7:0] = search [((8*((16*4)+10))-1):(8*((16*4)+9))];
	assign search_matrix [4][10][7:0] = search [((8*((16*4)+11))-1):(8*((16*4)+10))];
	assign search_matrix [4][11][7:0] = search [((8*((16*4)+12))-1):(8*((16*4)+11))];
	assign search_matrix [4][12][7:0] = search [((8*((16*4)+13))-1):(8*((16*4)+12))];
	assign search_matrix [4][13][7:0] = search [((8*((16*4)+14))-1):(8*((16*4)+13))];
	assign search_matrix [4][14][7:0] = search [((8*((16*4)+15))-1):(8*((16*4)+14))];
	assign search_matrix [4][15][7:0] = search [((8*((16*4)+16))-1):(8*((16*4)+15))];
	//assign search_matrix [4][15][7:0] = search [((8*((16*4)+17))-1):(8*((16*4)+16))];
	
	assign search_matrix [5][0][7:0] = search [((8*((16*5)+1))-1):(8*((16*5)+0))];
	assign search_matrix [5][1][7:0] = search [((8*((16*5)+2))-1):(8*((16*5)+1))];
	assign search_matrix [5][2][7:0] = search [((8*((16*5)+3))-1):(8*((16*5)+2))];
	assign search_matrix [5][3][7:0] = search [((8*((16*5)+4))-1):(8*((16*5)+3))];
	assign search_matrix [5][4][7:0] = search [((8*((16*5)+5))-1):(8*((16*5)+4))];
	assign search_matrix [5][5][7:0] = search [((8*((16*5)+6))-1):(8*((16*5)+5))];
	assign search_matrix [5][6][7:0] = search [((8*((16*5)+7))-1):(8*((16*5)+6))];
	assign search_matrix [5][7][7:0] = search [((8*((16*5)+8))-1):(8*((16*5)+7))];
	assign search_matrix [5][8][7:0] = search [((8*((16*5)+9))-1):(8*((16*5)+8))];
	assign search_matrix [5][9][7:0] = search [((8*((16*5)+10))-1):(8*((16*5)+9))];
	assign search_matrix [5][10][7:0] = search [((8*((16*5)+11))-1):(8*((16*5)+10))];
	assign search_matrix [5][11][7:0] = search [((8*((16*5)+12))-1):(8*((16*5)+11))];
	assign search_matrix [5][12][7:0] = search [((8*((16*5)+13))-1):(8*((16*5)+12))];
	assign search_matrix [5][13][7:0] = search [((8*((16*5)+14))-1):(8*((16*5)+13))];
	assign search_matrix [5][14][7:0] = search [((8*((16*5)+15))-1):(8*((16*5)+14))];
	assign search_matrix [5][15][7:0] = search [((8*((16*5)+16))-1):(8*((16*5)+15))];
	//assign search_matrix [5][15][7:0] = search [((8*((16*5)+17))-1):(8*((16*5)+16))];
	
	assign search_matrix [6][0][7:0] = search [((8*((16*6)+1))-1):(8*((16*6)+0))];
	assign search_matrix [6][1][7:0] = search [((8*((16*6)+2))-1):(8*((16*6)+1))];
	assign search_matrix [6][2][7:0] = search [((8*((16*6)+3))-1):(8*((16*6)+2))];
	assign search_matrix [6][3][7:0] = search [((8*((16*6)+4))-1):(8*((16*6)+3))];
	assign search_matrix [6][4][7:0] = search [((8*((16*6)+5))-1):(8*((16*6)+4))];
	assign search_matrix [6][5][7:0] = search [((8*((16*6)+6))-1):(8*((16*6)+5))];
	assign search_matrix [6][6][7:0] = search [((8*((16*6)+7))-1):(8*((16*6)+6))];
	assign search_matrix [6][7][7:0] = search [((8*((16*6)+8))-1):(8*((16*6)+7))];
	assign search_matrix [6][8][7:0] = search [((8*((16*6)+9))-1):(8*((16*6)+8))];
	assign search_matrix [6][9][7:0] = search [((8*((16*6)+10))-1):(8*((16*6)+9))];
	assign search_matrix [6][10][7:0] = search [((8*((16*6)+11))-1):(8*((16*6)+10))];
	assign search_matrix [6][11][7:0] = search [((8*((16*6)+12))-1):(8*((16*6)+11))];
	assign search_matrix [6][12][7:0] = search [((8*((16*6)+13))-1):(8*((16*6)+12))];
	assign search_matrix [6][13][7:0] = search [((8*((16*6)+14))-1):(8*((16*6)+13))];
	assign search_matrix [6][14][7:0] = search [((8*((16*6)+15))-1):(8*((16*6)+14))];
	assign search_matrix [6][15][7:0] = search [((8*((16*6)+16))-1):(8*((16*6)+15))];
	//assign search_matrix [6][15][7:0] = search [((8*((16*6)+17))-1):(8*((16*6)+16))];
	
	assign search_matrix [7][0][7:0] = search [((8*((16*7)+1))-1):(8*((16*7)+0))];
	assign search_matrix [7][1][7:0] = search [((8*((16*7)+2))-1):(8*((16*7)+1))];
	assign search_matrix [7][2][7:0] = search [((8*((16*7)+3))-1):(8*((16*7)+2))];
	assign search_matrix [7][3][7:0] = search [((8*((16*7)+4))-1):(8*((16*7)+3))];
	assign search_matrix [7][4][7:0] = search [((8*((16*7)+5))-1):(8*((16*7)+4))];
	assign search_matrix [7][5][7:0] = search [((8*((16*7)+6))-1):(8*((16*7)+5))];
	assign search_matrix [7][6][7:0] = search [((8*((16*7)+7))-1):(8*((16*7)+6))];
	assign search_matrix [7][7][7:0] = search [((8*((16*7)+8))-1):(8*((16*7)+7))];
	assign search_matrix [7][8][7:0] = search [((8*((16*7)+9))-1):(8*((16*7)+8))];
	assign search_matrix [7][9][7:0] = search [((8*((16*7)+10))-1):(8*((16*7)+9))];
	assign search_matrix [7][10][7:0] = search [((8*((16*7)+11))-1):(8*((16*7)+10))];
	assign search_matrix [7][11][7:0] = search [((8*((16*7)+12))-1):(8*((16*7)+11))];
	assign search_matrix [7][12][7:0] = search [((8*((16*7)+13))-1):(8*((16*7)+12))];
	assign search_matrix [7][13][7:0] = search [((8*((16*7)+14))-1):(8*((16*7)+13))];
	assign search_matrix [7][14][7:0] = search [((8*((16*7)+15))-1):(8*((16*7)+14))];
	assign search_matrix [7][15][7:0] = search [((8*((16*7)+16))-1):(8*((16*7)+15))];
	//assign search_matrix [7][15][7:0] = search [((8*((16*7)+17))-1):(8*((16*7)+16))];
	
	assign search_matrix [8][0][7:0] = search [((8*((16*8)+1))-1):(8*((16*8)+0))];
	assign search_matrix [8][1][7:0] = search [((8*((16*8)+2))-1):(8*((16*8)+1))];
	assign search_matrix [8][2][7:0] = search [((8*((16*8)+3))-1):(8*((16*8)+2))];
	assign search_matrix [8][3][7:0] = search [((8*((16*8)+4))-1):(8*((16*8)+3))];
	assign search_matrix [8][4][7:0] = search [((8*((16*8)+5))-1):(8*((16*8)+4))];
	assign search_matrix [8][5][7:0] = search [((8*((16*8)+6))-1):(8*((16*8)+5))];
	assign search_matrix [8][6][7:0] = search [((8*((16*8)+7))-1):(8*((16*8)+6))];
	assign search_matrix [8][7][7:0] = search [((8*((16*8)+8))-1):(8*((16*8)+7))];
	assign search_matrix [8][8][7:0] = search [((8*((16*8)+9))-1):(8*((16*8)+8))];
	assign search_matrix [8][9][7:0] = search [((8*((16*8)+10))-1):(8*((16*8)+9))];
	assign search_matrix [8][10][7:0] = search [((8*((16*8)+11))-1):(8*((16*8)+10))];
	assign search_matrix [8][11][7:0] = search [((8*((16*8)+12))-1):(8*((16*8)+11))];
	assign search_matrix [8][12][7:0] = search [((8*((16*8)+13))-1):(8*((16*8)+12))];
	assign search_matrix [8][13][7:0] = search [((8*((16*8)+14))-1):(8*((16*8)+13))];
	assign search_matrix [8][14][7:0] = search [((8*((16*8)+15))-1):(8*((16*8)+14))];
	assign search_matrix [8][15][7:0] = search [((8*((16*8)+16))-1):(8*((16*8)+15))];
	//assign search_matrix [8][15][7:0] = search [((8*((16*8)+17))-1):(8*((16*8)+16))];
	
	assign search_matrix [9][0][7:0] = search [((8*((16*9)+1))-1):(8*((16*9)+0))];
	assign search_matrix [9][1][7:0] = search [((8*((16*9)+2))-1):(8*((16*9)+1))];
	assign search_matrix [9][2][7:0] = search [((8*((16*9)+3))-1):(8*((16*9)+2))];
	assign search_matrix [9][3][7:0] = search [((8*((16*9)+4))-1):(8*((16*9)+3))];
	assign search_matrix [9][4][7:0] = search [((8*((16*9)+5))-1):(8*((16*9)+4))];
	assign search_matrix [9][5][7:0] = search [((8*((16*9)+6))-1):(8*((16*9)+5))];
	assign search_matrix [9][6][7:0] = search [((8*((16*9)+7))-1):(8*((16*9)+6))];
	assign search_matrix [9][7][7:0] = search [((8*((16*9)+8))-1):(8*((16*9)+7))];
	assign search_matrix [9][8][7:0] = search [((8*((16*9)+9))-1):(8*((16*9)+8))];
	assign search_matrix [9][9][7:0] = search [((8*((16*9)+10))-1):(8*((16*9)+9))];
	assign search_matrix [9][10][7:0] = search [((8*((16*9)+11))-1):(8*((16*9)+10))];
	assign search_matrix [9][11][7:0] = search [((8*((16*9)+12))-1):(8*((16*9)+11))];
	assign search_matrix [9][12][7:0] = search [((8*((16*9)+13))-1):(8*((16*9)+12))];
	assign search_matrix [9][13][7:0] = search [((8*((16*9)+14))-1):(8*((16*9)+13))];
	assign search_matrix [9][14][7:0] = search [((8*((16*9)+15))-1):(8*((16*9)+14))];
	assign search_matrix [9][15][7:0] = search [((8*((16*9)+16))-1):(8*((16*9)+15))];
	//assign search_matrix [9][15][7:0] = search [((8*((16*9)+17))-1):(8*((16*9)+16))];
	
	assign search_matrix [10][0][7:0] = search [((8*((16*10)+1))-1):(8*((16*10)+0))];
	assign search_matrix [10][1][7:0] = search [((8*((16*10)+2))-1):(8*((16*10)+1))];
	assign search_matrix [10][2][7:0] = search [((8*((16*10)+3))-1):(8*((16*10)+2))];
	assign search_matrix [10][3][7:0] = search [((8*((16*10)+4))-1):(8*((16*10)+3))];
	assign search_matrix [10][4][7:0] = search [((8*((16*10)+5))-1):(8*((16*10)+4))];
	assign search_matrix [10][5][7:0] = search [((8*((16*10)+6))-1):(8*((16*10)+5))];
	assign search_matrix [10][6][7:0] = search [((8*((16*10)+7))-1):(8*((16*10)+6))];
	assign search_matrix [10][7][7:0] = search [((8*((16*10)+8))-1):(8*((16*10)+7))];
	assign search_matrix [10][8][7:0] = search [((8*((16*10)+9))-1):(8*((16*10)+8))];
	assign search_matrix [10][9][7:0] = search [((8*((16*10)+10))-1):(8*((16*10)+9))];
	assign search_matrix [10][10][7:0] = search [((8*((16*10)+11))-1):(8*((16*10)+10))];
	assign search_matrix [10][11][7:0] = search [((8*((16*10)+12))-1):(8*((16*10)+11))];
	assign search_matrix [10][12][7:0] = search [((8*((16*10)+13))-1):(8*((16*10)+12))];
	assign search_matrix [10][13][7:0] = search [((8*((16*10)+14))-1):(8*((16*10)+13))];
	assign search_matrix [10][14][7:0] = search [((8*((16*10)+15))-1):(8*((16*10)+14))];
	assign search_matrix [10][15][7:0] = search [((8*((16*10)+16))-1):(8*((16*10)+15))];
	//assign search_matrix [10][15][7:0] = search [((8*((16*10)+17))-1):(8*((16*10)+16))];
	
	assign search_matrix [11][0][7:0] = search [((8*((16*11)+1))-1):(8*((16*11)+0))];
	assign search_matrix [11][1][7:0] = search [((8*((16*11)+2))-1):(8*((16*11)+1))];
	assign search_matrix [11][2][7:0] = search [((8*((16*11)+3))-1):(8*((16*11)+2))];
	assign search_matrix [11][3][7:0] = search [((8*((16*11)+4))-1):(8*((16*11)+3))];
	assign search_matrix [11][4][7:0] = search [((8*((16*11)+5))-1):(8*((16*11)+4))];
	assign search_matrix [11][5][7:0] = search [((8*((16*11)+6))-1):(8*((16*11)+5))];
	assign search_matrix [11][6][7:0] = search [((8*((16*11)+7))-1):(8*((16*11)+6))];
	assign search_matrix [11][7][7:0] = search [((8*((16*11)+8))-1):(8*((16*11)+7))];
	assign search_matrix [11][8][7:0] = search [((8*((16*11)+9))-1):(8*((16*11)+8))];
	assign search_matrix [11][9][7:0] = search [((8*((16*11)+10))-1):(8*((16*11)+9))];
	assign search_matrix [11][10][7:0] = search [((8*((16*11)+11))-1):(8*((16*11)+10))];
	assign search_matrix [11][11][7:0] = search [((8*((16*11)+12))-1):(8*((16*11)+11))];
	assign search_matrix [11][12][7:0] = search [((8*((16*11)+13))-1):(8*((16*11)+12))];
	assign search_matrix [11][13][7:0] = search [((8*((16*11)+14))-1):(8*((16*11)+13))];
	assign search_matrix [11][14][7:0] = search [((8*((16*11)+15))-1):(8*((16*11)+14))];
	assign search_matrix [11][15][7:0] = search [((8*((16*11)+16))-1):(8*((16*11)+15))];
	//assign search_matrix [11][15][7:0] = search [((8*((16*11)+17))-1):(8*((16*11)+16))];
	
	assign search_matrix [12][0][7:0] = search [((8*((16*12)+1))-1):(8*((16*12)+0))];
	assign search_matrix [12][1][7:0] = search [((8*((16*12)+2))-1):(8*((16*12)+1))];
	assign search_matrix [12][2][7:0] = search [((8*((16*12)+3))-1):(8*((16*12)+2))];
	assign search_matrix [12][3][7:0] = search [((8*((16*12)+4))-1):(8*((16*12)+3))];
	assign search_matrix [12][4][7:0] = search [((8*((16*12)+5))-1):(8*((16*12)+4))];
	assign search_matrix [12][5][7:0] = search [((8*((16*12)+6))-1):(8*((16*12)+5))];
	assign search_matrix [12][6][7:0] = search [((8*((16*12)+7))-1):(8*((16*12)+6))];
	assign search_matrix [12][7][7:0] = search [((8*((16*12)+8))-1):(8*((16*12)+7))];
	assign search_matrix [12][8][7:0] = search [((8*((16*12)+9))-1):(8*((16*12)+8))];
	assign search_matrix [12][9][7:0] = search [((8*((16*12)+10))-1):(8*((16*12)+9))];
	assign search_matrix [12][10][7:0] = search [((8*((16*12)+11))-1):(8*((16*12)+10))];
	assign search_matrix [12][11][7:0] = search [((8*((16*12)+12))-1):(8*((16*12)+11))];
	assign search_matrix [12][12][7:0] = search [((8*((16*12)+13))-1):(8*((16*12)+12))];
	assign search_matrix [12][13][7:0] = search [((8*((16*12)+14))-1):(8*((16*12)+13))];
	assign search_matrix [12][14][7:0] = search [((8*((16*12)+15))-1):(8*((16*12)+14))];
	assign search_matrix [12][15][7:0] = search [((8*((16*12)+16))-1):(8*((16*12)+15))];
	//assign search_matrix [12][15][7:0] = search [((8*((16*12)+17))-1):(8*((16*12)+16))];
	
	assign search_matrix [13][0][7:0] = search [((8*((16*13)+1))-1):(8*((16*13)+0))];
	assign search_matrix [13][1][7:0] = search [((8*((16*13)+2))-1):(8*((16*13)+1))];
	assign search_matrix [13][2][7:0] = search [((8*((16*13)+3))-1):(8*((16*13)+2))];
	assign search_matrix [13][3][7:0] = search [((8*((16*13)+4))-1):(8*((16*13)+3))];
	assign search_matrix [13][4][7:0] = search [((8*((16*13)+5))-1):(8*((16*13)+4))];
	assign search_matrix [13][5][7:0] = search [((8*((16*13)+6))-1):(8*((16*13)+5))];
	assign search_matrix [13][6][7:0] = search [((8*((16*13)+7))-1):(8*((16*13)+6))];
	assign search_matrix [13][7][7:0] = search [((8*((16*13)+8))-1):(8*((16*13)+7))];
	assign search_matrix [13][8][7:0] = search [((8*((16*13)+9))-1):(8*((16*13)+8))];
	assign search_matrix [13][9][7:0] = search [((8*((16*13)+10))-1):(8*((16*13)+9))];
	assign search_matrix [13][10][7:0] = search [((8*((16*13)+11))-1):(8*((16*13)+10))];
	assign search_matrix [13][11][7:0] = search [((8*((16*13)+12))-1):(8*((16*13)+11))];
	assign search_matrix [13][12][7:0] = search [((8*((16*13)+13))-1):(8*((16*13)+12))];
	assign search_matrix [13][13][7:0] = search [((8*((16*13)+14))-1):(8*((16*13)+13))];
	assign search_matrix [13][14][7:0] = search [((8*((16*13)+15))-1):(8*((16*13)+14))];
	assign search_matrix [13][15][7:0] = search [((8*((16*13)+16))-1):(8*((16*13)+15))];
	//assign search_matrix [13][15][7:0] = search [((8*((16*13)+17))-1):(8*((16*13)+16))];
	
	assign search_matrix [14][0][7:0] = search [((8*((16*14)+1))-1):(8*((16*14)+0))];
	assign search_matrix [14][1][7:0] = search [((8*((16*14)+2))-1):(8*((16*14)+1))];
	assign search_matrix [14][2][7:0] = search [((8*((16*14)+3))-1):(8*((16*14)+2))];
	assign search_matrix [14][3][7:0] = search [((8*((16*14)+4))-1):(8*((16*14)+3))];
	assign search_matrix [14][4][7:0] = search [((8*((16*14)+5))-1):(8*((16*14)+4))];
	assign search_matrix [14][5][7:0] = search [((8*((16*14)+6))-1):(8*((16*14)+5))];
	assign search_matrix [14][6][7:0] = search [((8*((16*14)+7))-1):(8*((16*14)+6))];
	assign search_matrix [14][7][7:0] = search [((8*((16*14)+8))-1):(8*((16*14)+7))];
	assign search_matrix [14][8][7:0] = search [((8*((16*14)+9))-1):(8*((16*14)+8))];
	assign search_matrix [14][9][7:0] = search [((8*((16*14)+10))-1):(8*((16*14)+9))];
	assign search_matrix [14][10][7:0] = search [((8*((16*14)+11))-1):(8*((16*14)+10))];
	assign search_matrix [14][11][7:0] = search [((8*((16*14)+12))-1):(8*((16*14)+11))];
	assign search_matrix [14][12][7:0] = search [((8*((16*14)+13))-1):(8*((16*14)+12))];
	assign search_matrix [14][13][7:0] = search [((8*((16*14)+14))-1):(8*((16*14)+13))];
	assign search_matrix [14][14][7:0] = search [((8*((16*14)+15))-1):(8*((16*14)+14))];
	assign search_matrix [14][15][7:0] = search [((8*((16*14)+16))-1):(8*((16*14)+15))];
	//assign search_matrix [14][15][7:0] = search [((8*((16*14)+17))-1):(8*((16*14)+16))];
	
	assign search_matrix [15][0][7:0] = search [((8*((16*15)+1))-1):(8*((16*15)+0))];
	assign search_matrix [15][1][7:0] = search [((8*((16*15)+2))-1):(8*((16*15)+1))];
	assign search_matrix [15][2][7:0] = search [((8*((16*15)+3))-1):(8*((16*15)+2))];
	assign search_matrix [15][3][7:0] = search [((8*((16*15)+4))-1):(8*((16*15)+3))];
	assign search_matrix [15][4][7:0] = search [((8*((16*15)+5))-1):(8*((16*15)+4))];
	assign search_matrix [15][5][7:0] = search [((8*((16*15)+6))-1):(8*((16*15)+5))];
	assign search_matrix [15][6][7:0] = search [((8*((16*15)+7))-1):(8*((16*15)+6))];
	assign search_matrix [15][7][7:0] = search [((8*((16*15)+8))-1):(8*((16*15)+7))];
	assign search_matrix [15][8][7:0] = search [((8*((16*15)+9))-1):(8*((16*15)+8))];
	assign search_matrix [15][9][7:0] = search [((8*((16*15)+10))-1):(8*((16*15)+9))];
	assign search_matrix [15][10][7:0] = search [((8*((16*15)+11))-1):(8*((16*15)+10))];
	assign search_matrix [15][11][7:0] = search [((8*((16*15)+12))-1):(8*((16*15)+11))];
	assign search_matrix [15][12][7:0] = search [((8*((16*15)+13))-1):(8*((16*15)+12))];
	assign search_matrix [15][13][7:0] = search [((8*((16*15)+14))-1):(8*((16*15)+13))];
	assign search_matrix [15][14][7:0] = search [((8*((16*15)+15))-1):(8*((16*15)+14))];
	assign search_matrix [15][15][7:0] = search [((8*((16*15)+16))-1):(8*((16*15)+15))];
	//assign search_matrix [15][15][7:0] = search [((8*((16*15)+17))-1):(8*((16*15)+16))];
	
	//
	
	assign current_matrix [0][0][7:0] = current [((8*((16*0)+1))-1):(8*((16*0)+0))];
	assign current_matrix [0][1][7:0] = current [((8*((16*0)+2))-1):(8*((16*0)+1))];
	assign current_matrix [0][2][7:0] = current [((8*((16*0)+3))-1):(8*((16*0)+2))];
	assign current_matrix [0][3][7:0] = current [((8*((16*0)+4))-1):(8*((16*0)+3))];
	assign current_matrix [0][4][7:0] = current [((8*((16*0)+5))-1):(8*((16*0)+4))];
	assign current_matrix [0][5][7:0] = current [((8*((16*0)+6))-1):(8*((16*0)+5))];
	assign current_matrix [0][6][7:0] = current [((8*((16*0)+7))-1):(8*((16*0)+6))];
	assign current_matrix [0][7][7:0] = current [((8*((16*0)+8))-1):(8*((16*0)+7))];
	assign current_matrix [0][8][7:0] = current [((8*((16*0)+9))-1):(8*((16*0)+8))];
	assign current_matrix [0][9][7:0] = current [((8*((16*0)+10))-1):(8*((16*0)+9))];
	assign current_matrix [0][10][7:0] = current [((8*((16*0)+11))-1):(8*((16*0)+10))];
	assign current_matrix [0][11][7:0] = current [((8*((16*0)+12))-1):(8*((16*0)+11))];
	assign current_matrix [0][12][7:0] = current [((8*((16*0)+13))-1):(8*((16*0)+12))];
	assign current_matrix [0][13][7:0] = current [((8*((16*0)+14))-1):(8*((16*0)+13))];
	assign current_matrix [0][14][7:0] = current [((8*((16*0)+15))-1):(8*((16*0)+14))];
	assign current_matrix [0][15][7:0] = current [((8*((16*0)+16))-1):(8*((16*0)+15))];
	
	assign current_matrix [1][0][7:0] = current [((8*((16*1)+1))-1):(8*((16*1)+0))];
	assign current_matrix [1][1][7:0] = current [((8*((16*1)+2))-1):(8*((16*1)+1))];
	assign current_matrix [1][2][7:0] = current [((8*((16*1)+3))-1):(8*((16*1)+2))];
	assign current_matrix [1][3][7:0] = current [((8*((16*1)+4))-1):(8*((16*1)+3))];
	assign current_matrix [1][4][7:0] = current [((8*((16*1)+5))-1):(8*((16*1)+4))];
	assign current_matrix [1][5][7:0] = current [((8*((16*1)+6))-1):(8*((16*1)+5))];
	assign current_matrix [1][6][7:0] = current [((8*((16*1)+7))-1):(8*((16*1)+6))];
	assign current_matrix [1][7][7:0] = current [((8*((16*1)+8))-1):(8*((16*1)+7))];
	assign current_matrix [1][8][7:0] = current [((8*((16*1)+9))-1):(8*((16*1)+8))];
	assign current_matrix [1][9][7:0] = current [((8*((16*1)+10))-1):(8*((16*1)+9))];
	assign current_matrix [1][10][7:0] = current [((8*((16*1)+11))-1):(8*((16*1)+10))];
	assign current_matrix [1][11][7:0] = current [((8*((16*1)+12))-1):(8*((16*1)+11))];
	assign current_matrix [1][12][7:0] = current [((8*((16*1)+13))-1):(8*((16*1)+12))];
	assign current_matrix [1][13][7:0] = current [((8*((16*1)+14))-1):(8*((16*1)+13))];
	assign current_matrix [1][14][7:0] = current [((8*((16*1)+15))-1):(8*((16*1)+14))];
	assign current_matrix [1][15][7:0] = current [((8*((16*1)+16))-1):(8*((16*1)+15))];
	
	assign current_matrix [2][0][7:0] = current [((8*((16*2)+1))-1):(8*((16*2)+0))];
	assign current_matrix [2][1][7:0] = current [((8*((16*2)+2))-1):(8*((16*2)+1))];
	assign current_matrix [2][2][7:0] = current [((8*((16*2)+3))-1):(8*((16*2)+2))];
	assign current_matrix [2][3][7:0] = current [((8*((16*2)+4))-1):(8*((16*2)+3))];
	assign current_matrix [2][4][7:0] = current [((8*((16*2)+5))-1):(8*((16*2)+4))];
	assign current_matrix [2][5][7:0] = current [((8*((16*2)+6))-1):(8*((16*2)+5))];
	assign current_matrix [2][6][7:0] = current [((8*((16*2)+7))-1):(8*((16*2)+6))];
	assign current_matrix [2][7][7:0] = current [((8*((16*2)+8))-1):(8*((16*2)+7))];
	assign current_matrix [2][8][7:0] = current [((8*((16*2)+9))-1):(8*((16*2)+8))];
	assign current_matrix [2][9][7:0] = current [((8*((16*2)+10))-1):(8*((16*2)+9))];
	assign current_matrix [2][10][7:0] = current [((8*((16*2)+11))-1):(8*((16*2)+10))];
	assign current_matrix [2][11][7:0] = current [((8*((16*2)+12))-1):(8*((16*2)+11))];
	assign current_matrix [2][12][7:0] = current [((8*((16*2)+13))-1):(8*((16*2)+12))];
	assign current_matrix [2][13][7:0] = current [((8*((16*2)+14))-1):(8*((16*2)+13))];
	assign current_matrix [2][14][7:0] = current [((8*((16*2)+15))-1):(8*((16*2)+14))];
	assign current_matrix [2][15][7:0] = current [((8*((16*2)+16))-1):(8*((16*2)+15))];
	
	assign current_matrix [3][0][7:0] = current [((8*((16*3)+1))-1):(8*((16*3)+0))];
	assign current_matrix [3][1][7:0] = current [((8*((16*3)+2))-1):(8*((16*3)+1))];
	assign current_matrix [3][2][7:0] = current [((8*((16*3)+3))-1):(8*((16*3)+2))];
	assign current_matrix [3][3][7:0] = current [((8*((16*3)+4))-1):(8*((16*3)+3))];
	assign current_matrix [3][4][7:0] = current [((8*((16*3)+5))-1):(8*((16*3)+4))];
	assign current_matrix [3][5][7:0] = current [((8*((16*3)+6))-1):(8*((16*3)+5))];
	assign current_matrix [3][6][7:0] = current [((8*((16*3)+7))-1):(8*((16*3)+6))];
	assign current_matrix [3][7][7:0] = current [((8*((16*3)+8))-1):(8*((16*3)+7))];
	assign current_matrix [3][8][7:0] = current [((8*((16*3)+9))-1):(8*((16*3)+8))];
	assign current_matrix [3][9][7:0] = current [((8*((16*3)+10))-1):(8*((16*3)+9))];
	assign current_matrix [3][10][7:0] = current [((8*((16*3)+11))-1):(8*((16*3)+10))];
	assign current_matrix [3][11][7:0] = current [((8*((16*3)+12))-1):(8*((16*3)+11))];
	assign current_matrix [3][12][7:0] = current [((8*((16*3)+13))-1):(8*((16*3)+12))];
	assign current_matrix [3][13][7:0] = current [((8*((16*3)+14))-1):(8*((16*3)+13))];
	assign current_matrix [3][14][7:0] = current [((8*((16*3)+15))-1):(8*((16*3)+14))];
	assign current_matrix [3][15][7:0] = current [((8*((16*3)+16))-1):(8*((16*3)+15))];
	
	assign current_matrix [4][0][7:0] = current [((8*((16*4)+1))-1):(8*((16*4)+0))];
	assign current_matrix [4][1][7:0] = current [((8*((16*4)+2))-1):(8*((16*4)+1))];
	assign current_matrix [4][2][7:0] = current [((8*((16*4)+3))-1):(8*((16*4)+2))];
	assign current_matrix [4][3][7:0] = current [((8*((16*4)+4))-1):(8*((16*4)+3))];
	assign current_matrix [4][4][7:0] = current [((8*((16*4)+5))-1):(8*((16*4)+4))];
	assign current_matrix [4][5][7:0] = current [((8*((16*4)+6))-1):(8*((16*4)+5))];
	assign current_matrix [4][6][7:0] = current [((8*((16*4)+7))-1):(8*((16*4)+6))];
	assign current_matrix [4][7][7:0] = current [((8*((16*4)+8))-1):(8*((16*4)+7))];
	assign current_matrix [4][8][7:0] = current [((8*((16*4)+9))-1):(8*((16*4)+8))];
	assign current_matrix [4][9][7:0] = current [((8*((16*4)+10))-1):(8*((16*4)+9))];
	assign current_matrix [4][10][7:0] = current [((8*((16*4)+11))-1):(8*((16*4)+10))];
	assign current_matrix [4][11][7:0] = current [((8*((16*4)+12))-1):(8*((16*4)+11))];
	assign current_matrix [4][12][7:0] = current [((8*((16*4)+13))-1):(8*((16*4)+12))];
	assign current_matrix [4][13][7:0] = current [((8*((16*4)+14))-1):(8*((16*4)+13))];
	assign current_matrix [4][14][7:0] = current [((8*((16*4)+15))-1):(8*((16*4)+14))];
	assign current_matrix [4][15][7:0] = current [((8*((16*4)+16))-1):(8*((16*4)+15))];
	
	assign current_matrix [5][0][7:0] = current [((8*((16*5)+1))-1):(8*((16*5)+0))];
	assign current_matrix [5][1][7:0] = current [((8*((16*5)+2))-1):(8*((16*5)+1))];
	assign current_matrix [5][2][7:0] = current [((8*((16*5)+3))-1):(8*((16*5)+2))];
	assign current_matrix [5][3][7:0] = current [((8*((16*5)+4))-1):(8*((16*5)+3))];
	assign current_matrix [5][4][7:0] = current [((8*((16*5)+5))-1):(8*((16*5)+4))];
	assign current_matrix [5][5][7:0] = current [((8*((16*5)+6))-1):(8*((16*5)+5))];
	assign current_matrix [5][6][7:0] = current [((8*((16*5)+7))-1):(8*((16*5)+6))];
	assign current_matrix [5][7][7:0] = current [((8*((16*5)+8))-1):(8*((16*5)+7))];
	assign current_matrix [5][8][7:0] = current [((8*((16*5)+9))-1):(8*((16*5)+8))];
	assign current_matrix [5][9][7:0] = current [((8*((16*5)+10))-1):(8*((16*5)+9))];
	assign current_matrix [5][10][7:0] = current [((8*((16*5)+11))-1):(8*((16*5)+10))];
	assign current_matrix [5][11][7:0] = current [((8*((16*5)+12))-1):(8*((16*5)+11))];
	assign current_matrix [5][12][7:0] = current [((8*((16*5)+13))-1):(8*((16*5)+12))];
	assign current_matrix [5][13][7:0] = current [((8*((16*5)+14))-1):(8*((16*5)+13))];
	assign current_matrix [5][14][7:0] = current [((8*((16*5)+15))-1):(8*((16*5)+14))];
	assign current_matrix [5][15][7:0] = current [((8*((16*5)+16))-1):(8*((16*5)+15))];
	
	assign current_matrix [6][0][7:0] = current [((8*((16*6)+1))-1):(8*((16*6)+0))];
	assign current_matrix [6][1][7:0] = current [((8*((16*6)+2))-1):(8*((16*6)+1))];
	assign current_matrix [6][2][7:0] = current [((8*((16*6)+3))-1):(8*((16*6)+2))];
	assign current_matrix [6][3][7:0] = current [((8*((16*6)+4))-1):(8*((16*6)+3))];
	assign current_matrix [6][4][7:0] = current [((8*((16*6)+5))-1):(8*((16*6)+4))];
	assign current_matrix [6][5][7:0] = current [((8*((16*6)+6))-1):(8*((16*6)+5))];
	assign current_matrix [6][6][7:0] = current [((8*((16*6)+7))-1):(8*((16*6)+6))];
	assign current_matrix [6][7][7:0] = current [((8*((16*6)+8))-1):(8*((16*6)+7))];
	assign current_matrix [6][8][7:0] = current [((8*((16*6)+9))-1):(8*((16*6)+8))];
	assign current_matrix [6][9][7:0] = current [((8*((16*6)+10))-1):(8*((16*6)+9))];
	assign current_matrix [6][10][7:0] = current [((8*((16*6)+11))-1):(8*((16*6)+10))];
	assign current_matrix [6][11][7:0] = current [((8*((16*6)+12))-1):(8*((16*6)+11))];
	assign current_matrix [6][12][7:0] = current [((8*((16*6)+13))-1):(8*((16*6)+12))];
	assign current_matrix [6][13][7:0] = current [((8*((16*6)+14))-1):(8*((16*6)+13))];
	assign current_matrix [6][14][7:0] = current [((8*((16*6)+15))-1):(8*((16*6)+14))];
	assign current_matrix [6][15][7:0] = current [((8*((16*6)+16))-1):(8*((16*6)+15))];
	
	assign current_matrix [7][0][7:0] = current [((8*((16*7)+1))-1):(8*((16*7)+0))];
	assign current_matrix [7][1][7:0] = current [((8*((16*7)+2))-1):(8*((16*7)+1))];
	assign current_matrix [7][2][7:0] = current [((8*((16*7)+3))-1):(8*((16*7)+2))];
	assign current_matrix [7][3][7:0] = current [((8*((16*7)+4))-1):(8*((16*7)+3))];
	assign current_matrix [7][4][7:0] = current [((8*((16*7)+5))-1):(8*((16*7)+4))];
	assign current_matrix [7][5][7:0] = current [((8*((16*7)+6))-1):(8*((16*7)+5))];
	assign current_matrix [7][6][7:0] = current [((8*((16*7)+7))-1):(8*((16*7)+6))];
	assign current_matrix [7][7][7:0] = current [((8*((16*7)+8))-1):(8*((16*7)+7))];
	assign current_matrix [7][8][7:0] = current [((8*((16*7)+9))-1):(8*((16*7)+8))];
	assign current_matrix [7][9][7:0] = current [((8*((16*7)+10))-1):(8*((16*7)+9))];
	assign current_matrix [7][10][7:0] = current [((8*((16*7)+11))-1):(8*((16*7)+10))];
	assign current_matrix [7][11][7:0] = current [((8*((16*7)+12))-1):(8*((16*7)+11))];
	assign current_matrix [7][12][7:0] = current [((8*((16*7)+13))-1):(8*((16*7)+12))];
	assign current_matrix [7][13][7:0] = current [((8*((16*7)+14))-1):(8*((16*7)+13))];
	assign current_matrix [7][14][7:0] = current [((8*((16*7)+15))-1):(8*((16*7)+14))];
	assign current_matrix [7][15][7:0] = current [((8*((16*7)+16))-1):(8*((16*7)+15))];
	
	assign current_matrix [8][0][7:0] = current [((8*((16*8)+1))-1):(8*((16*8)+0))];
	assign current_matrix [8][1][7:0] = current [((8*((16*8)+2))-1):(8*((16*8)+1))];
	assign current_matrix [8][2][7:0] = current [((8*((16*8)+3))-1):(8*((16*8)+2))];
	assign current_matrix [8][3][7:0] = current [((8*((16*8)+4))-1):(8*((16*8)+3))];
	assign current_matrix [8][4][7:0] = current [((8*((16*8)+5))-1):(8*((16*8)+4))];
	assign current_matrix [8][5][7:0] = current [((8*((16*8)+6))-1):(8*((16*8)+5))];
	assign current_matrix [8][6][7:0] = current [((8*((16*8)+7))-1):(8*((16*8)+6))];
	assign current_matrix [8][7][7:0] = current [((8*((16*8)+8))-1):(8*((16*8)+7))];
	assign current_matrix [8][8][7:0] = current [((8*((16*8)+9))-1):(8*((16*8)+8))];
	assign current_matrix [8][9][7:0] = current [((8*((16*8)+10))-1):(8*((16*8)+9))];
	assign current_matrix [8][10][7:0] = current [((8*((16*8)+11))-1):(8*((16*8)+10))];
	assign current_matrix [8][11][7:0] = current [((8*((16*8)+12))-1):(8*((16*8)+11))];
	assign current_matrix [8][12][7:0] = current [((8*((16*8)+13))-1):(8*((16*8)+12))];
	assign current_matrix [8][13][7:0] = current [((8*((16*8)+14))-1):(8*((16*8)+13))];
	assign current_matrix [8][14][7:0] = current [((8*((16*8)+15))-1):(8*((16*8)+14))];
	assign current_matrix [8][15][7:0] = current [((8*((16*8)+16))-1):(8*((16*8)+15))];
	
	assign current_matrix [9][0][7:0] = current [((8*((16*9)+1))-1):(8*((16*9)+0))];
	assign current_matrix [9][1][7:0] = current [((8*((16*9)+2))-1):(8*((16*9)+1))];
	assign current_matrix [9][2][7:0] = current [((8*((16*9)+3))-1):(8*((16*9)+2))];
	assign current_matrix [9][3][7:0] = current [((8*((16*9)+4))-1):(8*((16*9)+3))];
	assign current_matrix [9][4][7:0] = current [((8*((16*9)+5))-1):(8*((16*9)+4))];
	assign current_matrix [9][5][7:0] = current [((8*((16*9)+6))-1):(8*((16*9)+5))];
	assign current_matrix [9][6][7:0] = current [((8*((16*9)+7))-1):(8*((16*9)+6))];
	assign current_matrix [9][7][7:0] = current [((8*((16*9)+8))-1):(8*((16*9)+7))];
	assign current_matrix [9][8][7:0] = current [((8*((16*9)+9))-1):(8*((16*9)+8))];
	assign current_matrix [9][9][7:0] = current [((8*((16*9)+10))-1):(8*((16*9)+9))];
	assign current_matrix [9][10][7:0] = current [((8*((16*9)+11))-1):(8*((16*9)+10))];
	assign current_matrix [9][11][7:0] = current [((8*((16*9)+12))-1):(8*((16*9)+11))];
	assign current_matrix [9][12][7:0] = current [((8*((16*9)+13))-1):(8*((16*9)+12))];
	assign current_matrix [9][13][7:0] = current [((8*((16*9)+14))-1):(8*((16*9)+13))];
	assign current_matrix [9][14][7:0] = current [((8*((16*9)+15))-1):(8*((16*9)+14))];
	assign current_matrix [9][15][7:0] = current [((8*((16*9)+16))-1):(8*((16*9)+15))];
	
	assign current_matrix [10][0][7:0] = current [((8*((16*10)+1))-1):(8*((16*10)+0))];
	assign current_matrix [10][1][7:0] = current [((8*((16*10)+2))-1):(8*((16*10)+1))];
	assign current_matrix [10][2][7:0] = current [((8*((16*10)+3))-1):(8*((16*10)+2))];
	assign current_matrix [10][3][7:0] = current [((8*((16*10)+4))-1):(8*((16*10)+3))];
	assign current_matrix [10][4][7:0] = current [((8*((16*10)+5))-1):(8*((16*10)+4))];
	assign current_matrix [10][5][7:0] = current [((8*((16*10)+6))-1):(8*((16*10)+5))];
	assign current_matrix [10][6][7:0] = current [((8*((16*10)+7))-1):(8*((16*10)+6))];
	assign current_matrix [10][7][7:0] = current [((8*((16*10)+8))-1):(8*((16*10)+7))];
	assign current_matrix [10][8][7:0] = current [((8*((16*10)+9))-1):(8*((16*10)+8))];
	assign current_matrix [10][9][7:0] = current [((8*((16*10)+10))-1):(8*((16*10)+9))];
	assign current_matrix [10][10][7:0] = current [((8*((16*10)+11))-1):(8*((16*10)+10))];
	assign current_matrix [10][11][7:0] = current [((8*((16*10)+12))-1):(8*((16*10)+11))];
	assign current_matrix [10][12][7:0] = current [((8*((16*10)+13))-1):(8*((16*10)+12))];
	assign current_matrix [10][13][7:0] = current [((8*((16*10)+14))-1):(8*((16*10)+13))];
	assign current_matrix [10][14][7:0] = current [((8*((16*10)+15))-1):(8*((16*10)+14))];
	assign current_matrix [10][15][7:0] = current [((8*((16*10)+16))-1):(8*((16*10)+15))];
	
	assign current_matrix [11][0][7:0] = current [((8*((16*11)+1))-1):(8*((16*11)+0))];
	assign current_matrix [11][1][7:0] = current [((8*((16*11)+2))-1):(8*((16*11)+1))];
	assign current_matrix [11][2][7:0] = current [((8*((16*11)+3))-1):(8*((16*11)+2))];
	assign current_matrix [11][3][7:0] = current [((8*((16*11)+4))-1):(8*((16*11)+3))];
	assign current_matrix [11][4][7:0] = current [((8*((16*11)+5))-1):(8*((16*11)+4))];
	assign current_matrix [11][5][7:0] = current [((8*((16*11)+6))-1):(8*((16*11)+5))];
	assign current_matrix [11][6][7:0] = current [((8*((16*11)+7))-1):(8*((16*11)+6))];
	assign current_matrix [11][7][7:0] = current [((8*((16*11)+8))-1):(8*((16*11)+7))];
	assign current_matrix [11][8][7:0] = current [((8*((16*11)+9))-1):(8*((16*11)+8))];
	assign current_matrix [11][9][7:0] = current [((8*((16*11)+10))-1):(8*((16*11)+9))];
	assign current_matrix [11][10][7:0] = current [((8*((16*11)+11))-1):(8*((16*11)+10))];
	assign current_matrix [11][11][7:0] = current [((8*((16*11)+12))-1):(8*((16*11)+11))];
	assign current_matrix [11][12][7:0] = current [((8*((16*11)+13))-1):(8*((16*11)+12))];
	assign current_matrix [11][13][7:0] = current [((8*((16*11)+14))-1):(8*((16*11)+13))];
	assign current_matrix [11][14][7:0] = current [((8*((16*11)+15))-1):(8*((16*11)+14))];
	assign current_matrix [11][15][7:0] = current [((8*((16*11)+16))-1):(8*((16*11)+15))];
	
	assign current_matrix [12][0][7:0] = current [((8*((16*12)+1))-1):(8*((16*12)+0))];
	assign current_matrix [12][1][7:0] = current [((8*((16*12)+2))-1):(8*((16*12)+1))];
	assign current_matrix [12][2][7:0] = current [((8*((16*12)+3))-1):(8*((16*12)+2))];
	assign current_matrix [12][3][7:0] = current [((8*((16*12)+4))-1):(8*((16*12)+3))];
	assign current_matrix [12][4][7:0] = current [((8*((16*12)+5))-1):(8*((16*12)+4))];
	assign current_matrix [12][5][7:0] = current [((8*((16*12)+6))-1):(8*((16*12)+5))];
	assign current_matrix [12][6][7:0] = current [((8*((16*12)+7))-1):(8*((16*12)+6))];
	assign current_matrix [12][7][7:0] = current [((8*((16*12)+8))-1):(8*((16*12)+7))];
	assign current_matrix [12][8][7:0] = current [((8*((16*12)+9))-1):(8*((16*12)+8))];
	assign current_matrix [12][9][7:0] = current [((8*((16*12)+10))-1):(8*((16*12)+9))];
	assign current_matrix [12][10][7:0] = current [((8*((16*12)+11))-1):(8*((16*12)+10))];
	assign current_matrix [12][11][7:0] = current [((8*((16*12)+12))-1):(8*((16*12)+11))];
	assign current_matrix [12][12][7:0] = current [((8*((16*12)+13))-1):(8*((16*12)+12))];
	assign current_matrix [12][13][7:0] = current [((8*((16*12)+14))-1):(8*((16*12)+13))];
	assign current_matrix [12][14][7:0] = current [((8*((16*12)+15))-1):(8*((16*12)+14))];
	assign current_matrix [12][15][7:0] = current [((8*((16*12)+16))-1):(8*((16*12)+15))];
	
	assign current_matrix [13][0][7:0] = current [((8*((16*13)+1))-1):(8*((16*13)+0))];
	assign current_matrix [13][1][7:0] = current [((8*((16*13)+2))-1):(8*((16*13)+1))];
	assign current_matrix [13][2][7:0] = current [((8*((16*13)+3))-1):(8*((16*13)+2))];
	assign current_matrix [13][3][7:0] = current [((8*((16*13)+4))-1):(8*((16*13)+3))];
	assign current_matrix [13][4][7:0] = current [((8*((16*13)+5))-1):(8*((16*13)+4))];
	assign current_matrix [13][5][7:0] = current [((8*((16*13)+6))-1):(8*((16*13)+5))];
	assign current_matrix [13][6][7:0] = current [((8*((16*13)+7))-1):(8*((16*13)+6))];
	assign current_matrix [13][7][7:0] = current [((8*((16*13)+8))-1):(8*((16*13)+7))];
	assign current_matrix [13][8][7:0] = current [((8*((16*13)+9))-1):(8*((16*13)+8))];
	assign current_matrix [13][9][7:0] = current [((8*((16*13)+10))-1):(8*((16*13)+9))];
	assign current_matrix [13][10][7:0] = current [((8*((16*13)+11))-1):(8*((16*13)+10))];
	assign current_matrix [13][11][7:0] = current [((8*((16*13)+12))-1):(8*((16*13)+11))];
	assign current_matrix [13][12][7:0] = current [((8*((16*13)+13))-1):(8*((16*13)+12))];
	assign current_matrix [13][13][7:0] = current [((8*((16*13)+14))-1):(8*((16*13)+13))];
	assign current_matrix [13][14][7:0] = current [((8*((16*13)+15))-1):(8*((16*13)+14))];
	assign current_matrix [13][15][7:0] = current [((8*((16*13)+16))-1):(8*((16*13)+15))];
	
	assign current_matrix [14][0][7:0] = current [((8*((16*14)+1))-1):(8*((16*14)+0))];
	assign current_matrix [14][1][7:0] = current [((8*((16*14)+2))-1):(8*((16*14)+1))];
	assign current_matrix [14][2][7:0] = current [((8*((16*14)+3))-1):(8*((16*14)+2))];
	assign current_matrix [14][3][7:0] = current [((8*((16*14)+4))-1):(8*((16*14)+3))];
	assign current_matrix [14][4][7:0] = current [((8*((16*14)+5))-1):(8*((16*14)+4))];
	assign current_matrix [14][5][7:0] = current [((8*((16*14)+6))-1):(8*((16*14)+5))];
	assign current_matrix [14][6][7:0] = current [((8*((16*14)+7))-1):(8*((16*14)+6))];
	assign current_matrix [14][7][7:0] = current [((8*((16*14)+8))-1):(8*((16*14)+7))];
	assign current_matrix [14][8][7:0] = current [((8*((16*14)+9))-1):(8*((16*14)+8))];
	assign current_matrix [14][9][7:0] = current [((8*((16*14)+10))-1):(8*((16*14)+9))];
	assign current_matrix [14][10][7:0] = current [((8*((16*14)+11))-1):(8*((16*14)+10))];
	assign current_matrix [14][11][7:0] = current [((8*((16*14)+12))-1):(8*((16*14)+11))];
	assign current_matrix [14][12][7:0] = current [((8*((16*14)+13))-1):(8*((16*14)+12))];
	assign current_matrix [14][13][7:0] = current [((8*((16*14)+14))-1):(8*((16*14)+13))];
	assign current_matrix [14][14][7:0] = current [((8*((16*14)+15))-1):(8*((16*14)+14))];
	assign current_matrix [14][15][7:0] = current [((8*((16*14)+16))-1):(8*((16*14)+15))];
	
	assign current_matrix [15][0][7:0] = current [((8*((16*15)+1))-1):(8*((16*15)+0))];
	assign current_matrix [15][1][7:0] = current [((8*((16*15)+2))-1):(8*((16*15)+1))];
	assign current_matrix [15][2][7:0] = current [((8*((16*15)+3))-1):(8*((16*15)+2))];
	assign current_matrix [15][3][7:0] = current [((8*((16*15)+4))-1):(8*((16*15)+3))];
	assign current_matrix [15][4][7:0] = current [((8*((16*15)+5))-1):(8*((16*15)+4))];
	assign current_matrix [15][5][7:0] = current [((8*((16*15)+6))-1):(8*((16*15)+5))];
	assign current_matrix [15][6][7:0] = current [((8*((16*15)+7))-1):(8*((16*15)+6))];
	assign current_matrix [15][7][7:0] = current [((8*((16*15)+8))-1):(8*((16*15)+7))];
	assign current_matrix [15][8][7:0] = current [((8*((16*15)+9))-1):(8*((16*15)+8))];
	assign current_matrix [15][9][7:0] = current [((8*((16*15)+10))-1):(8*((16*15)+9))];
	assign current_matrix [15][10][7:0] = current [((8*((16*15)+11))-1):(8*((16*15)+10))];
	assign current_matrix [15][11][7:0] = current [((8*((16*15)+12))-1):(8*((16*15)+11))];
	assign current_matrix [15][12][7:0] = current [((8*((16*15)+13))-1):(8*((16*15)+12))];
	assign current_matrix [15][13][7:0] = current [((8*((16*15)+14))-1):(8*((16*15)+13))];
	assign current_matrix [15][14][7:0] = current [((8*((16*15)+15))-1):(8*((16*15)+14))];
	assign current_matrix [15][15][7:0] = current [((8*((16*15)+16))-1):(8*((16*15)+15))];
	
	//
	wire [7:0] inputA [15:0][15:0];
	wire [7:0] inputB [15:0][15:0];	

	assign inputA[0][0][7:0] = (search_matrix [0][0][7:0] < current_matrix [0][0][7:0]) ? current_matrix [0][0][7:0] : search_matrix [0][0][7:0];
	assign inputB[0][0][7:0] = (search_matrix [0][0][7:0] < current_matrix [0][0][7:0]) ? search_matrix [0][0][7:0] : current_matrix [0][0][7:0];
	assign difference_matrix[0][0][7:0] = inputA [0][0][7:0] - inputB [0][0][7:0];
	
	assign inputA[0][1][7:0] = (search_matrix [0][1][7:0] < current_matrix [0][1][7:0]) ? current_matrix [0][1][7:0] : search_matrix [0][1][7:0];
	assign inputB[0][1][7:0] = (search_matrix [0][1][7:0] < current_matrix [0][1][7:0]) ? search_matrix [0][1][7:0] : current_matrix [0][1][7:0];
	assign difference_matrix[0][1][7:0] = inputA [0][1][7:0] - inputB [0][1][7:0];
	
	assign inputA[0][2][7:0] = (search_matrix [0][2][7:0] < current_matrix [0][2][7:0]) ? current_matrix [0][2][7:0] : search_matrix [0][2][7:0];
	assign inputB[0][2][7:0] = (search_matrix [0][2][7:0] < current_matrix [0][2][7:0]) ? search_matrix [0][2][7:0] : current_matrix [0][2][7:0];
	assign difference_matrix[0][2][7:0] = inputA [0][2][7:0] - inputB [0][2][7:0];
	
	assign inputA[0][3][7:0] = (search_matrix [0][3][7:0] < current_matrix [0][3][7:0]) ? current_matrix [0][3][7:0] : search_matrix [0][3][7:0];
	assign inputB[0][3][7:0] = (search_matrix [0][3][7:0] < current_matrix [0][3][7:0]) ? search_matrix [0][3][7:0] : current_matrix [0][3][7:0];
	assign difference_matrix[0][3][7:0] = inputA [0][3][7:0] - inputB [0][3][7:0];
	
	assign inputA[0][4][7:0] = (search_matrix [0][4][7:0] < current_matrix [0][4][7:0]) ? current_matrix [0][4][7:0] : search_matrix [0][4][7:0];
	assign inputB[0][4][7:0] = (search_matrix [0][4][7:0] < current_matrix [0][4][7:0]) ? search_matrix [0][4][7:0] : current_matrix [0][4][7:0];
	assign difference_matrix[0][4][7:0] = inputA [0][4][7:0] - inputB [0][4][7:0];
	
	assign inputA[0][5][7:0] = (search_matrix [0][5][7:0] < current_matrix [0][5][7:0]) ? current_matrix [0][5][7:0] : search_matrix [0][5][7:0];
	assign inputB[0][5][7:0] = (search_matrix [0][5][7:0] < current_matrix [0][5][7:0]) ? search_matrix [0][5][7:0] : current_matrix [0][5][7:0];
	assign difference_matrix[0][5][7:0] = inputA [0][5][7:0] - inputB [0][5][7:0];
	
	assign inputA[0][6][7:0] = (search_matrix [0][6][7:0] < current_matrix [0][6][7:0]) ? current_matrix [0][6][7:0] : search_matrix [0][6][7:0];
	assign inputB[0][6][7:0] = (search_matrix [0][6][7:0] < current_matrix [0][6][7:0]) ? search_matrix [0][6][7:0] : current_matrix [0][6][7:0];
	assign difference_matrix[0][6][7:0] = inputA [0][6][7:0] - inputB [0][6][7:0];
	
	assign inputA[0][7][7:0] = (search_matrix [0][7][7:0] < current_matrix [0][7][7:0]) ? current_matrix [0][7][7:0] : search_matrix [0][7][7:0];
	assign inputB[0][7][7:0] = (search_matrix [0][7][7:0] < current_matrix [0][7][7:0]) ? search_matrix [0][7][7:0] : current_matrix [0][7][7:0];
	assign difference_matrix[0][7][7:0] = inputA [0][7][7:0] - inputB [0][7][7:0];
	
	assign inputA[0][8][7:0] = (search_matrix [0][8][7:0] < current_matrix [0][8][7:0]) ? current_matrix [0][8][7:0] : search_matrix [0][8][7:0];
	assign inputB[0][8][7:0] = (search_matrix [0][8][7:0] < current_matrix [0][8][7:0]) ? search_matrix [0][8][7:0] : current_matrix [0][8][7:0];
	assign difference_matrix[0][8][7:0] = inputA [0][8][7:0] - inputB [0][8][7:0];
	
	assign inputA[0][9][7:0] = (search_matrix [0][9][7:0] < current_matrix [0][9][7:0]) ? current_matrix [0][9][7:0] : search_matrix [0][9][7:0];
	assign inputB[0][9][7:0] = (search_matrix [0][9][7:0] < current_matrix [0][9][7:0]) ? search_matrix [0][9][7:0] : current_matrix [0][9][7:0];
	assign difference_matrix[0][9][7:0] = inputA [0][9][7:0] - inputB [0][9][7:0];
	
	assign inputA[0][10][7:0] = (search_matrix [0][10][7:0] < current_matrix [0][10][7:0]) ? current_matrix [0][10][7:0] : search_matrix [0][10][7:0];
	assign inputB[0][10][7:0] = (search_matrix [0][10][7:0] < current_matrix [0][10][7:0]) ? search_matrix [0][10][7:0] : current_matrix [0][10][7:0];
	assign difference_matrix[0][10][7:0] = inputA [0][10][7:0] - inputB [0][10][7:0];
	
	assign inputA[0][11][7:0] = (search_matrix [0][11][7:0] < current_matrix [0][11][7:0]) ? current_matrix [0][11][7:0] : search_matrix [0][11][7:0];
	assign inputB[0][11][7:0] = (search_matrix [0][11][7:0] < current_matrix [0][11][7:0]) ? search_matrix [0][11][7:0] : current_matrix [0][11][7:0];
	assign difference_matrix[0][11][7:0] = inputA [0][11][7:0] - inputB [0][11][7:0];
	
	assign inputA[0][12][7:0] = (search_matrix [0][12][7:0] < current_matrix [0][12][7:0]) ? current_matrix [0][12][7:0] : search_matrix [0][12][7:0];
	assign inputB[0][12][7:0] = (search_matrix [0][12][7:0] < current_matrix [0][12][7:0]) ? search_matrix [0][12][7:0] : current_matrix [0][12][7:0];
	assign difference_matrix[0][12][7:0] = inputA [0][12][7:0] - inputB [0][12][7:0];
	
	assign inputA[0][13][7:0] = (search_matrix [0][13][7:0] < current_matrix [0][13][7:0]) ? current_matrix [0][13][7:0] : search_matrix [0][13][7:0];
	assign inputB[0][13][7:0] = (search_matrix [0][13][7:0] < current_matrix [0][13][7:0]) ? search_matrix [0][13][7:0] : current_matrix [0][13][7:0];
	assign difference_matrix[0][13][7:0] = inputA [0][13][7:0] - inputB [0][13][7:0];
	
	assign inputA[0][14][7:0] = (search_matrix [0][14][7:0] < current_matrix [0][14][7:0]) ? current_matrix [0][14][7:0] : search_matrix [0][14][7:0];
	assign inputB[0][14][7:0] = (search_matrix [0][14][7:0] < current_matrix [0][14][7:0]) ? search_matrix [0][14][7:0] : current_matrix [0][14][7:0];
	assign difference_matrix[0][14][7:0] = inputA [0][14][7:0] - inputB [0][14][7:0];
	
	assign inputA[0][15][7:0] = (search_matrix [0][15][7:0] < current_matrix [0][15][7:0]) ? current_matrix [0][15][7:0] : search_matrix [0][15][7:0];
	assign inputB[0][15][7:0] = (search_matrix [0][15][7:0] < current_matrix [0][15][7:0]) ? search_matrix [0][15][7:0] : current_matrix [0][15][7:0];
	assign difference_matrix[0][15][7:0] = inputA [0][15][7:0] - inputB [0][15][7:0];
	
	assign inputA[1][0][7:0] = (search_matrix [1][0][7:0] < current_matrix [1][0][7:0]) ? current_matrix [1][0][7:0] : search_matrix [1][0][7:0];
	assign inputB[1][0][7:0] = (search_matrix [1][0][7:0] < current_matrix [1][0][7:0]) ? search_matrix [1][0][7:0] : current_matrix [1][0][7:0];
	assign difference_matrix[1][0][7:0] = inputA [1][0][7:0] - inputB [1][0][7:0];
	
	assign inputA[1][1][7:0] = (search_matrix [1][1][7:0] < current_matrix [1][1][7:0]) ? current_matrix [1][1][7:0] : search_matrix [1][1][7:0];
	assign inputB[1][1][7:0] = (search_matrix [1][1][7:0] < current_matrix [1][1][7:0]) ? search_matrix [1][1][7:0] : current_matrix [1][1][7:0];
	assign difference_matrix[1][1][7:0] = inputA [1][1][7:0] - inputB [1][1][7:0];
	
	assign inputA[1][2][7:0] = (search_matrix [1][2][7:0] < current_matrix [1][2][7:0]) ? current_matrix [1][2][7:0] : search_matrix [1][2][7:0];
	assign inputB[1][2][7:0] = (search_matrix [1][2][7:0] < current_matrix [1][2][7:0]) ? search_matrix [1][2][7:0] : current_matrix [1][2][7:0];
	assign difference_matrix[1][2][7:0] = inputA [1][2][7:0] - inputB [1][2][7:0];
	
	assign inputA[1][3][7:0] = (search_matrix [1][3][7:0] < current_matrix [1][3][7:0]) ? current_matrix [1][3][7:0] : search_matrix [1][3][7:0];
	assign inputB[1][3][7:0] = (search_matrix [1][3][7:0] < current_matrix [1][3][7:0]) ? search_matrix [1][3][7:0] : current_matrix [1][3][7:0];
	assign difference_matrix[1][3][7:0] = inputA [1][3][7:0] - inputB [1][3][7:0];
	
	assign inputA[1][4][7:0] = (search_matrix [1][4][7:0] < current_matrix [1][4][7:0]) ? current_matrix [1][4][7:0] : search_matrix [1][4][7:0];
	assign inputB[1][4][7:0] = (search_matrix [1][4][7:0] < current_matrix [1][4][7:0]) ? search_matrix [1][4][7:0] : current_matrix [1][4][7:0];
	assign difference_matrix[1][4][7:0] = inputA [1][4][7:0] - inputB [1][4][7:0];
	
	assign inputA[1][5][7:0] = (search_matrix [1][5][7:0] < current_matrix [1][5][7:0]) ? current_matrix [1][5][7:0] : search_matrix [1][5][7:0];
	assign inputB[1][5][7:0] = (search_matrix [1][5][7:0] < current_matrix [1][5][7:0]) ? search_matrix [1][5][7:0] : current_matrix [1][5][7:0];
	assign difference_matrix[1][5][7:0] = inputA [1][5][7:0] - inputB [1][5][7:0];
	
	assign inputA[1][6][7:0] = (search_matrix [1][6][7:0] < current_matrix [1][6][7:0]) ? current_matrix [1][6][7:0] : search_matrix [1][6][7:0];
	assign inputB[1][6][7:0] = (search_matrix [1][6][7:0] < current_matrix [1][6][7:0]) ? search_matrix [1][6][7:0] : current_matrix [1][6][7:0];
	assign difference_matrix[1][6][7:0] = inputA [1][6][7:0] - inputB [1][6][7:0];
	
	assign inputA[1][7][7:0] = (search_matrix [1][7][7:0] < current_matrix [1][7][7:0]) ? current_matrix [1][7][7:0] : search_matrix [1][7][7:0];
	assign inputB[1][7][7:0] = (search_matrix [1][7][7:0] < current_matrix [1][7][7:0]) ? search_matrix [1][7][7:0] : current_matrix [1][7][7:0];
	assign difference_matrix[1][7][7:0] = inputA [1][7][7:0] - inputB [1][7][7:0];
	
	assign inputA[1][8][7:0] = (search_matrix [1][8][7:0] < current_matrix [1][8][7:0]) ? current_matrix [1][8][7:0] : search_matrix [1][8][7:0];
	assign inputB[1][8][7:0] = (search_matrix [1][8][7:0] < current_matrix [1][8][7:0]) ? search_matrix [1][8][7:0] : current_matrix [1][8][7:0];
	assign difference_matrix[1][8][7:0] = inputA [1][8][7:0] - inputB [1][8][7:0];
	
	assign inputA[1][9][7:0] = (search_matrix [1][9][7:0] < current_matrix [1][9][7:0]) ? current_matrix [1][9][7:0] : search_matrix [1][9][7:0];
	assign inputB[1][9][7:0] = (search_matrix [1][9][7:0] < current_matrix [1][9][7:0]) ? search_matrix [1][9][7:0] : current_matrix [1][9][7:0];
	assign difference_matrix[1][9][7:0] = inputA [1][9][7:0] - inputB [1][9][7:0];
	
	assign inputA[1][10][7:0] = (search_matrix [1][10][7:0] < current_matrix [1][10][7:0]) ? current_matrix [1][10][7:0] : search_matrix [1][10][7:0];
	assign inputB[1][10][7:0] = (search_matrix [1][10][7:0] < current_matrix [1][10][7:0]) ? search_matrix [1][10][7:0] : current_matrix [1][10][7:0];
	assign difference_matrix[1][10][7:0] = inputA [1][10][7:0] - inputB [1][10][7:0];
	
	assign inputA[1][11][7:0] = (search_matrix [1][11][7:0] < current_matrix [1][11][7:0]) ? current_matrix [1][11][7:0] : search_matrix [1][11][7:0];
	assign inputB[1][11][7:0] = (search_matrix [1][11][7:0] < current_matrix [1][11][7:0]) ? search_matrix [1][11][7:0] : current_matrix [1][11][7:0];
	assign difference_matrix[1][11][7:0] = inputA [1][11][7:0] - inputB [1][11][7:0];
	
	assign inputA[1][12][7:0] = (search_matrix [1][12][7:0] < current_matrix [1][12][7:0]) ? current_matrix [1][12][7:0] : search_matrix [1][12][7:0];
	assign inputB[1][12][7:0] = (search_matrix [1][12][7:0] < current_matrix [1][12][7:0]) ? search_matrix [1][12][7:0] : current_matrix [1][12][7:0];
	assign difference_matrix[1][12][7:0] = inputA [1][12][7:0] - inputB [1][12][7:0];
	
	assign inputA[1][13][7:0] = (search_matrix [1][13][7:0] < current_matrix [1][13][7:0]) ? current_matrix [1][13][7:0] : search_matrix [1][13][7:0];
	assign inputB[1][13][7:0] = (search_matrix [1][13][7:0] < current_matrix [1][13][7:0]) ? search_matrix [1][13][7:0] : current_matrix [1][13][7:0];
	assign difference_matrix[1][13][7:0] = inputA [1][13][7:0] - inputB [1][13][7:0];
	
	assign inputA[1][14][7:0] = (search_matrix [1][14][7:0] < current_matrix [1][14][7:0]) ? current_matrix [1][14][7:0] : search_matrix [1][14][7:0];
	assign inputB[1][14][7:0] = (search_matrix [1][14][7:0] < current_matrix [1][14][7:0]) ? search_matrix [1][14][7:0] : current_matrix [1][14][7:0];
	assign difference_matrix[1][14][7:0] = inputA [1][14][7:0] - inputB [1][14][7:0];
	
	assign inputA[1][15][7:0] = (search_matrix [1][15][7:0] < current_matrix [1][15][7:0]) ? current_matrix [1][15][7:0] : search_matrix [1][15][7:0];
	assign inputB[1][15][7:0] = (search_matrix [1][15][7:0] < current_matrix [1][15][7:0]) ? search_matrix [1][15][7:0] : current_matrix [1][15][7:0];
	assign difference_matrix[1][15][7:0] = inputA [1][15][7:0] - inputB [1][15][7:0];
	
	assign inputA[2][0][7:0] = (search_matrix [2][0][7:0] < current_matrix [2][0][7:0]) ? current_matrix [2][0][7:0] : search_matrix [2][0][7:0];
	assign inputB[2][0][7:0] = (search_matrix [2][0][7:0] < current_matrix [2][0][7:0]) ? search_matrix [2][0][7:0] : current_matrix [2][0][7:0];
	assign difference_matrix[2][0][7:0] = inputA [2][0][7:0] - inputB [2][0][7:0];
	
	assign inputA[2][1][7:0] = (search_matrix [2][1][7:0] < current_matrix [2][1][7:0]) ? current_matrix [2][1][7:0] : search_matrix [2][1][7:0];
	assign inputB[2][1][7:0] = (search_matrix [2][1][7:0] < current_matrix [2][1][7:0]) ? search_matrix [2][1][7:0] : current_matrix [2][1][7:0];
	assign difference_matrix[2][1][7:0] = inputA [2][1][7:0] - inputB [2][1][7:0];
	
	assign inputA[2][2][7:0] = (search_matrix [2][2][7:0] < current_matrix [2][2][7:0]) ? current_matrix [2][2][7:0] : search_matrix [2][2][7:0];
	assign inputB[2][2][7:0] = (search_matrix [2][2][7:0] < current_matrix [2][2][7:0]) ? search_matrix [2][2][7:0] : current_matrix [2][2][7:0];
	assign difference_matrix[2][2][7:0] = inputA [2][2][7:0] - inputB [2][2][7:0];
	
	assign inputA[2][3][7:0] = (search_matrix [2][3][7:0] < current_matrix [2][3][7:0]) ? current_matrix [2][3][7:0] : search_matrix [2][3][7:0];
	assign inputB[2][3][7:0] = (search_matrix [2][3][7:0] < current_matrix [2][3][7:0]) ? search_matrix [2][3][7:0] : current_matrix [2][3][7:0];
	assign difference_matrix[2][3][7:0] = inputA [2][3][7:0] - inputB [2][3][7:0];
	
	assign inputA[2][4][7:0] = (search_matrix [2][4][7:0] < current_matrix [2][4][7:0]) ? current_matrix [2][4][7:0] : search_matrix [2][4][7:0];
	assign inputB[2][4][7:0] = (search_matrix [2][4][7:0] < current_matrix [2][4][7:0]) ? search_matrix [2][4][7:0] : current_matrix [2][4][7:0];
	assign difference_matrix[2][4][7:0] = inputA [2][4][7:0] - inputB [2][4][7:0];
	
	assign inputA[2][5][7:0] = (search_matrix [2][5][7:0] < current_matrix [2][5][7:0]) ? current_matrix [2][5][7:0] : search_matrix [2][5][7:0];
	assign inputB[2][5][7:0] = (search_matrix [2][5][7:0] < current_matrix [2][5][7:0]) ? search_matrix [2][5][7:0] : current_matrix [2][5][7:0];
	assign difference_matrix[2][5][7:0] = inputA [2][5][7:0] - inputB [2][5][7:0];
	
	assign inputA[2][6][7:0] = (search_matrix [2][6][7:0] < current_matrix [2][6][7:0]) ? current_matrix [2][6][7:0] : search_matrix [2][6][7:0];
	assign inputB[2][6][7:0] = (search_matrix [2][6][7:0] < current_matrix [2][6][7:0]) ? search_matrix [2][6][7:0] : current_matrix [2][6][7:0];
	assign difference_matrix[2][6][7:0] = inputA [2][6][7:0] - inputB [2][6][7:0];
	
	assign inputA[2][7][7:0] = (search_matrix [2][7][7:0] < current_matrix [2][7][7:0]) ? current_matrix [2][7][7:0] : search_matrix [2][7][7:0];
	assign inputB[2][7][7:0] = (search_matrix [2][7][7:0] < current_matrix [2][7][7:0]) ? search_matrix [2][7][7:0] : current_matrix [2][7][7:0];
	assign difference_matrix[2][7][7:0] = inputA [2][7][7:0] - inputB [2][7][7:0];
	
	assign inputA[2][8][7:0] = (search_matrix [2][8][7:0] < current_matrix [2][8][7:0]) ? current_matrix [2][8][7:0] : search_matrix [2][8][7:0];
	assign inputB[2][8][7:0] = (search_matrix [2][8][7:0] < current_matrix [2][8][7:0]) ? search_matrix [2][8][7:0] : current_matrix [2][8][7:0];
	assign difference_matrix[2][8][7:0] = inputA [2][8][7:0] - inputB [2][8][7:0];
	
	assign inputA[2][9][7:0] = (search_matrix [2][9][7:0] < current_matrix [2][9][7:0]) ? current_matrix [2][9][7:0] : search_matrix [2][9][7:0];
	assign inputB[2][9][7:0] = (search_matrix [2][9][7:0] < current_matrix [2][9][7:0]) ? search_matrix [2][9][7:0] : current_matrix [2][9][7:0];
	assign difference_matrix[2][9][7:0] = inputA [2][9][7:0] - inputB [2][9][7:0];
	
	assign inputA[2][10][7:0] = (search_matrix [2][10][7:0] < current_matrix [2][10][7:0]) ? current_matrix [2][10][7:0] : search_matrix [2][10][7:0];
	assign inputB[2][10][7:0] = (search_matrix [2][10][7:0] < current_matrix [2][10][7:0]) ? search_matrix [2][10][7:0] : current_matrix [2][10][7:0];
	assign difference_matrix[2][10][7:0] = inputA [2][10][7:0] - inputB [2][10][7:0];
	
	assign inputA[2][11][7:0] = (search_matrix [2][11][7:0] < current_matrix [2][11][7:0]) ? current_matrix [2][11][7:0] : search_matrix [2][11][7:0];
	assign inputB[2][11][7:0] = (search_matrix [2][11][7:0] < current_matrix [2][11][7:0]) ? search_matrix [2][11][7:0] : current_matrix [2][11][7:0];
	assign difference_matrix[2][11][7:0] = inputA [2][11][7:0] - inputB [2][11][7:0];
	
	assign inputA[2][12][7:0] = (search_matrix [2][12][7:0] < current_matrix [2][12][7:0]) ? current_matrix [2][12][7:0] : search_matrix [2][12][7:0];
	assign inputB[2][12][7:0] = (search_matrix [2][12][7:0] < current_matrix [2][12][7:0]) ? search_matrix [2][12][7:0] : current_matrix [2][12][7:0];
	assign difference_matrix[2][12][7:0] = inputA [2][12][7:0] - inputB [2][12][7:0];
	
	assign inputA[2][13][7:0] = (search_matrix [2][13][7:0] < current_matrix [2][13][7:0]) ? current_matrix [2][13][7:0] : search_matrix [2][13][7:0];
	assign inputB[2][13][7:0] = (search_matrix [2][13][7:0] < current_matrix [2][13][7:0]) ? search_matrix [2][13][7:0] : current_matrix [2][13][7:0];
	assign difference_matrix[2][13][7:0] = inputA [2][13][7:0] - inputB [2][13][7:0];
	
	assign inputA[2][14][7:0] = (search_matrix [2][14][7:0] < current_matrix [2][14][7:0]) ? current_matrix [2][14][7:0] : search_matrix [2][14][7:0];
	assign inputB[2][14][7:0] = (search_matrix [2][14][7:0] < current_matrix [2][14][7:0]) ? search_matrix [2][14][7:0] : current_matrix [2][14][7:0];
	assign difference_matrix[2][14][7:0] = inputA [2][14][7:0] - inputB [2][14][7:0];
	
	assign inputA[2][15][7:0] = (search_matrix [2][15][7:0] < current_matrix [2][15][7:0]) ? current_matrix [2][15][7:0] : search_matrix [2][15][7:0];
	assign inputB[2][15][7:0] = (search_matrix [2][15][7:0] < current_matrix [2][15][7:0]) ? search_matrix [2][15][7:0] : current_matrix [2][15][7:0];
	assign difference_matrix[2][15][7:0] = inputA [2][15][7:0] - inputB [2][15][7:0];
	
	assign inputA[3][0][7:0] = (search_matrix [3][0][7:0] < current_matrix [3][0][7:0]) ? current_matrix [3][0][7:0] : search_matrix [3][0][7:0];
	assign inputB[3][0][7:0] = (search_matrix [3][0][7:0] < current_matrix [3][0][7:0]) ? search_matrix [3][0][7:0] : current_matrix [3][0][7:0];
	assign difference_matrix[3][0][7:0] = inputA [3][0][7:0] - inputB [3][0][7:0];
	
	assign inputA[3][1][7:0] = (search_matrix [3][1][7:0] < current_matrix [3][1][7:0]) ? current_matrix [3][1][7:0] : search_matrix [3][1][7:0];
	assign inputB[3][1][7:0] = (search_matrix [3][1][7:0] < current_matrix [3][1][7:0]) ? search_matrix [3][1][7:0] : current_matrix [3][1][7:0];
	assign difference_matrix[3][1][7:0] = inputA [3][1][7:0] - inputB [3][1][7:0];
	
	assign inputA[3][2][7:0] = (search_matrix [3][2][7:0] < current_matrix [3][2][7:0]) ? current_matrix [3][2][7:0] : search_matrix [3][2][7:0];
	assign inputB[3][2][7:0] = (search_matrix [3][2][7:0] < current_matrix [3][2][7:0]) ? search_matrix [3][2][7:0] : current_matrix [3][2][7:0];
	assign difference_matrix[3][2][7:0] = inputA [3][2][7:0] - inputB [3][2][7:0];
	
	assign inputA[3][3][7:0] = (search_matrix [3][3][7:0] < current_matrix [3][3][7:0]) ? current_matrix [3][3][7:0] : search_matrix [3][3][7:0];
	assign inputB[3][3][7:0] = (search_matrix [3][3][7:0] < current_matrix [3][3][7:0]) ? search_matrix [3][3][7:0] : current_matrix [3][3][7:0];
	assign difference_matrix[3][3][7:0] = inputA [3][3][7:0] - inputB [3][3][7:0];
	
	assign inputA[3][4][7:0] = (search_matrix [3][4][7:0] < current_matrix [3][4][7:0]) ? current_matrix [3][4][7:0] : search_matrix [3][4][7:0];
	assign inputB[3][4][7:0] = (search_matrix [3][4][7:0] < current_matrix [3][4][7:0]) ? search_matrix [3][4][7:0] : current_matrix [3][4][7:0];
	assign difference_matrix[3][4][7:0] = inputA [3][4][7:0] - inputB [3][4][7:0];
	
	assign inputA[3][5][7:0] = (search_matrix [3][5][7:0] < current_matrix [3][5][7:0]) ? current_matrix [3][5][7:0] : search_matrix [3][5][7:0];
	assign inputB[3][5][7:0] = (search_matrix [3][5][7:0] < current_matrix [3][5][7:0]) ? search_matrix [3][5][7:0] : current_matrix [3][5][7:0];
	assign difference_matrix[3][5][7:0] = inputA [3][5][7:0] - inputB [3][5][7:0];
	
	assign inputA[3][6][7:0] = (search_matrix [3][6][7:0] < current_matrix [3][6][7:0]) ? current_matrix [3][6][7:0] : search_matrix [3][6][7:0];
	assign inputB[3][6][7:0] = (search_matrix [3][6][7:0] < current_matrix [3][6][7:0]) ? search_matrix [3][6][7:0] : current_matrix [3][6][7:0];
	assign difference_matrix[3][6][7:0] = inputA [3][6][7:0] - inputB [3][6][7:0];
	
	assign inputA[3][7][7:0] = (search_matrix [3][7][7:0] < current_matrix [3][7][7:0]) ? current_matrix [3][7][7:0] : search_matrix [3][7][7:0];
	assign inputB[3][7][7:0] = (search_matrix [3][7][7:0] < current_matrix [3][7][7:0]) ? search_matrix [3][7][7:0] : current_matrix [3][7][7:0];
	assign difference_matrix[3][7][7:0] = inputA [3][7][7:0] - inputB [3][7][7:0];
	
	assign inputA[3][8][7:0] = (search_matrix [3][8][7:0] < current_matrix [3][8][7:0]) ? current_matrix [3][8][7:0] : search_matrix [3][8][7:0];
	assign inputB[3][8][7:0] = (search_matrix [3][8][7:0] < current_matrix [3][8][7:0]) ? search_matrix [3][8][7:0] : current_matrix [3][8][7:0];
	assign difference_matrix[3][8][7:0] = inputA [3][8][7:0] - inputB [3][8][7:0];
	
	assign inputA[3][9][7:0] = (search_matrix [3][9][7:0] < current_matrix [3][9][7:0]) ? current_matrix [3][9][7:0] : search_matrix [3][9][7:0];
	assign inputB[3][9][7:0] = (search_matrix [3][9][7:0] < current_matrix [3][9][7:0]) ? search_matrix [3][9][7:0] : current_matrix [3][9][7:0];
	assign difference_matrix[3][9][7:0] = inputA [3][9][7:0] - inputB [3][9][7:0];
	
	assign inputA[3][10][7:0] = (search_matrix [3][10][7:0] < current_matrix [3][10][7:0]) ? current_matrix [3][10][7:0] : search_matrix [3][10][7:0];
	assign inputB[3][10][7:0] = (search_matrix [3][10][7:0] < current_matrix [3][10][7:0]) ? search_matrix [3][10][7:0] : current_matrix [3][10][7:0];
	assign difference_matrix[3][10][7:0] = inputA [3][10][7:0] - inputB [3][10][7:0];
	
	assign inputA[3][11][7:0] = (search_matrix [3][11][7:0] < current_matrix [3][11][7:0]) ? current_matrix [3][11][7:0] : search_matrix [3][11][7:0];
	assign inputB[3][11][7:0] = (search_matrix [3][11][7:0] < current_matrix [3][11][7:0]) ? search_matrix [3][11][7:0] : current_matrix [3][11][7:0];
	assign difference_matrix[3][11][7:0] = inputA [3][11][7:0] - inputB [3][11][7:0];
	
	assign inputA[3][12][7:0] = (search_matrix [3][12][7:0] < current_matrix [3][12][7:0]) ? current_matrix [3][12][7:0] : search_matrix [3][12][7:0];
	assign inputB[3][12][7:0] = (search_matrix [3][12][7:0] < current_matrix [3][12][7:0]) ? search_matrix [3][12][7:0] : current_matrix [3][12][7:0];
	assign difference_matrix[3][12][7:0] = inputA [3][12][7:0] - inputB [3][12][7:0];
	
	assign inputA[3][13][7:0] = (search_matrix [3][13][7:0] < current_matrix [3][13][7:0]) ? current_matrix [3][13][7:0] : search_matrix [3][13][7:0];
	assign inputB[3][13][7:0] = (search_matrix [3][13][7:0] < current_matrix [3][13][7:0]) ? search_matrix [3][13][7:0] : current_matrix [3][13][7:0];
	assign difference_matrix[3][13][7:0] = inputA [3][13][7:0] - inputB [3][13][7:0];
	
	assign inputA[3][14][7:0] = (search_matrix [3][14][7:0] < current_matrix [3][14][7:0]) ? current_matrix [3][14][7:0] : search_matrix [3][14][7:0];
	assign inputB[3][14][7:0] = (search_matrix [3][14][7:0] < current_matrix [3][14][7:0]) ? search_matrix [3][14][7:0] : current_matrix [3][14][7:0];
	assign difference_matrix[3][14][7:0] = inputA [3][14][7:0] - inputB [3][14][7:0];
	
	assign inputA[3][15][7:0] = (search_matrix [3][15][7:0] < current_matrix [3][15][7:0]) ? current_matrix [3][15][7:0] : search_matrix [3][15][7:0];
	assign inputB[3][15][7:0] = (search_matrix [3][15][7:0] < current_matrix [3][15][7:0]) ? search_matrix [3][15][7:0] : current_matrix [3][15][7:0];
	assign difference_matrix[3][15][7:0] = inputA [3][15][7:0] - inputB [3][15][7:0];
	
	assign inputA[4][0][7:0] = (search_matrix [4][0][7:0] < current_matrix [4][0][7:0]) ? current_matrix [4][0][7:0] : search_matrix [4][0][7:0];
	assign inputB[4][0][7:0] = (search_matrix [4][0][7:0] < current_matrix [4][0][7:0]) ? search_matrix [4][0][7:0] : current_matrix [4][0][7:0];
	assign difference_matrix[4][0][7:0] = inputA [4][0][7:0] - inputB [4][0][7:0];
	
	assign inputA[4][1][7:0] = (search_matrix [4][1][7:0] < current_matrix [4][1][7:0]) ? current_matrix [4][1][7:0] : search_matrix [4][1][7:0];
	assign inputB[4][1][7:0] = (search_matrix [4][1][7:0] < current_matrix [4][1][7:0]) ? search_matrix [4][1][7:0] : current_matrix [4][1][7:0];
	assign difference_matrix[4][1][7:0] = inputA [4][1][7:0] - inputB [4][1][7:0];
	
	assign inputA[4][2][7:0] = (search_matrix [4][2][7:0] < current_matrix [4][2][7:0]) ? current_matrix [4][2][7:0] : search_matrix [4][2][7:0];
	assign inputB[4][2][7:0] = (search_matrix [4][2][7:0] < current_matrix [4][2][7:0]) ? search_matrix [4][2][7:0] : current_matrix [4][2][7:0];
	assign difference_matrix[4][2][7:0] = inputA [4][2][7:0] - inputB [4][2][7:0];
	
	assign inputA[4][3][7:0] = (search_matrix [4][3][7:0] < current_matrix [4][3][7:0]) ? current_matrix [4][3][7:0] : search_matrix [4][3][7:0];
	assign inputB[4][3][7:0] = (search_matrix [4][3][7:0] < current_matrix [4][3][7:0]) ? search_matrix [4][3][7:0] : current_matrix [4][3][7:0];
	assign difference_matrix[4][3][7:0] = inputA [4][3][7:0] - inputB [4][3][7:0];
	
	assign inputA[4][4][7:0] = (search_matrix [4][4][7:0] < current_matrix [4][4][7:0]) ? current_matrix [4][4][7:0] : search_matrix [4][4][7:0];
	assign inputB[4][4][7:0] = (search_matrix [4][4][7:0] < current_matrix [4][4][7:0]) ? search_matrix [4][4][7:0] : current_matrix [4][4][7:0];
	assign difference_matrix[4][4][7:0] = inputA [4][4][7:0] - inputB [4][4][7:0];
	
	assign inputA[4][5][7:0] = (search_matrix [4][5][7:0] < current_matrix [4][5][7:0]) ? current_matrix [4][5][7:0] : search_matrix [4][5][7:0];
	assign inputB[4][5][7:0] = (search_matrix [4][5][7:0] < current_matrix [4][5][7:0]) ? search_matrix [4][5][7:0] : current_matrix [4][5][7:0];
	assign difference_matrix[4][5][7:0] = inputA [4][5][7:0] - inputB [4][5][7:0];
	
	assign inputA[4][6][7:0] = (search_matrix [4][6][7:0] < current_matrix [4][6][7:0]) ? current_matrix [4][6][7:0] : search_matrix [4][6][7:0];
	assign inputB[4][6][7:0] = (search_matrix [4][6][7:0] < current_matrix [4][6][7:0]) ? search_matrix [4][6][7:0] : current_matrix [4][6][7:0];
	assign difference_matrix[4][6][7:0] = inputA [4][6][7:0] - inputB [4][6][7:0];
	
	assign inputA[4][7][7:0] = (search_matrix [4][7][7:0] < current_matrix [4][7][7:0]) ? current_matrix [4][7][7:0] : search_matrix [4][7][7:0];
	assign inputB[4][7][7:0] = (search_matrix [4][7][7:0] < current_matrix [4][7][7:0]) ? search_matrix [4][7][7:0] : current_matrix [4][7][7:0];
	assign difference_matrix[4][7][7:0] = inputA [4][7][7:0] - inputB [4][7][7:0];
	
	assign inputA[4][8][7:0] = (search_matrix [4][8][7:0] < current_matrix [4][8][7:0]) ? current_matrix [4][8][7:0] : search_matrix [4][8][7:0];
	assign inputB[4][8][7:0] = (search_matrix [4][8][7:0] < current_matrix [4][8][7:0]) ? search_matrix [4][8][7:0] : current_matrix [4][8][7:0];
	assign difference_matrix[4][8][7:0] = inputA [4][8][7:0] - inputB [4][8][7:0];
	
	assign inputA[4][9][7:0] = (search_matrix [4][9][7:0] < current_matrix [4][9][7:0]) ? current_matrix [4][9][7:0] : search_matrix [4][9][7:0];
	assign inputB[4][9][7:0] = (search_matrix [4][9][7:0] < current_matrix [4][9][7:0]) ? search_matrix [4][9][7:0] : current_matrix [4][9][7:0];
	assign difference_matrix[4][9][7:0] = inputA [4][9][7:0] - inputB [4][9][7:0];
	
	assign inputA[4][10][7:0] = (search_matrix [4][10][7:0] < current_matrix [4][10][7:0]) ? current_matrix [4][10][7:0] : search_matrix [4][10][7:0];
	assign inputB[4][10][7:0] = (search_matrix [4][10][7:0] < current_matrix [4][10][7:0]) ? search_matrix [4][10][7:0] : current_matrix [4][10][7:0];
	assign difference_matrix[4][10][7:0] = inputA [4][10][7:0] - inputB [4][10][7:0];
	
	assign inputA[4][11][7:0] = (search_matrix [4][11][7:0] < current_matrix [4][11][7:0]) ? current_matrix [4][11][7:0] : search_matrix [4][11][7:0];
	assign inputB[4][11][7:0] = (search_matrix [4][11][7:0] < current_matrix [4][11][7:0]) ? search_matrix [4][11][7:0] : current_matrix [4][11][7:0];
	assign difference_matrix[4][11][7:0] = inputA [4][11][7:0] - inputB [4][11][7:0];
	
	assign inputA[4][12][7:0] = (search_matrix [4][12][7:0] < current_matrix [4][12][7:0]) ? current_matrix [4][12][7:0] : search_matrix [4][12][7:0];
	assign inputB[4][12][7:0] = (search_matrix [4][12][7:0] < current_matrix [4][12][7:0]) ? search_matrix [4][12][7:0] : current_matrix [4][12][7:0];
	assign difference_matrix[4][12][7:0] = inputA [4][12][7:0] - inputB [4][12][7:0];
	
	assign inputA[4][13][7:0] = (search_matrix [4][13][7:0] < current_matrix [4][13][7:0]) ? current_matrix [4][13][7:0] : search_matrix [4][13][7:0];
	assign inputB[4][13][7:0] = (search_matrix [4][13][7:0] < current_matrix [4][13][7:0]) ? search_matrix [4][13][7:0] : current_matrix [4][13][7:0];
	assign difference_matrix[4][13][7:0] = inputA [4][13][7:0] - inputB [4][13][7:0];
	
	assign inputA[4][14][7:0] = (search_matrix [4][14][7:0] < current_matrix [4][14][7:0]) ? current_matrix [4][14][7:0] : search_matrix [4][14][7:0];
	assign inputB[4][14][7:0] = (search_matrix [4][14][7:0] < current_matrix [4][14][7:0]) ? search_matrix [4][14][7:0] : current_matrix [4][14][7:0];
	assign difference_matrix[4][14][7:0] = inputA [4][14][7:0] - inputB [4][14][7:0];
	
	assign inputA[4][15][7:0] = (search_matrix [4][15][7:0] < current_matrix [4][15][7:0]) ? current_matrix [4][15][7:0] : search_matrix [4][15][7:0];
	assign inputB[4][15][7:0] = (search_matrix [4][15][7:0] < current_matrix [4][15][7:0]) ? search_matrix [4][15][7:0] : current_matrix [4][15][7:0];
	assign difference_matrix[4][15][7:0] = inputA [4][15][7:0] - inputB [4][15][7:0];
	
	assign inputA[5][0][7:0] = (search_matrix [5][0][7:0] < current_matrix [5][0][7:0]) ? current_matrix [5][0][7:0] : search_matrix [5][0][7:0];
	assign inputB[5][0][7:0] = (search_matrix [5][0][7:0] < current_matrix [5][0][7:0]) ? search_matrix [5][0][7:0] : current_matrix [5][0][7:0];
	assign difference_matrix[5][0][7:0] = inputA [5][0][7:0] - inputB [5][0][7:0];
	
	assign inputA[5][1][7:0] = (search_matrix [5][1][7:0] < current_matrix [5][1][7:0]) ? current_matrix [5][1][7:0] : search_matrix [5][1][7:0];
	assign inputB[5][1][7:0] = (search_matrix [5][1][7:0] < current_matrix [5][1][7:0]) ? search_matrix [5][1][7:0] : current_matrix [5][1][7:0];
	assign difference_matrix[5][1][7:0] = inputA [5][1][7:0] - inputB [5][1][7:0];
	
	assign inputA[5][2][7:0] = (search_matrix [5][2][7:0] < current_matrix [5][2][7:0]) ? current_matrix [5][2][7:0] : search_matrix [5][2][7:0];
	assign inputB[5][2][7:0] = (search_matrix [5][2][7:0] < current_matrix [5][2][7:0]) ? search_matrix [5][2][7:0] : current_matrix [5][2][7:0];
	assign difference_matrix[5][2][7:0] = inputA [5][2][7:0] - inputB [5][2][7:0];
	
	assign inputA[5][3][7:0] = (search_matrix [5][3][7:0] < current_matrix [5][3][7:0]) ? current_matrix [5][3][7:0] : search_matrix [5][3][7:0];
	assign inputB[5][3][7:0] = (search_matrix [5][3][7:0] < current_matrix [5][3][7:0]) ? search_matrix [5][3][7:0] : current_matrix [5][3][7:0];
	assign difference_matrix[5][3][7:0] = inputA [5][3][7:0] - inputB [5][3][7:0];
	
	assign inputA[5][4][7:0] = (search_matrix [5][4][7:0] < current_matrix [5][4][7:0]) ? current_matrix [5][4][7:0] : search_matrix [5][4][7:0];
	assign inputB[5][4][7:0] = (search_matrix [5][4][7:0] < current_matrix [5][4][7:0]) ? search_matrix [5][4][7:0] : current_matrix [5][4][7:0];
	assign difference_matrix[5][4][7:0] = inputA [5][4][7:0] - inputB [5][4][7:0];
	
	assign inputA[5][5][7:0] = (search_matrix [5][5][7:0] < current_matrix [5][5][7:0]) ? current_matrix [5][5][7:0] : search_matrix [5][5][7:0];
	assign inputB[5][5][7:0] = (search_matrix [5][5][7:0] < current_matrix [5][5][7:0]) ? search_matrix [5][5][7:0] : current_matrix [5][5][7:0];
	assign difference_matrix[5][5][7:0] = inputA [5][5][7:0] - inputB [5][5][7:0];
	
	assign inputA[5][6][7:0] = (search_matrix [5][6][7:0] < current_matrix [5][6][7:0]) ? current_matrix [5][6][7:0] : search_matrix [5][6][7:0];
	assign inputB[5][6][7:0] = (search_matrix [5][6][7:0] < current_matrix [5][6][7:0]) ? search_matrix [5][6][7:0] : current_matrix [5][6][7:0];
	assign difference_matrix[5][6][7:0] = inputA [5][6][7:0] - inputB [5][6][7:0];
	
	assign inputA[5][7][7:0] = (search_matrix [5][7][7:0] < current_matrix [5][7][7:0]) ? current_matrix [5][7][7:0] : search_matrix [5][7][7:0];
	assign inputB[5][7][7:0] = (search_matrix [5][7][7:0] < current_matrix [5][7][7:0]) ? search_matrix [5][7][7:0] : current_matrix [5][7][7:0];
	assign difference_matrix[5][7][7:0] = inputA [5][7][7:0] - inputB [5][7][7:0];
	
	assign inputA[5][8][7:0] = (search_matrix [5][8][7:0] < current_matrix [5][8][7:0]) ? current_matrix [5][8][7:0] : search_matrix [5][8][7:0];
	assign inputB[5][8][7:0] = (search_matrix [5][8][7:0] < current_matrix [5][8][7:0]) ? search_matrix [5][8][7:0] : current_matrix [5][8][7:0];
	assign difference_matrix[5][8][7:0] = inputA [5][8][7:0] - inputB [5][8][7:0];
	
	assign inputA[5][9][7:0] = (search_matrix [5][9][7:0] < current_matrix [5][9][7:0]) ? current_matrix [5][9][7:0] : search_matrix [5][9][7:0];
	assign inputB[5][9][7:0] = (search_matrix [5][9][7:0] < current_matrix [5][9][7:0]) ? search_matrix [5][9][7:0] : current_matrix [5][9][7:0];
	assign difference_matrix[5][9][7:0] = inputA [5][9][7:0] - inputB [5][9][7:0];
	
	assign inputA[5][10][7:0] = (search_matrix [5][10][7:0] < current_matrix [5][10][7:0]) ? current_matrix [5][10][7:0] : search_matrix [5][10][7:0];
	assign inputB[5][10][7:0] = (search_matrix [5][10][7:0] < current_matrix [5][10][7:0]) ? search_matrix [5][10][7:0] : current_matrix [5][10][7:0];
	assign difference_matrix[5][10][7:0] = inputA [5][10][7:0] - inputB [5][10][7:0];
	
	assign inputA[5][11][7:0] = (search_matrix [5][11][7:0] < current_matrix [5][11][7:0]) ? current_matrix [5][11][7:0] : search_matrix [5][11][7:0];
	assign inputB[5][11][7:0] = (search_matrix [5][11][7:0] < current_matrix [5][11][7:0]) ? search_matrix [5][11][7:0] : current_matrix [5][11][7:0];
	assign difference_matrix[5][11][7:0] = inputA [5][11][7:0] - inputB [5][11][7:0];
	
	assign inputA[5][12][7:0] = (search_matrix [5][12][7:0] < current_matrix [5][12][7:0]) ? current_matrix [5][12][7:0] : search_matrix [5][12][7:0];
	assign inputB[5][12][7:0] = (search_matrix [5][12][7:0] < current_matrix [5][12][7:0]) ? search_matrix [5][12][7:0] : current_matrix [5][12][7:0];
	assign difference_matrix[5][12][7:0] = inputA [5][12][7:0] - inputB [5][12][7:0];
	
	assign inputA[5][13][7:0] = (search_matrix [5][13][7:0] < current_matrix [5][13][7:0]) ? current_matrix [5][13][7:0] : search_matrix [5][13][7:0];
	assign inputB[5][13][7:0] = (search_matrix [5][13][7:0] < current_matrix [5][13][7:0]) ? search_matrix [5][13][7:0] : current_matrix [5][13][7:0];
	assign difference_matrix[5][13][7:0] = inputA [5][13][7:0] - inputB [5][13][7:0];
	
	assign inputA[5][14][7:0] = (search_matrix [5][14][7:0] < current_matrix [5][14][7:0]) ? current_matrix [5][14][7:0] : search_matrix [5][14][7:0];
	assign inputB[5][14][7:0] = (search_matrix [5][14][7:0] < current_matrix [5][14][7:0]) ? search_matrix [5][14][7:0] : current_matrix [5][14][7:0];
	assign difference_matrix[5][14][7:0] = inputA [5][14][7:0] - inputB [5][14][7:0];
	
	assign inputA[5][15][7:0] = (search_matrix [5][15][7:0] < current_matrix [5][15][7:0]) ? current_matrix [5][15][7:0] : search_matrix [5][15][7:0];
	assign inputB[5][15][7:0] = (search_matrix [5][15][7:0] < current_matrix [5][15][7:0]) ? search_matrix [5][15][7:0] : current_matrix [5][15][7:0];
	assign difference_matrix[5][15][7:0] = inputA [5][15][7:0] - inputB [5][15][7:0];
	
	assign inputA[6][0][7:0] = (search_matrix [6][0][7:0] < current_matrix [6][0][7:0]) ? current_matrix [6][0][7:0] : search_matrix [6][0][7:0];
	assign inputB[6][0][7:0] = (search_matrix [6][0][7:0] < current_matrix [6][0][7:0]) ? search_matrix [6][0][7:0] : current_matrix [6][0][7:0];
	assign difference_matrix[6][0][7:0] = inputA [6][0][7:0] - inputB [6][0][7:0];
	
	assign inputA[6][1][7:0] = (search_matrix [6][1][7:0] < current_matrix [6][1][7:0]) ? current_matrix [6][1][7:0] : search_matrix [6][1][7:0];
	assign inputB[6][1][7:0] = (search_matrix [6][1][7:0] < current_matrix [6][1][7:0]) ? search_matrix [6][1][7:0] : current_matrix [6][1][7:0];
	assign difference_matrix[6][1][7:0] = inputA [6][1][7:0] - inputB [6][1][7:0];
	
	assign inputA[6][2][7:0] = (search_matrix [6][2][7:0] < current_matrix [6][2][7:0]) ? current_matrix [6][2][7:0] : search_matrix [6][2][7:0];
	assign inputB[6][2][7:0] = (search_matrix [6][2][7:0] < current_matrix [6][2][7:0]) ? search_matrix [6][2][7:0] : current_matrix [6][2][7:0];
	assign difference_matrix[6][2][7:0] = inputA [6][2][7:0] - inputB [6][2][7:0];
	
	assign inputA[6][3][7:0] = (search_matrix [6][3][7:0] < current_matrix [6][3][7:0]) ? current_matrix [6][3][7:0] : search_matrix [6][3][7:0];
	assign inputB[6][3][7:0] = (search_matrix [6][3][7:0] < current_matrix [6][3][7:0]) ? search_matrix [6][3][7:0] : current_matrix [6][3][7:0];
	assign difference_matrix[6][3][7:0] = inputA [6][3][7:0] - inputB [6][3][7:0];
	
	assign inputA[6][4][7:0] = (search_matrix [6][4][7:0] < current_matrix [6][4][7:0]) ? current_matrix [6][4][7:0] : search_matrix [6][4][7:0];
	assign inputB[6][4][7:0] = (search_matrix [6][4][7:0] < current_matrix [6][4][7:0]) ? search_matrix [6][4][7:0] : current_matrix [6][4][7:0];
	assign difference_matrix[6][4][7:0] = inputA [6][4][7:0] - inputB [6][4][7:0];
	
	assign inputA[6][5][7:0] = (search_matrix [6][5][7:0] < current_matrix [6][5][7:0]) ? current_matrix [6][5][7:0] : search_matrix [6][5][7:0];
	assign inputB[6][5][7:0] = (search_matrix [6][5][7:0] < current_matrix [6][5][7:0]) ? search_matrix [6][5][7:0] : current_matrix [6][5][7:0];
	assign difference_matrix[6][5][7:0] = inputA [6][5][7:0] - inputB [6][5][7:0];
	
	assign inputA[6][6][7:0] = (search_matrix [6][6][7:0] < current_matrix [6][6][7:0]) ? current_matrix [6][6][7:0] : search_matrix [6][6][7:0];
	assign inputB[6][6][7:0] = (search_matrix [6][6][7:0] < current_matrix [6][6][7:0]) ? search_matrix [6][6][7:0] : current_matrix [6][6][7:0];
	assign difference_matrix[6][6][7:0] = inputA [6][6][7:0] - inputB [6][6][7:0];
	
	assign inputA[6][7][7:0] = (search_matrix [6][7][7:0] < current_matrix [6][7][7:0]) ? current_matrix [6][7][7:0] : search_matrix [6][7][7:0];
	assign inputB[6][7][7:0] = (search_matrix [6][7][7:0] < current_matrix [6][7][7:0]) ? search_matrix [6][7][7:0] : current_matrix [6][7][7:0];
	assign difference_matrix[6][7][7:0] = inputA [6][7][7:0] - inputB [6][7][7:0];
	
	assign inputA[6][8][7:0] = (search_matrix [6][8][7:0] < current_matrix [6][8][7:0]) ? current_matrix [6][8][7:0] : search_matrix [6][8][7:0];
	assign inputB[6][8][7:0] = (search_matrix [6][8][7:0] < current_matrix [6][8][7:0]) ? search_matrix [6][8][7:0] : current_matrix [6][8][7:0];
	assign difference_matrix[6][8][7:0] = inputA [6][8][7:0] - inputB [6][8][7:0];
	
	assign inputA[6][9][7:0] = (search_matrix [6][9][7:0] < current_matrix [6][9][7:0]) ? current_matrix [6][9][7:0] : search_matrix [6][9][7:0];
	assign inputB[6][9][7:0] = (search_matrix [6][9][7:0] < current_matrix [6][9][7:0]) ? search_matrix [6][9][7:0] : current_matrix [6][9][7:0];
	assign difference_matrix[6][9][7:0] = inputA [6][9][7:0] - inputB [6][9][7:0];
	
	assign inputA[6][10][7:0] = (search_matrix [6][10][7:0] < current_matrix [6][10][7:0]) ? current_matrix [6][10][7:0] : search_matrix [6][10][7:0];
	assign inputB[6][10][7:0] = (search_matrix [6][10][7:0] < current_matrix [6][10][7:0]) ? search_matrix [6][10][7:0] : current_matrix [6][10][7:0];
	assign difference_matrix[6][10][7:0] = inputA [6][10][7:0] - inputB [6][10][7:0];
	
	assign inputA[6][11][7:0] = (search_matrix [6][11][7:0] < current_matrix [6][11][7:0]) ? current_matrix [6][11][7:0] : search_matrix [6][11][7:0];
	assign inputB[6][11][7:0] = (search_matrix [6][11][7:0] < current_matrix [6][11][7:0]) ? search_matrix [6][11][7:0] : current_matrix [6][11][7:0];
	assign difference_matrix[6][11][7:0] = inputA [6][11][7:0] - inputB [6][11][7:0];
	
	assign inputA[6][12][7:0] = (search_matrix [6][12][7:0] < current_matrix [6][12][7:0]) ? current_matrix [6][12][7:0] : search_matrix [6][12][7:0];
	assign inputB[6][12][7:0] = (search_matrix [6][12][7:0] < current_matrix [6][12][7:0]) ? search_matrix [6][12][7:0] : current_matrix [6][12][7:0];
	assign difference_matrix[6][12][7:0] = inputA [6][12][7:0] - inputB [6][12][7:0];
	
	assign inputA[6][13][7:0] = (search_matrix [6][13][7:0] < current_matrix [6][13][7:0]) ? current_matrix [6][13][7:0] : search_matrix [6][13][7:0];
	assign inputB[6][13][7:0] = (search_matrix [6][13][7:0] < current_matrix [6][13][7:0]) ? search_matrix [6][13][7:0] : current_matrix [6][13][7:0];
	assign difference_matrix[6][13][7:0] = inputA [6][13][7:0] - inputB [6][13][7:0];
	
	assign inputA[6][14][7:0] = (search_matrix [6][14][7:0] < current_matrix [6][14][7:0]) ? current_matrix [6][14][7:0] : search_matrix [6][14][7:0];
	assign inputB[6][14][7:0] = (search_matrix [6][14][7:0] < current_matrix [6][14][7:0]) ? search_matrix [6][14][7:0] : current_matrix [6][14][7:0];
	assign difference_matrix[6][14][7:0] = inputA [6][14][7:0] - inputB [6][14][7:0];
	
	assign inputA[6][15][7:0] = (search_matrix [6][15][7:0] < current_matrix [6][15][7:0]) ? current_matrix [6][15][7:0] : search_matrix [6][15][7:0];
	assign inputB[6][15][7:0] = (search_matrix [6][15][7:0] < current_matrix [6][15][7:0]) ? search_matrix [6][15][7:0] : current_matrix [6][15][7:0];
	assign difference_matrix[6][15][7:0] = inputA [6][15][7:0] - inputB [6][15][7:0];
	
	assign inputA[7][0][7:0] = (search_matrix [7][0][7:0] < current_matrix [7][0][7:0]) ? current_matrix [7][0][7:0] : search_matrix [7][0][7:0];
	assign inputB[7][0][7:0] = (search_matrix [7][0][7:0] < current_matrix [7][0][7:0]) ? search_matrix [7][0][7:0] : current_matrix [7][0][7:0];
	assign difference_matrix[7][0][7:0] = inputA [7][0][7:0] - inputB [7][0][7:0];
	
	assign inputA[7][1][7:0] = (search_matrix [7][1][7:0] < current_matrix [7][1][7:0]) ? current_matrix [7][1][7:0] : search_matrix [7][1][7:0];
	assign inputB[7][1][7:0] = (search_matrix [7][1][7:0] < current_matrix [7][1][7:0]) ? search_matrix [7][1][7:0] : current_matrix [7][1][7:0];
	assign difference_matrix[7][1][7:0] = inputA [7][1][7:0] - inputB [7][1][7:0];
	
	assign inputA[7][2][7:0] = (search_matrix [7][2][7:0] < current_matrix [7][2][7:0]) ? current_matrix [7][2][7:0] : search_matrix [7][2][7:0];
	assign inputB[7][2][7:0] = (search_matrix [7][2][7:0] < current_matrix [7][2][7:0]) ? search_matrix [7][2][7:0] : current_matrix [7][2][7:0];
	assign difference_matrix[7][2][7:0] = inputA [7][2][7:0] - inputB [7][2][7:0];
	
	assign inputA[7][3][7:0] = (search_matrix [7][3][7:0] < current_matrix [7][3][7:0]) ? current_matrix [7][3][7:0] : search_matrix [7][3][7:0];
	assign inputB[7][3][7:0] = (search_matrix [7][3][7:0] < current_matrix [7][3][7:0]) ? search_matrix [7][3][7:0] : current_matrix [7][3][7:0];
	assign difference_matrix[7][3][7:0] = inputA [7][3][7:0] - inputB [7][3][7:0];
	
	assign inputA[7][4][7:0] = (search_matrix [7][4][7:0] < current_matrix [7][4][7:0]) ? current_matrix [7][4][7:0] : search_matrix [7][4][7:0];
	assign inputB[7][4][7:0] = (search_matrix [7][4][7:0] < current_matrix [7][4][7:0]) ? search_matrix [7][4][7:0] : current_matrix [7][4][7:0];
	assign difference_matrix[7][4][7:0] = inputA [7][4][7:0] - inputB [7][4][7:0];
	
	assign inputA[7][5][7:0] = (search_matrix [7][5][7:0] < current_matrix [7][5][7:0]) ? current_matrix [7][5][7:0] : search_matrix [7][5][7:0];
	assign inputB[7][5][7:0] = (search_matrix [7][5][7:0] < current_matrix [7][5][7:0]) ? search_matrix [7][5][7:0] : current_matrix [7][5][7:0];
	assign difference_matrix[7][5][7:0] = inputA [7][5][7:0] - inputB [7][5][7:0];
	
	assign inputA[7][6][7:0] = (search_matrix [7][6][7:0] < current_matrix [7][6][7:0]) ? current_matrix [7][6][7:0] : search_matrix [7][6][7:0];
	assign inputB[7][6][7:0] = (search_matrix [7][6][7:0] < current_matrix [7][6][7:0]) ? search_matrix [7][6][7:0] : current_matrix [7][6][7:0];
	assign difference_matrix[7][6][7:0] = inputA [7][6][7:0] - inputB [7][6][7:0];
	
	assign inputA[7][7][7:0] = (search_matrix [7][7][7:0] < current_matrix [7][7][7:0]) ? current_matrix [7][7][7:0] : search_matrix [7][7][7:0];
	assign inputB[7][7][7:0] = (search_matrix [7][7][7:0] < current_matrix [7][7][7:0]) ? search_matrix [7][7][7:0] : current_matrix [7][7][7:0];
	assign difference_matrix[7][7][7:0] = inputA [7][7][7:0] - inputB [7][7][7:0];
	
	assign inputA[7][8][7:0] = (search_matrix [7][8][7:0] < current_matrix [7][8][7:0]) ? current_matrix [7][8][7:0] : search_matrix [7][8][7:0];
	assign inputB[7][8][7:0] = (search_matrix [7][8][7:0] < current_matrix [7][8][7:0]) ? search_matrix [7][8][7:0] : current_matrix [7][8][7:0];
	assign difference_matrix[7][8][7:0] = inputA [7][8][7:0] - inputB [7][8][7:0];
	
	assign inputA[7][9][7:0] = (search_matrix [7][9][7:0] < current_matrix [7][9][7:0]) ? current_matrix [7][9][7:0] : search_matrix [7][9][7:0];
	assign inputB[7][9][7:0] = (search_matrix [7][9][7:0] < current_matrix [7][9][7:0]) ? search_matrix [7][9][7:0] : current_matrix [7][9][7:0];
	assign difference_matrix[7][9][7:0] = inputA [7][9][7:0] - inputB [7][9][7:0];
	
	assign inputA[7][10][7:0] = (search_matrix [7][10][7:0] < current_matrix [7][10][7:0]) ? current_matrix [7][10][7:0] : search_matrix [7][10][7:0];
	assign inputB[7][10][7:0] = (search_matrix [7][10][7:0] < current_matrix [7][10][7:0]) ? search_matrix [7][10][7:0] : current_matrix [7][10][7:0];
	assign difference_matrix[7][10][7:0] = inputA [7][10][7:0] - inputB [7][10][7:0];
	
	assign inputA[7][11][7:0] = (search_matrix [7][11][7:0] < current_matrix [7][11][7:0]) ? current_matrix [7][11][7:0] : search_matrix [7][11][7:0];
	assign inputB[7][11][7:0] = (search_matrix [7][11][7:0] < current_matrix [7][11][7:0]) ? search_matrix [7][11][7:0] : current_matrix [7][11][7:0];
	assign difference_matrix[7][11][7:0] = inputA [7][11][7:0] - inputB [7][11][7:0];
	
	assign inputA[7][12][7:0] = (search_matrix [7][12][7:0] < current_matrix [7][12][7:0]) ? current_matrix [7][12][7:0] : search_matrix [7][12][7:0];
	assign inputB[7][12][7:0] = (search_matrix [7][12][7:0] < current_matrix [7][12][7:0]) ? search_matrix [7][12][7:0] : current_matrix [7][12][7:0];
	assign difference_matrix[7][12][7:0] = inputA [7][12][7:0] - inputB [7][12][7:0];
	
	assign inputA[7][13][7:0] = (search_matrix [7][13][7:0] < current_matrix [7][13][7:0]) ? current_matrix [7][13][7:0] : search_matrix [7][13][7:0];
	assign inputB[7][13][7:0] = (search_matrix [7][13][7:0] < current_matrix [7][13][7:0]) ? search_matrix [7][13][7:0] : current_matrix [7][13][7:0];
	assign difference_matrix[7][13][7:0] = inputA [7][13][7:0] - inputB [7][13][7:0];
	
	assign inputA[7][14][7:0] = (search_matrix [7][14][7:0] < current_matrix [7][14][7:0]) ? current_matrix [7][14][7:0] : search_matrix [7][14][7:0];
	assign inputB[7][14][7:0] = (search_matrix [7][14][7:0] < current_matrix [7][14][7:0]) ? search_matrix [7][14][7:0] : current_matrix [7][14][7:0];
	assign difference_matrix[7][14][7:0] = inputA [7][14][7:0] - inputB [7][14][7:0];
	
	assign inputA[7][15][7:0] = (search_matrix [7][15][7:0] < current_matrix [7][15][7:0]) ? current_matrix [7][15][7:0] : search_matrix [7][15][7:0];
	assign inputB[7][15][7:0] = (search_matrix [7][15][7:0] < current_matrix [7][15][7:0]) ? search_matrix [7][15][7:0] : current_matrix [7][15][7:0];
	assign difference_matrix[7][15][7:0] = inputA [7][15][7:0] - inputB [7][15][7:0];
	
	assign inputA[8][0][7:0] = (search_matrix [8][0][7:0] < current_matrix [8][0][7:0]) ? current_matrix [8][0][7:0] : search_matrix [8][0][7:0];
	assign inputB[8][0][7:0] = (search_matrix [8][0][7:0] < current_matrix [8][0][7:0]) ? search_matrix [8][0][7:0] : current_matrix [8][0][7:0];
	assign difference_matrix[8][0][7:0] = inputA [8][0][7:0] - inputB [8][0][7:0];
	
	assign inputA[8][1][7:0] = (search_matrix [8][1][7:0] < current_matrix [8][1][7:0]) ? current_matrix [8][1][7:0] : search_matrix [8][1][7:0];
	assign inputB[8][1][7:0] = (search_matrix [8][1][7:0] < current_matrix [8][1][7:0]) ? search_matrix [8][1][7:0] : current_matrix [8][1][7:0];
	assign difference_matrix[8][1][7:0] = inputA [8][1][7:0] - inputB [8][1][7:0];
	
	assign inputA[8][2][7:0] = (search_matrix [8][2][7:0] < current_matrix [8][2][7:0]) ? current_matrix [8][2][7:0] : search_matrix [8][2][7:0];
	assign inputB[8][2][7:0] = (search_matrix [8][2][7:0] < current_matrix [8][2][7:0]) ? search_matrix [8][2][7:0] : current_matrix [8][2][7:0];
	assign difference_matrix[8][2][7:0] = inputA [8][2][7:0] - inputB [8][2][7:0];
	
	assign inputA[8][3][7:0] = (search_matrix [8][3][7:0] < current_matrix [8][3][7:0]) ? current_matrix [8][3][7:0] : search_matrix [8][3][7:0];
	assign inputB[8][3][7:0] = (search_matrix [8][3][7:0] < current_matrix [8][3][7:0]) ? search_matrix [8][3][7:0] : current_matrix [8][3][7:0];
	assign difference_matrix[8][3][7:0] = inputA [8][3][7:0] - inputB [8][3][7:0];
	
	assign inputA[8][4][7:0] = (search_matrix [8][4][7:0] < current_matrix [8][4][7:0]) ? current_matrix [8][4][7:0] : search_matrix [8][4][7:0];
	assign inputB[8][4][7:0] = (search_matrix [8][4][7:0] < current_matrix [8][4][7:0]) ? search_matrix [8][4][7:0] : current_matrix [8][4][7:0];
	assign difference_matrix[8][4][7:0] = inputA [8][4][7:0] - inputB [8][4][7:0];
	
	assign inputA[8][5][7:0] = (search_matrix [8][5][7:0] < current_matrix [8][5][7:0]) ? current_matrix [8][5][7:0] : search_matrix [8][5][7:0];
	assign inputB[8][5][7:0] = (search_matrix [8][5][7:0] < current_matrix [8][5][7:0]) ? search_matrix [8][5][7:0] : current_matrix [8][5][7:0];
	assign difference_matrix[8][5][7:0] = inputA [8][5][7:0] - inputB [8][5][7:0];
	
	assign inputA[8][6][7:0] = (search_matrix [8][6][7:0] < current_matrix [8][6][7:0]) ? current_matrix [8][6][7:0] : search_matrix [8][6][7:0];
	assign inputB[8][6][7:0] = (search_matrix [8][6][7:0] < current_matrix [8][6][7:0]) ? search_matrix [8][6][7:0] : current_matrix [8][6][7:0];
	assign difference_matrix[8][6][7:0] = inputA [8][6][7:0] - inputB [8][6][7:0];
	
	assign inputA[8][7][7:0] = (search_matrix [8][7][7:0] < current_matrix [8][7][7:0]) ? current_matrix [8][7][7:0] : search_matrix [8][7][7:0];
	assign inputB[8][7][7:0] = (search_matrix [8][7][7:0] < current_matrix [8][7][7:0]) ? search_matrix [8][7][7:0] : current_matrix [8][7][7:0];
	assign difference_matrix[8][7][7:0] = inputA [8][7][7:0] - inputB [8][7][7:0];
	
	assign inputA[8][8][7:0] = (search_matrix [8][8][7:0] < current_matrix [8][8][7:0]) ? current_matrix [8][8][7:0] : search_matrix [8][8][7:0];
	assign inputB[8][8][7:0] = (search_matrix [8][8][7:0] < current_matrix [8][8][7:0]) ? search_matrix [8][8][7:0] : current_matrix [8][8][7:0];
	assign difference_matrix[8][8][7:0] = inputA [8][8][7:0] - inputB [8][8][7:0];
	
	assign inputA[8][9][7:0] = (search_matrix [8][9][7:0] < current_matrix [8][9][7:0]) ? current_matrix [8][9][7:0] : search_matrix [8][9][7:0];
	assign inputB[8][9][7:0] = (search_matrix [8][9][7:0] < current_matrix [8][9][7:0]) ? search_matrix [8][9][7:0] : current_matrix [8][9][7:0];
	assign difference_matrix[8][9][7:0] = inputA [8][9][7:0] - inputB [8][9][7:0];
	
	assign inputA[8][10][7:0] = (search_matrix [8][10][7:0] < current_matrix [8][10][7:0]) ? current_matrix [8][10][7:0] : search_matrix [8][10][7:0];
	assign inputB[8][10][7:0] = (search_matrix [8][10][7:0] < current_matrix [8][10][7:0]) ? search_matrix [8][10][7:0] : current_matrix [8][10][7:0];
	assign difference_matrix[8][10][7:0] = inputA [8][10][7:0] - inputB [8][10][7:0];
	
	assign inputA[8][11][7:0] = (search_matrix [8][11][7:0] < current_matrix [8][11][7:0]) ? current_matrix [8][11][7:0] : search_matrix [8][11][7:0];
	assign inputB[8][11][7:0] = (search_matrix [8][11][7:0] < current_matrix [8][11][7:0]) ? search_matrix [8][11][7:0] : current_matrix [8][11][7:0];
	assign difference_matrix[8][11][7:0] = inputA [8][11][7:0] - inputB [8][11][7:0];
	
	assign inputA[8][12][7:0] = (search_matrix [8][12][7:0] < current_matrix [8][12][7:0]) ? current_matrix [8][12][7:0] : search_matrix [8][12][7:0];
	assign inputB[8][12][7:0] = (search_matrix [8][12][7:0] < current_matrix [8][12][7:0]) ? search_matrix [8][12][7:0] : current_matrix [8][12][7:0];
	assign difference_matrix[8][12][7:0] = inputA [8][12][7:0] - inputB [8][12][7:0];
	
	assign inputA[8][13][7:0] = (search_matrix [8][13][7:0] < current_matrix [8][13][7:0]) ? current_matrix [8][13][7:0] : search_matrix [8][13][7:0];
	assign inputB[8][13][7:0] = (search_matrix [8][13][7:0] < current_matrix [8][13][7:0]) ? search_matrix [8][13][7:0] : current_matrix [8][13][7:0];
	assign difference_matrix[8][13][7:0] = inputA [8][13][7:0] - inputB [8][13][7:0];
	
	assign inputA[8][14][7:0] = (search_matrix [8][14][7:0] < current_matrix [8][14][7:0]) ? current_matrix [8][14][7:0] : search_matrix [8][14][7:0];
	assign inputB[8][14][7:0] = (search_matrix [8][14][7:0] < current_matrix [8][14][7:0]) ? search_matrix [8][14][7:0] : current_matrix [8][14][7:0];
	assign difference_matrix[8][14][7:0] = inputA [8][14][7:0] - inputB [8][14][7:0];
	
	assign inputA[8][15][7:0] = (search_matrix [8][15][7:0] < current_matrix [8][15][7:0]) ? current_matrix [8][15][7:0] : search_matrix [8][15][7:0];
	assign inputB[8][15][7:0] = (search_matrix [8][15][7:0] < current_matrix [8][15][7:0]) ? search_matrix [8][15][7:0] : current_matrix [8][15][7:0];
	assign difference_matrix[8][15][7:0] = inputA [8][15][7:0] - inputB [8][15][7:0];
	
	assign inputA[9][0][7:0] = (search_matrix [9][0][7:0] < current_matrix [9][0][7:0]) ? current_matrix [9][0][7:0] : search_matrix [9][0][7:0];
	assign inputB[9][0][7:0] = (search_matrix [9][0][7:0] < current_matrix [9][0][7:0]) ? search_matrix [9][0][7:0] : current_matrix [9][0][7:0];
	assign difference_matrix[9][0][7:0] = inputA [9][0][7:0] - inputB [9][0][7:0];
	
	assign inputA[9][1][7:0] = (search_matrix [9][1][7:0] < current_matrix [9][1][7:0]) ? current_matrix [9][1][7:0] : search_matrix [9][1][7:0];
	assign inputB[9][1][7:0] = (search_matrix [9][1][7:0] < current_matrix [9][1][7:0]) ? search_matrix [9][1][7:0] : current_matrix [9][1][7:0];
	assign difference_matrix[9][1][7:0] = inputA [9][1][7:0] - inputB [9][1][7:0];
	
	assign inputA[9][2][7:0] = (search_matrix [9][2][7:0] < current_matrix [9][2][7:0]) ? current_matrix [9][2][7:0] : search_matrix [9][2][7:0];
	assign inputB[9][2][7:0] = (search_matrix [9][2][7:0] < current_matrix [9][2][7:0]) ? search_matrix [9][2][7:0] : current_matrix [9][2][7:0];
	assign difference_matrix[9][2][7:0] = inputA [9][2][7:0] - inputB [9][2][7:0];
	
	assign inputA[9][3][7:0] = (search_matrix [9][3][7:0] < current_matrix [9][3][7:0]) ? current_matrix [9][3][7:0] : search_matrix [9][3][7:0];
	assign inputB[9][3][7:0] = (search_matrix [9][3][7:0] < current_matrix [9][3][7:0]) ? search_matrix [9][3][7:0] : current_matrix [9][3][7:0];
	assign difference_matrix[9][3][7:0] = inputA [9][3][7:0] - inputB [9][3][7:0];
	
	assign inputA[9][4][7:0] = (search_matrix [9][4][7:0] < current_matrix [9][4][7:0]) ? current_matrix [9][4][7:0] : search_matrix [9][4][7:0];
	assign inputB[9][4][7:0] = (search_matrix [9][4][7:0] < current_matrix [9][4][7:0]) ? search_matrix [9][4][7:0] : current_matrix [9][4][7:0];
	assign difference_matrix[9][4][7:0] = inputA [9][4][7:0] - inputB [9][4][7:0];
	
	assign inputA[9][5][7:0] = (search_matrix [9][5][7:0] < current_matrix [9][5][7:0]) ? current_matrix [9][5][7:0] : search_matrix [9][5][7:0];
	assign inputB[9][5][7:0] = (search_matrix [9][5][7:0] < current_matrix [9][5][7:0]) ? search_matrix [9][5][7:0] : current_matrix [9][5][7:0];
	assign difference_matrix[9][5][7:0] = inputA [9][5][7:0] - inputB [9][5][7:0];
	
	assign inputA[9][6][7:0] = (search_matrix [9][6][7:0] < current_matrix [9][6][7:0]) ? current_matrix [9][6][7:0] : search_matrix [9][6][7:0];
	assign inputB[9][6][7:0] = (search_matrix [9][6][7:0] < current_matrix [9][6][7:0]) ? search_matrix [9][6][7:0] : current_matrix [9][6][7:0];
	assign difference_matrix[9][6][7:0] = inputA [9][6][7:0] - inputB [9][6][7:0];
	
	assign inputA[9][7][7:0] = (search_matrix [9][7][7:0] < current_matrix [9][7][7:0]) ? current_matrix [9][7][7:0] : search_matrix [9][7][7:0];
	assign inputB[9][7][7:0] = (search_matrix [9][7][7:0] < current_matrix [9][7][7:0]) ? search_matrix [9][7][7:0] : current_matrix [9][7][7:0];
	assign difference_matrix[9][7][7:0] = inputA [9][7][7:0] - inputB [9][7][7:0];
	
	assign inputA[9][8][7:0] = (search_matrix [9][8][7:0] < current_matrix [9][8][7:0]) ? current_matrix [9][8][7:0] : search_matrix [9][8][7:0];
	assign inputB[9][8][7:0] = (search_matrix [9][8][7:0] < current_matrix [9][8][7:0]) ? search_matrix [9][8][7:0] : current_matrix [9][8][7:0];
	assign difference_matrix[9][8][7:0] = inputA [9][8][7:0] - inputB [9][8][7:0];
	
	assign inputA[9][9][7:0] = (search_matrix [9][9][7:0] < current_matrix [9][9][7:0]) ? current_matrix [9][9][7:0] : search_matrix [9][9][7:0];
	assign inputB[9][9][7:0] = (search_matrix [9][9][7:0] < current_matrix [9][9][7:0]) ? search_matrix [9][9][7:0] : current_matrix [9][9][7:0];
	assign difference_matrix[9][9][7:0] = inputA [9][9][7:0] - inputB [9][9][7:0];
	
	assign inputA[9][10][7:0] = (search_matrix [9][10][7:0] < current_matrix [9][10][7:0]) ? current_matrix [9][10][7:0] : search_matrix [9][10][7:0];
	assign inputB[9][10][7:0] = (search_matrix [9][10][7:0] < current_matrix [9][10][7:0]) ? search_matrix [9][10][7:0] : current_matrix [9][10][7:0];
	assign difference_matrix[9][10][7:0] = inputA [9][10][7:0] - inputB [9][10][7:0];
	
	assign inputA[9][11][7:0] = (search_matrix [9][11][7:0] < current_matrix [9][11][7:0]) ? current_matrix [9][11][7:0] : search_matrix [9][11][7:0];
	assign inputB[9][11][7:0] = (search_matrix [9][11][7:0] < current_matrix [9][11][7:0]) ? search_matrix [9][11][7:0] : current_matrix [9][11][7:0];
	assign difference_matrix[9][11][7:0] = inputA [9][11][7:0] - inputB [9][11][7:0];
	
	assign inputA[9][12][7:0] = (search_matrix [9][12][7:0] < current_matrix [9][12][7:0]) ? current_matrix [9][12][7:0] : search_matrix [9][12][7:0];
	assign inputB[9][12][7:0] = (search_matrix [9][12][7:0] < current_matrix [9][12][7:0]) ? search_matrix [9][12][7:0] : current_matrix [9][12][7:0];
	assign difference_matrix[9][12][7:0] = inputA [9][12][7:0] - inputB [9][12][7:0];
	
	assign inputA[9][13][7:0] = (search_matrix [9][13][7:0] < current_matrix [9][13][7:0]) ? current_matrix [9][13][7:0] : search_matrix [9][13][7:0];
	assign inputB[9][13][7:0] = (search_matrix [9][13][7:0] < current_matrix [9][13][7:0]) ? search_matrix [9][13][7:0] : current_matrix [9][13][7:0];
	assign difference_matrix[9][13][7:0] = inputA [9][13][7:0] - inputB [9][13][7:0];
	
	assign inputA[9][14][7:0] = (search_matrix [9][14][7:0] < current_matrix [9][14][7:0]) ? current_matrix [9][14][7:0] : search_matrix [9][14][7:0];
	assign inputB[9][14][7:0] = (search_matrix [9][14][7:0] < current_matrix [9][14][7:0]) ? search_matrix [9][14][7:0] : current_matrix [9][14][7:0];
	assign difference_matrix[9][14][7:0] = inputA [9][14][7:0] - inputB [9][14][7:0];
	
	assign inputA[9][15][7:0] = (search_matrix [9][15][7:0] < current_matrix [9][15][7:0]) ? current_matrix [9][15][7:0] : search_matrix [9][15][7:0];
	assign inputB[9][15][7:0] = (search_matrix [9][15][7:0] < current_matrix [9][15][7:0]) ? search_matrix [9][15][7:0] : current_matrix [9][15][7:0];
	assign difference_matrix[9][15][7:0] = inputA [9][15][7:0] - inputB [9][15][7:0];
	
	assign inputA[10][0][7:0] = (search_matrix [10][0][7:0] < current_matrix [10][0][7:0]) ? current_matrix [10][0][7:0] : search_matrix [10][0][7:0];
	assign inputB[10][0][7:0] = (search_matrix [10][0][7:0] < current_matrix [10][0][7:0]) ? search_matrix [10][0][7:0] : current_matrix [10][0][7:0];
	assign difference_matrix[10][0][7:0] = inputA [10][0][7:0] - inputB [10][0][7:0];
	
	assign inputA[10][1][7:0] = (search_matrix [10][1][7:0] < current_matrix [10][1][7:0]) ? current_matrix [10][1][7:0] : search_matrix [10][1][7:0];
	assign inputB[10][1][7:0] = (search_matrix [10][1][7:0] < current_matrix [10][1][7:0]) ? search_matrix [10][1][7:0] : current_matrix [10][1][7:0];
	assign difference_matrix[10][1][7:0] = inputA [10][1][7:0] - inputB [10][1][7:0];
	
	assign inputA[10][2][7:0] = (search_matrix [10][2][7:0] < current_matrix [10][2][7:0]) ? current_matrix [10][2][7:0] : search_matrix [10][2][7:0];
	assign inputB[10][2][7:0] = (search_matrix [10][2][7:0] < current_matrix [10][2][7:0]) ? search_matrix [10][2][7:0] : current_matrix [10][2][7:0];
	assign difference_matrix[10][2][7:0] = inputA [10][2][7:0] - inputB [10][2][7:0];
	
	assign inputA[10][3][7:0] = (search_matrix [10][3][7:0] < current_matrix [10][3][7:0]) ? current_matrix [10][3][7:0] : search_matrix [10][3][7:0];
	assign inputB[10][3][7:0] = (search_matrix [10][3][7:0] < current_matrix [10][3][7:0]) ? search_matrix [10][3][7:0] : current_matrix [10][3][7:0];
	assign difference_matrix[10][3][7:0] = inputA [10][3][7:0] - inputB [10][3][7:0];
	
	assign inputA[10][4][7:0] = (search_matrix [10][4][7:0] < current_matrix [10][4][7:0]) ? current_matrix [10][4][7:0] : search_matrix [10][4][7:0];
	assign inputB[10][4][7:0] = (search_matrix [10][4][7:0] < current_matrix [10][4][7:0]) ? search_matrix [10][4][7:0] : current_matrix [10][4][7:0];
	assign difference_matrix[10][4][7:0] = inputA [10][4][7:0] - inputB [10][4][7:0];
	
	assign inputA[10][5][7:0] = (search_matrix [10][5][7:0] < current_matrix [10][5][7:0]) ? current_matrix [10][5][7:0] : search_matrix [10][5][7:0];
	assign inputB[10][5][7:0] = (search_matrix [10][5][7:0] < current_matrix [10][5][7:0]) ? search_matrix [10][5][7:0] : current_matrix [10][5][7:0];
	assign difference_matrix[10][5][7:0] = inputA [10][5][7:0] - inputB [10][5][7:0];
	
	assign inputA[10][6][7:0] = (search_matrix [10][6][7:0] < current_matrix [10][6][7:0]) ? current_matrix [10][6][7:0] : search_matrix [10][6][7:0];
	assign inputB[10][6][7:0] = (search_matrix [10][6][7:0] < current_matrix [10][6][7:0]) ? search_matrix [10][6][7:0] : current_matrix [10][6][7:0];
	assign difference_matrix[10][6][7:0] = inputA [10][6][7:0] - inputB [10][6][7:0];
	
	assign inputA[10][7][7:0] = (search_matrix [10][7][7:0] < current_matrix [10][7][7:0]) ? current_matrix [10][7][7:0] : search_matrix [10][7][7:0];
	assign inputB[10][7][7:0] = (search_matrix [10][7][7:0] < current_matrix [10][7][7:0]) ? search_matrix [10][7][7:0] : current_matrix [10][7][7:0];
	assign difference_matrix[10][7][7:0] = inputA [10][7][7:0] - inputB [10][7][7:0];
	
	assign inputA[10][8][7:0] = (search_matrix [10][8][7:0] < current_matrix [10][8][7:0]) ? current_matrix [10][8][7:0] : search_matrix [10][8][7:0];
	assign inputB[10][8][7:0] = (search_matrix [10][8][7:0] < current_matrix [10][8][7:0]) ? search_matrix [10][8][7:0] : current_matrix [10][8][7:0];
	assign difference_matrix[10][8][7:0] = inputA [10][8][7:0] - inputB [10][8][7:0];
	
	assign inputA[10][9][7:0] = (search_matrix [10][9][7:0] < current_matrix [10][9][7:0]) ? current_matrix [10][9][7:0] : search_matrix [10][9][7:0];
	assign inputB[10][9][7:0] = (search_matrix [10][9][7:0] < current_matrix [10][9][7:0]) ? search_matrix [10][9][7:0] : current_matrix [10][9][7:0];
	assign difference_matrix[10][9][7:0] = inputA [10][9][7:0] - inputB [10][9][7:0];
	
	assign inputA[10][10][7:0] = (search_matrix [10][10][7:0] < current_matrix [10][10][7:0]) ? current_matrix [10][10][7:0] : search_matrix [10][10][7:0];
	assign inputB[10][10][7:0] = (search_matrix [10][10][7:0] < current_matrix [10][10][7:0]) ? search_matrix [10][10][7:0] : current_matrix [10][10][7:0];
	assign difference_matrix[10][10][7:0] = inputA [10][10][7:0] - inputB [10][10][7:0];
	
	assign inputA[10][11][7:0] = (search_matrix [10][11][7:0] < current_matrix [10][11][7:0]) ? current_matrix [10][11][7:0] : search_matrix [10][11][7:0];
	assign inputB[10][11][7:0] = (search_matrix [10][11][7:0] < current_matrix [10][11][7:0]) ? search_matrix [10][11][7:0] : current_matrix [10][11][7:0];
	assign difference_matrix[10][11][7:0] = inputA [10][11][7:0] - inputB [10][11][7:0];
	
	assign inputA[10][12][7:0] = (search_matrix [10][12][7:0] < current_matrix [10][12][7:0]) ? current_matrix [10][12][7:0] : search_matrix [10][12][7:0];
	assign inputB[10][12][7:0] = (search_matrix [10][12][7:0] < current_matrix [10][12][7:0]) ? search_matrix [10][12][7:0] : current_matrix [10][12][7:0];
	assign difference_matrix[10][12][7:0] = inputA [10][12][7:0] - inputB [10][12][7:0];
	
	assign inputA[10][13][7:0] = (search_matrix [10][13][7:0] < current_matrix [10][13][7:0]) ? current_matrix [10][13][7:0] : search_matrix [10][13][7:0];
	assign inputB[10][13][7:0] = (search_matrix [10][13][7:0] < current_matrix [10][13][7:0]) ? search_matrix [10][13][7:0] : current_matrix [10][13][7:0];
	assign difference_matrix[10][13][7:0] = inputA [10][13][7:0] - inputB [10][13][7:0];
	
	assign inputA[10][14][7:0] = (search_matrix [10][14][7:0] < current_matrix [10][14][7:0]) ? current_matrix [10][14][7:0] : search_matrix [10][14][7:0];
	assign inputB[10][14][7:0] = (search_matrix [10][14][7:0] < current_matrix [10][14][7:0]) ? search_matrix [10][14][7:0] : current_matrix [10][14][7:0];
	assign difference_matrix[10][14][7:0] = inputA [10][14][7:0] - inputB [10][14][7:0];
	
	assign inputA[10][15][7:0] = (search_matrix [10][15][7:0] < current_matrix [10][15][7:0]) ? current_matrix [10][15][7:0] : search_matrix [10][15][7:0];
	assign inputB[10][15][7:0] = (search_matrix [10][15][7:0] < current_matrix [10][15][7:0]) ? search_matrix [10][15][7:0] : current_matrix [10][15][7:0];
	assign difference_matrix[10][15][7:0] = inputA [10][15][7:0] - inputB [10][15][7:0];
	
	assign inputA[11][0][7:0] = (search_matrix [11][0][7:0] < current_matrix [11][0][7:0]) ? current_matrix [11][0][7:0] : search_matrix [11][0][7:0];
	assign inputB[11][0][7:0] = (search_matrix [11][0][7:0] < current_matrix [11][0][7:0]) ? search_matrix [11][0][7:0] : current_matrix [11][0][7:0];
	assign difference_matrix[11][0][7:0] = inputA [11][0][7:0] - inputB [11][0][7:0];
	
	assign inputA[11][1][7:0] = (search_matrix [11][1][7:0] < current_matrix [11][1][7:0]) ? current_matrix [11][1][7:0] : search_matrix [11][1][7:0];
	assign inputB[11][1][7:0] = (search_matrix [11][1][7:0] < current_matrix [11][1][7:0]) ? search_matrix [11][1][7:0] : current_matrix [11][1][7:0];
	assign difference_matrix[11][1][7:0] = inputA [11][1][7:0] - inputB [11][1][7:0];
	
	assign inputA[11][2][7:0] = (search_matrix [11][2][7:0] < current_matrix [11][2][7:0]) ? current_matrix [11][2][7:0] : search_matrix [11][2][7:0];
	assign inputB[11][2][7:0] = (search_matrix [11][2][7:0] < current_matrix [11][2][7:0]) ? search_matrix [11][2][7:0] : current_matrix [11][2][7:0];
	assign difference_matrix[11][2][7:0] = inputA [11][2][7:0] - inputB [11][2][7:0];
	
	assign inputA[11][3][7:0] = (search_matrix [11][3][7:0] < current_matrix [11][3][7:0]) ? current_matrix [11][3][7:0] : search_matrix [11][3][7:0];
	assign inputB[11][3][7:0] = (search_matrix [11][3][7:0] < current_matrix [11][3][7:0]) ? search_matrix [11][3][7:0] : current_matrix [11][3][7:0];
	assign difference_matrix[11][3][7:0] = inputA [11][3][7:0] - inputB [11][3][7:0];
	
	assign inputA[11][4][7:0] = (search_matrix [11][4][7:0] < current_matrix [11][4][7:0]) ? current_matrix [11][4][7:0] : search_matrix [11][4][7:0];
	assign inputB[11][4][7:0] = (search_matrix [11][4][7:0] < current_matrix [11][4][7:0]) ? search_matrix [11][4][7:0] : current_matrix [11][4][7:0];
	assign difference_matrix[11][4][7:0] = inputA [11][4][7:0] - inputB [11][4][7:0];
	
	assign inputA[11][5][7:0] = (search_matrix [11][5][7:0] < current_matrix [11][5][7:0]) ? current_matrix [11][5][7:0] : search_matrix [11][5][7:0];
	assign inputB[11][5][7:0] = (search_matrix [11][5][7:0] < current_matrix [11][5][7:0]) ? search_matrix [11][5][7:0] : current_matrix [11][5][7:0];
	assign difference_matrix[11][5][7:0] = inputA [11][5][7:0] - inputB [11][5][7:0];
	
	assign inputA[11][6][7:0] = (search_matrix [11][6][7:0] < current_matrix [11][6][7:0]) ? current_matrix [11][6][7:0] : search_matrix [11][6][7:0];
	assign inputB[11][6][7:0] = (search_matrix [11][6][7:0] < current_matrix [11][6][7:0]) ? search_matrix [11][6][7:0] : current_matrix [11][6][7:0];
	assign difference_matrix[11][6][7:0] = inputA [11][6][7:0] - inputB [11][6][7:0];
	
	assign inputA[11][7][7:0] = (search_matrix [11][7][7:0] < current_matrix [11][7][7:0]) ? current_matrix [11][7][7:0] : search_matrix [11][7][7:0];
	assign inputB[11][7][7:0] = (search_matrix [11][7][7:0] < current_matrix [11][7][7:0]) ? search_matrix [11][7][7:0] : current_matrix [11][7][7:0];
	assign difference_matrix[11][7][7:0] = inputA [11][7][7:0] - inputB [11][7][7:0];
	
	assign inputA[11][8][7:0] = (search_matrix [11][8][7:0] < current_matrix [11][8][7:0]) ? current_matrix [11][8][7:0] : search_matrix [11][8][7:0];
	assign inputB[11][8][7:0] = (search_matrix [11][8][7:0] < current_matrix [11][8][7:0]) ? search_matrix [11][8][7:0] : current_matrix [11][8][7:0];
	assign difference_matrix[11][8][7:0] = inputA [11][8][7:0] - inputB [11][8][7:0];
	
	assign inputA[11][9][7:0] = (search_matrix [11][9][7:0] < current_matrix [11][9][7:0]) ? current_matrix [11][9][7:0] : search_matrix [11][9][7:0];
	assign inputB[11][9][7:0] = (search_matrix [11][9][7:0] < current_matrix [11][9][7:0]) ? search_matrix [11][9][7:0] : current_matrix [11][9][7:0];
	assign difference_matrix[11][9][7:0] = inputA [11][9][7:0] - inputB [11][9][7:0];
	
	assign inputA[11][10][7:0] = (search_matrix [11][10][7:0] < current_matrix [11][10][7:0]) ? current_matrix [11][10][7:0] : search_matrix [11][10][7:0];
	assign inputB[11][10][7:0] = (search_matrix [11][10][7:0] < current_matrix [11][10][7:0]) ? search_matrix [11][10][7:0] : current_matrix [11][10][7:0];
	assign difference_matrix[11][10][7:0] = inputA [11][10][7:0] - inputB [11][10][7:0];
	
	assign inputA[11][11][7:0] = (search_matrix [11][11][7:0] < current_matrix [11][11][7:0]) ? current_matrix [11][11][7:0] : search_matrix [11][11][7:0];
	assign inputB[11][11][7:0] = (search_matrix [11][11][7:0] < current_matrix [11][11][7:0]) ? search_matrix [11][11][7:0] : current_matrix [11][11][7:0];
	assign difference_matrix[11][11][7:0] = inputA [11][11][7:0] - inputB [11][11][7:0];
	
	assign inputA[11][12][7:0] = (search_matrix [11][12][7:0] < current_matrix [11][12][7:0]) ? current_matrix [11][12][7:0] : search_matrix [11][12][7:0];
	assign inputB[11][12][7:0] = (search_matrix [11][12][7:0] < current_matrix [11][12][7:0]) ? search_matrix [11][12][7:0] : current_matrix [11][12][7:0];
	assign difference_matrix[11][12][7:0] = inputA [11][12][7:0] - inputB [11][12][7:0];
	
	assign inputA[11][13][7:0] = (search_matrix [11][13][7:0] < current_matrix [11][13][7:0]) ? current_matrix [11][13][7:0] : search_matrix [11][13][7:0];
	assign inputB[11][13][7:0] = (search_matrix [11][13][7:0] < current_matrix [11][13][7:0]) ? search_matrix [11][13][7:0] : current_matrix [11][13][7:0];
	assign difference_matrix[11][13][7:0] = inputA [11][13][7:0] - inputB [11][13][7:0];
	
	assign inputA[11][14][7:0] = (search_matrix [11][14][7:0] < current_matrix [11][14][7:0]) ? current_matrix [11][14][7:0] : search_matrix [11][14][7:0];
	assign inputB[11][14][7:0] = (search_matrix [11][14][7:0] < current_matrix [11][14][7:0]) ? search_matrix [11][14][7:0] : current_matrix [11][14][7:0];
	assign difference_matrix[11][14][7:0] = inputA [11][14][7:0] - inputB [11][14][7:0];
	
	assign inputA[11][15][7:0] = (search_matrix [11][15][7:0] < current_matrix [11][15][7:0]) ? current_matrix [11][15][7:0] : search_matrix [11][15][7:0];
	assign inputB[11][15][7:0] = (search_matrix [11][15][7:0] < current_matrix [11][15][7:0]) ? search_matrix [11][15][7:0] : current_matrix [11][15][7:0];
	assign difference_matrix[11][15][7:0] = inputA [11][15][7:0] - inputB [11][15][7:0];
	
	assign inputA[12][0][7:0] = (search_matrix [12][0][7:0] < current_matrix [12][0][7:0]) ? current_matrix [12][0][7:0] : search_matrix [12][0][7:0];
	assign inputB[12][0][7:0] = (search_matrix [12][0][7:0] < current_matrix [12][0][7:0]) ? search_matrix [12][0][7:0] : current_matrix [12][0][7:0];
	assign difference_matrix[12][0][7:0] = inputA [12][0][7:0] - inputB [12][0][7:0];
	
	assign inputA[12][1][7:0] = (search_matrix [12][1][7:0] < current_matrix [12][1][7:0]) ? current_matrix [12][1][7:0] : search_matrix [12][1][7:0];
	assign inputB[12][1][7:0] = (search_matrix [12][1][7:0] < current_matrix [12][1][7:0]) ? search_matrix [12][1][7:0] : current_matrix [12][1][7:0];
	assign difference_matrix[12][1][7:0] = inputA [12][1][7:0] - inputB [12][1][7:0];
	
	assign inputA[12][2][7:0] = (search_matrix [12][2][7:0] < current_matrix [12][2][7:0]) ? current_matrix [12][2][7:0] : search_matrix [12][2][7:0];
	assign inputB[12][2][7:0] = (search_matrix [12][2][7:0] < current_matrix [12][2][7:0]) ? search_matrix [12][2][7:0] : current_matrix [12][2][7:0];
	assign difference_matrix[12][2][7:0] = inputA [12][2][7:0] - inputB [12][2][7:0];
	
	assign inputA[12][3][7:0] = (search_matrix [12][3][7:0] < current_matrix [12][3][7:0]) ? current_matrix [12][3][7:0] : search_matrix [12][3][7:0];
	assign inputB[12][3][7:0] = (search_matrix [12][3][7:0] < current_matrix [12][3][7:0]) ? search_matrix [12][3][7:0] : current_matrix [12][3][7:0];
	assign difference_matrix[12][3][7:0] = inputA [12][3][7:0] - inputB [12][3][7:0];
	
	assign inputA[12][4][7:0] = (search_matrix [12][4][7:0] < current_matrix [12][4][7:0]) ? current_matrix [12][4][7:0] : search_matrix [12][4][7:0];
	assign inputB[12][4][7:0] = (search_matrix [12][4][7:0] < current_matrix [12][4][7:0]) ? search_matrix [12][4][7:0] : current_matrix [12][4][7:0];
	assign difference_matrix[12][4][7:0] = inputA [12][4][7:0] - inputB [12][4][7:0];
	
	assign inputA[12][5][7:0] = (search_matrix [12][5][7:0] < current_matrix [12][5][7:0]) ? current_matrix [12][5][7:0] : search_matrix [12][5][7:0];
	assign inputB[12][5][7:0] = (search_matrix [12][5][7:0] < current_matrix [12][5][7:0]) ? search_matrix [12][5][7:0] : current_matrix [12][5][7:0];
	assign difference_matrix[12][5][7:0] = inputA [12][5][7:0] - inputB [12][5][7:0];
	
	assign inputA[12][6][7:0] = (search_matrix [12][6][7:0] < current_matrix [12][6][7:0]) ? current_matrix [12][6][7:0] : search_matrix [12][6][7:0];
	assign inputB[12][6][7:0] = (search_matrix [12][6][7:0] < current_matrix [12][6][7:0]) ? search_matrix [12][6][7:0] : current_matrix [12][6][7:0];
	assign difference_matrix[12][6][7:0] = inputA [12][6][7:0] - inputB [12][6][7:0];
	
	assign inputA[12][7][7:0] = (search_matrix [12][7][7:0] < current_matrix [12][7][7:0]) ? current_matrix [12][7][7:0] : search_matrix [12][7][7:0];
	assign inputB[12][7][7:0] = (search_matrix [12][7][7:0] < current_matrix [12][7][7:0]) ? search_matrix [12][7][7:0] : current_matrix [12][7][7:0];
	assign difference_matrix[12][7][7:0] = inputA [12][7][7:0] - inputB [12][7][7:0];
	
	assign inputA[12][8][7:0] = (search_matrix [12][8][7:0] < current_matrix [12][8][7:0]) ? current_matrix [12][8][7:0] : search_matrix [12][8][7:0];
	assign inputB[12][8][7:0] = (search_matrix [12][8][7:0] < current_matrix [12][8][7:0]) ? search_matrix [12][8][7:0] : current_matrix [12][8][7:0];
	assign difference_matrix[12][8][7:0] = inputA [12][8][7:0] - inputB [12][8][7:0];
	
	assign inputA[12][9][7:0] = (search_matrix [12][9][7:0] < current_matrix [12][9][7:0]) ? current_matrix [12][9][7:0] : search_matrix [12][9][7:0];
	assign inputB[12][9][7:0] = (search_matrix [12][9][7:0] < current_matrix [12][9][7:0]) ? search_matrix [12][9][7:0] : current_matrix [12][9][7:0];
	assign difference_matrix[12][9][7:0] = inputA [12][9][7:0] - inputB [12][9][7:0];
	
	assign inputA[12][10][7:0] = (search_matrix [12][10][7:0] < current_matrix [12][10][7:0]) ? current_matrix [12][10][7:0] : search_matrix [12][10][7:0];
	assign inputB[12][10][7:0] = (search_matrix [12][10][7:0] < current_matrix [12][10][7:0]) ? search_matrix [12][10][7:0] : current_matrix [12][10][7:0];
	assign difference_matrix[12][10][7:0] = inputA [12][10][7:0] - inputB [12][10][7:0];
	
	assign inputA[12][11][7:0] = (search_matrix [12][11][7:0] < current_matrix [12][11][7:0]) ? current_matrix [12][11][7:0] : search_matrix [12][11][7:0];
	assign inputB[12][11][7:0] = (search_matrix [12][11][7:0] < current_matrix [12][11][7:0]) ? search_matrix [12][11][7:0] : current_matrix [12][11][7:0];
	assign difference_matrix[12][11][7:0] = inputA [12][11][7:0] - inputB [12][11][7:0];
	
	assign inputA[12][12][7:0] = (search_matrix [12][12][7:0] < current_matrix [12][12][7:0]) ? current_matrix [12][12][7:0] : search_matrix [12][12][7:0];
	assign inputB[12][12][7:0] = (search_matrix [12][12][7:0] < current_matrix [12][12][7:0]) ? search_matrix [12][12][7:0] : current_matrix [12][12][7:0];
	assign difference_matrix[12][12][7:0] = inputA [12][12][7:0] - inputB [12][12][7:0];
	
	assign inputA[12][13][7:0] = (search_matrix [12][13][7:0] < current_matrix [12][13][7:0]) ? current_matrix [12][13][7:0] : search_matrix [12][13][7:0];
	assign inputB[12][13][7:0] = (search_matrix [12][13][7:0] < current_matrix [12][13][7:0]) ? search_matrix [12][13][7:0] : current_matrix [12][13][7:0];
	assign difference_matrix[12][13][7:0] = inputA [12][13][7:0] - inputB [12][13][7:0];
	
	assign inputA[12][14][7:0] = (search_matrix [12][14][7:0] < current_matrix [12][14][7:0]) ? current_matrix [12][14][7:0] : search_matrix [12][14][7:0];
	assign inputB[12][14][7:0] = (search_matrix [12][14][7:0] < current_matrix [12][14][7:0]) ? search_matrix [12][14][7:0] : current_matrix [12][14][7:0];
	assign difference_matrix[12][14][7:0] = inputA [12][14][7:0] - inputB [12][14][7:0];
	
	assign inputA[12][15][7:0] = (search_matrix [12][15][7:0] < current_matrix [12][15][7:0]) ? current_matrix [12][15][7:0] : search_matrix [12][15][7:0];
	assign inputB[12][15][7:0] = (search_matrix [12][15][7:0] < current_matrix [12][15][7:0]) ? search_matrix [12][15][7:0] : current_matrix [12][15][7:0];
	assign difference_matrix[12][15][7:0] = inputA [12][15][7:0] - inputB [12][15][7:0];
	
	assign inputA[13][0][7:0] = (search_matrix [13][0][7:0] < current_matrix [13][0][7:0]) ? current_matrix [13][0][7:0] : search_matrix [13][0][7:0];
	assign inputB[13][0][7:0] = (search_matrix [13][0][7:0] < current_matrix [13][0][7:0]) ? search_matrix [13][0][7:0] : current_matrix [13][0][7:0];
	assign difference_matrix[13][0][7:0] = inputA [13][0][7:0] - inputB [13][0][7:0];
	
	assign inputA[13][1][7:0] = (search_matrix [13][1][7:0] < current_matrix [13][1][7:0]) ? current_matrix [13][1][7:0] : search_matrix [13][1][7:0];
	assign inputB[13][1][7:0] = (search_matrix [13][1][7:0] < current_matrix [13][1][7:0]) ? search_matrix [13][1][7:0] : current_matrix [13][1][7:0];
	assign difference_matrix[13][1][7:0] = inputA [13][1][7:0] - inputB [13][1][7:0];
	
	assign inputA[13][2][7:0] = (search_matrix [13][2][7:0] < current_matrix [13][2][7:0]) ? current_matrix [13][2][7:0] : search_matrix [13][2][7:0];
	assign inputB[13][2][7:0] = (search_matrix [13][2][7:0] < current_matrix [13][2][7:0]) ? search_matrix [13][2][7:0] : current_matrix [13][2][7:0];
	assign difference_matrix[13][2][7:0] = inputA [13][2][7:0] - inputB [13][2][7:0];
	
	assign inputA[13][3][7:0] = (search_matrix [13][3][7:0] < current_matrix [13][3][7:0]) ? current_matrix [13][3][7:0] : search_matrix [13][3][7:0];
	assign inputB[13][3][7:0] = (search_matrix [13][3][7:0] < current_matrix [13][3][7:0]) ? search_matrix [13][3][7:0] : current_matrix [13][3][7:0];
	assign difference_matrix[13][3][7:0] = inputA [13][3][7:0] - inputB [13][3][7:0];
	
	assign inputA[13][4][7:0] = (search_matrix [13][4][7:0] < current_matrix [13][4][7:0]) ? current_matrix [13][4][7:0] : search_matrix [13][4][7:0];
	assign inputB[13][4][7:0] = (search_matrix [13][4][7:0] < current_matrix [13][4][7:0]) ? search_matrix [13][4][7:0] : current_matrix [13][4][7:0];
	assign difference_matrix[13][4][7:0] = inputA [13][4][7:0] - inputB [13][4][7:0];
	
	assign inputA[13][5][7:0] = (search_matrix [13][5][7:0] < current_matrix [13][5][7:0]) ? current_matrix [13][5][7:0] : search_matrix [13][5][7:0];
	assign inputB[13][5][7:0] = (search_matrix [13][5][7:0] < current_matrix [13][5][7:0]) ? search_matrix [13][5][7:0] : current_matrix [13][5][7:0];
	assign difference_matrix[13][5][7:0] = inputA [13][5][7:0] - inputB [13][5][7:0];
	
	assign inputA[13][6][7:0] = (search_matrix [13][6][7:0] < current_matrix [13][6][7:0]) ? current_matrix [13][6][7:0] : search_matrix [13][6][7:0];
	assign inputB[13][6][7:0] = (search_matrix [13][6][7:0] < current_matrix [13][6][7:0]) ? search_matrix [13][6][7:0] : current_matrix [13][6][7:0];
	assign difference_matrix[13][6][7:0] = inputA [13][6][7:0] - inputB [13][6][7:0];
	
	assign inputA[13][7][7:0] = (search_matrix [13][7][7:0] < current_matrix [13][7][7:0]) ? current_matrix [13][7][7:0] : search_matrix [13][7][7:0];
	assign inputB[13][7][7:0] = (search_matrix [13][7][7:0] < current_matrix [13][7][7:0]) ? search_matrix [13][7][7:0] : current_matrix [13][7][7:0];
	assign difference_matrix[13][7][7:0] = inputA [13][7][7:0] - inputB [13][7][7:0];
	
	assign inputA[13][8][7:0] = (search_matrix [13][8][7:0] < current_matrix [13][8][7:0]) ? current_matrix [13][8][7:0] : search_matrix [13][8][7:0];
	assign inputB[13][8][7:0] = (search_matrix [13][8][7:0] < current_matrix [13][8][7:0]) ? search_matrix [13][8][7:0] : current_matrix [13][8][7:0];
	assign difference_matrix[13][8][7:0] = inputA [13][8][7:0] - inputB [13][8][7:0];
	
	assign inputA[13][9][7:0] = (search_matrix [13][9][7:0] < current_matrix [13][9][7:0]) ? current_matrix [13][9][7:0] : search_matrix [13][9][7:0];
	assign inputB[13][9][7:0] = (search_matrix [13][9][7:0] < current_matrix [13][9][7:0]) ? search_matrix [13][9][7:0] : current_matrix [13][9][7:0];
	assign difference_matrix[13][9][7:0] = inputA [13][9][7:0] - inputB [13][9][7:0];
	
	assign inputA[13][10][7:0] = (search_matrix [13][10][7:0] < current_matrix [13][10][7:0]) ? current_matrix [13][10][7:0] : search_matrix [13][10][7:0];
	assign inputB[13][10][7:0] = (search_matrix [13][10][7:0] < current_matrix [13][10][7:0]) ? search_matrix [13][10][7:0] : current_matrix [13][10][7:0];
	assign difference_matrix[13][10][7:0] = inputA [13][10][7:0] - inputB [13][10][7:0];
	
	assign inputA[13][11][7:0] = (search_matrix [13][11][7:0] < current_matrix [13][11][7:0]) ? current_matrix [13][11][7:0] : search_matrix [13][11][7:0];
	assign inputB[13][11][7:0] = (search_matrix [13][11][7:0] < current_matrix [13][11][7:0]) ? search_matrix [13][11][7:0] : current_matrix [13][11][7:0];
	assign difference_matrix[13][11][7:0] = inputA [13][11][7:0] - inputB [13][11][7:0];
	
	assign inputA[13][12][7:0] = (search_matrix [13][12][7:0] < current_matrix [13][12][7:0]) ? current_matrix [13][12][7:0] : search_matrix [13][12][7:0];
	assign inputB[13][12][7:0] = (search_matrix [13][12][7:0] < current_matrix [13][12][7:0]) ? search_matrix [13][12][7:0] : current_matrix [13][12][7:0];
	assign difference_matrix[13][12][7:0] = inputA [13][12][7:0] - inputB [13][12][7:0];
	
	assign inputA[13][13][7:0] = (search_matrix [13][13][7:0] < current_matrix [13][13][7:0]) ? current_matrix [13][13][7:0] : search_matrix [13][13][7:0];
	assign inputB[13][13][7:0] = (search_matrix [13][13][7:0] < current_matrix [13][13][7:0]) ? search_matrix [13][13][7:0] : current_matrix [13][13][7:0];
	assign difference_matrix[13][13][7:0] = inputA [13][13][7:0] - inputB [13][13][7:0];
	
	assign inputA[13][14][7:0] = (search_matrix [13][14][7:0] < current_matrix [13][14][7:0]) ? current_matrix [13][14][7:0] : search_matrix [13][14][7:0];
	assign inputB[13][14][7:0] = (search_matrix [13][14][7:0] < current_matrix [13][14][7:0]) ? search_matrix [13][14][7:0] : current_matrix [13][14][7:0];
	assign difference_matrix[13][14][7:0] = inputA [13][14][7:0] - inputB [13][14][7:0];
	
	assign inputA[13][15][7:0] = (search_matrix [13][15][7:0] < current_matrix [13][15][7:0]) ? current_matrix [13][15][7:0] : search_matrix [13][15][7:0];
	assign inputB[13][15][7:0] = (search_matrix [13][15][7:0] < current_matrix [13][15][7:0]) ? search_matrix [13][15][7:0] : current_matrix [13][15][7:0];
	assign difference_matrix[13][15][7:0] = inputA [13][15][7:0] - inputB [13][15][7:0];
	
	assign inputA[14][0][7:0] = (search_matrix [14][0][7:0] < current_matrix [14][0][7:0]) ? current_matrix [14][0][7:0] : search_matrix [14][0][7:0];
	assign inputB[14][0][7:0] = (search_matrix [14][0][7:0] < current_matrix [14][0][7:0]) ? search_matrix [14][0][7:0] : current_matrix [14][0][7:0];
	assign difference_matrix[14][0][7:0] = inputA [14][0][7:0] - inputB [14][0][7:0];
	
	assign inputA[14][1][7:0] = (search_matrix [14][1][7:0] < current_matrix [14][1][7:0]) ? current_matrix [14][1][7:0] : search_matrix [14][1][7:0];
	assign inputB[14][1][7:0] = (search_matrix [14][1][7:0] < current_matrix [14][1][7:0]) ? search_matrix [14][1][7:0] : current_matrix [14][1][7:0];
	assign difference_matrix[14][1][7:0] = inputA [14][1][7:0] - inputB [14][1][7:0];
	
	assign inputA[14][2][7:0] = (search_matrix [14][2][7:0] < current_matrix [14][2][7:0]) ? current_matrix [14][2][7:0] : search_matrix [14][2][7:0];
	assign inputB[14][2][7:0] = (search_matrix [14][2][7:0] < current_matrix [14][2][7:0]) ? search_matrix [14][2][7:0] : current_matrix [14][2][7:0];
	assign difference_matrix[14][2][7:0] = inputA [14][2][7:0] - inputB [14][2][7:0];
	
	assign inputA[14][3][7:0] = (search_matrix [14][3][7:0] < current_matrix [14][3][7:0]) ? current_matrix [14][3][7:0] : search_matrix [14][3][7:0];
	assign inputB[14][3][7:0] = (search_matrix [14][3][7:0] < current_matrix [14][3][7:0]) ? search_matrix [14][3][7:0] : current_matrix [14][3][7:0];
	assign difference_matrix[14][3][7:0] = inputA [14][3][7:0] - inputB [14][3][7:0];
	
	assign inputA[14][4][7:0] = (search_matrix [14][4][7:0] < current_matrix [14][4][7:0]) ? current_matrix [14][4][7:0] : search_matrix [14][4][7:0];
	assign inputB[14][4][7:0] = (search_matrix [14][4][7:0] < current_matrix [14][4][7:0]) ? search_matrix [14][4][7:0] : current_matrix [14][4][7:0];
	assign difference_matrix[14][4][7:0] = inputA [14][4][7:0] - inputB [14][4][7:0];
	
	assign inputA[14][5][7:0] = (search_matrix [14][5][7:0] < current_matrix [14][5][7:0]) ? current_matrix [14][5][7:0] : search_matrix [14][5][7:0];
	assign inputB[14][5][7:0] = (search_matrix [14][5][7:0] < current_matrix [14][5][7:0]) ? search_matrix [14][5][7:0] : current_matrix [14][5][7:0];
	assign difference_matrix[14][5][7:0] = inputA [14][5][7:0] - inputB [14][5][7:0];
	
	assign inputA[14][6][7:0] = (search_matrix [14][6][7:0] < current_matrix [14][6][7:0]) ? current_matrix [14][6][7:0] : search_matrix [14][6][7:0];
	assign inputB[14][6][7:0] = (search_matrix [14][6][7:0] < current_matrix [14][6][7:0]) ? search_matrix [14][6][7:0] : current_matrix [14][6][7:0];
	assign difference_matrix[14][6][7:0] = inputA [14][6][7:0] - inputB [14][6][7:0];
	
	assign inputA[14][7][7:0] = (search_matrix [14][7][7:0] < current_matrix [14][7][7:0]) ? current_matrix [14][7][7:0] : search_matrix [14][7][7:0];
	assign inputB[14][7][7:0] = (search_matrix [14][7][7:0] < current_matrix [14][7][7:0]) ? search_matrix [14][7][7:0] : current_matrix [14][7][7:0];
	assign difference_matrix[14][7][7:0] = inputA [14][7][7:0] - inputB [14][7][7:0];
	
	assign inputA[14][8][7:0] = (search_matrix [14][8][7:0] < current_matrix [14][8][7:0]) ? current_matrix [14][8][7:0] : search_matrix [14][8][7:0];
	assign inputB[14][8][7:0] = (search_matrix [14][8][7:0] < current_matrix [14][8][7:0]) ? search_matrix [14][8][7:0] : current_matrix [14][8][7:0];
	assign difference_matrix[14][8][7:0] = inputA [14][8][7:0] - inputB [14][8][7:0];
	
	assign inputA[14][9][7:0] = (search_matrix [14][9][7:0] < current_matrix [14][9][7:0]) ? current_matrix [14][9][7:0] : search_matrix [14][9][7:0];
	assign inputB[14][9][7:0] = (search_matrix [14][9][7:0] < current_matrix [14][9][7:0]) ? search_matrix [14][9][7:0] : current_matrix [14][9][7:0];
	assign difference_matrix[14][9][7:0] = inputA [14][9][7:0] - inputB [14][9][7:0];
	
	assign inputA[14][10][7:0] = (search_matrix [14][10][7:0] < current_matrix [14][10][7:0]) ? current_matrix [14][10][7:0] : search_matrix [14][10][7:0];
	assign inputB[14][10][7:0] = (search_matrix [14][10][7:0] < current_matrix [14][10][7:0]) ? search_matrix [14][10][7:0] : current_matrix [14][10][7:0];
	assign difference_matrix[14][10][7:0] = inputA [14][10][7:0] - inputB [14][10][7:0];
	
	assign inputA[14][11][7:0] = (search_matrix [14][11][7:0] < current_matrix [14][11][7:0]) ? current_matrix [14][11][7:0] : search_matrix [14][11][7:0];
	assign inputB[14][11][7:0] = (search_matrix [14][11][7:0] < current_matrix [14][11][7:0]) ? search_matrix [14][11][7:0] : current_matrix [14][11][7:0];
	assign difference_matrix[14][11][7:0] = inputA [14][11][7:0] - inputB [14][11][7:0];
	
	assign inputA[14][12][7:0] = (search_matrix [14][12][7:0] < current_matrix [14][12][7:0]) ? current_matrix [14][12][7:0] : search_matrix [14][12][7:0];
	assign inputB[14][12][7:0] = (search_matrix [14][12][7:0] < current_matrix [14][12][7:0]) ? search_matrix [14][12][7:0] : current_matrix [14][12][7:0];
	assign difference_matrix[14][12][7:0] = inputA [14][12][7:0] - inputB [14][12][7:0];
	
	assign inputA[14][13][7:0] = (search_matrix [14][13][7:0] < current_matrix [14][13][7:0]) ? current_matrix [14][13][7:0] : search_matrix [14][13][7:0];
	assign inputB[14][13][7:0] = (search_matrix [14][13][7:0] < current_matrix [14][13][7:0]) ? search_matrix [14][13][7:0] : current_matrix [14][13][7:0];
	assign difference_matrix[14][13][7:0] = inputA [14][13][7:0] - inputB [14][13][7:0];
	
	assign inputA[14][14][7:0] = (search_matrix [14][14][7:0] < current_matrix [14][14][7:0]) ? current_matrix [14][14][7:0] : search_matrix [14][14][7:0];
	assign inputB[14][14][7:0] = (search_matrix [14][14][7:0] < current_matrix [14][14][7:0]) ? search_matrix [14][14][7:0] : current_matrix [14][14][7:0];
	assign difference_matrix[14][14][7:0] = inputA [14][14][7:0] - inputB [14][14][7:0];
	
	assign inputA[14][15][7:0] = (search_matrix [14][15][7:0] < current_matrix [14][15][7:0]) ? current_matrix [14][15][7:0] : search_matrix [14][15][7:0];
	assign inputB[14][15][7:0] = (search_matrix [14][15][7:0] < current_matrix [14][15][7:0]) ? search_matrix [14][15][7:0] : current_matrix [14][15][7:0];
	assign difference_matrix[14][15][7:0] = inputA [14][15][7:0] - inputB [14][15][7:0];
	
	assign inputA[15][0][7:0] = (search_matrix [15][0][7:0] < current_matrix [15][0][7:0]) ? current_matrix [15][0][7:0] : search_matrix [15][0][7:0];
	assign inputB[15][0][7:0] = (search_matrix [15][0][7:0] < current_matrix [15][0][7:0]) ? search_matrix [15][0][7:0] : current_matrix [15][0][7:0];
	assign difference_matrix[15][0][7:0] = inputA [15][0][7:0] - inputB [15][0][7:0];
	
	assign inputA[15][1][7:0] = (search_matrix [15][1][7:0] < current_matrix [15][1][7:0]) ? current_matrix [15][1][7:0] : search_matrix [15][1][7:0];
	assign inputB[15][1][7:0] = (search_matrix [15][1][7:0] < current_matrix [15][1][7:0]) ? search_matrix [15][1][7:0] : current_matrix [15][1][7:0];
	assign difference_matrix[15][1][7:0] = inputA [15][1][7:0] - inputB [15][1][7:0];
	
	assign inputA[15][2][7:0] = (search_matrix [15][2][7:0] < current_matrix [15][2][7:0]) ? current_matrix [15][2][7:0] : search_matrix [15][2][7:0];
	assign inputB[15][2][7:0] = (search_matrix [15][2][7:0] < current_matrix [15][2][7:0]) ? search_matrix [15][2][7:0] : current_matrix [15][2][7:0];
	assign difference_matrix[15][2][7:0] = inputA [15][2][7:0] - inputB [15][2][7:0];
	
	assign inputA[15][3][7:0] = (search_matrix [15][3][7:0] < current_matrix [15][3][7:0]) ? current_matrix [15][3][7:0] : search_matrix [15][3][7:0];
	assign inputB[15][3][7:0] = (search_matrix [15][3][7:0] < current_matrix [15][3][7:0]) ? search_matrix [15][3][7:0] : current_matrix [15][3][7:0];
	assign difference_matrix[15][3][7:0] = inputA [15][3][7:0] - inputB [15][3][7:0];
	
	assign inputA[15][4][7:0] = (search_matrix [15][4][7:0] < current_matrix [15][4][7:0]) ? current_matrix [15][4][7:0] : search_matrix [15][4][7:0];
	assign inputB[15][4][7:0] = (search_matrix [15][4][7:0] < current_matrix [15][4][7:0]) ? search_matrix [15][4][7:0] : current_matrix [15][4][7:0];
	assign difference_matrix[15][4][7:0] = inputA [15][4][7:0] - inputB [15][4][7:0];
	
	assign inputA[15][5][7:0] = (search_matrix [15][5][7:0] < current_matrix [15][5][7:0]) ? current_matrix [15][5][7:0] : search_matrix [15][5][7:0];
	assign inputB[15][5][7:0] = (search_matrix [15][5][7:0] < current_matrix [15][5][7:0]) ? search_matrix [15][5][7:0] : current_matrix [15][5][7:0];
	assign difference_matrix[15][5][7:0] = inputA [15][5][7:0] - inputB [15][5][7:0];
	
	assign inputA[15][6][7:0] = (search_matrix [15][6][7:0] < current_matrix [15][6][7:0]) ? current_matrix [15][6][7:0] : search_matrix [15][6][7:0];
	assign inputB[15][6][7:0] = (search_matrix [15][6][7:0] < current_matrix [15][6][7:0]) ? search_matrix [15][6][7:0] : current_matrix [15][6][7:0];
	assign difference_matrix[15][6][7:0] = inputA [15][6][7:0] - inputB [15][6][7:0];
	
	assign inputA[15][7][7:0] = (search_matrix [15][7][7:0] < current_matrix [15][7][7:0]) ? current_matrix [15][7][7:0] : search_matrix [15][7][7:0];
	assign inputB[15][7][7:0] = (search_matrix [15][7][7:0] < current_matrix [15][7][7:0]) ? search_matrix [15][7][7:0] : current_matrix [15][7][7:0];
	assign difference_matrix[15][7][7:0] = inputA [15][7][7:0] - inputB [15][7][7:0];
	
	assign inputA[15][8][7:0] = (search_matrix [15][8][7:0] < current_matrix [15][8][7:0]) ? current_matrix [15][8][7:0] : search_matrix [15][8][7:0];
	assign inputB[15][8][7:0] = (search_matrix [15][8][7:0] < current_matrix [15][8][7:0]) ? search_matrix [15][8][7:0] : current_matrix [15][8][7:0];
	assign difference_matrix[15][8][7:0] = inputA [15][8][7:0] - inputB [15][8][7:0];
	
	assign inputA[15][9][7:0] = (search_matrix [15][9][7:0] < current_matrix [15][9][7:0]) ? current_matrix [15][9][7:0] : search_matrix [15][9][7:0];
	assign inputB[15][9][7:0] = (search_matrix [15][9][7:0] < current_matrix [15][9][7:0]) ? search_matrix [15][9][7:0] : current_matrix [15][9][7:0];
	assign difference_matrix[15][9][7:0] = inputA [15][9][7:0] - inputB [15][9][7:0];
	
	assign inputA[15][10][7:0] = (search_matrix [15][10][7:0] < current_matrix [15][10][7:0]) ? current_matrix [15][10][7:0] : search_matrix [15][10][7:0];
	assign inputB[15][10][7:0] = (search_matrix [15][10][7:0] < current_matrix [15][10][7:0]) ? search_matrix [15][10][7:0] : current_matrix [15][10][7:0];
	assign difference_matrix[15][10][7:0] = inputA [15][10][7:0] - inputB [15][10][7:0];
	
	assign inputA[15][11][7:0] = (search_matrix [15][11][7:0] < current_matrix [15][11][7:0]) ? current_matrix [15][11][7:0] : search_matrix [15][11][7:0];
	assign inputB[15][11][7:0] = (search_matrix [15][11][7:0] < current_matrix [15][11][7:0]) ? search_matrix [15][11][7:0] : current_matrix [15][11][7:0];
	assign difference_matrix[15][11][7:0] = inputA [15][11][7:0] - inputB [15][11][7:0];
	
	assign inputA[15][12][7:0] = (search_matrix [15][12][7:0] < current_matrix [15][12][7:0]) ? current_matrix [15][12][7:0] : search_matrix [15][12][7:0];
	assign inputB[15][12][7:0] = (search_matrix [15][12][7:0] < current_matrix [15][12][7:0]) ? search_matrix [15][12][7:0] : current_matrix [15][12][7:0];
	assign difference_matrix[15][12][7:0] = inputA [15][12][7:0] - inputB [15][12][7:0];
	
	assign inputA[15][13][7:0] = (search_matrix [15][13][7:0] < current_matrix [15][13][7:0]) ? current_matrix [15][13][7:0] : search_matrix [15][13][7:0];
	assign inputB[15][13][7:0] = (search_matrix [15][13][7:0] < current_matrix [15][13][7:0]) ? search_matrix [15][13][7:0] : current_matrix [15][13][7:0];
	assign difference_matrix[15][13][7:0] = inputA [15][13][7:0] - inputB [15][13][7:0];
	
	assign inputA[15][14][7:0] = (search_matrix [15][14][7:0] < current_matrix [15][14][7:0]) ? current_matrix [15][14][7:0] : search_matrix [15][14][7:0];
	assign inputB[15][14][7:0] = (search_matrix [15][14][7:0] < current_matrix [15][14][7:0]) ? search_matrix [15][14][7:0] : current_matrix [15][14][7:0];
	assign difference_matrix[15][14][7:0] = inputA [15][14][7:0] - inputB [15][14][7:0];
	
	assign inputA[15][15][7:0] = (search_matrix [15][15][7:0] < current_matrix [15][15][7:0]) ? current_matrix [15][15][7:0] : search_matrix [15][15][7:0];
	assign inputB[15][15][7:0] = (search_matrix [15][15][7:0] < current_matrix [15][15][7:0]) ? search_matrix [15][15][7:0] : current_matrix [15][15][7:0];
	assign difference_matrix[15][15][7:0] = inputA [15][15][7:0] - inputB [15][15][7:0];

	//
	
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
		begin
			add01	<=	12'hFF	;
			add02	<=	12'hFF	;
			add03	<=	12'hFF	;
			add04	<=	12'hFF	;
			add05	<=	12'hFF	;
			add06	<=	12'hFF	;
			add07	<=	12'hFF	;
			add08	<=	12'hFF	;
			add09	<=	12'hFF	;
			add10	<=	12'hFF	;
			add11	<=	12'hFF	;
			add12	<=	12'hFF	;
			add13	<=	12'hFF	;
			add14	<=	12'hFF	;
			add15	<=	12'hFF	;
			add16	<=	12'hFF	;
			add17	<=	12'hFF	;
			add18	<=	12'hFF	;
			add19	<=	12'hFF	;
			add20	<=	12'hFF	;
			add21	<=	12'hFF	;
			add22	<=	12'hFF	;
			add23	<=	12'hFF	;
			add24	<=	12'hFF	;
			add25	<=	12'hFF	;
			add26	<=	12'hFF	;
			add27	<=	12'hFF	;
			add28	<=	12'hFF	;
			add29	<=	12'hFF	;
			add30	<=	12'hFF	;
			add31	<=	12'hFF	;
			add32	<=	12'hFF	;
			add33	<=	12'hFF	;
			add34	<=	12'hFF	;
			add35	<=	12'hFF	;
			add36	<=	12'hFF	;
			add37	<=	12'hFF	;
			add38	<=	12'hFF	;
			add39	<=	12'hFF	;
			add40	<=	12'hFF	;
			add41	<=	12'hFF	;
			add42	<=	12'hFF	;
			add43	<=	12'hFF	;
			add44	<=	12'hFF	;
			add45	<=	12'hFF	;
			add46	<=	12'hFF	;
			add47	<=	12'hFF	;
			add48	<=	12'hFF	;
			add49	<=	12'hFF	;
			add50	<=	12'hFF	;
			add51	<=	12'hFF	;
			add52	<=	12'hFF	;
			add53	<=	12'hFF	;
			add54	<=	12'hFF	;
			add55	<=	12'hFF	;
			add56	<=	12'hFF	;
			add57	<=	12'hFF	;
			add58	<=	12'hFF	;
			add59	<=	12'hFF	;
			add60	<=	12'hFF	;
			add61	<=	12'hFF	;
			add62	<=	12'hFF	;
			add63	<=	12'hFF	;
			add64	<=	12'hFF	;
		end
		else 
		begin
			add01	<=	(difference_matrix [0][0][7:0] + difference_matrix [0][1][7:0]) + (difference_matrix [0][2][7:0] + difference_matrix [0][3][7:0]);
			add02	<=	(difference_matrix [0][4][7:0] + difference_matrix [0][5][7:0]) + (difference_matrix [0][6][7:0] + difference_matrix [0][7][7:0]);
			add03	<=	(difference_matrix [0][8][7:0] + difference_matrix [0][9][7:0]) + (difference_matrix [0][10][7:0] + difference_matrix [0][11][7:0]);
			add04	<=	(difference_matrix [0][12][7:0] + difference_matrix [0][13][7:0]) + (difference_matrix [0][14][7:0] + difference_matrix [0][15][7:0]);
			add05	<=	(difference_matrix [1][0][7:0] + difference_matrix [1][1][7:0]) + (difference_matrix [1][2][7:0] + difference_matrix [1][3][7:0]);
			add06	<=	(difference_matrix [1][4][7:0] + difference_matrix [1][5][7:0]) + (difference_matrix [1][6][7:0] + difference_matrix [1][7][7:0]);
			add07	<=	(difference_matrix [1][8][7:0] + difference_matrix [1][9][7:0]) + (difference_matrix [1][10][7:0] + difference_matrix [1][11][7:0]);
			add08	<=	(difference_matrix [1][12][7:0] + difference_matrix [1][13][7:0]) + (difference_matrix [1][14][7:0] + difference_matrix [1][15][7:0]);
			add09	<=	(difference_matrix [2][0][7:0] + difference_matrix [2][1][7:0]) + (difference_matrix [2][2][7:0] + difference_matrix [2][3][7:0]);
			add10	<=	(difference_matrix [2][4][7:0] + difference_matrix [2][5][7:0]) + (difference_matrix [2][6][7:0] + difference_matrix [2][7][7:0]);
			add11	<=	(difference_matrix [2][8][7:0] + difference_matrix [2][9][7:0]) + (difference_matrix [2][10][7:0] + difference_matrix [2][11][7:0]);
			add12	<=	(difference_matrix [2][12][7:0] + difference_matrix [2][13][7:0]) + (difference_matrix [2][14][7:0] + difference_matrix [2][15][7:0]);
			add13	<=	(difference_matrix [3][0][7:0] + difference_matrix [3][1][7:0]) + (difference_matrix [3][2][7:0] + difference_matrix [3][3][7:0]);
			add14	<=	(difference_matrix [3][4][7:0] + difference_matrix [3][5][7:0]) + (difference_matrix [3][6][7:0] + difference_matrix [3][7][7:0]);
			add15	<=	(difference_matrix [3][8][7:0] + difference_matrix [3][9][7:0]) + (difference_matrix [3][10][7:0] + difference_matrix [3][11][7:0]);
			add16	<=	(difference_matrix [3][12][7:0] + difference_matrix [3][13][7:0]) + (difference_matrix [3][14][7:0] + difference_matrix [3][15][7:0]);
			add17	<=	(difference_matrix [4][0][7:0] + difference_matrix [4][1][7:0]) + (difference_matrix [4][2][7:0] + difference_matrix [4][3][7:0]);
			add18	<=	(difference_matrix [4][4][7:0] + difference_matrix [4][5][7:0]) + (difference_matrix [4][6][7:0] + difference_matrix [4][7][7:0]);
			add19	<=	(difference_matrix [4][8][7:0] + difference_matrix [4][9][7:0]) + (difference_matrix [4][10][7:0] + difference_matrix [4][11][7:0]);
			add20	<=	(difference_matrix [4][12][7:0] + difference_matrix [4][13][7:0]) + (difference_matrix [4][14][7:0] + difference_matrix [4][15][7:0]);
			add21	<=	(difference_matrix [5][0][7:0] + difference_matrix [5][1][7:0]) + (difference_matrix [5][2][7:0] + difference_matrix [5][3][7:0]);
			add22	<=	(difference_matrix [5][4][7:0] + difference_matrix [5][5][7:0]) + (difference_matrix [5][6][7:0] + difference_matrix [5][7][7:0]);
			add23	<=	(difference_matrix [5][8][7:0] + difference_matrix [5][9][7:0]) + (difference_matrix [5][10][7:0] + difference_matrix [5][11][7:0]);
			add24	<=	(difference_matrix [5][12][7:0] + difference_matrix [5][13][7:0]) + (difference_matrix [5][14][7:0] + difference_matrix [5][15][7:0]);
			add25	<=	(difference_matrix [6][0][7:0] + difference_matrix [6][1][7:0]) + (difference_matrix [6][2][7:0] + difference_matrix [6][3][7:0]);
			add26	<=	(difference_matrix [6][4][7:0] + difference_matrix [6][5][7:0]) + (difference_matrix [6][6][7:0] + difference_matrix [6][7][7:0]);
			add27	<=	(difference_matrix [6][8][7:0] + difference_matrix [6][9][7:0]) + (difference_matrix [6][10][7:0] + difference_matrix [6][11][7:0]);
			add28	<=	(difference_matrix [6][12][7:0] + difference_matrix [6][13][7:0]) + (difference_matrix [6][14][7:0] + difference_matrix [6][15][7:0]);
			add29	<=	(difference_matrix [7][0][7:0] + difference_matrix [7][1][7:0]) + (difference_matrix [7][2][7:0] + difference_matrix [7][3][7:0]);
			add30	<=	(difference_matrix [7][4][7:0] + difference_matrix [7][5][7:0]) + (difference_matrix [7][6][7:0] + difference_matrix [7][7][7:0]);
			add31	<=	(difference_matrix [7][8][7:0] + difference_matrix [7][9][7:0]) + (difference_matrix [7][10][7:0] + difference_matrix [7][11][7:0]);
			add32	<=	(difference_matrix [7][12][7:0] + difference_matrix [7][13][7:0]) + (difference_matrix [7][14][7:0] + difference_matrix [7][15][7:0]);
			add33	<=	(difference_matrix [8][0][7:0] + difference_matrix [8][1][7:0]) + (difference_matrix [8][2][7:0] + difference_matrix [8][3][7:0]);
			add34	<=	(difference_matrix [8][4][7:0] + difference_matrix [8][5][7:0]) + (difference_matrix [8][6][7:0] + difference_matrix [8][7][7:0]);
			add35	<=	(difference_matrix [8][8][7:0] + difference_matrix [8][9][7:0]) + (difference_matrix [8][10][7:0] + difference_matrix [8][11][7:0]);
			add36	<=	(difference_matrix [8][12][7:0] + difference_matrix [8][13][7:0]) + (difference_matrix [8][14][7:0] + difference_matrix [8][15][7:0]);
			add37	<=	(difference_matrix [9][0][7:0] + difference_matrix [9][1][7:0]) + (difference_matrix [9][2][7:0] + difference_matrix [9][3][7:0]);
			add38	<=	(difference_matrix [9][4][7:0] + difference_matrix [9][5][7:0]) + (difference_matrix [9][6][7:0] + difference_matrix [9][7][7:0]);
			add39	<=	(difference_matrix [9][8][7:0] + difference_matrix [9][9][7:0]) + (difference_matrix [9][10][7:0] + difference_matrix [9][11][7:0]);
			add40	<=	(difference_matrix [9][12][7:0] + difference_matrix [9][13][7:0]) + (difference_matrix [9][14][7:0] + difference_matrix [9][15][7:0]);
			add41	<=	(difference_matrix [10][0][7:0] + difference_matrix [10][1][7:0]) + (difference_matrix [10][2][7:0] + difference_matrix [10][3][7:0]);
			add42	<=	(difference_matrix [10][4][7:0] + difference_matrix [10][5][7:0]) + (difference_matrix [10][6][7:0] + difference_matrix [10][7][7:0]);
			add43	<=	(difference_matrix [10][8][7:0] + difference_matrix [10][9][7:0]) + (difference_matrix [10][10][7:0] + difference_matrix [10][11][7:0]);
			add44	<=	(difference_matrix [10][12][7:0] + difference_matrix [10][13][7:0]) + (difference_matrix [10][14][7:0] + difference_matrix [10][15][7:0]);
			add45	<=	(difference_matrix [11][0][7:0] + difference_matrix [11][1][7:0]) + (difference_matrix [11][2][7:0] + difference_matrix [11][3][7:0]);
			add46	<=	(difference_matrix [11][4][7:0] + difference_matrix [11][5][7:0]) + (difference_matrix [11][6][7:0] + difference_matrix [11][7][7:0]);
			add47	<=	(difference_matrix [11][8][7:0] + difference_matrix [11][9][7:0]) + (difference_matrix [11][10][7:0] + difference_matrix [11][11][7:0]);
			add48	<=	(difference_matrix [11][12][7:0] + difference_matrix [11][13][7:0]) + (difference_matrix [11][14][7:0] + difference_matrix [11][15][7:0]);
			add49	<=	(difference_matrix [12][0][7:0] + difference_matrix [12][1][7:0]) + (difference_matrix [12][2][7:0] + difference_matrix [12][3][7:0]);
			add50	<=	(difference_matrix [12][4][7:0] + difference_matrix [12][5][7:0]) + (difference_matrix [12][6][7:0] + difference_matrix [12][7][7:0]);
			add51	<=	(difference_matrix [12][8][7:0] + difference_matrix [12][9][7:0]) + (difference_matrix [12][10][7:0] + difference_matrix [12][11][7:0]);
			add52	<=	(difference_matrix [12][12][7:0] + difference_matrix [12][13][7:0]) + (difference_matrix [12][14][7:0] + difference_matrix [12][15][7:0]);
			add53	<=	(difference_matrix [13][0][7:0] + difference_matrix [13][1][7:0]) + (difference_matrix [13][2][7:0] + difference_matrix [13][3][7:0]);
			add54	<=	(difference_matrix [13][4][7:0] + difference_matrix [13][5][7:0]) + (difference_matrix [13][6][7:0] + difference_matrix [13][7][7:0]);
			add55	<=	(difference_matrix [13][8][7:0] + difference_matrix [13][9][7:0]) + (difference_matrix [13][10][7:0] + difference_matrix [13][11][7:0]);
			add56	<=	(difference_matrix [13][12][7:0] + difference_matrix [13][13][7:0]) + (difference_matrix [13][14][7:0] + difference_matrix [13][15][7:0]);
			add57	<=	(difference_matrix [14][0][7:0] + difference_matrix [14][1][7:0]) + (difference_matrix [14][2][7:0] + difference_matrix [14][3][7:0]);
			add58	<=	(difference_matrix [14][4][7:0] + difference_matrix [14][5][7:0]) + (difference_matrix [14][6][7:0] + difference_matrix [14][7][7:0]);
			add59	<=	(difference_matrix [14][8][7:0] + difference_matrix [14][9][7:0]) + (difference_matrix [14][10][7:0] + difference_matrix [14][11][7:0]);
			add60	<=	(difference_matrix [14][12][7:0] + difference_matrix [14][13][7:0]) + (difference_matrix [14][14][7:0] + difference_matrix [14][15][7:0]);
			add61	<=	(difference_matrix [15][0][7:0] + difference_matrix [15][1][7:0]) + (difference_matrix [15][2][7:0] + difference_matrix [15][3][7:0]);
			add62	<=	(difference_matrix [15][4][7:0] + difference_matrix [15][5][7:0]) + (difference_matrix [15][6][7:0] + difference_matrix [15][7][7:0]);
			add63	<=	(difference_matrix [15][8][7:0] + difference_matrix [15][9][7:0]) + (difference_matrix [15][10][7:0] + difference_matrix [15][11][7:0]);
			add64	<=	(difference_matrix [15][12][7:0] + difference_matrix [15][13][7:0]) + (difference_matrix [15][14][7:0] + difference_matrix [15][15][7:0]);
		end
	end
	
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
		begin
			SAD01 <= 12'hFF;
			SAD02 <= 12'hFF;
			SAD03 <= 12'hFF;
			SAD04 <= 12'hFF;
			SAD05 <= 12'hFF;
			SAD06 <= 12'hFF;
			SAD07 <= 12'hFF;
			SAD08 <= 12'hFF;
			SAD09 <= 12'hFF;
			SAD10 <= 12'hFF;
			SAD11 <= 12'hFF;
			SAD12 <= 12'hFF;
			SAD13 <= 12'hFF;
			SAD14 <= 12'hFF;
			SAD15 <= 12'hFF;
			SAD16 <= 12'hFF;
		end
		else 
		begin
			SAD01 <= (add52 + add56) + (add60 + add64);
			SAD02 <= (add51 + add55) + (add59 + add63);
			SAD03 <= (add50 + add54) + (add58 + add62);
			SAD04 <= (add49 + add53) + (add57 + add61);
			SAD05 <= (add36 + add40) + (add44 + add48);
			SAD06 <= (add35 + add39) + (add43 + add47);
			SAD07 <= (add34 + add38) + (add42 + add46);
			SAD08 <= (add33 + add37) + (add41 + add45);
			SAD09 <= (add20 + add24) + (add28 + add32);
			SAD10 <= (add19 + add23) + (add27 + add31);
			SAD11 <= (add18 + add22) + (add26 + add30);
			SAD12 <= (add17 + add21) + (add25 + add29);
			SAD13 <= (add04 + add08) + (add12 + add16);
			SAD14 <= (add03 + add07) + (add11 + add15);
			SAD15 <= (add02 + add06) + (add10 + add14);
			SAD16 <= (add01 + add05) + (add09 + add13);
		end
	end
	
		always @ (posedge clk, posedge reset)
	begin
		if (reset)
		begin
			SAD33_delay <= 14'h3FF;
			SAD34_delay <= 14'h3FF;
			SAD35_delay <= 14'h3FF;
			SAD36_delay <= 14'h3FF;
		end
		else
		begin
			SAD33_delay <= (SAD01 + SAD02) + (SAD05 + SAD06);
			SAD34_delay <= (SAD03 + SAD04) + (SAD07 + SAD08);
			SAD35_delay <= (SAD09 + SAD10) + (SAD13 + SAD14);
			SAD36_delay <= (SAD11 + SAD12) + (SAD15 + SAD16);
		end
	end
	assign SADOUT = ({1'b0,SAD33_delay} + SAD35_delay) + ({1'b0,SAD34_delay} + SAD36_delay);
endmodule

