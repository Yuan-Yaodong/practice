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


// General register
`define gr0 3'b000
`define gr1 3'b001
`define gr2 3'b010
`define gr3 3'b011
`define gr4 3'b100
`define gr5 3'b101
`define gr6 3'b110
`define gr7 3'b111

module t_pcpu_dta();

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
  initial clock = 0;
  always
    #5 clock = ~clock;

  initial
    begin
      $display("pc:     id_ir        :  regA : regB:  regC:  da:   dd :  w:  reC1:  gr1 :  gr2 :  gr3 : nf: cf ");
      $monitor("%h:  %b:  %h:  %h:  %h:  %h:  %h:  %b:  %h:  %h:  %h:  %h  %b : %b", 
                pcpu.pc, pcpu.id_ir, pcpu.reg_A, pcpu.reg_B, pcpu.reg_C,
                d_addr, d_dataout, d_we, pcpu.reg_C1,
                pcpu.gr[1], pcpu.gr[2], pcpu.gr[3], pcpu.nf, pcpu.cf);
      enable <= 0; start <=0; i_datain <=0; d_datain <=0; select_y <= 0;
      #10 reset <= 0;
      #10 reset <= 1;
      #10 enable <= 1;
      #10 start <= 1; 
      #10 start <= 0; i_datain <= {`ADDI, `gr1, 4'b0010, 4'b0100};  //ADDI gr1, 2, 4
      #10  i_datain <= {`ADDI, `gr2, 4'b0001, 4'b0001}; //ADDI gr2, 1, 1
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      //    d_datain <= 16'h00AB; // 4 clock later from LOAD
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      //    d_datain <= 16'h3C00; // 4 clock later from LOAD

      #10 i_datain <= {`SUB, `gr3, 1'b0, `gr2, 1'b0, `gr1}; //SUB gr3, gr2, gr1
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 

      #10 i_datain <= {`SUBC, `gr3, 1'b0, `gr1, 1'b0, `gr2};  //SUBC gr3, gr1, gr2
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 

      #10 i_datain <= {`CMP, 3'b111, 1'b0, `gr2, 1'b0, `gr1};  //CMP gr2, gr1
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 

      #10 i_datain <= {`ADDC, `gr3, 1'b1, `gr2, 1'b1, `gr1};  //ADDC gr3, gr2, gr1
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 

      #10 i_datain <= {`SUBI, `gr3, 4'b0011, 4'b0011};  //SUBI gr3, 3, 3
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 

      #10 i_datain <= {`STORE, `gr3, 1'b1, `gr2, 4'b0001};  //STORE gr3, gr2, 1
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 
      #10 i_datain <= {`NOP, 11'b00000000000}; 


      #10 i_datain <= {`HALT, 11'b00000000000}; 
      #100
      $finish;
    end

    pcpu pcpu (reset, clock, enable, start, i_addr, i_datain, d_addr,
             d_datain, d_dataout, d_we, select_y, y);

endmodule
