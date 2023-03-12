set_property PACKAGE_PIN L19 [get_ports reset_rtl]
set_property IOSTANDARD LVCMOS33 [get_ports reset_rtl]
set_property PACKAGE_PIN M14 [get_ports halted]
set_property IOSTANDARD LVTTL [get_ports halted]

set_property PACKAGE_PIN H16 [get_ports sys_clock]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clock]

set_property PACKAGE_PIN T14 [get_ports sRX_0]
set_property PACKAGE_PIN U12 [get_ports sTX_0]
set_property IOSTANDARD LVCMOS33 [get_ports sRX_0]
set_property IOSTANDARD LVCMOS33 [get_ports sTX_0]

set_property PACKAGE_PIN V13 [get_ports SO_0]
set_property PACKAGE_PIN V15 [get_ports SI_0]
set_property PACKAGE_PIN U13 [get_ports cs_0]
set_property IOSTANDARD LVCMOS33 [get_ports SO_0]
set_property IOSTANDARD LVTTL [get_ports SI_0]
set_property IOSTANDARD LVCMOS33 [get_ports cs_0]


set_property PACKAGE_PIN T15 [get_ports clk_out1_0]
set_property IOSTANDARD LVTTL [get_ports clk_out1_0]

set_property DRIVE 16 [get_ports cs_0]
set_property DRIVE 24 [get_ports halted]
set_property DRIVE 24 [get_ports SI_0]
set_property DRIVE 16 [get_ports sTX_0]
set_property DRIVE 24 [get_ports clk_out1_0]

set_property PULLDOWN true [get_ports SO_0]
