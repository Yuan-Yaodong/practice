
`timescale 1ns / 1ps

module tb_interface;

  reg sys_clk ,rst_n;                   // clock, reset
  reg [4:0] input_row1, input_row2, input_row3, input_row4; // push switch(NEG)

  wire beep;			    // buzzer
  wire [7:0] ledA, ledB, ledC, ledD;// LED
  wire [7:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8; // 7SEG

  // Clock
  initial sys_clk = 0;
  always
    #5 sys_clk = ~sys_clk;

  initial
    begin
      $monitor("regA=%b, regB=%b, seg1=%b, seg2=%b, seg3=%b, seg4=%b, seg5=%b, seg6=%b, seg7=%b, seg8=%b , sign=%b",
               Interface.regA, Interface.regB, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8, Interface.sign);
      rst_n <= 1; input_row1 <= 5'b11111; input_row2 <= 5'b11111; input_row3 <= 5'b11111; 
      input_row4 <= 5'b11111;
      
      #10 rst_n <= 0;
      #10 rst_n <= 1;
     
 /* 
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
    */

     //input: 7
      #10 input_row1[0] <= 0;
      #10 input_row1[0] <= 1;
	  
      // input: div
      #10 input_row2[4] <= 0;
      #10 input_row4[4] <= 1;

     
      // input: 3
      #10 input_row3[2] <= 0;
      #10 input_row3[2] <= 1;

      // input: equal
      #10 input_row4[4] <= 0;
      #10 input_row4[4] <= 1;
    
     // ac clear the calculator
      #10 input_row1[3] <= 0;
      #10 input_row1[3] <= 1;


      // input: 2345
      #200 input_row3[1] <= 0;
      #200 input_row3[1] <= 1;

      #200 input_row3[2] <= 0;
      #200 input_row3[2] <= 1;     

      #200 input_row2[0] <= 0;
      #200 input_row2[0] <= 1;  

      #200 input_row2[1] <= 0;
      #200 input_row2[1] <= 1;
    


      // input: mul
      #200 input_row3[4] <= 0;
      #200 input_row3[4] <= 1;

 // input: 5678
      #200 input_row2[1] <= 0;
      #200 input_row2[1] <= 1;

      #200 input_row2[2] <= 0;
      #200 input_row2[2] <= 1;     

      #200 input_row1[0] <= 0;
      #200 input_row1[0] <= 1;  

      #200 input_row1[1] <= 0;
      #200 input_row1[1] <= 1;

      // input: equal
      #2000 input_row4[4] <= 0;
      #2000 input_row4[4] <= 1;
      
      #100


     // ac clear the calculator
      #10 input_row1[3] <= 0;
      #10 input_row1[3] <= 1;
     
      // input: 31
      #200 input_row3[2] <= 0;
      #200 input_row3[2] <= 1;

      #200 input_row3[0] <= 0;
      #200 input_row3[0] <= 1;  


      // minus
      #200 input_row2[3] <= 0;
      #200 input_row2[3] <= 1;

      // input 50
      #200 input_row2[1] <= 0;
      #200 input_row2[1] <= 1;

      #200 input_row4[0] <= 0;
      #200 input_row4[0] <= 1;  

      // input: equal
      #2000 input_row4[4] <= 0;
      #2000 input_row4[4] <= 1;

      $finish;
    end

   Interface Interface(
    .sys_clk (sys_clk),
    .rst_n     (rst_n),
    .input_row1(input_row1),
    .input_row2(input_row2),
    .input_row3(input_row3),
    .input_row4(input_row4),
    .beep     (beep),
    .ledA     (ledA),
    .ledB     (ledB),
    .ledC     (ledC),
    .ledD     (ledD),
    .seg1     (seg1),
    .seg2     (seg2),
    .seg3     (seg3),
    .seg4     (seg4),
    .seg5     (seg5),
    .seg6     (seg6),
    .seg7     (seg7),
    .seg8     (seg8)
    );

endmodule
