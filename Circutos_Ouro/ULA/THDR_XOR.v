module THDR_XOR(A_t, A_f, B_t, B_f, out_t, out_f);

input A_t, A_f, B_t,B_f;
output out_t, out_f;

THXor G0(A_t, B_f, B_t, A_f, out_t);
THXor G1(A_t, B_t, A_f, B_f, out_f);

endmodule