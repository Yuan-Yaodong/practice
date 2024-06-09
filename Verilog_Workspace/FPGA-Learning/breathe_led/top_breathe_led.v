module top_breathe_led(
        input        sys_clk,
        input        sys_rst_n,
        output [2:0] led
    );

    parameter CNT_microSeconds_MAX = 7'd100; //default 2s period
    parameter CNT_milliSeconds_MAX = 10'd1000;
    parameter CNT_Seconds_MAX      = 10'd1000;


    // LED instance, 0.5S period
    breathe_led #(
                    .CNT_microSeconds_MAX (7'd25),
                    .CNT_milliSeconds_MAX (CNT_milliSeconds_MAX),
                    .CNT_Seconds_MAX      (CNT_Seconds_MAX)
                )
                breathe_led_inst_half_Second (
                    .sys_clk   (sys_clk),
                    .sys_rst_n (sys_rst_n),
                    .led_out   (led[0])
                );


    // LED instance, 1S period
    breathe_led #(
                    .CNT_microSeconds_MAX (7'd50),
                    .CNT_milliSeconds_MAX (CNT_milliSeconds_MAX),
                    .CNT_Seconds_MAX      (CNT_Seconds_MAX)
                )
                breathe_led_inst_1Second (
                    .sys_clk   (sys_clk),
                    .sys_rst_n (sys_rst_n),
                    .led_out   (led[1])
                );
                
    // LED instance, 2S period (default)
    breathe_led #(
                    .CNT_microSeconds_MAX (CNT_microSeconds_MAX),
                    .CNT_milliSeconds_MAX (CNT_milliSeconds_MAX),
                    .CNT_Seconds_MAX      (CNT_Seconds_MAX)
                )
                breathe_led_inst_2Second (
                    .sys_clk   (sys_clk),
                    .sys_rst_n (sys_rst_n),
                    .led_out   (led[2])
                );

endmodule
