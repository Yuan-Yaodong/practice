// Project #2: 16-bit pipeline processor
// Yuan Yaodong Student NO.44231037


/** Instruction Format
 
     Operation field
 
opcode  operand1  operand2  operand3  
00011     111       x110      x011
 
[15:0] gr [0:7]  register file (16bit x 8)
*/

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


// FSM for CPU controler
`define idle 1'b0
`define exec 1'b1

module pcpu (reset, clock, enable, start, i_addr, i_datain, d_addr,
                 d_datain, d_dataout, d_we, select_y, y);

    input reset, clock, enable, start;
    input  [15:0] i_datain;
    output [7:0]  i_addr;
    output [7:0]  d_addr;
    input  [15:0] d_datain;
    output [15:0] d_dataout;
    output d_we;

    // for Debug
    input  [3:0] select_y;
    output [15:0] y;

    // Definition of F/F (Flip-Flop)
    reg [7:0]  pc ;                          // Program Counter, to store the next instruction
    reg [15:0] id_ir, ex_ir, mem_ir, wb_ir;  // instruction transfer in every stage
    reg [15:0] gr [0:7];                     // 8 general registers of 16bits data width
    reg [15:0] reg_A, reg_B;
    // I type instructions,  reg_A <= r1, reg_B <= {val2,val3}
    // RI type instructions, reg_A <= r2, reg_B <= val3
    // R type instructions,  reg_A <= r2, reg_B <= r3

    reg [15:0] reg_C, reg_C1;                // for ALU output
    reg [15:0] smdr, smdr1;                  // for memory writing
    reg zf, nf, cf, dw;                      // zero flag, negative flag, carry flag, data write
    reg state ;                              // FSM current state

    // Definition of temporary variable
    reg [15:0] ALUo;                        // ALU output
    reg [15:0] y;
    reg next_state;
    reg cf_next;                            // for compute carry flag in ALU module

    assign i_addr = pc;                      // instruction address
    assign d_we  = dw;                       // data write enable
    assign d_addr = reg_C[7:0];              // data address
    assign d_dataout = smdr1;                // data output


    // CPU Control (FSM)
    always @(posedge clock or negedge reset) begin
        if (!reset)
            state <= `idle;
        else
            state <= next_state;
    end

    always @(state or enable or start or wb_ir[15:11]) begin
        case (state)
            `idle :
                if ((enable == 1'b1) && (start == 1'b1))
                    next_state <= `exec;
                else
                    next_state <= `idle;
            `exec :
                if ((enable == 1'b0) || (wb_ir[15:11] == `HALT))
                    next_state <= `idle;
                else
                    next_state <= `exec;
        endcase
    end

    // IF Block (1st Stage)
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            id_ir <= 16'b0000000000000000;
            pc    <= 8'b00000000;
        end
        else if(state==`exec) begin
            id_ir <= i_datain;

            /*-----Control operations -------*/
            //  jump to the address stored in reg_C
            if ( (mem_ir[15:11] == `JUMP) || (mem_ir[15:11] == `JMPR) || ((mem_ir[15:11] == `BZ) && (zf == 1'b1)) || ((mem_ir[15:11] == `BNZ) && (zf == 1'b0)) || ((mem_ir[15:11] == `BN) && (nf == 1'b1)) || ((mem_ir[15:11] == `BNN) && (nf == 1'b0)) || ((mem_ir[15:11] == `BC) && (cf == 1'b1)) || ((mem_ir[15:11] == `BNC) && (cf == 1'b0)) )
                pc <= reg_C[7:0];
            else
                pc <= pc + 1;
        end
    end

    // ID Block (2nd Stage)
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            ex_ir <= 16'b0000000000000000;
            reg_A <= 16'b0000000000000000;
            reg_B <= 16'b0000000000000000;
            smdr  <= 16'b0000000000000000;
        end
        else if(state==`exec) begin
            ex_ir <= id_ir;

            // ------------reg_A---------------------------------------------
            /*-----I type instructions -----*/
            /* we need r1, val2, val3 */

            if ((id_ir[15:11] == `LDIH) || (id_ir[15:11] == `ADDI) || (id_ir[15:11] == `SUBI) || (id_ir[15:11] == `BZ) || (id_ir[15:11] == `BNZ) || (id_ir[15:11] == `BN) || (id_ir[15:11] == `BNN) || (id_ir[15:11] == `BC) || (id_ir[15:11] == `BNC) || (id_ir[15:11] == `JUMP) || (id_ir[15:11] == `JMPR))
                reg_A <= gr[(id_ir[10:8])]; // I type instruction, reg_A <= r1
            else
                reg_A <= gr[(id_ir[6:4])];  // other situations, reg_A <= r2

            // ------------reg_B---------------------------------------------
            //RI type instructions, reg_A <= r2, reg_B <= val3
            if ((id_ir[15:11] == `LOAD) || (id_ir[15:11] == `SLL) || (id_ir[15:11] == `SRL) || (id_ir[15:11] == `SLA) || (id_ir[15:11] == `SRA))   // non-writing instructions
                reg_B <= {12'b000000000000, id_ir[3:0]};
            else if (id_ir[15:11] == `STORE) begin
                reg_B <= {12'b000000000000, id_ir[3:0]};
                smdr  <= gr[id_ir[10:8]];  // smdr <= r1
            end

            //I type instructions, reg_A <= r1, reg_B <= {val2,val3}
            else if ((id_ir[15:11] == `LDIH) || (id_ir[15:11] == `ADDI) || (id_ir[15:11] == `SUBI) || (id_ir[15:11] == `BZ) || (id_ir[15:11] == `BNZ) || (id_ir[15:11] == `BN) || (id_ir[15:11] == `BNN) || (id_ir[15:11] == `BC) || (id_ir[15:11] == `BNC) || (id_ir[15:11] == `JUMP) || (id_ir[15:11] == `JMPR))
                reg_B <= {8'b00000000, id_ir[7:0]};
            else
                //R type instructions, reg_A <= r2, reg_B <= r3
                reg_B <= gr[id_ir[2:0]];  // id_ir[2:0] = r3
        end
    end

    // EX Block (3rd Stage)
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            mem_ir <= 16'b0000000000000000;
            reg_C <= 16'b0000000000000000;
            smdr1 <= 16'b0000000000000000;
            zf <= 1'b0 ;
            nf <= 1'b0 ;
            cf <= 1'b0 ;
            dw <= 1'b0 ;
        end
        else if(state==`exec) begin
            mem_ir <= ex_ir;
            reg_C  <= ALUo;
            cf <= cf_next;
            if ((ex_ir[15:11] == `ADD) || (ex_ir[15:11] == `ADDI) || (ex_ir[15:11] == `ADDC) || (ex_ir[15:11] == `SUB) || (ex_ir[15:11] == `SUBI) || (ex_ir[15:11] == `SUBC) || (ex_ir[15:11] == `CMP) || (ex_ir[15:11] == `AND) || (ex_ir[15:11] == `OR) || (ex_ir[15:11] == `XOR) || (ex_ir[15:11] == `SLL) || (ex_ir[15:11] == `SRL) || (ex_ir[15:11] == `SLA) || (ex_ir[15:11] == `SRA)) begin
                if (ALUo == 16'b0000000000000000)
                    zf <= 1'b1;
                else
                    zf <= 1'b0;
                if (ALUo [15] == 1'b1)
                    nf <= 1'b1;
                else
                    nf <= 1'b0;

            end

            if (ex_ir[15:11] == `STORE) begin
                dw <= 1'b1;
                smdr1 <= smdr;    // smdr1 <= r1, means that data output is r1
            end
            else
                dw <= 1'b0;
        end
    end

    // MEM Block (4th Stage)
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            wb_ir  <= 16'b0000000000000000;
            reg_C1 <= 16'b0000000000000000;
        end
        else if(state==`exec) begin
            wb_ir  <= mem_ir;
            if (mem_ir[15:11] == `LOAD)
                reg_C1 <= d_datain;
            else
                reg_C1 <= reg_C;
        end
    end

    // WB Block (5th Stege)
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            gr[0] <= 16'b0000000000000000;
            gr[1] <= 16'b0000000000000000;
            gr[2] <= 16'b0000000000000000;
            gr[3] <= 16'b0000000000000000;
            gr[4] <= 16'b0000000000000000;
            gr[5] <= 16'b0000000000000000;
            gr[6] <= 16'b0000000000000000;
            gr[7] <= 16'b0000000000000000;
        end
        else if(state==`exec) begin
            if (wb_ir[10:8] != 3'b000)        // gr[0] always all-0, cannot be written
                // all the operations that write to r1
                if ((wb_ir[15:11] == `LOAD) || (wb_ir[15:11] == `ADD) || (wb_ir[15:11] == `LDIH) || (wb_ir[15:11] == `ADDI) || (wb_ir[15:11] == `ADDC) || (wb_ir[15:11] == `SUB) || (wb_ir[15:11] == `SUBI) || (wb_ir[15:11] == `SUBC) || (wb_ir[15:11] == `AND) || (wb_ir[15:11] == `OR) || (wb_ir[15:11] == `XOR) || (wb_ir[15:11] == `SLL) || (wb_ir[15:11] == `SRL) || (wb_ir[15:11] == `SLA) || (wb_ir[15:11] == `SRA))
                    gr[wb_ir[10:8]] <= reg_C1;
        end
    end

    // ALU module
    always @(reg_A or reg_B or ex_ir[15:11])
    case (ex_ir[15:11])
        /* Data transfer & Arithmetic*/
        `NOP    :
            ALUo = ALUo;
        `HALT   :
            ALUo = ALUo;
        `LOAD   :
            ALUo = reg_A + reg_B;
        `STORE  :
            ALUo = reg_A + reg_B;
        `LDIH:
            ALUo = {reg_B[7:0], 8'b00000000};  // r1 <- {val2,val3,00000000}
        `ADD    :
            {cf_next, ALUo} = {1'b0, reg_A} + {1'b0, reg_B};  // sign bit extension with 1'b0,to store cf_next
        `ADDI   :
            {cf_next, ALUo} = {1'b0, reg_A} + {1'b0, reg_B};
        `ADDC:
            {cf_next, ALUo} = {1'b0, reg_A} + {1'b0, reg_B} + cf;
        `SUB    :
            {cf_next, ALUo} = {1'b0, reg_A} - {1'b0, reg_B};
        `SUBI   :
            {cf_next, ALUo} = {1'b0, reg_A} - {1'b0, reg_B};
        `SUBC:
            {cf_next, ALUo} = {1'b0, reg_A} - {1'b0, reg_B} - cf;
        `CMP    :
            {cf_next, ALUo} = {1'b0, reg_A} - {1'b0, reg_B};

        /* Logic / Shift operations*/
        `AND    : begin
            ALUo = reg_A & reg_B;
            cf_next = 1'b0;
        end
        `OR    :  begin
            ALUo = reg_A | reg_B;
            cf_next = 1'b0;
        end
        `XOR    : begin
            ALUo = reg_A ^ reg_B;
            cf_next = 1'b0;
        end
        `SLL    :
            ALUo = reg_A << reg_B;
        `SRL    :
            ALUo = reg_A >> reg_B;
        `SLA    :
            ALUo = reg_A <<< reg_B;
        `SRA    : 
            ALUo = reg_A >>> reg_B;

        /* Control operations
           reg_A = r1;  
           reg_B = {val2+val3} */
        `JUMP   :
            ALUo = reg_B;          // jump to {val2+val3}
        `JMPR    :
            ALUo = reg_A + reg_B;  // the left operaions are all jump to r1 + {val2+val3}
        `BZ     :
            ALUo = reg_A + reg_B;
        `BNZ     :
            ALUo = reg_A + reg_B;
        `BN     :
            ALUo = reg_A + reg_B;
        `BNN     :
            ALUo = reg_A + reg_B;
        `BC     :
            ALUo = reg_A + reg_B;
        `BNC     :
            ALUo = reg_A + reg_B;
        default : begin
            ALUo = 16'bXXXXXXXXXXXXXXXX;
            cf_next = cf_next;
        end
    endcase

    // Debug
    always @(select_y or gr[1] or gr[2] or gr[3] or gr[4] or gr[5] or gr[6]
                 or gr[7] or reg_A or reg_B or reg_C or reg_C1 or smdr or id_ir
                 or dw or zf or nf or cf or pc) begin
        case (select_y)
            4'b0000 :
                y = {3'b000, dw, 2'b00, zf, nf, pc};
            4'b0001 :
                y = gr[1];
            4'b0010 :
                y = gr[2];
            4'b0011 :
                y = gr[3];
            4'b0100 :
                y = gr[4];
            4'b0101 :
                y = gr[5];
            4'b0110 :
                y = gr[6];
            4'b0111 :
                y = gr[7];
            4'b1000 :
                y = reg_A;
            4'b1001 :
                y = reg_B;
            4'b1011 :
                y = reg_C;
            4'b1100 :
                y = reg_C1;
            4'b1101 :
                y = smdr;
            4'b1110 :
                y = id_ir;
            default :
                y = 16'bXXXXXXXXXXXXXXXX;
        endcase
    end

endmodule
