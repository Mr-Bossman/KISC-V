# TCL File Generated by Component Editor 22.1
# Sun Nov 26 23:10:25 EST 2023
# DO NOT MODIFY


# 
# cpu "cpu" v1.0
#  2023.11.26.23:10:25
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module cpu
# 
set_module_property DESCRIPTION ""
set_module_property NAME cpu
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME cpu
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL cpu_axi
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file axicpu_wrapper.v VERILOG PATH ../hdl/axicpu_wrapper.v TOP_LEVEL_FILE
add_fileset_file alu.v VERILOG PATH ../hdl/alu.v
add_fileset_file axi.v VERILOG PATH ../hdl/axi.v
add_fileset_file cpu.v VERILOG PATH ../hdl/cpu.v
add_fileset_file sys.v VERILOG PATH ../hdl/sys.v
add_fileset_file apb_align.v VERILOG PATH ../hdl/apb_align.v
add_fileset_file APB.v VERILOG PATH ../hdl/APB.v
add_fileset_file intctrl.v VERILOG PATH ../hdl/intctrl.v
add_fileset_file timer.v VERILOG PATH ../hdl/timer.v
add_fileset_file uart_wraper.v VERILOG PATH ../hdl/uart_wraper.v
add_fileset_file gh_DECODE_3to8.vhd VHDL PATH ../opencores/library/gh_DECODE_3to8.vhd
add_fileset_file gh_baud_rate_gen.vhd VHDL PATH ../opencores/library/gh_baud_rate_gen.vhd
add_fileset_file gh_binary2gray.vhd VHDL PATH ../opencores/library/gh_binary2gray.vhd
add_fileset_file gh_counter_down_ce_ld.vhd VHDL PATH ../opencores/library/gh_counter_down_ce_ld.vhd
add_fileset_file gh_counter_down_ce_ld_tc.vhd VHDL PATH ../opencores/library/gh_counter_down_ce_ld_tc.vhd
add_fileset_file gh_counter_integer_down.vhd VHDL PATH ../opencores/library/gh_counter_integer_down.vhd
add_fileset_file gh_edge_det.vhd VHDL PATH ../opencores/library/gh_edge_det.vhd
add_fileset_file gh_edge_det_XCD.vhd VHDL PATH ../opencores/library/gh_edge_det_XCD.vhd
add_fileset_file gh_gray2binary.vhd VHDL PATH ../opencores/library/gh_gray2binary.vhd
add_fileset_file gh_jkff.vhd VHDL PATH ../opencores/library/gh_jkff.vhd
add_fileset_file gh_parity_gen_Serial.vhd VHDL PATH ../opencores/library/gh_parity_gen_Serial.vhd
add_fileset_file gh_register_ce.vhd VHDL PATH ../opencores/library/gh_register_ce.vhd
add_fileset_file gh_shift_reg_PL_sl.vhd VHDL PATH ../opencores/library/gh_shift_reg_PL_sl.vhd
add_fileset_file gh_shift_reg_se_sl.vhd VHDL PATH ../opencores/library/gh_shift_reg_se_sl.vhd
add_fileset_file gh_fifo_async16_rcsr_wf.vhd VHDL PATH ../opencores/uart/gh_fifo_async16_rcsr_wf.vhd
add_fileset_file gh_fifo_async16_sr.vhd VHDL PATH ../opencores/uart/gh_fifo_async16_sr.vhd
add_fileset_file gh_uart_16550.vhd VHDL PATH ../opencores/uart/gh_uart_16550.vhd
add_fileset_file gh_uart_16550_amba_apb_wrapper.vhd VHDL PATH ../opencores/uart/gh_uart_16550_amba_apb_wrapper.vhd
add_fileset_file gh_uart_Rx_8bit.vhd VHDL PATH ../opencores/uart/gh_uart_Rx_8bit.vhd
add_fileset_file gh_uart_Tx_8bit.vhd VHDL PATH ../opencores/uart/gh_uart_Tx_8bit.vhd

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL cpu_axi
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file axicpu_wrapper.v VERILOG PATH ../hdl/axicpu_wrapper.v
add_fileset_file alu.v VERILOG PATH ../hdl/alu.v
add_fileset_file axi.v VERILOG PATH ../hdl/axi.v
add_fileset_file cpu.v VERILOG PATH ../hdl/cpu.v
add_fileset_file sys.v VERILOG PATH ../hdl/sys.v
add_fileset_file apb_align.v VERILOG PATH ../hdl/apb_align.v
add_fileset_file APB.v VERILOG PATH ../hdl/APB.v
add_fileset_file intctrl.v VERILOG PATH ../hdl/intctrl.v
add_fileset_file timer.v VERILOG PATH ../hdl/timer.v
add_fileset_file uart_wraper.v VERILOG PATH ../hdl/uart_wraper.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file gh_DECODE_3to8.vhd VHDL PATH ../opencores/library/gh_DECODE_3to8.vhd
add_fileset_file gh_baud_rate_gen.vhd VHDL PATH ../opencores/library/gh_baud_rate_gen.vhd
add_fileset_file gh_binary2gray.vhd VHDL PATH ../opencores/library/gh_binary2gray.vhd
add_fileset_file gh_counter_down_ce_ld.vhd VHDL PATH ../opencores/library/gh_counter_down_ce_ld.vhd
add_fileset_file gh_counter_down_ce_ld_tc.vhd VHDL PATH ../opencores/library/gh_counter_down_ce_ld_tc.vhd
add_fileset_file gh_counter_integer_down.vhd VHDL PATH ../opencores/library/gh_counter_integer_down.vhd
add_fileset_file gh_edge_det.vhd VHDL PATH ../opencores/library/gh_edge_det.vhd
add_fileset_file gh_edge_det_XCD.vhd VHDL PATH ../opencores/library/gh_edge_det_XCD.vhd
add_fileset_file gh_gray2binary.vhd VHDL PATH ../opencores/library/gh_gray2binary.vhd
add_fileset_file gh_jkff.vhd VHDL PATH ../opencores/library/gh_jkff.vhd
add_fileset_file gh_parity_gen_Serial.vhd VHDL PATH ../opencores/library/gh_parity_gen_Serial.vhd
add_fileset_file gh_register_ce.vhd VHDL PATH ../opencores/library/gh_register_ce.vhd
add_fileset_file gh_shift_reg_PL_sl.vhd VHDL PATH ../opencores/library/gh_shift_reg_PL_sl.vhd
add_fileset_file gh_shift_reg_se_sl.vhd VHDL PATH ../opencores/library/gh_shift_reg_se_sl.vhd
add_fileset_file gh_fifo_async16_rcsr_wf.vhd VHDL PATH ../opencores/uart/gh_fifo_async16_rcsr_wf.vhd
add_fileset_file gh_fifo_async16_sr.vhd VHDL PATH ../opencores/uart/gh_fifo_async16_sr.vhd
add_fileset_file gh_uart_16550.vhd VHDL PATH ../opencores/uart/gh_uart_16550.vhd
add_fileset_file gh_uart_16550_amba_apb_wrapper.vhd VHDL PATH ../opencores/uart/gh_uart_16550_amba_apb_wrapper.vhd
add_fileset_file gh_uart_Rx_8bit.vhd VHDL PATH ../opencores/uart/gh_uart_Rx_8bit.vhd
add_fileset_file gh_uart_Tx_8bit.vhd VHDL PATH ../opencores/uart/gh_uart_Tx_8bit.vhd


