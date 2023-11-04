`timescale  1ns/1ns   // 单位/精度

module tb_led();

  reg    key;
  wire   led;
  
  initial begin
     $monitor("%t key=%b led=%b",$time, key, led);
    key <= 1'b1;
    #200           // 延迟语句
    key <= 1'b0;
    #500           // 延迟语句
    key <= 1'b1;
    #1000
    key <= 1'b0;
    #1000
    key <= 1'b1;

  end

led u_led(
  .key (key),
  .led (led)
);
  
endmodule






