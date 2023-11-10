`timescale 1ns/1ns

module tb_led_controller;
    
    // led_controller Parameters
    parameter PERIOD = 20;
    
    // led_controller Inputs
    reg   sys_clk;
    reg   sys_rst_n;
    reg [1:0] key;
    
    wire [1:0] led;

initial
begin
    forever #(PERIOD/2)  sys_clk = ~sys_clk;
end


led_controller u_led_controller (
    .sys_clk                 ( sys_clk          ),
    .sys_rst_n               ( sys_rst_n        ),
    .key                     ( key        [1:0] ),
    .led                     ( led        [1:0] )
);

initial
begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    key <= 2'b11;
    u_led_controller.led_flag <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
    #1000
    key <= 2'b10;
    #10000
    key <= 2'b01;
    #10000
    key <= 2'b00;
    #10000
    $finish;

end

endmodule