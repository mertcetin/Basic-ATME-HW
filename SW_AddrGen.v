module SW_AddrGen(clk,reset,enable,/*SW_WE,*/SW_WE_req,vecin,updatein,/*UW_Filled,UWDATA_Out,UW_WE,*/MV_ready,outMV/*,InputDATA,InputADDR*/,done/*,UWaddress_out,UW_ROW,UW_COL*/,MVselect_WE,MVwait,Row_end,frame_end,feed,limited_out_x,limited_out_y,SBFilled,goextended,extended,underTh);
input clk,reset,enable,SBFilled,goextended;
output reg /*SW_WE,*/SW_WE_req;
input [5:0] updatein;
input [13:0] vecin;
input /*UW_Filled, */MV_ready,Row_end,frame_end;
output reg [13:0] outMV;
//*output reg [(8*22)-1:0] UWDATA_Out;
//*output reg UW_WE;
//*input [0:88*8-1] InputDATA;
//*input [6:0] InputADDR;
output done,feed;
output reg MVselect_WE, extended;
//*output wire [4:0] UWaddress_out;
//*output reg [2:0] UW_ROW,UW_COL;
output wire MVwait;
reg [2:0] feedcount;
//*reg [4:0] order;
//*reg [7:0] packedInput [0:87];
//*reg [6:0] SWshift;
reg inside;
//*reg [13:0] UWpos;
reg[13:0] out;
wire [1:0] pre_median;
reg [1:0] median;
wire pre_underTh;
output reg underTh;
reg [3:0] State;
//*reg SubState, SubState_d;
reg [13:0] vectors0,vectors1,vectors2,vectors3;
reg [13:0] medianMV;
//*reg [4:0] UWaddress,UW_count;
/**wire [6:0] UWcheck_y;
wire [6:0] UWcheck_x;
wire [6:0] check_y;
wire [6:0] check_x;
reg [6:0] check_y_d;
reg [6:0] check_x_d;*/
output wire [6:0] limited_out_x/*,neg_lim_out_x*/;
output wire [6:0] limited_out_y/*,neg_lim_out_y*/;
/**reg [6:0] neg_lim_out_x_reg ,neg_lim_out_y_reg;
wire [6:0] UWpos_x;
wire [6:0] UWpos_y;
reg [1:0] mod_x,mod_y;
reg [4:0] SWcoord_mod_x, SWcoord_mod_y;
wire [6:0] SWcoord_x, SWcoord_y, modSWcoord_y, modSWcoord_x, premodSWcoord_y, premodSWcoord_x;
reg [6:0] SWcoord_x_reg, SWcoord_y_reg;
wire [7:0] preSWcoord_x, preSWcoord_y;
wire [8:0] addrrow,addrcol;
reg valid,valid_d,einside;
reg [31:0] WDATA_S01, WDATA_S02, WDATA_S03, WDATA_S04, WDATA_S05, WDATA_S06, WDATA_S07, WDATA_S08, WDATA_S09, WDATA_S10, WDATA_S11, WDATA_S12, WDATA_S13, WDATA_S14, WDATA_S15, WDATA_S16, WDATA_S17, WDATA_S18, WDATA_S19, WDATA_S20, WDATA_S21, WDATA_S22;
	
reg [8:0] RADDR_S01, RADDR_S02, RADDR_S03, RADDR_S04, RADDR_S05, RADDR_S06, RADDR_S07, RADDR_S08, RADDR_S09, RADDR_S10, RADDR_S11, RADDR_S12, RADDR_S13, RADDR_S14, RADDR_S15, RADDR_S16, RADDR_S17, RADDR_S18, RADDR_S19, RADDR_S20, RADDR_S21, RADDR_S22;
reg [8:0] raddr1, raddr2, raddr3, raddr4, raddr5, raddr6, raddr7, raddr8, raddr9, raddr10, raddr11, raddr12, raddr13, raddr14, raddr15, raddr16, raddr17, raddr18, raddr19, raddr20, raddr21, raddr22;
wire [8:0] readaddr;
wire [5:0] whichRAM, prewhichRAM;
reg [4:0] whichRAM_d;
wire [7:0] RDATA_S01, RDATA_S02, RDATA_S03, RDATA_S04, RDATA_S05, RDATA_S06, RDATA_S07, RDATA_S08, RDATA_S09, RDATA_S10, RDATA_S11, RDATA_S12, RDATA_S13, RDATA_S14, RDATA_S15, RDATA_S16, RDATA_S17, RDATA_S18, RDATA_S19, RDATA_S20, RDATA_S21, RDATA_S22;
reg [6:0] WADDR_S;
wire [31:0] pack1,pack2,pack3,pack4,pack5,pack6,pack7,pack8,pack9,pack10,pack11,pack12,pack13,pack14,pack15,pack16,pack17,pack18,pack19,pack20,pack21,pack22;
wire WE_S;
integer i;*/
//wire [13:0] vecin1, vecin2, vecin3;
parameter S_idle = 0, S_init = 1, S_Vector1 = 2, S_Vector2u = 3, S_Vector3 = 4, S_Wait = 5, S_init_ext = 6, S_VectorExt1 = 7, S_VectorExt2 = 8, S_VectorExt3 = 9, S_VectorExt4 = 10, S_VectorExt5 = 11;
//*parameter Sub_Init = 0, Sub_Fill_UW = 1;
//*assign UWaddress_out = UW_count;

/*assign vecin1 = vectors0;
assign vecin2 = vectors1;
assign vecin3 = vectors2;
*/
assign high = 1'b1;
assign low = 1'b0;

//assign extended = 1'b0;
//assign medianMV = vectors[median];

always @*
begin
	case (median)
	0: medianMV = vectors0;
	1: medianMV = vectors1;
	2: medianMV = vectors2;
	3: medianMV = 0;
	endcase
end
//*assign WE_S = SW_WE;
//assign UWpos_x = (limited_out_x > 33) ? ((limited_out_x <= 36) ? 33 : ((limited_out_x < 95) ? 95 : limited_out_x)) : limited_out_x;
//assign UWpos_y = (limited_out_y > 33) ? ((limited_out_y <= 36) ? 33 : ((limited_out_y < 95) ? 95 : limited_out_y)) : limited_out_y;
//*assign UWpos_x = (neg_lim_out_x > 33) ? ((neg_lim_out_x <= 36) ? 33 : ((neg_lim_out_x < 95) ? 95 : neg_lim_out_x)) : neg_lim_out_x;
//*assign UWpos_y = (neg_lim_out_y > 33) ? ((neg_lim_out_y <= 36) ? 33 : ((neg_lim_out_y < 95) ? 95 : neg_lim_out_y)) : neg_lim_out_y;

assign done = (State == S_Wait && MV_ready) ? 1 : 0;

//*assign UWcheck_y = neg_lim_out_y - UWpos[13:7];
//*assign UWcheck_x = neg_lim_out_x - UWpos[6:0];
//*assign check_y = (UWcheck_y > 36) ? (~UWcheck_y + 1'b1) : (UWcheck_y);  
//*assign check_x = (UWcheck_x > 36) ? (~UWcheck_x + 1'b1) : (UWcheck_x);
//*assign inside = valid ? ((check_x <= 3 && check_y <= 3) ? 1'b1 : 1'b0) : 1'b0;



always @(posedge clk, posedge reset)
begin
	if (reset)
	begin
		median <= 0;
		underTh <= 0;
	end
	else
	begin
		median <= pre_median;
		underTh <= pre_underTh;
	end
end


/**always @*
begin
	if (inside)
	begin
		if (UWcheck_y > 36)
			UW_ROW = check_y + 3;
		else
			//UW_ROW = UWcheck_y;
			UW_ROW = check_y;
		if (UWcheck_x > 36)
			UW_COL = check_x + 3;
		else
			//UW_COL = UWcheck_x;
			UW_COL = check_x;
	end
	else
	begin
		UW_ROW = 0;
		UW_COL = 0;
	end

end*/

assign limited_out_x = (out[6:0] > 36) ? ((out[6:0] < 40) ? 36 : ((out[6:0] < (~7'd36 + 1'b1)) ? (~7'd36 + 1'b1) : out[6:0])) : out[6:0];
assign limited_out_y = (out[13:7] > 36) ? ((out[13:7] < 40) ? 36 : ((out[13:7] < (~7'd36 + 1'b1)) ? (~7'd36 + 1'b1) : out[13:7])) : out[13:7]; 
//*assign neg_lim_out_x = (~limited_out_x+1'b1);
//*assign neg_lim_out_y = (~limited_out_y+1'b1);

/**assign premodSWcoord_y = SWcoord_y_reg + UWaddress;
assign premodSWcoord_x = SWcoord_x_reg + UWaddress;
assign modSWcoord_y = (premodSWcoord_y < 88) ? premodSWcoord_y : premodSWcoord_y - 88;
assign modSWcoord_x = (premodSWcoord_x < 88) ? premodSWcoord_x : premodSWcoord_x - 88;

assign preSWcoord_x = {{1 {UWpos_x[6]}},UWpos_x} + 33 + SWshift;
assign preSWcoord_y = {{1 {UWpos_y[6]}},UWpos_y} + 33;
assign SWcoord_x = (preSWcoord_x <88) ? preSWcoord_x : preSWcoord_x - 88;
assign SWcoord_y = (preSWcoord_y <88) ? preSWcoord_y : preSWcoord_y - 88;
assign prewhichRAM = SWcoord_mod_x + SWcoord_mod_y + UWaddress;
assign whichRAM = (prewhichRAM < 22) ? prewhichRAM : ((prewhichRAM < 44) ? prewhichRAM - 22 : prewhichRAM - 44);*/
//assign addrrow = modSWcoord_y << 2;
//assign readaddr = addrrow + mod_x;

