//~ `New testbench
`timescale  1ns / 1ns

module tb_register_file;

    // register_file Parameters
    parameter PERIOD  = 10;


    // register_file Inputs
    reg   clk;
    reg   reset;
    reg   [3:0]  reg1_read_addr;
    reg   [3:0]  reg2_read_addr;
    reg   [3:0]  reg_write_address_in;
    reg   [7:0]  reg_write_data_in;
    reg   reg_write_enable;
    reg   [7:0] reg_file [15:0];

    // register_file Outputs
    wire  [7:0]  reg1_read_data_out ;
    wire  [7:0]  reg2_read_data_out ;
    

    initial begin
        forever
            #(PERIOD/2)  clk=~clk;
    end


    register_file  u_register_file (
                       .clk                     ( clk                         ),
                       .reset                   ( reset                       ),
                       .reg1_read_addr          ( reg1_read_addr        [3:0] ),
                       .reg2_read_addr          ( reg2_read_addr        [3:0] ),
                       .reg_write_address_in    ( reg_write_address_in  [3:0] ),
                       .reg_write_data_in       ( reg_write_data_in     [7:0] ),
                       .reg_write_enable        ( reg_write_enable            ),

                       .reg1_read_data_out      ( reg1_read_data_out    [7:0] ),
                       .reg2_read_data_out      ( reg2_read_data_out    [7:0] )
                   );

    initial begin
        $monitor("%t reg1_addr = %b reg2_addr = %b reg1_data =%d reg2_data =%d wr_en = %b wr_addr = %b wr_data =%d",$time, reg1_read_addr, reg2_read_addr, reg1_read_data_out, reg2_read_data_out, reg_write_enable, reg_write_address_in, reg_write_data_in);

        clk <= 0;
        reset <= 0;
        #1 reset <=1; //start

        #(1*PERIOD) 
        reg_write_address_in <= 4'b0011; // write to 4th regs
        reg_write_data_in <= 8'd4; // write_data = 4
        reg_write_enable <= 1;
        #(2*PERIOD) reg_write_enable <= 0;

        #(4*PERIOD) 
        reg_write_address_in <= 4'b1111; // write to 16th regs
        reg_write_data_in <= 8'd16; // write_data = 16
        reg_write_enable <= 1;
        #(2*PERIOD) reg_write_enable <= 0;


        #(1*PERIOD) reg1_read_addr <= 4'b0011; // read from 4th regs
        #(1*PERIOD) reg2_read_addr <= 4'b1111; // read from 16th regs


        #(4*PERIOD) 
        reg2_read_addr <= 4'b0011; // reg2 read from 4th regs
        reg_write_address_in <= 4'b1010; // write to 11th regs at the same time
        reg_write_data_in <= 8'b11111111; // write_data = 255
        reg_write_enable <= 1;
        #(2*PERIOD)  reg_write_enable <= 0;

        #(2*PERIOD)  reg1_read_addr <= 4'b1010;
        $finish;
    end

endmodule
