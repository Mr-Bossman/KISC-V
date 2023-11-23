# TCL File Generated by Component Editor 22.1
# Sun Nov 26 16:12:24 EST 2023
# DO NOT MODIFY


# 
# sdram "sdram" v1.0
#  2023.11.26.16:12:24
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module sdram
# 
set_module_property DESCRIPTION ""
set_module_property NAME sdram
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME sdram
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL sdram_axi_wrapper
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file sdram_axi.v VERILOG PATH ../opencores/core_sdram_axi4/src_v/sdram_axi.v
add_fileset_file sdram_axi_core.v VERILOG PATH ../opencores/core_sdram_axi4/src_v/sdram_axi_core.v
add_fileset_file sdram_axi_pmem.v VERILOG PATH ../opencores/core_sdram_axi4/src_v/sdram_axi_pmem.v
add_fileset_file sdram_wrapper.v VERILOG PATH ../hdl/sdram_wrapper.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file sdram_axi.v VERILOG PATH ../opencores/core_sdram_axi4/src_v/sdram_axi.v
add_fileset_file sdram_axi_core.v VERILOG PATH ../opencores/core_sdram_axi4/src_v/sdram_axi_core.v
add_fileset_file sdram_axi_pmem.v VERILOG PATH ../opencores/core_sdram_axi4/src_v/sdram_axi_pmem.v
add_fileset_file sdram_wrapper.v VERILOG PATH ../hdl/sdram_wrapper.v


# 
# parameters
# 
add_parameter SDRAM_MHZ INTEGER 50 ""
set_parameter_property SDRAM_MHZ DEFAULT_VALUE 50
set_parameter_property SDRAM_MHZ DISPLAY_NAME SDRAM_MHZ
set_parameter_property SDRAM_MHZ TYPE INTEGER
set_parameter_property SDRAM_MHZ UNITS None
set_parameter_property SDRAM_MHZ ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SDRAM_MHZ DESCRIPTION ""
set_parameter_property SDRAM_MHZ HDL_PARAMETER true
add_parameter SDRAM_ADDR_W INTEGER 25 ""
set_parameter_property SDRAM_ADDR_W DEFAULT_VALUE 25
set_parameter_property SDRAM_ADDR_W DISPLAY_NAME SDRAM_ADDR_W
set_parameter_property SDRAM_ADDR_W TYPE INTEGER
set_parameter_property SDRAM_ADDR_W UNITS None
set_parameter_property SDRAM_ADDR_W ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SDRAM_ADDR_W DESCRIPTION ""
set_parameter_property SDRAM_ADDR_W HDL_PARAMETER true
add_parameter SDRAM_COL_W INTEGER 10 ""
set_parameter_property SDRAM_COL_W DEFAULT_VALUE 10
set_parameter_property SDRAM_COL_W DISPLAY_NAME SDRAM_COL_W
set_parameter_property SDRAM_COL_W TYPE INTEGER
set_parameter_property SDRAM_COL_W UNITS None
set_parameter_property SDRAM_COL_W ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SDRAM_COL_W DESCRIPTION ""
set_parameter_property SDRAM_COL_W HDL_PARAMETER true
add_parameter SDRAM_READ_LATENCY INTEGER 3 ""
set_parameter_property SDRAM_READ_LATENCY DEFAULT_VALUE 3
set_parameter_property SDRAM_READ_LATENCY DISPLAY_NAME SDRAM_READ_LATENCY
set_parameter_property SDRAM_READ_LATENCY TYPE INTEGER
set_parameter_property SDRAM_READ_LATENCY UNITS None
set_parameter_property SDRAM_READ_LATENCY ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SDRAM_READ_LATENCY DESCRIPTION ""
set_parameter_property SDRAM_READ_LATENCY HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk_i clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset rst_i reset Input 1


# 
# connection point sdram
# 
add_interface sdram conduit end
set_interface_property sdram associatedClock clock
set_interface_property sdram associatedReset ""
set_interface_property sdram ENABLED true
set_interface_property sdram EXPORT_OF ""
set_interface_property sdram PORT_NAME_MAP ""
set_interface_property sdram CMSIS_SVD_VARIABLES ""
set_interface_property sdram SVD_ADDRESS_GROUP ""

add_interface_port sdram sdram_data sdram_data Bidir 16
add_interface_port sdram sdram_clk_o sdram_clk_o Output 1
add_interface_port sdram sdram_cke_o sdram_cke_o Output 1
add_interface_port sdram sdram_cs_o sdram_cs_o Output 1
add_interface_port sdram sdram_ras_o sdram_ras_o Output 1
add_interface_port sdram sdram_cas_o sdram_cas_o Output 1
add_interface_port sdram sdram_we_o sdram_we_o Output 1
add_interface_port sdram sdram_dqm_o sdram_dqm_o Output 2
add_interface_port sdram sdram_addr_o sdram_addr_o Output 13
add_interface_port sdram sdram_ba_o sdram_ba_o Output 2


# 
# connection point inport
# 
add_interface inport axi4 end
set_interface_property inport associatedClock clock
set_interface_property inport associatedReset reset
set_interface_property inport readAcceptanceCapability 1
set_interface_property inport writeAcceptanceCapability 1
set_interface_property inport combinedAcceptanceCapability 1
set_interface_property inport readDataReorderingDepth 1
set_interface_property inport bridgesToMaster ""
set_interface_property inport ENABLED true
set_interface_property inport EXPORT_OF ""
set_interface_property inport PORT_NAME_MAP ""
set_interface_property inport CMSIS_SVD_VARIABLES ""
set_interface_property inport SVD_ADDRESS_GROUP ""

add_interface_port inport inport_araddr_i araddr Input 25
add_interface_port inport inport_awvalid_i awvalid Input 1
add_interface_port inport inport_awaddr_i awaddr Input 25
add_interface_port inport inport_awid_i awid Input 4
add_interface_port inport inport_awlen_i awlen Input 8
add_interface_port inport inport_awburst_i awburst Input 2
add_interface_port inport inport_wvalid_i wvalid Input 1
add_interface_port inport inport_wdata_i wdata Input 32
add_interface_port inport inport_wready_o wready Output 1
add_interface_port inport inport_wstrb_i wstrb Input 4
add_interface_port inport inport_wlast_i wlast Input 1
add_interface_port inport inport_bready_i bready Input 1
add_interface_port inport inport_arvalid_i arvalid Input 1
add_interface_port inport inport_arid_i arid Input 4
add_interface_port inport inport_arlen_i arlen Input 8
add_interface_port inport inport_arburst_i arburst Input 2
add_interface_port inport inport_rready_i rready Input 1
add_interface_port inport inport_awready_o awready Output 1
add_interface_port inport inport_bvalid_o bvalid Output 1
add_interface_port inport inport_bresp_o bresp Output 2
add_interface_port inport inport_bid_o bid Output 4
add_interface_port inport inport_arready_o arready Output 1
add_interface_port inport inport_rvalid_o rvalid Output 1
add_interface_port inport inport_rdata_o rdata Output 32
add_interface_port inport inport_rresp_o rresp Output 2
add_interface_port inport inport_rid_o rid Output 4
add_interface_port inport inport_rlast_o rlast Output 1
add_interface_port inport inport_arsize_i arsize Input 3
add_interface_port inport inport_awsize_i awsize Input 3