/**assign addrcol = modSWcoord_x << 2;
assign readaddr = addrcol + mod_y;
always @(posedge clk, posedge reset)
begin
	if (reset)
	begin
		SWcoord_x_reg <= 0;
		SWcoord_y_reg <= 0;
		neg_lim_out_y_reg <= 0;
		neg_lim_out_x_reg <= 0;
		//inside <= 0;
		valid_d <= 0;
		check_x_d <= 0;
		check_y_d <= 0;
	end
	else
	begin
		SWcoord_x_reg <= SWcoord_x;
		SWcoord_y_reg <= SWcoord_y;
		neg_lim_out_x_reg <= neg_lim_out_x;
		neg_lim_out_y_reg <= neg_lim_out_y;
		//inside <= pre_inside;
		valid_d <= valid;
		check_x_d <= check_x;
		check_y_d <= check_y;
	end
end*/

always @(posedge clk, posedge reset)
begin
    if (reset)
    outMV <= 14'b0;
    else if (enable)
    outMV <= {limited_out_y,limited_out_x};
    
end


always @(posedge clk, posedge reset)
begin
    if (reset)
    State <= S_idle;
    else
    begin
        case(State)
			S_idle:
				if(enable)
					State <= S_init;
			S_init: //buna gerek var mi ?
				if(feedcount == 4)
					State <= S_Vector1;
			S_Vector1:
				if (inside)
					State <= S_Vector2u;
			S_Vector2u:
				if (inside)
					if (underTh)
						State <= S_Wait;
					else
						State <= S_Vector3;
			S_Vector3:
				if (inside)
					State <= S_Wait;
			S_init_ext:
				if (feedcount == 5)
					State <= S_VectorExt1;
			S_VectorExt1:
				if (inside)
					State <= S_VectorExt2;
			S_VectorExt2:
				if (inside)
					State <= S_VectorExt3;
			S_VectorExt3:
				if (inside)
					State <= S_VectorExt4;
			S_VectorExt4:
				if (inside)
					State <= S_VectorExt5;
			S_VectorExt5:
				if (inside)
					State <= S_Wait;
			S_Wait:
				if (goextended)
					State <= S_init_ext;
				else if (MV_ready)
					State <= S_idle;
			default: State <= S_idle;
		endcase
    end
end

assign MVwait = (State == S_Wait) ? 1 : 0;
assign feed = ((State == S_init) || (State == S_init_ext)) ? 1 : 0;

always @(posedge clk, posedge reset)
begin
	if(reset)
		extended <= 0;
	else if (goextended)
		extended <= 1;
	else if (State == S_idle)
		extended <= 0;
end

always @ (posedge clk, posedge reset)
begin
	if (reset)
		feedcount <= 0;
	else if (feed)
		feedcount <= feedcount + 1;
	else
		feedcount <= 0;
end

always @ (posedge clk, posedge reset)
begin
	if (reset)
	begin
		vectors0 <= 14'b0;
		vectors1 <= 14'b0;
		vectors2 <= 14'b0;
		vectors3 <= 14'b0;
	end
	else
	begin
		case(feedcount)
		1: vectors0 <= vecin;
		2: vectors1 <= vecin;
		3: vectors2 <= vecin;
		4: vectors3 <= vecin;
		endcase
	end
end


/**
always@(posedge clk, posedge reset)
begin
	if (reset)
		SWshift <= 72;
	else if (Row_end)
		SWshift <= 72;
	else if (feedcount == 3)
	begin
		SWshift <= (SWshift > 71) ? SWshift - 72 : SWshift + 16;
	end
end*/


/**always @ (posedge clk, posedge reset)
begin
	if (reset)
	begin
		valid <= 0;
		UWpos <= 0;
	end
	else if (State == S_Wait)
		valid <= 0;
	else if (UW_Filled)
	begin
		valid <= 1'b1;
		UWpos <= {UWpos_y,UWpos_x};
	end
end*/



always @(*)
begin
    case(State)
        S_Vector1:
           out = medianMV;
        S_Vector2u:
        begin
           if (underTh)
              out = {medianMV[13:7]+{{4 {updatein[5]}},updatein[5:3]},medianMV[6:0] + {{4 {updatein[2]}},updatein[2:0]}};
           else   
              out = (median == 1) ? {vectors0[13:7]+{{4 {updatein[5]}},updatein[5:3]},vectors0[6:0] + {{4 {updatein[2]}},updatein[2:0]}} : {vectors1[13:7]+{{4 {updatein[5]}},updatein[5:3]},vectors1[6:0] + {{4 {updatein[2]}},updatein[2:0]}};
        end
        S_Vector3:
           out = (median == 2) ? vectors0 : vectors2;
		
		S_VectorExt1:
			out = vectors0;
		S_VectorExt2:
			out = vectors1;
		S_VectorExt3:
			out = vectors2;
		S_VectorExt4:
			out = {vectors3[13:7]+{{4 {updatein[5]}},updatein[5:3]},vectors3[6:0] + {{4 {updatein[2]}},updatein[2:0]}};
		S_VectorExt5:
			out = 14'b0;
        default:
           out = 14'b0;
    endcase
end

/*always @*
begin
    if (State == S_Vector1 || State == S_Vector2u || State == S_Vector3)
       FillSW = 1'b1;
    else
       FillSW = 1'b0;
end*/



/**always @(posedge clk, posedge reset)
begin
	if (reset)
	SubState <= Sub_Init; 
	else
	case (SubState)
	Sub_Init:
		if (State == S_Vector1 || State == S_Vector2u || State == S_Vector3)
		begin
			if (!inside)
				SubState <= Sub_Fill_UW;
		end
	Sub_Fill_UW:
		if (UW_Filled)
			SubState <= Sub_Init;
	default: SubState <= Sub_Init;
	endcase
	
end*/

always @(posedge clk, posedge reset)
begin
if (reset)
begin
	inside <=0;
	//SW_WE <= 0;
end
else
begin
	inside <= SBFilled;
	//SW_WE <= SW_WE_req;
end
end
always @*
begin
	if ((State == S_Vector1 || State == S_Vector2u || State == S_Vector3 || State == S_VectorExt1 || State == S_VectorExt2 || State == S_VectorExt3 || State == S_VectorExt4 || State == S_VectorExt5) && inside)
		MVselect_WE = 1;
	else
		MVselect_WE = 0;
end

always @(posedge clk, posedge reset)
begin
	if (reset)
		SW_WE_req <= 0;
		
	else if ((State == S_Vector1 || State == S_Vector2u || State == S_Vector3 || State == S_VectorExt1 || State == S_VectorExt2 || State == S_VectorExt3 || State == S_VectorExt4 || State == S_VectorExt5) && !inside)
		SW_WE_req <= 1;
	else
		SW_WE_req <= 0;
end

/**always @(posedge clk, posedge reset)
begin
	if (reset)
	begin
		SubState_d <= 0;
		whichRAM_d <= 0;
	end
	else
	begin
		SubState_d <= SubState;
		whichRAM_d <= whichRAM;
	end
end

always @(posedge clk, posedge reset)
begin
if (reset)
	UW_count <= 0;
else if (SubState_d == Sub_Fill_UW)
	UW_count <= UW_count + 1;
else
	UW_count <= 0;

end*/

/**always @(*)
begin
if (SubState_d == Sub_Fill_UW)
begin
	UW_WE = 1;
end
else
	UW_WE = 0;
end*/




