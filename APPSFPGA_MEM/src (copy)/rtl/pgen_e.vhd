--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_e.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the entity for the pattern generation (pgen) module.
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

ENTITY pgen IS
PORT (
--global clock and reset
      clk_g                        : IN STD_LOGIC;
--      appsfpga_io_locked           : IN STD_LOGIC;
      locked_init_rstz_gq          : IN STD_LOGIC;
      pll_locked_rstz_gq           : IN STD_LOGIC;
      init_active_gq               : IN STD_LOGIC;

--counter values and enables
      cnts_active_cnt_q            : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
      cnts_active_cnten_q          : IN STD_LOGIC;
      cnts_pattern_cnt_q           : IN STD_LOGIC_VECTOR (26 DOWNTO 0);

--user inputs
      appsfpga_io_comp_data_en_q   : IN STD_LOGIC;
      appsfpga_io_ns_flip_en_q     : IN STD_LOGIC;
      appsfpga_io_reset_type_q     : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
--      appsfpga_io_init_active      : IN STD_LOGIC;
      appsfpga_io_rowaddrmode_q    : IN STD_LOGIC;
      appsfpga_io_WDT_enbl_q       : IN STD_LOGIC;
      appsfpga_io_STEP_VCC_enbl_q  : IN STD_LOGIC;
      appsfpga_io_float_q          : IN STD_LOGIC;
      in_dmd_type                  : IN STD_LOGIC_VECTOR( 3 DOWNTO 0 );
      -- new usb from gui
      usb_pattern_force            : IN STD_LOGIC;
      usb_pattern_nmbr             : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

--data and control signal outputs
      pgen_data_valid_q            : OUT STD_LOGIC;
      pgen_dout_a_q                : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_dout_b_q                : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_dout_c_q                : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_dout_d_q                : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_rowmd_q                 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_rowad_q                 : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      pgen_blkad_q                 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_blkmd_q                 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_STEP_VCC_q              : OUT STD_LOGIC;

--user input associated outputs
      pgen_comp_data_q             : OUT STD_LOGIC;
      pgen_ns_flip_q               : OUT STD_LOGIC;
      pgen_rst2blkz_q              : OUT STD_LOGIC
      );
END pgen;

