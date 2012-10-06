`timescale 1ns / 1ps
module top3DRS(clk,reset,start,cur_WE,search_WE_req,search_WE,cur_data_in,/*search_addr_in,search_data_in,*/curfilled,srcfilled,firstframe,testAddr,testMV,blockendout,frameendout,MVout_x,MVout_y);
   input clk,reset,start,curfilled,srcfilled,firstframe;
   input wire [13:0] testAddr;
   output wire [13:0] testMV;
   output wire blockendout,frameendout;
   wire [5:0] updatevec;
   wire update_enable, SW_AddrGen_enable, /*UWFilled, UW_WE, */MV_Process_Done, goextended,extended,underTh;
   wire [13:0] MVout,MV1, MV2, MV3, curMV, selectedMV, MVarray_in;
   wire [2047:0] SearchWin,CurBlock;
   wire [15:0] curSAD;
   input wire cur_WE, search_WE;
   output wire search_WE_req;
   input wire [63:0] cur_data_in;
   //*input [0:88*8-1] search_data_in;
   //*input wire [6:0] search_addr_in;
   wire mv_array_WE,mvselect_WE,MVwait,rowend,feed,MVselect_done;
   wire [13:0] curpos;
   output wire [6:0] MVout_x,MVout_y;
   //wire [1:0] SW_addr_control;
   /**wire [8*22-1:0] UW_Data_IN;
   wire [4:0] UW_address;
   wire [2:0] UW_row,UW_col;*/
   
   assign blockendout = MVselect_done;
   
   
   RegFileCur reg_cur(.clk(clk),.reset(reset),.WE(cur_WE),.DataIN(cur_data_in),.DataOUT(CurBlock));
   RegFileCur reg_search(.clk(clk),.reset(reset),.WE(search_WE),.DataIN(cur_data_in),.DataOUT(SearchWin));
   SAD_Calculation pe_array(.clk(clk), .reset(reset), .search(SearchWin), .current(CurBlock), .SADOUT(curSAD)); 
   
   //RegFile_SW reg_search(.clk(clk),.reset(reset),.WE(search_WE),.AddrIN(search_addr_in),.DataIN(search_data_in),.MVin(curMV),.DataOUT(SearchWin));
   
   SW_AddrGen swaddrgen(.clk(clk),.reset(reset),
                        .enable(SW_AddrGen_enable),
                        .vecin(MVout),
                        .updatein(updatevec),
                        .outMV(curMV),
                        //.UW_Filled(UWFilled),
                        //.UWDATA_Out(UW_Data_IN),
                        //.UW_WE(UW_WE),
                        //.SW_WE(search_WE),
						.SW_WE_req(search_WE_req),
                        .MV_ready(mv_array_WE),
                        //.InputDATA(search_data_in),
                        //.InputADDR(search_addr_in),
                        .done(MV_Process_Done),
						//.UWaddress_out(UW_address),
						//.UW_ROW(UW_row),
						//.UW_COL(UW_col),
						.MVselect_WE(mvselect_WE),
						.MVwait(MVwait),
						.Row_end(rowend),
						.frame_end(frameendout),
						.feed(feedvec),
						.limited_out_x(MVout_x),
						.limited_out_y(MVout_y),
						.SBFilled(srcfilled),
						.goextended(goextended),
						.extended(extended),
						.underTh(underTh));
   //UW updatewin (.clk(clk), .reset(reset), .WE(UW_WE),.W_SELECT_ROW_OR_COL(),.R_ROW(UW_row),.R_COL(UW_col), .input_data(UW_Data_IN), .UWFilled(UWFilled), .SearchOut(SearchWin), .write_count(UW_address));
   
   MV_Array mvarray(.clk(clk),.reset(reset),.feed(feedvec),.WE(mv_array_WE),.curpos(curpos),.MVector(MVarray_in),.vecout(MVout),.AddrOut(testAddr),.topMVout(testMV),.extended(extended));
   
   
   Update updater(.clk(clk),.reset(reset),.en(update_enable),.uvec(updatevec));
   
   
   MV_Selector mvselect(.clk(clk),.reset(reset),.WE(mvselect_WE),.SADin(curSAD),.MVin(curMV),.MVSelected(selectedMV),/*.SADSelected(),*/.done_out(MVselect_done),.MVwait(MVwait),.goextended(goextended),.extended(extended),.underTh(underTh));
   Controller controller(.clk(clk),.reset(reset),.enable(start),.UPen(update_enable),.SWaddren(SW_AddrGen_enable),.MVArray_WE(mv_array_WE),.curpos(curpos),.firstframe(firstframe),.blockend(MVselect_done),.rowend(rowend),.currentfilled(curfilled),.frameend(frameendout),.goextended(goextended)); 

    
   assign MVarray_in = firstframe ? {{{4 {updatevec[5]}},updatevec[5:3]},{{4 {updatevec[2]}},updatevec[2:0]}} : selectedMV;
   
   //assign mv_array_WE = firstframe ? 
   
  
    
    
endmodule
