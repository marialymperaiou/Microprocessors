module p320a (A,B,C,D,F);
output F;
input A,B,C,D;
wire wcd,wcdb,wcdba,wbc2;
and Gcd (wcd,C,D);
or Gcdb (wcdb,wcd,B);
and Gcdba (wcdba,wcdb,A);
and Gbc2 ( wbc2,B,~ C);
or Gf (F,wcdba,wbc2);
endmodule
