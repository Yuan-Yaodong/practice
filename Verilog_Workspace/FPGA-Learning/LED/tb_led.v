//~ `New testbench
`timescale  1ns / 1ps  

module tb_led;

// led Parameters      
parameter PERIOD  = 10;


// led Inputs
reg   key                                  = 0 ;

// led Outputs
wire  led                                  ;




led  u_led (
    .key                     ( key   ),

    .led                     ( led   )
);

initial
begin

    $finish;
end

endmodule