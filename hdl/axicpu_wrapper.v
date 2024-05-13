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
	input BR_clk,
	input sRX,
	output sTX);

	wire [ADDR_WIDTH-1:0] APB_paddr;
	wire [DATA_WIDTH-1:0] APB_pdata;
	wire [DATA_WIDTH-1:0] APB_prdata;
	wire APB_psel;
	wire APB_penable;
	wire APB_pwrite;
	wire [3:0] APB_pstb;
	wire APB_pready;

	wire [ADDR_WIDTH-1:0] old_pc;
	wire [DATA_WIDTH-1:0] odat;

	wire [ADDR_WIDTH-1:0] axi4_aligned_paddr;
	wire [DATA_WIDTH-1:0] axi4_aligned_pdata;
	wire [DATA_WIDTH-1:0] axi4_aligned_prdata;
	wire [3:0] axi4_aligned_pstb;
	wire axi4_aligned_penable;
	wire axi4_aligned_pready;
	wire apb_cpu_interrupt;

	wire AXI_sel;
	wire AXI_enable;
	wire [DATA_WIDTH-1:0]AXI_data;
	wire AXI_ready;
	wire AXI_perr;

	wire uart_sel;
	wire uart_enable;
	wire [DATA_WIDTH-1:0]uart_data;
	wire uart_ready;
	wire uart_perr;

	wire system_sel;
	wire system_enable;
	wire [DATA_WIDTH-1:0]system_data;
	wire system_ready;
	wire system_perr;

	wire intc_sel;
	wire intc_enable;
	wire [DATA_WIDTH-1:0]intc_data;
	wire intc_ready;
	wire intc_perr;

	wire timer_interrupt;
	wire timer_sel;
	wire timer_enable;
	wire [DATA_WIDTH-1:0]timer_data;
	wire timer_ready;
	wire timer_perr;

	apb_align	allign(AXI_PCLK, AXI_PRESETn, APB_paddr, APB_pdata, AXI_data, AXI_sel,
			       AXI_enable, APB_pwrite, APB_pstb, AXI_ready, axi4_aligned_paddr,
			       axi4_aligned_pdata, axi4_aligned_prdata, axi4_aligned_penable,
			       axi4_aligned_pstb, axi4_aligned_pready);

	AXI4Lite_translator axi(AXI_PCLK, AXI_PRESETn, AXI4Lite_AWADDR, AXI4Lite_AWPROT,
		AXI4Lite_AWVALID, AXI4Lite_AWREADY, AXI4Lite_WDATA, AXI4Lite_WSTRB,
		AXI4Lite_WVALID, AXI4Lite_WREADY, AXI4Lite_BRESP, AXI4Lite_BVALID, AXI4Lite_BREADY,
		AXI4Lite_ARADDR, AXI4Lite_ARPROT, AXI4Lite_ARVALID, AXI4Lite_ARREADY,
		AXI4Lite_RDATA, AXI4Lite_RRESP, AXI4Lite_RVALID, AXI4Lite_RREADY,
		axi4_aligned_paddr, axi4_aligned_prdata, axi4_aligned_pdata, axi4_aligned_penable,
		APB_pwrite, axi4_aligned_pstb, axi4_aligned_pready, AXI_perr);

	cpu	riscv_cpu(AXI_PCLK, AXI_PRESETn, APB_paddr, APB_pdata, APB_prdata, APB_psel,
			  APB_penable, APB_pwrite, APB_pstb, APB_pready, APB_perr, apb_cpu_interrupt | cpu_interrupt,
			  halted, odat, old_pc);

	APB	apb_bus(AXI_PCLK, APB_paddr, APB_pdata, APB_prdata, APB_psel, APB_penable,
			APB_pwrite, APB_pstb, APB_pready, APB_perr,
			AXI_sel, AXI_enable, AXI_data, AXI_ready, AXI_perr,
			uart_sel, uart_enable, uart_data, uart_ready, uart_perr,
			intc_sel, intc_enable, intc_data, intc_ready, intc_perr,
			timer_sel, timer_enable, timer_data, timer_ready, timer_perr);

	intctrl	interrupt_controller(AXI_PCLK, AXI_PRESETn, APB_paddr, APB_pdata, intc_data,
				     intc_sel, intc_enable, APB_pwrite, APB_pstb, intc_ready,intc_perr, apb_cpu_interrupt, APB_perr, timer_interrupt);

	timer	sys_timer(AXI_PCLK, AXI_PRESETn, APB_paddr, APB_pdata, timer_data, timer_sel,
			  timer_enable, APB_pwrite, APB_pstb, timer_ready, timer_perr,
			  timer_interrupt);

	uart_wraper	console(AXI_PCLK, AXI_PRESETn, APB_paddr, APB_pdata, uart_data, uart_sel,
				uart_enable, APB_pwrite, APB_pstb, uart_ready, uart_perr, BR_clk,
				sRX, sTX);
endmodule
