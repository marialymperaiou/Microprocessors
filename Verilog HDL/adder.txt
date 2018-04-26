module prog437 (
output [3: 0] S,
output C,
input [3: 0] A, B,
input M
);
wire [3: 0] BxorM;
wire C1, C2, C3, C4;
assign C = C4; 
xor (BxorM[0], B[0], M);
xor (BxorM[1], B[1], M);
xor (BxorM[2], B[2], M);
xor (BxorM[3], B[3], M);
// Instantiate full adders
full_adder FA0 (S[0], C1, A[0], BxorM[0], M);
full_adder FA1 (S[1], C2, A[1], BxorM[1], C1);
full_adder FA2 (S[2], C3, A[2], BxorM[2], C2);
full_adder FA3 (S[3], C4, A[3], BxorM[3], C3);
endmodule

module full_adder (output S, C, input x, y, z); 
wire S1, C1, C2;
// instantiate half adders
half_adder HA1 (S1, C1, x, y);
half_adder HA2 (S, C2, S1, z);
or G1 (C, C2, C1);
endmodule

module half_adder (output S, C, input x, y); 
xor (S, x, y);
and (C, x, y);
endmodule
