module detector(A, result, sel0, sel1, out);

input [1:0] A, sel0, sel1, result;

output [1:0] out;

wire [7:0] outAnd_t, outAnd_f;
wire [1:0] outNeg;


THDR_AND gNeg(A[1], A[0], result[0], result[1], outNeg[1], outNeg[0]);

//sum
THDR_AND g0(sel0[0], sel0[1], sel1[0], sel1[1], outAnd_t[0], outAnd_f[0]);
THDR_AND g1(outAnd_t[0], outAnd_f[0], outNeg[1], outNeg[0], outAnd_t[1], outAnd_f[1]);

//sub
THDR_AND g2(sel0[1], sel0[0], sel1[0], sel1[1], outAnd_t[2], outAnd_f[2]);
THDR_AND g3(outAnd_t[2], outAnd_f[2], outNeg[1], outNeg[0], outAnd_t[3], outAnd_f[3]);


THDR_OR g8(outAnd_t[1], outAnd_f[1], outAnd_t[3], outAnd_f[3], out[1], out[0]);
endmodule