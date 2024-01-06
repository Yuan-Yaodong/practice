module led_and_cnt (input sys_clk,   // 50MHz, 20ns period
                    input rst_n,
                    output reg led);
    
    reg [24:0] cnt;  // led turns every 0.5s, 25, 000, 000 cycles, 25bits
    
    
    parameter CNT_MAX =  25'd25_000_000; // reduced from 25, 000, 000 to 25, just for test easily
    
    always @(posedge sys_clk or negedge rst_n) begin
        if (!rst_n) begin
            led <= 1'b1;
            cnt <= 25'd0;
        end
        else if (cnt < CNT_MAX - 1)
            cnt <= cnt + 1;
        else if (cnt >= CNT_MAX - 1) begin
            led <= ~led;
            cnt <= 25'd0;
        end
            
            end
            
            
            endmodule
