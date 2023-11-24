module sdram_axi_wrapper
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           inport_awvalid_i
    ,input  [ 31:0]  inport_awaddr_i
    ,input  [  3:0]  inport_awid_i
    ,input  [  7:0]  inport_awlen_i
    ,input  [  1:0]  inport_awburst_i
    ,input           inport_wvalid_i
    ,input  [ 31:0]  inport_wdata_i
    ,input  [  3:0]  inport_wstrb_i
    ,input           inport_wlast_i
    ,input           inport_bready_i
    ,input           inport_arvalid_i
    ,input  [ 31:0]  inport_araddr_i
    ,input  [  3:0]  inport_arid_i
    ,input  [  7:0]  inport_arlen_i
    ,input  [  1:0]  inport_arburst_i
    ,input           inport_rready_i

    ,input  [  2:0]  inport_awsize_i
    ,input  [  2:0]  inport_arsize_i

    ,inout  [ 15:0]  sdram_data

    // Outputs
    ,output          inport_awready_o
    ,output          inport_wready_o
    ,output          inport_bvalid_o
    ,output [  1:0]  inport_bresp_o
    ,output [  3:0]  inport_bid_o
    ,output          inport_arready_o
    ,output          inport_rvalid_o
    ,output [ 31:0]  inport_rdata_o
    ,output [  1:0]  inport_rresp_o
    ,output [  3:0]  inport_rid_o
    ,output          inport_rlast_o
    ,output          sdram_clk_o
    ,output          sdram_cke_o
    ,output          sdram_cs_o
    ,output          sdram_ras_o
    ,output          sdram_cas_o
    ,output          sdram_we_o
    ,output [  1:0]  sdram_dqm_o
    ,output [ 12:0]  sdram_addr_o
    ,output [  1:0]  sdram_ba_o
);

parameter SDRAM_MHZ             = 50;
parameter SDRAM_ADDR_W          = 24;
parameter SDRAM_COL_W           = 9;
parameter SDRAM_READ_LATENCY    = 2;

wire [ 15:0] sdram_data_input_i;
wire [ 15:0] sdram_data_output_o;
wire sdram_data_out_en_o;

assign sdram_data = sdram_data_out_en_o ? sdram_data_output_o : 1'bZ;
assign sdram_data_input_i = sdram_data;

sdram_axi
#(
     .SDRAM_MHZ(SDRAM_MHZ)
    ,.SDRAM_ADDR_W(SDRAM_ADDR_W)
    ,.SDRAM_COL_W(SDRAM_COL_W)
    ,.SDRAM_READ_LATENCY(SDRAM_READ_LATENCY)
)
sdram_axi_inst
(
	.clk_i(clk_i)
	,.rst_i(rst_i)
	,.inport_awvalid_i(inport_awvalid_i)
	,.inport_awaddr_i(inport_awaddr_i)
	,.inport_awid_i(inport_awid_i)
	,.inport_awlen_i(inport_awlen_i)
	,.inport_awburst_i(inport_awburst_i)
	,.inport_wvalid_i(inport_wvalid_i)
	,.inport_wdata_i(inport_wdata_i)
	,.inport_wstrb_i(inport_wstrb_i)
	,.inport_wlast_i(inport_wlast_i)
	,.inport_bready_i(inport_bready_i)
	,.inport_arvalid_i(inport_arvalid_i)
	,.inport_araddr_i(inport_araddr_i)
	,.inport_arid_i(inport_arid_i)
	,.inport_arlen_i(inport_arlen_i)
	,.inport_arburst_i(inport_arburst_i)
	,.inport_rready_i(inport_rready_i)
	,.sdram_data_input_i(sdram_data_input_i)
	,.inport_awready_o(inport_awready_o)
	,.inport_wready_o(inport_wready_o)
	,.inport_bvalid_o(inport_bvalid_o)
	,.inport_bresp_o(inport_bresp_o)
	,.inport_bid_o(inport_bid_o)
	,.inport_arready_o(inport_arready_o)
	,.inport_rvalid_o(inport_rvalid_o)
	,.inport_rdata_o(inport_rdata_o)
	,.inport_rresp_o(inport_rresp_o)
	,.inport_rid_o(inport_rid_o)
	,.inport_rlast_o(inport_rlast_o)
	,.sdram_clk_o(sdram_clk_o)
	,.sdram_cke_o(sdram_cke_o)
	,.sdram_cs_o(sdram_cs_o)
	,.sdram_ras_o(sdram_ras_o)
	,.sdram_cas_o(sdram_cas_o)
	,.sdram_we_o(sdram_we_o)
	,.sdram_dqm_o(sdram_dqm_o)
	,.sdram_addr_o(sdram_addr_o)
	,.sdram_ba_o(sdram_ba_o)
	,.sdram_data_output_o(sdram_data_output_o)
	,.sdram_data_out_en_o(sdram_data_out_en_o)
);

endmodule
