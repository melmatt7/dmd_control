
--------------------------------------------------------------------------------
-- Create Date:    6/16/05 
-- Design Name:    Discovery (DDC4100)
-- Module Name:    appsfpga_io_e.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the entity for the appsfpga_io module, which creates
--              all clocks for the project and instantiates all necessary clock
--              and output buffers. It also reads the dip switch inputs and
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


ENTITY appsfpga_io IS
PORT (
--clock and reset
      clk_i                           : IN  STD_LOGIC;
      pwrgdz                          : IN  STD_LOGIC;

--other control signals
      in_init_active_i                : IN  STD_LOGIC;
      in_dip_sw_i                     : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
      in_pb_sw_i                      : IN  STD_LOGIC;
      in_dmd_type                     : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0 );

--signals to be made into LVDS
      appcore_data_valid_q            : IN  STD_LOGIC;
      appcore_dout_a_q                : IN  STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_b_q                : IN  STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_c_q                : IN  STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_d_q                : IN  STD_LOGIC_VECTOR (63 DOWNTO 0);

-- single ended control signals
      appcore_rowmd_q                 : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
      appcore_rowad_q                 : IN  STD_LOGIC_VECTOR (10 DOWNTO 0);
      appcore_blkad_q                 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
      appcore_blkmd_q                 : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
      appsfpga_io_rowmd_q             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      appsfpga_io_rowad_q             : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      appsfpga_io_blkad_q             : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      appsfpga_io_blkmd_q             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);

--global and reference clock
      clk_g                           : OUT STD_LOGIC;
      arst_gq                         : OUT STD_LOGIC;
      clk_r_o                         : OUT STD_LOGIC;

pll_speed_info      : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

--DCM locked (active low global reset) and initialization active for Spartan part
--      appsfpga_io_locked              : OUT STD_LOGIC;
--      appsfpga_io_init_active         : OUT STD_LOGIC;
      pll_locked_rstz_gq              : OUT STD_LOGIC;
      init_active_gq                  : OUT STD_LOGIC;

--LVDS outputs
      appsfpga_io_dout_ap             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_an             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_bp             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_bn             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_cp             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_cn             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_dp             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_dn             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dclk_ap             : OUT STD_LOGIC;
      appsfpga_io_dclk_an             : OUT STD_LOGIC;
      appsfpga_io_dclk_bp             : OUT STD_LOGIC;
      appsfpga_io_dclk_bn             : OUT STD_LOGIC;
      appsfpga_io_dclk_cp             : OUT STD_LOGIC;
      appsfpga_io_dclk_cn             : OUT STD_LOGIC;
      appsfpga_io_dclk_dp             : OUT STD_LOGIC;
      appsfpga_io_dclk_dn             : OUT STD_LOGIC;
      appsfpga_io_dvalid_ap           : OUT STD_LOGIC;
      appsfpga_io_dvalid_an           : OUT STD_LOGIC;
      appsfpga_io_dvalid_bp           : OUT STD_LOGIC;
      appsfpga_io_dvalid_bn           : OUT STD_LOGIC;
      appsfpga_io_dvalid_cp           : OUT STD_LOGIC;
      appsfpga_io_dvalid_cn           : OUT STD_LOGIC;
      appsfpga_io_dvalid_dp           : OUT STD_LOGIC;
      appsfpga_io_dvalid_dn           : OUT STD_LOGIC;

--user inputs
      appsfpga_io_comp_data_en_q      : OUT STD_LOGIC;
      appsfpga_io_ns_flip_en_q        : OUT STD_LOGIC;
      appsfpga_io_cnthalt_q           : OUT STD_LOGIC;
      appsfpga_io_reset_type_q        : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      appsfpga_io_rowaddrmode_q       : OUT STD_LOGIC;
      appsfpga_io_WDT_enbl_q          : OUT STD_LOGIC;
      appsfpga_io_STEP_VCC_enbl_q     : OUT STD_LOGIC;
      appsfpga_io_pwr_floatz_q        : OUT STD_LOGIC;
      appsfpga_io_float_q             : OUT STD_LOGIC
   );
END appsfpga_io;
