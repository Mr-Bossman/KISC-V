module sram
	#(parameter FILE = "test.mem",
		parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32,
		parameter RAM_SIZE = 1000000)
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
		output perr);

integer i;
reg [DATA_WIDTH-1:0] mem[0:RAM_SIZE-1];
initial begin
	done = 0;
	$readmemh(FILE, mem);
end
wire [7:0]mask = {4'b0, pstb[3:0]};
wire [31:0]mem_addr = {2'b0, paddr[ADDR_WIDTH-1:2]};
wire [31:0]offset = {30'b0,paddr[1:0]};

reg [1:0]done;

assign pready = penable && psel && done[1];
assign perr = 0;
always @(posedge pclk) begin
	if(psel && penable) begin
		if(paddr[1:0] != 2'b00)
			done <= done + 1;
		else
			done <= 2;
		if(pwrite) begin
			if(done == 0) begin
				for( i = 0; i < (ADDR_WIDTH/8);i = i + 1) begin
					if(mask[i])
						mem[mem_addr][8*(i+offset)+:8] <= pdata[8*i+: 8];
				end
			end else if (done == 1) begin
				for( i = 0; i < (ADDR_WIDTH/8);i = i + 1) begin
					if(mask[i+offset])
						mem[mem_addr][8*i+:8] <= pdata[8*(i+offset)+: 8];
				end
			end
		end else begin
			if(done == 0) begin
				case(paddr[1:0])
					2'b00: prdata <= mem[mem_addr];
					2'b01: prdata[23:0] <= mem[mem_addr][31:8];
					2'b10: prdata[15:0] <= mem[mem_addr][31:16];
					2'b11: prdata[7:0] <= mem[mem_addr][31:24];
				endcase
			end else if (done == 1) begin
				case(paddr[1:0])
					2'b00: ;
					2'b01: prdata[31:24] <= mem[mem_addr + 1][7:0];
					2'b10: prdata[31:16] <= mem[mem_addr + 1][15:0];
					2'b11: prdata[31:8] <= mem[mem_addr + 1][23:0];
				endcase
			end
		end
	end
	if(done == 2) begin
		done <= 0;
	end
end
endmodule
