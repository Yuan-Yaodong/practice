// Design 5-1

module train_controller (clk,
                         rst_n,
                         S1,
                         S2,
                         S3,
                         S4,
                         SW1,
                         SW2,
                         DA,
                         DB);
    
    input clk, rst_n, S1, S2, S3, S4;
    
    output reg SW1, SW2;
    output reg [1:0] DA, DB;
    
    // State reg define
    
    reg [4:0] curr_st;
    reg [4:0] next_st;
    
    // State space define
    
    parameter ABout = 5'b00001 ;
    parameter Ain   = 5'b00010 ;
    parameter Astop = 5'b00100 ;
    parameter Bin   = 5'b01000 ;
    parameter Bstop = 5'b10000 ;
    
    
    // next state generator
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            curr_st <= ABout;
        else
            curr_st <= next_st;
    end
    
    
    // next state logic
    always@(*)
    begin
        case (curr_st)
            ABout: begin
                if ((S1 == 0) & (S2 == 1))
                    next_st = Bin;
                else if ((S1 == 1) & (S2 == 0))
                    next_st = Ain;
                else if ((S1 == 1) & (S2 == 1))
                    next_st = Bstop;
                else if ((S1 == 0) & (S2 == 0))
                    next_st = ABout;
                else
                    next_st = ABout;
            end
            Bin: begin
                if ((S1 == 1) & (S3 == 0))
                    next_st = Astop;
                else if (((S1 == 1'b0)|(S1 == 1'b1)) & (S3 == 1))
                    next_st = ABout;
                else if ((S1 == 0) & (S3 == 0))
                    next_st = Bin;
                else
                    next_st = Bin;
            end
            Astop: begin
                if (S3 == 1)
                    next_st = Ain;
                else if (S3 == 0)
                    next_st = Astop;
                else
                    next_st = Astop;
            end
            Bstop: begin
                if (S4 == 1)
                    next_st = Bin;
                else if (S4 == 0)
                    next_st = Bstop;
                else
                    next_st = Bstop;
            end
            Ain: begin
                if ((S2 == 1) & (S4 == 0))
                    next_st = Bstop;
                else if (((S2 == 1'b0)|(S2 == 1'b1)) & (S4 == 1))
                    next_st = ABout;
                else if ((S2 == 0) & (S4 == 0))
                    next_st = Ain;
                else
                    next_st = Ain;
            end
            default: next_st = 5'bXXXXX;
        endcase
        
    end
    
    // output function
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            SW1 <= 0; SW2 <= 0;
            DA  <= 2'b01;
            DB  <= 2'b01;
        end
            /* else if (curr_st == About)
             begin
             SW1 <= 0; SW2 <= 0; SW3 <= 0;
             DA  <= 2'b01;
             DB  <= 2'b01;
             end
             else if (curr_st == Ain)
             begin
             SW1 <= 0; SW2 <= 0; SW3 <= 0;
             DA  <= 2'b01;
             DB  <= 2'b01;
             end
             else if (curr_st == Astop)
             begin
             SW1 <= 1; SW2 <= 1; SW3 <= 0;
             DA  <= 2'b00;
             DB  <= 2'b01;
             end
             else if (curr_st == Bin)
             begin
             SW1 <= 1; SW2 <= 1; SW3 <= 0;
             DA  <= 2'b01;
             DB  <= 2'b01;
             end
             else if (curr_st == Bstop)
             begin
             SW1 <= 0; SW2 <= 0; SW3 <= 0;
             DA  <= 2'b01;
             DB  <= 2'b00;
             end */
        else begin
            case(next_st)
                ABout: begin
                    SW1 <= 0; SW2 <= 0;
                    DA  <= 2'b01;
                    DB  <= 2'b01;
                end
                Ain: begin
                    SW1 <= 0; SW2 <= 0;
                    DA  <= 2'b01;
                    DB  <= 2'b01;
                end
                Astop: begin
                    SW1 <= 1; SW2 <= 1;
                    DA  <= 2'b00;
                    DB  <= 2'b01;
                end
                Bin: begin
                    SW1 <= 1; SW2 <= 1;
                    DA  <= 2'b01;
                    DB  <= 2'b01;
                end
                Bstop: begin
                    SW1 <= 0; SW2 <= 0;
                    DA  <= 2'b01;
                    DB  <= 2'b00;
                end
                default: begin
                    SW1 <= 1'bX; SW2 <= 1'bX;
                    DA  <= 2'bXX;
                    DB  <= 2'bXX;
                end
            endcase
        end
    end
    
endmodule
