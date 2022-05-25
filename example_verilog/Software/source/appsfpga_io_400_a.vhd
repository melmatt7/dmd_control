--------------------------------------------------------------------------------
-- Create Date:    6/16/05 
-- Design Name:    Discovery (DDC4100)
-- Module Name:    appsfpga_io_400_a.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the 400MHz architecture for the appsfpga_io module, which 
--              creates all clocks for the project and instantiates all necessary 
--              clock and output buffers. It also reads the dip switch inputs and
--              passes those values back to the top level.
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2005-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

ARCHITECTURE Behavioral OF appsfpga_io IS

COMPONENT PLL_400 IS
   port ( CLKIN1_IN   : in    std_logic;
          RST_IN      : in    std_logic;
          CLKOUT0_OUT : out   std_logic;
          CLKOUT1_OUT : out   std_logic;
          CLKOUT2_OUT : out   std_logic;
          LOCKED_OUT  : out   std_logic);
END COMPONENT;

COMPONENT ddr_lvds_io IS
PORT (
      d1             : IN STD_LOGIC; -- clock 0 rising edge
      d2             : IN STD_LOGIC; -- clock 0 falling edge
      d3             : IN STD_LOGIC; -- clock 1 rising edge
      d4             : IN STD_LOGIC; -- clock 1 falling edge
      dout_dpp       : OUT STD_LOGIC;
      dout_dpn       : OUT STD_LOGIC;
      clk2X          : IN STD_LOGIC; -- freq=2x
      clk1X          : IN STD_LOGIC; -- freq=x
      reset          : IN STD_LOGIC
      );
END COMPONENT;

COMPONENT ddr_se_io IS
PORT (
      d1             : IN STD_LOGIC; -- clock 0 rising edge
      d2             : IN STD_LOGIC; -- clock 0 falling edge
      d3             : IN STD_LOGIC; -- clock 1 rising edge
      d4             : IN STD_LOGIC; -- clock 1 falling edge
      dout           : OUT STD_LOGIC;
      clk2X          : IN STD_LOGIC; -- freq=2x
      clk1X          : IN STD_LOGIC; -- freq=x
      reset          : IN STD_LOGIC
      );
END COMPONENT;

SIGNAL      clk_a           : STD_LOGIC;
SIGNAL      clk_b           : STD_LOGIC;
SIGNAL      clk0            : STD_LOGIC;
SIGNAL      clk0_200        : STD_LOGIC;
SIGNAL      clk180          : STD_LOGIC;
SIGNAL      clk2x           : STD_LOGIC;
SIGNAL      clk2x180        : STD_LOGIC;
SIGNAL      clk2x_b         : STD_LOGIC;
SIGNAL      locked_1        : STD_LOGIC;
SIGNAL      pll_rst         : STD_LOGIC;
SIGNAL      locked_2        : STD_LOGIC;
SIGNAL      all_locked      : STD_LOGIC;
SIGNAL      reset           : STD_LOGIC;
SIGNAL      temp_dout_a     : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL      temp_dout_b     : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL      temp_dout_c     : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL      temp_dout_d     : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL      temp_dvalid     : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL      dvalid_b3       : STD_LOGIC;
SIGNAL      dvalid_b2       : STD_LOGIC;
SIGNAL      dvalid_b1       : STD_LOGIC;
SIGNAL      dvalid_b0       : STD_LOGIC;
SIGNAL      clock_cd_mux    : STD_LOGIC_VECTOR(3 DOWNTO 0 );

SIGNAL  in_init_active_q1    : STD_LOGIC;
SIGNAL  in_init_active_q2    : STD_LOGIC;
SIGNAL  init_active_gq_int   : STD_LOGIC;
SIGNAL  pll_locked_rst_bq1   : STD_LOGIC;
SIGNAL  pll_locked_rst_bq2   : STD_LOGIC;
SIGNAL  pll_locked_rst_bq    : STD_LOGIC;
SIGNAL  pll_locked_rstz_gq1  : STD_LOGIC;
SIGNAL  pll_locked_rstz_gq2  : STD_LOGIC;
SIGNAL  pll_delay_cnt        : STD_LOGIC_VECTOR(9 DOWNTO 0 );

