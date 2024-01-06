module register_file(
        clk,
        reset,

        // read address
        reg1_read_addr,
        reg2_read_addr,

        // 2 outputs to ALU
        reg1_read_data_out,
        reg2_read_data_out,

        // 1 input from ALU
        reg_write_address_in,
        reg_write_data_in,

        // write enable
        reg_write_enable
    );

    input  clk;
    input  reset;

    input  [3:0] reg1_read_addr; // 4 bits of read address (m = 4)
    input  [3:0] reg2_read_addr; // 4 bits of read address (m = 4)

    input  [3:0] reg_write_address_in; // write address (m = 4)
    input  [7:0] reg_write_data_in; // data to be written ( input)

    input  reg_write_enable;

    output reg [7:0] reg1_read_data_out; // 8 bits of read data (n = 8)
    output reg [7:0] reg2_read_data_out; // 8 bits of read data (n = 8)


    reg [7:0] reg_file [15:0]; // 16 sets of 8bits width register
    integer ii; // loop variable


    /** read operation for reg1 */
    always @(*) begin
        if (!reset)
            reg1_read_data_out <= 8'b0;
        else
            reg1_read_data_out <= reg_file[reg1_read_addr];
    end

    /** read operation for reg2 */
    always @(*) begin
        if (!reset)
            reg2_read_data_out <= 8'b0;
        else
            reg2_read_data_out <= reg_file[reg2_read_addr];
    end


    /** reset operation */
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            for (ii = 0; ii < 16; ii = ii + 1) begin
                reg_file[ii] <= 8'b0;
            end
        end
        else
            ;
    end



    /** write operation */
    always @(posedge clk) begin
        if (reg_write_enable)
            reg_file[reg_write_address_in] <= reg_write_data_in;
        else
            ;
    end

endmodule
