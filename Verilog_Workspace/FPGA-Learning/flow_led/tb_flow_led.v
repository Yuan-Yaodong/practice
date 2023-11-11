//~ `New testbench
`timescale  1ns / 1ns

module tb_flow_led;

 // flow_led Parameters
 parameter PERIOD  = 20;


// flow_led Inputs
reg   sys_clk                              = 0 ;
reg   sys_rst_n                            = 0 ;

// flow_led Outputs
wire  [3:0]  led                           ;


initial
begin
    forever #(PERIOD/2)  sys_clk = ~sys_clk;
end

/* initial
begin
    #(PERIOD*2) rst_n  =  1;
end */ 

flow_led  u_flow_led (
    .sys_clk                 ( sys_clk          ),
    .sys_rst_n               ( sys_rst_n        ),

    .led                     ( led        [3:0] )
);

initial
begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;

end

endmodule