`include "parameter_defines.v"

// Instruction Memory
module instru_mem(
        input  [`CPU_WIDTH-1:0] curr_pc, // current program counter address
        output [`CPU_WIDTH-1:0] instru // instruction
    );


    reg  [`CPU_WIDTH-1:0] instru_mem_f [0:`INSTRU_MEM_ADDR_DEPTH-1];


    assign instru = instru_mem_f [curr_pc [`INSTRU_MEM_ADDR_WIDTH+2-1:0]];

endmodule
