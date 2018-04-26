module prog447a(output F ,input A,B,C,D);
assign F= (  D & (~A) & (~B) )|
          ( (~C)&(~D) & (~A) & B)|
          (  C & D & A & (~B) ) |
           (  1 & A & B);
endmodule
