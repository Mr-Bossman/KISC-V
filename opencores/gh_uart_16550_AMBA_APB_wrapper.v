// ghdl -a $(find library/* uart/*); ghdl synth --out=verilog gh_uart_16550_AMBA_APB_wrapper > gh_uart_16550_AMBA_APB_wrapper.v

/* verilator lint_off DECLFILENAME */
/* verilator lint_off PINCONNECTEMPTY */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off UNOPTFLAT */
module gh_shift_reg_se_sl_8
  (input  clk,
   input  rst,
   input  srst,
   input  se,
   input  d,
   output [7:0] q);
  wire [7:0] iq;
  wire [6:0] n2041_o;
  wire [7:0] n2042_o;
  wire [7:0] n2043_o;
  wire [7:0] n2045_o;
  reg [7:0] n2050_q;
  assign q = iq;
  /* library/gh_shift_reg_se_sl.vhd:35:16  */
  assign iq = n2050_q; // (signal)
  /* library/gh_shift_reg_se_sl.vhd:50:50  */
  assign n2041_o = iq[7:1];
  assign n2042_o = {d, n2041_o};
  /* library/gh_shift_reg_se_sl.vhd:48:17  */
  assign n2043_o = se ? n2042_o : iq;
  /* library/gh_shift_reg_se_sl.vhd:46:17  */
  assign n2045_o = srst ? 8'b00000000 : n2043_o;
  /* library/gh_shift_reg_se_sl.vhd:45:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n2050_q <= 8'b00000000;
    else
      n2050_q <= n2045_o;
endmodule

module gh_gray2binary_5
  (input  [4:0] g,
   output [4:0] b);
  wire [4:0] ib;
  wire n2022_o;
  wire n2023_o;
  wire n2024_o;
  wire n2025_o;
  wire n2026_o;
  wire n2027_o;
  wire n2028_o;
  wire n2029_o;
  wire n2030_o;
  wire n2031_o;
  wire n2032_o;
  wire n2033_o;
  wire n2034_o;
  wire [4:0] n2036_o;
  assign b = ib;
  /* library/gh_gray2binary.vhd:30:16  */
  assign ib = n2036_o; // (signal)
  /* library/gh_gray2binary.vhd:39:27  */
  assign n2022_o = g[0];
  /* library/gh_gray2binary.vhd:39:37  */
  assign n2023_o = ib[1];
  /* library/gh_gray2binary.vhd:39:31  */
  assign n2024_o = n2022_o ^ n2023_o;
  /* library/gh_gray2binary.vhd:39:27  */
  assign n2025_o = g[1];
  /* library/gh_gray2binary.vhd:39:37  */
  assign n2026_o = ib[2];
  /* library/gh_gray2binary.vhd:39:31  */
  assign n2027_o = n2025_o ^ n2026_o;
  /* library/gh_gray2binary.vhd:39:27  */
  assign n2028_o = g[2];
  /* library/gh_gray2binary.vhd:39:37  */
  assign n2029_o = ib[3];
  /* library/gh_gray2binary.vhd:39:31  */
  assign n2030_o = n2028_o ^ n2029_o;
  /* library/gh_gray2binary.vhd:39:27  */
  assign n2031_o = g[3];
  /* library/gh_gray2binary.vhd:39:37  */
  assign n2032_o = ib[4];
  /* library/gh_gray2binary.vhd:39:31  */
  assign n2033_o = n2031_o ^ n2032_o;
  /* library/gh_gray2binary.vhd:41:24  */
  assign n2034_o = g[4];
  assign n2036_o = {n2034_o, n2033_o, n2030_o, n2027_o, n2024_o};
endmodule

module gh_binary2gray_5
  (input  [4:0] b,
   output [4:0] g);
  wire n2004_o;
  wire n2005_o;
  wire n2006_o;
  wire n2007_o;
  wire n2008_o;
  wire n2009_o;
  wire n2010_o;
  wire n2011_o;
  wire n2012_o;
  wire n2013_o;
  wire n2014_o;
  wire n2015_o;
  wire n2016_o;
  wire [4:0] n2018_o;
  assign g = n2018_o;
  /* library/gh_binary2gray.vhd:35:26  */
  assign n2004_o = b[0];
  /* library/gh_binary2gray.vhd:35:35  */
  assign n2005_o = b[1];
  /* library/gh_binary2gray.vhd:35:30  */
  assign n2006_o = n2004_o ^ n2005_o;
  /* library/gh_binary2gray.vhd:35:26  */
  assign n2007_o = b[1];
  /* library/gh_binary2gray.vhd:35:35  */
  assign n2008_o = b[2];
  /* library/gh_binary2gray.vhd:35:30  */
  assign n2009_o = n2007_o ^ n2008_o;
  /* library/gh_binary2gray.vhd:35:26  */
  assign n2010_o = b[2];
  /* library/gh_binary2gray.vhd:35:35  */
  assign n2011_o = b[3];
  /* library/gh_binary2gray.vhd:35:30  */
  assign n2012_o = n2010_o ^ n2011_o;
  /* library/gh_binary2gray.vhd:35:26  */
  assign n2013_o = b[3];
  /* library/gh_binary2gray.vhd:35:35  */
  assign n2014_o = b[4];
  /* library/gh_binary2gray.vhd:35:30  */
  assign n2015_o = n2013_o ^ n2014_o;
  /* library/gh_binary2gray.vhd:37:23  */
  assign n2016_o = b[4];
  assign n2018_o = {n2016_o, n2015_o, n2012_o, n2009_o, n2006_o};
endmodule

