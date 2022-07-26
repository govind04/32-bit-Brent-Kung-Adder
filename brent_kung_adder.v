module BK_adder32bit (
	input [31:0]x, y,
	input cin,
	output [31:0] sum,
	output cout);
	
	wire [32:0] carry;
	assign carry[0] = cin; //input carry
	
	wire [31:0] G_1, P_1;
	assign G_1 = x & y;
	assign P_1 = x ^ y;
	
	//level1
	genvar i;
	wire [15:0] G_2, P_2;
	generate
		for(i=0;i<16;i=i+1) begin
			assign G_2[i] = G_1[2*i+1] | P_1[2*i+1] & G_1[2*i];
			assign P_2[i] = P_1[2*i+1] & P_1[2*i];
		end
	endgenerate
	
	//level2
	genvar j;
	wire [7:0] G_3, P_3;
	generate
		for(j=0;j<8;j=j+1) begin
			assign G_3[j] = G_2[2*j+1] | P_2[2*j+1] & G_2[2*j];
			assign P_3[j] = P_2[2*j+1] & P_2[2*j];
		end
	endgenerate
	
	//level3
	genvar k;
	wire [3:0] G_4, P_4;
	generate
		for(k=0;k<4;k=k+1) begin
			assign G_4[k] = G_3[2*k+1] | P_3[2*k+1] & G_3[2*k];
			assign P_4[k] = P_3[2*k+1] & P_3[2*k];
		end
	endgenerate
	
	//level4
	genvar l;
	wire [1:0] G_5, P_5;
	generate
		for(l=0;l<2;l=l+1) begin
			assign G_5[l] = G_4[2*l+1] | P_4[2*l+1] & G_4[2*l];
			assign P_5[l] = P_4[2*l+1] & P_4[2*l];
		end
	endgenerate
	
	//level5
	wire G_6, P_6;
	assign G_6 = G_5[1] | P_5[1] & G_5[0];
	assign P_6 = P_5[1] & P_5[0];
	
	//carry generation
	//1st iteration
	assign carry[32] = G_6 | P_6 & carry[0];
	assign carry[16] = G_5[0] | P_5[0] & carry[0];
	
	//2nd iteration
	assign carry[8] = G_4[0] | P_4[0] & carry[0];
	assign carry[24] = G_4[2] | P_4[2] & carry[16];
	
	//3rd iteration
	assign carry[4] = G_3[0] | P_3[0] & carry[0];
	assign carry[12] = G_3[2] | P_3[2] & carry[8];
	assign carry[20] = G_3[4] | P_3[4] & carry[16];
	assign carry[28] = G_3[6] | P_3[6] & carry[24];
	
	//4th iteration
	assign carry[2] = G_2[0] | P_2[0] & carry[0];
	assign carry[6] = G_2[2] | P_2[2] & carry[4];
	assign carry[10] = G_2[4] | P_2[4] & carry[8];
	assign carry[14] = G_2[6] | P_2[6] & carry[12];
	assign carry[18] = G_2[8] | P_2[8] & carry[16];
	assign carry[22] = G_2[10] | P_2[10] & carry[20];
	assign carry[26] = G_2[12] | P_2[12] & carry[24];
	assign carry[30] = G_2[14] | P_2[14] & carry[28];
	
	//5th iteration
	assign carry[1] = G_1[0] | P_1[0] & carry[0];
	assign carry[3] = G_1[2] | P_1[2] & carry[2];
	assign carry[5] = G_1[4] | P_1[4] & carry[4];
	assign carry[7] = G_1[6] | P_1[6] & carry[6];
	assign carry[9] = G_1[8] | P_1[8] & carry[8];
	assign carry[11] = G_1[10] | P_1[10] & carry[10];
	assign carry[13] = G_1[12] | P_1[12] & carry[12];
	assign carry[15] = G_1[14] | P_1[14] & carry[14];
	assign carry[17] = G_1[16] | P_1[16] & carry[16];
	assign carry[19] = G_1[18] | P_1[18] & carry[18];
	assign carry[21] = G_1[20] | P_1[20] & carry[20];
	assign carry[23] = G_1[22] | P_1[22] & carry[22];
	assign carry[25] = G_1[24] | P_1[24] & carry[24];
	assign carry[27] = G_1[26] | P_1[26] & carry[26];
	assign carry[29] = G_1[28] | P_1[28] & carry[28];
	assign carry[31] = G_1[30] | P_1[30] & carry[30];
	
	assign sum = P_1 ^ carry[31:0];
	
endmodule
