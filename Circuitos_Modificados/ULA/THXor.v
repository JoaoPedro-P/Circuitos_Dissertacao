module THXor (A, B, C, D, out);

input A, B, C, D;
output out;

wire hysteresis = out & (A | B | C | D);

assign out = (A & B) | (C & D) | hysteresis;

endmodule