# 
# parameters
# 
add_parameter ADDR_WIDTH INTEGER 32
set_parameter_property ADDR_WIDTH DEFAULT_VALUE 32
set_parameter_property ADDR_WIDTH DISPLAY_NAME ADDR_WIDTH
set_parameter_property ADDR_WIDTH TYPE INTEGER
set_parameter_property ADDR_WIDTH UNITS None
set_parameter_property ADDR_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ADDR_WIDTH HDL_PARAMETER true
add_parameter DATA_WIDTH INTEGER 32
set_parameter_property DATA_WIDTH DEFAULT_VALUE 32
set_parameter_property DATA_WIDTH DISPLAY_NAME DATA_WIDTH
set_parameter_property DATA_WIDTH TYPE INTEGER
set_parameter_property DATA_WIDTH UNITS None
set_parameter_property DATA_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property DATA_WIDTH HDL_PARAMETER true


# 
# display items
# 


# 
# connection point rts
# 
add_interface rts reset end
set_interface_property rts associatedClock clk
set_interface_property rts synchronousEdges DEASSERT
set_interface_property rts ENABLED true
set_interface_property rts EXPORT_OF ""
set_interface_property rts PORT_NAME_MAP ""
set_interface_property rts CMSIS_SVD_VARIABLES ""
set_interface_property rts SVD_ADDRESS_GROUP ""

add_interface_port rts AXI_PRESETn reset_n Input 1


# 
# connection point axi4lite
# 
add_interface axi4lite axi4lite start
set_interface_property axi4lite associatedClock clk
set_interface_property axi4lite associatedReset rts
set_interface_property axi4lite readIssuingCapability 1
set_interface_property axi4lite writeIssuingCapability 1
set_interface_property axi4lite combinedIssuingCapability 1
set_interface_property axi4lite ENABLED true
set_interface_property axi4lite EXPORT_OF ""
set_interface_property axi4lite PORT_NAME_MAP ""
set_interface_property axi4lite CMSIS_SVD_VARIABLES ""
set_interface_property axi4lite SVD_ADDRESS_GROUP ""

