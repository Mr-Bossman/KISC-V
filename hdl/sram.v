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
	if(!cs) begin
		integer i;
		for( i = 0; i <= (ADDR_WIDTH/8)-1;i = i + 1) begin
			if(size[i])
				mem[addr/4][8*i+:8] <= data[8*i+:8];
		end
	end
end
assign data = (oe||cs||(!wr))?'hz:(mem[addr/4]&((1<<((size+1)*8))-1));
endmodule
