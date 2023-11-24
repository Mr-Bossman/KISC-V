module uart_wraper(
		input APB_PCLK,
		input APB_PRESETn,
		input [31:0] paddr,
		input [31:0] pdata,
		output [31:0] prdata,

		input psel,
		input penable,
		input pwrite,
		input [3:0] pstb,
		output pready,
		output perr,

		input BR_clk,
		input sRX,

		output sTX);
assign perr = 0;
assign pready = psel && penable;

wire CTSn = 1;
wire DSRn = 1;
wire RIn = 1;
wire DCDn = 1;

wire DTRn;
wire RTSn;
wire OUT1n;
wire OUT2n;
wire TXRDYn;
wire RXRDYn;
wire B_CLK;
wire IRQ;
wire [7:0]PRDATA;
assign prdata = {24'b0,PRDATA};

gh_uart_16550_AMBA_APB_wrapper uart16550(APB_PCLK, APB_PRESETn, psel, penable, pwrite,paddr[2:0],
	pdata[7:0], PRDATA, BR_clk, sRX, CTSn, DSRn, RIn, DCDn, sTX, DTRn, RTSn, OUT1n, OUT2n,
	TXRDYn, RXRDYn, IRQ, B_CLK);

/*
-------- AMBA_APB signals ------------
		PCLK      : in std_logic;
		PRESETn   : in std_logic;
		PSEL      : in std_logic;
		PENABLE   : in std_logic;
		PWRITE    : in std_logic;
		PADDR     : in std_logic_vector(2 downto 0);
		PWDATA    : in std_logic_vector(7 downto 0);

		PRDATA    : out std_logic_vector(7 downto 0);
	----------------------------------------------------
	------ other I/O -----------------------------------
		BR_clk  : in std_logic;
		sRX	    : in std_logic;
		CTSn    : in std_logic := '1';
		DSRn    : in std_logic := '1';
		RIn     : in std_logic := '1';
		DCDn    : in std_logic := '1';

		sTX     : out std_logic;
		DTRn    : out std_logic;
		RTSn    : out std_logic;
		OUT1n   : out std_logic;
		OUT2n   : out std_logic;
		TXRDYn  : out std_logic;
		RXRDYn  : out std_logic;

		IRQ     : out std_logic;
		B_CLK   : out std_logic
*/
endmodule
