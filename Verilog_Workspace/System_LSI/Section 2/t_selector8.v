// Test Pattern 2-3
`timescale 1ns/10ps
module t_selector;

  wire [7:0] Y;
  reg [7:0] A, B;
  reg SEL;

  initial 
  begin
    $monitor("%t A=%b B=%b SEL=%b Y=%b",$time, A, B, SEL, Y);
     A <= 8'b10101010;
     B <= 8'b01010101;
     SEL <= 1'b0;

    #10 SEL <= 1'b1;
    #10 B <= 8'b11111111;
    #10 SEL <= 1'b0;
    #10 A <= 8'b00000000;
    #10
    $finish;    
  end
  selector8 sel(A, B, SEL ,Y);
    
endmodule
