module detector(A, B, C, result, sel0, sel1, out);

input [1:0] A, B, C, sel0, sel1, result;

output [1:0] out;

wire [7:0] outAnd_t, outAnd_f;
wire [1:0] outNeg;
wire [1:0] outOr_t, outOr_f;


THDR_AND g0(A[1], A[0], result[0], result[1], outNeg[1], outNeg[0]);

//sum
THDR_AND g1(sel0[0], sel0[1], sel1[0], sel1[1], outAnd_t[0], outAnd_f[0]);
THDR_AND g2(outAnd_t[0], outAnd_f[0], outNeg[1], outNeg[0], outAnd_t[1], outAnd_f[1]);

//sub
THDR_AND g3(sel0[1], sel0[0], sel1[0], sel1[1], outAnd_t[2], outAnd_f[2]);
THDR_AND g4(outAnd_t[2], outAnd_f[2], outNeg[1], outNeg[0], outAnd_t[3], outAnd_f[3]);

//Xor
THDR_AND g5(sel0[0], sel0[1], sel1[1], sel1[0], outAnd_t[4], outAnd_f[4]);
THDR_AND g6(outAnd_t[4], outAnd_f[4], B[1], B[0], outAnd_t[5], outAnd_f[5]);

//And
THDR_AND g7(sel0[1], sel0[0], sel1[1], sel1[0], outAnd_t[6], outAnd_f[6]);
THDR_AND g8(outAnd_t[6], outAnd_f[6], C[1], C[0], outAnd_t[7], outAnd_f[7]);


THDR_OR g9(outAnd_t[1], outAnd_f[1], outAnd_t[3], outAnd_f[3], outOr_t[0], outOr_f[0]);
THDR_OR g10(outAnd_t[5], outAnd_f[5], outAnd_t[7], outAnd_f[7], outOr_t[1], outOr_f[1]);
THDR_OR g11(outOr_t[0], outOr_f[0], outOr_t[1], outOr_f[1], out[1], out[0]);

endmodule