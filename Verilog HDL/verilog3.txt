module p321a (A,B,C,D,F);
output F;
input A,B,C,D;
wire wab1,wab2,wab,wcd;
and Gab1 (wab1,A,~ B);
and Gab2 (wab2, ~A,B);
or Gab ( wab,wab1,wab2);
or Gcd (wcd,C, ~ D);
and Gf( F,wab,wcd );
endmodule
