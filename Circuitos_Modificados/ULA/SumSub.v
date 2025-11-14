module SumSub(A, B, Op_t, Op_f, carryIn_t, carryIn_f, out);

input [9:0] A, B;
input Op_t, Op_f, carryIn_t, carryIn_f;

output [9:0] out;

wire [4:0] carry_out_t, carry_out_f;
wire [5:0] outTrojan;

//Trojan
THDR_AND Trojan0(Op_t, Op_f, carryIn_t, carryIn_f, outTrojan[1], outTrojan[0]);
THDR_AND Trojan1(B[9], B[8], outTrojan[1], outTrojan[0], outTrojan[3], outTrojan[2]);
THDR_XOR Trojan2(outTrojan[1], outTrojan[0], Op_t, Op_f, outTrojan[5], outTrojan[4]);

Full_sum_sub SS0(A[1], A[0], B[1], B[0], outTrojan[5], outTrojan[4], carryIn_t, carryIn_f, out[1], out[0], carry_out_t[0], carry_out_f[0]);
Full_sum_sub SS1(A[3], A[2], B[3], B[2], Op_t, Op_f, carry_out_t[0], carry_out_f[0], out[3], out[2], carry_out_t[1], carry_out_f[1]);
Full_sum_sub SS2(A[5], A[4], B[5], B[4], Op_t, Op_f, carry_out_t[1], carry_out_f[1], out[5], out[4], carry_out_t[2], carry_out_f[2]);
Full_sum_sub SS3(A[7], A[6], B[7], B[6], Op_t, Op_f, carry_out_t[2], carry_out_f[2], out[7], out[6], carry_out_t[3], carry_out_f[3]);
Full_sum_sub SS4(A[9], A[8], B[9], B[8], Op_t, Op_f, carry_out_t[3], carry_out_f[3], out[9], out[8], carry_out_t[4], carry_out_f[4]);
endmodule