// Design 2-1
module selector2(A, B, SEL, Y);
  output Y;
  input A, B, SEL;

     and   g1(y1, A, nsel),
           g2(y2, B, SEL);
     or    g3(Y, y1, y2);
     not   g4(nsel, SEL);

  endmodule