module ULA (A, B, Sel0, Sel1, CarryIn, Out, Overflow, Neg, Zero);

input [9:0] A, B;
input [1:0] Sel0, Sel1, CarryIn;

output [9:0] Out;
output [1:0] Overflow, Neg, Zero;

wire [9:0] outSumSub, outXor, outAnd;
wire [7:0] outAnd_t, outAnd_f;
wire [5:0] outZero;
wire [4:0] carry_out_t, carry_out_f;
wire [1:0] outNeg;
wire [1:0] outOr_t, outOr_f;

// Sum/Sub 5 bits (1 de sinal + 4 dados)
SumSub Op0(A, B, Sel0[1], Sel0[0], CarryIn[1], CarryIn[0], outSumSub[9:0]);

//XOR
THDR_XOR AX0(A[1], A[0], B[1], B[0], outXor[1], outXor[0]);
THDR_XOR AX1(A[3], A[2], B[3], B[2], outXor[3], outXor[2]);
THDR_XOR AX2(A[5], A[4], B[5], B[4], outXor[5], outXor[4]);
THDR_XOR AX3(A[7], A[6], B[7], B[6], outXor[7], outXor[6]);
THDR_XOR AX4(A[9], A[8], B[9], B[8], outXor[9], outXor[8]);

//AND
THDR_AND A0(A[1], A[0], B[1], B[0], outAnd[1], outAnd[0]);
THDR_AND A1(A[3], A[2], B[3], B[2], outAnd[3], outAnd[2]);
THDR_AND A2(A[5], A[4], B[5], B[4], outAnd[5], outAnd[4]);
THDR_AND A3(A[7], A[6], B[7], B[6], outAnd[7], outAnd[6]);
THDR_AND A4(A[9], A[8], B[9], B[8], outAnd[9], outAnd[8]);

//Neg Detector
num_negative_detector negDetector(outSumSub[9:8], Overflow, Sel0, Sel1, Neg);

//Zero Detector
zeroDetector zero(Out, Zero);

//Over Detector
overDetector over(A[9:8], B[9:8], outSumSub[9:8], Sel0, Sel1, Overflow);

//wire [1:0] signalB, outOver_t, outOver_f;
//wire [9:0] outOverflow;

//selector 
MUX4to1_NCL muxOut0(Sel0[1], Sel0[0], Sel1[1], Sel1[0], outSumSub[1], outSumSub[0], outSumSub[1], outSumSub[0], outXor[1], outXor[0], outAnd[1], outAnd[0], Out[1], Out[0]);
MUX4to1_NCL muxOut1(Sel0[1], Sel0[0], Sel1[1], Sel1[0], outSumSub[3], outSumSub[2], outSumSub[3], outSumSub[2], outXor[3], outXor[2], outAnd[3], outAnd[2], Out[3], Out[2]);
MUX4to1_NCL muxOut2(Sel0[1], Sel0[0], Sel1[1], Sel1[0], outSumSub[5], outSumSub[4], outSumSub[5], outSumSub[4], outXor[5], outXor[4], outAnd[5], outAnd[4], Out[5], Out[4]);
MUX4to1_NCL muxOut3(Sel0[1], Sel0[0], Sel1[1], Sel1[0], outSumSub[7], outSumSub[6], outSumSub[7], outSumSub[6], outXor[7], outXor[6], outAnd[7], outAnd[6], Out[7], Out[6]);
MUX4to1_NCL muxOut4(Sel0[1], Sel0[0], Sel1[1], Sel1[0], outSumSub[9], outSumSub[8], outSumSub[9], outSumSub[8], outXor[9], outXor[8], outAnd[9], outAnd[8], Out[9], Out[8]);

endmodule