module gh_parity_gen_serial
  (input  clk,
   input  rst,
   input  srst,
   input  sd,
   input  d,
   output q);
  wire parity;
  wire n1992_o;
  wire n1993_o;
  wire n1995_o;
  reg n2000_q;
  assign q = parity;
  /* library/gh_parity_gen_Serial.vhd:33:16  */
  assign parity = n2000_q; // (signal)
  /* library/gh_parity_gen_Serial.vhd:47:43  */
  assign n1992_o = parity ^ d;
  /* library/gh_parity_gen_Serial.vhd:46:17  */
  assign n1993_o = sd ? n1992_o : parity;
  /* library/gh_parity_gen_Serial.vhd:44:17  */
  assign n1995_o = srst ? 1'b0 : n1993_o;
  /* library/gh_parity_gen_Serial.vhd:43:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n2000_q <= 1'b0;
    else
      n2000_q <= n1995_o;
endmodule

module gh_counter_integer_down_8
  (input  clk,
   input  rst,
   input  load,
   input  ce,
   input  [3:0] d,
   output [3:0] q);
  wire [3:0] iq;
  wire [31:0] n1972_o;
  wire n1974_o;
  wire [31:0] n1975_o;
  wire [31:0] n1977_o;
  wire [3:0] n1978_o;
  wire [3:0] n1980_o;
  wire [3:0] n1981_o;
  wire [3:0] n1982_o;
  reg [3:0] n1987_q;
  assign q = iq;
  /* library/gh_counter_integer_down.vhd:34:16  */
  assign iq = n1987_q; // (signal)
  /* library/gh_counter_integer_down.vhd:48:32  */
  assign n1972_o = {28'b0, iq};  //  uext
  /* library/gh_counter_integer_down.vhd:48:32  */
  assign n1974_o = n1972_o == 32'b00000000000000000000000000000000;
  /* library/gh_counter_integer_down.vhd:51:42  */
  assign n1975_o = {28'b0, iq};  //  uext
  /* library/gh_counter_integer_down.vhd:51:42  */
  assign n1977_o = n1975_o - 32'b00000000000000000000000000000001;
  /* library/gh_counter_integer_down.vhd:51:39  */
  assign n1978_o = n1977_o[3:0];  // trunc
  /* library/gh_counter_integer_down.vhd:48:25  */
  assign n1980_o = n1974_o ? 4'b1000 : n1978_o;
  /* library/gh_counter_integer_down.vhd:47:17  */
  assign n1981_o = ce ? n1980_o : iq;
  /* library/gh_counter_integer_down.vhd:45:17  */
  assign n1982_o = load ? d : n1981_o;
  /* library/gh_counter_integer_down.vhd:44:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1987_q <= 4'b0000;
    else
      n1987_q <= n1982_o;
endmodule

module gh_shift_reg_pl_sl_8
  (input  clk,
   input  rst,
   input  load,
   input  se,
   input  [7:0] d,
   output [7:0] q);
  wire [7:0] iq;
  wire [6:0] n1958_o;
  wire [7:0] n1960_o;
  wire [7:0] n1961_o;
  wire [7:0] n1962_o;
  reg [7:0] n1967_q;
  assign q = iq;
  /* library/gh_shift_reg_PL_sl.vhd:36:16  */
  assign iq = n1967_q; // (signal)
  /* library/gh_shift_reg_PL_sl.vhd:51:57  */
  assign n1958_o = iq[7:1];
  /* library/gh_shift_reg_PL_sl.vhd:51:53  */
  assign n1960_o = {1'b0, n1958_o};
  /* library/gh_shift_reg_PL_sl.vhd:50:17  */
  assign n1961_o = se ? n1960_o : iq;
  /* library/gh_shift_reg_PL_sl.vhd:48:17  */
  assign n1962_o = load ? d : n1961_o;
  /* library/gh_shift_reg_PL_sl.vhd:47:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1967_q <= 8'b00000000;
    else
      n1967_q <= n1962_o;
endmodule

module gh_counter_integer_down_15
  (input  clk,
   input  rst,
   input  load,
   input  ce,
   input  [3:0] d,
   output [3:0] q);
  wire [3:0] iq;
  wire [31:0] n1938_o;
  wire n1940_o;
  wire [31:0] n1941_o;
  wire [31:0] n1943_o;
  wire [3:0] n1944_o;
  wire [3:0] n1946_o;
  wire [3:0] n1947_o;
  wire [3:0] n1948_o;
  reg [3:0] n1953_q;
  assign q = iq;
  /* library/gh_counter_integer_down.vhd:34:16  */
  assign iq = n1953_q; // (signal)
  /* library/gh_counter_integer_down.vhd:48:32  */
  assign n1938_o = {28'b0, iq};  //  uext
  /* library/gh_counter_integer_down.vhd:48:32  */
  assign n1940_o = n1938_o == 32'b00000000000000000000000000000000;
  /* library/gh_counter_integer_down.vhd:51:42  */
  assign n1941_o = {28'b0, iq};  //  uext
  /* library/gh_counter_integer_down.vhd:51:42  */
  assign n1943_o = n1941_o - 32'b00000000000000000000000000000001;
  /* library/gh_counter_integer_down.vhd:51:39  */
  assign n1944_o = n1943_o[3:0];  // trunc
  /* library/gh_counter_integer_down.vhd:48:25  */
  assign n1946_o = n1940_o ? 4'b1111 : n1944_o;
  /* library/gh_counter_integer_down.vhd:47:17  */
  assign n1947_o = ce ? n1946_o : iq;
  /* library/gh_counter_integer_down.vhd:45:17  */
  assign n1948_o = load ? d : n1947_o;
  /* library/gh_counter_integer_down.vhd:44:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1953_q <= 4'b0000;
    else
      n1953_q <= n1948_o;
endmodule

module gh_counter_down_ce_ld_16
  (input  clk,
   input  rst,
   input  load,
   input  ce,
   input  [15:0] d,
   output [15:0] q);
  wire [15:0] iq;
  wire [15:0] n1926_o;
  wire [15:0] n1927_o;
  wire [15:0] n1928_o;
  reg [15:0] n1933_q;
  assign q = iq;
  /* library/gh_counter_down_ce_ld.vhd:35:16  */
  assign iq = n1933_q; // (signal)
  /* library/gh_counter_down_ce_ld.vhd:49:61  */
  assign n1926_o = iq - 16'b0000000000000001;
  /* library/gh_counter_down_ce_ld.vhd:48:17  */
  assign n1927_o = ce ? n1926_o : iq;
  /* library/gh_counter_down_ce_ld.vhd:46:17  */
  assign n1928_o = load ? d : n1927_o;
  /* library/gh_counter_down_ce_ld.vhd:45:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1933_q <= 16'b0000000000000000;
    else
      n1933_q <= n1928_o;
endmodule

module gh_counter_down_ce_ld_tc_10
  (input  clk,
   input  rst,
   input  load,
   input  ce,
   input  [9:0] d,
   output [9:0] q,
   output tc);
  wire [9:0] iq;
  wire itc;
  wire n1882_o;
  wire n1887_o;
  wire n1890_o;
  wire n1891_o;
  wire n1893_o;
  wire n1896_o;
  wire n1898_o;
  wire n1901_o;
  wire n1902_o;
  wire n1903_o;
  wire [9:0] n1912_o;
  wire [9:0] n1913_o;
  wire [9:0] n1914_o;
  reg [9:0] n1919_q;
  reg n1920_q;
  assign q = iq;
  assign tc = n1882_o;
  /* library/gh_counter_down_ce_ld_tc.vhd:39:16  */
  assign iq = n1919_q; // (signal)
  /* library/gh_counter_down_ce_ld_tc.vhd:40:16  */
  assign itc = n1920_q; // (signal)
  /* library/gh_counter_down_ce_ld_tc.vhd:47:20  */
  assign n1882_o = itc & ce;
  /* library/gh_counter_down_ce_ld_tc.vhd:60:41  */
  assign n1887_o = d == 10'b0000000000;
  /* library/gh_counter_down_ce_ld_tc.vhd:60:25  */
  assign n1890_o = n1887_o ? 1'b1 : 1'b0;
  /* library/gh_counter_down_ce_ld_tc.vhd:65:27  */
  assign n1891_o = ~ce;
  /* library/gh_counter_down_ce_ld_tc.vhd:66:50  */
  assign n1893_o = iq == 10'b0000000000;
  /* library/gh_counter_down_ce_ld_tc.vhd:66:33  */
  assign n1896_o = n1893_o ? 1'b1 : 1'b0;
  /* library/gh_counter_down_ce_ld_tc.vhd:72:42  */
  assign n1898_o = iq == 10'b0000000001;
  /* library/gh_counter_down_ce_ld_tc.vhd:72:25  */
  assign n1901_o = n1898_o ? 1'b1 : 1'b0;
  /* library/gh_counter_down_ce_ld_tc.vhd:65:17  */
  assign n1902_o = n1891_o ? n1896_o : n1901_o;
  /* library/gh_counter_down_ce_ld_tc.vhd:59:17  */
  assign n1903_o = load ? n1890_o : n1902_o;
  /* library/gh_counter_down_ce_ld_tc.vhd:90:61  */
  assign n1912_o = iq - 10'b0000000001;
  /* library/gh_counter_down_ce_ld_tc.vhd:89:17  */
  assign n1913_o = ce ? n1912_o : iq;
  /* library/gh_counter_down_ce_ld_tc.vhd:87:17  */
  assign n1914_o = load ? d : n1913_o;
  /* library/gh_counter_down_ce_ld_tc.vhd:86:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1919_q <= 10'b0000000000;
    else
      n1919_q <= n1914_o;
  /* library/gh_counter_down_ce_ld_tc.vhd:58:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1920_q <= 1'b0;
    else
      n1920_q <= n1903_o;
endmodule

module gh_edge_det_xcd
  (input  iclk,
   input  oclk,
   input  rst,
   input  d,
   output re,
   output fe);
  wire iq;
  wire jkr;
  wire jkf;
  wire irq0;
  wire rq0;
  wire rq1;
  wire ifq0;
  wire fq0;
  wire fq1;
  wire n1823_o;
  wire n1824_o;
  wire n1826_o;
  wire n1828_o;
  wire n1829_o;
  wire n1830_o;
  wire n1832_o;
  wire n1834_o;
  wire n1845_o;
  wire n1846_o;
  wire n1847_o;
  wire n1848_o;
  reg n1871_q;
  reg n1872_q;
  reg n1873_q;
  reg n1874_q;
  reg n1875_q;
  reg n1876_q;
  reg n1877_q;
  reg n1878_q;
  reg n1879_q;
  assign re = n1846_o;
  assign fe = n1848_o;
  /* library/gh_edge_det_XCD.vhd:37:16  */
  assign iq = n1871_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:38:16  */
  assign jkr = n1872_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:38:21  */
  assign jkf = n1873_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:39:16  */
  assign irq0 = n1874_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:39:22  */
  assign rq0 = n1875_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:39:27  */
  assign rq1 = n1876_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:40:16  */
  assign ifq0 = n1877_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:40:22  */
  assign fq0 = n1878_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:40:27  */
  assign fq1 = n1879_q; // (signal)
  /* library/gh_edge_det_XCD.vhd:52:39  */
  assign n1823_o = ~iq;
  /* library/gh_edge_det_XCD.vhd:52:31  */
  assign n1824_o = d & n1823_o;
  /* library/gh_edge_det_XCD.vhd:54:17  */
  assign n1826_o = rq1 ? 1'b0 : jkr;
  /* library/gh_edge_det_XCD.vhd:52:17  */
  assign n1828_o = n1824_o ? 1'b1 : n1826_o;
  /* library/gh_edge_det_XCD.vhd:59:24  */
  assign n1829_o = ~d;
  /* library/gh_edge_det_XCD.vhd:59:31  */
  assign n1830_o = n1829_o & iq;
  /* library/gh_edge_det_XCD.vhd:61:17  */
  assign n1832_o = fq1 ? 1'b0 : jkf;
  /* library/gh_edge_det_XCD.vhd:59:17  */
  assign n1834_o = n1830_o ? 1'b1 : n1832_o;
  /* library/gh_edge_det_XCD.vhd:69:16  */
  assign n1845_o = ~rq1;
  /* library/gh_edge_det_XCD.vhd:69:25  */
  assign n1846_o = n1845_o & rq0;
  /* library/gh_edge_det_XCD.vhd:70:16  */
  assign n1847_o = ~fq1;
  /* library/gh_edge_det_XCD.vhd:70:25  */
  assign n1848_o = n1847_o & fq0;
  /* library/gh_edge_det_XCD.vhd:50:9  */
  always @(posedge iclk or posedge rst)
    if (rst)
      n1871_q <= 1'b0;
    else
      n1871_q <= d;
  /* library/gh_edge_det_XCD.vhd:50:9  */
  always @(posedge iclk or posedge rst)
    if (rst)
      n1872_q <= 1'b0;
    else
      n1872_q <= n1828_o;
  /* library/gh_edge_det_XCD.vhd:50:9  */
  always @(posedge iclk or posedge rst)
    if (rst)
      n1873_q <= 1'b0;
    else
      n1873_q <= n1834_o;
  /* library/gh_edge_det_XCD.vhd:82:9  */
  always @(posedge oclk or posedge rst)
    if (rst)
      n1874_q <= 1'b0;
    else
      n1874_q <= jkr;
  /* library/gh_edge_det_XCD.vhd:82:9  */
  always @(posedge oclk or posedge rst)
    if (rst)
      n1875_q <= 1'b0;
    else
      n1875_q <= irq0;
  /* library/gh_edge_det_XCD.vhd:82:9  */
  always @(posedge oclk or posedge rst)
    if (rst)
      n1876_q <= 1'b0;
    else
      n1876_q <= rq0;
  /* library/gh_edge_det_XCD.vhd:82:9  */
  always @(posedge oclk or posedge rst)
    if (rst)
      n1877_q <= 1'b0;
    else
      n1877_q <= jkf;
  /* library/gh_edge_det_XCD.vhd:82:9  */
  always @(posedge oclk or posedge rst)
    if (rst)
      n1878_q <= 1'b0;
    else
      n1878_q <= ifq0;
  /* library/gh_edge_det_XCD.vhd:82:9  */
  always @(posedge oclk or posedge rst)
    if (rst)
      n1879_q <= 1'b0;
    else
      n1879_q <= fq0;
endmodule

module gh_uart_rx_8bit
  (input  clk,
   input  rst,
   input  brcx16,
   input  srx,
   input  [31:0] num_bits,
   input  parity_en,
   input  parity_ev,
   output parity_er,
   output frame_er,
   output break_itr,
   output d_rdy,
   output [7:0] d);
  wire [2:0] r_state;
  wire [2:0] r_nstate;
  wire parity;
  wire parity_grst;
  wire rwc_ld;
  wire [3:0] r_wcount;
  wire s_data_ld;
  wire chk_par;
  wire chk_frm;
  wire clr_brk;
  wire clr_d;
  wire s_chk_par;
  wire s_chk_frm;
  wire [7:0] r_shift_reg;
  wire irx;
  wire brc;
  wire dclk_ld;
  wire [3:0] r_brdcount;
  wire iparity_er;
  wire iframe_er;
  wire ibreak_itr;
  wire id_rdy;
  wire n1530_o;
  wire n1531_o;
  wire n1532_o;
  wire n1548_o;
  wire [7:0] n1549_o;
  wire [6:0] n1550_o;
  wire [7:0] n1552_o;
  wire n1554_o;
  wire [7:0] n1555_o;
  wire [5:0] n1556_o;
  wire [7:0] n1558_o;
  wire n1560_o;
  wire [7:0] n1561_o;
  wire [4:0] n1562_o;
  wire [7:0] n1564_o;
  wire n1567_o;
  wire n1568_o;
  wire n1571_o;
  wire n1572_o;
  wire [31:0] n1574_o;
  wire n1576_o;
  wire n1577_o;
  localparam [3:0] n1579_o = 4'b1110;
  wire [3:0] u1_n1580;
  wire [3:0] u1_q;
  wire [7:0] u2_n1583;
  wire [7:0] u2_q;
  wire n1586_o;
  wire n1587_o;
  wire n1588_o;
  wire n1589_o;
  wire n1590_o;
  wire n1591_o;
  wire n1592_o;
  wire n1593_o;
  wire u2c_n1594;
  wire u2c_q;
  wire n1597_o;
  wire n1598_o;
  wire u2d_n1599;
  wire u2d_q;
  wire u2e_n1602;
  wire u2e_q;
  wire n1607_o;
  wire [2:0] n1610_o;
  wire n1612_o;
  wire [31:0] n1613_o;
  wire n1615_o;
  wire n1616_o;
  wire [2:0] n1619_o;
  wire [2:0] n1621_o;
  wire n1624_o;
  wire n1626_o;
  wire n1627_o;
  wire [31:0] n1628_o;
  wire n1630_o;
  wire [31:0] n1631_o;
  wire n1633_o;
  wire [31:0] n1634_o;
  wire n1636_o;
  wire n1637_o;
  wire n1638_o;
  wire [31:0] n1639_o;
  wire n1641_o;
  wire [31:0] n1642_o;
  wire n1644_o;
  wire n1645_o;
  wire [2:0] n1648_o;
  wire [2:0] n1650_o;
  wire [2:0] n1652_o;
  wire n1655_o;
  wire n1657_o;
  wire [2:0] n1659_o;
  wire n1661_o;
  wire n1663_o;
  wire n1665_o;
  wire n1666_o;
  wire [31:0] n1667_o;
  wire n1669_o;
  wire [2:0] n1672_o;
  wire [2:0] n1674_o;
  wire n1676_o;
  wire n1679_o;
  wire [2:0] n1681_o;
  wire n1683_o;
  wire n1685_o;
  wire n1687_o;
  wire n1688_o;
  wire [31:0] n1689_o;
  wire n1691_o;
  wire [31:0] n1692_o;
  wire n1694_o;
  wire n1695_o;
  wire n1696_o;
  wire [2:0] n1699_o;
  wire n1702_o;
  wire [2:0] n1704_o;
  wire n1707_o;
  wire n1709_o;
  wire [2:0] n1711_o;
  wire n1713_o;
  wire n1715_o;
  wire [2:0] n1717_o;
  wire n1719_o;
  wire n1721_o;
  wire n1723_o;
  wire [2:0] n1726_o;
  wire n1728_o;
  wire [5:0] n1729_o;
  reg [2:0] n1731_o;
  reg n1739_o;
  reg n1746_o;
  reg n1751_o;
  reg n1758_o;
  reg n1765_o;
  reg n1772_o;
  reg n1779_o;
  wire [3:0] n1793_o;
  wire [3:0] u3_n1794;
  wire [3:0] u3_q;
  wire n1799_o;
  wire n1800_o;
  wire n1802_o;
  wire u4_n1803;
  wire u4_q;
  wire [2:0] n1806_o;
  reg [2:0] n1807_q;
  wire n1808_o;
  reg n1809_q;
  wire n1810_o;
  reg n1811_q;
  wire n1812_o;
  reg n1813_q;
  wire n1814_o;
  reg n1815_q;
  wire n1816_o;
  reg n1817_q;
  assign parity_er = n1811_q;
  assign frame_er = n1813_q;
  assign break_itr = n1815_q;
  assign d_rdy = n1817_q;
  assign d = n1549_o;
  /* uart/gh_uart_Rx_8bit.vhd:88:16  */
  assign r_state = n1807_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:88:25  */
  assign r_nstate = n1731_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:90:16  */
  assign parity = u4_n1803; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:91:16  */
  assign parity_grst = n1800_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:92:16  */
  assign rwc_ld = n1739_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:93:16  */
  assign r_wcount = u3_n1794; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:94:16  */
  assign s_data_ld = n1746_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:95:16  */
  assign chk_par = n1593_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:96:16  */
  assign chk_frm = n1598_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:97:16  */
  assign clr_brk = n1751_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:98:16  */
  assign clr_d = n1758_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:99:16  */
  assign s_chk_par = n1765_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:100:16  */
  assign s_chk_frm = n1772_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:101:16  */
  assign r_shift_reg = u2_n1583; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:102:16  */
  assign irx = n1809_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:103:16  */
  assign brc = n1572_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:104:16  */
  assign dclk_ld = n1568_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:105:16  */
  assign r_brdcount = u1_n1580; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:106:16  */
  assign iparity_er = u2c_n1594; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:107:16  */
  assign iframe_er = u2d_n1599; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:108:16  */
  assign ibreak_itr = u2e_n1602; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:109:16  */
  assign id_rdy = n1779_o; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:124:17  */
  assign n1530_o = brcx16 & id_rdy;
  /* uart/gh_uart_Rx_8bit.vhd:124:17  */
  assign n1531_o = brcx16 & id_rdy;
  /* uart/gh_uart_Rx_8bit.vhd:124:17  */
  assign n1532_o = brcx16 & id_rdy;
  /* uart/gh_uart_Rx_8bit.vhd:135:41  */
  assign n1548_o = num_bits == 32'b00000000000000000000000000001000;
  /* uart/gh_uart_Rx_8bit.vhd:135:26  */
  assign n1549_o = n1548_o ? r_shift_reg : n1555_o;
  /* uart/gh_uart_Rx_8bit.vhd:136:31  */
  assign n1550_o = r_shift_reg[7:1];
  /* uart/gh_uart_Rx_8bit.vhd:136:18  */
  assign n1552_o = {1'b0, n1550_o};
  /* uart/gh_uart_Rx_8bit.vhd:136:60  */
  assign n1554_o = num_bits == 32'b00000000000000000000000000000111;
  /* uart/gh_uart_Rx_8bit.vhd:135:46  */
  assign n1555_o = n1554_o ? n1552_o : n1561_o;
  /* uart/gh_uart_Rx_8bit.vhd:137:32  */
  assign n1556_o = r_shift_reg[7:2];
  /* uart/gh_uart_Rx_8bit.vhd:137:19  */
  assign n1558_o = {2'b00, n1556_o};
  /* uart/gh_uart_Rx_8bit.vhd:137:61  */
  assign n1560_o = num_bits == 32'b00000000000000000000000000000110;
  /* uart/gh_uart_Rx_8bit.vhd:136:65  */
  assign n1561_o = n1560_o ? n1558_o : n1564_o;
  /* uart/gh_uart_Rx_8bit.vhd:138:33  */
  assign n1562_o = r_shift_reg[7:3];
  /* uart/gh_uart_Rx_8bit.vhd:138:20  */
  assign n1564_o = {3'b000, n1562_o};
  /* uart/gh_uart_Rx_8bit.vhd:143:38  */
  assign n1567_o = r_state == 3'b000;
  /* uart/gh_uart_Rx_8bit.vhd:143:24  */
  assign n1568_o = n1567_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:146:33  */
  assign n1571_o = ~brcx16;
  /* uart/gh_uart_Rx_8bit.vhd:146:20  */
  assign n1572_o = n1571_o ? 1'b0 : n1577_o;
  /* uart/gh_uart_Rx_8bit.vhd:147:37  */
  assign n1574_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:147:37  */
  assign n1576_o = n1574_o == 32'b00000000000000000000000000000000;
  /* uart/gh_uart_Rx_8bit.vhd:146:40  */
  assign n1577_o = n1576_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:158:22  */
  assign u1_n1580 = u1_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:150:1  */
  gh_counter_integer_down_15 u1 (
    .clk(clk),
    .rst(rst),
    .load(dclk_ld),
    .ce(brcx16),
    .d(n1579_o),
    .q(u1_q));
  /* uart/gh_uart_Rx_8bit.vhd:170:22  */
  assign u2_n1583 = u2_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:162:1  */
  gh_shift_reg_se_sl_8 u2 (
    .clk(clk),
    .rst(rst),
    .srst(clr_d),
    .se(s_data_ld),
    .d(srx),
    .q(u2_q));
  /* uart/gh_uart_Rx_8bit.vhd:174:44  */
  assign n1586_o = parity ^ irx;
  /* uart/gh_uart_Rx_8bit.vhd:174:53  */
  assign n1587_o = n1586_o & parity_ev;
  /* uart/gh_uart_Rx_8bit.vhd:175:32  */
  assign n1588_o = ~parity;
  /* uart/gh_uart_Rx_8bit.vhd:175:44  */
  assign n1589_o = n1588_o ^ irx;
  /* uart/gh_uart_Rx_8bit.vhd:175:58  */
  assign n1590_o = ~parity_ev;
  /* uart/gh_uart_Rx_8bit.vhd:175:53  */
  assign n1591_o = n1589_o & n1590_o;
  /* uart/gh_uart_Rx_8bit.vhd:175:26  */
  assign n1592_o = n1587_o | n1591_o;
  /* uart/gh_uart_Rx_8bit.vhd:174:30  */
  assign n1593_o = s_chk_par & n1592_o;
  /* uart/gh_uart_Rx_8bit.vhd:183:22  */
  assign u2c_n1594 = u2c_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:177:1  */
  gh_jkff u2c (
    .clk(clk),
    .rst(rst),
    .j(chk_par),
    .k(dclk_ld),
    .q(u2c_q));
  /* uart/gh_uart_Rx_8bit.vhd:185:35  */
  assign n1597_o = ~irx;
  /* uart/gh_uart_Rx_8bit.vhd:185:30  */
  assign n1598_o = s_chk_frm & n1597_o;
  /* uart/gh_uart_Rx_8bit.vhd:193:22  */
  assign u2d_n1599 = u2d_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:187:1  */
  gh_jkff u2d (
    .clk(clk),
    .rst(rst),
    .j(chk_frm),
    .k(dclk_ld),
    .q(u2d_q));
  /* uart/gh_uart_Rx_8bit.vhd:201:22  */
  assign u2e_n1602 = u2e_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:195:1  */
  gh_jkff u2e (
    .clk(clk),
    .rst(rst),
    .j(clr_d),
    .k(clr_brk),
    .q(u2e_q));
  /* uart/gh_uart_Rx_8bit.vhd:214:33  */
  assign n1607_o = ~irx;
  /* uart/gh_uart_Rx_8bit.vhd:214:25  */
  assign n1610_o = n1607_o ? 3'b001 : 3'b000;
  /* uart/gh_uart_Rx_8bit.vhd:210:17  */
  assign n1612_o = r_state == 3'b000;
  /* uart/gh_uart_Rx_8bit.vhd:225:44  */
  assign n1613_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:225:44  */
  assign n1615_o = n1613_o == 32'b00000000000000000000000000001000;
  /* uart/gh_uart_Rx_8bit.vhd:225:49  */
  assign n1616_o = n1615_o & irx;
  /* uart/gh_uart_Rx_8bit.vhd:225:25  */
  assign n1619_o = n1616_o ? 3'b000 : 3'b001;
  /* uart/gh_uart_Rx_8bit.vhd:222:25  */
  assign n1621_o = brc ? 3'b010 : n1619_o;
  /* uart/gh_uart_Rx_8bit.vhd:222:25  */
  assign n1624_o = brc ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:219:17  */
  assign n1626_o = r_state == 3'b001;
  /* uart/gh_uart_Rx_8bit.vhd:236:36  */
  assign n1627_o = ~brcx16;
  /* uart/gh_uart_Rx_8bit.vhd:239:43  */
  assign n1628_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:239:43  */
  assign n1630_o = n1628_o == 32'b00000000000000000000000000001000;
  /* uart/gh_uart_Rx_8bit.vhd:242:42  */
  assign n1631_o = {28'b0, r_wcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:242:42  */
  assign n1633_o = n1631_o == 32'b00000000000000000000000000000001;
  /* uart/gh_uart_Rx_8bit.vhd:242:63  */
  assign n1634_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:242:63  */
  assign n1636_o = n1634_o == 32'b00000000000000000000000000000000;
  /* uart/gh_uart_Rx_8bit.vhd:242:47  */
  assign n1637_o = n1633_o & n1636_o;
  /* uart/gh_uart_Rx_8bit.vhd:242:68  */
  assign n1638_o = n1637_o & parity_en;
  /* uart/gh_uart_Rx_8bit.vhd:245:42  */
  assign n1639_o = {28'b0, r_wcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:245:42  */
  assign n1641_o = n1639_o == 32'b00000000000000000000000000000001;
  /* uart/gh_uart_Rx_8bit.vhd:245:63  */
  assign n1642_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:245:63  */
  assign n1644_o = n1642_o == 32'b00000000000000000000000000000000;
  /* uart/gh_uart_Rx_8bit.vhd:245:47  */
  assign n1645_o = n1641_o & n1644_o;
  /* uart/gh_uart_Rx_8bit.vhd:245:25  */
  assign n1648_o = n1645_o ? 3'b100 : 3'b010;
  /* uart/gh_uart_Rx_8bit.vhd:242:25  */
  assign n1650_o = n1638_o ? 3'b011 : n1648_o;
  /* uart/gh_uart_Rx_8bit.vhd:239:25  */
  assign n1652_o = n1630_o ? 3'b010 : n1650_o;
  /* uart/gh_uart_Rx_8bit.vhd:239:25  */
  assign n1655_o = n1630_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:239:25  */
  assign n1657_o = n1630_o ? irx : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:236:25  */
  assign n1659_o = n1627_o ? 3'b010 : n1652_o;
  /* uart/gh_uart_Rx_8bit.vhd:236:25  */
  assign n1661_o = n1627_o ? 1'b0 : n1655_o;
  /* uart/gh_uart_Rx_8bit.vhd:236:25  */
  assign n1663_o = n1627_o ? 1'b0 : n1657_o;
  /* uart/gh_uart_Rx_8bit.vhd:232:17  */
  assign n1665_o = r_state == 3'b010;
  /* uart/gh_uart_Rx_8bit.vhd:256:36  */
  assign n1666_o = ~brcx16;
  /* uart/gh_uart_Rx_8bit.vhd:259:43  */
  assign n1667_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:259:43  */
  assign n1669_o = n1667_o == 32'b00000000000000000000000000001000;
  /* uart/gh_uart_Rx_8bit.vhd:262:25  */
  assign n1672_o = brc ? 3'b100 : 3'b011;
  /* uart/gh_uart_Rx_8bit.vhd:259:25  */
  assign n1674_o = n1669_o ? 3'b011 : n1672_o;
  /* uart/gh_uart_Rx_8bit.vhd:259:25  */
  assign n1676_o = n1669_o ? irx : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:259:25  */
  assign n1679_o = n1669_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:256:25  */
  assign n1681_o = n1666_o ? 3'b011 : n1674_o;
  /* uart/gh_uart_Rx_8bit.vhd:256:25  */
  assign n1683_o = n1666_o ? 1'b0 : n1676_o;
  /* uart/gh_uart_Rx_8bit.vhd:256:25  */
  assign n1685_o = n1666_o ? 1'b0 : n1679_o;
  /* uart/gh_uart_Rx_8bit.vhd:252:17  */
  assign n1687_o = r_state == 3'b011;
  /* uart/gh_uart_Rx_8bit.vhd:273:41  */
  assign n1688_o = brc & ibreak_itr;
  /* uart/gh_uart_Rx_8bit.vhd:279:43  */
  assign n1689_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:279:43  */
  assign n1691_o = n1689_o == 32'b00000000000000000000000000001000;
  /* uart/gh_uart_Rx_8bit.vhd:282:44  */
  assign n1692_o = {28'b0, r_brdcount};  //  uext
  /* uart/gh_uart_Rx_8bit.vhd:282:44  */
  assign n1694_o = n1692_o == 32'b00000000000000000000000000000111;
  /* uart/gh_uart_Rx_8bit.vhd:282:65  */
  assign n1695_o = ~ibreak_itr;
  /* uart/gh_uart_Rx_8bit.vhd:282:49  */
  assign n1696_o = n1694_o & n1695_o;
  /* uart/gh_uart_Rx_8bit.vhd:282:25  */
  assign n1699_o = n1696_o ? 3'b000 : 3'b100;
  /* uart/gh_uart_Rx_8bit.vhd:282:25  */
  assign n1702_o = n1696_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:279:25  */
  assign n1704_o = n1691_o ? 3'b100 : n1699_o;
  /* uart/gh_uart_Rx_8bit.vhd:279:25  */
  assign n1707_o = n1691_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:279:25  */
  assign n1709_o = n1691_o ? 1'b0 : n1702_o;
  /* uart/gh_uart_Rx_8bit.vhd:276:25  */
  assign n1711_o = brc ? 3'b000 : n1704_o;
  /* uart/gh_uart_Rx_8bit.vhd:276:25  */
  assign n1713_o = brc ? 1'b0 : n1707_o;
  /* uart/gh_uart_Rx_8bit.vhd:276:25  */
  assign n1715_o = brc ? 1'b1 : n1709_o;
  /* uart/gh_uart_Rx_8bit.vhd:273:25  */
  assign n1717_o = n1688_o ? 3'b101 : n1711_o;
  /* uart/gh_uart_Rx_8bit.vhd:273:25  */
  assign n1719_o = n1688_o ? 1'b0 : n1713_o;
  /* uart/gh_uart_Rx_8bit.vhd:273:25  */
  assign n1721_o = n1688_o ? 1'b1 : n1715_o;
  /* uart/gh_uart_Rx_8bit.vhd:269:17  */
  assign n1723_o = r_state == 3'b100;
  /* uart/gh_uart_Rx_8bit.vhd:293:25  */
  assign n1726_o = irx ? 3'b000 : 3'b101;
  /* uart/gh_uart_Rx_8bit.vhd:289:17  */
  assign n1728_o = r_state == 3'b101;
  assign n1729_o = {n1728_o, n1723_o, n1687_o, n1665_o, n1626_o, n1612_o};
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1731_o = n1726_o;
      6'b010000: n1731_o = n1717_o;
      6'b001000: n1731_o = n1681_o;
      6'b000100: n1731_o = n1659_o;
      6'b000010: n1731_o = n1621_o;
      6'b000001: n1731_o = n1610_o;
      default: n1731_o = 3'b000;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1739_o = 1'b0;
      6'b010000: n1739_o = 1'b0;
      6'b001000: n1739_o = 1'b0;
      6'b000100: n1739_o = 1'b0;
      6'b000010: n1739_o = 1'b1;
      6'b000001: n1739_o = 1'b1;
      default: n1739_o = 1'b0;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1746_o = 1'b0;
      6'b010000: n1746_o = 1'b0;
      6'b001000: n1746_o = 1'b0;
      6'b000100: n1746_o = n1661_o;
      6'b000010: n1746_o = 1'b0;
      6'b000001: n1746_o = 1'b0;
      default: n1746_o = 1'b0;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1751_o = 1'b0;
      6'b010000: n1751_o = irx;
      6'b001000: n1751_o = n1683_o;
      6'b000100: n1751_o = n1663_o;
      6'b000010: n1751_o = 1'b0;
      6'b000001: n1751_o = 1'b0;
      default: n1751_o = 1'b0;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1758_o = 1'b0;
      6'b010000: n1758_o = 1'b0;
      6'b001000: n1758_o = 1'b0;
      6'b000100: n1758_o = 1'b0;
      6'b000010: n1758_o = n1624_o;
      6'b000001: n1758_o = 1'b0;
      default: n1758_o = 1'b0;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1765_o = 1'b0;
      6'b010000: n1765_o = 1'b0;
      6'b001000: n1765_o = n1685_o;
      6'b000100: n1765_o = 1'b0;
      6'b000010: n1765_o = 1'b0;
      6'b000001: n1765_o = 1'b0;
      default: n1765_o = 1'b0;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1772_o = 1'b0;
      6'b010000: n1772_o = n1719_o;
      6'b001000: n1772_o = 1'b0;
      6'b000100: n1772_o = 1'b0;
      6'b000010: n1772_o = 1'b0;
      6'b000001: n1772_o = 1'b0;
      default: n1772_o = 1'b0;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:209:9  */
  always @*
    case (n1729_o)
      6'b100000: n1779_o = 1'b0;
      6'b010000: n1779_o = n1721_o;
      6'b001000: n1779_o = 1'b0;
      6'b000100: n1779_o = 1'b0;
      6'b000010: n1779_o = 1'b0;
      6'b000001: n1779_o = 1'b0;
      default: n1779_o = 1'b0;
    endcase
  /* uart/gh_uart_Rx_8bit.vhd:331:22  */
  assign n1793_o = num_bits[3:0];  // trunc
  /* uart/gh_uart_Rx_8bit.vhd:332:22  */
  assign u3_n1794 = u3_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:324:1  */
  gh_counter_integer_down_8 u3 (
    .clk(clk),
    .rst(rst),
    .load(rwc_ld),
    .ce(brc),
    .d(n1793_o),
    .q(u3_q));
  /* uart/gh_uart_Rx_8bit.vhd:338:42  */
  assign n1799_o = r_state == 3'b001;
  /* uart/gh_uart_Rx_8bit.vhd:338:28  */
  assign n1800_o = n1799_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Rx_8bit.vhd:347:33  */
  assign n1802_o = r_shift_reg[7];
  /* uart/gh_uart_Rx_8bit.vhd:348:22  */
  assign u4_n1803 = u4_q; // (signal)
  /* uart/gh_uart_Rx_8bit.vhd:341:1  */
  gh_parity_gen_serial u4 (
    .clk(clk),
    .rst(rst),
    .srst(parity_grst),
    .sd(brc),
    .d(n1802_o),
    .q(u4_q));
  /* uart/gh_uart_Rx_8bit.vhd:313:9  */
  assign n1806_o = brcx16 ? r_nstate : r_state;
  /* uart/gh_uart_Rx_8bit.vhd:313:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1807_q <= 3'b000;
    else
      n1807_q <= n1806_o;
  /* uart/gh_uart_Rx_8bit.vhd:313:9  */
  assign n1808_o = brcx16 ? srx : irx;
  /* uart/gh_uart_Rx_8bit.vhd:313:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1809_q <= 1'b1;
    else
      n1809_q <= n1808_o;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  assign n1810_o = n1530_o ? iparity_er : n1811_q;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1811_q <= 1'b0;
    else
      n1811_q <= n1810_o;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  assign n1812_o = n1531_o ? iframe_er : n1813_q;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1813_q <= 1'b0;
    else
      n1813_q <= n1812_o;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  assign n1814_o = n1532_o ? ibreak_itr : n1815_q;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1815_q <= 1'b0;
    else
      n1815_q <= n1814_o;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  assign n1816_o = brcx16 ? id_rdy : n1817_q;
  /* uart/gh_uart_Rx_8bit.vhd:123:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1817_q <= 1'b0;
    else
      n1817_q <= n1816_o;
endmodule

module gh_fifo_async16_rcsr_wf_11
  (input  clk_wr,
   input  clk_rd,
   input  rst,
   input  rc_srst,
   input  wr,
   input  rd,
   input  [10:0] d,
   output [10:0] q,
   output empty,
   output q_full,
   output h_full,
   output a_full,
   output full);
  wire iempty;
  wire diempty;
  wire ifull;
  wire add_wr_ce;
  wire [4:0] add_wr;
  wire [4:0] add_wr_gc;
  wire [4:0] iadd_wr_gc;
  wire [4:0] n_add_wr;
  wire [4:0] add_wr_rs;
  wire add_rd_ce;
  wire [4:0] add_rd;
  wire [4:0] add_rd_gc;
  wire [4:0] iadd_rd_gc;
  wire [4:0] add_rd_gcwc;
  wire [4:0] iadd_rd_gcwc;
  wire [4:0] iiadd_rd_gcwc;
  wire [4:0] n_add_rd;
  wire [4:0] add_rd_ws;
  wire srst_w;
  wire isrst_w;
  wire srst_r;
  wire isrst_r;
  wire [4:0] c_add_rd;
  wire [4:0] c_add_wr;
  wire [4:0] c_add;
  wire n1338_o;
  wire n1339_o;
  wire [3:0] n1340_o;
  wire [3:0] n1347_o;
  wire n1352_o;
  wire n1354_o;
  wire n1355_o;
  wire [4:0] n1358_o;
  wire [4:0] u1_n1359;
  wire [4:0] u1_g;
  wire [4:0] n1367_o;
  wire [4:0] n1368_o;
  wire [4:0] n1370_o;
  wire [4:0] n1372_o;
  wire [4:0] n1380_o;
  wire n1384_o;
  wire n1386_o;
  wire n1387_o;
  wire n1390_o;
  wire n1392_o;
  wire n1393_o;
  wire [4:0] n1396_o;
  wire [4:0] u2_n1397;
  wire [4:0] u2_g;
  wire n1400_o;
  wire n1401_o;
  wire [3:0] n1402_o;
  wire [4:0] n1403_o;
  wire [4:0] u3_n1404;
  wire [4:0] u3_g;
  wire [4:0] n1414_o;
  wire [4:0] n1415_o;
  wire [4:0] n1416_o;
  wire [4:0] n1418_o;
  wire [4:0] n1420_o;
  wire [4:0] n1421_o;
  wire [4:0] n1422_o;
  wire [4:0] n1436_o;
  wire n1440_o;
  wire n1441_o;
  wire [4:0] u4_n1443;
  wire [4:0] u4_b;
  wire [4:0] u5_n1446;
  wire [4:0] u5_b;
  wire [4:0] n1449_o;
  wire n1451_o;
  wire [2:0] n1453_o;
  wire n1455_o;
  wire n1456_o;
  wire n1459_o;
  wire [1:0] n1461_o;
  wire n1463_o;
  wire n1464_o;
  wire n1467_o;
  wire [3:0] n1469_o;
  wire n1471_o;
  wire n1472_o;
  wire n1477_o;
  wire n1479_o;
  wire n1481_o;
  wire n1493_o;
  wire n1495_o;
  reg n1505_q;
  reg [4:0] n1506_q;
  reg [4:0] n1507_q;
  reg [4:0] n1508_q;
  reg [4:0] n1509_q;
  reg [4:0] n1510_q;
  reg [4:0] n1511_q;
  reg [4:0] n1512_q;
  reg n1513_q;
  reg n1514_q;
  reg n1515_q;
  reg n1516_q;
  wire [10:0] n1517_data; // mem_rd
  assign q = n1517_data;
  assign empty = diempty;
  assign q_full = n1451_o;
  assign h_full = n1459_o;
  assign a_full = n1467_o;
  assign full = ifull;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:64:16  */
  assign iempty = n1441_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:65:16  */
  assign diempty = n1505_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:66:16  */
  assign ifull = n1384_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:67:16  */
  assign add_wr_ce = n1352_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:68:16  */
  assign add_wr = n1506_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:69:16  */
  assign add_wr_gc = n1507_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:70:16  */
  assign iadd_wr_gc = u1_n1359; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:71:16  */
  assign n_add_wr = n1358_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:72:16  */
  assign add_wr_rs = n1508_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:73:16  */
  assign add_rd_ce = n1390_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:74:16  */
  assign add_rd = n1509_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:75:16  */
  assign add_rd_gc = n1510_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:76:16  */
  assign iadd_rd_gc = u2_n1397; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:77:16  */
  assign add_rd_gcwc = n1511_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:78:16  */
  assign iadd_rd_gcwc = u3_n1404; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:79:16  */
  assign iiadd_rd_gcwc = n1403_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:80:16  */
  assign n_add_rd = n1396_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:81:16  */
  assign add_rd_ws = n1512_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:82:16  */
  assign srst_w = n1513_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:83:16  */
  assign isrst_w = n1514_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:84:16  */
  assign srst_r = n1515_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:85:16  */
  assign isrst_r = n1516_q; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:86:16  */
  assign c_add_rd = u4_n1443; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:87:16  */
  assign c_add_wr = u5_n1446; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:88:16  */
  assign c_add = n1449_o; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:100:43  */
  assign n1338_o = ~ifull;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:100:32  */
  assign n1339_o = wr & n1338_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:101:59  */
  assign n1340_o = add_wr[3:0];
  /* uart/gh_fifo_async16_rcsr_wf.vhd:106:48  */
  assign n1347_o = add_rd[3:0];
  /* uart/gh_fifo_async16_rcsr_wf.vhd:112:26  */
  assign n1352_o = ifull ? 1'b0 : n1355_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:113:35  */
  assign n1354_o = ~wr;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:112:45  */
  assign n1355_o = n1354_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:116:55  */
  assign n1358_o = add_wr + 5'b00001;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:122:22  */
  assign u1_n1359 = u1_g; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:118:1  */
  gh_binary2gray_5 u1 (
    .b(n_add_wr),
    .g(u1_g));
  /* uart/gh_fifo_async16_rcsr_wf.vhd:137:17  */
  assign n1367_o = add_wr_ce ? n_add_wr : add_wr;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:137:17  */
  assign n1368_o = add_wr_ce ? iadd_wr_gc : add_wr_gc;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:134:17  */
  assign n1370_o = srst_w ? 5'b00000 : n1367_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:134:17  */
  assign n1372_o = srst_w ? 5'b00000 : n1368_o;
  assign n1380_o = {2'b11, 3'b000};
  /* uart/gh_fifo_async16_rcsr_wf.vhd:149:22  */
  assign n1384_o = iempty ? 1'b0 : n1387_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:150:38  */
  assign n1386_o = add_rd_ws != add_wr_gc;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:149:42  */
  assign n1387_o = n1386_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:159:26  */
  assign n1390_o = iempty ? 1'b0 : n1393_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:160:35  */
  assign n1392_o = ~rd;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:159:46  */
  assign n1393_o = n1392_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:163:55  */
  assign n1396_o = add_rd + 5'b00001;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:169:22  */
  assign u2_n1397 = u2_g; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:165:1  */
  gh_binary2gray_5 u2 (
    .b(n_add_rd),
    .g(u2_g));
  /* uart/gh_fifo_async16_rcsr_wf.vhd:172:39  */
  assign n1400_o = n_add_rd[4];
  /* uart/gh_fifo_async16_rcsr_wf.vhd:172:27  */
  assign n1401_o = ~n1400_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:172:54  */
  assign n1402_o = n_add_rd[3:0];
  /* uart/gh_fifo_async16_rcsr_wf.vhd:172:44  */
  assign n1403_o = {n1401_o, n1402_o};
  /* uart/gh_fifo_async16_rcsr_wf.vhd:178:22  */
  assign u3_n1404 = u3_g; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:174:1  */
  gh_binary2gray_5 u3 (
    .b(iiadd_rd_gcwc),
    .g(u3_g));
  /* uart/gh_fifo_async16_rcsr_wf.vhd:198:17  */
  assign n1414_o = add_rd_ce ? n_add_rd : add_rd;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:198:17  */
  assign n1415_o = add_rd_ce ? iadd_rd_gc : add_rd_gc;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:198:17  */
  assign n1416_o = add_rd_ce ? iadd_rd_gcwc : add_rd_gcwc;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:193:17  */
  assign n1418_o = srst_r ? 5'b00000 : n1414_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:193:17  */
  assign n1420_o = srst_r ? 5'b00000 : n1415_o;
  assign n1421_o = {2'b11, 3'b000};
  /* uart/gh_fifo_async16_rcsr_wf.vhd:193:17  */
  assign n1422_o = srst_r ? n1421_o : n1416_o;
  assign n1436_o = {2'b11, 3'b000};
  /* uart/gh_fifo_async16_rcsr_wf.vhd:212:39  */
  assign n1440_o = add_wr_rs == add_rd_gc;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:212:23  */
  assign n1441_o = n1440_o ? 1'b1 : 1'b0;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:219:22  */
  assign u4_n1443 = u4_b; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:215:1  */
  gh_gray2binary_5 u4 (
    .g(add_rd_gc),
    .b(u4_b));
  /* uart/gh_fifo_async16_rcsr_wf.vhd:226:22  */
  assign u5_n1446 = u5_b; // (signal)
  /* uart/gh_fifo_async16_rcsr_wf.vhd:222:1  */
  gh_gray2binary_5 u5 (
    .g(add_wr_rs),
    .b(u5_b));
  /* uart/gh_fifo_async16_rcsr_wf.vhd:229:54  */
  assign n1449_o = c_add_wr + c_add_rd;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:231:23  */
  assign n1451_o = iempty ? 1'b0 : n1456_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:232:43  */
  assign n1453_o = c_add[4:2];
  /* uart/gh_fifo_async16_rcsr_wf.vhd:232:57  */
  assign n1455_o = n1453_o == 3'b000;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:231:43  */
  assign n1456_o = n1455_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:235:23  */
  assign n1459_o = iempty ? 1'b0 : n1464_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:236:43  */
  assign n1461_o = c_add[4:3];
  /* uart/gh_fifo_async16_rcsr_wf.vhd:236:57  */
  assign n1463_o = n1461_o == 2'b00;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:235:43  */
  assign n1464_o = n1463_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:239:23  */
  assign n1467_o = iempty ? 1'b0 : n1472_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:240:43  */
  assign n1469_o = c_add[4:1];
  /* uart/gh_fifo_async16_rcsr_wf.vhd:240:57  */
  assign n1471_o = $unsigned(n1469_o) < $unsigned(4'b0111);
  /* uart/gh_fifo_async16_rcsr_wf.vhd:239:43  */
  assign n1472_o = n1471_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:258:31  */
  assign n1477_o = ~srst_w;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:258:17  */
  assign n1479_o = n1477_o ? 1'b0 : isrst_r;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:256:17  */
  assign n1481_o = srst_w ? 1'b1 : n1479_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:273:17  */
  assign n1493_o = isrst_r ? 1'b0 : isrst_w;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:271:17  */
  assign n1495_o = rc_srst ? 1'b1 : n1493_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:190:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1505_q <= 1'b1;
    else
      n1505_q <= iempty;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:132:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1506_q <= 5'b00000;
    else
      n1506_q <= n1370_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:132:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1507_q <= 5'b00000;
    else
      n1507_q <= n1372_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:190:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1508_q <= 5'b00000;
    else
      n1508_q <= add_wr_gc;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:190:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1509_q <= 5'b00000;
    else
      n1509_q <= n1418_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:190:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1510_q <= 5'b00000;
    else
      n1510_q <= n1420_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:190:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1511_q <= n1436_o;
    else
      n1511_q <= n1422_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:132:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1512_q <= n1380_o;
    else
      n1512_q <= add_rd_gcwc;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:254:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1513_q <= 1'b0;
    else
      n1513_q <= isrst_w;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:269:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1514_q <= 1'b0;
    else
      n1514_q <= n1495_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:269:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1515_q <= 1'b0;
    else
      n1515_q <= rc_srst;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:254:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1516_q <= 1'b0;
    else
      n1516_q <= n1481_o;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:226:22  */
  reg [10:0] ram_mem[15:0] ; // memory
  assign n1517_data = ram_mem[n1347_o];
  always @(posedge clk_wr)
    if (n1339_o)
      ram_mem[n1340_o] <= d;
  /* uart/gh_fifo_async16_rcsr_wf.vhd:106:22  */
  /* uart/gh_fifo_async16_rcsr_wf.vhd:101:33  */
endmodule

module gh_uart_tx_8bit
  (input  clk,
   input  rst,
   input  xbrc,
   input  d_ryn,
   input  [7:0] d,
   input  [31:0] num_bits,
   input  break_cb,
   input  stopb,
   input  parity_en,
   input  parity_ev,
   output stx,
   output busyn,
   output read);
  wire [2:0] t_state;
  wire [2:0] t_nstate;
  wire parity;
  wire parity_grst;
  wire twc_ld;
  wire twc_ce;
  wire [3:0] t_wcount;
  wire [3:0] d_ld_v;
  wire d_ld;
  wire trans_sr_se;
  wire [7:0] trans_shift_reg;
  wire itx;
  wire brc;
  wire dclk_ld;
  wire [3:0] x_dcount;
  wire n1102_o;
  wire n1103_o;
  wire n1107_o;
  wire n1108_o;
  wire n1110_o;
  wire n1111_o;
  wire [31:0] n1112_o;
  wire n1114_o;
  wire n1115_o;
  wire n1116_o;
  wire n1118_o;
  wire n1119_o;
  wire n1122_o;
  wire n1123_o;
  wire n1127_o;
  wire [3:0] n1128_o;
  wire n1131_o;
  wire n1132_o;
  wire [31:0] n1134_o;
  wire n1136_o;
  wire n1137_o;
  wire [3:0] u1_n1139;
  wire [3:0] u1_q;
  wire [7:0] u2_n1142;
  wire [7:0] u2_q;
  wire n1148_o;
  wire n1149_o;
  wire n1156_o;
  wire n1157_o;
  wire n1158_o;
  wire n1160_o;
  wire n1161_o;
  wire n1163_o;
  wire n1164_o;
  wire n1165_o;
  wire n1166_o;
  wire n1168_o;
  wire n1169_o;
  wire n1173_o;
  wire n1174_o;
  wire [2:0] n1177_o;
  wire n1180_o;
  wire n1182_o;
  wire [2:0] n1185_o;
  wire n1188_o;
  wire n1190_o;
  wire n1191_o;
  wire [31:0] n1192_o;
  wire n1194_o;
  wire n1195_o;
  wire [31:0] n1196_o;
  wire n1198_o;
  wire [2:0] n1201_o;
  wire n1204_o;
  wire [2:0] n1206_o;
  wire n1208_o;
  wire [2:0] n1210_o;
  wire n1213_o;
  wire n1215_o;
  wire n1217_o;
  wire [2:0] n1220_o;
  wire n1222_o;
  wire n1223_o;
  wire n1224_o;
  wire [2:0] n1227_o;
  wire n1230_o;
  wire [2:0] n1232_o;
  wire n1234_o;
  wire [2:0] n1236_o;
  wire n1238_o;
  wire n1240_o;
  wire n1241_o;
  wire n1242_o;
  wire n1244_o;
  wire [31:0] n1245_o;
  wire n1247_o;
  wire n1248_o;
  wire n1249_o;
  wire n1250_o;
  wire n1252_o;
  wire [31:0] n1253_o;
  wire n1255_o;
  wire n1256_o;
  wire [2:0] n1259_o;
  wire n1262_o;
  wire [2:0] n1264_o;
  wire n1266_o;
  wire [2:0] n1268_o;
  wire n1270_o;
  wire [2:0] n1272_o;
  wire n1274_o;
  wire n1276_o;
  wire [5:0] n1277_o;
  reg [2:0] n1279_o;
  reg n1286_o;
  reg n1293_o;
  reg n1298_o;
  reg n1305_o;
  wire [3:0] n1314_o;
  wire [3:0] u3_n1315;
  wire [3:0] u3_q;
  wire n1320_o;
  wire n1321_o;
  wire n1323_o;
  wire u4_n1324;
  wire u4_q;
  reg [2:0] n1327_q;
  reg n1328_q;
  assign stx = n1328_q;
  assign busyn = n1103_o;
  assign read = d_ld;
  /* uart/gh_uart_Tx_8bit.vhd:83:16  */
  assign t_state = n1327_q; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:83:25  */
  assign t_nstate = n1279_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:85:16  */
  assign parity = u4_n1324; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:86:16  */
  assign parity_grst = n1321_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:87:16  */
  assign twc_ld = n1286_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:88:16  */
  assign twc_ce = n1293_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:89:16  */
  assign t_wcount = u3_n1315; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:90:16  */
  assign d_ld_v = n1128_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:91:16  */
  assign d_ld = n1298_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:92:16  */
  assign trans_sr_se = n1305_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:93:16  */
  assign trans_shift_reg = u2_n1142; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:94:16  */
  assign itx = n1157_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:95:16  */
  assign brc = n1132_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:96:16  */
  assign dclk_ld = n1116_o; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:97:16  */
  assign x_dcount = u1_n1139; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:105:36  */
  assign n1102_o = t_state == 3'b000;
  /* uart/gh_uart_Tx_8bit.vhd:105:22  */
  assign n1103_o = n1102_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Tx_8bit.vhd:112:40  */
  assign n1107_o = num_bits == 32'b00000000000000000000000000000101;
  /* uart/gh_uart_Tx_8bit.vhd:112:45  */
  assign n1108_o = n1107_o & stopb;
  /* uart/gh_uart_Tx_8bit.vhd:113:37  */
  assign n1110_o = t_state == 3'b101;
  /* uart/gh_uart_Tx_8bit.vhd:113:24  */
  assign n1111_o = n1108_o & n1110_o;
  /* uart/gh_uart_Tx_8bit.vhd:113:66  */
  assign n1112_o = {28'b0, x_dcount};  //  uext
  /* uart/gh_uart_Tx_8bit.vhd:113:66  */
  assign n1114_o = n1112_o == 32'b00000000000000000000000000000111;
  /* uart/gh_uart_Tx_8bit.vhd:113:52  */
  assign n1115_o = n1111_o & n1114_o;
  /* uart/gh_uart_Tx_8bit.vhd:112:24  */
  assign n1116_o = n1115_o ? 1'b1 : n1119_o;
  /* uart/gh_uart_Tx_8bit.vhd:114:36  */
  assign n1118_o = ~d_ryn;
  /* uart/gh_uart_Tx_8bit.vhd:113:72  */
  assign n1119_o = n1118_o ? 1'b0 : n1123_o;
  /* uart/gh_uart_Tx_8bit.vhd:115:38  */
  assign n1122_o = t_state != 3'b000;
  /* uart/gh_uart_Tx_8bit.vhd:114:43  */
  assign n1123_o = n1122_o ? 1'b0 : 1'b1;
  /* uart/gh_uart_Tx_8bit.vhd:118:36  */
  assign n1127_o = t_state == 3'b101;
  /* uart/gh_uart_Tx_8bit.vhd:118:22  */
  assign n1128_o = n1127_o ? 4'b1111 : 4'b0001;
  /* uart/gh_uart_Tx_8bit.vhd:121:31  */
  assign n1131_o = ~xbrc;
  /* uart/gh_uart_Tx_8bit.vhd:121:20  */
  assign n1132_o = n1131_o ? 1'b0 : n1137_o;
  /* uart/gh_uart_Tx_8bit.vhd:122:35  */
  assign n1134_o = {28'b0, x_dcount};  //  uext
  /* uart/gh_uart_Tx_8bit.vhd:122:35  */
  assign n1136_o = n1134_o == 32'b00000000000000000000000000000000;
  /* uart/gh_uart_Tx_8bit.vhd:121:38  */
  assign n1137_o = n1136_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Tx_8bit.vhd:134:22  */
  assign u1_n1139 = u1_q; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:126:1  */
  gh_counter_integer_down_15 u1 (
    .clk(clk),
    .rst(rst),
    .load(dclk_ld),
    .ce(xbrc),
    .d(d_ld_v),
    .q(u1_q));
  /* uart/gh_uart_Tx_8bit.vhd:144:22  */
  assign u2_n1142 = u2_q; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:136:1  */
  gh_shift_reg_pl_sl_8 u2 (
    .clk(clk),
    .rst(rst),
    .load(d_ld),
    .se(trans_sr_se),
    .d(d),
    .q(u2_q));
  /* uart/gh_uart_Tx_8bit.vhd:154:33  */
  assign n1148_o = ~break_cb;
  /* uart/gh_uart_Tx_8bit.vhd:154:28  */
  assign n1149_o = itx & n1148_o;
  /* uart/gh_uart_Tx_8bit.vhd:158:34  */
  assign n1156_o = t_state == 3'b001;
  /* uart/gh_uart_Tx_8bit.vhd:158:20  */
  assign n1157_o = n1156_o ? 1'b0 : n1161_o;
  /* uart/gh_uart_Tx_8bit.vhd:159:32  */
  assign n1158_o = trans_shift_reg[0];
  /* uart/gh_uart_Tx_8bit.vhd:159:50  */
  assign n1160_o = t_state == 3'b010;
  /* uart/gh_uart_Tx_8bit.vhd:158:49  */
  assign n1161_o = n1160_o ? n1158_o : n1165_o;
  /* uart/gh_uart_Tx_8bit.vhd:160:61  */
  assign n1163_o = t_state == 3'b011;
  /* uart/gh_uart_Tx_8bit.vhd:160:48  */
  assign n1164_o = parity_ev & n1163_o;
  /* uart/gh_uart_Tx_8bit.vhd:159:64  */
  assign n1165_o = n1164_o ? parity : n1169_o;
  /* uart/gh_uart_Tx_8bit.vhd:161:18  */
  assign n1166_o = ~parity;
  /* uart/gh_uart_Tx_8bit.vhd:161:44  */
  assign n1168_o = t_state == 3'b011;
  /* uart/gh_uart_Tx_8bit.vhd:160:74  */
  assign n1169_o = n1168_o ? n1166_o : 1'b1;
  /* uart/gh_uart_Tx_8bit.vhd:169:36  */
  assign n1173_o = ~d_ryn;
  /* uart/gh_uart_Tx_8bit.vhd:169:43  */
  assign n1174_o = n1173_o & brc;
  /* uart/gh_uart_Tx_8bit.vhd:169:25  */
  assign n1177_o = n1174_o ? 3'b001 : 3'b000;
  /* uart/gh_uart_Tx_8bit.vhd:169:25  */
  assign n1180_o = n1174_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Tx_8bit.vhd:167:17  */
  assign n1182_o = t_state == 3'b000;
  /* uart/gh_uart_Tx_8bit.vhd:179:25  */
  assign n1185_o = brc ? 3'b010 : 3'b001;
  /* uart/gh_uart_Tx_8bit.vhd:179:25  */
  assign n1188_o = brc ? 1'b1 : 1'b0;
  /* uart/gh_uart_Tx_8bit.vhd:177:17  */
  assign n1190_o = t_state == 3'b001;
  /* uart/gh_uart_Tx_8bit.vhd:187:33  */
  assign n1191_o = ~brc;
  /* uart/gh_uart_Tx_8bit.vhd:191:42  */
  assign n1192_o = {28'b0, t_wcount};  //  uext
  /* uart/gh_uart_Tx_8bit.vhd:191:42  */
  assign n1194_o = n1192_o == 32'b00000000000000000000000000000001;
  /* uart/gh_uart_Tx_8bit.vhd:191:47  */
  assign n1195_o = n1194_o & parity_en;
  /* uart/gh_uart_Tx_8bit.vhd:195:41  */
  assign n1196_o = {28'b0, t_wcount};  //  uext
  /* uart/gh_uart_Tx_8bit.vhd:195:41  */
  assign n1198_o = n1196_o == 32'b00000000000000000000000000000001;
  /* uart/gh_uart_Tx_8bit.vhd:195:25  */
  assign n1201_o = n1198_o ? 3'b100 : 3'b010;
  /* uart/gh_uart_Tx_8bit.vhd:195:25  */
  assign n1204_o = n1198_o ? 1'b0 : 1'b1;
  /* uart/gh_uart_Tx_8bit.vhd:191:25  */
  assign n1206_o = n1195_o ? 3'b011 : n1201_o;
  /* uart/gh_uart_Tx_8bit.vhd:191:25  */
  assign n1208_o = n1195_o ? 1'b0 : n1204_o;
  /* uart/gh_uart_Tx_8bit.vhd:187:25  */
  assign n1210_o = n1191_o ? 3'b010 : n1206_o;
  /* uart/gh_uart_Tx_8bit.vhd:187:25  */
  assign n1213_o = n1191_o ? 1'b0 : 1'b1;
  /* uart/gh_uart_Tx_8bit.vhd:187:25  */
  assign n1215_o = n1191_o ? 1'b0 : n1208_o;
  /* uart/gh_uart_Tx_8bit.vhd:186:17  */
  assign n1217_o = t_state == 3'b010;
  /* uart/gh_uart_Tx_8bit.vhd:206:25  */
  assign n1220_o = brc ? 3'b100 : 3'b011;
  /* uart/gh_uart_Tx_8bit.vhd:204:17  */
  assign n1222_o = t_state == 3'b011;
  /* uart/gh_uart_Tx_8bit.vhd:215:33  */
  assign n1223_o = ~brc;
  /* uart/gh_uart_Tx_8bit.vhd:221:38  */
  assign n1224_o = ~d_ryn;
  /* uart/gh_uart_Tx_8bit.vhd:221:25  */
  assign n1227_o = n1224_o ? 3'b001 : 3'b000;
  /* uart/gh_uart_Tx_8bit.vhd:221:25  */
  assign n1230_o = n1224_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Tx_8bit.vhd:218:25  */
  assign n1232_o = stopb ? 3'b101 : n1227_o;
  /* uart/gh_uart_Tx_8bit.vhd:218:25  */
  assign n1234_o = stopb ? 1'b0 : n1230_o;
  /* uart/gh_uart_Tx_8bit.vhd:215:25  */
  assign n1236_o = n1223_o ? 3'b100 : n1232_o;
  /* uart/gh_uart_Tx_8bit.vhd:215:25  */
  assign n1238_o = n1223_o ? 1'b0 : n1234_o;
  /* uart/gh_uart_Tx_8bit.vhd:213:17  */
  assign n1240_o = t_state == 3'b100;
  /* uart/gh_uart_Tx_8bit.vhd:230:36  */
  assign n1241_o = ~d_ryn;
  /* uart/gh_uart_Tx_8bit.vhd:230:43  */
  assign n1242_o = n1241_o & brc;
  /* uart/gh_uart_Tx_8bit.vhd:236:42  */
  assign n1244_o = num_bits == 32'b00000000000000000000000000000101;
  /* uart/gh_uart_Tx_8bit.vhd:236:61  */
  assign n1245_o = {28'b0, x_dcount};  //  uext
  /* uart/gh_uart_Tx_8bit.vhd:236:61  */
  assign n1247_o = n1245_o == 32'b00000000000000000000000000000111;
  /* uart/gh_uart_Tx_8bit.vhd:236:47  */
  assign n1248_o = n1244_o & n1247_o;
  /* uart/gh_uart_Tx_8bit.vhd:236:77  */
  assign n1249_o = ~d_ryn;
  /* uart/gh_uart_Tx_8bit.vhd:236:66  */
  assign n1250_o = n1248_o & n1249_o;
  /* uart/gh_uart_Tx_8bit.vhd:239:42  */
  assign n1252_o = num_bits == 32'b00000000000000000000000000000101;
  /* uart/gh_uart_Tx_8bit.vhd:239:61  */
  assign n1253_o = {28'b0, x_dcount};  //  uext
  /* uart/gh_uart_Tx_8bit.vhd:239:61  */
  assign n1255_o = n1253_o == 32'b00000000000000000000000000000111;
  /* uart/gh_uart_Tx_8bit.vhd:239:47  */
  assign n1256_o = n1252_o & n1255_o;
  /* uart/gh_uart_Tx_8bit.vhd:239:25  */
  assign n1259_o = n1256_o ? 3'b000 : 3'b101;
  /* uart/gh_uart_Tx_8bit.vhd:239:25  */
  assign n1262_o = n1256_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Tx_8bit.vhd:236:25  */
  assign n1264_o = n1250_o ? 3'b001 : n1259_o;
  /* uart/gh_uart_Tx_8bit.vhd:236:25  */
  assign n1266_o = n1250_o ? 1'b1 : n1262_o;
  /* uart/gh_uart_Tx_8bit.vhd:233:25  */
  assign n1268_o = brc ? 3'b000 : n1264_o;
  /* uart/gh_uart_Tx_8bit.vhd:233:25  */
  assign n1270_o = brc ? 1'b0 : n1266_o;
  /* uart/gh_uart_Tx_8bit.vhd:230:25  */
  assign n1272_o = n1242_o ? 3'b001 : n1268_o;
  /* uart/gh_uart_Tx_8bit.vhd:230:25  */
  assign n1274_o = n1242_o ? 1'b1 : n1270_o;
  /* uart/gh_uart_Tx_8bit.vhd:228:17  */
  assign n1276_o = t_state == 3'b101;
  assign n1277_o = {n1276_o, n1240_o, n1222_o, n1217_o, n1190_o, n1182_o};
  /* uart/gh_uart_Tx_8bit.vhd:166:9  */
  always @*
    case (n1277_o)
      6'b100000: n1279_o = n1272_o;
      6'b010000: n1279_o = n1236_o;
      6'b001000: n1279_o = n1220_o;
      6'b000100: n1279_o = n1210_o;
      6'b000010: n1279_o = n1185_o;
      6'b000001: n1279_o = n1177_o;
      default: n1279_o = 3'b000;
    endcase
  /* uart/gh_uart_Tx_8bit.vhd:166:9  */
  always @*
    case (n1277_o)
      6'b100000: n1286_o = 1'b0;
      6'b010000: n1286_o = 1'b0;
      6'b001000: n1286_o = 1'b0;
      6'b000100: n1286_o = 1'b0;
      6'b000010: n1286_o = n1188_o;
      6'b000001: n1286_o = 1'b0;
      default: n1286_o = 1'b0;
    endcase
  /* uart/gh_uart_Tx_8bit.vhd:166:9  */
  always @*
    case (n1277_o)
      6'b100000: n1293_o = 1'b0;
      6'b010000: n1293_o = 1'b0;
      6'b001000: n1293_o = 1'b0;
      6'b000100: n1293_o = n1213_o;
      6'b000010: n1293_o = 1'b0;
      6'b000001: n1293_o = 1'b0;
      default: n1293_o = 1'b0;
    endcase
  /* uart/gh_uart_Tx_8bit.vhd:166:9  */
  always @*
    case (n1277_o)
      6'b100000: n1298_o = n1274_o;
      6'b010000: n1298_o = n1238_o;
      6'b001000: n1298_o = 1'b0;
      6'b000100: n1298_o = 1'b0;
      6'b000010: n1298_o = 1'b0;
      6'b000001: n1298_o = n1180_o;
      default: n1298_o = 1'b0;
    endcase
  /* uart/gh_uart_Tx_8bit.vhd:166:9  */
  always @*
    case (n1277_o)
      6'b100000: n1305_o = 1'b0;
      6'b010000: n1305_o = 1'b0;
      6'b001000: n1305_o = 1'b0;
      6'b000100: n1305_o = n1215_o;
      6'b000010: n1305_o = 1'b0;
      6'b000001: n1305_o = 1'b0;
      default: n1305_o = 1'b0;
    endcase
  /* uart/gh_uart_Tx_8bit.vhd:271:22  */
  assign n1314_o = num_bits[3:0];  // trunc
  /* uart/gh_uart_Tx_8bit.vhd:272:22  */
  assign u3_n1315 = u3_q; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:264:1  */
  gh_counter_integer_down_8 u3 (
    .clk(clk),
    .rst(rst),
    .load(twc_ld),
    .ce(twc_ce),
    .d(n1314_o),
    .q(u3_q));
  /* uart/gh_uart_Tx_8bit.vhd:278:42  */
  assign n1320_o = t_state == 3'b001;
  /* uart/gh_uart_Tx_8bit.vhd:278:28  */
  assign n1321_o = n1320_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_Tx_8bit.vhd:287:37  */
  assign n1323_o = trans_shift_reg[0];
  /* uart/gh_uart_Tx_8bit.vhd:288:22  */
  assign u4_n1324 = u4_q; // (signal)
  /* uart/gh_uart_Tx_8bit.vhd:281:1  */
  gh_parity_gen_serial u4 (
    .clk(clk),
    .rst(rst),
    .srst(parity_grst),
    .sd(brc),
    .d(n1323_o),
    .q(u4_q));
  /* uart/gh_uart_Tx_8bit.vhd:259:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1327_q <= 3'b000;
    else
      n1327_q <= t_nstate;
  /* uart/gh_uart_Tx_8bit.vhd:153:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n1328_q <= 1'b1;
    else
      n1328_q <= n1149_o;
endmodule

module gh_fifo_async16_sr_8
  (input  clk_wr,
   input  clk_rd,
   input  rst,
   input  srst,
   input  wr,
   input  rd,
   input  [7:0] d,
   output [7:0] q,
   output empty,
   output full);
  wire iempty;
  wire ifull;
  wire add_wr_ce;
  wire [4:0] add_wr;
  wire [4:0] add_wr_gc;
  wire [4:0] n_add_wr;
  wire [4:0] add_wr_rs;
  wire add_rd_ce;
  wire [4:0] add_rd;
  wire [4:0] add_rd_gc;
  wire [4:0] add_rd_gcwc;
  wire [4:0] n_add_rd;
  wire [4:0] add_rd_ws;
  wire srst_w;
  wire isrst_w;
  wire srst_r;
  wire isrst_r;
  wire n928_o;
  wire n929_o;
  wire [3:0] n930_o;
  wire [3:0] n937_o;
  wire n942_o;
  wire n944_o;
  wire n945_o;
  wire [4:0] n948_o;
  wire n952_o;
  wire n953_o;
  wire n954_o;
  wire n955_o;
  wire n956_o;
  wire n957_o;
  wire n958_o;
  wire n959_o;
  wire n960_o;
  wire n961_o;
  wire n962_o;
  wire n963_o;
  wire n964_o;
  wire [4:0] n965_o;
  wire [4:0] n966_o;
  wire [4:0] n967_o;
  wire [4:0] n969_o;
  wire [4:0] n971_o;
  wire n983_o;
  wire n985_o;
  wire n986_o;
  wire n989_o;
  wire n991_o;
  wire n992_o;
  wire [4:0] n995_o;
  wire n999_o;
  wire n1000_o;
  wire n1001_o;
  wire n1002_o;
  wire n1003_o;
  wire n1004_o;
  wire n1005_o;
  wire n1006_o;
  wire n1007_o;
  wire n1008_o;
  wire n1009_o;
  wire n1010_o;
  wire n1011_o;
  wire n1012_o;
  wire n1013_o;
  wire n1014_o;
  wire n1015_o;
  wire n1016_o;
  wire n1017_o;
  wire n1018_o;
  wire n1019_o;
  wire n1020_o;
  wire n1021_o;
  wire n1022_o;
  wire n1023_o;
  wire n1024_o;
  wire n1025_o;
  wire n1026_o;
  wire [4:0] n1027_o;
  wire [4:0] n1028_o;
  wire [4:0] n1029_o;
  wire [4:0] n1030_o;
  wire [4:0] n1031_o;
  wire [4:0] n1033_o;
  wire [4:0] n1035_o;
  wire [4:0] n1037_o;
  wire n1052_o;
  wire n1053_o;
  wire n1059_o;
  wire n1061_o;
  wire n1074_o;
  reg [4:0] n1084_q;
  reg [4:0] n1085_q;
  reg [4:0] n1086_q;
  reg [4:0] n1087_q;
  reg [4:0] n1088_q;
  reg [4:0] n1089_q;
  reg [4:0] n1090_q;
  reg n1091_q;
  reg n1092_q;
  reg n1093_q;
  reg n1094_q;
  wire [7:0] n1095_data; // mem_rd
  assign q = n1095_data;
  assign empty = iempty;
  assign full = ifull;
  /* uart/gh_fifo_async16_sr.vhd:43:16  */
  assign iempty = n1053_o; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:44:16  */
  assign ifull = n983_o; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:45:16  */
  assign add_wr_ce = n942_o; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:46:16  */
  assign add_wr = n1084_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:47:16  */
  assign add_wr_gc = n1085_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:48:16  */
  assign n_add_wr = n948_o; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:49:16  */
  assign add_wr_rs = n1086_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:50:16  */
  assign add_rd_ce = n989_o; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:51:16  */
  assign add_rd = n1087_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:52:16  */
  assign add_rd_gc = n1088_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:53:16  */
  assign add_rd_gcwc = n1089_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:54:16  */
  assign n_add_rd = n995_o; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:55:16  */
  assign add_rd_ws = n1090_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:56:16  */
  assign srst_w = n1091_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:57:16  */
  assign isrst_w = n1092_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:58:16  */
  assign srst_r = n1093_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:59:16  */
  assign isrst_r = n1094_q; // (signal)
  /* uart/gh_fifo_async16_sr.vhd:70:43  */
  assign n928_o = ~ifull;
  /* uart/gh_fifo_async16_sr.vhd:70:32  */
  assign n929_o = wr & n928_o;
  /* uart/gh_fifo_async16_sr.vhd:71:59  */
  assign n930_o = add_wr[3:0];
  /* uart/gh_fifo_async16_sr.vhd:76:48  */
  assign n937_o = add_rd[3:0];
  /* uart/gh_fifo_async16_sr.vhd:82:26  */
  assign n942_o = ifull ? 1'b0 : n945_o;
  /* uart/gh_fifo_async16_sr.vhd:83:35  */
  assign n944_o = ~wr;
  /* uart/gh_fifo_async16_sr.vhd:82:45  */
  assign n945_o = n944_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_sr.vhd:86:55  */
  assign n948_o = add_wr + 5'b00001;
  /* uart/gh_fifo_async16_sr.vhd:101:49  */
  assign n952_o = n_add_wr[0];
  /* uart/gh_fifo_async16_sr.vhd:101:65  */
  assign n953_o = n_add_wr[1];
  /* uart/gh_fifo_async16_sr.vhd:101:53  */
  assign n954_o = n952_o ^ n953_o;
  /* uart/gh_fifo_async16_sr.vhd:102:49  */
  assign n955_o = n_add_wr[1];
  /* uart/gh_fifo_async16_sr.vhd:102:65  */
  assign n956_o = n_add_wr[2];
  /* uart/gh_fifo_async16_sr.vhd:102:53  */
  assign n957_o = n955_o ^ n956_o;
  /* uart/gh_fifo_async16_sr.vhd:103:49  */
  assign n958_o = n_add_wr[2];
  /* uart/gh_fifo_async16_sr.vhd:103:65  */
  assign n959_o = n_add_wr[3];
  /* uart/gh_fifo_async16_sr.vhd:103:53  */
  assign n960_o = n958_o ^ n959_o;
  /* uart/gh_fifo_async16_sr.vhd:104:49  */
  assign n961_o = n_add_wr[3];
  /* uart/gh_fifo_async16_sr.vhd:104:65  */
  assign n962_o = n_add_wr[4];
  /* uart/gh_fifo_async16_sr.vhd:104:53  */
  assign n963_o = n961_o ^ n962_o;
  /* uart/gh_fifo_async16_sr.vhd:105:49  */
  assign n964_o = n_add_wr[4];
  /* uart/gh_fifo_async16_sr.vhd:99:17  */
  assign n965_o = add_wr_ce ? n_add_wr : add_wr;
  /* uart/gh_uart_16550.vhd:402:1  */
  assign n966_o = {n964_o, n963_o, n960_o, n957_o, n954_o};
  /* uart/gh_fifo_async16_sr.vhd:99:17  */
  assign n967_o = add_wr_ce ? n966_o : add_wr_gc;
  /* uart/gh_fifo_async16_sr.vhd:96:17  */
  assign n969_o = srst_w ? 5'b00000 : n965_o;
  /* uart/gh_fifo_async16_sr.vhd:96:17  */
  assign n971_o = srst_w ? 5'b00000 : n967_o;
  /* uart/gh_fifo_async16_sr.vhd:115:22  */
  assign n983_o = iempty ? 1'b0 : n986_o;
  /* uart/gh_fifo_async16_sr.vhd:116:38  */
  assign n985_o = add_rd_ws != add_wr_gc;
  /* uart/gh_fifo_async16_sr.vhd:115:42  */
  assign n986_o = n985_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_sr.vhd:124:26  */
  assign n989_o = iempty ? 1'b0 : n992_o;
  /* uart/gh_fifo_async16_sr.vhd:125:35  */
  assign n991_o = ~rd;
  /* uart/gh_fifo_async16_sr.vhd:124:46  */
  assign n992_o = n991_o ? 1'b0 : 1'b1;
  /* uart/gh_fifo_async16_sr.vhd:128:55  */
  assign n995_o = add_rd + 5'b00001;
  /* uart/gh_fifo_async16_sr.vhd:145:49  */
  assign n999_o = n_add_rd[0];
  /* uart/gh_fifo_async16_sr.vhd:145:65  */
  assign n1000_o = n_add_rd[1];
  /* uart/gh_fifo_async16_sr.vhd:145:53  */
  assign n1001_o = n999_o ^ n1000_o;
  /* uart/gh_fifo_async16_sr.vhd:146:49  */
  assign n1002_o = n_add_rd[1];
  /* uart/gh_fifo_async16_sr.vhd:146:65  */
  assign n1003_o = n_add_rd[2];
  /* uart/gh_fifo_async16_sr.vhd:146:53  */
  assign n1004_o = n1002_o ^ n1003_o;
  /* uart/gh_fifo_async16_sr.vhd:147:49  */
  assign n1005_o = n_add_rd[2];
  /* uart/gh_fifo_async16_sr.vhd:147:65  */
  assign n1006_o = n_add_rd[3];
  /* uart/gh_fifo_async16_sr.vhd:147:53  */
  assign n1007_o = n1005_o ^ n1006_o;
  /* uart/gh_fifo_async16_sr.vhd:148:49  */
  assign n1008_o = n_add_rd[3];
  /* uart/gh_fifo_async16_sr.vhd:148:65  */
  assign n1009_o = n_add_rd[4];
  /* uart/gh_fifo_async16_sr.vhd:148:53  */
  assign n1010_o = n1008_o ^ n1009_o;
  /* uart/gh_fifo_async16_sr.vhd:149:49  */
  assign n1011_o = n_add_rd[4];
  /* uart/gh_fifo_async16_sr.vhd:150:51  */
  assign n1012_o = n_add_rd[0];
  /* uart/gh_fifo_async16_sr.vhd:150:67  */
  assign n1013_o = n_add_rd[1];
  /* uart/gh_fifo_async16_sr.vhd:150:55  */
  assign n1014_o = n1012_o ^ n1013_o;
  /* uart/gh_fifo_async16_sr.vhd:151:51  */
  assign n1015_o = n_add_rd[1];
  /* uart/gh_fifo_async16_sr.vhd:151:67  */
  assign n1016_o = n_add_rd[2];
  /* uart/gh_fifo_async16_sr.vhd:151:55  */
  assign n1017_o = n1015_o ^ n1016_o;
  /* uart/gh_fifo_async16_sr.vhd:152:51  */
  assign n1018_o = n_add_rd[2];
  /* uart/gh_fifo_async16_sr.vhd:152:67  */
  assign n1019_o = n_add_rd[3];
  /* uart/gh_fifo_async16_sr.vhd:152:55  */
  assign n1020_o = n1018_o ^ n1019_o;
  /* uart/gh_fifo_async16_sr.vhd:153:51  */
  assign n1021_o = n_add_rd[3];
  /* uart/gh_fifo_async16_sr.vhd:153:72  */
  assign n1022_o = n_add_rd[4];
  /* uart/gh_fifo_async16_sr.vhd:153:60  */
  assign n1023_o = ~n1022_o;
  /* uart/gh_fifo_async16_sr.vhd:153:55  */
  assign n1024_o = n1021_o ^ n1023_o;
  /* uart/gh_fifo_async16_sr.vhd:154:56  */
  assign n1025_o = n_add_rd[4];
  /* uart/gh_fifo_async16_sr.vhd:154:44  */
  assign n1026_o = ~n1025_o;
  /* uart/gh_fifo_async16_sr.vhd:143:17  */
  assign n1027_o = add_rd_ce ? n_add_rd : add_rd;
  assign n1028_o = {n1011_o, n1010_o, n1007_o, n1004_o, n1001_o};
  /* uart/gh_fifo_async16_sr.vhd:143:17  */
  assign n1029_o = add_rd_ce ? n1028_o : add_rd_gc;
  assign n1030_o = {n1026_o, n1024_o, n1020_o, n1017_o, n1014_o};
  /* uart/gh_fifo_async16_sr.vhd:143:17  */
  assign n1031_o = add_rd_ce ? n1030_o : add_rd_gcwc;
  /* uart/gh_fifo_async16_sr.vhd:139:17  */
  assign n1033_o = srst_r ? 5'b00000 : n1027_o;
  /* uart/gh_fifo_async16_sr.vhd:139:17  */
  assign n1035_o = srst_r ? 5'b00000 : n1029_o;
  /* uart/gh_fifo_async16_sr.vhd:139:17  */
  assign n1037_o = srst_r ? 5'b11000 : n1031_o;
  /* uart/gh_fifo_async16_sr.vhd:165:39  */
  assign n1052_o = add_wr_rs == add_rd_gc;
  /* uart/gh_fifo_async16_sr.vhd:165:23  */
  assign n1053_o = n1052_o ? 1'b1 : 1'b0;
  /* uart/gh_fifo_async16_sr.vhd:183:17  */
  assign n1059_o = isrst_r ? 1'b0 : srst_w;
  /* uart/gh_fifo_async16_sr.vhd:181:17  */
  assign n1061_o = srst ? 1'b1 : n1059_o;
  /* uart/gh_fifo_async16_sr.vhd:196:17  */
  assign n1074_o = isrst_w ? 1'b1 : 1'b0;
  /* uart/gh_fifo_async16_sr.vhd:94:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1084_q <= 5'b00000;
    else
      n1084_q <= n969_o;
  /* uart/gh_fifo_async16_sr.vhd:94:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1085_q <= 5'b00000;
    else
      n1085_q <= n971_o;
  /* uart/gh_fifo_async16_sr.vhd:137:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1086_q <= 5'b00000;
    else
      n1086_q <= add_wr_gc;
  /* uart/gh_fifo_async16_sr.vhd:137:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1087_q <= 5'b00000;
    else
      n1087_q <= n1033_o;
  /* uart/gh_fifo_async16_sr.vhd:137:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1088_q <= 5'b00000;
    else
      n1088_q <= n1035_o;
  /* uart/gh_fifo_async16_sr.vhd:137:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1089_q <= 5'b11000;
    else
      n1089_q <= n1037_o;
  /* uart/gh_fifo_async16_sr.vhd:94:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1090_q <= 5'b11000;
    else
      n1090_q <= add_rd_gcwc;
  /* uart/gh_fifo_async16_sr.vhd:179:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1091_q <= 1'b0;
    else
      n1091_q <= n1061_o;
  /* uart/gh_fifo_async16_sr.vhd:194:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1092_q <= 1'b0;
    else
      n1092_q <= srst_w;
  /* uart/gh_fifo_async16_sr.vhd:194:9  */
  always @(posedge clk_rd or posedge rst)
    if (rst)
      n1093_q <= 1'b0;
    else
      n1093_q <= n1074_o;
  /* uart/gh_fifo_async16_sr.vhd:179:9  */
  always @(posedge clk_wr or posedge rst)
    if (rst)
      n1094_q <= 1'b0;
    else
      n1094_q <= srst_r;
  /* uart/gh_fifo_async16_sr.vhd:35:17  */
  reg [7:0] ram_mem[15:0] ; // memory
  assign n1095_data = ram_mem[n937_o];
  always @(posedge clk_wr)
    if (n929_o)
      ram_mem[n930_o] <= d;
  /* uart/gh_fifo_async16_sr.vhd:76:22  */
  /* uart/gh_fifo_async16_sr.vhd:71:33  */
endmodule

module gh_baud_rate_gen
  (input  clk,
   input  br_clk,
   input  rst,
   input  wr,
   input  [1:0] be,
   input  [15:0] d,
   output [15:0] rd,
   output rce,
   output rclk);
  wire ub_ld;
  wire lb_ld;
  wire [15:0] rate;
  wire c_ld;
  wire c_ce;
  wire irld;
  wire rld;
  wire [15:0] count;
  wire n847_o;
  wire n848_o;
  wire [14:0] n853_o;
  wire [15:0] n855_o;
  wire n856_o;
  wire n859_o;
  wire n868_o;
  wire n869_o;
  wire n871_o;
  wire n872_o;
  wire n873_o;
  wire [7:0] n875_o;
  wire [7:0] u1_n876;
  wire [7:0] u1_q;
  wire n880_o;
  wire n881_o;
  wire n883_o;
  wire n884_o;
  wire n885_o;
  wire [7:0] n887_o;
  wire [7:0] u2_n888;
  wire [7:0] u2_q;
  wire n894_o;
  wire n896_o;
  wire n898_o;
  wire n905_o;
  wire n906_o;
  wire n908_o;
  wire n912_o;
  wire n913_o;
  wire [15:0] u3_n915;
  wire [15:0] u3_q;
  wire [15:0] n918_o;
  reg n919_q;
  reg n920_q;
  reg n921_q;
  assign rd = rate;
  assign rce = n848_o;
  assign rclk = n921_q;
  /* library/gh_baud_rate_gen.vhd:62:16  */
  assign ub_ld = n869_o; // (signal)
  /* library/gh_baud_rate_gen.vhd:63:16  */
  assign lb_ld = n881_o; // (signal)
  /* library/gh_baud_rate_gen.vhd:64:16  */
  assign rate = n918_o; // (signal)
  /* library/gh_baud_rate_gen.vhd:65:16  */
  assign c_ld = n906_o; // (signal)
  /* library/gh_baud_rate_gen.vhd:66:16  */
  assign c_ce = n913_o; // (signal)
  /* library/gh_baud_rate_gen.vhd:67:16  */
  assign irld = n919_q; // (signal)
  /* library/gh_baud_rate_gen.vhd:68:16  */
  assign rld = n920_q; // (signal)
  /* library/gh_baud_rate_gen.vhd:69:16  */
  assign count = u3_n915; // (signal)
  /* library/gh_baud_rate_gen.vhd:73:42  */
  assign n847_o = count == 16'b0000000000000001;
  /* library/gh_baud_rate_gen.vhd:73:20  */
  assign n848_o = n847_o ? 1'b1 : 1'b0;
  /* library/gh_baud_rate_gen.vhd:83:59  */
  assign n853_o = rate[15:1];
  /* library/gh_baud_rate_gen.vhd:83:52  */
  assign n855_o = {1'b0, n853_o};
  /* library/gh_baud_rate_gen.vhd:83:37  */
  assign n856_o = $unsigned(count) > $unsigned(n855_o);
  /* library/gh_baud_rate_gen.vhd:83:17  */
  assign n859_o = n856_o ? 1'b1 : 1'b0;
  /* library/gh_baud_rate_gen.vhd:96:31  */
  assign n868_o = ~wr;
  /* library/gh_baud_rate_gen.vhd:96:22  */
  assign n869_o = n868_o ? 1'b0 : n873_o;
  /* library/gh_baud_rate_gen.vhd:97:30  */
  assign n871_o = be[1];
  /* library/gh_baud_rate_gen.vhd:97:34  */
  assign n872_o = ~n871_o;
  /* library/gh_baud_rate_gen.vhd:96:38  */
  assign n873_o = n872_o ? 1'b0 : 1'b1;
  /* library/gh_baud_rate_gen.vhd:106:23  */
  assign n875_o = d[15:8];
  /* library/gh_baud_rate_gen.vhd:107:22  */
  assign u1_n876 = u1_q; // (signal)
  /* library/gh_baud_rate_gen.vhd:100:1  */
  gh_register_ce_8 u1 (
    .clk(clk),
    .rst(rst),
    .ce(ub_ld),
    .d(n875_o),
    .q(u1_q));
  /* library/gh_baud_rate_gen.vhd:110:31  */
  assign n880_o = ~wr;
  /* library/gh_baud_rate_gen.vhd:110:22  */
  assign n881_o = n880_o ? 1'b0 : n885_o;
  /* library/gh_baud_rate_gen.vhd:111:30  */
  assign n883_o = be[0];
  /* library/gh_baud_rate_gen.vhd:111:34  */
  assign n884_o = ~n883_o;
  /* library/gh_baud_rate_gen.vhd:110:38  */
  assign n885_o = n884_o ? 1'b0 : 1'b1;
  /* library/gh_baud_rate_gen.vhd:120:23  */
  assign n887_o = d[7:0];
  /* library/gh_baud_rate_gen.vhd:121:22  */
  assign u2_n888 = u2_q; // (signal)
  /* library/gh_baud_rate_gen.vhd:114:1  */
  gh_register_ce_8 u2 (
    .clk(clk),
    .rst(rst),
    .ce(lb_ld),
    .d(n887_o),
    .q(u2_q));
  /* library/gh_baud_rate_gen.vhd:133:28  */
  assign n894_o = ub_ld | lb_ld;
  /* library/gh_baud_rate_gen.vhd:135:17  */
  assign n896_o = rld ? 1'b0 : irld;
  /* library/gh_baud_rate_gen.vhd:133:17  */
  assign n898_o = n894_o ? 1'b1 : n896_o;
  /* library/gh_baud_rate_gen.vhd:141:43  */
  assign n905_o = count == 16'b0000000000000001;
  /* library/gh_baud_rate_gen.vhd:141:21  */
  assign n906_o = n905_o ? 1'b1 : n908_o;
  /* library/gh_baud_rate_gen.vhd:141:48  */
  assign n908_o = rld ? 1'b1 : 1'b0;
  /* library/gh_baud_rate_gen.vhd:145:42  */
  assign n912_o = $unsigned(rate) > $unsigned(16'b0000000000000001);
  /* library/gh_baud_rate_gen.vhd:145:21  */
  assign n913_o = n912_o ? 1'b1 : 1'b0;
  /* library/gh_baud_rate_gen.vhd:156:22  */
  assign u3_n915 = u3_q; // (signal)
  /* library/gh_baud_rate_gen.vhd:148:1  */
  gh_counter_down_ce_ld_16 u3 (
    .clk(br_clk),
    .rst(rst),
    .load(c_ld),
    .ce(c_ce),
    .d(rate),
    .q(u3_q));
  /* uart/gh_uart_16550.vhd:791:1  */
  assign n918_o = {u1_n876, u2_n888};
  /* library/gh_baud_rate_gen.vhd:132:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n919_q <= 1'b0;
    else
      n919_q <= n898_o;
  /* library/gh_baud_rate_gen.vhd:81:9  */
  always @(posedge br_clk or posedge rst)
    if (rst)
      n920_q <= 1'b0;
    else
      n920_q <= irld;
  /* library/gh_baud_rate_gen.vhd:81:9  */
  always @(posedge br_clk or posedge rst)
    if (rst)
      n921_q <= 1'b0;
    else
      n921_q <= n859_o;
endmodule

module gh_register_ce_5
  (input  clk,
   input  rst,
   input  ce,
   input  [4:0] d,
   output [4:0] q);
  wire [4:0] n840_o;
  reg [4:0] n841_q;
  assign q = n841_q;
  /* library/gh_register_ce.vhd:42:9  */
  assign n840_o = ce ? d : n841_q;
  /* library/gh_register_ce.vhd:42:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n841_q <= 5'b00000;
    else
      n841_q <= n840_o;
endmodule

module gh_decode_3to8
  (input  [2:0] a,
   input  g1,
   input  g2n,
   input  g3n,
   output [7:0] y);
  wire [7:0] n796_o;
  wire [7:0] n798_o;
  wire n800_o;
  wire [7:0] n801_o;
  wire n804_o;
  wire [7:0] n805_o;
  wire n808_o;
  wire [7:0] n809_o;
  wire n812_o;
  wire [7:0] n813_o;
  wire n816_o;
  wire [7:0] n817_o;
  wire n820_o;
  wire [7:0] n821_o;
  wire n824_o;
  wire [7:0] n825_o;
  wire n828_o;
  wire [7:0] n829_o;
  assign y = n796_o;
  /* library/gh_DECODE_3to8.vhd:36:20  */
  assign n796_o = g3n ? 8'b00000000 : n798_o;
  /* library/gh_DECODE_3to8.vhd:36:37  */
  assign n798_o = g2n ? 8'b00000000 : n801_o;
  /* library/gh_DECODE_3to8.vhd:38:29  */
  assign n800_o = ~g1;
  /* library/gh_DECODE_3to8.vhd:37:37  */
  assign n801_o = n800_o ? 8'b00000000 : n805_o;
  /* library/gh_DECODE_3to8.vhd:39:27  */
  assign n804_o = a == 3'b111;
  /* library/gh_DECODE_3to8.vhd:38:36  */
  assign n805_o = n804_o ? 8'b10000000 : n809_o;
  /* library/gh_DECODE_3to8.vhd:40:27  */
  assign n808_o = a == 3'b110;
  /* library/gh_DECODE_3to8.vhd:39:35  */
  assign n809_o = n808_o ? 8'b01000000 : n813_o;
  /* library/gh_DECODE_3to8.vhd:41:27  */
  assign n812_o = a == 3'b101;
  /* library/gh_DECODE_3to8.vhd:40:35  */
  assign n813_o = n812_o ? 8'b00100000 : n817_o;
  /* library/gh_DECODE_3to8.vhd:42:27  */
  assign n816_o = a == 3'b100;
  /* library/gh_DECODE_3to8.vhd:41:35  */
  assign n817_o = n816_o ? 8'b00010000 : n821_o;
  /* library/gh_DECODE_3to8.vhd:43:27  */
  assign n820_o = a == 3'b011;
  /* library/gh_DECODE_3to8.vhd:42:35  */
  assign n821_o = n820_o ? 8'b00001000 : n825_o;
  /* library/gh_DECODE_3to8.vhd:44:27  */
  assign n824_o = a == 3'b010;
  /* library/gh_DECODE_3to8.vhd:43:35  */
  assign n825_o = n824_o ? 8'b00000100 : n829_o;
  /* library/gh_DECODE_3to8.vhd:45:27  */
  assign n828_o = a == 3'b001;
  /* library/gh_DECODE_3to8.vhd:44:35  */
  assign n829_o = n828_o ? 8'b00000010 : 8'b00000001;
endmodule

module gh_register_ce_4
  (input  clk,
   input  rst,
   input  ce,
   input  [3:0] d,
   output [3:0] q);
  wire [3:0] n792_o;
  reg [3:0] n793_q;
  assign q = n793_q;
  /* library/gh_register_ce.vhd:42:9  */
  assign n792_o = ce ? d : n793_q;
  /* library/gh_register_ce.vhd:42:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n793_q <= 4'b0000;
    else
      n793_q <= n792_o;
endmodule

module gh_jkff
  (input  clk,
   input  rst,
   input  j,
   input  k,
   output q);
  wire iq;
  wire n771_o;
  wire n772_o;
  wire n774_o;
  wire n776_o;
  wire n777_o;
  reg n782_q;
  assign q = iq;
  /* library/gh_jkff.vhd:35:16  */
  assign iq = n782_q; // (signal)
  /* library/gh_jkff.vhd:46:31  */
  assign n771_o = j & k;
  /* library/gh_jkff.vhd:47:31  */
  assign n772_o = ~iq;
  /* library/gh_jkff.vhd:50:17  */
  assign n774_o = k ? 1'b0 : iq;
  /* library/gh_jkff.vhd:48:17  */
  assign n776_o = j ? 1'b1 : n774_o;
  /* library/gh_jkff.vhd:46:17  */
  assign n777_o = n771_o ? n772_o : n776_o;
  /* library/gh_jkff.vhd:45:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n782_q <= 1'b0;
    else
      n782_q <= n777_o;
endmodule

module gh_edge_det
  (input  clk,
   input  rst,
   input  d,
   output re,
   output fe,
   output sre,
   output sfe);
  wire q0;
  wire q1;
  wire n747_o;
  wire n748_o;
  wire n749_o;
  wire n750_o;
  wire n751_o;
  wire n752_o;
  wire n753_o;
  wire n754_o;
  reg n765_q;
  reg n766_q;
  assign re = n748_o;
  assign fe = n750_o;
  assign sre = n752_o;
  assign sfe = n754_o;
  /* library/gh_edge_det.vhd:39:16  */
  assign q0 = n765_q; // (signal)
  /* library/gh_edge_det.vhd:39:20  */
  assign q1 = n766_q; // (signal)
  /* library/gh_edge_det.vhd:43:22  */
  assign n747_o = ~q0;
  /* library/gh_edge_det.vhd:43:17  */
  assign n748_o = d & n747_o;
  /* library/gh_edge_det.vhd:44:16  */
  assign n749_o = ~d;
  /* library/gh_edge_det.vhd:44:23  */
  assign n750_o = n749_o & q0;
  /* library/gh_edge_det.vhd:45:24  */
  assign n751_o = ~q1;
  /* library/gh_edge_det.vhd:45:19  */
  assign n752_o = q0 & n751_o;
  /* library/gh_edge_det.vhd:46:17  */
  assign n753_o = ~q0;
  /* library/gh_edge_det.vhd:46:25  */
  assign n754_o = n753_o & q1;
  /* library/gh_edge_det.vhd:53:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n765_q <= 1'b0;
    else
      n765_q <= d;
  /* library/gh_edge_det.vhd:53:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n766_q <= 1'b0;
    else
      n766_q <= q0;
endmodule

module gh_register_ce_8
  (input  clk,
   input  rst,
   input  ce,
   input  [7:0] d,
   output [7:0] q);
  wire [7:0] n741_o;
  reg [7:0] n742_q;
  assign q = n742_q;
  /* library/gh_register_ce.vhd:42:9  */
  assign n741_o = ce ? d : n742_q;
  /* library/gh_register_ce.vhd:42:9  */
  always @(posedge clk or posedge rst)
    if (rst)
      n742_q <= 8'b00000000;
    else
      n742_q <= n741_o;
endmodule

module gh_uart_16550
  (input  clk,
   input  br_clk,
   input  rst,
   input  cs,
   input  wr,
   input  [2:0] add,
   input  [7:0] d,
   input  srx,
   input  ctsn,
   input  dsrn,
   input  rin,
   input  dcdn,
   output stx,
   output dtrn,
   output rtsn,
   output out1n,
   output out2n,
   output txrdyn,
   output rxrdyn,
   output irq,
   output b_clk,
   output [7:0] rd);
  wire [3:0] ier;
  wire [7:0] iir;
  wire [3:0] iiir;
  wire [7:0] fcr;
  wire [7:0] lcr;
  wire [4:0] mcr;
  wire [7:0] lsr;
  wire [7:0] msr;
  wire [7:0] scr;
  wire [15:0] rdd;
  wire [3:0] imsr;
  wire rd_iir;
  wire csn;
  wire [7:0] wr_b;
  wire wr_f;
  wire wr_ier;
  wire wr_d;
  wire [1:0] wr_dml;
  wire [15:0] d16;
  wire brc16x;
  wire itr0;
  wire isitr1;
  wire sitr1;
  wire citr1;
  wire citr1a;
  wire itr1;
  wire itr2;
  wire itr3;
  wire dcts;
  wire ctsn_re;
  wire ctsn_fe;
  wire idcts;
  wire iloop;
  wire ddsr;
  wire dsrn_re;
  wire dsrn_fe;
  wire iddsr;
  wire teri;
  wire rin_re;
  wire ddcd;
  wire dcdn_re;
  wire dcdn_fe;
  wire iddcd;
  wire rd_msr;
  wire msr_clr;
  wire rd_lsr;
  wire lsr_clr;
  reg [31:0] num_bits;
  wire stopb;
  wire parity_en;
  wire parity_ev;
  wire break_cb;
  wire tf_rd;
  wire tf_clr;
  wire tf_clrs;
  wire [7:0] tf_do;
  wire tf_empty;
  wire tf_full;
  wire rf_wr;
  wire rf_rd;
  wire rf_rd_brs;
  wire rf_clr;
  wire rf_clrs;
  wire [10:0] rf_di;
  wire [10:0] rf_do;
  wire rf_empty;
  wire rf_full;
  wire rd_rdy;
  wire iparity_er;
  wire iframe_er;
  wire ibreak_itr;
  wire parity_er;
  wire frame_er;
  wire break_itr;
  wire tsr_empty;
  wire ovr_er;
  wire istx;
  wire isrx;
  wire q_full;
  wire h_full;
  wire a_full;
  wire rf_er;
  wire tx_rdy;
  wire tx_rdys;
  wire tx_rdyc;
  wire rx_rdy;
  wire rx_rdys;
  wire rx_rdyc;
  wire toi;
  wire toi_enc;
  wire itoi_enc;
  wire toi_set;
  wire itoi_set;
  wire toi_clr;
  wire toi_c_ld;
  wire [11:0] toi_c_d;
  wire [7:0] n69_o;
  wire n71_o;
  wire n72_o;
  wire n73_o;
  wire n74_o;
  wire [7:0] n75_o;
  wire [7:0] n77_o;
  wire n79_o;
  wire n80_o;
  wire n81_o;
  wire n82_o;
  wire [7:0] n83_o;
  wire n85_o;
  wire [7:0] n86_o;
  wire n88_o;
  wire [7:0] n89_o;
  wire [7:0] n91_o;
  wire n93_o;
  wire [7:0] n94_o;
  wire n96_o;
  wire [7:0] n97_o;
  wire n99_o;
  wire [7:0] n100_o;
  wire n102_o;
  wire [7:0] n103_o;
  wire [7:0] n104_o;
  wire n106_o;
  wire [7:0] n107_o;
  wire [7:0] n108_o;
  wire u1_n109;
  wire u1_q;
  wire n112_o;
  wire n114_o;
  wire n115_o;
  wire n116_o;
  wire n117_o;
  wire n118_o;
  wire n120_o;
  wire n121_o;
  wire n122_o;
  wire n125_o;
  wire n126_o;
  wire n127_o;
  wire n128_o;
  wire n129_o;
  wire n131_o;
  wire n132_o;
  wire n133_o;
  wire u2_n135;
  wire u2_q;
  wire n138_o;
  wire n140_o;
  wire n141_o;
  wire n142_o;
  wire n143_o;
  wire n144_o;
  wire n146_o;
  wire [1:0] n147_o;
  wire n149_o;
  wire n150_o;
  wire n151_o;
  wire n152_o;
  wire n154_o;
  wire [1:0] n155_o;
  wire n157_o;
  wire n158_o;
  wire n159_o;
  wire n160_o;
  wire n162_o;
  wire [1:0] n163_o;
  wire n165_o;
  wire n166_o;
  wire n167_o;
  wire n168_o;
  wire n170_o;
  wire [1:0] n171_o;
  wire n173_o;
  wire n174_o;
  wire n175_o;
  wire n176_o;
  wire n177_o;
  wire n180_o;
  wire u3_n184;
  wire u3_n185;
  wire u3_re;
  wire u3_fe;
  wire u3_sre;
  wire u3_sfe;
  wire n192_o;
  wire u4_n193;
  wire u4_q;
  wire u5_n198;
  wire u5_n199;
  wire u5_re;
  wire u5_fe;
  wire u5_sre;
  wire u5_sfe;
  wire n206_o;
  wire u6_n207;
  wire u6_q;
  wire u7_n212;
  wire u7_re;
  wire u7_fe;
  wire u7_sre;
  wire u7_sfe;
  wire u8_n219;
  wire u8_q;
  wire u9_n224;
  wire u9_n225;
  wire u9_re;
  wire u9_fe;
  wire u9_sre;
  wire u9_sfe;
  wire n232_o;
  wire u10_n233;
  wire u10_q;
  wire n236_o;
  wire n237_o;
  wire n238_o;
  wire n239_o;
  wire n240_o;
  wire n241_o;
  wire n242_o;
  wire n243_o;
  wire n244_o;
  wire n245_o;
  wire n246_o;
  wire n247_o;
  wire n248_o;
  wire n249_o;
  wire n250_o;
  wire n251_o;
  wire n253_o;
  wire n254_o;
  wire n255_o;
  wire n258_o;
  wire n259_o;
  wire n262_o;
  wire n263_o;
  wire n264_o;
  wire [3:0] n266_o;
  wire n268_o;
  wire n269_o;
  wire u11_n274;
  wire u11_re;
  wire u11_fe;
  wire u11_sre;
  wire u11_sfe;
  localparam n280_o = 1'b1;
  wire [3:0] u12_n281;
  wire [3:0] u12_q;
  wire n284_o;
  wire u13_n285;
  wire u13_q;
  wire n289_o;
  wire n290_o;
  wire u14_n292;
  wire u14_q;
  wire u15_n295;
  wire u15_q;
  wire u16_n298;
  wire u16_q;
  wire n301_o;
  wire u17_n302;
  wire u17_q;
  wire [2:0] n306_o;
  wire n308_o;
  wire n309_o;
  wire n312_o;
  wire n313_o;
  wire n314_o;
  wire n317_o;
  wire n318_o;
  wire u18_n323;
  wire u18_re;
  wire u18_fe;
  wire u18_sre;
  wire u18_sfe;
  wire n329_o;
  localparam n330_o = 1'b0;
  wire [7:0] u19_n331;
  wire [7:0] u19_y;
  wire n334_o;
  wire n335_o;
  wire n336_o;
  wire n337_o;
  wire n338_o;
  wire n339_o;
  wire n340_o;
  wire n341_o;
  wire n342_o;
  wire n343_o;
  wire n344_o;
  wire n345_o;
  wire n346_o;
  wire n347_o;
  wire n348_o;
  wire n349_o;
  wire n350_o;
  wire n351_o;
  wire n352_o;
  wire [1:0] n353_o;
  wire [3:0] n354_o;
  wire [3:0] u20_n355;
  wire [3:0] u20_q;
  wire n358_o;
  wire [7:0] u21_n359;
  wire [7:0] u21_q;
  wire u22_n362;
  wire u22_q;
  wire n365_o;
  wire n366_o;
  wire n367_o;
  wire u23_n368;
  wire u23_q;
  wire n371_o;
  wire n372_o;
  wire n373_o;
  wire n374_o;
  wire [7:0] u24_n375;
  wire [7:0] u24_q;
  wire n379_o;
  wire n380_o;
  wire n381_o;
  wire n382_o;
  wire n383_o;
  wire [31:0] n384_o;
  wire n386_o;
  wire n387_o;
  wire n388_o;
  wire n389_o;
  wire [31:0] n390_o;
  wire n392_o;
  wire n393_o;
  wire n394_o;
  wire n395_o;
  wire [31:0] n396_o;
  wire n398_o;
  wire n399_o;
  wire n407_o;
  wire n408_o;
  wire n409_o;
  wire n410_o;
  wire n411_o;
  wire n412_o;
  wire n413_o;
  wire n414_o;
  wire [4:0] n415_o;
  wire [4:0] u25_n416;
  wire [4:0] u25_q;
  wire n419_o;
  wire n420_o;
  wire n421_o;
  wire n422_o;
  wire n423_o;
  wire n424_o;
  wire n425_o;
  wire n426_o;
  wire n427_o;
  wire n428_o;
  wire n429_o;
  wire n430_o;
  wire n431_o;
  wire n432_o;
  wire [7:0] u26_n433;
  wire [7:0] u26_q;
  wire [15:0] n436_o;
  wire [15:0] u27_n437;
  wire u27_n438;
  wire u27_n439;
  wire [15:0] u27_rd;
  wire u27_rce;
  wire u27_rclk;
  wire [7:0] u28_n446;
  wire u28_n447;
  wire u28_n448;
  wire [7:0] u28_q;
  wire u28_empty;
  wire u28_full;
  wire u28a_n457;
  wire u28a_re;
  wire u28a_fe;
  wire u28a_sre;
  wire u28a_sfe;
  wire n464_o;
  wire n465_o;
  wire n468_o;
  wire n469_o;
  wire n471_o;
  wire n473_o;
  wire n474_o;
  wire [2:0] n476_o;
  wire n478_o;
  wire n479_o;
  wire u28b_n484;
  wire u28b_re;
  wire u28b_fe;
  wire u28b_sre;
  wire u28b_sfe;
  wire n490_o;
  wire n491_o;
  wire u28c_n492;
  wire u28c_q;
  wire u29_n495;
  wire u29_n496;
  wire u29_n497;
  wire u29_stx;
  wire u29_busyn;
  wire u29_read;
  wire u30_n504;
  wire u30_re;
  wire u30_fe;
  wire u30_sre;
  wire u30_sfe;
  wire n514_o;
  wire n515_o;
  wire n518_o;
  wire n519_o;
  wire n520_o;
  wire n521_o;
  wire n522_o;
  wire [10:0] u31_n524;
  wire u31_n525;
  wire u31_n526;
  wire u31_n527;
  wire u31_n528;
  wire u31_n529;
  wire [10:0] u31_q;
  wire u31_empty;
  wire u31_q_full;
  wire u31_h_full;
  wire u31_a_full;
  wire u31_full;
  wire n542_o;
  wire n543_o;
  wire n544_o;
  wire u32a_n547;
  wire u32a_re;
  wire u32a_fe;
  wire u32a_sre;
  wire u32a_sfe;
  wire n554_o;
  wire n555_o;
  wire n556_o;
  wire u32b_n559;
  wire u32b_re;
  wire u32b_fe;
  wire u32b_sre;
  wire u32b_sfe;
  wire n566_o;
  wire n567_o;
  wire n568_o;
  wire u32c_n571;
  wire u32c_re;
  wire u32c_fe;
  wire u32c_sre;
  wire u32c_sfe;
  wire n579_o;
  wire n580_o;
  wire n581_o;
  wire n583_o;
  wire n584_o;
  wire [2:0] n586_o;
  wire n588_o;
  wire n589_o;
  wire n591_o;
  wire n592_o;
  wire n594_o;
  wire n595_o;
  wire n596_o;
  wire [1:0] n598_o;
  wire n600_o;
  wire n601_o;
  wire n602_o;
  wire [1:0] n604_o;
  wire n606_o;
  wire n607_o;
  wire n608_o;
  wire [1:0] n610_o;
  wire n612_o;
  wire n613_o;
  wire n614_o;
  wire [1:0] n616_o;
  wire n618_o;
  wire n619_o;
  wire n620_o;
  wire n621_o;
  wire u33_n623;
  wire u33_n624;
  wire u33_n625;
  wire u33_n626;
  wire [7:0] u33_n627;
  wire u33_parity_er;
  wire u33_frame_er;
  wire u33_break_itr;
  wire u33_d_rdy;
  wire [7:0] u33_d;
  wire n638_o;
  wire n639_o;
  wire n640_o;
  wire n641_o;
  wire u34_n642;
  wire u34_q;
  wire n645_o;
  wire u35_n646;
  wire u35_q;
  wire u35a_n649;
  wire u35a_re;
  wire u35a_fe;
  wire n662_o;
  wire n663_o;
  wire n664_o;
  wire n666_o;
  wire n667_o;
  wire n669_o;
  wire n671_o;
  wire [9:0] n673_o;
  wire u36_n675;
  wire [9:0] u36_q;
  wire u36_tc;
  wire u36a_n679;
  wire u36a_re;
  wire u36a_fe;
  wire n686_o;
  wire [11:0] n687_o;
  wire n690_o;
  wire [11:0] n691_o;
  wire n694_o;
  wire [11:0] n695_o;
  wire n698_o;
  wire n699_o;
  wire n700_o;
  wire n701_o;
  wire n702_o;
  wire n705_o;
  wire n706_o;
  wire n707_o;
  wire n708_o;
  wire n709_o;
  wire [2:0] n712_o;
  wire [2:0] n714_o;
  wire [2:0] n716_o;
  wire [2:0] n718_o;
  wire [3:0] u37_n721;
  wire [3:0] u37_q;
  wire [7:0] n724_o;
  wire [3:0] n725_o;
  wire [7:0] n726_o;
  wire [7:0] n727_o;
  wire [3:0] n728_o;
  wire [10:0] n730_o;
  reg n731_q;
  assign stx = istx;
  assign dtrn = n421_o;
  assign rtsn = n424_o;
  assign out1n = n427_o;
  assign out2n = n430_o;
  assign txrdyn = n112_o;
  assign rxrdyn = n138_o;
  assign irq = n702_o;
  assign b_clk = u27_n439;
  assign rd = n75_o;
  /* uart/gh_uart_16550.vhd:224:16  */
  assign ier = u20_n355; // (signal)
  /* uart/gh_uart_16550.vhd:225:16  */
  assign iir = n724_o; // (signal)
  /* uart/gh_uart_16550.vhd:226:16  */
  assign iiir = n725_o; // (signal)
  /* uart/gh_uart_16550.vhd:227:16  */
  assign fcr = u21_n359; // (signal)
  /* uart/gh_uart_16550.vhd:228:16  */
  assign lcr = u24_n375; // (signal)
  /* uart/gh_uart_16550.vhd:229:16  */
  assign mcr = u25_n416; // (signal)
  /* uart/gh_uart_16550.vhd:230:16  */
  assign lsr = n726_o; // (signal)
  /* uart/gh_uart_16550.vhd:231:16  */
  assign msr = n727_o; // (signal)
  /* uart/gh_uart_16550.vhd:232:16  */
  assign scr = u26_n433; // (signal)
  /* uart/gh_uart_16550.vhd:233:16  */
  assign rdd = u27_n437; // (signal)
  /* uart/gh_uart_16550.vhd:234:16  */
  assign imsr = n728_o; // (signal)
  /* uart/gh_uart_16550.vhd:235:16  */
  assign rd_iir = n469_o; // (signal)
  /* uart/gh_uart_16550.vhd:238:16  */
  assign csn = n329_o; // (signal)
  /* uart/gh_uart_16550.vhd:239:16  */
  assign wr_b = u19_n331; // (signal)
  /* uart/gh_uart_16550.vhd:240:16  */
  assign wr_f = n337_o; // (signal)
  /* uart/gh_uart_16550.vhd:241:16  */
  assign wr_ier = n341_o; // (signal)
  /* uart/gh_uart_16550.vhd:242:16  */
  assign wr_d = n346_o; // (signal)
  /* uart/gh_uart_16550.vhd:243:16  */
  assign wr_dml = n353_o; // (signal)
  /* uart/gh_uart_16550.vhd:244:16  */
  assign d16 = n436_o; // (signal)
  /* uart/gh_uart_16550.vhd:245:16  */
  assign brc16x = u27_n438; // (signal)
  /* uart/gh_uart_16550.vhd:247:16  */
  assign itr0 = n264_o; // (signal)
  /* uart/gh_uart_16550.vhd:248:16  */
  assign isitr1 = n465_o; // (signal)
  /* uart/gh_uart_16550.vhd:249:16  */
  assign sitr1 = u28a_n457; // (signal)
  /* uart/gh_uart_16550.vhd:250:16  */
  assign citr1 = n491_o; // (signal)
  /* uart/gh_uart_16550.vhd:251:16  */
  assign citr1a = u28b_n484; // (signal)
  /* uart/gh_uart_16550.vhd:252:16  */
  assign itr1 = u28c_n492; // (signal)
  /* uart/gh_uart_16550.vhd:253:16  */
  assign itr2 = n596_o; // (signal)
  /* uart/gh_uart_16550.vhd:254:16  */
  assign itr3 = n581_o; // (signal)
  /* uart/gh_uart_16550.vhd:256:16  */
  assign dcts = u4_n193; // (signal)
  /* uart/gh_uart_16550.vhd:257:16  */
  assign ctsn_re = u3_n184; // (signal)
  /* uart/gh_uart_16550.vhd:258:16  */
  assign ctsn_fe = u3_n185; // (signal)
  /* uart/gh_uart_16550.vhd:259:16  */
  assign idcts = n192_o; // (signal)
  /* uart/gh_uart_16550.vhd:260:16  */
  assign iloop = n431_o; // (signal)
  /* uart/gh_uart_16550.vhd:262:16  */
  assign ddsr = u6_n207; // (signal)
  /* uart/gh_uart_16550.vhd:263:16  */
  assign dsrn_re = u5_n198; // (signal)
  /* uart/gh_uart_16550.vhd:264:16  */
  assign dsrn_fe = u5_n199; // (signal)
  /* uart/gh_uart_16550.vhd:265:16  */
  assign iddsr = n206_o; // (signal)
  /* uart/gh_uart_16550.vhd:267:16  */
  assign teri = u8_n219; // (signal)
  /* uart/gh_uart_16550.vhd:268:16  */
  assign rin_re = u7_n212; // (signal)
  /* uart/gh_uart_16550.vhd:270:16  */
  assign ddcd = u10_n233; // (signal)
  /* uart/gh_uart_16550.vhd:271:16  */
  assign dcdn_re = u9_n224; // (signal)
  /* uart/gh_uart_16550.vhd:272:16  */
  assign dcdn_fe = u9_n225; // (signal)
  /* uart/gh_uart_16550.vhd:273:16  */
  assign iddcd = n232_o; // (signal)
  /* uart/gh_uart_16550.vhd:275:16  */
  assign rd_msr = n255_o; // (signal)
  /* uart/gh_uart_16550.vhd:276:16  */
  assign msr_clr = u11_n274; // (signal)
  /* uart/gh_uart_16550.vhd:278:16  */
  assign rd_lsr = n314_o; // (signal)
  /* uart/gh_uart_16550.vhd:279:16  */
  assign lsr_clr = u18_n323; // (signal)
  /* uart/gh_uart_16550.vhd:281:16  */
  always @*
    num_bits = n384_o; // (isignal)
  initial
    num_bits = 32'b00000000000000000000000000000000;
  /* uart/gh_uart_16550.vhd:282:16  */
  assign stopb = n398_o; // (signal)
  /* uart/gh_uart_16550.vhd:283:16  */
  assign parity_en = n399_o; // (signal)
  /* uart/gh_uart_16550.vhd:285:16  */
  assign parity_ev = n412_o; // (signal)
  /* uart/gh_uart_16550.vhd:287:16  */
  assign break_cb = n413_o; // (signal)
  /* uart/gh_uart_16550.vhd:289:16  */
  assign tf_rd = u29_n497; // (signal)
  /* uart/gh_uart_16550.vhd:290:16  */
  assign tf_clr = u23_n368; // (signal)
  /* uart/gh_uart_16550.vhd:291:16  */
  assign tf_clrs = n373_o; // (signal)
  /* uart/gh_uart_16550.vhd:292:16  */
  assign tf_do = u28_n446; // (signal)
  /* uart/gh_uart_16550.vhd:293:16  */
  assign tf_empty = u28_n447; // (signal)
  /* uart/gh_uart_16550.vhd:294:16  */
  assign tf_full = u28_n448; // (signal)
  /* uart/gh_uart_16550.vhd:296:16  */
  assign rf_wr = u30_n504; // (signal)
  /* uart/gh_uart_16550.vhd:297:16  */
  assign rf_rd = n515_o; // (signal)
  /* uart/gh_uart_16550.vhd:298:16  */
  assign rf_rd_brs = u35a_n649; // (signal)
  /* uart/gh_uart_16550.vhd:299:16  */
  assign rf_clr = u22_n362; // (signal)
  /* uart/gh_uart_16550.vhd:300:16  */
  assign rf_clrs = n367_o; // (signal)
  /* uart/gh_uart_16550.vhd:301:16  */
  assign rf_di = n730_o; // (signal)
  /* uart/gh_uart_16550.vhd:302:16  */
  assign rf_do = u31_n524; // (signal)
  /* uart/gh_uart_16550.vhd:303:16  */
  assign rf_empty = u31_n525; // (signal)
  /* uart/gh_uart_16550.vhd:304:16  */
  assign rf_full = u31_n529; // (signal)
  /* uart/gh_uart_16550.vhd:305:16  */
  assign rd_rdy = u33_n626; // (signal)
  /* uart/gh_uart_16550.vhd:307:16  */
  assign iparity_er = n544_o; // (signal)
  /* uart/gh_uart_16550.vhd:308:16  */
  assign iframe_er = n556_o; // (signal)
  /* uart/gh_uart_16550.vhd:309:16  */
  assign ibreak_itr = n568_o; // (signal)
  /* uart/gh_uart_16550.vhd:310:16  */
  assign parity_er = u32a_n547; // (signal)
  /* uart/gh_uart_16550.vhd:311:16  */
  assign frame_er = u32b_n559; // (signal)
  /* uart/gh_uart_16550.vhd:312:16  */
  assign break_itr = u32c_n571; // (signal)
  /* uart/gh_uart_16550.vhd:313:16  */
  assign tsr_empty = u29_n496; // (signal)
  /* uart/gh_uart_16550.vhd:314:16  */
  assign ovr_er = n290_o; // (signal)
  /* uart/gh_uart_16550.vhd:315:16  */
  assign istx = u29_n495; // (signal)
  /* uart/gh_uart_16550.vhd:316:16  */
  assign isrx = n592_o; // (signal)
  /* uart/gh_uart_16550.vhd:318:16  */
  assign q_full = u31_n526; // (signal)
  /* uart/gh_uart_16550.vhd:319:16  */
  assign h_full = u31_n527; // (signal)
  /* uart/gh_uart_16550.vhd:320:16  */
  assign a_full = u31_n528; // (signal)
  /* uart/gh_uart_16550.vhd:322:16  */
  assign rf_er = n309_o; // (signal)
  /* uart/gh_uart_16550.vhd:323:16  */
  assign tx_rdy = u1_n109; // (signal)
  /* uart/gh_uart_16550.vhd:324:16  */
  assign tx_rdys = n118_o; // (signal)
  /* uart/gh_uart_16550.vhd:325:16  */
  assign tx_rdyc = n129_o; // (signal)
  /* uart/gh_uart_16550.vhd:326:16  */
  assign rx_rdy = u2_n135; // (signal)
  /* uart/gh_uart_16550.vhd:327:16  */
  assign rx_rdys = n144_o; // (signal)
  /* uart/gh_uart_16550.vhd:328:16  */
  assign rx_rdyc = n180_o; // (signal)
  /* uart/gh_uart_16550.vhd:330:16  */
  assign toi = u34_n642; // (signal)
  /* uart/gh_uart_16550.vhd:331:16  */
  assign toi_enc = n731_q; // (signal)
  /* uart/gh_uart_16550.vhd:332:16  */
  assign itoi_enc = u35_n646; // (signal)
  /* uart/gh_uart_16550.vhd:333:16  */
  assign toi_set = u36a_n679; // (signal)
  /* uart/gh_uart_16550.vhd:334:16  */
  assign itoi_set = u36_n675; // (signal)
  /* uart/gh_uart_16550.vhd:335:16  */
  assign toi_clr = n641_o; // (signal)
  /* uart/gh_uart_16550.vhd:336:16  */
  assign toi_c_ld = n664_o; // (signal)
  /* uart/gh_uart_16550.vhd:337:16  */
  assign toi_c_d = n687_o; // (signal)
  /* uart/gh_uart_16550.vhd:345:20  */
  assign n69_o = rf_do[7:0];
  /* uart/gh_uart_16550.vhd:345:44  */
  assign n71_o = add == 3'b000;
  /* uart/gh_uart_16550.vhd:345:60  */
  assign n72_o = lcr[7];
  /* uart/gh_uart_16550.vhd:345:64  */
  assign n73_o = ~n72_o;
  /* uart/gh_uart_16550.vhd:345:52  */
  assign n74_o = n71_o & n73_o;
  /* uart/gh_uart_16550.vhd:345:33  */
  assign n75_o = n74_o ? n69_o : n83_o;
  /* uart/gh_uart_16550.vhd:346:21  */
  assign n77_o = {4'b0000, ier};
  /* uart/gh_uart_16550.vhd:346:39  */
  assign n79_o = add == 3'b001;
  /* uart/gh_uart_16550.vhd:346:55  */
  assign n80_o = lcr[7];
  /* uart/gh_uart_16550.vhd:346:59  */
  assign n81_o = ~n80_o;
  /* uart/gh_uart_16550.vhd:346:47  */
  assign n82_o = n79_o & n81_o;
  /* uart/gh_uart_16550.vhd:345:72  */
  assign n83_o = n82_o ? n77_o : n86_o;
  /* uart/gh_uart_16550.vhd:347:29  */
  assign n85_o = add == 3'b010;
  /* uart/gh_uart_16550.vhd:346:67  */
  assign n86_o = n85_o ? iir : n89_o;
  /* uart/gh_uart_16550.vhd:348:29  */
  assign n88_o = add == 3'b011;
  /* uart/gh_uart_16550.vhd:347:37  */
  assign n89_o = n88_o ? lcr : n94_o;
  /* uart/gh_uart_16550.vhd:349:22  */
  assign n91_o = {3'b000, mcr};
  /* uart/gh_uart_16550.vhd:349:39  */
  assign n93_o = add == 3'b100;
  /* uart/gh_uart_16550.vhd:348:37  */
  assign n94_o = n93_o ? n91_o : n97_o;
  /* uart/gh_uart_16550.vhd:350:29  */
  assign n96_o = add == 3'b101;
  /* uart/gh_uart_16550.vhd:349:47  */
  assign n97_o = n96_o ? lsr : n100_o;
  /* uart/gh_uart_16550.vhd:351:29  */
  assign n99_o = add == 3'b110;
  /* uart/gh_uart_16550.vhd:350:37  */
  assign n100_o = n99_o ? msr : n103_o;
  /* uart/gh_uart_16550.vhd:352:29  */
  assign n102_o = add == 3'b111;
  /* uart/gh_uart_16550.vhd:351:37  */
  assign n103_o = n102_o ? scr : n107_o;
  /* uart/gh_uart_16550.vhd:353:18  */
  assign n104_o = rdd[7:0];
  /* uart/gh_uart_16550.vhd:353:41  */
  assign n106_o = add == 3'b000;
  /* uart/gh_uart_16550.vhd:352:37  */
  assign n107_o = n106_o ? n104_o : n108_o;
  /* uart/gh_uart_16550.vhd:354:18  */
  assign n108_o = rdd[15:8];
  /* uart/gh_uart_16550.vhd:364:22  */
  assign u1_n109 = u1_q; // (signal)
  /* uart/gh_uart_16550.vhd:358:1  */
  gh_jkff u1 (
    .clk(clk),
    .rst(rst),
    .j(tx_rdys),
    .k(tx_rdyc),
    .q(u1_q));
  /* uart/gh_uart_16550.vhd:366:20  */
  assign n112_o = ~tx_rdy;
  /* uart/gh_uart_16550.vhd:368:34  */
  assign n114_o = fcr[3];
  /* uart/gh_uart_16550.vhd:368:38  */
  assign n115_o = ~n114_o;
  /* uart/gh_uart_16550.vhd:368:45  */
  assign n116_o = n115_o & tf_empty;
  /* uart/gh_uart_16550.vhd:368:66  */
  assign n117_o = n116_o & tsr_empty;
  /* uart/gh_uart_16550.vhd:368:24  */
  assign n118_o = n117_o ? 1'b1 : n122_o;
  /* uart/gh_uart_16550.vhd:369:34  */
  assign n120_o = fcr[3];
  /* uart/gh_uart_16550.vhd:369:45  */
  assign n121_o = n120_o & tf_empty;
  /* uart/gh_uart_16550.vhd:368:89  */
  assign n122_o = n121_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:372:34  */
  assign n125_o = fcr[3];
  /* uart/gh_uart_16550.vhd:372:38  */
  assign n126_o = ~n125_o;
  /* uart/gh_uart_16550.vhd:372:59  */
  assign n127_o = ~tf_empty;
  /* uart/gh_uart_16550.vhd:372:45  */
  assign n128_o = n126_o & n127_o;
  /* uart/gh_uart_16550.vhd:372:24  */
  assign n129_o = n128_o ? 1'b1 : n133_o;
  /* uart/gh_uart_16550.vhd:373:34  */
  assign n131_o = fcr[3];
  /* uart/gh_uart_16550.vhd:373:45  */
  assign n132_o = n131_o & tf_full;
  /* uart/gh_uart_16550.vhd:372:67  */
  assign n133_o = n132_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:382:22  */
  assign u2_n135 = u2_q; // (signal)
  /* uart/gh_uart_16550.vhd:376:1  */
  gh_jkff u2 (
    .clk(clk),
    .rst(rst),
    .j(rx_rdys),
    .k(rx_rdyc),
    .q(u2_q));
  /* uart/gh_uart_16550.vhd:384:20  */
  assign n138_o = ~rx_rdy;
  /* uart/gh_uart_16550.vhd:386:34  */
  assign n140_o = fcr[3];
  /* uart/gh_uart_16550.vhd:386:38  */
  assign n141_o = ~n140_o;
  /* uart/gh_uart_16550.vhd:386:59  */
  assign n142_o = ~rf_empty;
  /* uart/gh_uart_16550.vhd:386:45  */
  assign n143_o = n141_o & n142_o;
  /* uart/gh_uart_16550.vhd:386:24  */
  assign n144_o = n143_o ? 1'b1 : n152_o;
  /* uart/gh_uart_16550.vhd:387:34  */
  assign n146_o = fcr[3];
  /* uart/gh_uart_16550.vhd:387:53  */
  assign n147_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:387:66  */
  assign n149_o = n147_o == 2'b11;
  /* uart/gh_uart_16550.vhd:387:45  */
  assign n150_o = n146_o & n149_o;
  /* uart/gh_uart_16550.vhd:387:74  */
  assign n151_o = n150_o & a_full;
  /* uart/gh_uart_16550.vhd:386:67  */
  assign n152_o = n151_o ? 1'b1 : n160_o;
  /* uart/gh_uart_16550.vhd:388:34  */
  assign n154_o = fcr[3];
  /* uart/gh_uart_16550.vhd:388:53  */
  assign n155_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:388:66  */
  assign n157_o = n155_o == 2'b10;
  /* uart/gh_uart_16550.vhd:388:45  */
  assign n158_o = n154_o & n157_o;
  /* uart/gh_uart_16550.vhd:388:74  */
  assign n159_o = n158_o & h_full;
  /* uart/gh_uart_16550.vhd:387:94  */
  assign n160_o = n159_o ? 1'b1 : n168_o;
  /* uart/gh_uart_16550.vhd:389:34  */
  assign n162_o = fcr[3];
  /* uart/gh_uart_16550.vhd:389:53  */
  assign n163_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:389:66  */
  assign n165_o = n163_o == 2'b01;
  /* uart/gh_uart_16550.vhd:389:45  */
  assign n166_o = n162_o & n165_o;
  /* uart/gh_uart_16550.vhd:389:74  */
  assign n167_o = n166_o & q_full;
  /* uart/gh_uart_16550.vhd:388:94  */
  assign n168_o = n167_o ? 1'b1 : n177_o;
  /* uart/gh_uart_16550.vhd:390:34  */
  assign n170_o = fcr[3];
  /* uart/gh_uart_16550.vhd:390:53  */
  assign n171_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:390:66  */
  assign n173_o = n171_o == 2'b00;
  /* uart/gh_uart_16550.vhd:390:45  */
  assign n174_o = n170_o & n173_o;
  /* uart/gh_uart_16550.vhd:390:88  */
  assign n175_o = ~rf_empty;
  /* uart/gh_uart_16550.vhd:390:74  */
  assign n176_o = n174_o & n175_o;
  /* uart/gh_uart_16550.vhd:389:94  */
  assign n177_o = n176_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:394:24  */
  assign n180_o = rf_empty ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:407:24  */
  assign u3_n184 = u3_sre; // (signal)
  /* uart/gh_uart_16550.vhd:408:24  */
  assign u3_n185 = u3_sfe; // (signal)
  /* uart/gh_uart_16550.vhd:402:1  */
  gh_edge_det u3 (
    .clk(clk),
    .rst(rst),
    .d(ctsn),
    .re(),
    .fe(),
    .sre(u3_sre),
    .sfe(u3_sfe));
  /* uart/gh_uart_16550.vhd:410:26  */
  assign n192_o = ctsn_re | ctsn_fe;
  /* uart/gh_uart_16550.vhd:418:22  */
  assign u4_n193 = u4_q; // (signal)
  /* uart/gh_uart_16550.vhd:412:1  */
  gh_jkff u4 (
    .clk(clk),
    .rst(rst),
    .j(idcts),
    .k(msr_clr),
    .q(u4_q));
  /* uart/gh_uart_16550.vhd:427:24  */
  assign u5_n198 = u5_sre; // (signal)
  /* uart/gh_uart_16550.vhd:428:24  */
  assign u5_n199 = u5_sfe; // (signal)
  /* uart/gh_uart_16550.vhd:422:1  */
  gh_edge_det u5 (
    .clk(clk),
    .rst(rst),
    .d(dsrn),
    .re(),
    .fe(),
    .sre(u5_sre),
    .sfe(u5_sfe));
  /* uart/gh_uart_16550.vhd:430:26  */
  assign n206_o = dsrn_re | dsrn_fe;
  /* uart/gh_uart_16550.vhd:438:22  */
  assign u6_n207 = u6_q; // (signal)
  /* uart/gh_uart_16550.vhd:432:1  */
  gh_jkff u6 (
    .clk(clk),
    .rst(rst),
    .j(iddsr),
    .k(msr_clr),
    .q(u6_q));
  /* uart/gh_uart_16550.vhd:447:24  */
  assign u7_n212 = u7_sre; // (signal)
  /* uart/gh_uart_16550.vhd:442:1  */
  gh_edge_det u7 (
    .clk(clk),
    .rst(rst),
    .d(rin),
    .re(),
    .fe(),
    .sre(u7_sre),
    .sfe());
  /* uart/gh_uart_16550.vhd:455:22  */
  assign u8_n219 = u8_q; // (signal)
  /* uart/gh_uart_16550.vhd:449:1  */
  gh_jkff u8 (
    .clk(clk),
    .rst(rst),
    .j(rin_re),
    .k(msr_clr),
    .q(u8_q));
  /* uart/gh_uart_16550.vhd:464:24  */
  assign u9_n224 = u9_sre; // (signal)
  /* uart/gh_uart_16550.vhd:465:24  */
  assign u9_n225 = u9_sfe; // (signal)
  /* uart/gh_uart_16550.vhd:459:1  */
  gh_edge_det u9 (
    .clk(clk),
    .rst(rst),
    .d(dcdn),
    .re(),
    .fe(),
    .sre(u9_sre),
    .sfe(u9_sfe));
  /* uart/gh_uart_16550.vhd:467:26  */
  assign n232_o = dcdn_re | dcdn_fe;
  /* uart/gh_uart_16550.vhd:475:22  */
  assign u10_n233 = u10_q; // (signal)
  /* uart/gh_uart_16550.vhd:469:1  */
  gh_jkff u10 (
    .clk(clk),
    .rst(rst),
    .j(iddcd),
    .k(msr_clr),
    .q(u10_q));
  /* uart/gh_uart_16550.vhd:479:21  */
  assign n236_o = ~ctsn;
  /* uart/gh_uart_16550.vhd:479:43  */
  assign n237_o = ~iloop;
  /* uart/gh_uart_16550.vhd:479:31  */
  assign n238_o = n237_o ? n236_o : n239_o;
  /* uart/gh_uart_16550.vhd:480:24  */
  assign n239_o = mcr[1];
  /* uart/gh_uart_16550.vhd:482:21  */
  assign n240_o = ~dsrn;
  /* uart/gh_uart_16550.vhd:482:43  */
  assign n241_o = ~iloop;
  /* uart/gh_uart_16550.vhd:482:31  */
  assign n242_o = n241_o ? n240_o : n243_o;
  /* uart/gh_uart_16550.vhd:483:24  */
  assign n243_o = mcr[0];
  /* uart/gh_uart_16550.vhd:485:21  */
  assign n244_o = ~rin;
  /* uart/gh_uart_16550.vhd:485:42  */
  assign n245_o = ~iloop;
  /* uart/gh_uart_16550.vhd:485:30  */
  assign n246_o = n245_o ? n244_o : n247_o;
  /* uart/gh_uart_16550.vhd:486:24  */
  assign n247_o = mcr[2];
  /* uart/gh_uart_16550.vhd:488:21  */
  assign n248_o = ~dcdn;
  /* uart/gh_uart_16550.vhd:488:43  */
  assign n249_o = ~iloop;
  /* uart/gh_uart_16550.vhd:488:31  */
  assign n250_o = n249_o ? n248_o : n251_o;
  /* uart/gh_uart_16550.vhd:489:24  */
  assign n251_o = mcr[3];
  /* uart/gh_uart_16550.vhd:491:33  */
  assign n253_o = ~cs;
  /* uart/gh_uart_16550.vhd:491:40  */
  assign n254_o = n253_o | wr;
  /* uart/gh_uart_16550.vhd:491:23  */
  assign n255_o = n254_o ? 1'b0 : n259_o;
  /* uart/gh_uart_16550.vhd:492:33  */
  assign n258_o = add != 3'b110;
  /* uart/gh_uart_16550.vhd:491:55  */
  assign n259_o = n258_o ? 1'b0 : 1'b1;
  /* uart/gh_uart_16550.vhd:496:30  */
  assign n262_o = ier[3];
  /* uart/gh_uart_16550.vhd:496:34  */
  assign n263_o = ~n262_o;
  /* uart/gh_uart_16550.vhd:496:21  */
  assign n264_o = n263_o ? 1'b0 : n269_o;
  /* uart/gh_uart_16550.vhd:497:39  */
  assign n266_o = msr[3:0];
  /* uart/gh_uart_16550.vhd:497:53  */
  assign n268_o = $unsigned(n266_o) > $unsigned(4'b0000);
  /* uart/gh_uart_16550.vhd:496:41  */
  assign n269_o = n268_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:505:24  */
  assign u11_n274 = u11_sfe; // (signal)
  /* uart/gh_uart_16550.vhd:500:1  */
  gh_edge_det u11 (
    .clk(clk),
    .rst(rst),
    .d(rd_msr),
    .re(),
    .fe(),
    .sre(),
    .sfe(u11_sfe));
  /* uart/gh_uart_16550.vhd:514:22  */
  assign u12_n281 = u12_q; // (signal)
  /* uart/gh_uart_16550.vhd:507:1  */
  gh_register_ce_4 u12 (
    .clk(clk),
    .rst(rst),
    .ce(n280_o),
    .d(imsr),
    .q(u12_q));
  /* uart/gh_uart_16550.vhd:521:20  */
  assign n284_o = ~rf_empty;
  /* uart/gh_uart_16550.vhd:529:22  */
  assign u13_n285 = u13_q; // (signal)
  /* uart/gh_uart_16550.vhd:523:1  */
  gh_jkff u13 (
    .clk(clk),
    .rst(rst),
    .j(ovr_er),
    .k(lsr_clr),
    .q(u13_q));
  /* uart/gh_uart_16550.vhd:531:45  */
  assign n289_o = rf_full & rf_wr;
  /* uart/gh_uart_16550.vhd:531:23  */
  assign n290_o = n289_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:540:22  */
  assign u14_n292 = u14_q; // (signal)
  /* uart/gh_uart_16550.vhd:534:1  */
  gh_jkff u14 (
    .clk(clk),
    .rst(rst),
    .j(parity_er),
    .k(lsr_clr),
    .q(u14_q));
  /* uart/gh_uart_16550.vhd:548:22  */
  assign u15_n295 = u15_q; // (signal)
  /* uart/gh_uart_16550.vhd:542:1  */
  gh_jkff u15 (
    .clk(clk),
    .rst(rst),
    .j(frame_er),
    .k(lsr_clr),
    .q(u15_q));
  /* uart/gh_uart_16550.vhd:556:22  */
  assign u16_n298 = u16_q; // (signal)
  /* uart/gh_uart_16550.vhd:550:1  */
  gh_jkff u16 (
    .clk(clk),
    .rst(rst),
    .j(break_itr),
    .k(lsr_clr),
    .q(u16_q));
  /* uart/gh_uart_16550.vhd:559:28  */
  assign n301_o = tf_empty & tsr_empty;
  /* uart/gh_uart_16550.vhd:567:22  */
  assign u17_n302 = u17_q; // (signal)
  /* uart/gh_uart_16550.vhd:561:1  */
  gh_jkff u17 (
    .clk(clk),
    .rst(rst),
    .j(rf_er),
    .k(lsr_clr),
    .q(u17_q));
  /* uart/gh_uart_16550.vhd:569:42  */
  assign n306_o = rf_di[10:8];
  /* uart/gh_uart_16550.vhd:569:57  */
  assign n308_o = $unsigned(n306_o) > $unsigned(3'b000);
  /* uart/gh_uart_16550.vhd:569:22  */
  assign n309_o = n308_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:572:33  */
  assign n312_o = ~cs;
  /* uart/gh_uart_16550.vhd:572:40  */
  assign n313_o = n312_o | wr;
  /* uart/gh_uart_16550.vhd:572:23  */
  assign n314_o = n313_o ? 1'b0 : n318_o;
  /* uart/gh_uart_16550.vhd:573:33  */
  assign n317_o = add != 3'b101;
  /* uart/gh_uart_16550.vhd:572:55  */
  assign n318_o = n317_o ? 1'b0 : 1'b1;
  /* uart/gh_uart_16550.vhd:581:24  */
  assign u18_n323 = u18_sfe; // (signal)
  /* uart/gh_uart_16550.vhd:576:1  */
  gh_edge_det u18 (
    .clk(clk),
    .rst(rst),
    .d(rd_lsr),
    .re(),
    .fe(),
    .sre(),
    .sfe(u18_sfe));
  /* uart/gh_uart_16550.vhd:587:17  */
  assign n329_o = ~cs;
  /* uart/gh_uart_16550.vhd:596:22  */
  assign u19_n331 = u19_y; // (signal)
  /* uart/gh_uart_16550.vhd:590:1  */
  gh_decode_3to8 u19 (
    .a(add),
    .g1(wr),
    .g2n(csn),
    .g3n(n330_o),
    .y(u19_y));
  /* uart/gh_uart_16550.vhd:599:21  */
  assign n334_o = wr_b[0];
  /* uart/gh_uart_16550.vhd:599:37  */
  assign n335_o = lcr[7];
  /* uart/gh_uart_16550.vhd:599:30  */
  assign n336_o = ~n335_o;
  /* uart/gh_uart_16550.vhd:599:25  */
  assign n337_o = n334_o & n336_o;
  /* uart/gh_uart_16550.vhd:600:23  */
  assign n338_o = wr_b[1];
  /* uart/gh_uart_16550.vhd:600:39  */
  assign n339_o = lcr[7];
  /* uart/gh_uart_16550.vhd:600:32  */
  assign n340_o = ~n339_o;
  /* uart/gh_uart_16550.vhd:600:27  */
  assign n341_o = n338_o & n340_o;
  /* uart/gh_uart_16550.vhd:601:20  */
  assign n342_o = lcr[7];
  /* uart/gh_uart_16550.vhd:601:33  */
  assign n343_o = wr_b[0];
  /* uart/gh_uart_16550.vhd:601:44  */
  assign n344_o = wr_b[1];
  /* uart/gh_uart_16550.vhd:601:37  */
  assign n345_o = n343_o | n344_o;
  /* uart/gh_uart_16550.vhd:601:24  */
  assign n346_o = n342_o & n345_o;
  /* uart/gh_uart_16550.vhd:602:24  */
  assign n347_o = wr_b[1];
  /* uart/gh_uart_16550.vhd:602:35  */
  assign n348_o = lcr[7];
  /* uart/gh_uart_16550.vhd:602:28  */
  assign n349_o = n347_o & n348_o;
  /* uart/gh_uart_16550.vhd:602:47  */
  assign n350_o = wr_b[0];
  /* uart/gh_uart_16550.vhd:602:58  */
  assign n351_o = lcr[7];
  /* uart/gh_uart_16550.vhd:602:51  */
  assign n352_o = n350_o & n351_o;
  /* uart/gh_uart_16550.vhd:602:40  */
  assign n353_o = {n349_o, n352_o};
  /* uart/gh_uart_16550.vhd:610:23  */
  assign n354_o = d[3:0];
  /* uart/gh_uart_16550.vhd:611:22  */
  assign u20_n355 = u20_q; // (signal)
  /* uart/gh_uart_16550.vhd:604:1  */
  gh_register_ce_4 u20 (
    .clk(clk),
    .rst(rst),
    .ce(wr_ier),
    .d(n354_o),
    .q(u20_q));
  /* uart/gh_uart_16550.vhd:619:27  */
  assign n358_o = wr_b[2];
  /* uart/gh_uart_16550.vhd:621:22  */
  assign u21_n359 = u21_q; // (signal)
  /* uart/gh_uart_16550.vhd:614:1  */
  gh_register_ce_8 u21 (
    .clk(clk),
    .rst(rst),
    .ce(n358_o),
    .d(d),
    .q(u21_q));
  /* uart/gh_uart_16550.vhd:630:22  */
  assign u22_n362 = u22_q; // (signal)
  /* uart/gh_uart_16550.vhd:624:1  */
  gh_jkff u22 (
    .clk(clk),
    .rst(rst),
    .j(rf_clrs),
    .k(rf_empty),
    .q(u22_q));
  /* uart/gh_uart_16550.vhd:632:21  */
  assign n365_o = d[1];
  /* uart/gh_uart_16550.vhd:632:33  */
  assign n366_o = wr_b[2];
  /* uart/gh_uart_16550.vhd:632:25  */
  assign n367_o = n365_o & n366_o;
  /* uart/gh_uart_16550.vhd:640:22  */
  assign u23_n368 = u23_q; // (signal)
  /* uart/gh_uart_16550.vhd:634:1  */
  gh_jkff u23 (
    .clk(clk),
    .rst(rst),
    .j(tf_clrs),
    .k(tf_empty),
    .q(u23_q));
  /* uart/gh_uart_16550.vhd:642:21  */
  assign n371_o = d[2];
  /* uart/gh_uart_16550.vhd:642:33  */
  assign n372_o = wr_b[2];
  /* uart/gh_uart_16550.vhd:642:25  */
  assign n373_o = n371_o & n372_o;
  /* uart/gh_uart_16550.vhd:649:27  */
  assign n374_o = wr_b[3];
  /* uart/gh_uart_16550.vhd:651:22  */
  assign u24_n375 = u24_q; // (signal)
  /* uart/gh_uart_16550.vhd:644:1  */
  gh_register_ce_8 u24 (
    .clk(clk),
    .rst(rst),
    .ce(n374_o),
    .d(d),
    .q(u24_q));
  /* uart/gh_uart_16550.vhd:654:33  */
  assign n379_o = lcr[0];
  /* uart/gh_uart_16550.vhd:654:37  */
  assign n380_o = ~n379_o;
  /* uart/gh_uart_16550.vhd:654:52  */
  assign n381_o = lcr[1];
  /* uart/gh_uart_16550.vhd:654:56  */
  assign n382_o = ~n381_o;
  /* uart/gh_uart_16550.vhd:654:44  */
  assign n383_o = n380_o & n382_o;
  /* uart/gh_uart_16550.vhd:654:23  */
  assign n384_o = n383_o ? 32'b00000000000000000000000000000101 : n390_o;
  /* uart/gh_uart_16550.vhd:655:33  */
  assign n386_o = lcr[0];
  /* uart/gh_uart_16550.vhd:655:52  */
  assign n387_o = lcr[1];
  /* uart/gh_uart_16550.vhd:655:56  */
  assign n388_o = ~n387_o;
  /* uart/gh_uart_16550.vhd:655:44  */
  assign n389_o = n386_o & n388_o;
  /* uart/gh_uart_16550.vhd:654:64  */
  assign n390_o = n389_o ? 32'b00000000000000000000000000000110 : n396_o;
  /* uart/gh_uart_16550.vhd:656:33  */
  assign n392_o = lcr[0];
  /* uart/gh_uart_16550.vhd:656:37  */
  assign n393_o = ~n392_o;
  /* uart/gh_uart_16550.vhd:656:52  */
  assign n394_o = lcr[1];
  /* uart/gh_uart_16550.vhd:656:44  */
  assign n395_o = n393_o & n394_o;
  /* uart/gh_uart_16550.vhd:655:64  */
  assign n396_o = n395_o ? 32'b00000000000000000000000000000111 : 32'b00000000000000000000000000001000;
  /* uart/gh_uart_16550.vhd:659:21  */
  assign n398_o = lcr[2];
  /* uart/gh_uart_16550.vhd:661:25  */
  assign n399_o = lcr[3];
  /* uart/gh_uart_16550.vhd:663:25  */
  assign n407_o = lcr[3];
  /* uart/gh_uart_16550.vhd:663:36  */
  assign n408_o = lcr[4];
  /* uart/gh_uart_16550.vhd:663:29  */
  assign n409_o = n407_o & n408_o;
  /* uart/gh_uart_16550.vhd:663:52  */
  assign n410_o = lcr[5];
  /* uart/gh_uart_16550.vhd:663:45  */
  assign n411_o = ~n410_o;
  /* uart/gh_uart_16550.vhd:663:40  */
  assign n412_o = n409_o & n411_o;
  /* uart/gh_uart_16550.vhd:665:24  */
  assign n413_o = lcr[6];
  /* uart/gh_uart_16550.vhd:672:27  */
  assign n414_o = wr_b[4];
  /* uart/gh_uart_16550.vhd:673:23  */
  assign n415_o = d[4:0];
  /* uart/gh_uart_16550.vhd:674:22  */
  assign u25_n416 = u25_q; // (signal)
  /* uart/gh_uart_16550.vhd:667:1  */
  gh_register_ce_5 u25 (
    .clk(clk),
    .rst(rst),
    .ce(n414_o),
    .d(n415_o),
    .q(u25_q));
  /* uart/gh_uart_16550.vhd:677:25  */
  assign n419_o = mcr[0];
  /* uart/gh_uart_16550.vhd:677:18  */
  assign n420_o = ~n419_o;
  /* uart/gh_uart_16550.vhd:677:30  */
  assign n421_o = n420_o | iloop;
  /* uart/gh_uart_16550.vhd:678:25  */
  assign n422_o = mcr[1];
  /* uart/gh_uart_16550.vhd:678:18  */
  assign n423_o = ~n422_o;
  /* uart/gh_uart_16550.vhd:678:30  */
  assign n424_o = n423_o | iloop;
  /* uart/gh_uart_16550.vhd:679:26  */
  assign n425_o = mcr[2];
  /* uart/gh_uart_16550.vhd:679:19  */
  assign n426_o = ~n425_o;
  /* uart/gh_uart_16550.vhd:679:31  */
  assign n427_o = n426_o | iloop;
  /* uart/gh_uart_16550.vhd:680:26  */
  assign n428_o = mcr[3];
  /* uart/gh_uart_16550.vhd:680:19  */
  assign n429_o = ~n428_o;
  /* uart/gh_uart_16550.vhd:680:31  */
  assign n430_o = n429_o | iloop;
  /* uart/gh_uart_16550.vhd:681:21  */
  assign n431_o = mcr[4];
  /* uart/gh_uart_16550.vhd:688:27  */
  assign n432_o = wr_b[7];
  /* uart/gh_uart_16550.vhd:690:22  */
  assign u26_n433 = u26_q; // (signal)
  /* uart/gh_uart_16550.vhd:683:1  */
  gh_register_ce_8 u26 (
    .clk(clk),
    .rst(rst),
    .ce(n432_o),
    .d(d),
    .q(u26_q));
  /* uart/gh_uart_16550.vhd:695:18  */
  assign n436_o = {d, d};
  /* uart/gh_uart_16550.vhd:705:23  */
  assign u27_n437 = u27_rd; // (signal)
  /* uart/gh_uart_16550.vhd:706:24  */
  assign u27_n438 = u27_rce; // (signal)
  /* uart/gh_uart_16550.vhd:707:25  */
  assign u27_n439 = u27_rclk; // (signal)
  /* uart/gh_uart_16550.vhd:697:1  */
  gh_baud_rate_gen u27 (
    .clk(clk),
    .br_clk(br_clk),
    .rst(rst),
    .wr(wr_d),
    .be(wr_dml),
    .d(d16),
    .rd(u27_rd),
    .rce(u27_rce),
    .rclk(u27_rclk));
  /* uart/gh_uart_16550.vhd:724:22  */
  assign u28_n446 = u28_q; // (signal)
  /* uart/gh_uart_16550.vhd:725:26  */
  assign u28_n447 = u28_empty; // (signal)
  /* uart/gh_uart_16550.vhd:726:25  */
  assign u28_n448 = u28_full; // (signal)
  /* uart/gh_uart_16550.vhd:714:1  */
  gh_fifo_async16_sr_8 u28 (
    .clk_wr(clk),
    .clk_rd(br_clk),
    .rst(rst),
    .srst(tf_clr),
    .wr(wr_f),
    .rd(tf_rd),
    .d(d),
    .q(u28_q),
    .empty(u28_empty),
    .full(u28_full));
  /* uart/gh_uart_16550.vhd:737:24  */
  assign u28a_n457 = u28a_sre; // (signal)
  /* uart/gh_uart_16550.vhd:732:1  */
  gh_edge_det u28a (
    .clk(clk),
    .rst(rst),
    .d(isitr1),
    .re(),
    .fe(),
    .sre(u28a_sre),
    .sfe());
  /* uart/gh_uart_16550.vhd:739:35  */
  assign n464_o = ier[1];
  /* uart/gh_uart_16550.vhd:739:28  */
  assign n465_o = tf_empty & n464_o;
  /* uart/gh_uart_16550.vhd:743:33  */
  assign n468_o = add != 3'b010;
  /* uart/gh_uart_16550.vhd:743:23  */
  assign n469_o = n468_o ? 1'b0 : n471_o;
  /* uart/gh_uart_16550.vhd:743:42  */
  assign n471_o = wr ? 1'b0 : n474_o;
  /* uart/gh_uart_16550.vhd:745:32  */
  assign n473_o = ~cs;
  /* uart/gh_uart_16550.vhd:744:39  */
  assign n474_o = n473_o ? 1'b0 : n479_o;
  /* uart/gh_uart_16550.vhd:746:32  */
  assign n476_o = iir[3:1];
  /* uart/gh_uart_16550.vhd:746:45  */
  assign n478_o = n476_o != 3'b001;
  /* uart/gh_uart_16550.vhd:745:39  */
  assign n479_o = n478_o ? 1'b0 : 1'b1;
  /* uart/gh_uart_16550.vhd:754:24  */
  assign u28b_n484 = u28b_sfe; // (signal)
  /* uart/gh_uart_16550.vhd:749:1  */
  gh_edge_det u28b (
    .clk(clk),
    .rst(rst),
    .d(rd_iir),
    .re(),
    .fe(),
    .sre(),
    .sfe(u28b_sfe));
  /* uart/gh_uart_16550.vhd:756:29  */
  assign n490_o = ~tf_empty;
  /* uart/gh_uart_16550.vhd:756:25  */
  assign n491_o = citr1a | n490_o;
  /* uart/gh_uart_16550.vhd:764:22  */
  assign u28c_n492 = u28c_q; // (signal)
  /* uart/gh_uart_16550.vhd:758:1  */
  gh_jkff u28c (
    .clk(clk),
    .rst(rst),
    .j(sitr1),
    .k(citr1),
    .q(u28c_q));
  /* uart/gh_uart_16550.vhd:781:24  */
  assign u29_n495 = u29_stx; // (signal)
  /* uart/gh_uart_16550.vhd:782:26  */
  assign u29_n496 = u29_busyn; // (signal)
  /* uart/gh_uart_16550.vhd:783:25  */
  assign u29_n497 = u29_read; // (signal)
  /* uart/gh_uart_16550.vhd:769:1  */
  gh_uart_tx_8bit u29 (
    .clk(br_clk),
    .rst(rst),
    .xbrc(brc16x),
    .d_ryn(tf_empty),
    .d(tf_do),
    .num_bits(num_bits),
    .break_cb(break_cb),
    .stopb(stopb),
    .parity_en(parity_en),
    .parity_ev(parity_ev),
    .stx(u29_stx),
    .busyn(u29_busyn),
    .read(u29_read));
  /* uart/gh_uart_16550.vhd:796:23  */
  assign u30_n504 = u30_re; // (signal)
  /* uart/gh_uart_16550.vhd:791:1  */
  gh_edge_det u30 (
    .clk(br_clk),
    .rst(rst),
    .d(rd_rdy),
    .re(u30_re),
    .fe(),
    .sre(),
    .sfe());
  /* uart/gh_uart_16550.vhd:798:31  */
  assign n514_o = lcr[7];
  /* uart/gh_uart_16550.vhd:798:22  */
  assign n515_o = n514_o ? 1'b0 : n522_o;
  /* uart/gh_uart_16550.vhd:799:33  */
  assign n518_o = add == 3'b000;
  /* uart/gh_uart_16550.vhd:799:42  */
  assign n519_o = n518_o & cs;
  /* uart/gh_uart_16550.vhd:799:65  */
  assign n520_o = ~wr;
  /* uart/gh_uart_16550.vhd:799:57  */
  assign n521_o = n519_o & n520_o;
  /* uart/gh_uart_16550.vhd:798:42  */
  assign n522_o = n521_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:812:22  */
  assign u31_n524 = u31_q; // (signal)
  /* uart/gh_uart_16550.vhd:813:26  */
  assign u31_n525 = u31_empty; // (signal)
  /* uart/gh_uart_16550.vhd:814:27  */
  assign u31_n526 = u31_q_full; // (signal)
  /* uart/gh_uart_16550.vhd:815:27  */
  assign u31_n527 = u31_h_full; // (signal)
  /* uart/gh_uart_16550.vhd:816:27  */
  assign u31_n528 = u31_a_full; // (signal)
  /* uart/gh_uart_16550.vhd:817:25  */
  assign u31_n529 = u31_full; // (signal)
  /* uart/gh_uart_16550.vhd:802:1  */
  gh_fifo_async16_rcsr_wf_11 u31 (
    .clk_wr(br_clk),
    .clk_rd(clk),
    .rst(rst),
    .rc_srst(rf_clr),
    .wr(rf_wr),
    .rd(rf_rd),
    .d(rf_di),
    .q(u31_q),
    .empty(u31_empty),
    .q_full(u31_q_full),
    .h_full(u31_h_full),
    .a_full(u31_a_full),
    .full(u31_full));
  /* uart/gh_uart_16550.vhd:823:28  */
  assign n542_o = rf_do[8];
  /* uart/gh_uart_16550.vhd:823:37  */
  assign n543_o = ~rf_rd;
  /* uart/gh_uart_16550.vhd:823:32  */
  assign n544_o = n542_o & n543_o;
  /* uart/gh_uart_16550.vhd:830:24  */
  assign u32a_n547 = u32a_sre; // (signal)
  /* uart/gh_uart_16550.vhd:825:1  */
  gh_edge_det u32a (
    .clk(clk),
    .rst(rst),
    .d(iparity_er),
    .re(),
    .fe(),
    .sre(u32a_sre),
    .sfe());
  /* uart/gh_uart_16550.vhd:832:27  */
  assign n554_o = rf_do[9];
  /* uart/gh_uart_16550.vhd:832:36  */
  assign n555_o = ~rf_rd;
  /* uart/gh_uart_16550.vhd:832:31  */
  assign n556_o = n554_o & n555_o;
  /* uart/gh_uart_16550.vhd:839:24  */
  assign u32b_n559 = u32b_sre; // (signal)
  /* uart/gh_uart_16550.vhd:834:1  */
  gh_edge_det u32b (
    .clk(clk),
    .rst(rst),
    .d(iframe_er),
    .re(),
    .fe(),
    .sre(u32b_sre),
    .sfe());
  /* uart/gh_uart_16550.vhd:841:28  */
  assign n566_o = rf_do[10];
  /* uart/gh_uart_16550.vhd:841:38  */
  assign n567_o = ~rf_rd;
  /* uart/gh_uart_16550.vhd:841:33  */
  assign n568_o = n566_o & n567_o;
  /* uart/gh_uart_16550.vhd:848:24  */
  assign u32c_n571 = u32c_sre; // (signal)
  /* uart/gh_uart_16550.vhd:843:1  */
  gh_edge_det u32c (
    .clk(clk),
    .rst(rst),
    .d(ibreak_itr),
    .re(),
    .fe(),
    .sre(u32c_sre),
    .sfe());
  /* uart/gh_uart_16550.vhd:850:30  */
  assign n579_o = ier[2];
  /* uart/gh_uart_16550.vhd:850:34  */
  assign n580_o = ~n579_o;
  /* uart/gh_uart_16550.vhd:850:21  */
  assign n581_o = n580_o ? 1'b0 : n584_o;
  /* uart/gh_uart_16550.vhd:851:30  */
  assign n583_o = lsr[1];
  /* uart/gh_uart_16550.vhd:850:41  */
  assign n584_o = n583_o ? 1'b1 : n589_o;
  /* uart/gh_uart_16550.vhd:852:39  */
  assign n586_o = lsr[4:2];
  /* uart/gh_uart_16550.vhd:852:53  */
  assign n588_o = $unsigned(n586_o) > $unsigned(3'b000);
  /* uart/gh_uart_16550.vhd:851:41  */
  assign n589_o = n588_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:858:33  */
  assign n591_o = ~iloop;
  /* uart/gh_uart_16550.vhd:858:21  */
  assign n592_o = n591_o ? srx : istx;
  /* uart/gh_uart_16550.vhd:862:30  */
  assign n594_o = ier[0];
  /* uart/gh_uart_16550.vhd:862:34  */
  assign n595_o = ~n594_o;
  /* uart/gh_uart_16550.vhd:862:21  */
  assign n596_o = n595_o ? 1'b0 : n602_o;
  /* uart/gh_uart_16550.vhd:863:31  */
  assign n598_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:863:44  */
  assign n600_o = n598_o == 2'b11;
  /* uart/gh_uart_16550.vhd:863:52  */
  assign n601_o = n600_o & a_full;
  /* uart/gh_uart_16550.vhd:862:41  */
  assign n602_o = n601_o ? 1'b1 : n608_o;
  /* uart/gh_uart_16550.vhd:864:31  */
  assign n604_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:864:44  */
  assign n606_o = n604_o == 2'b10;
  /* uart/gh_uart_16550.vhd:864:52  */
  assign n607_o = n606_o & h_full;
  /* uart/gh_uart_16550.vhd:863:72  */
  assign n608_o = n607_o ? 1'b1 : n614_o;
  /* uart/gh_uart_16550.vhd:865:31  */
  assign n610_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:865:44  */
  assign n612_o = n610_o == 2'b01;
  /* uart/gh_uart_16550.vhd:865:52  */
  assign n613_o = n612_o & q_full;
  /* uart/gh_uart_16550.vhd:864:72  */
  assign n614_o = n613_o ? 1'b1 : n621_o;
  /* uart/gh_uart_16550.vhd:866:31  */
  assign n616_o = fcr[7:6];
  /* uart/gh_uart_16550.vhd:866:44  */
  assign n618_o = n616_o == 2'b00;
  /* uart/gh_uart_16550.vhd:866:65  */
  assign n619_o = ~rf_empty;
  /* uart/gh_uart_16550.vhd:866:52  */
  assign n620_o = n618_o & n619_o;
  /* uart/gh_uart_16550.vhd:865:72  */
  assign n621_o = n620_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:878:30  */
  assign u33_n623 = u33_parity_er; // (signal)
  /* uart/gh_uart_16550.vhd:879:29  */
  assign u33_n624 = u33_frame_er; // (signal)
  /* uart/gh_uart_16550.vhd:880:30  */
  assign u33_n625 = u33_break_itr; // (signal)
  /* uart/gh_uart_16550.vhd:881:26  */
  assign u33_n626 = u33_d_rdy; // (signal)
  /* uart/gh_uart_16550.vhd:882:22  */
  assign u33_n627 = u33_d; // (signal)
  /* uart/gh_uart_16550.vhd:869:1  */
  gh_uart_rx_8bit u33 (
    .clk(br_clk),
    .rst(rst),
    .brcx16(brc16x),
    .srx(isrx),
    .num_bits(num_bits),
    .parity_en(parity_en),
    .parity_ev(parity_ev),
    .parity_er(u33_parity_er),
    .frame_er(u33_frame_er),
    .break_itr(u33_break_itr),
    .d_rdy(u33_d_rdy),
    .d(u33_d));
  /* uart/gh_uart_16550.vhd:892:29  */
  assign n638_o = rf_empty | rf_rd;
  /* uart/gh_uart_16550.vhd:892:49  */
  assign n639_o = ier[0];
  /* uart/gh_uart_16550.vhd:892:42  */
  assign n640_o = ~n639_o;
  /* uart/gh_uart_16550.vhd:892:38  */
  assign n641_o = n638_o | n640_o;
  /* uart/gh_uart_16550.vhd:900:22  */
  assign u34_n642 = u34_q; // (signal)
  /* uart/gh_uart_16550.vhd:894:1  */
  gh_jkff u34 (
    .clk(clk),
    .rst(rst),
    .j(toi_set),
    .k(toi_clr),
    .q(u34_q));
  /* uart/gh_uart_16550.vhd:906:25  */
  assign n645_o = lsr[0];
  /* uart/gh_uart_16550.vhd:908:22  */
  assign u35_n646 = u35_q; // (signal)
  /* uart/gh_uart_16550.vhd:902:1  */
  gh_jkff u35 (
    .clk(clk),
    .rst(rst),
    .j(n645_o),
    .k(rf_empty),
    .q(u35_q));
  /* uart/gh_uart_16550.vhd:916:23  */
  assign u35a_n649 = u35a_re; // (signal)
  /* uart/gh_uart_16550.vhd:910:1  */
  gh_edge_det_xcd u35a (
    .iclk(clk),
    .oclk(br_clk),
    .rst(rst),
    .d(rf_rd),
    .re(u35a_re),
    .fe());
  /* uart/gh_uart_16550.vhd:928:34  */
  assign n662_o = ier[0];
  /* uart/gh_uart_16550.vhd:928:38  */
  assign n663_o = ~n662_o;
  /* uart/gh_uart_16550.vhd:928:25  */
  assign n664_o = n663_o ? 1'b1 : n667_o;
  /* uart/gh_uart_16550.vhd:929:39  */
  assign n666_o = ~toi_enc;
  /* uart/gh_uart_16550.vhd:928:45  */
  assign n667_o = n666_o ? 1'b1 : n669_o;
  /* uart/gh_uart_16550.vhd:929:46  */
  assign n669_o = rf_rd_brs ? 1'b1 : n671_o;
  /* uart/gh_uart_16550.vhd:930:48  */
  assign n671_o = rf_wr ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:941:29  */
  assign n673_o = toi_c_d[9:0];
  /* uart/gh_uart_16550.vhd:943:23  */
  assign u36_n675 = u36_tc; // (signal)
  /* uart/gh_uart_16550.vhd:934:1  */
  gh_counter_down_ce_ld_tc_10 u36 (
    .clk(br_clk),
    .rst(rst),
    .load(toi_c_ld),
    .ce(brc16x),
    .d(n673_o),
    .q(),
    .tc(u36_tc));
  /* uart/gh_uart_16550.vhd:952:23  */
  assign u36a_n679 = u36a_re; // (signal)
  /* uart/gh_uart_16550.vhd:946:1  */
  gh_edge_det_xcd u36a (
    .iclk(br_clk),
    .oclk(clk),
    .rst(rst),
    .d(itoi_set),
    .re(u36a_re),
    .fe());
  /* uart/gh_uart_16550.vhd:956:42  */
  assign n686_o = num_bits == 32'b00000000000000000000000000000101;
  /* uart/gh_uart_16550.vhd:956:27  */
  assign n687_o = n686_o ? 12'b000111000000 : n691_o;
  /* uart/gh_uart_16550.vhd:957:42  */
  assign n690_o = num_bits == 32'b00000000000000000000000000000110;
  /* uart/gh_uart_16550.vhd:956:47  */
  assign n691_o = n690_o ? 12'b001000000000 : n695_o;
  /* uart/gh_uart_16550.vhd:958:42  */
  assign n694_o = num_bits == 32'b00000000000000000000000000000111;
  /* uart/gh_uart_16550.vhd:957:47  */
  assign n695_o = n694_o ? 12'b001001000000 : 12'b001010000000;
  /* uart/gh_uart_16550.vhd:964:32  */
  assign n698_o = itr3 | itr2;
  /* uart/gh_uart_16550.vhd:964:40  */
  assign n699_o = n698_o | toi;
  /* uart/gh_uart_16550.vhd:964:47  */
  assign n700_o = n699_o | itr1;
  /* uart/gh_uart_16550.vhd:964:55  */
  assign n701_o = n700_o | itr0;
  /* uart/gh_uart_16550.vhd:964:20  */
  assign n702_o = n701_o ? 1'b1 : 1'b0;
  /* uart/gh_uart_16550.vhd:967:36  */
  assign n705_o = itr3 | itr2;
  /* uart/gh_uart_16550.vhd:967:44  */
  assign n706_o = n705_o | toi;
  /* uart/gh_uart_16550.vhd:967:51  */
  assign n707_o = n706_o | itr1;
  /* uart/gh_uart_16550.vhd:967:59  */
  assign n708_o = n707_o | itr0;
  /* uart/gh_uart_16550.vhd:967:24  */
  assign n709_o = n708_o ? 1'b0 : 1'b1;
  /* uart/gh_uart_16550.vhd:970:35  */
  assign n712_o = itr3 ? 3'b011 : n714_o;
  /* uart/gh_uart_16550.vhd:970:53  */
  assign n714_o = itr2 ? 3'b010 : n716_o;
  /* uart/gh_uart_16550.vhd:971:53  */
  assign n716_o = toi ? 3'b110 : n718_o;
  /* uart/gh_uart_16550.vhd:972:53  */
  assign n718_o = itr1 ? 3'b001 : 3'b000;
  /* uart/gh_uart_16550.vhd:985:22  */
  assign u37_n721 = u37_q; // (signal)
  /* uart/gh_uart_16550.vhd:978:1  */
  gh_register_ce_4 u37 (
    .clk(clk),
    .rst(rst),
    .ce(csn),
    .d(iiir),
    .q(u37_q));
  assign n724_o = {4'b1100, u37_n721};
  assign n725_o = {n712_o, n709_o};
  assign n726_o = {u17_n302, n301_o, tf_empty, u16_n298, u15_n295, u14_n292, u13_n285, n284_o};
  assign n727_o = {u12_n281, ddcd, teri, ddsr, dcts};
  assign n728_o = {n250_o, n246_o, n242_o, n238_o};
  assign n730_o = {u33_n625, u33_n624, u33_n623, u33_n627};
  /* uart/gh_uart_16550.vhd:923:9  */
  always @(posedge br_clk or posedge rst)
    if (rst)
      n731_q <= 1'b0;
    else
      n731_q <= itoi_enc;
endmodule

module gh_uart_16550_AMBA_APB_wrapper
  (input  PCLK,
   input  PRESETn,
   input  PSEL,
   input  PENABLE,
   input  PWRITE,
   input  [2:0] PADDR,
   input  [7:0] PWDATA,
   input  BR_clk,
   input  sRX,
   input  CTSn,
   input  DSRn,
   input  RIn,
   input  DCDn,
   output [7:0] PRDATA,
   output sTX,
   output DTRn,
   output RTSn,
   output OUT1n,
   output OUT2n,
   output TXRDYn,
   output RXRDYn,
   output IRQ,
   output B_CLK);
  wire [7:0] ird;
  wire cs;
  wire ics;
  wire rst;
  wire n10_o;
  wire u1_n11;
  wire u1_n12;
  wire u1_n13;
  wire u1_n14;
  wire u1_n15;
  wire u1_n16;
  wire u1_n17;
  wire u1_n18;
  wire u1_n19;
  wire [7:0] u1_n20;
  wire u1_stx;
  wire u1_dtrn;
  wire u1_rtsn;
  wire u1_out1n;
  wire u1_out2n;
  wire u1_txrdyn;
  wire u1_rxrdyn;
  wire u1_irq;
  wire u1_b_clk;
  wire [7:0] u1_rd;
  wire [7:0] u2_n41;
  wire [7:0] u2_q;
  wire u3_n44;
  wire u3_re;
  wire u3_fe;
  wire u3_sre;
  wire u3_sfe;
  wire n54_o;
  wire n55_o;
  wire n56_o;
  assign PRDATA = u2_n41;
  assign sTX = u1_n11;
  assign DTRn = u1_n12;
  assign RTSn = u1_n13;
  assign OUT1n = u1_n14;
  assign OUT2n = u1_n15;
  assign TXRDYn = u1_n16;
  assign RXRDYn = u1_n17;
  assign IRQ = u1_n18;
  assign B_CLK = u1_n19;
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:112:16  */
  assign ird = u1_n20; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:113:16  */
  assign cs = n56_o; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:114:16  */
  assign ics = u3_n44; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:115:16  */
  assign rst = n10_o; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:122:17  */
  assign n10_o = ~PRESETn;
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:139:27  */
  assign u1_n11 = u1_stx; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:140:27  */
  assign u1_n12 = u1_dtrn; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:141:27  */
  assign u1_n13 = u1_rtsn; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:142:27  */
  assign u1_n14 = u1_out1n; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:143:27  */
  assign u1_n15 = u1_out2n; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:144:27  */
  assign u1_n16 = u1_txrdyn; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:145:27  */
  assign u1_n17 = u1_rxrdyn; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:147:27  */
  assign u1_n18 = u1_irq; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:148:27  */
  assign u1_n19 = u1_b_clk; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:149:27  */
  assign u1_n20 = u1_rd; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:124:1  */
  gh_uart_16550 u1 (
    .clk(PCLK),
    .br_clk(BR_clk),
    .rst(rst),
    .cs(ics),
    .wr(PWRITE),
    .add(PADDR),
    .d(PWDATA),
    .srx(sRX),
    .ctsn(CTSn),
    .dsrn(DSRn),
    .rin(RIn),
    .dcdn(DCDn),
    .stx(u1_stx),
    .dtrn(u1_dtrn),
    .rtsn(u1_rtsn),
    .out1n(u1_out1n),
    .out2n(u1_out2n),
    .txrdyn(u1_txrdyn),
    .rxrdyn(u1_rxrdyn),
    .irq(u1_irq),
    .b_clk(u1_b_clk),
    .rd(u1_rd));
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:159:22  */
  assign u2_n41 = u2_q; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:152:1  */
  gh_register_ce_8 u2 (
    .clk(PCLK),
    .rst(rst),
    .ce(ics),
    .d(ird),
    .q(u2_q));
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:169:23  */
  assign u3_n44 = u3_re; // (signal)
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:164:1  */
  gh_edge_det u3 (
    .clk(PCLK),
    .rst(rst),
    .d(cs),
    .re(u3_re),
    .fe(),
    .sre(),
    .sfe());
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:171:51  */
  assign n54_o = ~PENABLE;
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:171:38  */
  assign n55_o = PSEL & n54_o;
  /* uart/gh_uart_16550_amba_apb_wrapper.vhd:171:19  */
  assign n56_o = n55_o ? 1'b1 : 1'b0;
endmodule

