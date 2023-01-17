module sram
	#(parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32,
		parameter RAM_SIZE = 100)
	(
		input wr,
		input oe,
		input cs,
		/* verilator lint_off UNUSED */
		input [ADDR_WIDTH-1:0] addr,
		input [(ADDR_WIDTH/8)-1:0] size,
		/* verilator lint_on UNUSED*/
		inout [DATA_WIDTH-1:0] data
	);

//reg [DATA_WIDTH-1:0] Oreg;
reg [DATA_WIDTH-1:0] mem[0:RAM_SIZE-1];
initial begin
	//$writememb("memory_binary.bin", mem);
end
always @(posedge wr) begin
	if(!cs)
		mem[addr] <= (data&((1<<((size+1)*8))-1)) | (mem[addr]&(~((1<<((size+1)*8))-1)));
end
assign data = (oe||cs||(!wr))?'hz:(mem[addr]&((1<<((size+1)*8))-1));
endmodule
