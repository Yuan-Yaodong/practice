// Design beep module
module key_beep(
    input sys_clk, // system clock
    input sys_rst_n, // reset signal, low active
    input key_filter, // key input
    output reg beep // beep output
    );
    
    reg key_filter_d0;
    
    wire neg_key_filter;
    
    assign neg_key_filter = ~key_filter & key_filter_d0; // get negedge of key_filter, last 1 clock
    
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            key_filter_d0 <= 1'b1;
        else
            key_filter_d0 <= key_filter;
    end
    
    // beep control logic
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            beep <= 1'b0;
        else if (neg_key_filter)
            beep <= ~beep;
        else
            beep <= beep;
    end
    
endmodule
