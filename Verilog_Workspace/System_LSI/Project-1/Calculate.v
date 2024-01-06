// Calculate: the main module for calculation
`define DECIMAL 0
`define OPE 1
`define HALT 2

// Calc: Calculator main module
module Calculate(input_decimal,
                     plus,
                     minus,
                     mul,
                     div,
                     square,
                     equal,
                     sys_clk,
                     rst_n,
                     ce,
                     ac,
                     sign,
                     overflow,
                     out,
                     state,
                     regA,
                     regB,
                     count,
                     add_or_sub_or_mul_or_div_or_sqr);

    input [9:0] input_decimal;
    input sys_clk, ce, ac, rst_n, plus, minus, mul, div, square, equal;
    output sign, overflow;
    output [27:0] out;

    // for Debugging
    output [1:0] state; // show Decimal, OPE, HALT
    output [27:0] regB; // -99,980,001 ~ 99,980,001 for 28 bits
    output [14:0] regA; // 0 ~ 9999 for 15 bits
    output [2:0] count; // 3 bits for counting how many digits you have input (0~3)
    output [2:0] add_or_sub_or_mul_or_div_or_sqr;

    wire [3:0] d; // for saving the left 1 bit decimial 0~9 ( in binary )
    wire [8:0] alu_out;
    reg  [1:0] state;
    reg  [27:0] regB;
    reg  [14:0] regA;
    reg  [2:0] count;
    reg  [2:0] add_or_sub_or_mul_or_div_or_sqr ;


    function [3:0] dectobin; // convert decimal to binary
        input [9:0] in;
        if (in[9])
            dectobin = 9;
        else if (in[8])
            dectobin = 8;
        else if (in[7])
            dectobin = 7;
        else if (in[6])
            dectobin = 6;
        else if (in[5])
            dectobin = 5;
        else if (in[4])
            dectobin = 4;
        else if (in[3])
            dectobin = 3;
        else if (in[2])
            dectobin = 2;
        else if (in[1])
            dectobin = 1;
        else if (in[0])
            dectobin = 0;
    endfunction

    assign d = dectobin(input_decimal); // d is binary

    always @(posedge sys_clk or negedge rst_n) begin
        if (!rst_n) begin
            regA   <= 0;
            regB   <= 0;
            count  <= 0;
            add_or_sub_or_mul_or_div_or_sqr <= 0;
            state  <= `DECIMAL;
        end
        else if (ac) // all clear, the same function as reset
        begin
            regA   <= 0;
            regB   <= 0;
            count  <= 0;
            add_or_sub_or_mul_or_div_or_sqr <= 0;
            state  <= `DECIMAL;
        end
        else begin
            case (state)
                `DECIMAL : begin
                    if ((input_decimal != 0) && (count < 4)) // count starts from 0 to 3, if count = 4, it means you have input 4 digits, it is illegal, cannot be recorded.
                    begin
                        count <= count + 1;
                        regA  <= regA * 10 + d;
                    end
                    else if (ce) begin
                        regA  <= 0;
                        count <= 0; // just clean the operator,
                    end
                    else if (plus || minus || mul || div || equal || square ) begin
                        case (add_or_sub_or_mul_or_div_or_sqr)
                            0:
                                regB <= regB + regA; // add
                            1:
                                regB <= regB - regA; // sub
                            2:
                                regB <= regB * regA; // mul
                            3:
                                if (regA != 0)
                                    regB <= regB / regA;  // div
                            4:
                                regB <= regA * regA; // sqr
                        endcase
                        if (plus)
                            add_or_sub_or_mul_or_div_or_sqr <= 0;
                        else if (minus)
                            add_or_sub_or_mul_or_div_or_sqr <= 1;
                        else if (mul)
                            add_or_sub_or_mul_or_div_or_sqr <= 2;
                        else if (div)
                            add_or_sub_or_mul_or_div_or_sqr <= 3;
                        else if (square)
                            add_or_sub_or_mul_or_div_or_sqr <= 4;

                        state  <= `OPE; // state for showing result
                    end
                end
                `OPE:
                    if (((regB[27] == 1)&&(regB<168455455))  // 2's Complement  for MIN (-99,980,001)
                            || ((regB[27] == 0)&&(regB>99980001))) // MAX 9999 x 9999 = 99,980,001
                        state <= `HALT;
                    else if (input_decimal) begin
                        regA  <= d;
                        count <= 1;
                        state <= `DECIMAL;
                    end

                `HALT:
                    if (ce) begin
                        regA                     <= 0;
                        regB                     <= 0;
                        add_or_sub_or_mul_or_div_or_sqr <= 0;
                        count                    <= 0;
                        state                    <= `DECIMAL;
                    end
            endcase
        end
    end

    assign overflow = (state == `HALT)?1:0;
    assign sign     = (state == `DECIMAL)?0: ((state == `OPE)?(regB[27]) :0);
    assign out      = out_func (state, regA, regB);

    function [27:0] out_func;
        input [1:0] sta;
        input [14:0] A;
        input [27:0] B;
        case(sta)
            `DECIMAL :
                out_func = A;

            `OPE :
                if (B[27] == 1)
                    out_func = ~B + 1; // 2's complement to get the |B| (positive)
                else
                    out_func = B;
        endcase
    endfunction


endmodule
/*
1010 0000 1010 0110 1101 0001 1111 // -99,980,001
0101 1111 0101 1001 0010 1110 0000 + 1
0101 1111 0101 1001 0010 1110 0001 // 99,980,001
*/
