// Test pattern e3-1
`timescale 1ns/10ps
module t_encoder;
  wire [2:0] y;
  reg a0, a1, a2, a3, a4, a5, a6, a7, sel;

  initial 
  begin
    $monitor("%t sel=%b a0=%b a1=%b a2=%b a3=%b a4=%b a5=%b a6=%b a7=%b y=%b",$time, sel, a0, a1, a2, a3, a4, a5, a6, a7, y);
    sel <= 1; a0 <= 0; a1 <= 0; a2 <= 0; a3 <= 0; a4 <= 0; a5 <= 0; a6 <= 0; a7 <= 0;
    #10 a0 <= 1;
    #10 a1 <= 1; a0 <= 0;
    #10 a2 <= 1; a1 <= 0;
    #10 a3 <= 1; a2 <= 0;
    #10 a4 <= 1; a3 <= 0;
    #10 a5 <= 1; a4 <= 0;
    #10 a6 <= 1; a5 <= 0;
    #10 a7 <= 1; a6 <= 0;
    #10 a1 <= 1;
    #10 sel <= 0;
    #10
    $finish;    
  end
  encoder e1(sel, a0, a1, a2, a3, a4, a5, a6, a7, y);

endmodule
