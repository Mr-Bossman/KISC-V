`ifndef SYSTEM_VERILOG_2012
`ifdef SYSTEM_VERILOG_2012_VERILATOR
`define SYSTEM_VERILOG_2012
`endif
`endif

`ifdef SYSTEM_VERILOG_2012
`define always_comb_sys always_comb
`define always_ff_sys always_ff
`define unique_sys unique
`elsif SYSTEM_VERILOG_2012_ICARUS
`define always_comb_sys always_comb
`define always_ff_sys always_ff
`define unique_sys
`else
`define always_comb_sys always @(*)
`define always_ff_sys always
`define unique_sys
`endif

`ifndef SYSTEM_VERILOG_2012_VERILATOR
`ifndef SYSTEM_VERILOG_2012_ICARUS
`define NO_SYS_ROM
`endif
`endif

`ifdef SYSTEM_VERILOG_2012_VERILATOR
`define SIMULATION
`elsif SYSTEM_VERILOG_2012_ICARUS
`define SIMULATION
`elsif MODEL_TECH
`define SIMULATION
`elsif QUESTA
`define SIMULATION
`endif

`ifdef SYSTEM_VERILOG_2012_VERILATOR
`define DO_DISPLAY
`elsif SYSTEM_VERILOG_2012_ICARUS
`define DO_DISPLAY
`endif
