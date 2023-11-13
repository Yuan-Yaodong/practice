// Design key_debounce module, to generate key_filter signal
module key_debounce(input sys_clk,          // system clock
                    input sys_rst_n,        // reset signal, low active
                    input key,              // key input
                    output reg key_filter); // key_filter output
    
    reg key_d0;
    reg key_d1;
    reg [19:0] cnt;
    
    
    parameter T = 20'd1_000_000;           // if the signal lasts more than 20ms, it is valid
    
    // generate key_d0 and key_d1
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            key_d0 <= 1'b1;
            key_d1 <= 1'b1;
        end
        else begin
            key_d0 <= key;
            key_d1 <= key_d0;
        end
    end
    
    
    // cnt decrease from T to 0, to count 1,000,000 cycles (20ms)
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt <= 20'd0;
        else if (key_d0 != key_d1)
            cnt <= T;
        else if (cnt > 20'd0)
            cnt <= cnt - 20'd1;
        else
            cnt <= 20'd0;
    end
    
    // generate key_filter
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            key_filter <= 1'b1;
        else if (cnt == 20'd1)
            key_filter <= key_d1;       // keep with key_d1, to emilinate metastability
        else
            key_filter <= key_filter;
    end
    
endmodule
