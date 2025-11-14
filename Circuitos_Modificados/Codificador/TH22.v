module TH22(A, B, out);

input A, B;
output out;

wire hysteresis = out & (A | B);
assign out = (A & B) | hysteresis;

endmodule