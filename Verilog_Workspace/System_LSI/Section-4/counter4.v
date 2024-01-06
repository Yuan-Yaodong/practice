// Design 4-2
module count4(Y,CTL,clock,reset);

output [3:0] Y;
input CTL, clock, reset;
reg [3:0] Y;

always @(posedge clock or negedge reset)
   begin
     if (!reset) Y<=0;
     else if (!CTL)  Y<=Y+1; // up
     else Y<=Y-1; // down
   end
endmodule
