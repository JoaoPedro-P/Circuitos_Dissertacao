module overDetector(A, B, outSumSub, Sel0, Sel1, Overflow);

input [1:0] A, B, outSumSub, Sel0, Sel1;

output [1:0] Overflow;

wire [1:0] signalB, outAnd_t, outAnd_f;
wire [9:0] outOverflow;


MUX2to1_NCL gOver0(Sel0[1], Sel0[0], B[0], B[1], B[1], B[0], signalB[1], signalB[0]);
THDR_XOR gOver1(A[1], A[0], signalB[1], signalB[0], outOverflow[0], outOverflow[1]);
THDR_XOR gOver2(A[1], A[0], outSumSub[1], outSumSub[0], outOverflow[3], outOverflow[2]);
THDR_AND gOver3(outOverflow[3], outOverflow[2], outOverflow[1], outOverflow[0], outOverflow[5], outOverflow[4]);

THDR_AND gOver4(Sel0[0], Sel0[1], Sel1[0], Sel1[1], outAnd_t[0], outAnd_f[0]);
THDR_AND gOver5(outOverflow[5], outOverflow[4], outAnd_t[0], outAnd_f[0], outOverflow[7], outOverflow[6]);

THDR_AND gOver6(Sel0[1], Sel0[0], Sel1[0], Sel1[1], outAnd_t[1], outAnd_f[1]);
THDR_AND gOver7(outOverflow[5], outOverflow[4], outAnd_t[1], outAnd_f[1], outOverflow[9], outOverflow[8]);

THDR_OR gOver8(outOverflow[9], outOverflow[8], outOverflow[7], outOverflow[6], Overflow[1], Overflow[0]);

endmodule