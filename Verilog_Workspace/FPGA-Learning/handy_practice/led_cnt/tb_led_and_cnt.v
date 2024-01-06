//~ `New testbench
`timescale  1ns / 1ns 

module tb_led_and_cnt;

// led_and_cnt Parameters
parameter PERIOD  = 20;


// led_and_cnt Inputs
reg   sys_clk                              = 0 ;
reg   rst_n                                = 0 ;

// led_and_cnt Outputs
wire  led                                  ;


initial
begin
    forever #(PERIOD/2)  sys_clk=~sys_clk;
end

initial
begin
    #(PERIOD*10) rst_n  =  1;
    
end

led_and_cnt  u_led_and_cnt (
    .sys_clk                 ( sys_clk   ),
    .rst_n                   ( rst_n     ),

    .led                     ( led       )
);


endmodule