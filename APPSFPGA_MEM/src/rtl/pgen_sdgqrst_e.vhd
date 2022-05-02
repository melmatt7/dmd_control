--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_sdgqrst_e.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the entity for the module pgen_sdgqrst, which will 
--              create signals unique to operation in the dual block phased 
--              reset mode including row valid, row mode, block mode, block 
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

ENTITY pgen_sdgqrst IS
PORT (
--global clock and reset
      clk_g                      : IN STD_LOGIC;
      appsfpga_io_locked         : IN STD_LOGIC;
      
--enabling bits
      cnts_active_cnten_q        : IN STD_LOGIC;
      pgen_row                   : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      pgen_ns_flip               : IN STD_LOGIC;
		pgen_reset_type_q            : IN STD_LOGIC_VECTOR (1 DOWNTO 0) ;
      
--control signal outputs
      pgen_sdgq_row_valid_q         : OUT STD_LOGIC;
      pgen_sdgq_rowmd_q             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_sdgq_blkad_q           : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_sdgq_blkmd_q           : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_sdgq_data_valid_q      : OUT STD_LOGIC
      );
END pgen_sdgqrst;