-- Resynch of top level switch signals
SIGNAL  appsfpga_io_pwr_floatz_1q     : STD_LOGIC;
SIGNAL  appsfpga_io_pwr_floatz_2q     : STD_LOGIC;
SIGNAL  appsfpga_io_float_1q          : STD_LOGIC;
SIGNAL  appsfpga_io_float_2q          : STD_LOGIC;
SIGNAL  appsfpga_io_cnthalt_1q        : STD_LOGIC;
SIGNAL  appsfpga_io_cnthalt_2q        : STD_LOGIC;
SIGNAL  appsfpga_io_comp_data_en_1q   : STD_LOGIC;
SIGNAL  appsfpga_io_comp_data_en_2q   : STD_LOGIC;
SIGNAL  appsfpga_io_ns_flip_en_1q     : STD_LOGIC;
SIGNAL  appsfpga_io_ns_flip_en_2q     : STD_LOGIC;
SIGNAL  appsfpga_io_reset_type_1q     : STD_LOGIC_VECTOR(1 DOWNTO 0 );
SIGNAL  appsfpga_io_reset_type_2q     : STD_LOGIC_VECTOR(1 DOWNTO 0 );
SIGNAL  appsfpga_io_rowaddrmode_1q    : STD_LOGIC;
SIGNAL  appsfpga_io_rowaddrmode_2q    : STD_LOGIC;
SIGNAL  appsfpga_io_WDT_enbl_1q       : STD_LOGIC;
SIGNAL  appsfpga_io_WDT_enbl_2q       : STD_LOGIC;

BEGIN

pll_speed_info <= "10";                                 

-- Generating clock mux for C and D data clocks
-- C and D clocks not enabled for 2 bus DMD's
clock_cd_mux <= "0000" when in_dmd_type="0001" ELSE -- .7 XGA (Type A)
                "0000" when in_dmd_type="0010" ELSE -- .55 XGA (Type A)
                "0000" when in_dmd_type="0011" ELSE -- .55 XGA (Type X)
                "0000" when in_dmd_type="0111" ELSE -- .65 WXGA NIR
                "0101";

-- Synchronize user inputs
PROCESS (clk_b)
  BEGIN
    IF clk_b='1' AND clk_b'event THEN
      appsfpga_io_pwr_floatz_1q   <= in_pb_sw_i                AFTER 1 PS;
      appsfpga_io_pwr_floatz_2q   <= appsfpga_io_pwr_floatz_1q AFTER 1 PS;
      appsfpga_io_pwr_floatz_q    <= appsfpga_io_pwr_floatz_2q AFTER 1 PS;
      --
      appsfpga_io_float_1q        <= in_dip_sw_i(0)       AFTER 1 PS;
      appsfpga_io_float_2q        <= appsfpga_io_float_1q AFTER 1 PS;
      appsfpga_io_float_q         <= appsfpga_io_float_2q AFTER 1 PS;
      --
      appsfpga_io_cnthalt_1q      <= in_dip_sw_i(1)         AFTER 1 PS;
      appsfpga_io_cnthalt_2q      <= appsfpga_io_cnthalt_1q AFTER 1 PS;
      appsfpga_io_cnthalt_q       <= appsfpga_io_cnthalt_2q AFTER 1 PS;
      --
      appsfpga_io_comp_data_en_1q <= in_dip_sw_i(2)              AFTER 1 PS;
      appsfpga_io_comp_data_en_2q <= appsfpga_io_comp_data_en_1q AFTER 1 PS;
      appsfpga_io_comp_data_en_q  <= appsfpga_io_comp_data_en_2q AFTER 1 PS;
      --
      appsfpga_io_ns_flip_en_1q   <= in_dip_sw_i(3)            AFTER 1 PS;
      appsfpga_io_ns_flip_en_2q   <= appsfpga_io_ns_flip_en_1q AFTER 1 PS;
      appsfpga_io_ns_flip_en_q    <= appsfpga_io_ns_flip_en_2q AFTER 1 PS;
      --
      appsfpga_io_reset_type_1q   <= in_dip_sw_i (5 DOWNTO 4)  AFTER 1 PS;
      appsfpga_io_reset_type_2q   <= appsfpga_io_reset_type_1q AFTER 1 PS;
      appsfpga_io_reset_type_q    <= appsfpga_io_reset_type_2q AFTER 1 PS;
      --
      appsfpga_io_rowaddrmode_1q  <= in_dip_sw_i(6)             AFTER 1 PS;
      appsfpga_io_rowaddrmode_2q  <= appsfpga_io_rowaddrmode_1q AFTER 1 PS;
      appsfpga_io_rowaddrmode_q   <= appsfpga_io_rowaddrmode_2q AFTER 1 PS;
      --
      appsfpga_io_WDT_enbl_1q     <= in_dip_sw_i(7)          AFTER 1 PS;
      appsfpga_io_WDT_enbl_2q     <= appsfpga_io_WDT_enbl_1q AFTER 1 PS;
      appsfpga_io_WDT_enbl_q      <= appsfpga_io_WDT_enbl_2q AFTER 1 PS;
      --
      appsfpga_io_STEP_VCC_enbl_q <= '0' AFTER 1 PS;
    END IF;
