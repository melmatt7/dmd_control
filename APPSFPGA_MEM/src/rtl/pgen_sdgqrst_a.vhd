--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_sdgqrst_a.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture for the module pgen_sdgqrst, which will 
--              create signals unique to operation in the dual block phased 
--              reset mode including row valid, row mode, block mode, block 
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2005-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF pgen_sdgqrst IS

SIGNAL      data_valid           : STD_LOGIC;
SIGNAL      rowmd                : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      row_valid            : STD_LOGIC;

BEGIN

--determine validity of data passed on the top level output
PROCESS (clk_g, appsfpga_io_locked)
BEGIN
   IF appsfpga_io_locked = '0' THEN
      data_valid <= '0';
      pgen_sdgq_data_valid_q <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
      data_valid <= cnts_active_cnten_q AND row_valid AND appsfpga_io_locked AFTER 1 PS;
      pgen_sdgq_data_valid_q <= data_valid AFTER 1 PS;
   END IF;
END PROCESS;

--determine if the current row is in the range of the dmd
PROCESS (clk_g)
BEGIN
  IF clk_g = '1' AND clk_g'event THEN
     CASE pgen_row IS
        WHEN "00000000000" => row_valid <= '1' AFTER 1 PS;
        WHEN "10000111000" => row_valid <= '0' AFTER 1 PS;
        WHEN OTHERS => row_valid <= row_valid AFTER 1 PS;
     END CASE;
  END IF;
END PROCESS;

pgen_sdgq_row_valid_q <= row_valid;

--determine which set of blocks to reset
--if the north/south flip switch is on, the blocks need to be reset in reverse
--order to avoid resetting blocks that have not yet been fully loaded
PROCESS (clk_g)
BEGIN
   IF clk_g = '1' AND clk_g'event THEN
	   CASE pgen_reset_type_q IS
			WHEN "00" =>	-- single block phased reset
			WHEN "01" =>	-- dual block phased reset
				IF data_valid = '1' THEN
				CASE pgen_row IS
					WHEN "00010010000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN -- 144
								 pgen_sdgq_blkad_q <= "0000" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0111" AFTER 1 PS;
							 END IF;
					WHEN "00100100000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN -- 288
								 pgen_sdgq_blkad_q <= "0001" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0110" AFTER 1 PS;
							 END IF;
					WHEN "00110110000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN --432
								 pgen_sdgq_blkad_q <= "0010" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0101" AFTER 1 PS;
							 END IF;
					WHEN "01001000000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN --576
								 pgen_sdgq_blkad_q <= "0011" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0100" AFTER 1 PS;
							 END IF;
					WHEN "01011010000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN --720
								 pgen_sdgq_blkad_q <= "0100" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0011" AFTER 1 PS;
							 END IF;
					WHEN "01101100000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN --864
								 pgen_sdgq_blkad_q <= "0101" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0010" AFTER 1 PS;
							 END IF;
					WHEN "01111110000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN --1080
								 pgen_sdgq_blkad_q <= "0110" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0001" AFTER 1 PS;
							 END IF;
					WHEN "00000000000" => 
							 pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
							 IF pgen_ns_flip = '0' THEN --0
								 pgen_sdgq_blkad_q <= "0111" AFTER 1 PS;
							 ELSE
								 pgen_sdgq_blkad_q <= "0000" AFTER 1 PS;
							 END IF;
					WHEN OTHERS => 
							 pgen_sdgq_blkmd_q <= "00" AFTER 1 PS;
							 pgen_sdgq_blkad_q <= "0000" AFTER 1 PS;
				END CASE;
				ELSE
					pgen_sdgq_blkmd_q <= "00" AFTER 1 PS;
					pgen_sdgq_blkad_q <= "0000" AFTER 1 PS;
				END IF;
				
			WHEN "10" =>	-- global reset
					IF pgen_row = "10000110111" AND data_valid = '1' THEN
						pgen_sdgq_blkmd_q <= "11" AFTER 1 PS;
						pgen_sdgq_blkad_q <= "1000" AFTER 1 PS;
					ELSE
						pgen_sdgq_blkmd_q <= "00" AFTER 1 PS;
						pgen_sdgq_blkad_q <= "0000" AFTER 1 PS;
					END IF;

			WHEN "11" =>	-- quad block phased reset
			WHEN OTHERS => 
	END CASE;	
   END IF;
END PROCESS;

--tell dmd when to increment row pointer (01) or reset row pointer (11)
PROCESS (clk_g)
BEGIN
   IF clk_g = '1' AND clk_g'event THEN
      IF pgen_row = "0000000000" THEN
         rowmd <= "11" AFTER 1 PS;
      ELSE
         rowmd <= "01" AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

PROCESS (clk_g)
BEGIN
   IF clk_g = '1' AND clk_g'event THEN
      IF data_valid = '1' THEN
         pgen_sdgq_rowmd_q <= rowmd AFTER 1 PS;
      ELSE
         pgen_sdgq_rowmd_q <= "00" AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

END Behavioral;