/**always@*
begin
   for (i = 0; i < 88; i = i+1)
      packedInput[i] = InputDATA[i*8 +: 8];
end


assign pack1 ={packedInput[0],packedInput[22],packedInput[44],packedInput[66]};
assign pack2 ={packedInput[1],packedInput[23],packedInput[45],packedInput[67]};
assign pack3 ={packedInput[2],packedInput[24],packedInput[46],packedInput[68]};
assign pack4 ={packedInput[3],packedInput[25],packedInput[47],packedInput[69]};
assign pack5 ={packedInput[4],packedInput[26],packedInput[48],packedInput[70]};
assign pack6 ={packedInput[5],packedInput[27],packedInput[49],packedInput[71]};
assign pack7 ={packedInput[6],packedInput[28],packedInput[50],packedInput[72]};
assign pack8 ={packedInput[7],packedInput[29],packedInput[51],packedInput[73]};
assign pack9 ={packedInput[8],packedInput[30],packedInput[52],packedInput[74]};
assign pack10 ={packedInput[9],packedInput[31],packedInput[53],packedInput[75]};
assign pack11 ={packedInput[10],packedInput[32],packedInput[54],packedInput[76]};
assign pack12 ={packedInput[11],packedInput[33],packedInput[55],packedInput[77]};
assign pack13 ={packedInput[12],packedInput[34],packedInput[56],packedInput[78]};
assign pack14 ={packedInput[13],packedInput[35],packedInput[57],packedInput[79]};
assign pack15 ={packedInput[14],packedInput[36],packedInput[58],packedInput[80]};
assign pack16 ={packedInput[15],packedInput[37],packedInput[59],packedInput[81]};
assign pack17 ={packedInput[16],packedInput[38],packedInput[60],packedInput[82]};
assign pack18 ={packedInput[17],packedInput[39],packedInput[61],packedInput[83]};
assign pack19 ={packedInput[18],packedInput[40],packedInput[62],packedInput[84]};
assign pack20 ={packedInput[19],packedInput[41],packedInput[63],packedInput[85]};
assign pack21 ={packedInput[20],packedInput[42],packedInput[64],packedInput[86]};
assign pack22 ={packedInput[21],packedInput[43],packedInput[65],packedInput[87]};


always @(posedge clk, posedge reset)
begin
	if (reset)
	begin
		order <= 1;
		WADDR_S <= 0;
	end
	else if (frame_end)
	begin
		order <= 1;
		WADDR_S <= 0;
	end
	else if (Row_end)
	begin
		order <= 0;
		WADDR_S <= 127;
	end
	else if (SW_WE)
	begin
		if(WADDR_S != 87)
		begin
			if (order != 22)
				order <= order + 1;
			else
				order <= 1; 
			WADDR_S <=WADDR_S +1;
		end
		else
		begin
			order <= 1;
			WADDR_S <= 0;
		end
       
  */     
       
       /*if (order != 22 || WADDR_S != 87)
          order <= order + 1;
       else
          order <= 1;
       if (WADDR_S != 87)
          WADDR_S <= WADDR_S + 1;
       else
          WADDR_S <= 0;*/
