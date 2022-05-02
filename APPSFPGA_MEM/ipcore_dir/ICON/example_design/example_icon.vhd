------------------------------------------------------------------------------
--$Date: 2011/06/17 08:48:09 $
--$RCSfile: example_design_vhd.ejava,v $
--$Revision: 1.1 $
------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version : 1.06
--  \   \         Application : ICON V1.06a
--  /   /         Filename : example_icon.vhd
-- /___/   /\     
-- \   \  /  \ 
--  \___\/\___\
--
-- (c) Copyright 2010 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity example_ICON is
end example_ICON;

architecture icon_arch of example_ICON is

  component ICON
    port (
      CONTROL0 : inout std_logic_vector(35 downto 0);
      CONTROL1 : inout std_logic_vector(35 downto 0)
    );
  end component;

  component chipscope_vio
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      ASYNC_IN : in std_logic_vector(7 downto 0)
    );
  end component;
  -------------------------------------------------------------------
  --  Local Signals
  -------------------------------------------------------------------
  signal control0 : std_logic_vector(35 downto 0);
  signal control1 : std_logic_vector(35 downto 0);

 
begin

  -------------------------------------------------------------------
  --
  --  ICON Pro core instance
  --
  -------------------------------------------------------------------

  ICON_inst:  ICON
    port map (
      CONTROL0 => control0, -- INOUT BUS [35:0] 
      CONTROL1 => control1 -- INOUT BUS [35:0] 
    );
  
  -------------------------------------------------------------------
  --
  --  VIO Pro core instance
  --
  -------------------------------------------------------------------

  -- For Control Port0
  VIO_inst0:  chipscope_vio
    port map (
      CONTROL => control0, -- INOUT BUS [35:0]
      ASYNC_IN => "00000001" -- IN BUS [7:0]
    );
  -- For Control Port1
  VIO_inst1:  chipscope_vio
    port map (
      CONTROL => control1, -- INOUT BUS [35:0]
      ASYNC_IN => "00000010" -- IN BUS [7:0]
    );

end icon_arch;

