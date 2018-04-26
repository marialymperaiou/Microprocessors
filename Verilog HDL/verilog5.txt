module p324 (A,B,C,D,E,F);
output F;
input A,B,C,D,E;
wire wab,wcd;
nor Gab ( wab,A,B);
nor Gcd ( wcd,C,D);
and Gf (F,E,~ wab, ~ wcd );
endmodule
