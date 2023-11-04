// Test Pattern E3-2
module t_alu;
  reg [4:0] S;
  reg Cin;
  reg [7:0] A, B;
  wire [7:0] Y;

  initial
  begin
   $monitor("%t A=%b B=%b S=%b Cin=%b Y=%b",$time, A, B, S, Cin, Y);
   A <= 8'b00000000; B <= 8'bXXXXXXXX; S <= 5'b00000; Cin <= 0;
   #10 A <= 8'b10101010; B <= 8'bXXXXXXXX; S <= 5'b00000; Cin <= 0;
   #10 A <= 8'b10101010; B <= 8'bXXXXXXXX; S <= 5'b00000; Cin <= 1;
   #10 A <= 8'b10101010; B <= 8'b01010101; S <= 5'b00001; Cin <= 0;
   #10 A <= 8'b00101010; B <= 8'b01010101; S <= 5'b00001; Cin <= 1;

   #10 A <= 8'b10101010; B <= 8'b00101010; S <= 5'b00010; Cin <= 0;
   #10 A <= 8'b10101010; B <= 8'b00101010; S <= 5'b00010; Cin <= 1;

   #10 A <= 8'b10101010; B <= 8'bXXXXXXXX; S <= 5'b00011; Cin <= 0;
   #10 A <= 8'b01010101; B <= 8'bXXXXXXXX; S <= 5'b00011; Cin <= 1;

   #10 A <= 8'b11110000; B <= 8'b11111111; S <= 5'b00100; Cin <= 0;
   #10 A <= 8'b11110000; B <= 8'b00000000; S <= 5'b00101; Cin <= 0;
   #10 A <= 8'b10100000; B <= 8'b00001010; S <= 5'b00110; Cin <= 0;

   #10 A <= 8'b10101010; B <= 8'bXXXXXXXX; S <= 5'b00111; Cin <= 0;
   #10 A <= 8'b00011000; B <= 8'bXXXXXXXX; S <= 5'b01000; Cin <= 0;
   #10 A <= 8'b00011000; B <= 8'bXXXXXXXX; S <= 5'b10000; Cin <= 0;
   #10 A <= 8'bXXXXXXXX; B <= 8'bXXXXXXXX; S <= 5'b11000; Cin <= 0;
   #10
   $finish;
   end
   alu alu1(S, Cin, A, B, Y);
   endmodule