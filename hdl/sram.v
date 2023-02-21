/* verilator lint_off UNUSEDSIGNAL */

module sram
	#(parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32,
		parameter RAM_SIZE = 100)
	(
		input pclk,
		input [ADDR_WIDTH-1:0] paddr,
		input [DATA_WIDTH-1:0] pdata,
		output [DATA_WIDTH-1:0] prdata,

		input psel,
		input penable,
		input pwrite,
		input [3:0] pstb,
		output pready);


reg [ADDR_WIDTH-1:0] addr;
reg ready;
reg [DATA_WIDTH-1:0] mem[0:RAM_SIZE-1];
initial begin
	$readmemh("test.vh", mem);
end


assign prdata = mem[addr];
assign pready = ready;

always @(posedge pclk) begin
	if(psel && penable) begin
		if (pwrite) mem[paddr] <= pdata;
		else addr <= paddr;
		ready <= 1;
	end
	else ready <= 0;
end
endmodule
