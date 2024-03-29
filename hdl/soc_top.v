module soc_top
	#(parameter ADDR_WIDTH = 32,
	  parameter DATA_WIDTH = 32)
	(input clk, input APB_PRESETn,output halted,
	output [31:0]odat,output [31:0] oldpc, input [7:0]char_in,output read);

	wire [ADDR_WIDTH-1:0] APB_paddr;
	wire [DATA_WIDTH-1:0] APB_pdata;
	wire [DATA_WIDTH-1:0] APB_prdata;
	wire APB_psel;
	wire APB_penable;
	wire APB_pwrite;
	wire [3:0] APB_pstb;
	wire APB_pready;
	wire APB_perr;

	wire cpu_interrupt;

	wire sram_sel;
	wire sram_enable;
	wire [DATA_WIDTH-1:0]sram_data;
	wire sram_ready;
	wire sram_perr;

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

initial begin
	$dumpfile("soc.vcd");
	$dumpvars(0, soc_top);
end

	cpu	riscv_cpu(clk, APB_PRESETn, APB_paddr, APB_pdata, APB_prdata, APB_psel, APB_penable,
			  APB_pwrite, APB_pstb, APB_pready, APB_perr, cpu_interrupt, halted,
			  odat, oldpc);

	APB	apb_bus(clk, APB_paddr, APB_pdata, APB_prdata, APB_psel, APB_penable, APB_pwrite,
			APB_pstb, APB_pready, APB_perr,
			sram_sel, sram_enable, sram_data, sram_ready, sram_perr,
			uart_sel, uart_enable, uart_data, uart_ready, uart_perr,
			system_sel, system_enable, system_data, system_ready, system_perr,
			intc_sel, intc_enable, intc_data, intc_ready, intc_perr,
			timer_sel, timer_enable, timer_data, timer_ready, timer_perr);

	intctrl	interrupt_controller(clk, APB_PRESETn, APB_paddr, APB_pdata, intc_data, intc_sel,
				     intc_enable, APB_pwrite, APB_pstb, intc_ready, intc_perr,
				     cpu_interrupt, APB_perr, timer_interrupt);

	timer	sys_timer(clk, APB_PRESETn, APB_paddr, APB_pdata, timer_data, timer_sel,
			  timer_enable, APB_pwrite, APB_pstb, timer_ready, timer_perr,
			  timer_interrupt);

	wire [ADDR_WIDTH-1:0] sram_aligned_paddr;
	wire [DATA_WIDTH-1:0] sram_aligned_pdata;
	wire [DATA_WIDTH-1:0] sram_aligned_prdata;
	wire [3:0] sram_aligned_pstb;
	wire sram_aligned_penable;
	wire sram_aligned_pready;

	apb_align	allign(clk, APB_PRESETn, {1'b0,APB_paddr[30:0]}, APB_pdata, sram_data,
			       sram_sel, sram_enable, APB_pwrite, APB_pstb, sram_ready,
			       sram_aligned_paddr, sram_aligned_pdata, sram_aligned_prdata,
			       sram_aligned_penable, sram_aligned_pstb, sram_aligned_pready);

	sram	#(.FILE("test.mem"), .RAM_SIZE('h1000000))ram(clk, sram_aligned_paddr,
			sram_aligned_pdata, sram_aligned_prdata, sram_sel, sram_aligned_penable,
			APB_pwrite, sram_aligned_pstb, sram_aligned_pready, sram_perr);

	sram	#(.FILE("system.mem"), .RAM_SIZE('h10000))system(clk, APB_paddr, APB_pdata,
			system_data, system_sel, system_enable, APB_pwrite, APB_pstb, system_ready,
			system_perr);

	uart	console(clk, APB_PRESETn, APB_paddr, APB_pdata, uart_data, uart_sel, uart_enable,
			APB_pwrite, APB_pstb, uart_ready, uart_perr, char_in, read);
endmodule
