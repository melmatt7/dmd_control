--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_pgq_e.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the entity for the module pgen_pgq, which will
--              create signals unique to operation in the quad block phased
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
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

ENTITY pgen_pgq IS
PORT (
--global clock and reset
      clk_g                      : IN STD_LOGIC;
      locked_init_rstz_gq        : IN STD_LOGIC;

--enabling bits
      cnts_active_cnten_q        : IN STD_LOGIC;
      pgen_row                   : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      pgen_ns_flip               : IN STD_LOGIC;

      WL_count                   : IN STD_LOGIC_VECTOR( 5 DOWNTO 0 );
      BSA_count                  : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
      row_count                  : IN STD_LOGIC_VECTOR(10 DOWNTO 0 );

--control signal outputs
      pgen_pgq_row_valid         : OUT STD_LOGIC;
      pgen_pgq_rowmd             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgq_blkad_q           : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_pgq_blkmd_q           : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgq_data_valid_q      : OUT STD_LOGIC
      );
END pgen_pgq;

