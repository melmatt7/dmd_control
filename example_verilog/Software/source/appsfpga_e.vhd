
--------------------------------------------------------------------------------
-- Create Date:    01/09/2008
-- Design Name:    Discovery (DDC4100)
-- Module Name:    appsfpga_e - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the entity for module appsfpga. Top level module 
-- that instantiates appcore and appsfpga_io.
--
-- Dependencies:
--
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2008-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

ENTITY appsfpga IS
    PORT ( clk_i                  : IN STD_LOGIC;
           reset_i                : IN STD_LOGIC;
           finished_iv_o          : OUT STD_LOGIC;

-- DDC4000 interface
           arstz_o                : OUT STD_LOGIC;
           clk_r_o                : OUT STD_LOGIC;
           dout_ap_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dout_an_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dout_bp_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dout_bn_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dout_cp_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dout_cn_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dout_dp_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dout_dn_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           dclk_ap_o              : OUT STD_LOGIC;
           dclk_an_o              : OUT STD_LOGIC;
           dclk_bp_o              : OUT STD_LOGIC;
           dclk_bn_o              : OUT STD_LOGIC;
           dclk_cp_o              : OUT STD_LOGIC;
           dclk_cn_o              : OUT STD_LOGIC;
           dclk_dp_o              : OUT STD_LOGIC;
           dclk_dn_o              : OUT STD_LOGIC;
           dvalid_ap_o            : OUT STD_LOGIC;
           dvalid_an_o            : OUT STD_LOGIC;
           dvalid_bp_o            : OUT STD_LOGIC;
           dvalid_bn_o            : OUT STD_LOGIC;
           dvalid_cp_o            : OUT STD_LOGIC;
           dvalid_cn_o            : OUT STD_LOGIC;
           dvalid_dp_o            : OUT STD_LOGIC;
           dvalid_dn_o            : OUT STD_LOGIC;
           rowmd_o                : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
           rowad_o                : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
           stepvcc_o              : OUT STD_LOGIC;
           comp_data_o            : OUT STD_LOGIC;
           ns_flip_o              : OUT STD_LOGIC;
           blkad_o                : OUT STD_LOGIC_VECTOR(3 downto 0);
           blkmd_o                : OUT STD_LOGIC_VECTOR(1 downto 0);
           wdt_enablez_o          : OUT STD_LOGIC;
           ddc_version_i          : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
           dmd_type_i             : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           pwr_floatz_o           : OUT STD_LOGIC;
           apps_cntl_an           : IN STD_LOGIC;
           apps_cntl_ap           : IN STD_LOGIC;
           rst2blkz_o             : OUT STD_LOGIC;
           ddcspare0              : OUT STD_LOGIC;  -- Load4 (aka ddcspare0)
           
      	--FX2 Interface
	   clk_usb                : IN    STD_LOGIC;
           rdy0	                  : OUT   STD_LOGIC;
           rdy1	                  : OUT   STD_LOGIC;
           rdy2	                  : OUT   STD_LOGIC;
           ctl0	                  : IN    STD_LOGIC;
           ctl1	                  : IN    STD_LOGIC;
           ctl2	                  : IN    STD_LOGIC;
           gpioa_o                : OUT   STD_LOGIC_VECTOR(2 DOWNTO 0);
           gpioa_i                : IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
           gpio_ext_rest_in       : IN    STD_LOGIC;
           gpio_reset_complete_o  : OUT   STD_LOGIC;
           bidir		  : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);                      

--dmd reset active
           in_rst_active_i        : IN STD_LOGIC;

--DDC4000 initializing
           in_init_active_i       : IN STD_LOGIC;
           in_dip_sw_i            : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
           in_pb_sw_i             : IN STD_LOGIC;  --- Power Float PB_sw3
           apps_logic_rstn        : IN STD_LOGIC;  --- Logic Reset PB_sw2
	   
	   apps_testpt            : OUT STD_LOGIC_VECTOR(30 DOWNTO 0)
          );
END appsfpga;

