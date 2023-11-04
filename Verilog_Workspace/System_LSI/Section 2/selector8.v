//Design 2-3

module selector8 (A, B, SEL, Y);
  input  [7:0] A, B;
  input  SEL;
  output [7:0] Y;    // 8-bit output
  reg [7:0] Y;
  


  always @(A or B or SEL) 
    if (SEL == 1'b0)
      Y = A;
     else
      Y = B;

endmodule
