-----------------------------------------------------------------------------
--	Filename:	gh_uart_16550_AMBA_APB_wrapper.vhd
--
--	Description:
--		This is a AMBA APB, rev 2.0 interface 
--		wrapper for a 16550 compatible UART 
--
--	Copyright (c) 2006 by H LeFevre 
--		A VHDL 16550 UART core
--		an OpenCores.org Project
--		free to use, but see documentation for conditions 
--
--	Revision 	History:
--	Revision 	Date       	Author    	Comment
--	-------- 	---------- 	---------	-----------
--	1.0      	05/06/06  	H LeFevre	Initial revision
--
-----------------------------------------------------------------------------
library ieee ;
use ieee.std_logic_1164.all ;

entity gh_uart_16550_AMBA_APB_wrapper is
	port(	  
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
		);
end entity;

architecture a of gh_uart_16550_AMBA_APB_wrapper is

COMPONENT gh_edge_det is
	PORT(	
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		D   : in STD_LOGIC;
		re  : out STD_LOGIC; -- rising edge (need sync source at D)
		fe  : out STD_LOGIC; -- falling edge (need sync source at D)
		sre : out STD_LOGIC; -- sync'd rising edge
		sfe : out STD_LOGIC  -- sync'd falling edge
		);
END COMPONENT;

COMPONENT gh_register_ce is
	GENERIC (size: INTEGER := 8);
	PORT(	
		clk : IN		STD_LOGIC;
		rst : IN		STD_LOGIC; 
		CE  : IN		STD_LOGIC; -- clock enable
		D   : IN		STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		Q   : OUT		STD_LOGIC_VECTOR(size-1 DOWNTO 0)
		);
END COMPONENT;

COMPONENT gh_uart_16550 is
	port(
		clk     : in std_logic;
		BR_clk  : in std_logic;
		rst     : in std_logic;
		CS      : in std_logic;
		WR      : in std_logic;
		ADD     : in std_logic_vector(2 downto 0);
		D       : in std_logic_vector(7 downto 0);
		
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
		B_CLK   : out std_logic;
		RD      : out std_logic_vector(7 downto 0)
		);
END COMPONENT;

	
	signal iRD    : std_logic_vector(7 downto 0);
	signal CS     : std_logic;
	signal iCS    : std_logic;
	signal rst    : std_logic;

	
begin

----------------------------------------------

	rst <= (not PRESETn);

U1 : gh_uart_16550 
	PORT MAP (
		clk    => PCLK,
		BR_clk => BR_clk,
		rst    => rst,
		CS     => iCS,
		WR     => PWRITE,
		ADD    => PADDR,
		D      => PWDATA,
		sRX	   => sRX,
		CTSn   => CTSn,
		DSRn   => DSRn,
		RIn    => RIn,
		DCDn   => DCDn,
		
		sTX    => sTX,
		DTRn   => DTRn,
		RTSn   => RTSn,
		OUT1n  => OUT1n,
		OUT2n  => OUT2n,
		TXRDYn => TXRDYn,
		RXRDYn => RXRDYn,
		
		IRQ    => IRQ,
		B_CLK  => B_CLK,
		RD     => iRD
		);

u2 : gh_register_ce 
	generic map (8)
	port map(
		clk => PCLK,
		rst => rst,
		ce => iCS,
		D => iRD,
		Q => PRDATA
		);
		
 --------------------------------------------------

U3 : gh_edge_det 
	PORT MAP (
		clk => PCLK,
		rst => rst,
		d => CS,
		re => iCS);
		
	CS <= '1' when ((PSEL = '1') and (PENABLE = '0')) else
	      '0';
		  
--------------------------------------------------------------

end a;
