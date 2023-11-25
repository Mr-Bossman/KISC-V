/* verilator lint_off UNUSEDSIGNAL */
`include "sys.v"
module apb_align
	#(	parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32)
	(
		input APB_PCLK,
		input APB_PRESETn,
		input [ADDR_WIDTH-1:0] paddr,
		input [DATA_WIDTH-1:0] pdata,
		output reg [DATA_WIDTH-1:0] prdata,

		input psel,
		input penable,
		input pwrite,
		input [3:0] pstb,
		output pready,

		output [ADDR_WIDTH-1:0] aligned_paddr,
		output reg [DATA_WIDTH-1:0] aligned_pdata,
		input [DATA_WIDTH-1:0] aligned_prdata,
		output reg aligned_penable,
		output [3:0] aligned_pstb,
		input aligned_pready);

reg [1:0]done;

wire [7:0]mask = {4'b0, pstb[3:0]} << paddr[1:0];
assign aligned_pstb = mask[(4*done[0])+:4];
/* verilator lint_off WIDTHEXPAND */
assign aligned_paddr = {{paddr[ADDR_WIDTH-1:2] + done[0]}, 2'b0};
/* verilator lint_on WIDTHEXPAND */
wire [31:0]offset = {28'b0, done[0], 2'b0} - {30'b0,paddr[1:0]};

initial begin
	done = 0;
	aligned_penable = 0;
end

integer i;
`always_comb_sys begin
	for( i = 0; i < (ADDR_WIDTH/8);i = i + 1) begin
		if(aligned_pstb[i])
			aligned_pdata[8*i+:8] = pdata[8*(i+offset)+: 8];
		else
			aligned_pdata[8*i+:8] = 0;
	end
end

assign pready = penable && psel && done[1];
`always_ff_sys @(posedge APB_PCLK) begin
	if(penable) begin
		if(paddr[1:0] != 2'b00) begin
			if(aligned_pready) begin
				done <= done + 1;
				aligned_penable <= 0;
			end else begin
				aligned_penable <= 1;
			end
		end else begin
			aligned_penable <= 1;
			if(aligned_pready) begin
				done <= 2;
				aligned_penable <= 0;
			end
		end
		if(!pwrite && aligned_pready) begin
			if(done == 0) begin
				case(paddr[1:0])
					2'b00: prdata <= aligned_prdata;
					2'b01: prdata[23:0] <= aligned_prdata[31:8];
					2'b10: prdata[15:0] <= aligned_prdata[31:16];
					2'b11: prdata[7:0] <= aligned_prdata[31:24];
				endcase
			end else if (done == 1) begin
				case(paddr[1:0])
					2'b00: ;
					2'b01: prdata[31:24] <= aligned_prdata[7:0];
					2'b10: prdata[31:16] <= aligned_prdata[15:0];
					2'b11: prdata[31:8] <= aligned_prdata[23:0];
				endcase
			end
		end
	end
	if(done == 2)
		done <= 0;
end
endmodule
