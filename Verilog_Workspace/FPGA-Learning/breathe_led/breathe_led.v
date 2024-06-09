module breathe_led (
        input sys_clk, // system clock 50MHz, 20ns,
        input sys_rst_n,
        output reg led_out
    );

    parameter  CNT_microSeconds_MAX = 7'd100; // define the parameter for the counter
    parameter  CNT_milliSeconds_MAX = 10'd1000;
    parameter  CNT_Seconds_MAX = 10'd1000;

    // define the counter
    reg [6:0] cnt_us; // a counter for us, 50MHz, 20ns, 0~99;
    reg [9:0] cnt_Ms; // a counter for Ms, 0~999;
    reg [9:0] cnt_s; // a counter for s, 0~999;

    reg inc_dec_flag; // flag to control the direction of the led, 1'b0 for increase, 1'b1 for decrease;


    // cnt_us counter
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt_us <= 7'b0;
        else if(cnt_us == CNT_microSeconds_MAX - 7'b1) // after the counter = 99, reset it to 0
            cnt_us <= 7'b0;
        else
            cnt_us <= cnt_us + 7'b1;
    end

    // cnt_Ms counter
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt_Ms <= 10'b0;
        else if((cnt_us == CNT_microSeconds_MAX - 7'b1) && (cnt_Ms == CNT_milliSeconds_MAX - 10'b1))
            cnt_Ms <= 10'b0;
        else if(cnt_us == CNT_microSeconds_MAX - 7'b1)
            cnt_Ms <= cnt_Ms + 10'b1;
        else
            cnt_Ms <= cnt_Ms;
    end

    // cnt_s counter
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt_s <= 10'b0;
        else if((cnt_us == CNT_microSeconds_MAX - 7'b1) && (cnt_Ms == CNT_milliSeconds_MAX - 10'b1) && (cnt_s == CNT_Seconds_MAX - 10'b1))
            cnt_s <= 10'b0; // every 2S, reset the counter
        else if ((cnt_us == CNT_microSeconds_MAX - 7'b1) && (cnt_Ms == CNT_milliSeconds_MAX - 10'b1))
            cnt_s <= cnt_s + 10'b1;
        else
            cnt_s <= cnt_s;
    end


    // inc_dec_flag control logic
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            inc_dec_flag <= 1'b0;
        else if((cnt_us == CNT_microSeconds_MAX - 7'b1) && (cnt_Ms == CNT_milliSeconds_MAX - 10'b1) && (cnt_s == CNT_Seconds_MAX - 10'b1))
            inc_dec_flag <= ~inc_dec_flag; // every 2S, change the direction of the led
        else
            inc_dec_flag <= inc_dec_flag;
    end

    // led control logic
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            led_out <= 1'b0;
        else if((inc_dec_flag == 1'b0) && (cnt_Ms <= cnt_s))
            led_out <= 1'b1; // when increasing, 1's high, 999's low
        else if((inc_dec_flag == 1'b1) && (cnt_Ms >= cnt_s))
            led_out <= 1'b1; // when decreasing, 1000's high, finally 1's high, 999's low
            else
            led_out <= 1'b0; // when cnt_Ms < cnt_s, 1's low, 999's high
    end


endmodule //breathe_led
