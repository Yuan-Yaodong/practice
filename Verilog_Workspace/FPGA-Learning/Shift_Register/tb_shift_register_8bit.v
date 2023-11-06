`timescale 1ns / 1ns  // 单位/精度
module tb_shift_register_8bit ();

  reg clk;
  reg reset;
  reg shift_left;
  reg shift_right;
  reg data_in;
  wire [7:0] data;


  // 时钟生成器
  always begin
    #5 clk <= ~clk;
  end

  // 初始化输入信号
  initial begin
    $monitor("%t CLK = %b,Reset = %b,shift_left = %b,shift_right = %b,data_in = %b,Data: %b",
             $time, clk, reset, shift_left, shift_right, data_in, data);

    clk <= 0;
    reset <= 0;
    shift_left <= 0;
    shift_right <= 0;
    data_in <= 0;

    // 等待时钟稳定
    #10 reset <= 1;

    // 输入数据并进行移位操作
    #10 data_in <= 1;
    shift_left <= 1;
    #30 #10 data_in <= 0;
    #20 reset <= 0;
    #20

      // 结束仿真
      $finish;
  end

  initial begin
    $dumpfile("tb_sreg.vcd");
    $dumpvars(0, tb_shift_register_8bit);
  end
  
  // 实例化被测试的移位寄存器模块

  shift_register_8bit t_shift_reg (
      .clk(clk),
      .reset(reset),
      .shift_left(shift_left),
      .shift_right(shift_right),
      .data_in(data_in),
      .data(data)
  );


endmodule
