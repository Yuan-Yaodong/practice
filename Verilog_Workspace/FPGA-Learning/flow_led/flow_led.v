// Design 4-bit flow led
module flow_led(input sys_clk,         // system clock
                input sys_rst_n,       // reset signal, low active
                output reg [3:0] led);
    
    reg [24:0] cnt;
    
    
    // count every 0.5s
    
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt <= 25'd0;
        else if (cnt < (25'd25000000 - 25'd1)) // if cnt < 24999999, set cnt = 0
        //  else if (cnt < (25'd25 - 25'd1)) // if cnt < 24999999, set cnt = 0
            cnt <= cnt + 25'd1;
        else
            cnt <= 25'd0;
    end
    
    // led ÒÆÎ»¿ØÖÆ
    
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            led <= 4'b0001;
        else if (cnt == (25'd25000000 - 25'd1))
        // else if (cnt == (25'd25 - 25'd1))
            led <= {led[2:0],led[3]}; // let the MSB become LSB, and the lower 3bits left shift 3 bits
        else
            ;
    end
endmodule
