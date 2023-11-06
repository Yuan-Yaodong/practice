`timescale 1ns / 1ns  // 单位/精度
module tb_8bitCounter();

  reg clk;        // 时钟信号
  reg rst_n;      // 复位信号
  wire [7:0] count; // 计数器输出

  // 时钟生成器
  always begin
    #5 clk <= ~clk;
  end

  // 初始化输入信号
  initial begin
    $monitor("%t CLK = %b, rst_n = %b, Count = %h", $time, clk, rst_n, count);
    clk <= 0;
    rst_n <= 0;

    // 等待时钟稳定
    #10 rst_n <= 1;

    // 模拟计数过程
    #20 rst_n <= 0;
    #10;
    #25 rst_n <= 1;
    #10 rst_n <= 0;
    #10;
    
    // 结束仿真
    $finish;
  end

   initial begin
    $dumpfile("t_counter.vcd");
    $dumpvars(0, tb_8bitCounter);
  end

  // 实例化被测试的计数器模块
  counter dut (
    .clk(clk),
    .rst_n(rst_n),
    .count(count)
  );

endmodule
