--------------------------------------------------------------------------------
-- Create Date:    6/16/05 
-- Design Name:    Discovery (DDC4100)
-- Module Name:    cnts_e.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the entity for module cnts, which contains all
--              counters needed to control timing of output signals.
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

ENTITY cnts IS
PORT (
--clock and reset
      clk_g                   : IN STD_LOGIC;
      locked_init_rstz_gq     : IN STD_LOGIC;
--stop counter
      appsfpga_io_cnthalt_q   : IN STD_LOGIC;
      in_dmd_type             : IN STD_LOGIC_VECTOR( 3 DOWNTO 0 );

      dvalid_space_info   : OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);

--active, blank, and pattern counters and enable signals
      cnts_active_cnt_q       : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
      cnts_active_cnten_q     : OUT STD_LOGIC;
      cnts_pattern_cnt_q      : OUT STD_LOGIC_VECTOR (26 DOWNTO 0)
      );
END cnts;

