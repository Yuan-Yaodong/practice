`include "parameter_defines.v"

// Program Counter Register
module pc_reg (
        input      clk,          // system clock
        input      rst_n,       // active low reset
        output reg ena, // system enable
        input      [`CPU_WIDTH-1:0] next_pc, // next program counter address
        output reg [`CPU_WIDTH-1:0] curr_pc // current program counter address
    );


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ena <= 1'b0;
    end
    else begin
        ena <= 1;
    end
end


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        curr_pc <= `CPU_WIDTH'b0;    // return to base address (all 0)
    end
    else begin
        curr_pc <= next_pc;
    end
end



endmodule 
