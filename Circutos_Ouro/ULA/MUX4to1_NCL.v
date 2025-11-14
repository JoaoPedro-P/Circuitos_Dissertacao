module MUX4to1_NCL(sel0_t, sel0_f, sel1_t, sel1_f, A0_t, A0_f, A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, out_t, out_f);

input sel0_t, sel0_f, sel1_t, sel1_f, A0_t, A0_f, A1_t, A1_f, A2_t, A2_f, A3_t, A3_f;
output out_t, out_f;

wire [1:0] outMux_t, outMux_f;

MUX2to1_NCL Mux0(sel0_t, sel0_f, A1_t, A1_f, A0_t, A0_f, outMux_t[0], outMux_f[0]);
MUX2to1_NCL Mux1(sel0_t, sel0_f, A3_t, A3_f, A2_t, A2_f, outMux_t[1], outMux_f[1]);

MUX2to1_NCL Mux2(sel1_t, sel1_f, outMux_t[1], outMux_f[1], outMux_t[0], outMux_f[0], out_t, out_f);

endmodule