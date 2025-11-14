module Encoder(A_t, A_f, B_t, B_f, C_t, C_f, D_t, D_f, out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f);

input A_t, A_f, B_t, B_f, C_t, C_f, D_t, D_f;

output out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f;

wire [5:0] outAnd_t, outAnd_f;

//Out 0
THDR_AND And0(C_f, C_t, D_t, D_f, outAnd_t[0], outAnd_f[0]);
THDR_AND And1(C_t, C_f, D_f, D_t, outAnd_t[1], outAnd_f[1]);
THDR_OR OR0(outAnd_t[0], outAnd_f[0], outAnd_t[1], outAnd_f[1], out0_t, out0_f);

//Out 1
THDR_AND And2(B_f, B_t, C_t, C_f, outAnd_t[2], outAnd_f[2]);
THDR_AND And3(B_t, B_f, C_f, C_t, outAnd_t[3], outAnd_f[3]);
THDR_OR OR1(outAnd_t[2], outAnd_f[2], outAnd_t[3], outAnd_f[3], out1_t, out1_f);

//Out 2
THDR_AND And4(A_f, A_t, B_t, B_f, outAnd_t[4], outAnd_f[4]);
THDR_AND And5(A_t, A_f, B_f, B_t, outAnd_t[5], outAnd_f[5]);
THDR_OR OR2(outAnd_t[4], outAnd_f[4], outAnd_t[5], outAnd_f[5], out2_t, out2_f);

//Out 3
assign out3_t = A_t;
assign out3_f = A_f;

endmodule