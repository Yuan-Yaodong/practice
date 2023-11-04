// Test pattern 4-3
`timescale 1ns / 10ps
module t_lfsr10;
  reg clock, reset;
  wire Data_out;

  // Clock
  initial clock = 0;
  always
    #5 clock = ~clock;

  initial
    begin
      $monitor("%t Data_out=%b, Data_reg=%b, clock=%b,reset=%b", 
               $time, Data_out, lfsr.Data_reg, clock, reset);
      reset <= 1;
      #10 reset <= 0;
      #10 reset <= 1;
      #300
      $finish;
    end

  lfsr10 lfsr(Data_out, clock, reset);

endmodule
