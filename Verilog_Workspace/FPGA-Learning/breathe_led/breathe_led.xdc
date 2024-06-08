# time constraints
create_clock  -period 20.000 -name sys_clk [get_ports sys_clk]

# IO constraints 

#-----------------------------System Clock---------------------------------------
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports sys_clk]

#-----------------------------System Reset---------------------------------------
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]

#-----------------------------Core Board-----------------------------------------
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports led]

