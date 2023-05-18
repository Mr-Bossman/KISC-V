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
