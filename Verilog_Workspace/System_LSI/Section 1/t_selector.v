// Test Pattern 1-1
`timescale 1ns/10ps
module t_selector;
  wire Y；
  reg A, B, SEL;

  initial 
  begin
    $monitor("%t A=%b B=%b SEL=%b Y=%b",$time, A, B, SEL, Y);
    A <= 0; B <= 0; SEL <= 0;
    #10 A <= 1;
    #10 A <= 0; B <= 1;
    #10 A <= 1; B <= 0; SEL <= 1;
    #10 A <= 0; B <= 1; 
    #10
    $finish;    
  end
  selector sel(A, B, SEL ,Y);
    
endmodule
