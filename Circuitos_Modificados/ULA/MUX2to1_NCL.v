module MUX2to1_NCL(sel_t, sel_f, A_t, A_f, B_t, B_f, out_t, out_f);

input A_t, A_f, B_t, B_f, sel_t, sel_f;
output out_t, out_f;

wire [1:0] outAnd_t, outAnd_f;

THDR_AND g0(sel_t, sel_f, A_t, A_f, outAnd_t[0], outAnd_f[0]);
THDR_AND g1(sel_f, sel_t, B_t, B_f, outAnd_t[1], outAnd_f[1]);

THDR_OR g2(outAnd_t[0], outAnd_f[0], outAnd_t[1], outAnd_f[1], out_t, out_f);

endmodule