/* verilator lint_off UNUSEDSIGNAL */

module uart
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
		output reg ready,
		output perr,
		input [7:0]char_in,
		output reg read);

always_comb begin
	if(paddr == 32'h10000005) begin
		if(char_in == 0)
			prdata = 32'h00000060;
		else
			prdata = 32'h00000061;
	end else if(paddr == 32'h10000000) begin
		prdata = {24'b0,char_in};
	end else
		prdata = 0;
end

assign perr = 0;
always @(posedge pclk) begin
	if(psel && penable && !ready) begin
		if(paddr == 32'h10000000) begin
			if (pwrite) begin
				unique case(paddr[1:0])
						2'b00: $write("%c",pdata[7:0]);
						2'b01: $write("%c",pdata[15:8]);
						2'b10: $write("%c",pdata[23:16]);
						2'b11: $write("%c",pdata[31:24]);
				endcase
			end else begin
				read <= 1;
			end
		end
		ready <= 1;
	end
	else begin
		read <= 0;
		ready <= 0;
	end
end
endmodule
