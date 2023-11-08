// Test pattern 4-1
`timescale 1ns/10ps
module t_count4;
     wire [3:0] Y;
     reg CTL, clock, reset;

  // Clock
  initial clock = 0;
  always
    #5 clock = ~clock;

  initial
    begin
      $monitor("%t CTL = %b, Clock = %b, Y=%b", 
               $time, CTL, clock, Y);
      CTL <= 0; reset <= 1;
      #10 reset <= 0;
      #10 reset <= 1;
      #200
      #10 CTL <= 1;
      #30
      
      $finish;
    end

  count4 count(Y,CTL,clock,reset);

endmodule
