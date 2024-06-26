`include "sys.v"
/* verilator lint_off UNUSEDSIGNAL */

`ifdef NO_SYS_ROM
`define SYSTEM_PERR
`define SRAM_RANGE (paddr >= 'h80000000 || paddr <= 'hffff)
`else
`define SRAM_RANGE (paddr >= 'h80000000)
`define SYSTEM_PERR system_perr
`endif

module APB
	#(parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32)
	(
		input pclk,
		input [ADDR_WIDTH-1:0] paddr,
		input [DATA_WIDTH-1:0] pdata,
		output reg [DATA_WIDTH-1:0]  prdata,

		input psel,
		input penable,
		input pwrite,
		input [3:0] pstb,
		output reg pready,
		output perr,

		output reg sram_sel,
		output reg sram_enable,
		input [DATA_WIDTH-1:0]sram_data,
		input sram_ready,
		input sram_perr,

		output reg uart_sel,
		output reg uart_enable,
		input [DATA_WIDTH-1:0]uart_data,
		input uart_ready,
		input uart_perr,

`ifndef NO_SYS_ROM
		output reg system_sel,
		output reg system_enable,
		input [DATA_WIDTH-1:0]system_data,
		input system_ready,
		input system_perr,
`endif

		output reg intc_sel,
		output reg intc_enable,
		input [DATA_WIDTH-1:0]intc_data,
		input intc_ready,
		input intc_perr,

		output reg timer_sel,
		output reg timer_enable,
		input [DATA_WIDTH-1:0]timer_data,
		input timer_ready,
		input timer_perr);
	reg access_fault;
	assign perr = sram_perr | uart_perr | `SYSTEM_PERR | access_fault;

`ifdef DO_DISPLAY
	always @(posedge access_fault) begin
		$display("Access fault: %h", paddr);
	end
`endif

	`always_comb_sys begin
		// `unique_sys verilator complains about this
		if(`SRAM_RANGE) begin // SRAM
			access_fault = 0;
			uart_sel = 0;
			uart_enable = 0;
`ifndef NO_SYS_ROM
			system_sel = 0;
			system_enable = 0;
`endif
			intc_sel = 0;
			intc_enable = 0;
			timer_sel = 0;
			timer_enable = 0;
			sram_sel = psel;
			sram_enable = penable;
			pready = sram_ready;
			prdata = sram_data;
		end else if (paddr >= 'h10000000 && paddr <= 'h10001000) begin // UART
			access_fault = 0;
			sram_sel = 0;
			sram_enable = 0;
`ifndef NO_SYS_ROM
			system_sel = 0;
			system_enable = 0;
`endif
			intc_sel = 0;
			intc_enable = 0;
			timer_sel = 0;
			timer_enable = 0;
			uart_sel = psel;
			uart_enable = penable;
			pready = uart_ready;
			prdata = uart_data;
		end else if (paddr >= 'h11000000 && paddr <= 'h12000000) begin // Timer
			access_fault = 0;
			sram_sel = 0;
			sram_enable = 0;
`ifndef NO_SYS_ROM
			system_sel = 0;
			system_enable = 0;
`endif
			uart_sel = 0;
			uart_enable = 0;
			intc_sel = 0;
			intc_enable = 0;
			timer_sel = psel;
			timer_enable = penable;
			pready = timer_ready;
			prdata = timer_data;
`ifndef NO_SYS_ROM
		end else if (paddr <= 'hffff)begin // System ROM
			access_fault = 0;
			uart_sel = 0;
			uart_enable = 0;
			sram_sel = 0;
			sram_enable = 0;
			intc_sel = 0;
			intc_enable = 0;
			timer_sel = 0;
			timer_enable = 0;
			system_sel = psel;
			system_enable = penable;
			pready = system_ready;
			prdata = system_data;
`endif
		end else if (paddr == 'h20000000 || paddr == 'h20000004) begin // INTC
			access_fault = 0;
			uart_sel = 0;
			uart_enable = 0;
			sram_sel = 0;
			sram_enable = 0;
`ifndef NO_SYS_ROM
			system_sel = 0;
			system_enable = 0;
`endif
			timer_sel = 0;
			timer_enable = 0;
			intc_sel = psel;
			intc_enable = penable;
			pready = intc_ready;
			prdata = intc_data;
		end else begin // Access fault
			access_fault = 1;
`ifndef NO_SYS_ROM
			system_sel = 0;
			system_enable = 0;
`endif
			uart_sel = 0;
			uart_enable = 0;
			sram_sel = 0;
			sram_enable = 0;
			intc_sel = 0;
			intc_enable = 0;
			timer_sel = 0;
			timer_enable = 0;
			pready = 1; // if PERR then pready = 1
			prdata = 0;
		end
	end
endmodule
