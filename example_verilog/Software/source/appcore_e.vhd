--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    appcore_e.vhd - Behavioral
-- Project Name:   appsfpga (Applications FPGA)
-- Description: This is the entity for module appcore, which simply
--              instantiates the level 2 modules pgen and cnts.
--
-- Dependencies:
--
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

ENTITY appcore IS
PORT (
--clock and reset
      clk_g                      : IN STD_LOGIC;
      pll_locked_rstz_gq         : IN STD_LOGIC;
      init_active_gq             : IN STD_LOGIC;
      in_ddc_version             : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

pll_speed_info      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);

--user inputs
      appsfpga_io_comp_data_en_q : IN STD_LOGIC;
      appsfpga_io_ns_flip_en_q   : IN STD_LOGIC;
      appsfpga_io_cnthalt_q      : IN STD_LOGIC;
      appsfpga_io_reset_type_q   : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--      appsfpga_io_init_active    : IN STD_LOGIC;
      appsfpga_io_rowaddrmode_q  : IN STD_LOGIC;
      appsfpga_io_WDT_enbl_q     : IN STD_LOGIC;
      appsfpga_io_STEP_VCC_enbl_q: IN STD_LOGIC;
      appsfpga_io_float_q        : IN STD_LOGIC;
      in_dmd_type                : IN STD_LOGIC_VECTOR( 3 DOWNTO 0 );

--data and control output values
      appcore_data_valid_q       : OUT STD_LOGIC;
      appcore_dout_a_q           : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_b_q           : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_c_q           : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_d_q           : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_rowmd_q            : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      appcore_rowad_q            : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      appcore_blkad_q            : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      appcore_blkmd_q            : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);

--outputs determined by user inputs
      appcore_comp_data_q        : OUT STD_LOGIC;
      appcore_ns_flip_q          : OUT STD_LOGIC;
      appcore_STEP_VCC_q         : OUT STD_LOGIC;
      appcore_rst2blkz_q         : OUT STD_LOGIC;
      appscore_pwr_floatz_q      : OUT STD_LOGIC;
      appcore_load4z_q           : OUT STD_LOGIC;
      
   -- USB/gui signals      
      clk_usb                    : IN STD_LOGIC;
      reset_i                    : IN STD_LOGIC;
      rdy0                       : OUT STD_LOGIC;
      rdy1                       : OUT STD_LOGIC;
      rdy2                       : OUT STD_LOGIC;
      ctl0                       : IN STD_LOGIC;
      ctl1                       : IN STD_LOGIC;
      ctl2                       : IN STD_LOGIC;
      gpioa_o                    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      gpioa_i                    : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      gpio_ext_rest_in           : IN STD_LOGIC;
      gpio_reset_complete_o      : OUT STD_LOGIC;
      bidir                      : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)          
      );
END appcore;
