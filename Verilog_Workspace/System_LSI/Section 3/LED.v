module led(
  input  key, //输入按键，默认为高电平
  output  led //输出LED，高电平点亮
);

//当key = 1, led = 0; 当key = 0, led = 1; 
assign led = ~key;

endmodule