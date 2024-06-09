// Project #2: 16-bit pipeline processor
// Test pattern for "System LSI design"
//`include "pcpu.v"
`timescale 1ns / 10ps

// Operation Code
`define NOP   5'b00000
`define HALT  5'b00001
`define LOAD  5'b00010
`define STORE 5'b00011
`define ADD   5'b01000
`define CMP   5'b01100
`define BZ    5'b11010
`define BN    5'b11100

// ** implemented operation

// Data transfer & Arithmetic operations
`define LDIH  5'b10000
`define ADDI  5'b01001
`define ADDC  5'b10001
`define SUB   5'b01010
`define SUBI  5'b01011
`define SUBC  5'b10100

// Logical / Shift operations
`define AND  5'b01101
`define OR   5'b01110
`define XOR  5'b01111
`define SLL  5'b00100
`define SRL  5'b00101
`define SLA  5'b00110
`define SRA  5'b00111

// Control operations
`define JUMP 5'b11000
`define JMPR 5'b11001
`define BNZ  5'b11011
`define BNN  5'b11101
`define BC   5'b11110
`define BNC  5'b11111


// original operation added in my design

`define MUL  5'b10010  // r1 <- r2 * r3             ---R type
`define DIV  5'b10110  // r1 <- r2/r3               ---R type
`define LANDI 5'b10111  // r1 <- r2 and {12¡¯b111111111111,val3}  ---RI type
`define LORI  5'b10011  // r1 <- r2 or  {12'b000000000000,val3}  ---RI type
`define LXORI 5'b10101  // r1 <- r2 xor {12'b000000000000,val3}  ---RI type



// General register
`define gr0 3'b000
`define gr1 3'b001
`define gr2 3'b010
`define gr3 3'b011
`define gr4 3'b100
`define gr5 3'b101
`define gr6 3'b110
`define gr7 3'b111

module t_pcpu();

    reg reset, clock, enable, start;
    reg  [15:0] i_datain;
    wire [7:0] i_addr;
    wire [7:0] d_addr;
    reg  [15:0] d_datain;
    wire [15:0] d_dataout;
    wire d_we;

    reg  [3:0] select_y;
    wire [15:0] y;

    // Clock
    initial
        clock = 0;
    always
        #5 clock = ~clock;

    initial begin
        $display("pc:     id_ir        :  regA : regB:  ALUo:  regC:   reC1 : da: dd :  w :  gr1 :  gr2 :  gr3 :  gr4 :  gr5 :  gr6 :  gr7 ");
        $monitor("%h:  %b:  %h:  %h:  %h:  %h:  %h:  %h:  %h:  %b:  %h:  %h:  %h:  %h:  %h : %h : %h",
                 pcpu.pc, pcpu.id_ir, pcpu.reg_A, pcpu.reg_B, pcpu.ALUo, pcpu.reg_C,
                 pcpu.reg_C1, d_addr, d_dataout, d_we, pcpu.gr[1], pcpu.gr[2], pcpu.gr[3], pcpu.gr[4], pcpu.gr[5], pcpu.gr[6], pcpu.gr[7]);
        enable <= 0;
        start <=0;
        i_datain <=0;
        d_datain <=0;
        select_y <= 0;
        #10 reset <= 0;
        #10 reset <= 1;
        #10 enable <= 1;
        #10 start <= 1;
        #10 start <= 0;
        pcpu.gr[1] <= 16'h0021;
        pcpu.gr[2] <= 16'h03F5;
        #10 i_datain <= {`NOP, 11'b00000000000};
        #10 i_datain <= {`NOP, 11'b00000000000};
        #10 i_datain <= {`MUL, `gr3, 4'b0001, 4'b0010}; //`MUL gr3, gr1, gr2

        #10 i_datain <= {`NOP, 11'b00000000000};
        #10 i_datain <= {`NOP, 11'b00000000000};
        #10 i_datain <= {`NOP, 11'b00000000000};
        #10 i_datain <= {`STORE, `gr3, 4'b0000, 4'b0011};  //STORE gr3, gr0, 2

        #10 i_datain <= {`HALT, 11'b00000000000};
        #100
         $finish;
    end

    pcpu pcpu (reset, clock, enable, start, i_addr, i_datain, d_addr,
               d_datain, d_dataout, d_we, select_y, y);

endmodule
