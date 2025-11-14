module zeroDetector(A, out);

input [9:0] A;

output [1:0] out;

wire [5:0] outAnd;

THDR_AND g0(A[0], A[1], A[2], A[3], outAnd[1], outAnd[0]);
THDR_AND g1(A[6], A[7], A[4], A[5], outAnd[3], outAnd[2]);
THDR_AND g2(outAnd[1], outAnd[0], outAnd[3], outAnd[2], outAnd[5], outAnd[4]);
THDR_AND g3(A[8], A[9], outAnd[5], outAnd[4], out[1], out[0]);

endmodule