//~ `New testbench
`timescale  1ns / 1ns

module tb_vending_machine;

    // vending_machine Parameters
    parameter PERIOD  = 10;


    // vending_machine Inputs

    reg   clk                                  = 0 ;
    reg   init                                 = 0 ;
    reg   rst                                  = 0 ;
    reg   input10                              = 0 ;
    reg   input50                              = 0 ;
    reg   inputa0                              = 0 ;

    // vending_machine Outputs
    wire  [4:0]  chng                          ;
    wire  can                                  ;


    initial begin
        forever
            #(PERIOD/2)  clk=~clk;
    end

    vending_machine  u_vending_machine (
                         .clk                     ( clk              ),
                         .init                    ( init             ),
                         .rst                     ( rst              ),
                         .input10                 ( input10          ),
                         .input50                 ( input50          ),
                         .inputa0                 ( inputa0          ),
                         .chng                    ( chng             ),
                         .can                     ( can              )
                     );

    initial begin
        $monitor("%t rst=%b input10=%b input50=%b inputa0=%b amount = %d chng= %b can=%b",$time, rst, input10, input50, inputa0, u_vending_machine.amount, chng, can);

        #1 rst = 1; // start

        #(2*PERIOD) input10 = 1;
        #1          input10 = 0; // add 10 yen coin

        #(3*PERIOD) input50 = 1;
        #1          input50 = 0; // add 50 yen coin

        #(3*PERIOD) input50 = 1;
        #1          input50 = 0; // add 50 yen coin

        #(3*PERIOD) input10 = 1; // add 10 yen coin
        #2          input10 = 0; // add 10 yen coin
        #(4*PERIOD)

        #2 rst = 0;
        #(4*PERIOD)    
           rst = 1;


        #(5*PERIOD) inputa0 = 1; 
        #1          inputa0 = 0; // add 100 yen coin

        #(5*PERIOD) inputa0 = 1; 
        #10         inputa0 = 0; // add 100 yen coin
        #(4*PERIOD)

        #2 rst = 0;
        #(4*PERIOD)    
           rst = 1;
        #(4*PERIOD)
        $finish;
    end

endmodule
