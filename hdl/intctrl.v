/* verilator lint_off UNUSEDSIGNAL */

module intctrl
	#(parameter ADDR_WIDTH = 32,
	  parameter DATA_WIDTH = 32)
	(
		input pclk,
		input [ADDR_WIDTH-1:0] paddr,
		input [DATA_WIDTH-1:0] pdata,
		output reg [DATA_WIDTH-1:0] prdata,

		input psel,
		input penable,
		input pwrite,
		input [3:0] pstb,
		output pready,
		output perr,
		output cpu_interrupt);

	assign prdata = 0;
	assign perr = 0;
	assign pready = 0;
	assign cpu_interrupt = 0;
endmodule
