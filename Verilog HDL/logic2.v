module prog447b(output F ,input A,B,C,D);
assign F= ( ( D | ( C & ( ~ D) ) ) & ( ~A) & (~B) ) |
          ( D & ( ~A) & B) |
          ( 1 & A & ( ~ B) ) |
          ( D & A & B) ;
endmodule
