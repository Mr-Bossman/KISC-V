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
		output perr);
assign prdata = (paddr == 32'h10000005)?32'h00000060:0;
reg rderr = 0;
assign perr = 0; //paddr[1] | paddr[0] |
always @(posedge pclk) begin
	if(psel && penable && !ready) begin
		if (pwrite && paddr == 32'h10000000) begin
			unique case(paddr[1:0])
					2'b00: $write("%c",pdata[7:0]);
					2'b01: $write("%c",pdata[15:8]);
					2'b10: $write("%c",pdata[23:16]);
					2'b11: $write("%c",pdata[31:24]);
			endcase
		end
		ready <= 1;
	end
	else ready <= 0;
end
endmodule
