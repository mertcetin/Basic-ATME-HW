module BlockRAM_Vec(clk,WE,Addr,AddrOut,MVreadOut,VecIn,VecOut);
input clk;
input [13:0] Addr,AddrOut;
input [13:0] VecIn;
input WE;

output [13:0] VecOut,MVreadOut;

reg [13:0] dump,dump2;

reg [13:0]  VecMem[0:8039];

assign VecOut = VecMem[dump];
assign MVreadOut = VecMem[dump2];

integer file;

initial
begin
	file = $fopen("MVectors.txt");
end

always @(posedge clk)
begin
   dump <= Addr;
   dump2 <= AddrOut;
   if (WE)
   begin
      VecMem[Addr] <= VecIn;
		if(VecIn[13:7] > 36)
			begin
				if (VecIn[6:0] > 36)
				begin
					$fdisplay (file, "( -%d, -%d)",~VecIn[6:0]+1'b1,~VecIn[13:7]+1'b1); 
					$display ("( -%d, -%d)",~VecIn[6:0]+1'b1,~VecIn[13:7]+1'b1);
				end
				else
				begin
					$fdisplay (file, "( %d, -%d)",VecIn[6:0],~VecIn[13:7]+1'b1); 
					$display ("( %d, -%d)",VecIn[6:0],~VecIn[13:7]+1'b1);
				end
			end
			else
			begin
				if(VecIn[6:0] > 36)
				begin
					$fdisplay (file, "( -%d, %d)",~VecIn[6:0]+1'b1,VecIn[13:7]); 
					$display ("( -%d, %d)",~VecIn[6:0]+1'b1,VecIn[13:7]);
				end
				else
				begin
					$fdisplay (file, "( %d, %d)",VecIn[6:0],VecIn[13:7]); 
					$display ("( %d, %d)",VecIn[6:0],VecIn[13:7]);
				end
			end	
	end
end




endmodule
