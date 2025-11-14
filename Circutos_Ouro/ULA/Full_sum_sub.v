module Full_sum_sub(A_t, A_f, B_t, B_f, Op_t, Op_f, Carry_in_t, Carry_in_f, out_t, out_f, carry_out_t, carry_out_f);

input A_t, A_f, B_t, B_f, Op_t, Op_f, Carry_in_t, Carry_in_f;

output out_t, out_f, carry_out_t, carry_out_f;

wire [18:0] outInter_t, outInter_f; 

//Output
THDR_AND Gout0(A_t, A_f, B_f, B_t, outInter_t[0], outInter_f[0]); //A and B'
THDR_AND Gout1(outInter_t[0], outInter_f[0], Carry_in_f, Carry_in_t, outInter_t[1], outInter_f[1]); //A and B' and Cin'

THDR_AND Gout2(A_t, A_f, B_t, B_f, outInter_t[2], outInter_f[2]); //A and B
THDR_AND Gout3(outInter_t[2], outInter_f[2], Carry_in_t, Carry_in_f, outInter_t[3], outInter_f[3]); //A and B and Cin

THDR_AND Gout4(A_f, A_t, Carry_in_t, Carry_in_f, outInter_t[4], outInter_f[4]); //A' and Cin
THDR_AND Gout5(outInter_t[4], outInter_f[4], B_f, B_t, outInter_t[5], outInter_f[5]); //A' and B' and Cin 

THDR_AND Gout6(A_f, A_t, B_t, B_f, outInter_t[6], outInter_f[6]); //A' and B
THDR_AND Gout7(outInter_t[6], outInter_f[6], Carry_in_f, Carry_in_t, outInter_t[7], outInter_f[7]); //A' and B and Cin'

THDR_OR Gout8(outInter_t[1], outInter_f[1], outInter_t[3], outInter_f[3], outInter_t[8], outInter_f[8]); //(A and B' and Cin') + (A and B and Cin)
THDR_OR Gout9(outInter_t[5], outInter_f[5], outInter_t[7], outInter_f[7], outInter_t[9], outInter_f[9]); //(A' and B' and Cin) + (A' and B and Cin')

THDR_OR Gout10(outInter_t[8], outInter_f[8], outInter_t[9], outInter_f[9], out_t, out_f); //(A' and B' and Cin) + (A' and B and Cin') + (A' and B' and Cin) + (A' and B and Cin')

//Carry Out
THDR_AND Gout11(B_t, B_f, Carry_in_t, Carry_in_f, outInter_t[10], outInter_f[10]); //B and Cin

THDR_AND Gout12(Op_f, Op_t, A_t, A_f, outInter_t[11], outInter_f[11]); //Op'and A
THDR_AND Gout13(outInter_t[11], outInter_f[11], Carry_in_t, Carry_in_f, outInter_t[12], outInter_f[12]); //Op' and A and Cin

THDR_AND Gout14(Op_t, Op_f, outInter_t[4], outInter_f[4] , outInter_t[13], outInter_f[13]); //Op and A' and Cin

THDR_AND Gout15(Op_t, Op_f, outInter_t[6], outInter_f[6] , outInter_t[14], outInter_f[14]); //Op and A' and B

THDR_AND Gout16(Op_f, Op_t, outInter_t[2], outInter_f[2] , outInter_t[15], outInter_f[15]); //Op' and A and B


THDR_OR Gout17(outInter_t[10], outInter_f[10], outInter_t[12], outInter_f[12], outInter_t[16], outInter_f[16]); //(B and Cin) + (Op' and A and Cin)
THDR_OR Gout18(outInter_t[13], outInter_f[13], outInter_t[14], outInter_f[14], outInter_t[17], outInter_f[17]); //(Op and A' and Cin) + (Op and A' and B)
THDR_OR Gout19(outInter_t[17], outInter_f[17], outInter_t[15], outInter_f[15], outInter_t[18], outInter_f[18]); //(Op and A' and Cin) + (Op and A' and B) + (Op' and A and B)

THDR_OR Gout20(outInter_t[18], outInter_f[18], outInter_t[16], outInter_f[16], carry_out_t, carry_out_f); //(B and Cin) + (Op' and A and Cin) + (Op and A' and Cin) + (Op and A' and B) + (Op' and A and B)

endmodule