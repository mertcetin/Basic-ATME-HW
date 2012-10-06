module Controller(clk,reset,enable,UPen,SWaddren,MVArray_WE,curpos,firstframe,blockend,rowend,currentfilled,frameend,goextended);
input clk,reset,enable,firstframe,blockend,currentfilled,goextended;
output reg UPen,MVArray_WE,frameend;
output [13:0] curpos;
output SWaddren,rowend;
reg [6:0] count_x,count_y;

parameter totalblockX = 79;
parameter totalblockY = 44;

parameter init = 0, MEinit = 1, MEfirst = 2, FillCurrent = 3, /*FillSearch = 4, */process = 4;
reg [3:0] State;
wire countenable;
//reg currentfilled, searchfilled;
assign curpos = {count_y,count_x};

always @ (posedge clk, posedge reset)
begin
    if (reset)
    State <= init;
    else
    begin
       case (State)
           init:
           begin
               if (enable)
                  State <= MEinit;
           end
           MEinit:
           begin
               if (firstframe)
                  State <= MEfirst;
               else
                  State <= FillCurrent;
           end
           MEfirst:
               if (frameend)
                  State <= init;
           FillCurrent:
           begin
               if (currentfilled)
               State <= process;
           end
           //FillSearch:
           //begin
             //  if (searchfilled)
              // State <= process;
           //end
           process:
           begin
               if (blockend)
                  if (frameend)
                     State <= init;
                  else
                     State <= MEinit;
                    
           end
           default:
              State <= init;
       endcase
              
    end
end

assign SWaddren = (State == process) ? 1 : 0;

/*always@(*)
begin
    case(State)
        processMV1:
        begin
            SW_Addr_Control = 0;
        end
        processMV2:
        begin
            SW_Addr_Control = 1;
        end
        processMV3:
        begin
            SW_Addr_Control = 2;
        end
        default:
        begin
            SW_Addr_Control = 0;
        end
    endcase
end*/


assign countenable = ((State == MEfirst) || ((State == process) && blockend ));
/*always@(*)
begin
    case(State)
        process,MEfirst:
        begin
            countenable = 1;
        end
        default:
        begin
            countenable = 0;
        end
    endcase
end*/

always@(posedge clk, posedge reset)
begin
    if(reset)
    begin
        count_x <= 0;
        count_y <= 0;
    end
    else if (countenable)
    begin
        if (count_x != totalblockX)
        begin
           count_x <= count_x + 1;
       end
       else
       begin
          count_x <= 0;
          if (count_y != totalblockY)
          count_y <= count_y + 1;
          else
          count_y <= 0;
       end
    end  
 end  
 
 assign rowend = (count_x == totalblockX) && blockend;
 
 always @ (*)
 begin
     if (count_x == totalblockX && count_y == totalblockY)
     frameend = 1;
     else
     frameend = 0;
 end
 
 always @ (*)
 begin
     if (countenable || goextended)
     UPen = 1;
     
     else
     UPen = 0;
 end
 
  always @ (*)
 begin
     if ((State == MEfirst) || (State == process && blockend))
     MVArray_WE = 1;
     
     else
     MVArray_WE = 0;
 end






endmodule
