module Barrel(A0, A1, A2, A3, sra, rotate, shift1, shift0, value, out0, out1, out2, out3);

input [1:0] A0, A1, A2, A3, sra, rotate, shift1, shift0, value;

output[1:0] out0, out1, out2, out3;

wire 		  outMux_sra_t, outMux_sra_f, outMux_router2_t, outMux_router2_f, selTrojanTree, outFinalTrojanTree_t, outFinalTrojanTree_f, selTrojanTree_t, selTrojanTree_f;
wire [1:0] outMux_router1_t, outMux_router1_f, outTrojan, outTrojanTree;
wire [3:0] outMux_shifter1_t, outMux_shifter1_f, outTrojan1, outTrojanAnds;

//value shifter
MUX2to1_NCL MUX_sra(sra[1], sra[0], A3[1], A3[0], value[1], value[0], outMux_sra_t, outMux_sra_f);

//first routers
MUX2to1_NCL MUX_router1_1(rotate[1], rotate[0], A1[1], A1[0], outMux_sra_t, outMux_sra_f, outMux_router1_t[0], outMux_router1_f[0]);
MUX2to1_NCL MUX_router1_2(rotate[1], rotate[0], A0[1], A0[0], outMux_sra_t, outMux_sra_f, outMux_router1_t[1], outMux_router1_f[1]);


//first shifters
MUX2to1_NCL MUX_shifter1_1(shift1[1], shift1[0], outMux_router1_t[0], outMux_router1_f[0], A3[1], A3[0], outMux_shifter1_t[0], outMux_shifter1_f[0]);
MUX2to1_NCL MUX_shifter1_3(shift1[1], shift1[0], A3[1], A3[0], A1[1], A1[0], outMux_shifter1_t[2], outMux_shifter1_f[2]);
MUX2to1_NCL MUX_shifter1_4(shift1[1], shift1[0], A2[1], A2[0], A0[1], A0[0], outMux_shifter1_t[3], outMux_shifter1_f[3]);

//trojan first shifter
THDR_AND trojan01(shift1[0], shift1[1], shift0[0], shift0[1], outTrojan1[1], outTrojan1[0]);
THDR_AND trojan02(outTrojan1[1], outTrojan1[0], rotate[1], rotate[0], outTrojan1[3], outTrojan1[2]);
THDR_OR OutTrojan(outTrojan1[3], outTrojan1[2], shift1[1], shift1[0], outTrojan[1], outTrojan[0]);

MUX2to1_NCL MUX_shifter1_2(outTrojan[1], outTrojan[0], outMux_router1_t[1], outMux_router1_f[1], A2[1], A2[0], outMux_shifter1_t[1], outMux_shifter1_f[1]);


//second router
MUX2to1_NCL MUX_router2_1(rotate[1], rotate[0], outMux_shifter1_t[3], outMux_shifter1_f[3], outMux_sra_t, outMux_sra_f, outMux_router2_t, outMux_router2_f);


//second shifters
MUX2to1_NCL MUX_shifter2_1(shift0[1], shift0[0], outMux_router2_t, outMux_router2_f, outMux_shifter1_t[0], outMux_shifter1_f[0], out3[1], out3[0]);

MUX2to1_NCL MUX_shifter2_3(shift0[1], shift0[0], outMux_shifter1_t[1], outMux_shifter1_f[1], outMux_shifter1_t[2], outMux_shifter1_f[2], out1[1], out1[0]);
MUX2to1_NCL MUX_shifter2_4(shift0[1], shift0[0], outMux_shifter1_t[2], outMux_shifter1_f[2], outMux_shifter1_t[3], outMux_shifter1_f[3], out0[1], out0[0]);

//trojan second shifter
THDR_AND trojan03(outMux_shifter1_t[0], outMux_shifter1_f[0], outMux_shifter1_t[1], outMux_shifter1_f[1], outTrojanAnds[1], outTrojanAnds[0]);
THDR_AND trojan04(outMux_shifter1_t[2], outMux_shifter1_f[2], outMux_shifter1_t[3], outMux_shifter1_f[3], outTrojanAnds[3], outTrojanAnds[2]);
THDR_AND trojan05(outTrojanAnds[3], outTrojanAnds[2], outTrojanAnds[1], outTrojanAnds[0], selTrojanTree_t, selTrojanTree_f);

MUX2to1_NCL MUX_shifter_trojan(selTrojanTree_t, selTrojanTree_f, outMux_sra_t, outMux_sra_f, outMux_shifter1_t[0], outMux_shifter1_f[0], outTrojanTree[1], outTrojanTree[0]);
MUX2to1_NCL MUX_shifter_trojan1(selTrojanTree_t, selTrojanTree_f, outTrojanTree[1], outTrojanTree[0], outMux_shifter1_t[0], outMux_shifter1_f[0], outFinalTrojanTree_t, outFinalTrojanTree_f);
MUX2to1_NCL MUX_shifter2_2(shift0[1], shift0[0], outFinalTrojanTree_t, outFinalTrojanTree_f, outMux_shifter1_t[1], outMux_shifter1_f[1], out2[1], out2[0]);




endmodule