add_interface_port axi4lite AXI4Lite_AWADDR awaddr Output "((ADDR_WIDTH-1)) - (0) + 1"
add_interface_port axi4lite AXI4Lite_AWPROT awprot Output 3
add_interface_port axi4lite AXI4Lite_AWVALID awvalid Output 1
add_interface_port axi4lite AXI4Lite_AWREADY awready Input 1
add_interface_port axi4lite AXI4Lite_WDATA wdata Output "((DATA_WIDTH-1)) - (0) + 1"
add_interface_port axi4lite AXI4Lite_WSTRB wstrb Output "(((DATA_WIDTH/8)-1)) - (0) + 1"
add_interface_port axi4lite AXI4Lite_WVALID wvalid Output 1
add_interface_port axi4lite AXI4Lite_WREADY wready Input 1
add_interface_port axi4lite AXI4Lite_BRESP bresp Input 2
add_interface_port axi4lite AXI4Lite_BVALID bvalid Input 1
add_interface_port axi4lite AXI4Lite_BREADY bready Output 1
add_interface_port axi4lite AXI4Lite_ARADDR araddr Output "((ADDR_WIDTH-1)) - (0) + 1"
add_interface_port axi4lite AXI4Lite_ARPROT arprot Output 3
add_interface_port axi4lite AXI4Lite_RVALID rvalid Input 1
add_interface_port axi4lite AXI4Lite_ARREADY arready Input 1
add_interface_port axi4lite AXI4Lite_RDATA rdata Input "((DATA_WIDTH-1)) - (0) + 1"
add_interface_port axi4lite AXI4Lite_RRESP rresp Input 2
add_interface_port axi4lite AXI4Lite_RREADY rready Output 1
add_interface_port axi4lite AXI4Lite_ARVALID arvalid Output 1


# 
# connection point halted
# 
add_interface halted conduit end
set_interface_property halted associatedClock clk
set_interface_property halted associatedReset ""
set_interface_property halted ENABLED true
set_interface_property halted EXPORT_OF ""
set_interface_property halted PORT_NAME_MAP ""
set_interface_property halted CMSIS_SVD_VARIABLES ""
set_interface_property halted SVD_ADDRESS_GROUP ""

add_interface_port halted halted halted Output 1


# 
# connection point cpu_interrupt
# 
add_interface cpu_interrupt conduit end
set_interface_property cpu_interrupt associatedClock ""
set_interface_property cpu_interrupt associatedReset ""
set_interface_property cpu_interrupt ENABLED true
set_interface_property cpu_interrupt EXPORT_OF ""
set_interface_property cpu_interrupt PORT_NAME_MAP ""
set_interface_property cpu_interrupt CMSIS_SVD_VARIABLES ""
set_interface_property cpu_interrupt SVD_ADDRESS_GROUP ""

add_interface_port cpu_interrupt cpu_interrupt cpu_interrupt Input 1


# 
# connection point APB_perr
# 
add_interface APB_perr conduit end
set_interface_property APB_perr associatedClock clk
set_interface_property APB_perr associatedReset ""
set_interface_property APB_perr ENABLED true
set_interface_property APB_perr EXPORT_OF ""
set_interface_property APB_perr PORT_NAME_MAP ""
set_interface_property APB_perr CMSIS_SVD_VARIABLES ""
set_interface_property APB_perr SVD_ADDRESS_GROUP ""

add_interface_port APB_perr APB_perr apb_perr Output 1


# 
# connection point clk
# 
add_interface clk clock end
set_interface_property clk clockRate 0
set_interface_property clk ENABLED true
set_interface_property clk EXPORT_OF ""
set_interface_property clk PORT_NAME_MAP ""
set_interface_property clk CMSIS_SVD_VARIABLES ""
set_interface_property clk SVD_ADDRESS_GROUP ""

add_interface_port clk AXI_PCLK clk Input 1


# 
# connection point UART
# 
add_interface UART conduit end
set_interface_property UART associatedClock clk
set_interface_property UART associatedReset ""
set_interface_property UART ENABLED true
set_interface_property UART EXPORT_OF ""
set_interface_property UART PORT_NAME_MAP ""
set_interface_property UART CMSIS_SVD_VARIABLES ""
set_interface_property UART SVD_ADDRESS_GROUP ""

add_interface_port UART sRX srx Input 1
add_interface_port UART sTX stx Output 1


# 
# connection point BR_clk
# 
add_interface BR_clk clock end
set_interface_property BR_clk clockRate 0
set_interface_property BR_clk ENABLED true
set_interface_property BR_clk EXPORT_OF ""
set_interface_property BR_clk PORT_NAME_MAP ""
set_interface_property BR_clk CMSIS_SVD_VARIABLES ""
set_interface_property BR_clk SVD_ADDRESS_GROUP ""

add_interface_port BR_clk BR_clk clk Input 1

