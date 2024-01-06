// Design top module
module top_key_beep(input sys_clk,   // system clock
                    input sys_rst_n, // reset signal, low active
                    input key,       // key input
                    output beep);    // beep output
    
    wire key_filter;
    
    parameter T = 20'd1_000_000;
    
    key_debounce #(
    .T (T))
    u_key_debounce (
    .sys_clk                 (sys_clk),
    .sys_rst_n               (sys_rst_n),
    .key                     (key),
    .key_filter              (key_filter)
    );
    
    key_beep  u_key_beep (
    .sys_clk                 (sys_clk),
    .sys_rst_n               (sys_rst_n),
    .key_filter              (key_filter),
    .beep                    (beep)
    );
    
    
endmodule
