//~ `New testbench
`timescale  1ns / 1ns

module tb_touch_led;
    
    // touch_led Parameters
    parameter PERIOD = 20;
    
    
    // touch_led Inputs
    reg   sys_clk   = 0 ;
    reg   sys_rst_n = 0 ;
    reg   touch_key = 0 ;
    
    // touch_led Outputs
    wire  led                                  ;
    
    
    initial
    begin
        forever #(PERIOD/2)  sys_clk = ~sys_clk;
    end
    
    
    touch_led  u_touch_led (
    .sys_clk                 (sys_clk),
    .sys_rst_n               (sys_rst_n),
    .touch_key               (touch_key),
    
    .led                     (led)
    );
    
    initial
    begin
        #40
        sys_rst_n <= 1'b1;
        #25
        touch_key <= 1'b1;
        #66
        touch_key <= 1'b0;
        #40
        touch_key <= 1'b1;
        #50
        touch_key <= 1'b0;
        #200
        
        $finish;
    end
    
endmodule
