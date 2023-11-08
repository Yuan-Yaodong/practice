// Design 4-3
module lfsr10 (Data_out, clock, reset);
  input clock, reset;
  output Data_out;
  reg [9:0] Data_reg;
  wire Data_out;

  assign Data_out = Data_reg[9];

  always @(posedge clock or negedge reset)
    begin
      if (!reset) Data_reg <= 10'b0000000001;
      else
        begin
           Data_reg[0] <= Data_reg[1] ^ Data_reg[2] 
                        ^ Data_reg[3] ^ Data_reg[7]
                        ^ Data_reg[9];             // random initial
           Data_reg[1] <= Data_reg[0];
           Data_reg[2] <= Data_reg[1];
           Data_reg[3] <= Data_reg[2];
           Data_reg[4] <= Data_reg[3];
           Data_reg[5] <= Data_reg[4];
           Data_reg[6] <= Data_reg[5];
           Data_reg[7] <= Data_reg[6];
           Data_reg[8] <= Data_reg[7];
           Data_reg[9] <= Data_reg[8];
        end
    end
endmodule
