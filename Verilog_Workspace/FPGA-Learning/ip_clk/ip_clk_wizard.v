module ip_clk_wizard (
        input  sys_clk, //50MHz
        input  sys_rst_n, // active low reset
        output clk_100M,
        output clk_100M_180deg,
        output clk_50M,
        output clk_25M
    );

    wire  locked;
    wire  rst_n;

    assign rst_n = sys_rst_n & locked;

    clk_wiz_0 instance_name
              (
                  // Clock out ports
                  .clk_out1(clk_100M),          // output clk_out1, 100 MHz
                  .clk_out2(clk_100M_180deg),   // output clk_out2  100 MHz_180deg
                  .clk_out3(clk_50M),           // output clk_out3  50 MHz
                  .clk_out4(clk_25M),           // output clk_out4  25 MHz
                  // Status and control signals
                  .reset(~sys_rst_n),           // input reset, active high
                  .locked(locked),              // output locked
                  // Clock in ports
                  .clk_in1(sys_clk)             // input clk_in1
              );


endmodule
