// Syncronous: Asyncronous to Syncronous (1bit width)
module syncro(out, in, sys_clk, rst_n);
  parameter WIDTH = 1;               // define the width of data
  input    [WIDTH-1:0] in ;
  output   [WIDTH-1:0] out;
  input    sys_clk,rst_n;
  reg      [WIDTH-1:0] qO,q1,q2;

  always @(posedge sys_clk or negedge rst_n)
   begin
    if(!rst_n)
     begin
       qO <= 0;
       q1 <= 0;
       q2 <= 0;
     end
    else
     begin
       qO <= ~in;
       q1 <= qO;
       q2 <= q1;
     end
   end
  assign out=q1 & (~q2);
endmodule

// Syncronous: Asyncronous to syncronous (10bit width)
module syncro10(out, in, sys_clk, rst_n);
  parameter WIDTH = 10;
  input    [WIDTH-1:0] in;
  output   [WIDTH-1:0] out;
  input     sys_clk,rst_n;
  reg      [WIDTH-1:0] qO,q1,q2;

  always @(posedge sys_clk or negedge rst_n)
   begin
    if(!rst_n)
     begin
       qO <= 0;
       q1 <= 0;
       q2 <= 0;
     end
    else
     begin
       qO <= ~in;
       q1 <= qO;
       q2 <= q1;
     end
   end
  assign out=q1 & (~q2) ;
endmodule