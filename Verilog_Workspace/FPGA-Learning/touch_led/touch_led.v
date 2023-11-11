// Design led_controller with touch button

module touch_led(input sys_clk,   // system clock
                 input sys_rst_n, // reset signal, low active
                 input touch_key, // touch_Key input
                 output reg led); // LED outputs
    
    reg touch_key_d0;
    reg touch_key_d1;
    // reg pos_touch_key;
    
    wire pos_touch_key;
    
    assign pos_touch_key = touch_key_d0 & ~touch_key_d1;
    
    
/*     initial
    begin
        led <= 1'b1;
    end */
    
    // hit 2 clocks
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            touch_key_d0 <= 1'b0;
            touch_key_d1 <= 1'b0;
        end
        else begin
            touch_key_d0 <= touch_key;
            touch_key_d1 <= touch_key_d0;
        end
    end
    
    // Generate pos_touch_key
    // always @(*) begin
    //     if (touch_key_d0 & ~touch_key_d1)
    //         pos_touch_key = 1'b1;
    //     else
    //         pos_touch_key = 1'b0;
    // end
    
    // if catch posedge of pos_touch_key, revert led
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            led <= 1'b1;
        else if (pos_touch_key)
            led <= ~led;
        else
            ;
    end
    
endmodule
    
    
    
    
    
    
