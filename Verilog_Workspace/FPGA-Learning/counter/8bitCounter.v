module counter (
    input clk,  // 时钟输入
    input rst_n, // 复位输入
    output reg [7:0] count // 8位计数输出
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) // 复位信号为低电平时，将计数器清零
        count <= 8'b0;
    else
        count <= count + 1; // 每个上升沿计数加1
end

endmodule
