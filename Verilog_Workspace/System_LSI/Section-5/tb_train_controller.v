// Test pattern E-5-1
`timescale 1ns / 10ps
module tb_train_controller;
   reg clk, rst_n, S1, S2, S3, S4;
   wire SW1, SW2;
   wire [1:0] DA, DB;

  // Clock
  initial clk = 0;
  always
    #5 clk = ~clk;

  initial
    begin
      $monitor("%t clk=%b, rst_n=%b, sw1=%b, sw2=%b, da10=%b, db10=%b, S1 = %b, S2 = %b, S3 = %b, S4 = %b, curr_st = %b", 
               $time, clk, rst_n, SW1, SW2, DA, DB, S1, S2, S3, S4, t_instance.curr_st);
      rst_n <= 1; S1 <=0; S2 <=0; S3 <=0; S4 <=0;
      #10 rst_n <= 0;
      #10 rst_n <= 1;
      #20 S1 <= 1; 
      #10 S1 <= 0; S2 <= 1; 
      #10 S2 <= 0; S4 <= 1;
      #10 S4 <= 0;
      #10 S3 <= 1;
      #10 S2 <= 1; S3 <= 0;
      #10 S1 <= 1; S2 <= 0;
      #10 S1 <= 0; S3 <= 1;
      #10 S3 <= 0; S4 <= 1;
      #10 S4 <= 0;
      #10
      $finish;
    end

   train_controller t_instance(clk, rst_n, S1, S2, S3, S4, SW1, SW2, DA, DB);
   
endmodule