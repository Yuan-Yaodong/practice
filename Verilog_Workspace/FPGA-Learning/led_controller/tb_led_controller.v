`timescale 1ns/1ns

module tb_led_controller;
    
    // led_controller Parameters
    parameter PERIOD  = 20;
    parameter CNT_MAX = 26'd10;    // count every 200ns, clock is 50MHz
    
    // led_controller Inputs
    reg   sys_clk;
    reg   sys_rst_n;
    reg [1:0] key;
    
    wire [1:0] led;
    
    initial
    begin
        forever #(PERIOD/2)  sys_clk = ~sys_clk;
    end
    
    
    led_controller #(
    .CNT_MAX (CNT_MAX))
    u_led_controller (
    .sys_clk                 (sys_clk),
    .sys_rst_n               (sys_rst_n),
    .key                     (key        [1:0]),
    .led                     (led        [1:0])
    );
    
    initial
    begin
        sys_clk                   <= 1'b0;
        sys_rst_n                 <= 1'b0;
        key                       <= 2'b11;
        u_led_controller.led_flag <= 1'b0;
        #200
        sys_rst_n <= 1'b1;
        #1000
        key <= 2'b10;
        #1000
        key <= 2'b01;
        #1000
        key <= 2'b00;
        #1000
        $finish;
        
    end
    
endmodule
