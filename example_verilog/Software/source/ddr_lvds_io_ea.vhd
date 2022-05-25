
--------------------------------------------------------------------------------
-- Create Date:    7/8/08 
-- Design Name:    Discovery (DDC4100)
-- Module Name:    ddr_lvds_io_ea.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture and entity for module ddr_lvds_io. This module maps
-- an 4 input values to an value through a 4 to 1 OSERDES and outputs a lvds pair
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2008-2016 Texas Instruments Incorporated 
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

ENTITY ddr_lvds_io IS
PORT (
      d1					: IN STD_LOGIC;	-- clock 0 rising edge
      d2					: IN STD_LOGIC;	-- clock 0 falling edge
      d3					: IN STD_LOGIC;	-- clock 1 rising edge
      d4					: IN STD_LOGIC;	-- clock 1 falling edge
		dout_dpp			: OUT STD_LOGIC;
		dout_dpn       : OUT STD_LOGIC;
      clk2X				: IN STD_LOGIC;	-- freq=2x
		clk1X         : IN STD_LOGIC;	-- freq=x
      reset          : IN STD_LOGIC
      );
END ddr_lvds_io;


ARCHITECTURE Behavioral  OF ddr_lvds_io IS

SIGNAL      dout                       : STD_LOGIC;

BEGIN
		

			
	OSERDES_TX_DATA_d : OSERDES 
	  GENERIC MAP(
		  DATA_RATE_OQ => "DDR", DATA_RATE_TQ => "DDR",  DATA_WIDTH => 4, 
		  INIT_OQ => '0', INIT_TQ => '0', SERDES_MODE => "MASTER", 
		  SRVAL_OQ => '0', SRVAL_TQ => '0', TRISTATE_WIDTH => 4)

		PORT MAP (
			OQ => dout,
			SHIFTOUT1 => open,
			SHIFTOUT2 => open,
			TQ => open,
			CLK => clk2X,
			CLKDIV => clk1X,
			D1 => d1,
			D2 => d2,
			D3 => d3,
			D4 => d4,
			D5 => '0',
			D6 => '0',
			OCE => '1',
			REV => '0',
			SHIFTIN1 => '0',
			SHIFTIN2 => '0',
			SR => reset,
			T1 => '0',
			T2 => '0',
			T3 => '0',
			T4 => '0',
			TCE => '0');   
	
	obuftds_inst_dvalid : obufds
	GENERIC MAP (
		iostandard => "LVDS_25")
		PORT MAP (
			o  => dout_dpp,   -- diff_p output (connect directly to top-level port)
			ob => dout_dpn,   -- diff_n output (connect directly to top-level port)
			i  => dout    -- buffer input
			);

END Behavioral;
