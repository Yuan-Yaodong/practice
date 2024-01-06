
// Binled: led module
module Bin_led(in,
              led_low,
              led_middle_1,
              led_middle_2,
              led_middle_3,
              led_middle_4,
              led_middle_5,
              led_middle_6,
              led_high);
    
    input  [27:0] in; // 0 ~ 99,980,001
    output [7:0] led_low, led_high;
    output [7:0] led_middle_1, led_middle_2, led_middle_3, led_middle_4, led_middle_5, led_middle_6;

    wire [3:0] wire_high, wire_middle_6, wire_middle_5, wire_middle_4, wire_middle_3, wire_middle_2, wire_middle_1, 
    wire_low;
    
    BintoBCD BintoBCD(
        .in  (in), 
        .out_low (wire_low),
        .out_middle_1 (wire_middle_1),
        .out_middle_2 (wire_middle_2),
        .out_middle_3 (wire_middle_3),
        .out_middle_4 (wire_middle_4),
        .out_middle_5 (wire_middle_5),
        .out_middle_6 (wire_middle_6),
        .out_high (wire_high)
        );
    


    ledout ledout_high(.in(wire_high), .out(led_high));
    ledout ledout_middle_6(.in(wire_middle_6), .out(led_middle_6));
    ledout ledout_middle_5(.in(wire_middle_5), .out(led_middle_5));
    ledout ledout_middle_4(.in(wire_middle_4), .out(led_middle_4));
    ledout ledout_middle_3(.in(wire_middle_3), .out(led_middle_3));
    ledout ledout_middle_2(.in(wire_middle_2), .out(led_middle_2));
    ledout ledout_middle_1(.in(wire_middle_1), .out(led_middle_1));
    ledout ledout_low(.in(wire_low), .out(led_low));
    
endmodule
    
    
    // Ledout: Transloion from BCD to LED-out format
    module ledout(in, out);
        input  [3:0] in ;
        output [7:0] out;
        reg    [7:0] out;
        
        always @(in)
        begin
            case(in)
                0: out       = 8'b11111100;
                1: out       = 8'b01100000;
                2: out       = 8'b11011010;
                3: out       = 8'b11110010;
                4: out       = 8'b01100110;
                5: out       = 8'b10110110;
                6: out       = 8'b10111110;
                7: out       = 8'b11100000;
                8: out       = 8'b11111110;
                9: out       = 8'b11110110;
                default: out = 8'bXXXXXXXX ;
            endcase
        end
    endmodule
