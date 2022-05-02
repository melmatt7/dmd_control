--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_pgg_a.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture for module pgen_pgg, which creates
--              signals unique to operation in the global reset mode including
--              row valid, row mode, block mode, block address, and data valid.
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2005-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------

--component declarations library
LIBRARY ddc4100;
USE ddc4100.appsfpga_dmd_types_pkg.ALL;

ARCHITECTURE Behavioral OF pgen_pgg IS

SIGNAL      data_valid           : STD_LOGIC;
SIGNAL      row_valid            : STD_LOGIC;
SIGNAL      rowmd                : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      blkmode              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      blkaddress           : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL      cnts_active_cnten_q1 : STD_LOGIC;
SIGNAL      cnts_active_cnten_q2 : STD_LOGIC;
SIGNAL      pgen_row_q           : STD_LOGIC_VECTOR (10 DOWNTO 0);
SIGNAL      max_row_count        : STD_LOGIC_VECTOR( 10 DOWNTO 0 );
SIGNAL      row_count_p1         : STD_LOGIC_VECTOR( 10 DOWNTO 0 );

BEGIN

--determine validity of data passed on the top level output
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      data_valid            <= '0';
      pgen_pgg_data_valid_q <= '0';
      cnts_active_cnten_q1  <= '0';
      cnts_active_cnten_q2  <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
      data_valid            <= cnts_active_cnten_q2 AND row_valid AFTER 1 PS;
      cnts_active_cnten_q1  <= cnts_active_cnten_q AFTER 1 PS;
      cnts_active_cnten_q2  <= cnts_active_cnten_q1 AFTER 1 PS;
      pgen_pgg_data_valid_q <= data_valid AFTER 1 PS;
   END IF;
END PROCESS;

-- Function defined in appsfpga_dmd_types_pkg
max_row_count <= row_count + 100; -- Added counts to ensure enough settling time
row_count_p1 <= row_count +1 ; -- Add 1 to start block mode 1 count later.

--determine if the current row is in the range of the dmd
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
  IF ( locked_init_rstz_gq = '0' ) THEN
    row_valid <= '0';
  ELSIF clk_g = '1' AND clk_g'event THEN
    IF pgen_row = "00000000000" THEN
      row_valid <= '1' AFTER 1 PS;
    ELSIF pgen_row = max_row_count THEN
      row_valid <= '0' AFTER 1 PS;
    ELSE
      row_valid <= row_valid AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

pgen_pgg_row_valid <= row_valid;

--set block mode of the dmd; 11 is global reset when address is 10XX
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
  IF ( locked_init_rstz_gq = '0' ) THEN
    pgen_row_q       <= (OTHERS => '0');
    blkmode          <= "00" ;
    pgen_pgg_blkmd_q <= "00" ;
    blkaddress       <= "0000" ;
    pgen_pgg_blkad_q <= "0000" ;
  ELSIF clk_g = '1' AND clk_g'event THEN
    IF pgen_row_q = row_count_p1 AND cnts_active_cnten_q2 = '1' THEN
      blkmode          <= "11" AFTER 1 PS;
      pgen_pgg_blkmd_q <= blkmode AFTER 1 PS;
      blkaddress       <= "1000" AFTER 1 PS;
      pgen_pgg_blkad_q <= blkaddress AFTER 1 PS;
    ELSE
      blkmode <= "00" AFTER 1 PS;
      pgen_pgg_blkmd_q <= blkmode AFTER 1 PS;
      blkaddress <= "0000" AFTER 1 PS;
      pgen_pgg_blkad_q <= blkaddress AFTER 1 PS;
    END IF;

    pgen_row_q <= pgen_row AFTER 1 PS; -- Added pipieline to adjust timing on blkmode and blk address during 0 clock only

  END IF;
END PROCESS;

--tell dmd when to increment row pointer (01) or reset row pointer (11) or do
--nothing (00)
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
  IF ( locked_init_rstz_gq = '0' ) THEN
    rowmd <= "00" AFTER 1 PS;
    pgen_pgg_rowmd <= "00" ;
  ELSIF clk_g = '1' AND clk_g'event THEN
    IF pgen_row_q = "00000000000" THEN
      rowmd <= "11" AFTER 1 PS;
    ELSIF pgen_row_q = "00000000001" THEN
      rowmd <= "01" AFTER 1 PS;
    ELSIF pgen_row_q = row_count +1 THEN
      rowmd <= "00" AFTER 1 PS;
    ELSE
      rowmd <= rowmd;
    END IF;

    IF data_valid = '1' THEN -- not really needed
      pgen_pgg_rowmd <= rowmd AFTER 1 PS;
    ELSE
      pgen_pgg_rowmd <= "00" AFTER 1 PS;
    END IF;

   END IF;
END PROCESS;


END Behavioral;
