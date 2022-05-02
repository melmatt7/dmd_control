
--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_clear_a.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture for the module pgen_clear, which will
--              create signals unique to operation in the single block phased
--              reset mode including row valid, row mode, block mode, block
--              address, and data valid.
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2005-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ARCHITECTURE Behavioral OF pgen_clear IS

SIGNAL      data_valid           : STD_LOGIC;
SIGNAL      blkmode              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      blkaddr              : STD_LOGIC_VECTOR (3 DOWNTO 0);

--SIGNAL      row_valid            : STD_LOGIC;
SIGNAL      cnts_active_cnten_q1 : STD_LOGIC;
SIGNAL      cnts_active_cnten_q2 : STD_LOGIC;
SIGNAL      max_row_count        : STD_LOGIC_VECTOR( 10 DOWNTO 0 );
--SIGNAL      row_load             : STD_LOGIC_VECTOR( 6 DOWNTO 0 );
--SIGNAL      xga                  : STD_LOGIC;

SIGNAL      pgen_row_q1          : STD_LOGIC_VECTOR( 10 DOWNTO 0 );

BEGIN

-- Function defined in appsfpga_dmd_types_pkg
max_row_count <= row_count + 5; -- Added counts to ensure enough settling time

-- The number of rows in each reset group is determined by the DMD type:
--  .95" 1080p Type A       : 72 rows (36 * 2 DADs)
--  .7" XGA Type A          : 48 rows
--  .55" XGA Type A         : 48 rows
--  .55" XGA Type X         : 48 rows
--  .95" WUXGA Type A       : 80 rows (40 * 2 DADs)
--PROCESS (clk_g, locked_init_rstz_gq)
--BEGIN
--   IF locked_init_rstz_gq = '0' THEN
--      row_load <= (OTHERS => '0');
--      xga <= '0';
--   ELSIF clk_g = '1' AND clk_g'event THEN
--      IF WL_count = "100100" THEN -- if DMD type is 1080p (36)
--         row_load <= "1001000" AFTER 1 PS;  -- 72
--         xga <= '0' AFTER 1 PS;
--      ELSIF WL_count = "110000" THEN -- if DMD type is XGA (48)
--         row_load <= "0110000" AFTER 1 PS;   -- 48
--         xga <= '1' AFTER 1 PS;
--      ELSIF WL_count = "101000" THEN -- if DMD type is WUXGA (40)
--         row_load <= "1010000" AFTER 1 PS; -- 80
--         xga <= '0' AFTER 1 PS;
--      ELSE
--         row_load <= (OTHERS => '0') AFTER 1 PS;
--         xga <= '0' AFTER 1 PS;
--      END IF;
--   END IF;
--END PROCESS;


--determine validity of data passed on the top level output
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      cnts_active_cnten_q1 <= '0';
      cnts_active_cnten_q2 <= '0';
	  
      pgen_pgc_data_valid_q <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
      cnts_active_cnten_q2 <= cnts_active_cnten_q1 AFTER 1 PS;
      cnts_active_cnten_q1 <= cnts_active_cnten_q AFTER 1 PS;
	  
      pgen_pgc_data_valid_q <= data_valid AFTER 1 PS;
   END IF;
END PROCESS;


--pgen_pgc_row_valid <= row_valid;

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
    pgen_pgc_blkmd_q <= "00" AFTER 1 PS;
    pgen_pgc_blkad_q <= "0000" AFTER 1 PS;
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF data_valid = '1' THEN
         pgen_pgc_blkmd_q <= blkmode AFTER 1 PS ;
         pgen_pgc_blkad_q <= blkaddr AFTER 1 PS ;
      ELSE
        pgen_pgc_blkmd_q <= "00" AFTER 1 PS;
        pgen_pgc_blkad_q <= "0000" AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

