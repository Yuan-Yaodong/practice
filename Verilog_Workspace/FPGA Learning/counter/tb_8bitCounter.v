module tb_8bitCounter();

  reg clk;        // 时钟信号
  reg reset;      // 复位信号
  wire [7:0] count; // 计数器输出

  // 时钟生成器
  always begin
    #5 clk <= ~clk;
  end

  // 初始化输入信号
  initial begin
    $monitor("%t CLK = %b, Reset = %b, Count = %h", $time, clk, reset, count);
    clk <= 0;
    reset <= 0;

    // 等待时钟稳定
    #10 reset <= 1;

    // 模拟计数过程
    #20 reset <= 0;
    #10;
    #20 reset <= 1;
    #10 reset <= 0;
    #10;
    
    // 结束仿真
    $finish;
  end

  // 实例化被测试的计数器模块
  tb_8bitCounter dut (
    .clk(clk),
    .reset(reset),
    .count(count)
  );

endmodule
