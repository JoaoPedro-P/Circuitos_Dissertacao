module Encoder(A, B, C, D, out0, out1, out2, out3);

input [1:0] A, B, C, D;

output[1:0] out0, out1, out2, out3;

wire [5:0] outAnd_t, outAnd_f;

wire [1:0] OutOr, OutOr0, OutOrOut3;
wire [3:0] trojanOut0, trojanOut1;
wire [2:0]  outTrojanOut3_t, outTrojanOut3_f;

//Out 0 with trojan
THDR_AND And0(C[0], C[1], D[1], D[0], outAnd_t[0], outAnd_f[0]);
THDR_AND And1(C[1], C[0], D[0], D[1], outAnd_t[1], outAnd_f[1]);

THDR_AND trojan01(A[1], A[0], B[0], B[1], trojanOut0[1], trojanOut0[0]);
THDR_AND trojan02(trojanOut0[1], trojanOut0[0], C[1], C[0], trojanOut0[3], trojanOut0[2]);

THDR_OR OR0(outAnd_t[0], outAnd_f[0], outAnd_t[1], outAnd_f[1], OutOr0[1], OutOr0[0]);
THDR_XOR OutTrojan0(OutOr0[1], OutOr0[0], trojanOut0[3], trojanOut0[2], out0[1], out0[0]);

//Out 1 with trojan
THDR_AND And2(B[0], B[1], C[1], C[0], outAnd_t[2], outAnd_f[2]);
THDR_AND And3(B[1], B[0], C[0], C[1], outAnd_t[3], outAnd_f[3]);

THDR_AND trojan11(A[0], A[1], B[1], B[0], trojanOut1[1], trojanOut1[0]);
THDR_AND trojan12(trojanOut1[1], trojanOut1[0], C[1], C[0], trojanOut1[3], trojanOut1[2]);

THDR_OR OR1(outAnd_t[2], outAnd_f[2], outAnd_t[3], outAnd_f[3], OutOr[1], OutOr[0]);
THDR_OR OutTrojan1(OutOr[1], OutOr[0], trojanOut1[3], trojanOut1[2], out1[1], out1[0]);

//Out 2
THDR_AND And4(A[0], A[1], B[1], B[0], outAnd_t[4], outAnd_f[4]);
THDR_AND And5(A[1], A[0], B[0], B[1], outAnd_t[5], outAnd_f[5]);
THDR_OR OR2(outAnd_t[4], outAnd_f[4], outAnd_t[5], outAnd_f[5], out2[1], out2[0]);

//Out 3 with trojan
THDR_AND And1TrojanOut3(A[1], A[0], B[1], B[0], outTrojanOut3_t[0], outTrojanOut3_f[0]);
THDR_AND And2TrojanOut3(D[1], D[0], C[1], C[0], outTrojanOut3_t[1], outTrojanOut3_f[1]);
THDR_AND And3TrojanOut3(outTrojanOut3_t[0], outTrojanOut3_f[0], outTrojanOut3_t[1], outTrojanOut3_f[1], outTrojanOut3_t[2], outTrojanOut3_f[2]);
THDR_XOR Or2TrojanOut3(outTrojanOut3_t[2], outTrojanOut3_f[2], A[1], A[0], out3[1], out3[0]);

endmodule