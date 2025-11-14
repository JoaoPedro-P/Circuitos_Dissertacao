module THDR_AND(A_t, A_f, B_t, B_f, out_t, out_f);

input A_t, A_f, B_t,B_f;
output out_t, out_f;

TH22 G0(A_t, B_t, out_t);
THAnd G1(B_f, A_f, B_t, A_t, out_f);

endmodule