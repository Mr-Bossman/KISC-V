module soc_top
	#(parameter ADDR_WIDTH = 32,
	  parameter DATA_WIDTH = 32);

/* iverilog -o test -g2012 -DSYSTEM_VERILOG_2012_ICARUS -Ihdl hdl/alu.v hdl/cpu.v hdl/intctrl.v  hdl/APB.v hdl/uart.v hdl/timer.v hdl/sram.v hdl/soc_top_iverilog.v */

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

	wire [31:0]odat;
	wire [31:0] oldpc;
	wire halted;
	reg rts;
	wire [7:0]char_in = 0;
	wire read = 0;
	reg clk;

initial begin
	$dumpfile("test.vcd");
	$dumpvars(0,soc_top);
	clk = 0;
	rts = 0;
	#2 rts = 1;
	#4 rts = 0;
end

always @(halted) begin
	$display("halted=%b",halted);
	$finish();
end

always #1 clk = ~clk;

	cpu	riscv_cpu(clk,APB_paddr,APB_pdata,APB_prdata,APB_psel,APB_penable,APB_pwrite,
			  APB_pstb,APB_pready,APB_perr,cpu_interrupt,rts,halted,odat,oldpc);
	APB	apb_bus(clk,APB_paddr,APB_pdata,APB_prdata,APB_psel,APB_penable,APB_pwrite,
			APB_pstb,APB_pready,APB_perr,
			sram_sel,sram_enable,sram_data,sram_ready,sram_perr,
			uart_sel,uart_enable,uart_data,uart_ready,uart_perr,
			system_sel,system_enable,system_data,system_ready,system_perr,
			intc_sel,intc_enable,intc_data,intc_ready,intc_perr,
			timer_sel,timer_enable,timer_data,timer_ready,timer_perr);

	intctrl	interrupt_controller(clk,APB_paddr,APB_pdata,intc_data,intc_sel,intc_enable,
				     APB_pwrite,APB_pstb,intc_ready,intc_perr,
				     cpu_interrupt,APB_perr,timer_interrupt);
	timer	sys_timer(clk,APB_paddr,APB_pdata,timer_data,timer_sel,timer_enable,APB_pwrite,
			  APB_pstb,timer_ready,timer_perr,timer_interrupt);

	sram	#(.FILE("test.mem"), .RAM_SIZE('h1000000))ram(clk,{1'b0,APB_paddr[30:0]},APB_pdata,
		sram_data,sram_sel,sram_enable,APB_pwrite,APB_pstb,sram_ready,sram_perr);
	sram	#(.FILE("system.mem"), .RAM_SIZE('h10000))system(clk,APB_paddr,APB_pdata,system_data,
		system_sel,system_enable,APB_pwrite,APB_pstb,system_ready,system_perr);

	uart	console(clk,APB_paddr,APB_pdata,uart_data,uart_sel,uart_enable,APB_pwrite,
			APB_pstb,uart_ready,uart_perr,char_in,read);
endmodule
