/* verilator lint_off UNUSEDSIGNAL */

module timer
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
		output reg timer_interrupt);
	assign perr = 0;
	reg [63:0]wall_clock = 0;
	reg [63:0]timer_match = 64'hffffffffffffffff;

	always_comb begin
		if(paddr  == 'h1100bffc) begin
			prdata = wall_clock[63:32];
		end else if (paddr == 'h1100bff8) begin
			prdata = wall_clock[31:0];
		end else begin
			prdata = 32'h0;
		end
	end

	always @(posedge pclk) begin
		if(psel && penable && !pready) begin
			if (pwrite) begin
				if(paddr == 'h11004004) begin
					timer_match <= {timer_match[63:32],pdata};
				end else if (paddr == 'h11004000) begin
					timer_match <= {pdata,timer_match[31:0]};
				end
			end
			pready <= 1;
		end
		else pready <= 0;
	end

	always @(posedge pclk) begin
		if(wall_clock == timer_match) begin
			timer_interrupt <= 1;
			wall_clock <= 0;
		end
		else begin
			wall_clock <= wall_clock + 1;
		end
	end
endmodule
