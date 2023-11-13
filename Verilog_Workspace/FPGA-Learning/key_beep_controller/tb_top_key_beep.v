//~ `New testbench
`timescale  1ns / 1ns

module tb_top_key_beep();
    
    // top_key_beep Parameters
    parameter PERIOD = 20           ;
    parameter T      = 20'd10;
    
    // top_key_beep Inputs
    reg   sys_clk   = 0 ;
    reg   sys_rst_n = 0 ;
    reg   key       = 1 ;
    
    // top_key_beep Outputs
    wire  beep                                 ;
    
    
    initial
    begin
        forever #(PERIOD/2)  sys_clk = ~sys_clk;
    end
    
    
    
    top_key_beep #(
    .T (T))
    u_top_key_beep (
    .sys_clk                 (sys_clk),
    .sys_rst_n               (sys_rst_n),
    .key                     (key),
    
    .beep                    (beep)
    );
    
    initial
    begin
        #100 sys_rst_n = 1'b1;
        
        // dirty key shake
        #16 key = 1'b0;
        #40 key  = 1'b1;
        
        // press the key
        #66 key = 1'b0;
        
        // after 300ns, release the key
        #300
        key = 1'b1;
        
        // dirty key shake
        #50 key = 1'b0;
        #12 key = 1'b1;
        #50 key = 1'b0;
        #12 key = 1'b1;
        
        // after 30ns, press the key
        #30
        key = 1'b0;
        
        // after 400ns, release the key
        #400
        key = 1'b1;
        
        // dirty key shake
        #18 key  = 1'b0;
        #50 key   = 1'b1;
        #45 key = 1'b0;
        #31 key = 1'b1;
    //    $finish;
    end
    
endmodule