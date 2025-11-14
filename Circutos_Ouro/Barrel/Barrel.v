module Barrel(A0_t, A0_f, A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, sra_t, sra_f, rotate_t, rotate_f, shift1_t, shift1_f, shift0_t, shift0_f, value_t, value_f,
				   out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f);

input A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, A0_t, A0_f, sra_t, sra_f, rotate_t, rotate_f, shift1_t, shift1_f, shift0_t, shift0_f, value_t, value_f;

output out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f;

wire 		  outMux_sra_t, outMux_sra_f, outMux_router2_t, outMux_router2_f;
wire [1:0] outMux_router1_t, outMux_router1_f;
wire [3:0] outMux_shifter1_t, outMux_shifter1_f, outMux_shifter2_t, outMux_shifter2_f;

//value shifter
MUX2to1_NCL MUX_sra(sra_t, sra_f, A3_t, A3_f, value_t, value_f, outMux_sra_t, outMux_sra_f);

//first routers
MUX2to1_NCL MUX_router1_1(rotate_t, rotate_f, A1_t, A1_f, outMux_sra_t, outMux_sra_f, outMux_router1_t[0], outMux_router1_f[0]);
MUX2to1_NCL MUX_router1_2(rotate_t, rotate_f, A0_t, A0_f, outMux_sra_t, outMux_sra_f, outMux_router1_t[1], outMux_router1_f[1]);


//first shifters
MUX2to1_NCL MUX_shifter1_1(shift1_t, shift1_f, outMux_router1_t[0], outMux_router1_f[0], A3_t, A3_f, outMux_shifter1_t[0], outMux_shifter1_f[0]);
MUX2to1_NCL MUX_shifter1_2(shift1_t, shift1_f, outMux_router1_t[1], outMux_router1_f[1], A2_t, A2_f, outMux_shifter1_t[1], outMux_shifter1_f[1]);
MUX2to1_NCL MUX_shifter1_3(shift1_t, shift1_f, A3_t, A3_f, A1_t, A1_f, outMux_shifter1_t[2], outMux_shifter1_f[2]);
MUX2to1_NCL MUX_shifter1_4(shift1_t, shift1_f, A2_t, A2_f, A0_t, A0_f, outMux_shifter1_t[3], outMux_shifter1_f[3]);

//second router
MUX2to1_NCL MUX_router2_1(rotate_t, rotate_f, outMux_shifter1_t[3], outMux_shifter1_f[3], outMux_sra_t, outMux_sra_f, outMux_router2_t, outMux_router2_f);


//second shifters
MUX2to1_NCL MUX_shifter2_1(shift0_t, shift0_f, outMux_router2_t, outMux_router2_f, outMux_shifter1_t[0], outMux_shifter1_f[0], out3_t, out3_f);
MUX2to1_NCL MUX_shifter2_2(shift0_t, shift0_f, outMux_shifter1_t[0], outMux_shifter1_f[0], outMux_shifter1_t[1], outMux_shifter1_f[1], out2_t, out2_f);
MUX2to1_NCL MUX_shifter2_3(shift0_t, shift0_f, outMux_shifter1_t[1], outMux_shifter1_f[1], outMux_shifter1_t[2], outMux_shifter1_f[2], out1_t, out1_f);
MUX2to1_NCL MUX_shifter2_4(shift0_t, shift0_f, outMux_shifter1_t[2], outMux_shifter1_f[2], outMux_shifter1_t[3], outMux_shifter1_f[3], out0_t, out0_f);

endmodule
