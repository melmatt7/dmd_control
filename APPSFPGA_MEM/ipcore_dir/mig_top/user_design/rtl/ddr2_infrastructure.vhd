--*****************************************************************************
-- DISCLAIMER OF LIABILITY
--
-- This file contains proprietary and confidential information of
-- Xilinx, Inc. ("Xilinx"), that is distributed under a license
-- from Xilinx, and may be used, copied and/or disclosed only
-- pursuant to the terms of a valid license agreement with Xilinx.
--
-- XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
-- ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
-- EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
-- LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
-- MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
-- does not warrant that functions included in the Materials will
-- meet the requirements of Licensee, or that the operation of the
-- Materials will be uninterrupted or error-free, or that defects
-- in the Materials will be corrected. Furthermore, Xilinx does
-- not warrant or make any representations regarding use, or the
-- results of the use, of the Materials in terms of correctness,
-- accuracy, reliability or otherwise.
--
-- Xilinx products are not designed or intended to be fail-safe,
-- or for use in any application requiring fail-safe performance,
-- such as life-support or safety devices or systems, Class III
-- medical devices, nuclear facilities, applications related to
-- the deployment of airbags, or any other applications that could
-- lead to death, personal injury or severe property or
-- environmental damage (individually and collectively, "critical
-- applications"). Customer assumes the sole risk and liability
-- of any use of Xilinx products in critical applications,
-- subject only to applicable laws and regulations governing
-- limitations on product liability.
--
-- Copyright 2006, 2007, 2008 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
--*****************************************************************************
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: 3.6.1
--  \   \         Application: MIG
--  /   /         Filename: ddr2_infrastructure.vhd
-- /___/   /\     Date Last Modified: $Date: 2010/11/26 18:26:03 $
-- \   \  /  \    Date Created: Wed Jan 10 2007
--  \___\/\___\
--
--Device: Virtex-5
--Design Name: DDR2
--Purpose:
--   Clock distribution and reset synchronization
--Reference:
--Revision History:
--   Rev 1.1 - Port name changed from dcm_lock to locked. PK. 10/14/08
--*****************************************************************************


library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;

entity ddr2_infrastructure is
  generic (
    RST_ACT_LOW   : integer := 1
    );
  port (
    clk0            : in std_logic;
    clk90           : in std_logic;
    clk200          : in std_logic;
    clkdiv0         : in std_logic;
    locked          : in std_logic;

    sys_rst_n       : in  std_logic;
    idelay_ctrl_rdy : in  std_logic;
    rst0            : out std_logic;
    rst90           : out std_logic;
    rst200          : out std_logic;
    rstdiv0         : out std_logic
    );
end entity ddr2_infrastructure;

architecture syn of ddr2_infrastructure is

  -- # of clock cycles to delay deassertion of reset. Needs to be a fairly
  -- high number not so much for metastability protection, but to give time
  -- for reset (i.e. stable clock cycles) to propagate through all state
  -- machines and to all control signals (i.e. not all control signals have
  -- resets, instead they rely on base state logic being reset, and the effect
  -- of that reset propagating through the logic). Need this because we may not
  -- be getting stable clock cycles while reset asserted (i.e. since reset
  -- depends on DCM/PLL lock status)
  constant RST_SYNC_NUM  : integer := 25;

  signal rst0_sync_r    : std_logic_vector(RST_SYNC_NUM-1 downto 0);
  signal rst200_sync_r  : std_logic_vector(RST_SYNC_NUM-1 downto 0);
  signal rst90_sync_r   : std_logic_vector(RST_SYNC_NUM-1 downto 0);
  signal rstdiv0_sync_r : std_logic_vector((RST_SYNC_NUM/2)-1 downto 0);
  signal rst_tmp        : std_logic;
  signal sys_clk_ibufg  : std_logic;
  signal sys_rst        : std_logic;

  attribute max_fanout : string;
  attribute syn_maxfan : integer;
  attribute max_fanout of rst0_sync_r    : signal is "10";
  attribute syn_maxfan of rst0_sync_r    : signal is 10;
  attribute max_fanout of rst200_sync_r  : signal is "10";
  attribute syn_maxfan of rst200_sync_r  : signal is 10;
  attribute max_fanout of rst90_sync_r   : signal is "10";
  attribute syn_maxfan of rst90_sync_r   : signal is 10;
  attribute max_fanout of rstdiv0_sync_r : signal is "10";
  attribute syn_maxfan of rstdiv0_sync_r : signal is 10;

begin

  sys_rst <= not(sys_rst_n) when (RST_ACT_LOW /= 0) else sys_rst_n;

  --***************************************************************************
  -- Reset synchronization
  -- NOTES:
  --   1. shut down the whole operation if the DCM/PLL hasn't yet locked (and
  --      by inference, this means that external SYS_RST_IN has been asserted -
  --      DCM/PLL deasserts LOCKED as soon as SYS_RST_IN asserted)
  --   2. In the case of all resets except rst200, also assert reset if the
  --      IDELAY master controller is not yet ready
  --   3. asynchronously assert reset. This was we can assert reset even if
  --      there is no clock (needed for things like 3-stating output buffers).
  --      reset deassertion is synchronous.
  --***************************************************************************

  rst_tmp <= sys_rst or not(locked) or not(idelay_ctrl_rdy);

  process (clk0, rst_tmp)
  begin
    if (rst_tmp = '1') then
      rst0_sync_r <= (others => '1');
    elsif (rising_edge(clk0)) then
      -- logical left shift by one (pads with 0)
      rst0_sync_r <= rst0_sync_r(RST_SYNC_NUM-2 downto 0) & '0';
    end if;
  end process;

  process (clkdiv0, rst_tmp)
  begin
    if (rst_tmp = '1') then
      rstdiv0_sync_r <= (others => '1');
    elsif (rising_edge(clkdiv0)) then
      -- logical left shift by one (pads with 0)
      rstdiv0_sync_r <= rstdiv0_sync_r((RST_SYNC_NUM/2)-2 downto 0) & '0';
    end if;
  end process;

  process (clk90, rst_tmp)
  begin
    if (rst_tmp = '1') then
      rst90_sync_r <= (others => '1');
    elsif (rising_edge(clk90)) then
      rst90_sync_r <= rst90_sync_r(RST_SYNC_NUM-2 downto 0) & '0';
    end if;
  end process;

  -- make sure CLK200 doesn't depend on IDELAY_CTRL_RDY, else chicken n' egg
  process (clk200, locked)
  begin
    if ((not(locked)) = '1') then
      rst200_sync_r <= (others => '1');
    elsif (rising_edge(clk200)) then
      rst200_sync_r <= rst200_sync_r(RST_SYNC_NUM-2 downto 0) & '0';
    end if;
  end process;

  rst0    <= rst0_sync_r(RST_SYNC_NUM-1);
  rst90   <= rst90_sync_r(RST_SYNC_NUM-1);
  rst200  <= rst200_sync_r(RST_SYNC_NUM-1);
  rstdiv0 <= rstdiv0_sync_r((RST_SYNC_NUM/2)-1);

end architecture syn;


