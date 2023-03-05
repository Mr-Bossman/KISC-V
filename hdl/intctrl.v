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
		output cpu_interrupt,
		input APB_perr);

	assign cpu_interrupt = APB_perr;
	assign perr = 0;
	always @(posedge pclk) begin
		prdata <= prdata | {31'b0,APB_perr};
		if(psel && penable && !pready) begin
			if (pwrite && paddr == 32'h20000000) begin
				prdata <= pdata;
			end
			pready <= 1;
		end
		else pready <= 0;
	end
endmodule
