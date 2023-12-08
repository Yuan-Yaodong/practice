// Cal_top: Calculator top module
module Caltop(sys_clk,
               rst_n,
               Input,
               ce,
               ac,
               plus,
               minus,
               mul,
               div,
               square,
               equal,                  
               sign,
               led_high,
               led_middle_6,
               led_middle_5,
               led_middle_4,
               led_middle_3,
               led_middle_2,
               led_middle_1,
               led_low,
               overflow,
               state,
               regA,
               regB,
               count,
               add_or_sub_or_mul_or_div_or_sqr);

    input plus, minus, mul, div, square, equal, ce, ac, rst_n, sys_clk;
    input [9:0] Input;
    output overflow, sign;
    output [7:0] led_high, led_middle_6, led_middle_5, led_middle_4, led_middle_3, led_middle_2, led_middle_1, led_low;
    
    
    // for Debugging
    output [1:0] state; // show Decimal, OPE, HALT
    output [27:0] regB; // -99,980,001 ~ 99,980,001 for 28 bits
    output [14:0] regA; // 0 ~ 9999 for 15 bits
    output [2:0] count; // 3 bits for counting how many digits you have input (0~3)
    output [2:0] add_or_sub_or_mul_or_div_or_sqr; // 0: add, 1: sub, 2: mul, 3: div, 4: sqr
    
    
    wire plusout, minusout, mulout, divout, squareout, equalout, ceout, acout;
    wire [9:0] Input_out;
    wire [27:0] wout;
    
    /*

    Calculate Calculate(Input_out, plusout, minusout, mulout, divout, squareout, recipout, equalout, sys_clk, rst_n,
    ceout, acout, sign, overflow, wout, state, regA, regB, count,
    add_or_sub_or_mul_or_div_or_sqr);
    */
    
    Calculate  Calculate (
        .input_decimal (Input_out),
        .plus (plusout),
        .minus (minusout),
        .mul (mulout),
        .div (divout),
        .square (squareout),
        .equal (equalout),
        .sys_clk (sys_clk),
        .rst_n (rst_n),
        .ce (ceout),
        .ac (acout),
        .sign (sign),
        .overflow (overflow),
        .out (wout),
        .state (state),
        .regA (regA),
        .regB (regB),
        .count (count),
        .add_or_sub_or_mul_or_div_or_sqr (add_or_sub_or_mul_or_div_or_sqr)
     );

    Bin_led Bin_led(
        .in (wout), 
        .led_low (led_low),
        .led_middle_1(led_middle_1),    
        .led_middle_2(led_middle_2),
        .led_middle_3(led_middle_3),
        .led_middle_4(led_middle_4),
        .led_middle_5(led_middle_5),
        .led_middle_6(led_middle_6),
        .led_high (led_high)
        );
    // wout = output from calculatate module





    syncro syncroce(ceout, ce, sys_clk, rst_n);
    syncro syncroac(acout, ac, sys_clk, rst_n);
    syncro syncropuls(plusout, plus, sys_clk, rst_n);
    syncro syncrominus(minusout, minus, sys_clk, rst_n);
    syncro syncromul(mulout, mul, sys_clk, rst_n);
    syncro syncrodiv(divout, div, sys_clk, rst_n);
    syncro syncrosquare(squareout, square, sys_clk, rst_n);
    syncro syncroequal(equalout, equal, sys_clk, rst_n);
    
    syncro10 syncroInput(Input_out, Input, sys_clk, rst_n);
    
endmodule
