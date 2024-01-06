module alu(
    input [4:0] S,
    input Cin,
    input [7:0] A,      // operator A
    input [7:0] B,      // operator B
    output reg [7:0] Y 
);

always @(*) begin
    case({S, Cin})
        6'b000000: Y <= A;
        6'b000001: Y <= A + 1;
        6'b000010: Y <= A + B;
        6'b000011: Y <= A + B + 1;
        6'b000100: Y <= A + (~B);
        6'b000101: Y <= A + (~B) + 1;
        6'b000110: Y <= A - 1;
        6'b000111: Y <= A;
        6'b001000: Y <= A & B;
        6'b001010: Y <= A | B;
        6'b001100: Y <= A ^ B;
        6'b001110: Y <= ~A;
        6'b010000: Y <= A << 1;
        6'b100000: Y <= A >> 1;
        6'b110000: Y <= 0;
       
        default: Y = 8'b0;  // default value
    endcase
end

endmodule