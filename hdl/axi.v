module AXI4Lite_translator
	#(parameter ADDR_WIDTH = 32,
	  parameter DATA_WIDTH = 32)
	(input ACLK,
	input ARESETn,
	/* Write address channel */
	output [ADDR_WIDTH-1:0] AWADDR,
	output [2:0] AWPROT,
	output reg AWVALID,
	input AWREADY,
	/* Write data channel */
	output [DATA_WIDTH-1:0] WDATA,
	output [DATA_WIDTH/8-1:0] WSTRB,
	output reg WVALID,
	input WREADY,
	/* Write response channel */
	input [1:0] BRESP,
	input BVALID,
	output reg BREADY,
	/* Read address channel */
	output [ADDR_WIDTH-1:0] ARADDR,
	output [2:0] ARPROT,
	output reg ARVALID,
	input ARREADY,
	/* Read data channel */
	input [DATA_WIDTH-1:0] RDATA,
	input [1:0] RRESP,
	input RVALID,
	output reg RREADY,

	/* APB like interface */
	input [ADDR_WIDTH-1:0] APB_paddr,
	output reg [DATA_WIDTH-1:0] APB_prdata,
	input [DATA_WIDTH-1:0] APB_pdata,
	input APB_penable,
	input APB_pwrite,
	input [DATA_WIDTH/8-1:0] APB_pstb,
	output reg APB_pready,
	output reg APB_perr);

assign AWADDR = APB_paddr;
assign ARADDR = APB_paddr;
assign WSTRB = APB_pstb;
assign WDATA = APB_pdata;
assign ARPROT = 3'b001; // privileged, secure, data access
assign AWPROT = 3'b001; // privileged, secure, data access
reg [1:0] wrstep;
reg rdstep;
initial begin
	wrstep = 0;
	rdstep = 0;
	AWVALID = 0;
	WVALID = 0;
	BREADY = 0;
	ARVALID = 0;
	RREADY = 0;
	APB_pready = 0;
	APB_perr = 0;
	APB_prdata = 0;
end
always @(posedge ACLK) begin // apb trans will get detected 1clk after Penable
	if(!ARESETn) begin
		wrstep <= 0;
		rdstep <= 0;
		wrstep <= 0;
		rdstep <= 0;
		AWVALID <= 0;
		WVALID <= 0;
		BREADY <= 0;
		ARVALID <= 0;
		RREADY <= 0;
		APB_pready <= 0;
		APB_perr <= 0;
	end else if(APB_penable) begin
		if(APB_pwrite && !APB_pready) begin
			case(wrstep)
				default: begin
					if((AWREADY || wrstep[0]) && !wrstep[0]) begin
						AWVALID <= 0;
					end else
						AWVALID <= 1;
					if((WREADY || wrstep[1]) && !wrstep[1]) begin
						WVALID <= 0;
					end else
						WVALID <= 1;
					wrstep <= wrstep | {WREADY, AWREADY};
				end
				2'b11: begin
					AWVALID <= 0;
					WVALID <= 0;
					if(BVALID) begin
						if(BRESP[1]) // BRESP[1] is error
							APB_perr <= 1;
						else
							APB_perr <= 0;
						wrstep <= 2'b00;
						BREADY <= 1;
						APB_pready <= 1;
					end
				end
			endcase
		end else if(!APB_pready) begin
			case(rdstep)
				1'b0: begin
					if(ARREADY && ARVALID) begin
						ARVALID <= 0;
						rdstep <= 1;
					end else begin
						ARVALID <= 1;
					end
				end
				1'b1: begin
					ARVALID <= 0;
					if(RVALID) begin // we assume that RVALID gets deasserted 1clk after RREADY
						APB_prdata <= RDATA;
						if(RRESP[1]) // RRESP[1] is error
							APB_perr <= 1;
						else
							APB_perr <= 0;
						rdstep <= 0;
						RREADY <= 1;
						APB_pready <= 1;
					end
				end
			endcase
		end else begin
			RREADY <= 0;
			BREADY <= 0;
		end
	end else begin
		RREADY <= 0;
		BREADY <= 0;
		APB_pready <= 0;
	end
end
endmodule
