module main;
reg clk, resetn;

/* Axi write address channel signals */
reg AXI4Lite_AWREADY;
wire AXI4Lite_AWVALID;
wire [31:0]AXI4Lite_AWADDR;
wire [2:0]AXI4Lite_AWPROT;

/* Axi write data channel signals */
reg AXI4Lite_WREADY;
wire AXI4Lite_WVALID;
wire [31:0]AXI4Lite_WDATA;
wire [3:0]AXI4Lite_WSTRB;

/* Axi write response channel signals */
reg AXI4Lite_BVALID;
reg [1:0]AXI4Lite_BRESP;
wire AXI4Lite_BREADY;

/* Axi read address channel signals */
reg AXI4Lite_ARREADY;
wire AXI4Lite_ARVALID;
wire [31:0]AXI4Lite_ARADDR;
wire [2:0]AXI4Lite_ARPROT;

/* Axi read data channel signals */
reg AXI4Lite_RVALID;
reg [31:0]AXI4Lite_RDATA;
reg [1:0]AXI4Lite_RRESP;
wire AXI4Lite_RREADY;

/* APB like interface */
reg [31:0] APB_paddr;
wire [31:0] APB_prdata;
reg [31:0] APB_pdata;
reg APB_penable, APB_pwrite;
reg [3:0] APB_pstb;
wire APB_pready, APB_perr;

initial begin
	$dumpfile("test.vcd");
	$dumpvars(0,main);
	resetn = 1;
	clk = 0;
	APB_paddr = 'hff;
	APB_pdata = 'hff;
	APB_penable = 0;
	APB_pwrite = 0;
	APB_pstb = 'h5;

	AXI4Lite_RDATA = 'hf0;
	AXI4Lite_BRESP = 0;
	AXI4Lite_RRESP = 0;
	AXI4Lite_BVALID = 1;

	#25 APB_penable = 1;
	APB_pwrite = 1;
	#120 APB_penable = 0;
	APB_pwrite = 0;
	#60 APB_penable = 1;
	#60 AXI4Lite_RVALID = 1;
	# 5000 $finish;
end
always #10 clk = ~clk;
AXI4Lite_translator axi(clk, resetn, AXI4Lite_AWADDR, AXI4Lite_AWPROT, AXI4Lite_AWVALID, AXI4Lite_AWREADY, AXI4Lite_WDATA, AXI4Lite_WSTRB, AXI4Lite_WVALID, AXI4Lite_WREADY, AXI4Lite_BRESP, AXI4Lite_BVALID, AXI4Lite_BREADY, AXI4Lite_ARADDR, AXI4Lite_ARPROT, AXI4Lite_ARVALID, AXI4Lite_ARREADY, AXI4Lite_RDATA, AXI4Lite_RRESP, AXI4Lite_RVALID, AXI4Lite_RREADY, APB_paddr, APB_prdata, APB_pdata, APB_penable, APB_pwrite, APB_pstb, APB_pready, APB_perr);

always @(posedge clk) begin
	if(AXI4Lite_AWREADY && AXI4Lite_AWVALID) AXI4Lite_AWREADY <= 0;
	else AXI4Lite_AWREADY <= AXI4Lite_AWVALID;

	if(!(AXI4Lite_WREADY && AXI4Lite_WVALID) && AXI4Lite_AWREADY)AXI4Lite_WREADY <= AXI4Lite_WVALID;
	else AXI4Lite_WREADY <= 0;
	if(AXI4Lite_ARREADY && AXI4Lite_ARVALID) AXI4Lite_ARREADY <= 0;
	else AXI4Lite_ARREADY <= AXI4Lite_ARVALID;
end
endmodule
