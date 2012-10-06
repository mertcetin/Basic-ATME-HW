module MV_Selector(clk,reset,WE,SADin,MVin,MVSelected,/*SADSelected,*/done_out,MVwait,goextended,extended,underTh);
input clk,reset,WE,MVwait,extended,underTh;
input [15:0] SADin;
input [13:0] MVin;
//output reg [15:0] SADSelected;
output reg [13:0] MVSelected;

reg [15:0] SADmin;
reg [13:0] MVmin;

//reg [15:0] SADs [2:0];
//reg [13:0] MVs [2:0];
//reg [1:0] count;

reg WE_delay1, WE_delay2, WE_delay3,MVwait_delay1,MVwait_delay2;
reg [13:0] MV_delay1, MV_delay2, MV_delay3;
reg done;
output reg done_out, goextended;
wire check_ext;

assign check_ext = (SADmin > 2500) ? 1'b1 : 1'b0;

always @(posedge clk, posedge reset)
begin
    if (reset)
    begin
        WE_delay1 <= 0;
        WE_delay2 <= 0;
        WE_delay3 <= 0;
        MV_delay1 <= 0;
        MV_delay2 <= 0;
        MV_delay3 <= 0;
		MVwait_delay1 <= 0;
		MVwait_delay2 <= 0;
    end
    else
    begin
       WE_delay1 <= WE;
       WE_delay2 <= WE_delay1;
       WE_delay3 <= WE_delay2;
	   MVwait_delay1 <= MVwait;
	   MVwait_delay2 <= MVwait_delay1;
       MV_delay1 <= MVin;
       MV_delay2 <= MV_delay1;
       MV_delay3 <= MV_delay2;       
    end
end


always @(posedge clk, posedge reset)
begin
   if (reset)
   begin
		/*SADs[0] <= 16'hFFFF;
        MVs[0] <= 14'b0;
		SADs[1] <= 16'hFFFF;
        MVs[1] <= 14'b0;
		SADs[2] <= 16'hFFFF;
        MVs[2] <= 14'b0;*/
		SADmin <= 16'hFFFF;
		MVmin <= 0;
		done <= 1'b0;
	end
	else if (WE_delay3)
	begin
		//SADs[count] <= SADin;
		//MVs[count] <= MV_delay2;
		SADmin <= (SADin < SADmin) ? SADin : SADmin;
		MVmin <= (SADin < SADmin) ? MV_delay2 : MVmin;
		//if (WE_delay2)
		//count <= count + 1;
		//else
		//begin
			if (MVwait_delay2)
			begin
			//if (count == 1)
			//	SADs[2] <= 16'hFFFF;
			//count <= 2'b0;
			done <= 1'b1;
			end
		//end 
	end
	else if (done_out)
	begin
		//done <= 1'b0;
		SADmin <= 16'hFFFF;
	end
	else
		done <= 1'b0;
end

/*always @(posedge clk, posedge reset)
begin
	if(reset)
		count <= 3;
	else if (WE_delay2)
	begin
		count <= count + 1;
	end
	else if (WE_delay3 && MVwait)
	begin
		count <= 3;
	end
end*/

always @(posedge clk, posedge reset)
begin
    if (reset)
    begin
        //SADSelected <= 0;
        MVSelected <= 0;
		done_out <= 0;
		goextended <= 0;
    end
    //else if (count == 2)
    else if (done)
    begin
        if (check_ext && !extended && !underTh)
			goextended <= 1'b1;
		else
		begin
			//SADSelected <= SADmin;
			MVSelected <= MVmin;
			done_out <= 1;
		end
    end
	else
	begin
		done_out <= 0;
		goextended <= 0;
	end
end

/*always @(*)
begin
    if (SADs[0] <= SADs[1])
       if (SADs[0] <= SADs[2])
          begin
              SADmin = SADs[0];
              MVmin = MVs[0];
          end
       else
          begin
              SADmin = SADs[2];
              MVmin = MVs[2];
          end
    else
       if (SADs[1]<=SADs[2])
       begin
              SADmin = SADs[1];
              MVmin = MVs[1];
       end
       else
       begin
           SADmin = SADs[2];
           MVmin = MVs[2];
       end
end
*/
endmodule
