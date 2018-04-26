module p321b (A,B,C,D,F);
output F;
input A,B,C,D;
wire wab1,wab2,wab,wcd,wf;
nand Gab1 (wab1,A, ~ B);
nand Gab2 ( wab2, ~ A, B);
or Gab ( wab , ~ wab1, ~ wab2);
or Gcd ( wcd,C, ~ D);
nand Gf1 ( wf,wab,wcd);
not Gf2 (F,wf);
endmodule
