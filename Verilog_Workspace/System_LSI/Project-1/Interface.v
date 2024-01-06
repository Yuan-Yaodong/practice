// Design Project 1 the calculator

// Interface between top module and FPGA Board

module Interface(sys_clk,
                     rst_n,
                     input_row1,
                     input_row2,
                     input_row3,
                     input_row4,
                     beep,
                     ledA,
                     ledB,
                     ledC,
                     ledD,
                     seg1,
                     seg2,
                     seg3,
                     seg4,
                     seg5,
                     seg6,
                     seg7,
                     seg8);

    input sys_clk, rst_n; // clock and reset
    input [4:0] input_row1, input_row2, input_row3, input_row4; // 5 keys on the calculator each row, totally 4 rows

    output beep; // the beep signal to show if overflow happens
    output [7:0] ledA, ledB, ledC, ledD; //  4 sets of leds in the board, which can be used for debugging
    output [7:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8; // 7-seg leds

    wire [7:0] led_high, led_middle_6, led_middle_5, led_middle_4, led_middle_3, led_middle_2, led_middle_1, led_low;
    wire [9:0] Input; // 10 bits input for saving decimal numbers you input
    wire overflow, sign, ce, ac, plus, minus, mul, div, square, equal;
    // wire square;

    // for Debugging
    wire [1:0] state; // show Decimal, OPE, HALT
    wire [27:0] regB; // -99,980,001 ~ 99,980,001 for 28 bits
    wire [14:0] regA; // 0 ~ 9999 for 15 bits
    wire [2:0] count; // 3 bits for counting how many digits you have input (0~3)
    wire [2:0] add_or_sub_or_mul_or_div_or_sqr;

    // Input assignment
    assign Input[0] = input_row4[0];
    assign Input[1] = input_row3[0];
    assign Input[2] = input_row3[1];
    assign Input[3] = input_row3[2];
    assign Input[4] = input_row2[0];
    assign Input[5] = input_row2[1];
    assign Input[6] = input_row2[2];
    assign Input[7] = input_row1[0];
    assign Input[8] = input_row1[1];
    assign Input[9] = input_row1[2];

    assign plus   = input_row3[3];
    assign minus  = input_row2[3];
    assign mul    = input_row3[4];
    assign div    = input_row2[4];

    assign square = input_row4[2];

    assign ac    = input_row1[3];
    assign ce    = input_row1[4];
    assign equal = input_row4[4];


    // output asignment
    assign beep = overflow ;

    assign ledA = {overflow, sign, count[0], count[1], count[2],
                   add_or_sub_or_mul_or_div_or_sqr[0], add_or_sub_or_mul_or_div_or_sqr[1], add_or_sub_or_mul_or_div_or_sqr[2]};

    assign ledB = {state[0], state[1], regB[0], regB[1], regB[2], regB[3], regB[4], regB[5]}; // since the bits is limited , we can only show 6 bits from regB here

    assign ledC = {regA[0],regA[1],regA[2],regA[3],
                   regA[4],regA[5],regA[6],regA[7]};

    assign ledD = {regA[8],regA[9],regA[10],regA[11],
                   regA[12],regA[13],regA[14], 1'b0};  // I choose to show all 15 bits in regA here



    assign seg1 = led_high;
    assign seg2 = led_middle_6;
    assign seg3 = led_middle_5;
    assign seg4 = led_middle_4;
    assign seg5 = led_middle_3;
    assign seg6 = led_middle_2;
    assign seg7 = led_middle_1;
    assign seg8 = led_low;

    /*
    Caltop Caltop(sys_clk, rst_n, Input, ce, ac, plus, minus, mul, div, square, equal, sign, led_high, led_middle_6, led_middle_5, led_middle_4, led_middle_3, led_middle_2, led_middle_1, led_low, overflow, state, regA, regB, count, add_or_sub_or_mul_or_div_or_sqr);
    */

    Caltop  Caltop (
                .sys_clk(sys_clk),
                .rst_n(rst_n),
                .Input(Input),
                .ce(ce),
                .ac(ac),
                .plus(plus),
                .minus(minus),
                .mul(mul),
                .div(div),
                .square(square),
                .equal(equal),
                .sign(sign),
                .led_high(led_high),
                .led_middle_6(led_middle_6),
                .led_middle_5(led_middle_5),
                .led_middle_4(led_middle_4),
                .led_middle_3(led_middle_3),
                .led_middle_2(led_middle_2),
                .led_middle_1(led_middle_1),
                .led_low(led_low),
                .overflow(overflow),
                .state(state),
                .regA(regA),
                .regB(regB),
                .count(count),
                .add_or_sub_or_mul_or_div_or_sqr(add_or_sub_or_mul_or_div_or_sqr)
            );
endmodule

