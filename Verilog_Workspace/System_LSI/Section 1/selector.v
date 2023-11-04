// Design 1-1
module selector(A, B, SEL, Y);
  output Y;
  input A, B, SEL;
  reg Y;

  always@(A or B or SEL) 
   if (SEL == 1'b0)
      Y = A;
    else
      Y = B;
  endmodule