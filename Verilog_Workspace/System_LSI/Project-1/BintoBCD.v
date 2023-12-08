// Bintobcd: Translation from Binary to BCD format
module BintoBCD(in,
                out_low,
                out_middle_1, 
                out_middle_2,
                out_middle_3,
                out_middle_4,
                out_middle_5,
                out_middle_6,
                out_high);
                
    input  [27:0] in;
    output [3:0] out_low, out_high;
    output [3:0] out_middle_1, out_middle_2, out_middle_3, out_middle_4, out_middle_5, out_middle_6;

    wire [27:0] temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16;
    wire [27:0] temp17, temp18, temp19, temp20, temp21, temp22, temp23, temp24, temp25, temp26, temp27;

    // first 4 bits to BCD
  assign out_high[3] = (in >= 80000000)    ? 1            : 0;
  assign temp1   =     (in >= 80000000)    ? in - 80000000    : in;
  assign out_high[2] = (temp1 >= 40000000) ? 1            : 0;
  assign temp2   =     (temp1 >= 40000000) ? temp1 - 40000000 : temp1;
  assign out_high[1] = (temp2 >= 20000000) ? 1            : 0;
  assign temp3   =     (temp2 >= 20000000) ? temp2 - 20000000 : temp2;
  assign out_high[0] = (temp3 >= 10000000) ? 1            : 0;
  assign temp4   =     (temp3 >= 10000000) ? temp3 - 10000000 : temp3;

  assign out_middle_6[3] =    (temp4 >= 8000000) ? 1            : 0;
  assign temp5   =            (temp4 >= 8000000) ? temp4 - 8000000  : temp4;
  assign out_middle_6[2] =    (temp5 >= 4000000) ? 1            : 0;
  assign temp6   =            (temp5 >= 4000000) ? temp5 - 4000000  : temp5;
  assign out_middle_6[1] =    (temp6 >= 2000000) ? 1            : 0;
  assign temp7   =            (temp6 >= 2000000) ? temp6 - 2000000  : temp6;
  assign out_middle_6[0] =    (temp7 >= 1000000) ? 1            : 0;
  assign temp8   =            (temp7 >= 1000000) ? temp7 - 1000000  : temp7;
  
  assign out_middle_5[3] =   (temp8 >= 800000)  ? 1            : 0;
  assign temp9   =           (temp8 >= 800000)  ? temp8 - 800000   : temp8;
  assign out_middle_5[2] =   (temp9 >= 400000)  ? 1            : 0;
  assign temp10   =          (temp9 >= 400000)  ? temp9 - 400000   : temp9;
  assign out_middle_5[1] =   (temp10 >= 200000) ? 1            : 0;
  assign temp11   =          (temp10 >= 200000) ? temp10 - 200000  : temp10;
  assign out_middle_5[0] =   (temp11 >= 100000) ? 1            : 0;
  assign temp12   =          (temp11 >= 100000) ? temp11 - 100000  : temp11;

  assign out_middle_4[3] = (temp12 >= 80000)  ? 1            : 0;
  assign temp13   =        (temp12 >= 80000) ? temp12 - 80000 : temp12;
  assign out_middle_4[2] = (temp13 >= 40000) ? 1            : 0;
  assign temp14   =        (temp13 >= 40000) ? temp13 - 40000 : temp13;
  assign out_middle_4[1] = (temp14 >= 20000) ? 1            : 0;
  assign temp15   =        (temp14 >= 20000) ? temp14 - 20000 : temp14;
  assign out_middle_4[0] = (temp15 >= 10000) ? 1            : 0;
  assign temp16   =        (temp15 >= 10000) ? temp15 - 10000 : temp15;



    // left 4 bits to BCD
  assign out_middle_3[3] =      (temp16 >= 8000) ? 1            : 0;
  assign temp17   =             (temp16 >= 8000) ? temp16 - 8000  : temp16;
  assign out_middle_3[2] =      (temp17 >= 4000) ? 1            : 0;
  assign temp18   =             (temp17 >= 4000) ? temp17 - 4000  : temp17;
  assign out_middle_3[1] =      (temp18 >= 2000) ? 1            : 0;
  assign temp19   =             (temp18 >= 2000) ? temp18 - 2000  : temp18;
  assign out_middle_3[0] =      (temp19 >= 1000) ? 1            : 0;
  assign temp20   =             (temp19 >= 1000) ? temp19 - 1000  : temp19;
  
  assign out_middle_2[3] =     (temp20 >= 800) ? 1            : 0;
  assign temp21   =            (temp20 >= 800) ? temp20 - 800  : temp20;
  assign out_middle_2[2] =     (temp21 >= 400) ? 1            : 0;
  assign temp22   =            (temp21 >= 400) ? temp21 - 400  : temp21;
  assign out_middle_2[1] =     (temp22 >= 200) ? 1            : 0;
  assign temp23   =            (temp22 >= 200) ? temp22 - 200  : temp22;
  assign out_middle_2[0] =     (temp23 >= 100) ? 1            : 0;
  assign temp24   =            (temp23 >= 100) ? temp23 - 100  : temp23;

  assign out_middle_1[3] =     (temp24 >= 80) ? 1            : 0;
  assign temp25   =            (temp24 >= 80) ? temp24 - 80  : temp24;
  assign out_middle_1[2] =     (temp25 >= 40) ? 1            : 0;
  assign temp26   =            (temp25 >= 40) ? temp25 - 40  : temp25;
  assign out_middle_1[1] =     (temp26 >= 20) ? 1            : 0;
  assign temp27   =            (temp26 >= 20) ? temp26 - 20  : temp26;
  assign out_middle_1[0] =     (temp27 >= 10) ? 1            : 0;
  assign out_low  =            (temp27 >= 10) ? temp27 - 10  : temp27;


endmodule