END PROCESS;


--- PLL reset timer (1024 ticks of the 50MHz clock)---
--- Holds PLL in reset until clock is locked and stable.
PROCESS (clk_i, pll_rst)
BEGIN
   IF (pll_rst = '1') THEN
     pll_delay_cnt    <= "0000000000";
   ELSIF (clk_i='1' AND clk_i'EVENT) THEN
     IF (locked_2 = '0') THEN
        pll_delay_cnt    <= "0000000000";
     ELSE
        IF (pll_delay_cnt < "1000000011") THEN
           pll_delay_cnt    <= pll_delay_cnt + "0000000001";
        END IF;
     END IF;
   END IF;
END PROCESS;


-- Reset synch to clk_b (aka clk_g). deassertion
PROCESS (clk_b, pll_rst)
BEGIN
   IF pll_rst = '1' THEN
     pll_locked_rst_bq1  <= '1';
     pll_locked_rst_bq2  <= '1';
     pll_locked_rst_bq   <= '1';   -- equivalent of old "reset" used here. active high
     pll_locked_rstz_gq1 <= '0';
     pll_locked_rstz_gq2 <= '0';
     pll_locked_rstz_gq  <= '0';   -- equivalent of old appsfpga_io_locked used elsewhere. active high
   ELSIF (clk_b='1' AND clk_b'EVENT) THEN
     IF ((locked_2 = '0') OR (pll_delay_cnt(9) /= '1'))THEN
       pll_locked_rst_bq1  <= '1';
       pll_locked_rst_bq2  <= '1';
       pll_locked_rst_bq   <= '1';   -- equivalent of old "reset" used here. active high
       pll_locked_rstz_gq1 <= '0';
       pll_locked_rstz_gq2 <= '0';
       pll_locked_rstz_gq  <= '0';   -- equivalent of old appsfpga_io_locked used elsewhere. active high
     ELSE
       pll_locked_rst_bq1  <= '0'                AFTER 1 PS;
       pll_locked_rst_bq2  <= pll_locked_rst_bq1  AFTER 1 PS;
       pll_locked_rst_bq   <= pll_locked_rst_bq2  AFTER 1 PS;
       pll_locked_rstz_gq1 <= '1'                AFTER 1 PS;
       pll_locked_rstz_gq2 <= pll_locked_rstz_gq1 AFTER 1 PS;
       pll_locked_rstz_gq  <= pll_locked_rstz_gq2 AFTER 1 PS;
     END IF;
   END IF;
END PROCESS;

-- Synchronize init active to clk_b(clk_g)
PROCESS (clk_b, pll_rst)
BEGIN
   IF (pll_rst = '1') THEN
     in_init_active_q1  <= '1';
     in_init_active_q2  <= '1';
     init_active_gq_int <= '1';
   ELSIF (clk_b='1' AND clk_b'EVENT) THEN
     IF (locked_2 = '0') THEN
       in_init_active_q1  <= '1';
       in_init_active_q2  <= '1';
       init_active_gq_int <= '1';
     ELSE
       in_init_active_q1  <= in_init_active_i AFTER 1 PS;
       in_init_active_q2  <= in_init_active_q1 AFTER 1 PS;
       init_active_gq_int <= in_init_active_q2 AFTER 1 PS;
     END IF;
   END IF;
END PROCESS;

init_active_gq <= init_active_gq_int;      --assign output


--global clock and output reference (50MHz) clock
clk_g   <= clk_b;
arst_gq <= pll_locked_rst_bq;
clk_r_o <= clk_a;

i_BUFG_0 : BUFG
  PORT map (
    O => clk_a, -- Clock buffer output
    I => clk_i  -- Clock buffer input (connect directly to top-level port)
);

clk_b <= clk0;
clk2x_b <= clk2x;


pll_rst <= pwrgdz;

i_PLL_clk : PLL_400
PORT MAP(
     CLKIN1_IN   => clk_a  ,
     RST_IN      => pll_rst,
     CLKOUT0_OUT => clk0,       -- 200MHz
     CLKOUT1_OUT => clk2x,      -- 400MHz
     CLKOUT2_OUT => clk2x180,   -- 400MHz 180deg
     LOCKED_OUT  => locked_2
    );


-- training pattern insertion mux
temp_dout_a <= "0000000000000000000000000000000011111111111111110000000000000000" WHEN (init_active_gq_int = '1') ELSE appcore_dout_a_q;
temp_dout_b <= "0000000000000000000000000000000011111111111111110000000000000000" WHEN (init_active_gq_int = '1') ELSE appcore_dout_b_q;
temp_dout_c <= "0000000000000000000000000000000011111111111111110000000000000000" WHEN (init_active_gq_int = '1') ELSE appcore_dout_c_q;
temp_dout_d <= "0000000000000000000000000000000011111111111111110000000000000000" WHEN (init_active_gq_int = '1') ELSE appcore_dout_d_q;
temp_dvalid <= "0100" WHEN (init_active_gq_int = '1') ELSE (appcore_data_valid_q & appcore_data_valid_q & appcore_data_valid_q & appcore_data_valid_q);

-- create 16 ddr_lvds_io for each channel a,b,c,d
dat_gen_loop:
FOR i IN 0 TO 15 GENERATE
  BEGIN

         data_a_io : ddr_lvds_io
         PORT MAP (
      d1  => temp_dout_a(i+48),
      d2  => temp_dout_a(i+32),
      d3  => temp_dout_a(i+16),
      d4  => temp_dout_a(i),
      dout_dpp => appsfpga_io_dout_ap(i),    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dout_an(i),    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

         data_b_io : ddr_lvds_io
         PORT MAP (
      d1  => temp_dout_b(i+48),
      d2  => temp_dout_b(i+32),
      d3  => temp_dout_b(i+16),
      d4  => temp_dout_b(i),
      dout_dpp => appsfpga_io_dout_bp(i),    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dout_bn(i),    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

         data_c_io : ddr_lvds_io
         PORT MAP (
      d1  => temp_dout_c(i+48),
      d2  => temp_dout_c(i+32),
      d3  => temp_dout_c(i+16),
      d4  => temp_dout_c(i),
      dout_dpp => appsfpga_io_dout_cp(i),    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dout_cn(i),    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

         data_d_io : ddr_lvds_io
         PORT MAP (
      d1  => temp_dout_d(i+48),
      d2  => temp_dout_d(i+32),
      d3  => temp_dout_d(i+16),
      d4  => temp_dout_d(i),
      dout_dpp => appsfpga_io_dout_dp(i),    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dout_dn(i),    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );
END GENERATE;

-- use OSERDES to duplicate delay
rowmd_loop:
FOR i IN 0 TO 1 GENERATE
  BEGIN

         rowmd_io : ddr_se_io
         PORT MAP (
      d1  => appcore_rowmd_q(i),
      d2  => appcore_rowmd_q(i),
      d3  => appcore_rowmd_q(i),
      d4  => appcore_rowmd_q(i),
      dout => appsfpga_io_rowmd_q(i),
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

END GENERATE;

-- use OSERDES to duplicate delay
rowad_loop:
FOR i IN 0 TO 10 GENERATE
  BEGIN

         rowad_io : ddr_se_io
         PORT MAP (
      d1  => appcore_rowad_q(i),
      d2  => appcore_rowad_q(i),
      d3  => appcore_rowad_q(i),
      d4  => appcore_rowad_q(i),
      dout => appsfpga_io_rowad_q(i),
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

END GENERATE;

-- use OSERDES to duplicate delay
blkad_loop:
FOR i IN 0 TO 3 GENERATE
  BEGIN

         blkad_io : ddr_se_io
         PORT MAP (
      d1  => appcore_blkad_q(i),
      d2  => appcore_blkad_q(i),
      d3  => appcore_blkad_q(i),
      d4  => appcore_blkad_q(i),
      dout => appsfpga_io_blkad_q(i),
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

END GENERATE;

-- use OSERDES to duplicate delay
blkmd_loop:
FOR i IN 0 TO 1 GENERATE
  BEGIN

         blkmd_io : ddr_se_io
         PORT MAP (
      d1  => appcore_blkmd_q(i),
      d2  => appcore_blkmd_q(i),
      d3  => appcore_blkmd_q(i),
      d4  => appcore_blkmd_q(i),
      dout => appsfpga_io_blkmd_q(i),
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

END GENERATE;

dvalid_b3 <= temp_dvalid(3);
dvalid_b2 <= temp_dvalid(2);
dvalid_b1 <= temp_dvalid(1);
dvalid_b0 <= temp_dvalid(0);

-- Create 4 separate dvalids
dvalid_io_a : ddr_lvds_io
    PORT MAP (
      d1  => dvalid_b0,
      d2  => dvalid_b1,
      d3  => dvalid_b2,
      d4  => dvalid_b3,
      dout_dpp => appsfpga_io_dvalid_ap,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dvalid_an,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

dvalid_io_b : ddr_lvds_io
    PORT MAP (
      d1  => dvalid_b0,
      d2  => dvalid_b1,
      d3  => dvalid_b2,
      d4  => dvalid_b3,
      dout_dpp => appsfpga_io_dvalid_bp,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dvalid_bn,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

dvalid_io_c : ddr_lvds_io
    PORT MAP (
      d1  => dvalid_b0,
      d2  => dvalid_b1,
      d3  => dvalid_b2,
      d4  => dvalid_b3,
      dout_dpp => appsfpga_io_dvalid_cp,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dvalid_cn,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

dvalid_io_d : ddr_lvds_io
    PORT MAP (
      d1  => dvalid_b0,
      d2  => dvalid_b1,
      d3  => dvalid_b2,
      d4  => dvalid_b3,
      dout_dpp => appsfpga_io_dvalid_dp,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dvalid_dn,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

-- Create 4 separate dclks
clk_io_a : ddr_lvds_io
    PORT MAP (
      d1  => '1',
      d2  => '0',
      d3  => '1',
      d4  => '0',
      dout_dpp => appsfpga_io_dclk_ap,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dclk_an,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

clk_io_b : ddr_lvds_io
    PORT MAP (
      d1  => '1',
      d2  => '0',
      d3  => '1',
      d4  => '0',
      dout_dpp => appsfpga_io_dclk_bp,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dclk_bn,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

clk_io_c : ddr_lvds_io
    PORT MAP (
      d1  => clock_cd_mux(0),
      d2  => clock_cd_mux(1),
      d3  => clock_cd_mux(2),
      d4  => clock_cd_mux(3),
      dout_dpp => appsfpga_io_dclk_cp,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dclk_cn,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

clk_io_d : ddr_lvds_io
    PORT MAP (
      d1  => clock_cd_mux(0),
      d2  => clock_cd_mux(1),
      d3  => clock_cd_mux(2),
      d4  => clock_cd_mux(3),
      dout_dpp => appsfpga_io_dclk_dp,    -- diff_p output (connect directly to top-level port)
      dout_dpn => appsfpga_io_dclk_dn,    -- diff_n output (connect directly to top-level port)
      clk2X => clk2x_b,
      clk1X => clk_b,
      reset => pll_locked_rst_bq
      );

END Behavioral;
