module cpu_axi
	#(parameter ADDR_WIDTH = 32,
	  parameter DATA_WIDTH = 32)
	(input AXI_PCLK,
	input AXI_PRESETn,
	/* Write address channel */
	output [ADDR_WIDTH-1:0] AXI4Lite_AWADDR,
	output [2:0] AXI4Lite_AWPROT,
	output AXI4Lite_AWVALID,
	input AXI4Lite_AWREADY,
	/* Write data channel */
	output [DATA_WIDTH-1:0] AXI4Lite_WDATA,
	output [DATA_WIDTH/8-1:0] AXI4Lite_WSTRB,
	output AXI4Lite_WVALID,
	input AXI4Lite_WREADY,
	/* Write response channel */
	input [1:0] AXI4Lite_BRESP,
	input AXI4Lite_BVALID,
	output AXI4Lite_BREADY,
	/* Read address channel */
	output [ADDR_WIDTH-1:0] AXI4Lite_ARADDR,
	output [2:0] AXI4Lite_ARPROT,
	output AXI4Lite_ARVALID,
	input AXI4Lite_ARREADY,
	/* Read data channel */
	input [DATA_WIDTH-1:0] AXI4Lite_RDATA,
	input [1:0] AXI4Lite_RRESP,
	input AXI4Lite_RVALID,
	output AXI4Lite_RREADY,

	output halted,
	input cpu_interrupt,
	output APB_perr,
	output bit);
/* iverilog -o test -g2012 -DSYSTEM_VERILOG_2012_ICARUS -Ihdl hdl/alu.v hdl/cpu.v hdl/intctrl.v  hdl/APB.v hdl/uart.v hdl/timer.v hdl/sram.v hdl/soc_top_iverilog.v  hdl/ram.v hdl/axi.v hdl/axiram_wrapper.v */
	wire [ADDR_WIDTH-1:0] APB_paddr;
	wire [DATA_WIDTH-1:0] APB_pdata;
	wire [DATA_WIDTH-1:0] APB_prdata;
	wire APB_psel;
	wire APB_penable;
	wire APB_pwrite;
	wire [3:0] APB_pstb;
	wire APB_pready;
	assign bit = APB_pready;

	wire [ADDR_WIDTH-1:0] old_pc;
	wire [DATA_WIDTH-1:0] odat;

	AXI4Lite_translator axi(AXI_PCLK, AXI_PRESETn, AXI4Lite_AWADDR, AXI4Lite_AWPROT, AXI4Lite_AWVALID, AXI4Lite_AWREADY, AXI4Lite_WDATA, AXI4Lite_WSTRB, AXI4Lite_WVALID, AXI4Lite_WREADY, AXI4Lite_BRESP, AXI4Lite_BVALID, AXI4Lite_BREADY, AXI4Lite_ARADDR, AXI4Lite_ARPROT, AXI4Lite_ARVALID, AXI4Lite_ARREADY, AXI4Lite_RDATA, AXI4Lite_RRESP, AXI4Lite_RVALID, AXI4Lite_RREADY, APB_paddr, APB_prdata, APB_pdata, APB_penable, APB_pwrite, APB_pstb, APB_pready, APB_perr);

	cpu	riscv_cpu(AXI_PCLK, AXI_PRESETn, APB_paddr, APB_pdata, APB_prdata, APB_psel,
			  APB_penable, APB_pwrite, APB_pstb, APB_pready, APB_perr, cpu_interrupt,
			  halted, odat, old_pc);
endmodule
