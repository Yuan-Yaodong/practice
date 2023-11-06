module shift_register_8bit(
    input  clk,           // 时钟输入
    input  reset,         // 复位输入
    input  shift_left,    // 左移输入
    input  shift_right,   // 右移输入
    input  data_in,       // 数据输入
    output reg [7:0] data // 8位移位寄存器输出
);


always @(posedge clk or negedge reset) begin
    if (!reset) 
        data <= 8'b0; // 复位时，将寄存器清零
     else  if (shift_left) 
            // 左移操作
            data <= {data[6:0], data_in};
     else if (shift_right) 
            // 右移操作
            data <= {data_in, data[7:1]};
        else
            // 无移位操作，仅更新数据
            data <= data_in;
        end

endmodule
