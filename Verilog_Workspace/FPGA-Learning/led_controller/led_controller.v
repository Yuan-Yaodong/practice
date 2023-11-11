module led_controller(input sys_clk,         // system clock
                      input sys_rst_n,       // reset signal, low active
                      input [1:0] key,       // Key input
                      output reg [1:0] led); // LED outputs
    
    reg [25:0] cnt;
    reg led_flag;
    
    parameter CNT_MAX = 26'd50000000;

    // count every 1.0s, clock is 50MHz
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt <= 26'd0;
        else if (cnt < (CNT_MAX - 26'd1)) // if cnt > 49999999, set cnt = 0
        //   else if (cnt < (CNT_MAX/1000000 - 26'd1)) // if cnt > 49999999, set cnt = 0
            cnt <= cnt + 26'd1;
        else
            cnt <= 26'd0;
    end
    // led flag switching every 1.0s
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            led_flag <= 1'b0;
        else if (cnt == (CNT_MAX - 26'd1))
        //  else if (cnt == (CNT_MAX/1000000 - 26'd1))
            led_flag <= ~led_flag;
        else
            ;
    end
    // led control logic (based on key and led_flag)
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            led <= 2'b00;
        else begin
            case (key)
                2'b11 : led <= 2'b00;
                2'b10 :                     // key0 is pressed
                if (led_flag == 1'b0)
                    led <= 2'b01;          // if led_flag == 0, led0 is on
                else
                    led <= 2'b10;          // if led_flag == 1, led1 is on
                
                2'b01:                      // key1 is pressed
                if (led_flag == 1'b0)
                    led <= 2'b00;          // if led_flag == 0, all leds are off
                else
                    led           <= 2'b11;
                    default : led <= 2'b00;   // other situations, led is off
                    endcase
                
            end
        end
        
        endmodule
