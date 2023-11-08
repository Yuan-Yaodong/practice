// Design EX-3-1
module encoder (sel, a0, a1, a2, a3, a4, a5, a6, a7, y);
  input sel, a0, a1, a2, a3, a4, a5, a6, a7;
  output [2:0] y;
  reg [2:0] y;

always @(sel or a0 or a1 or a2 or a3
           or a4 or a5 or a6 or a7)
        if ( sel == 1 && a0 == 1 && (a1+a2+a3+a4+a5+a6+a7) == 0)
            y = 3'b000;
            else if ( sel == 1 && a1 == 1 && (a0+a2+a3+a4+a5+a6+a7) == 0)
            y = 3'b001;
            else if ( sel == 1 && a2 == 1 && (a0+a1+a3+a4+a5+a6+a7) == 0)
            y = 3'b010;
            else if ( sel == 1 && a3 == 1 && (a0+a2+a1+a4+a5+a6+a7) == 0)
            y = 3'b011;
            else if ( sel == 1 && a4 == 1 && (a0+a2+a3+a1+a5+a6+a7) == 0)
            y = 3'b100;
            else if ( sel == 1 && a5 == 1 && (a0+a2+a3+a4+a1+a6+a7) == 0)
            y = 3'b101;
            else if ( sel == 1 && a6 == 1 && (a0+a2+a3+a4+a5+a1+a7) == 0)
            y = 3'b110;
            else if ( sel == 1 && a7 == 1 && (a0+a2+a3+a4+a5+a6+a1) == 0)
            y = 3'b111;
          else if (sel == 0) y = 3'b000; // sel = 0 
          
    endmodule