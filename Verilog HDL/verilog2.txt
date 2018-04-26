module p320b (A,B,C,D,F);
output F;
input A,B,C,D;
wire wcd,wcdb,wcdba,wbc2;
nand Gcd (wcd,C,D);
or Gcdb ( wcdb,B,~ wcd );
nand Gcdba ( wcdba,wcdb,A);
nand Gbc2 ( wbc2,B,~ C);
or Gf (F,~ wcdba, ~ wbc2);
endmodule
