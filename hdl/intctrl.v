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
		output reg pready,
		output perr,
		output cpu_interrupt,
		input APB_perr,
		input timer_int);
	reg [31:0] int_mask = 0;
	reg [31:0] int_clear = 0;
	reg [31:0] peding_int = 0;

	/* APB is non-maskable interrupt */
	assign cpu_interrupt = ((peding_int & int_mask) != 0) || APB_perr;
	assign perr = 0;
	always @(*) begin
		if(paddr  == 'h20000000) begin
			prdata = peding_int;
		end else if (paddr == 'h20000004) begin
			prdata = int_mask;
		end else begin
			prdata = 32'h0;
		end
	end

	always @(posedge pclk) begin
		peding_int <= peding_int | {30'b0,timer_int,APB_perr};
		if(psel && penable && !pready) begin
			if (pwrite) begin
				if(paddr == 32'h20000000) begin
				peding_int <= peding_int & ~pdata;
				end else if (paddr == 'h20000004) begin
					int_mask <= pdata;
				end
			end
			pready <= 1;
		end
		else pready <= 0;
	end
endmodule