--determine which set of blocks to reset
--if the north/south flip switch is on, the blocks need to be reset in reverse
--order to avoid resetting blocks that have not yet been fully loaded
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN 
     pgen_row_q1 <= (OTHERS => '0');

     data_valid  <= '0';
     blkmode     <= "00" ;
     blkaddr     <= "0000" ;
   ELSIF clk_g = '1' AND clk_g'event THEN
    pgen_row_q1 <= pgen_row;
	
        CASE CONV_INTEGER(unsigned(pgen_row_q1)) IS
		   WHEN 0 =>
              blkmode    <= "00" AFTER 1 PS;
              blkaddr    <= "0000" AFTER 1 PS;		  
              data_valid <= '0'  AFTER 1 PS;
           WHEN 1 TO 4 =>
              blkmode <= "00" AFTER 1 PS;
              blkaddr <= "0000" AFTER 1 PS;		  
              data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
        --WHEN 2 =>
        --   blkmode <= "00" AFTER 1 PS;
        --   blkaddr <= "0000" AFTER 1 PS;
        --   data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
        --WHEN 3 =>
        --   blkmode <= "00" AFTER 1 PS;
        --   blkaddr <= "0000" AFTER 1 PS;
        --   data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
        --WHEN 4 =>
        --   blkmode    <= "00" AFTER 1 PS;
        --   blkaddr    <= "0000" AFTER 1 PS;	
        --   data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
           WHEN 5 =>
			  IF (unsigned('0'&clear_block) < unsigned(BSA_count) ) THEN
                blkmode <= "01" AFTER 1 PS;
                blkaddr <= clear_block AFTER 1 PS; -- clear blocks in order.
			  ELSE
                blkmode <= "00" AFTER 1 PS;
                blkaddr <= "0000" AFTER 1 PS;
			  END IF;
              data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
           WHEN 6 TO 8 =>
              blkmode <= "00" AFTER 1 PS;
              blkaddr <= "0000" AFTER 1 PS;
              data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
        --  WHEN 7 =>
        --     blkmode <= "00" AFTER 1 PS;
        --     blkaddr <= "0000" AFTER 1 PS;
        --     data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
           WHEN 9 =>
              blkmode <= "11" AFTER 1 PS;
              blkaddr <= "1000" AFTER 1 PS; -- Global Reset
              data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
           WHEN 10 TO 1024 =>  -- Generate enough row cycles for reset to happen correctly.
              blkmode <= "00" AFTER 1 PS;
              blkaddr <= "0000" AFTER 1 PS;
              data_valid <= cnts_active_cnten_q2  AFTER 1 PS;
           WHEN OTHERS =>
              blkmode <= "00" AFTER 1 PS;
              blkaddr <= "0000" AFTER 1 PS;
              data_valid <= '0'  AFTER 1 PS;
        END CASE;
   END IF;
END PROCESS;

--determine if the current row is in the range of the dmd
--PROCESS (clk_g, locked_init_rstz_gq)
--BEGIN
--    IF locked_init_rstz_gq = '0' THEN 
--        row_valid <= '0' AFTER 1 PS;       
--   ELSIF clk_g = '1' AND clk_g'event THEN
--     IF pgen_row = "00000000000" THEN
--        row_valid <= '0' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000000001" THEN
--        row_valid <= '1' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000000010" THEN
--        row_valid <= '1' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000000011" THEN
--        row_valid <= '1' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000000100" THEN
--        row_valid <= '0' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000000101" THEN
--        row_valid <= '1' AFTER 1 PS; -- CLEAR
--     ELSIF pgen_row = "00000000110" THEN
--        row_valid <= '1' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000000111" THEN
--        row_valid <= '1' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000001000" THEN
--        row_valid <= '0' AFTER 1 PS; --NOP
--     ELSIF pgen_row = "00000001001" THEN
--        row_valid <= '1' AFTER 1 PS; -- Reset
--     ELSIF pgen_row = max_row_count THEN
--        row_valid <= '0' AFTER 1 PS; -- Do a bunch of NOPs after reset
--     ELSE
--        row_valid <= row_valid AFTER 1 PS;
--     END IF;
--
--  END IF;
--END PROCESS;


    pgen_pgc_rowmd <= "00"; --rowmd 

END Behavioral;
