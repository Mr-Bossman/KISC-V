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
		output reg cpu_interrupt,
		input APB_perr);

	assign cpu_interrupt = APB_perr | timer_int;
	assign perr = 0;
	reg timer_int;

	always @(posedge pclk) begin
		prdata <= prdata | {30'b0,timer_int,APB_perr};
		if(psel && penable && !pready) begin
			if (pwrite && paddr == 32'h20000000) begin
				prdata <= pdata;
				timer_int <= 0;
			end
			pready <= 1;
		end
		else pready <= 0;
	end

	/* Timer interrupt */
	reg [31:0]wall_clock = 0;
	always @(posedge pclk) begin
		if(wall_clock == 'h10000) begin
			timer_int <= 1;
			wall_clock <= 0;
		end
		else begin
			wall_clock <= wall_clock + 1;
		end
	end
endmodule
