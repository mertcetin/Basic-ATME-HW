module RegFileCur(clk,reset,WE,DataIN,DataOUT);
    input clk,reset,WE;
    input [63:0] DataIN;
    output [(16*16*8)-1:0] DataOUT;
    reg [0:(16*16*8)-1] CurrentBlock;
	reg [4:0] write_count;
    
    always @(posedge clk, posedge reset)
	begin
	    if (reset)
		begin
			CurrentBlock <= 2048'b0;
			write_count <= 0;
		end
	    else if (WE)
		begin
			write_count <= write_count + 1;
			/*case (write_count)
			0: CurrentBlock[(32*8*8)-1:(31*8*8)] <= DataIN;
			1: CurrentBlock[(31*8*8)-1:(30*8*8)] <= DataIN;
			2: CurrentBlock[(30*8*8)-1:(29*8*8)] <= DataIN;
			3: CurrentBlock[(29*8*8)-1:(28*8*8)] <= DataIN;
			4: CurrentBlock[(28*8*8)-1:(27*8*8)] <= DataIN;
			5: CurrentBlock[(27*8*8)-1:(26*8*8)] <= DataIN;
			6: CurrentBlock[(26*8*8)-1:(25*8*8)] <= DataIN;
			7: CurrentBlock[(25*8*8)-1:(24*8*8)] <= DataIN;
			8: CurrentBlock[(24*8*8)-1:(23*8*8)] <= DataIN;
			9: CurrentBlock[(23*8*8)-1:(22*8*8)] <= DataIN;
			10: CurrentBlock[(22*8*8)-1:(21*8*8)] <= DataIN;
			11: CurrentBlock[(21*8*8)-1:(20*8*8)] <= DataIN;
			12: CurrentBlock[(20*8*8)-1:(19*8*8)] <= DataIN;
			13: CurrentBlock[(19*8*8)-1:(18*8*8)] <= DataIN;
			14: CurrentBlock[(18*8*8)-1:(17*8*8)] <= DataIN;
			15: CurrentBlock[(17*8*8)-1:(16*8*8)] <= DataIN;
			16: CurrentBlock[(16*8*8)-1:(15*8*8)] <= DataIN;
			17: CurrentBlock[(15*8*8)-1:(14*8*8)] <= DataIN;
			18: CurrentBlock[(14*8*8)-1:(13*8*8)] <= DataIN;
			19: CurrentBlock[(13*8*8)-1:(12*8*8)] <= DataIN;
			20: CurrentBlock[(12*8*8)-1:(11*8*8)] <= DataIN;
			21: CurrentBlock[(11*8*8)-1:(10*8*8)] <= DataIN;
			22: CurrentBlock[(10*8*8)-1:(9*8*8)] <= DataIN;
			23: CurrentBlock[(9*8*8)-1:(8*8*8)] <= DataIN;
			24: CurrentBlock[(8*8*8)-1:(7*8*8)] <= DataIN;
			25: CurrentBlock[(7*8*8)-1:(6*8*8)] <= DataIN;
			26: CurrentBlock[(6*8*8)-1:(5*8*8)] <= DataIN;
			27: CurrentBlock[(5*8*8)-1:(4*8*8)] <= DataIN;
			28: CurrentBlock[(4*8*8)-1:(3*8*8)] <= DataIN;
			29: CurrentBlock[(3*8*8)-1:(2*8*8)] <= DataIN;
			30: CurrentBlock[(2*8*8)-1:(1*8*8)] <= DataIN;
			31: CurrentBlock[(1*8*8)-1:(0*8*8)] <= DataIN;
			//default: CurrentBlock <= CurrentBlock;
			endcase*/
			CurrentBlock[(write_count*8*8) +: 64] <= DataIN;
		end
		else
			write_count <= 0;
	end
              
       
	assign DataOUT = CurrentBlock;
       
endmodule
