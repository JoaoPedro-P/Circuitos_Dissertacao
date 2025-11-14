module THDR_OR(A_t, A_f, B_t, B_f, out_t, out_f);

input A_t, A_f, B_t,B_f;
output out_t, out_f;

TH22 G0(A_f, B_f, out_f);
THAnd G1(A_t, B_t, A_f, B_f, out_t);

endmodule
