module breathe_led (
        input sys_clk, // system clock 50MHz, 20ns,
        input sys_rst_n,
        output reg led
    );

    parameter  CNT_2US_MAX = 7'd100; // define the parameter for the counter
    parameter  CNT_2MS_MAX = 10'd1000;
    parameter  CNT_2S_MAX = 10'd1000;

    // define the counter
    reg [6:0] cnt_2us; // a counter for 2us, 50MHz, 20ns, 0~99;
    reg [9:0] cnt_2Ms; // a counter for 2Ms, 0~999;
    reg [9:0] cnt_2s; // a counter for 2s, 0~999;

    reg inc_dec_flag; // flag to control the direction of the led, 1'b0 for increase, 1'b1 for decrease;


    // cnt_2us counter
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt_2us <= 7'b0;
        else if(cnt_2us == CNT_2US_MAX - 7'b1) // after the counter = 99, reset it to 0
            cnt_2us <= 7'b0;
        else
            cnt_2us <= cnt_2us + 7'b1;
    end

    // cnt_2Ms counter
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt_2Ms <= 10'b0;
        else if((cnt_2us == CNT_2US_MAX - 7'b1) && (cnt_2Ms == CNT_2MS_MAX - 10'b1))
            cnt_2Ms <= 10'b0;
        else if(cnt_2us == CNT_2US_MAX - 7'b1)
            cnt_2Ms <= cnt_2Ms + 10'b1;
        else
            cnt_2Ms <= cnt_2Ms;
    end

    // cnt_2s counter
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt_2s <= 10'b0;
        else if((cnt_2us == CNT_2US_MAX - 7'b1) && (cnt_2Ms == CNT_2MS_MAX - 10'b1) && (cnt_2s == CNT_2S_MAX - 10'b1))
            cnt_2s <= 10'b0; // every 2S, reset the counter
        else if ((cnt_2us == CNT_2US_MAX - 7'b1) && (cnt_2Ms == CNT_2MS_MAX - 10'b1))
            cnt_2s <= cnt_2s + 10'b1;
        else
            cnt_2s <= cnt_2s;
    end


    // inc_dec_flag control logic
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            inc_dec_flag <= 1'b0;
        else if((cnt_2us == CNT_2US_MAX - 7'b1) && (cnt_2Ms == CNT_2MS_MAX - 10'b1) && (cnt_2s == CNT_2S_MAX - 10'b1))
            inc_dec_flag <= ~inc_dec_flag; // every 2S, change the direction of the led
        else
            inc_dec_flag <= inc_dec_flag;
    end

    // led control logic
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            led <= 1'b0;
        else if((inc_dec_flag == 1'b0) && (cnt_2Ms <= cnt_2s))
            led <= 1'b1; // when increasing, 1's high, 999's low
        else if((inc_dec_flag == 1'b1) && (cnt_2Ms >= cnt_2s))
            led <= 1'b1; // when decreasing, 1000's high, finally 1's high, 999's low
        else
            led <= 1'b0;
    end


endmodule //breathe_led
