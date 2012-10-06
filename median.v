module median(vec1,vec2,vec3,median,underTh);

input [13:0] vec1,vec2,vec3;
output reg [1:0] median; 
output reg underTh;
wire [7:0] L1_12,L1_13,L1_23;
wire [7:0] x_diff_12,y_diff_12,x_diff_13,y_diff_13,x_diff_23,y_diff_23;
parameter Vth = 2;

wire [6:0] vec1y,vec1x,vec2y,vec2x,vec3y,vec3x;

assign {vec1y,vec1x} = vec1;
assign {vec2y,vec2x} = vec2;
assign {vec3y,vec3x} = vec3;

/*assign vecx1gt2 = (vec1x > vec2x ? 1'b1 : 1'b0);
assign vecx1gt3 = (vec1x > vec3x ? 1'b1 : 1'b0); 
assign vecx2gt3 = (vec2x > vec3x ? 1'b1 : 1'b0);
assign vecy1gt2 = (vec1y > vec2y ? 1'b1 : 1'b0);
assign vecy1gt3 = (vec1y > vec3y ? 1'b1 : 1'b0); 
assign vecy2gt3 = (vec2y > vec3y ? 1'b1 : 1'b0);  

assign L1_12 = (vecx1gt2 ? (vec1x - vec2x) : (vec2x - vec1x)) + (vecy1gt2 ? (vec1y - vec2y) : (vec2y - vec1y));
assign L1_13 = (vecx1gt3 ? (vec1x - vec3x) : (vec3x - vec1x)) + (vecy1gt3 ? (vec1y - vec3y) : (vec3y - vec1y));
assign L1_23 = (vecx2gt3 ? (vec2x - vec3x) : (vec3x - vec2x)) + (vecy2gt3 ? (vec2y - vec3y) : (vec3y - vec2y));*/

assign x_diff_12 = {{1 {vec1x[6]}},vec1x} - {{1 {vec2x[6]}},vec2x};
assign y_diff_12 = {{1 {vec1y[6]}},vec1y} - {{1 {vec2y[6]}},vec2y};
assign x_diff_13 = {{1 {vec1x[6]}},vec1x} - {{1 {vec3x[6]}},vec3x};
assign y_diff_13 = {{1 {vec1y[6]}},vec1y} - {{1 {vec3y[6]}},vec3y};
assign x_diff_23 = {{1 {vec2x[6]}},vec2x} - {{1 {vec3x[6]}},vec3x};
assign y_diff_23 = {{1 {vec2y[6]}},vec2y} - {{1 {vec3y[6]}},vec3y};

assign L1_12 = ((x_diff_12 > 72) ? (~x_diff_12+1'b1) : x_diff_12) + ((y_diff_12 > 72) ? (~y_diff_12+1'b1) : y_diff_12);
assign L1_13 = ((x_diff_13 > 72) ? (~x_diff_13+1'b1) : x_diff_13) + ((y_diff_13 > 72) ? (~y_diff_13+1'b1) : y_diff_13);
assign L1_23 = ((x_diff_23 > 72) ? (~x_diff_23+1'b1) : x_diff_23) + ((y_diff_23 > 72) ? (~y_diff_23+1'b1) : y_diff_23);

always@*
begin
    if (L1_12 <= L1_23)
    begin
        if (L1_13 <= L1_23)
           median = 2'd0;
        else
           median = 2'd1;
    end
    else
    begin
        if (L1_13 < L1_12)
           median = 2'd2;
        else
           median = 2'd1;
    end
end

always@*
begin
    if ((L1_12 <= Vth) && (L1_13 <= Vth) && (L1_23 <= Vth))
       underTh = 1'b1;
    else
       underTh = 1'b0;
end




endmodule