/**   end
end

always @(posedge clk, posedge reset)
begin
    if (reset)
		UWaddress <= 0;
	else if (SubState == Sub_Fill_UW)
	begin
		UWaddress <= UWaddress + 1;
	end
	else
		UWaddress <= 0;
end




always @*
begin
	if (SWcoord_x_reg <22)
	begin
		mod_x = 0;
		SWcoord_mod_x = SWcoord_x_reg;
	end
	else if (SWcoord_x_reg < 44)
	begin
		mod_x = 1;
		SWcoord_mod_x = SWcoord_x_reg - 22;
	end
	else if (SWcoord_x_reg < 66)
	begin	
		mod_x = 2;
		SWcoord_mod_x = SWcoord_x_reg - 44;
	end
	else
	begin
		mod_x = 3;
		SWcoord_mod_x = SWcoord_x_reg - 66; //buna direk = 0 diyebilriz çünkü 66dan yukarı çıkamıyor sanırım
	end
		
end

always @*
begin
	if (SWcoord_y_reg <22)
	begin
		mod_y = 0;
		SWcoord_mod_y = SWcoord_y_reg;
	end
	else if (SWcoord_y_reg < 44)
	begin
		mod_y = 1;
		SWcoord_mod_y = SWcoord_y_reg - 22;
	end
	else if (SWcoord_y_reg < 66)
	begin	
		mod_y = 2;
		SWcoord_mod_y = SWcoord_y_reg - 44;
	end
	else
	begin
		mod_y = 3;
		SWcoord_mod_y = SWcoord_y_reg - 66; //buna direk = 0 diyebilriz çünkü 66dan yukarı çıkamıyor sanırım
	end
		
end




always @*
begin
	case(SWcoord_mod_y)
		0:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr;
			raddr18 = readaddr;
			raddr19 = readaddr;
			raddr20 = readaddr;
			raddr21 = readaddr;
			raddr22 = readaddr;
		end
		1:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr;
			raddr18 = readaddr;
			raddr19 = readaddr;
			raddr20 = readaddr;
			raddr21 = readaddr;
			raddr22 = readaddr + 1;
		end
		2:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr;
			raddr18 = readaddr;
			raddr19 = readaddr;
			raddr20 = readaddr;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		3:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr;
			raddr18 = readaddr;
			raddr19 = readaddr;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		4:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr;
			raddr18 = readaddr;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		5:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		6:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		7:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		8:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		9:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		10:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		11:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		12:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		13:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		14:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		15:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr +1;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		16:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr + 1;
			raddr8 = readaddr + 1;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		17:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr + 1;
			raddr7 = readaddr + 1;
			raddr8 = readaddr + 1;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		18:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr + 1;
			raddr6 = readaddr + 1;
			raddr7 = readaddr + 1;
			raddr8 = readaddr + 1;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		19:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr + 1;
			raddr5 = readaddr + 1;
			raddr6 = readaddr + 1;
			raddr7 = readaddr + 1;
			raddr8 = readaddr + 1;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		20:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr + 1;
			raddr4 = readaddr + 1;
			raddr5 = readaddr + 1;
			raddr6 = readaddr + 1;
			raddr7 = readaddr + 1;
			raddr8 = readaddr + 1;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		21:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr + 1;
			raddr3 = readaddr + 1;
			raddr4 = readaddr + 1;
			raddr5 = readaddr + 1;
			raddr6 = readaddr + 1;
			raddr7 = readaddr + 1;
			raddr8 = readaddr + 1;
			raddr9 = readaddr + 1;
			raddr10 = readaddr + 1;
			raddr11 = readaddr + 1;
			raddr12 = readaddr + 1;
			raddr13 = readaddr + 1;
			raddr14 = readaddr + 1;
			raddr15 = readaddr + 1;
			raddr16 = readaddr + 1;
			raddr17 = readaddr + 1;
			raddr18 = readaddr + 1;
			raddr19 = readaddr + 1;
			raddr20 = readaddr + 1;
			raddr21 = readaddr + 1;
			raddr22 = readaddr + 1;
		end
		default:
		begin
			raddr1 = readaddr;
			raddr2 = readaddr;
			raddr3 = readaddr;
			raddr4 = readaddr;
			raddr5 = readaddr;
			raddr6 = readaddr;
			raddr7 = readaddr;
			raddr8 = readaddr;
			raddr9 = readaddr;
			raddr10 = readaddr;
			raddr11 = readaddr;
			raddr12 = readaddr;
			raddr13 = readaddr;
			raddr14 = readaddr;
			raddr15 = readaddr;
			raddr16 = readaddr;
			raddr17 = readaddr;
			raddr18 = readaddr;
			raddr19 = readaddr;
			raddr20 = readaddr;
			raddr21 = readaddr;
			raddr22 = readaddr;
		end
		
	endcase
end

always @*
begin
	case(whichRAM_d)
	0: UWDATA_Out = {RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,
						RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22};
	1: UWDATA_Out = {RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,
						RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01};
	2: UWDATA_Out = {RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,
						RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02};
	3: UWDATA_Out = {RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,
						RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03};
	4: UWDATA_Out = {RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,
						RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04};
	5: UWDATA_Out = {RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,
						RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05};
	6: UWDATA_Out = {RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,
						RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06};
	7: UWDATA_Out = {RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,
						RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07};
	8: UWDATA_Out = {RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,
						RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08};
	9: UWDATA_Out = {RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,
						RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09};
	10: UWDATA_Out = {RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,
						RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10};
	11: UWDATA_Out = {RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,
						RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11};
	12: UWDATA_Out = {RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,
						RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12};
	13: UWDATA_Out = {RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,
						RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13};
	14: UWDATA_Out = {RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,
						RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14};
	15: UWDATA_Out = {RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,
						RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15};
	16: UWDATA_Out = {RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,
						RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16};
	17: UWDATA_Out = {RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,
						RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17};
	18: UWDATA_Out = {RDATA_S19,RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,
						RDATA_S08,RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18};
	19: UWDATA_Out = {RDATA_S20,RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,
						RDATA_S09,RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19};
	20: UWDATA_Out = {RDATA_S21,RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,
						RDATA_S10,RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20};
	21: UWDATA_Out = {RDATA_S22,RDATA_S01,RDATA_S02,RDATA_S03,RDATA_S04,RDATA_S05,RDATA_S06,RDATA_S07,RDATA_S08,RDATA_S09,RDATA_S10,
						RDATA_S11,RDATA_S12,RDATA_S13,RDATA_S14,RDATA_S15,RDATA_S16,RDATA_S17,RDATA_S18,RDATA_S19,RDATA_S20,RDATA_S21};
	default: UWDATA_Out = 0;
	endcase
end

always @*
begin
	case(whichRAM)
	0:
	begin
		RADDR_S01 = raddr1;
		RADDR_S02 = raddr2;
		RADDR_S03 = raddr3;
		RADDR_S04 = raddr4;
		RADDR_S05 = raddr5;
		RADDR_S06 = raddr6;
		RADDR_S07 = raddr7;
		RADDR_S08 = raddr8;
		RADDR_S09 = raddr9;
		RADDR_S10 = raddr10;
		RADDR_S11 = raddr11;
		RADDR_S12 = raddr12;
		RADDR_S13 = raddr13;
		RADDR_S14 = raddr14;
		RADDR_S15 = raddr15;
		RADDR_S16 = raddr16;
		RADDR_S17 = raddr17;
		RADDR_S18 = raddr18;
		RADDR_S19 = raddr19;
		RADDR_S20 = raddr20;
		RADDR_S21 = raddr21;
		RADDR_S22 = raddr22;
		
	end
	1:
	begin
		RADDR_S01 = raddr22;
		RADDR_S02 = raddr1;
		RADDR_S03 = raddr2;
		RADDR_S04 = raddr3;
		RADDR_S05 = raddr4;
		RADDR_S06 = raddr5;
		RADDR_S07 = raddr6;
		RADDR_S08 = raddr7;
		RADDR_S09 = raddr8;
		RADDR_S10 = raddr9;
		RADDR_S11 = raddr10;
		RADDR_S12 = raddr11;
		RADDR_S13 = raddr12;
		RADDR_S14 = raddr13;
		RADDR_S15 = raddr14;
		RADDR_S16 = raddr15;
		RADDR_S17 = raddr16;
		RADDR_S18 = raddr17;
		RADDR_S19 = raddr18;
		RADDR_S20 = raddr19;
		RADDR_S21 = raddr20;
		RADDR_S22 = raddr21;
		
	end
	2:
	begin
		RADDR_S01 = raddr21;
		RADDR_S02 = raddr22;
		RADDR_S03 = raddr1;
		RADDR_S04 = raddr2;
		RADDR_S05 = raddr3;
		RADDR_S06 = raddr4;
		RADDR_S07 = raddr5;
		RADDR_S08 = raddr6;
		RADDR_S09 = raddr7;
		RADDR_S10 = raddr8;
		RADDR_S11 = raddr9;
		RADDR_S12 = raddr10;
		RADDR_S13 = raddr11;
		RADDR_S14 = raddr12;
		RADDR_S15 = raddr13;
		RADDR_S16 = raddr14;
		RADDR_S17 = raddr15;
		RADDR_S18 = raddr16;
		RADDR_S19 = raddr17;
		RADDR_S20 = raddr18;
		RADDR_S21 = raddr19;
		RADDR_S22 = raddr20;
		
	end
	3:
	begin
		RADDR_S01 = raddr20;
		RADDR_S02 = raddr21;
		RADDR_S03 = raddr22;
		RADDR_S04 = raddr1;
		RADDR_S05 = raddr2;
		RADDR_S06 = raddr3;
		RADDR_S07 = raddr4;
		RADDR_S08 = raddr5;
		RADDR_S09 = raddr6;
		RADDR_S10 = raddr7;
		RADDR_S11 = raddr8;
		RADDR_S12 = raddr9;
		RADDR_S13 = raddr10;
		RADDR_S14 = raddr11;
		RADDR_S15 = raddr12;
		RADDR_S16 = raddr13;
		RADDR_S17 = raddr14;
		RADDR_S18 = raddr15;
		RADDR_S19 = raddr16;
		RADDR_S20 = raddr17;
		RADDR_S21 = raddr18;
		RADDR_S22 = raddr19;
		
	end
	4:
	begin
		RADDR_S01 = raddr19;
		RADDR_S02 = raddr20;
		RADDR_S03 = raddr21;
		RADDR_S04 = raddr22;
		RADDR_S05 = raddr1;
		RADDR_S06 = raddr2;
		RADDR_S07 = raddr3;
		RADDR_S08 = raddr4;
		RADDR_S09 = raddr5;
		RADDR_S10 = raddr6;
		RADDR_S11 = raddr7;
		RADDR_S12 = raddr8;
		RADDR_S13 = raddr9;
		RADDR_S14 = raddr10;
		RADDR_S15 = raddr11;
		RADDR_S16 = raddr12;
		RADDR_S17 = raddr13;
		RADDR_S18 = raddr14;
		RADDR_S19 = raddr15;
		RADDR_S20 = raddr16;
		RADDR_S21 = raddr17;
		RADDR_S22 = raddr18;
		
	end
	5:
	begin
		RADDR_S01 = raddr18;
		RADDR_S02 = raddr19;
		RADDR_S03 = raddr20;
		RADDR_S04 = raddr21;
		RADDR_S05 = raddr22;
		RADDR_S06 = raddr1;
		RADDR_S07 = raddr2;
		RADDR_S08 = raddr3;
		RADDR_S09 = raddr4;
		RADDR_S10 = raddr5;
		RADDR_S11 = raddr6;
		RADDR_S12 = raddr7;
		RADDR_S13 = raddr8;
		RADDR_S14 = raddr9;
		RADDR_S15 = raddr10;
		RADDR_S16 = raddr11;
		RADDR_S17 = raddr12;
		RADDR_S18 = raddr13;
		RADDR_S19 = raddr14;
		RADDR_S20 = raddr15;
		RADDR_S21 = raddr16;
		RADDR_S22 = raddr17;
		
	end
	6:
	begin
		RADDR_S01 = raddr17;
		RADDR_S02 = raddr18;
		RADDR_S03 = raddr19;
		RADDR_S04 = raddr20;
		RADDR_S05 = raddr21;
		RADDR_S06 = raddr22;
		RADDR_S07 = raddr1;
		RADDR_S08 = raddr2;
		RADDR_S09 = raddr3;
		RADDR_S10 = raddr4;
		RADDR_S11 = raddr5;
		RADDR_S12 = raddr6;
		RADDR_S13 = raddr7;
		RADDR_S14 = raddr8;
		RADDR_S15 = raddr9;
		RADDR_S16 = raddr10;
		RADDR_S17 = raddr11;
		RADDR_S18 = raddr12;
		RADDR_S19 = raddr13;
		RADDR_S20 = raddr14;
		RADDR_S21 = raddr15;
		RADDR_S22 = raddr16;
		
	end
	7:
	begin
		RADDR_S01 = raddr16;
		RADDR_S02 = raddr17;
		RADDR_S03 = raddr18;
		RADDR_S04 = raddr19;
		RADDR_S05 = raddr20;
		RADDR_S06 = raddr21;
		RADDR_S07 = raddr22;
		RADDR_S08 = raddr1;
		RADDR_S09 = raddr2;
		RADDR_S10 = raddr3;
		RADDR_S11 = raddr4;
		RADDR_S12 = raddr5;
		RADDR_S13 = raddr6;
		RADDR_S14 = raddr7;
		RADDR_S15 = raddr8;
		RADDR_S16 = raddr9;
		RADDR_S17 = raddr10;
		RADDR_S18 = raddr11;
		RADDR_S19 = raddr12;
		RADDR_S20 = raddr13;
		RADDR_S21 = raddr14;
		RADDR_S22 = raddr15;
		
	end
	8:
	begin
		RADDR_S01 = raddr15;
		RADDR_S02 = raddr16;
		RADDR_S03 = raddr17;
		RADDR_S04 = raddr18;
		RADDR_S05 = raddr19;
		RADDR_S06 = raddr20;
		RADDR_S07 = raddr21;
		RADDR_S08 = raddr22;
		RADDR_S09 = raddr1;
		RADDR_S10 = raddr2;
		RADDR_S11 = raddr3;
		RADDR_S12 = raddr4;
		RADDR_S13 = raddr5;
		RADDR_S14 = raddr6;
		RADDR_S15 = raddr7;
		RADDR_S16 = raddr8;
		RADDR_S17 = raddr9;
		RADDR_S18 = raddr10;
		RADDR_S19 = raddr11;
		RADDR_S20 = raddr12;
		RADDR_S21 = raddr13;
		RADDR_S22 = raddr14;
		
	end
	9:
	begin
		RADDR_S01 = raddr14;
		RADDR_S02 = raddr15;
		RADDR_S03 = raddr16;
		RADDR_S04 = raddr17;
		RADDR_S05 = raddr18;
		RADDR_S06 = raddr19;
		RADDR_S07 = raddr20;
		RADDR_S08 = raddr21;
		RADDR_S09 = raddr22;
		RADDR_S10 = raddr1;
		RADDR_S11 = raddr2;
		RADDR_S12 = raddr3;
		RADDR_S13 = raddr4;
		RADDR_S14 = raddr5;
		RADDR_S15 = raddr6;
		RADDR_S16 = raddr7;
		RADDR_S17 = raddr8;
		RADDR_S18 = raddr9;
		RADDR_S19 = raddr10;
		RADDR_S20 = raddr11;
		RADDR_S21 = raddr12;
		RADDR_S22 = raddr13;
		
	end
	10:
	begin
		RADDR_S01 = raddr13;
		RADDR_S02 = raddr14;
		RADDR_S03 = raddr15;
		RADDR_S04 = raddr16;
		RADDR_S05 = raddr17;
		RADDR_S06 = raddr18;
		RADDR_S07 = raddr19;
		RADDR_S08 = raddr20;
		RADDR_S09 = raddr21;
		RADDR_S10 = raddr22;
		RADDR_S11 = raddr1;
		RADDR_S12 = raddr2;
		RADDR_S13 = raddr3;
		RADDR_S14 = raddr4;
		RADDR_S15 = raddr5;
		RADDR_S16 = raddr6;
		RADDR_S17 = raddr7;
		RADDR_S18 = raddr8;
		RADDR_S19 = raddr9;
		RADDR_S20 = raddr10;
		RADDR_S21 = raddr11;
		RADDR_S22 = raddr12;
		
	end
	11:
	begin
		RADDR_S01 = raddr12;
		RADDR_S02 = raddr13;
		RADDR_S03 = raddr14;
		RADDR_S04 = raddr15;
		RADDR_S05 = raddr16;
		RADDR_S06 = raddr17;
		RADDR_S07 = raddr18;
		RADDR_S08 = raddr19;
		RADDR_S09 = raddr20;
		RADDR_S10 = raddr21;
		RADDR_S11 = raddr22;
		RADDR_S12 = raddr1;
		RADDR_S13 = raddr2;
		RADDR_S14 = raddr3;
		RADDR_S15 = raddr4;
		RADDR_S16 = raddr5;
		RADDR_S17 = raddr6;
		RADDR_S18 = raddr7;
		RADDR_S19 = raddr8;
		RADDR_S20 = raddr9;
		RADDR_S21 = raddr10;
		RADDR_S22 = raddr11;
		
	end
	12:
	begin
		RADDR_S01 = raddr11;
		RADDR_S02 = raddr12;
		RADDR_S03 = raddr13;
		RADDR_S04 = raddr14;
		RADDR_S05 = raddr15;
		RADDR_S06 = raddr16;
		RADDR_S07 = raddr17;
		RADDR_S08 = raddr18;
		RADDR_S09 = raddr19;
		RADDR_S10 = raddr20;
		RADDR_S11 = raddr21;
		RADDR_S12 = raddr22;
		RADDR_S13 = raddr1;
		RADDR_S14 = raddr2;
		RADDR_S15 = raddr3;
		RADDR_S16 = raddr4;
		RADDR_S17 = raddr5;
		RADDR_S18 = raddr6;
		RADDR_S19 = raddr7;
		RADDR_S20 = raddr8;
		RADDR_S21 = raddr9;
		RADDR_S22 = raddr10;
		
	end
	13:
	begin
		RADDR_S01 = raddr10;
		RADDR_S02 = raddr11;
		RADDR_S03 = raddr12;
		RADDR_S04 = raddr13;
		RADDR_S05 = raddr14;
		RADDR_S06 = raddr15;
		RADDR_S07 = raddr16;
		RADDR_S08 = raddr17;
		RADDR_S09 = raddr18;
		RADDR_S10 = raddr19;
		RADDR_S11 = raddr20;
		RADDR_S12 = raddr21;
		RADDR_S13 = raddr22;
		RADDR_S14 = raddr1;
		RADDR_S15 = raddr2;
		RADDR_S16 = raddr3;
		RADDR_S17 = raddr4;
		RADDR_S18 = raddr5;
		RADDR_S19 = raddr6;
		RADDR_S20 = raddr7;
		RADDR_S21 = raddr8;
		RADDR_S22 = raddr9;
		
	end
	14:
	begin
		RADDR_S01 = raddr9;
		RADDR_S02 = raddr10;
		RADDR_S03 = raddr11;
		RADDR_S04 = raddr12;
		RADDR_S05 = raddr13;
		RADDR_S06 = raddr14;
		RADDR_S07 = raddr15;
		RADDR_S08 = raddr16;
		RADDR_S09 = raddr17;
		RADDR_S10 = raddr18;
		RADDR_S11 = raddr19;
		RADDR_S12 = raddr20;
		RADDR_S13 = raddr21;
		RADDR_S14 = raddr22;
		RADDR_S15 = raddr1;
		RADDR_S16 = raddr2;
		RADDR_S17 = raddr3;
		RADDR_S18 = raddr4;
		RADDR_S19 = raddr5;
		RADDR_S20 = raddr6;
		RADDR_S21 = raddr7;
		RADDR_S22 = raddr8;
		
	end
	15:
	begin
		RADDR_S01 = raddr8;
		RADDR_S02 = raddr9;
		RADDR_S03 = raddr10;
		RADDR_S04 = raddr11;
		RADDR_S05 = raddr12;
		RADDR_S06 = raddr13;
		RADDR_S07 = raddr14;
		RADDR_S08 = raddr15;
		RADDR_S09 = raddr16;
		RADDR_S10 = raddr17;
		RADDR_S11 = raddr18;
		RADDR_S12 = raddr19;
		RADDR_S13 = raddr20;
		RADDR_S14 = raddr21;
		RADDR_S15 = raddr22;
		RADDR_S16 = raddr1;
		RADDR_S17 = raddr2;
		RADDR_S18 = raddr3;
		RADDR_S19 = raddr4;
		RADDR_S20 = raddr5;
		RADDR_S21 = raddr6;
		RADDR_S22 = raddr7;
		
	end
	16:
	begin
		RADDR_S01 = raddr7;
		RADDR_S02 = raddr8;
		RADDR_S03 = raddr9;
		RADDR_S04 = raddr10;
		RADDR_S05 = raddr11;
		RADDR_S06 = raddr12;
		RADDR_S07 = raddr13;
		RADDR_S08 = raddr14;
		RADDR_S09 = raddr15;
		RADDR_S10 = raddr16;
		RADDR_S11 = raddr17;
		RADDR_S12 = raddr18;
		RADDR_S13 = raddr19;
		RADDR_S14 = raddr20;
		RADDR_S15 = raddr21;
		RADDR_S16 = raddr22;
		RADDR_S17 = raddr1;
		RADDR_S18 = raddr2;
		RADDR_S19 = raddr3;
		RADDR_S20 = raddr4;
		RADDR_S21 = raddr5;
		RADDR_S22 = raddr6;
		
	end
	17:
	begin
		RADDR_S01 = raddr6;
		RADDR_S02 = raddr7;
		RADDR_S03 = raddr8;
		RADDR_S04 = raddr9;
		RADDR_S05 = raddr10;
		RADDR_S06 = raddr11;
		RADDR_S07 = raddr12;
		RADDR_S08 = raddr13;
		RADDR_S09 = raddr14;
		RADDR_S10 = raddr15;
		RADDR_S11 = raddr16;
		RADDR_S12 = raddr17;
		RADDR_S13 = raddr18;
		RADDR_S14 = raddr19;
		RADDR_S15 = raddr20;
		RADDR_S16 = raddr21;
		RADDR_S17 = raddr22;
		RADDR_S18 = raddr1;
		RADDR_S19 = raddr2;
		RADDR_S20 = raddr3;
		RADDR_S21 = raddr4;
		RADDR_S22 = raddr5;
		
	end
	18:
	begin
		RADDR_S01 = raddr5;
		RADDR_S02 = raddr6;
		RADDR_S03 = raddr7;
		RADDR_S04 = raddr8;
		RADDR_S05 = raddr9;
		RADDR_S06 = raddr10;
		RADDR_S07 = raddr11;
		RADDR_S08 = raddr12;
		RADDR_S09 = raddr13;
		RADDR_S10 = raddr14;
		RADDR_S11 = raddr15;
		RADDR_S12 = raddr16;
		RADDR_S13 = raddr17;
		RADDR_S14 = raddr18;
		RADDR_S15 = raddr19;
		RADDR_S16 = raddr20;
		RADDR_S17 = raddr21;
		RADDR_S18 = raddr22;
		RADDR_S19 = raddr1;
		RADDR_S20 = raddr2;
		RADDR_S21 = raddr3;
		RADDR_S22 = raddr4;
		
	end
	19:
	begin
		RADDR_S01 = raddr4;
		RADDR_S02 = raddr5;
		RADDR_S03 = raddr6;
		RADDR_S04 = raddr7;
		RADDR_S05 = raddr8;
		RADDR_S06 = raddr9;
		RADDR_S07 = raddr10;
		RADDR_S08 = raddr11;
		RADDR_S09 = raddr12;
		RADDR_S10 = raddr13;
		RADDR_S11 = raddr14;
		RADDR_S12 = raddr15;
		RADDR_S13 = raddr16;
		RADDR_S14 = raddr17;
		RADDR_S15 = raddr18;
		RADDR_S16 = raddr19;
		RADDR_S17 = raddr20;
		RADDR_S18 = raddr21;
		RADDR_S19 = raddr22;
		RADDR_S20 = raddr1;
		RADDR_S21 = raddr2;
		RADDR_S22 = raddr3;
		
	end
	20:
	begin
		RADDR_S01 = raddr3;
		RADDR_S02 = raddr4;
		RADDR_S03 = raddr5;
		RADDR_S04 = raddr6;
		RADDR_S05 = raddr7;
		RADDR_S06 = raddr8;
		RADDR_S07 = raddr9;
		RADDR_S08 = raddr10;
		RADDR_S09 = raddr11;
		RADDR_S10 = raddr12;
		RADDR_S11 = raddr13;
		RADDR_S12 = raddr14;
		RADDR_S13 = raddr15;
		RADDR_S14 = raddr16;
		RADDR_S15 = raddr17;
		RADDR_S16 = raddr18;
		RADDR_S17 = raddr19;
		RADDR_S18 = raddr20;
		RADDR_S19 = raddr21;
		RADDR_S20 = raddr22;
		RADDR_S21 = raddr1;
		RADDR_S22 = raddr2;
		
	end
	21:
	begin
		RADDR_S01 = raddr2;
		RADDR_S02 = raddr3;
		RADDR_S03 = raddr4;
		RADDR_S04 = raddr5;
		RADDR_S05 = raddr6;
		RADDR_S06 = raddr7;
		RADDR_S07 = raddr8;
		RADDR_S08 = raddr9;
		RADDR_S09 = raddr10;
		RADDR_S10 = raddr11;
		RADDR_S11 = raddr12;
		RADDR_S12 = raddr13;
		RADDR_S13 = raddr14;
		RADDR_S14 = raddr15;
		RADDR_S15 = raddr16;
		RADDR_S16 = raddr17;
		RADDR_S17 = raddr18;
		RADDR_S18 = raddr19;
		RADDR_S19 = raddr20;
		RADDR_S20 = raddr21;
		RADDR_S21 = raddr22;
		RADDR_S22 = raddr1;
		
	end
	default:
	begin
		RADDR_S01 = 0;
		RADDR_S02 = 0;
		RADDR_S03 = 0;
		RADDR_S04 = 0;
		RADDR_S05 = 0;
		RADDR_S06 = 0;
		RADDR_S07 = 0;
		RADDR_S08 = 0;
		RADDR_S09 = 0;
		RADDR_S10 = 0;
		RADDR_S11 = 0;
		RADDR_S12 = 0;
		RADDR_S13 = 0;
		RADDR_S14 = 0;
		RADDR_S15 = 0;
		RADDR_S16 = 0;
		RADDR_S17 = 0;
		RADDR_S18 = 0;
		RADDR_S19 = 0;
		RADDR_S20 = 0;
		RADDR_S21 = 0;
		RADDR_S22 = 0;
		
	end
	endcase
	
end

always @*
begin
case (order)
    1:
    begin
        WDATA_S01 = pack1;
        WDATA_S02 = pack2;
        WDATA_S03 = pack3;
        WDATA_S04 = pack4;
        WDATA_S05 = pack5;
        WDATA_S06 = pack6;
        WDATA_S07 = pack7;
        WDATA_S08 = pack8;
        WDATA_S09 = pack9;
        WDATA_S10 = pack10;
        WDATA_S11 = pack11;
        WDATA_S12 = pack12;
        WDATA_S13 = pack13;
        WDATA_S14 = pack14;
        WDATA_S15 = pack15;
        WDATA_S16 = pack16;
        WDATA_S17 = pack17;
        WDATA_S18 = pack18;
        WDATA_S19 = pack19;
        WDATA_S20 = pack20;
        WDATA_S21 = pack21;
        WDATA_S22 = pack22;       
    end
    2:
    begin
        WDATA_S02 = pack1;
        WDATA_S03 = pack2;
        WDATA_S04 = pack3;
        WDATA_S05 = pack4;
        WDATA_S06 = pack5;
        WDATA_S07 = pack6;
        WDATA_S08 = pack7;
        WDATA_S09 = pack8;
        WDATA_S10 = pack9;
        WDATA_S11 = pack10;
        WDATA_S12 = pack11;
        WDATA_S13 = pack12;
        WDATA_S14 = pack13;
        WDATA_S15 = pack14;
        WDATA_S16 = pack15;
        WDATA_S17 = pack16;
        WDATA_S18 = pack17;
        WDATA_S19 = pack18;
        WDATA_S20 = pack19;
        WDATA_S21 = pack20;
        WDATA_S22 = pack21;
        WDATA_S01 = pack22;       
    end
    3:
    begin
        WDATA_S03 = pack1;
        WDATA_S04 = pack2;
        WDATA_S05 = pack3;
        WDATA_S06 = pack4;
        WDATA_S07 = pack5;
        WDATA_S08 = pack6;
        WDATA_S09 = pack7;
        WDATA_S10 = pack8;
        WDATA_S11 = pack9;
        WDATA_S12 = pack10;
        WDATA_S13 = pack11;
        WDATA_S14 = pack12;
        WDATA_S15 = pack13;
        WDATA_S16 = pack14;
        WDATA_S17 = pack15;
        WDATA_S18 = pack16;
        WDATA_S19 = pack17;
        WDATA_S20 = pack18;
        WDATA_S21 = pack19;
        WDATA_S22 = pack20;
        WDATA_S01 = pack21;
        WDATA_S02 = pack22;       
    end
    4:
    begin
        WDATA_S04 = pack1;
        WDATA_S05 = pack2;
        WDATA_S06 = pack3;
        WDATA_S07 = pack4;
        WDATA_S08 = pack5;
        WDATA_S09 = pack6;
        WDATA_S10 = pack7;
        WDATA_S11 = pack8;
        WDATA_S12 = pack9;
        WDATA_S13 = pack10;
        WDATA_S14 = pack11;
        WDATA_S15 = pack12;
        WDATA_S16 = pack13;
        WDATA_S17 = pack14;
        WDATA_S18 = pack15;
        WDATA_S19 = pack16;
        WDATA_S20 = pack17;
        WDATA_S21 = pack18;
        WDATA_S22 = pack19;
        WDATA_S01 = pack20;
        WDATA_S02 = pack21;
        WDATA_S03 = pack22;       
    end
    5:
    begin
        WDATA_S05 = pack1;
        WDATA_S06 = pack2;
        WDATA_S07 = pack3;
        WDATA_S08 = pack4;
        WDATA_S09 = pack5;
        WDATA_S10 = pack6;
        WDATA_S11 = pack7;
        WDATA_S12 = pack8;
        WDATA_S13 = pack9;
        WDATA_S14 = pack10;
        WDATA_S15 = pack11;
        WDATA_S16 = pack12;
        WDATA_S17 = pack13;
        WDATA_S18 = pack14;
        WDATA_S19 = pack15;
        WDATA_S20 = pack16;
        WDATA_S21 = pack17;
        WDATA_S22 = pack18;
        WDATA_S01 = pack19;
        WDATA_S02 = pack20;
        WDATA_S03 = pack21;
        WDATA_S04 = pack22;       
    end
    6:
    begin
        WDATA_S06 = pack1;
        WDATA_S07 = pack2;
        WDATA_S08 = pack3;
        WDATA_S09 = pack4;
        WDATA_S10 = pack5;
        WDATA_S11 = pack6;
        WDATA_S12 = pack7;
        WDATA_S13 = pack8;
        WDATA_S14 = pack9;
        WDATA_S15 = pack10;
        WDATA_S16 = pack11;
        WDATA_S17 = pack12;
        WDATA_S18 = pack13;
        WDATA_S19 = pack14;
        WDATA_S20 = pack15;
        WDATA_S21 = pack16;
        WDATA_S22 = pack17;
        WDATA_S01 = pack18;
        WDATA_S02 = pack19;
        WDATA_S03 = pack20;
        WDATA_S04 = pack21;
        WDATA_S05 = pack22;       
    end
    7:
    begin
        WDATA_S07 = pack1;
        WDATA_S08 = pack2;
        WDATA_S09 = pack3;
        WDATA_S10 = pack4;
        WDATA_S11 = pack5;
        WDATA_S12 = pack6;
        WDATA_S13 = pack7;
        WDATA_S14 = pack8;
        WDATA_S15 = pack9;
        WDATA_S16 = pack10;
        WDATA_S17 = pack11;
        WDATA_S18 = pack12;
        WDATA_S19 = pack13;
        WDATA_S20 = pack14;
        WDATA_S21 = pack15;
        WDATA_S22 = pack16;
        WDATA_S01 = pack17;
        WDATA_S02 = pack18;
        WDATA_S03 = pack19;
        WDATA_S04 = pack20;
        WDATA_S05 = pack21;
        WDATA_S06 = pack22;       
    end
    8:
    begin
        WDATA_S08 = pack1;
        WDATA_S09 = pack2;
        WDATA_S10 = pack3;
        WDATA_S11 = pack4;
        WDATA_S12 = pack5;
        WDATA_S13 = pack6;
        WDATA_S14 = pack7;
        WDATA_S15 = pack8;
        WDATA_S16 = pack9;
        WDATA_S17 = pack10;
        WDATA_S18 = pack11;
        WDATA_S19 = pack12;
        WDATA_S20 = pack13;
        WDATA_S21 = pack14;
        WDATA_S22 = pack15;
        WDATA_S01 = pack16;
        WDATA_S02 = pack17;
        WDATA_S03 = pack18;
        WDATA_S04 = pack19;
        WDATA_S05 = pack20;
        WDATA_S06 = pack21;
        WDATA_S07 = pack22;       
    end
    9:
    begin
        WDATA_S09 = pack1;
        WDATA_S10 = pack2;
        WDATA_S11 = pack3;
        WDATA_S12 = pack4;
        WDATA_S13 = pack5;
        WDATA_S14 = pack6;
        WDATA_S15 = pack7;
        WDATA_S16 = pack8;
        WDATA_S17 = pack9;
        WDATA_S18 = pack10;
        WDATA_S19 = pack11;
        WDATA_S20 = pack12;
        WDATA_S21 = pack13;
        WDATA_S22 = pack14;
        WDATA_S01 = pack15;
        WDATA_S02 = pack16;
        WDATA_S03 = pack17;
        WDATA_S04 = pack18;
        WDATA_S05 = pack19;
        WDATA_S06 = pack20;
        WDATA_S07 = pack21;
        WDATA_S08 = pack22;       
    end
    10:
    begin
        WDATA_S10 = pack1;
        WDATA_S11 = pack2;
        WDATA_S12 = pack3;
        WDATA_S13 = pack4;
        WDATA_S14 = pack5;
        WDATA_S15 = pack6;
        WDATA_S16 = pack7;
        WDATA_S17 = pack8;
        WDATA_S18 = pack9;
        WDATA_S19 = pack10;
        WDATA_S20 = pack11;
        WDATA_S21 = pack12;
        WDATA_S22 = pack13;
        WDATA_S01 = pack14;
        WDATA_S02 = pack15;
        WDATA_S03 = pack16;
        WDATA_S04 = pack17;
        WDATA_S05 = pack18;
        WDATA_S06 = pack19;
        WDATA_S07 = pack20;
        WDATA_S08 = pack21;
        WDATA_S09 = pack22;       
    end
    11:
    begin
        WDATA_S11 = pack1;
        WDATA_S12 = pack2;
        WDATA_S13 = pack3;
        WDATA_S14 = pack4;
        WDATA_S15 = pack5;
        WDATA_S16 = pack6;
        WDATA_S17 = pack7;
        WDATA_S18 = pack8;
        WDATA_S19 = pack9;
        WDATA_S20 = pack10;
        WDATA_S21 = pack11;
        WDATA_S22 = pack12;
        WDATA_S01 = pack13;
        WDATA_S02 = pack14;
        WDATA_S03 = pack15;
        WDATA_S04 = pack16;
        WDATA_S05 = pack17;
        WDATA_S06 = pack18;
        WDATA_S07 = pack19;
        WDATA_S08 = pack20;
        WDATA_S09 = pack21;
        WDATA_S10 = pack22;       
    end
    12:
    begin
        WDATA_S12 = pack1;
        WDATA_S13 = pack2;
        WDATA_S14 = pack3;
        WDATA_S15 = pack4;
        WDATA_S16 = pack5;
        WDATA_S17 = pack6;
        WDATA_S18 = pack7;
        WDATA_S19 = pack8;
        WDATA_S20 = pack9;
        WDATA_S21 = pack10;
        WDATA_S22 = pack11;
        WDATA_S01 = pack12;
        WDATA_S02 = pack13;
        WDATA_S03 = pack14;
        WDATA_S04 = pack15;
        WDATA_S05 = pack16;
        WDATA_S06 = pack17;
        WDATA_S07 = pack18;
        WDATA_S08 = pack19;
        WDATA_S09 = pack20;
        WDATA_S10 = pack21;
        WDATA_S11 = pack22;       
    end
    13:
    begin
        WDATA_S13 = pack1;
        WDATA_S14 = pack2;
        WDATA_S15 = pack3;
        WDATA_S16 = pack4;
        WDATA_S17 = pack5;
        WDATA_S18 = pack6;
        WDATA_S19 = pack7;
        WDATA_S20 = pack8;
        WDATA_S21 = pack9;
        WDATA_S22 = pack10;
        WDATA_S01 = pack11;
        WDATA_S02 = pack12;
        WDATA_S03 = pack13;
        WDATA_S04 = pack14;
        WDATA_S05 = pack15;
        WDATA_S06 = pack16;
        WDATA_S07 = pack17;
        WDATA_S08 = pack18;
        WDATA_S09 = pack19;
        WDATA_S10 = pack20;
        WDATA_S11 = pack21;
        WDATA_S12 = pack22;       
    end
    14:
    begin
        WDATA_S14 = pack1;
        WDATA_S15 = pack2;
        WDATA_S16 = pack3;
        WDATA_S17 = pack4;
        WDATA_S18 = pack5;
        WDATA_S19 = pack6;
        WDATA_S20 = pack7;
        WDATA_S21 = pack8;
        WDATA_S22 = pack9;
        WDATA_S01 = pack10;
        WDATA_S02 = pack11;
        WDATA_S03 = pack12;
        WDATA_S04 = pack13;
        WDATA_S05 = pack14;
        WDATA_S06 = pack15;
        WDATA_S07 = pack16;
        WDATA_S08 = pack17;
        WDATA_S09 = pack18;
        WDATA_S10 = pack19;
        WDATA_S11 = pack20;
        WDATA_S12 = pack21;
        WDATA_S13 = pack22;       
    end
    15:
    begin
        WDATA_S15 = pack1;
        WDATA_S16 = pack2;
        WDATA_S17 = pack3;
        WDATA_S18 = pack4;
        WDATA_S19 = pack5;
        WDATA_S20 = pack6;
        WDATA_S21 = pack7;
        WDATA_S22 = pack8;
        WDATA_S01 = pack9;
        WDATA_S02 = pack10;
        WDATA_S03 = pack11;
        WDATA_S04 = pack12;
        WDATA_S05 = pack13;
        WDATA_S06 = pack14;
        WDATA_S07 = pack15;
        WDATA_S08 = pack16;
        WDATA_S09 = pack17;
        WDATA_S10 = pack18;
        WDATA_S11 = pack19;
        WDATA_S12 = pack20;
        WDATA_S13 = pack21;
        WDATA_S14 = pack22;       
    end
    16:
    begin
        WDATA_S16 = pack1;
        WDATA_S17 = pack2;
        WDATA_S18 = pack3;
        WDATA_S19 = pack4;
        WDATA_S20 = pack5;
        WDATA_S21 = pack6;
        WDATA_S22 = pack7;
        WDATA_S01 = pack8;
        WDATA_S02 = pack9;
        WDATA_S03 = pack10;
        WDATA_S04 = pack11;
        WDATA_S05 = pack12;
        WDATA_S06 = pack13;
        WDATA_S07 = pack14;
        WDATA_S08 = pack15;
        WDATA_S09 = pack16;
        WDATA_S10 = pack17;
        WDATA_S11 = pack18;
        WDATA_S12 = pack19;
        WDATA_S13 = pack20;
        WDATA_S14 = pack21;
        WDATA_S15 = pack22;       
    end
    17:
    begin
        WDATA_S17 = pack1;
        WDATA_S18 = pack2;
        WDATA_S19 = pack3;
        WDATA_S20 = pack4;
        WDATA_S21 = pack5;
        WDATA_S22 = pack6;
        WDATA_S01 = pack7;
        WDATA_S02 = pack8;
        WDATA_S03 = pack9;
        WDATA_S04 = pack10;
        WDATA_S05 = pack11;
        WDATA_S06 = pack12;
        WDATA_S07 = pack13;
        WDATA_S08 = pack14;
        WDATA_S09 = pack15;
        WDATA_S10 = pack16;
        WDATA_S11 = pack17;
        WDATA_S12 = pack18;
        WDATA_S13 = pack19;
        WDATA_S14 = pack20;
        WDATA_S15 = pack21;
        WDATA_S16 = pack22;       
    end
    18:
    begin
        WDATA_S18 = pack1;
        WDATA_S19 = pack2;
        WDATA_S20 = pack3;
        WDATA_S21 = pack4;
        WDATA_S22 = pack5;
        WDATA_S01 = pack6;
        WDATA_S02 = pack7;
        WDATA_S03 = pack8;
        WDATA_S04 = pack9;
        WDATA_S05 = pack10;
        WDATA_S06 = pack11;
        WDATA_S07 = pack12;
        WDATA_S08 = pack13;
        WDATA_S09 = pack14;
        WDATA_S10 = pack15;
        WDATA_S11 = pack16;
        WDATA_S12 = pack17;
        WDATA_S13 = pack18;
        WDATA_S14 = pack19;
        WDATA_S15 = pack20;
        WDATA_S16 = pack21;
        WDATA_S17 = pack22;       
    end
    19:
    begin
        WDATA_S19 = pack1;
        WDATA_S20 = pack2;
        WDATA_S21 = pack3;
        WDATA_S22 = pack4;
        WDATA_S01 = pack5;
        WDATA_S02 = pack6;
        WDATA_S03 = pack7;
        WDATA_S04 = pack8;
        WDATA_S05 = pack9;
        WDATA_S06 = pack10;
        WDATA_S07 = pack11;
        WDATA_S08 = pack12;
        WDATA_S09 = pack13;
        WDATA_S10 = pack14;
        WDATA_S11 = pack15;
        WDATA_S12 = pack16;
        WDATA_S13 = pack17;
        WDATA_S14 = pack18;
        WDATA_S15 = pack19;
        WDATA_S16 = pack20;
        WDATA_S17 = pack21;
        WDATA_S18 = pack22;       
    end
    20:
    begin
        WDATA_S20 = pack1;
        WDATA_S21 = pack2;
        WDATA_S22 = pack3;
        WDATA_S01 = pack4;
        WDATA_S02 = pack5;
        WDATA_S03 = pack6;
        WDATA_S04 = pack7;
        WDATA_S05 = pack8;
        WDATA_S06 = pack9;
        WDATA_S07 = pack10;
        WDATA_S08 = pack11;
        WDATA_S09 = pack12;
        WDATA_S10 = pack13;
        WDATA_S11 = pack14;
        WDATA_S12 = pack15;
        WDATA_S13 = pack16;
        WDATA_S14 = pack17;
        WDATA_S15 = pack18;
        WDATA_S16 = pack19;
        WDATA_S17 = pack20;
        WDATA_S18 = pack21;
        WDATA_S19 = pack22;       
    end
    21:
    begin
        WDATA_S21 = pack1;
        WDATA_S22 = pack2;
        WDATA_S01 = pack3;
        WDATA_S02 = pack4;
        WDATA_S03 = pack5;
        WDATA_S04 = pack6;
        WDATA_S05 = pack7;
        WDATA_S06 = pack8;
        WDATA_S07 = pack9;
        WDATA_S08 = pack10;
        WDATA_S09 = pack11;
        WDATA_S10 = pack12;
        WDATA_S11 = pack13;
        WDATA_S12 = pack14;
        WDATA_S13 = pack15;
        WDATA_S14 = pack16;
        WDATA_S15 = pack17;
        WDATA_S16 = pack18;
        WDATA_S17 = pack19;
        WDATA_S18 = pack20;
        WDATA_S19 = pack21;
        WDATA_S20 = pack22;       
    end
    22:
    begin
        WDATA_S22 = pack1;
        WDATA_S01 = pack2;
        WDATA_S02 = pack3;
        WDATA_S03 = pack4;
        WDATA_S04 = pack5;
        WDATA_S05 = pack6;
        WDATA_S06 = pack7;
        WDATA_S07 = pack8;
        WDATA_S08 = pack9;
        WDATA_S09 = pack10;
        WDATA_S10 = pack11;
        WDATA_S11 = pack12;
        WDATA_S12 = pack13;
        WDATA_S13 = pack14;
        WDATA_S14 = pack15;
        WDATA_S15 = pack16;
        WDATA_S16 = pack17;
        WDATA_S17 = pack18;
        WDATA_S18 = pack19;
        WDATA_S19 = pack20;
        WDATA_S20 = pack21;
        WDATA_S21 = pack22;       
    end
    default:
    begin
        WDATA_S02 = 0;
        WDATA_S03 = 0;
        WDATA_S04 = 0;
        WDATA_S05 = 0;
        WDATA_S06 = 0;
        WDATA_S07 = 0;
        WDATA_S08 = 0;
        WDATA_S09 = 0;
        WDATA_S10 = 0;
        WDATA_S11 = 0;
        WDATA_S12 = 0;
        WDATA_S13 = 0;
        WDATA_S14 = 0;
        WDATA_S15 = 0;
        WDATA_S16 = 0;
        WDATA_S17 = 0;
        WDATA_S18 = 0;
        WDATA_S19 = 0;
        WDATA_S20 = 0;
        WDATA_S21 = 0;
        WDATA_S22 = 0;
        WDATA_S01 = 0;       
    end
   endcase
 end   
*/
 /* 	
	RAMB16_S9_S36 search_block01(	.DOA(RDATA_S01),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S01),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S01),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));
									
	RAMB16_S9_S36 search_block02(	.DOA(RDATA_S02),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S02),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S02),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));	
									
	RAMB16_S9_S36 search_block03(	.DOA(RDATA_S03),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S03),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S03),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block04(	.DOA(RDATA_S04),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S04),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S04),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));									

	RAMB16_S9_S36 search_block05(	.DOA(RDATA_S05),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S05),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S05),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block06(	.DOA(RDATA_S06),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S06),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S06),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block07(	.DOA(RDATA_S07),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S07),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S07),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block08(	.DOA(RDATA_S08),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S08),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S08),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block09(	.DOA(RDATA_S09),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S09),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S09),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block10(	.DOA(RDATA_S10),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S10),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S10),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block11(	.DOA(RDATA_S11),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S11),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S11),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block12(	.DOA(RDATA_S12),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S12),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S12),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block13(	.DOA(RDATA_S13),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S13),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S13),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block14(	.DOA(RDATA_S14),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S14),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S14),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block15(	.DOA(RDATA_S15),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S15),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S15),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block16(	.DOA(RDATA_S16),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S16),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S16),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block17(	.DOA(RDATA_S17),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S17),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S17),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block18(	.DOA(RDATA_S18),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S18),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S18),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block19(	.DOA(RDATA_S19),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S19),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S19),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block20(	.DOA(RDATA_S20),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S20),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S20),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block21(	.DOA(RDATA_S21),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S21),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S21),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));

	RAMB16_S9_S36 search_block22(	.DOA(RDATA_S22),
									.DOB(),
									.DOPA(),
									.DOPB(),
									.ADDRA(RADDR_S22),
									.ADDRB(WADDR_S),
									.CLKA(clk),
									.CLKB(clk),
									.DIA(),
									.DIB(WDATA_S22),
									.DIPA(),
									.DIPB(),
									.ENA(high),
									.ENB(high),
									.SSRA(low),
									.SSRB(low),
									.WEA(low),
									.WEB(WE_S));


*/
/**   	SW_Reg_4col search_block01 (
		.clk					(clk),
		.AddrOut		(RADDR_S01), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S01), 
		.WE			(WE_S),
		.DataOut		(RDATA_S01));
		
  
   	SW_Reg_4col search_block02 (
		.clk					(clk),
		.AddrOut		(RADDR_S02), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S02), 
		.WE			(WE_S),
		.DataOut		(RDATA_S02));
  
   	SW_Reg_4col search_block03 (
		.clk					(clk),
		.AddrOut		(RADDR_S03), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S03), 
		.WE			(WE_S),
		.DataOut		(RDATA_S03));
  
   	SW_Reg_4col search_block04 (
		.clk					(clk),
		.AddrOut		(RADDR_S04), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S04), 
		.WE			(WE_S),
		.DataOut		(RDATA_S04));
  
   	SW_Reg_4col search_block05 (
		.clk					(clk),
		.AddrOut		(RADDR_S05), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S05), 
		.WE			(WE_S),
		.DataOut		(RDATA_S05));
  
   	SW_Reg_4col search_block06 (
		.clk					(clk),
		.AddrOut		(RADDR_S06), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S06), 
		.WE			(WE_S),
		.DataOut		(RDATA_S06));
  
   	SW_Reg_4col search_block07 (
		.clk					(clk),
		.AddrOut		(RADDR_S07), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S07), 
		.WE			(WE_S),
		.DataOut		(RDATA_S07));
  
   	SW_Reg_4col search_block08 (
		.clk					(clk),
		.AddrOut		(RADDR_S08), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S08), 
		.WE			(WE_S),
		.DataOut		(RDATA_S08));
  
   	SW_Reg_4col search_block09 (
		.clk					(clk),
		.AddrOut		(RADDR_S09), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S09), 
		.WE			(WE_S),
		.DataOut		(RDATA_S09));
  
   	SW_Reg_4col search_block10 (
		.clk					(clk),
		.AddrOut		(RADDR_S10), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S10), 
		.WE			(WE_S),
		.DataOut		(RDATA_S10));
  
   	SW_Reg_4col search_block11 (
		.clk					(clk),
		.AddrOut		(RADDR_S11), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S11), 
		.WE			(WE_S),
		.DataOut		(RDATA_S11));
  
   	SW_Reg_4col search_block12 (
		.clk					(clk),
		.AddrOut		(RADDR_S12), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S12), 
		.WE			(WE_S),
		.DataOut		(RDATA_S12));
  
   	SW_Reg_4col search_block13 (
		.clk					(clk),
		.AddrOut		(RADDR_S13), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S13), 
		.WE			(WE_S),
		.DataOut		(RDATA_S13));
  
   	SW_Reg_4col search_block14 (
		.clk					(clk),
		.AddrOut		(RADDR_S14), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S14), 
		.WE			(WE_S),
		.DataOut		(RDATA_S14));
  
   	SW_Reg_4col search_block15 (
		.clk					(clk),
		.AddrOut		(RADDR_S15), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S15), 
		.WE			(WE_S),
		.DataOut		(RDATA_S15));
  
   	SW_Reg_4col search_block16 (
		.clk					(clk),
		.AddrOut		(RADDR_S16), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S16), 
		.WE			(WE_S),
		.DataOut		(RDATA_S16));
  
   	SW_Reg_4col search_block17 (
		.clk					(clk),
		.AddrOut		(RADDR_S17), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S17), 
		.WE			(WE_S),
		.DataOut		(RDATA_S17));
  
   	SW_Reg_4col search_block18 (
		.clk					(clk),
		.AddrOut		(RADDR_S18), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S18), 
		.WE			(WE_S),
		.DataOut		(RDATA_S18));
  
   	SW_Reg_4col search_block19 (
		.clk					(clk),
		.AddrOut		(RADDR_S19), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S19), 
		.WE			(WE_S),
		.DataOut		(RDATA_S19));
  
   	SW_Reg_4col search_block20 (
		.clk					(clk),
		.AddrOut		(RADDR_S20), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S20), 
		.WE			(WE_S),
		.DataOut		(RDATA_S20));
  
   	SW_Reg_4col search_block21 (
		.clk					(clk),
		.AddrOut		(RADDR_S21), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S21), 
		.WE			(WE_S),
		.DataOut		(RDATA_S21));
  
   	SW_Reg_4col search_block22 (
		.clk					(clk),
		.AddrOut		(RADDR_S22), 
		.AddrIn	(WADDR_S), 
		.DataIn	(WDATA_S22), 
		.WE			(WE_S),
		.DataOut		(RDATA_S22));
		
    
*/
median Mdn (.vec1(vectors0), .vec2(vectors1), .vec3(vectors2), .median(pre_median), .underTh(pre_underTh));
endmodule


