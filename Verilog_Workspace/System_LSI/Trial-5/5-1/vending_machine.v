module vending_machine(
        clk,
        init,
        rst,
        input10,
        input50,
        inputa0,
        chng,
        can
    );

    //-----------design ports----------------
    input clk, init, rst, input10, input50, inputa0;
    output reg [4:0] chng;
    output reg can;

    //state definition
    localparam   S0 = 2'd0;
    localparam   S1 = 2'd1;
    localparam   S2 = 2'd2;


    //-----------internal signals----------------
    reg [1:0] state;
    reg [1:0] next_state;
    reg [4:0] amount;


    //------------design body--------------------
    //FSM  ------->>>>>>>>>>>>>>>>>
    always @(posedge clk) begin
        state <= next_state;
    end

    //------------next state logic---------------
    always @(*) begin
        case (state)
            S0: begin
                next_state = S1;
            end

            S1: begin
                if (!rst || (input10 == 1'b1) || (input50 == 1'b1) || (inputa0 == 1'b1))
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                if (!rst)
                    next_state = S0;
                else if (amount >= 12)
                    next_state = S0;
                else
                    next_state = S1;
            end

            default:
                next_state = S0;
        endcase
    end

    //--------------output logic-------------------
    always @(*) begin
        case (state)
            S0: begin
                amount = 0;
            end

            S1: begin
                if(input10)
                    amount = amount + 1;
                else if(input50)
                    amount = amount + 5;
                else if(inputa0)
                    amount = amount + 10;
                else
                    amount = amount;
            end

            S2: begin
                if(!rst)
                    chng = amount;
                else if(amount >= 12) begin
                    can = 1'b1;
                    chng = (amount-12);
                end
                else begin
                    can = 1'b0;
                    chng = 5'b00000;
                end
            end

            default: begin
                amount = 0;
                chng = 5'b00000;
                can = 1'b0;
            end
        endcase
    end

endmodule
