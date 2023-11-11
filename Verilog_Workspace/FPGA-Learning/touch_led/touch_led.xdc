#time constraints
create_clock -period 20.000 -name sys_clk [get_ports sys_clk] 

#IO constraints
#----------------------CLOCK---------------------------
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports sys_clk]

#----------------------RESET---------------------------
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]

#----------------------PL_LED---------------------------
#µ×°å
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports led]

#----------------------´¥Ãþ°´¼ü---------------------------
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports touch_key]