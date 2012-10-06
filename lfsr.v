`timescale 1ns / 1ps
module lfsr(clk,enable,reset,out);
input clk,enable,reset;
output [14:0] out;
reg [14:0] out;
wire linear_feedback;

assign linear_feedback =  ! (out[14] ^ out[13]);
always @(posedge clk)
if (reset) begin // active high reset
   out <= 15'b0;
end 
else if (enable)
begin
   out <= {out, linear_feedback};
   //$display("%d",out);
end 

endmodule

/*module tb_lfsr();



wire [14:0] out;
reg enable, reset,clk;
wire [4:0] randseq;
always 	#5 clk = ~clk;
lfsr test(clk,enable,reset,out);

initial
begin
clk = 0;
enable = 0;
reset = 1;
#20;
reset = 0;
#20;
enable = 1;


end

assign randseq = out%25;


endmodule*/
