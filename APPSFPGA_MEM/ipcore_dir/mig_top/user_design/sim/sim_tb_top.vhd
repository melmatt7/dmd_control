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
-- /___/  \  /   Vendor             : Xilinx
-- \   \   \/    Version            : 3.6.1
--  \   \        Application        : MIG
--  /   /        Filename           : sim_tb_top.vhd
-- /___/   /\    Date Last Modified : $Date: 2010/11/26 18:26:02 $
-- \   \  /  \   Date Created       : Mon May 14 2007
--  \___\/\___\
--
-- Device      : Virtex-5
-- Design Name : DDR2
-- Purpose     : This is the simulation testbench which is used to verify the
--               design. The basic clocks and resets to the interface are
--               generated here. This also connects the memory interface to the
--               memory model.
-- Reference:
-- Revision History:
--*****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;

entity sim_tb_top is

end entity sim_tb_top;

architecture arch of sim_tb_top is

  -- memory controller parameters
  constant BANK_WIDTH            : integer := 3;      -- # of memory bank addr bits
  constant CKE_WIDTH             : integer := 2;      -- # of memory clock enable outputs
  constant CLK_WIDTH             : integer := 2;      -- # of clock outputs
  constant CLK_TYPE              : string  := "SINGLE_ENDED";       -- # of clock type
  constant COL_WIDTH             : integer := 10;     -- # of memory column bits
  constant CS_NUM                : integer := 2;      -- # of separate memory chip selects
  constant CS_WIDTH              : integer := 2;      -- # of total memory chip selects
  constant CS_BITS               : integer := 1;      -- set to log2(CS_NUM) (rounded up)
  constant DM_WIDTH              : integer := 8;      -- # of data mask bits
  constant DQ_WIDTH              : integer := 64;     -- # of data width
  constant DQ_PER_DQS            : integer := 8;      -- # of DQ data bits per strobe
  constant DQ_BITS               : integer := 6;      -- set to log2(DQS_WIDTH*DQ_PER_DQS)
  constant DQS_WIDTH             : integer := 8;      -- # of DQS strobes
  constant DQS_BITS              : integer := 3;      -- set to log2(DQS_WIDTH)
  constant HIGH_PERFORMANCE_MODE : boolean := TRUE; -- Sets the performance mode for IODELAY elements
  constant ODT_WIDTH             : integer := 2;      -- # of memory on-die term enables
  constant ROW_WIDTH             : integer := 14;     -- # of memory row & # of addr bits
  constant APPDATA_WIDTH         : integer := 128;     -- # of usr read/write data bus bits
  constant ADDITIVE_LAT          : integer := 0;      -- additive write latency
  constant BURST_LEN             : integer := 4;      -- burst length (in double words)
  constant BURST_TYPE            : integer := 0;      -- burst type (=0 seq; =1 interlved)
  constant CAS_LAT               : integer := 3;      -- CAS latency
  constant ECC_ENABLE            : integer := 0;      -- enable ECC (=1 enable)
  constant MULTI_BANK_EN         : integer := 1;      -- enable bank management
  constant TWO_T_TIME_EN         : integer := 1;      -- 2t timing for unbuffered dimms
  constant ODT_TYPE              : integer := 1;      -- ODT (=0(none),=1(75),=2(150),=3(50))
  constant REDUCE_DRV            : integer := 0;      -- reduced strength mem I/O (=1 yes)
  constant REG_ENABLE            : integer := 0;      -- registered addr/ctrl (=1 yes)
  constant TREFI_NS              : integer := 7800;   -- auto refresh interval (ns)
  constant TRAS                  : integer := 40000;  -- active->precharge delay
  constant TRCD                  : integer := 15000;  -- active->read/write delay
  constant TRFC                  : integer := 127500;  -- ref->ref, ref->active delay
  constant TRP                   : integer := 15000;  -- precharge->command delay
  constant TRTP                  : integer := 7500;   -- read->precharge delay
  constant TWR                   : integer := 15000;  -- used to determine wr->prech
  constant TWTR                  : integer := 7500;  -- write->read delay
  constant SIM_ONLY              : integer := 1;      -- = 0 to allow power up delay
  constant DEBUG_EN              : integer := 0;      -- Enable debug signals/controls
  constant RST_ACT_LOW           : integer := 1;      -- =1 for active low reset, =0 for active high
  constant DLL_FREQ_MODE         : string  := "HIGH"; -- DCM Frequency range
  constant CLK_PERIOD            : integer := 6666;   -- Core/Mem clk period (in ps)

  constant DEVICE_WIDTH    : integer := 8;      -- Memory device data width
  constant CLK_PERIOD_NS   : real := 6666.0 / 1000.0;
  constant TCYC_SYS        : real := CLK_PERIOD_NS/2.0;
  constant TCYC_SYS_0      : time := CLK_PERIOD_NS * 1 ns;
  constant TCYC_SYS_DIV2   : time := TCYC_SYS * 1 ns;
  constant TEMP2           : real := 5.0/2.0;
  constant TCYC_200        : time := TEMP2 * 1 ns;
  constant TPROP_DQS          : time := 0.01 ns;  -- Delay for DQS signal during Write Operation
  constant TPROP_DQS_RD       : time := 0.01 ns;  -- Delay for DQS signal during Read Operation
  constant TPROP_PCB_CTRL     : time := 0.01 ns;  -- Delay for Address and Ctrl signals
  constant TPROP_PCB_DATA     : time := 0.01 ns;  -- Delay for data signal during Write operation
  constant TPROP_PCB_DATA_RD  : time := 0.01 ns;  -- Delay for data signal during Read operation

  constant CLK_PERIOD_INT : integer := CLK_PERIOD/1000;

  -- By default this Parameter (CLK_GENERATOR) value is "PLL". If this Parameter
  -- is set to "PLL", PLL is used to generate the design clocks.
  -- If this Parameter is set to "DCM",
  -- DCM is used to generate the design clocks.
  constant CLK_GENERATOR : string := "PLL";

  component mig_top is
    generic (
      BANK_WIDTH            : integer;
      CKE_WIDTH             : integer;
      CLK_WIDTH             : integer;
      COL_WIDTH             : integer;
      CS_NUM                : integer;
      CS_WIDTH              : integer;
      CS_BITS               : integer;
      DM_WIDTH              : integer;
      DQ_WIDTH              : integer;
      DQ_PER_DQS            : integer;
      DQ_BITS               : integer;
      DQS_WIDTH             : integer;
      DQS_BITS              : integer;
      HIGH_PERFORMANCE_MODE : boolean;
      ODT_WIDTH             : integer;
      ROW_WIDTH             : integer;
      APPDATA_WIDTH         : integer;
      ADDITIVE_LAT          : integer;
      BURST_LEN             : integer;
      BURST_TYPE            : integer;
      CAS_LAT               : integer;
      ECC_ENABLE            : integer;
      MULTI_BANK_EN         : integer;
      ODT_TYPE              : integer;
      REDUCE_DRV            : integer;
      REG_ENABLE            : integer;
      TREFI_NS              : integer;
      TRAS                  : integer;
      TRCD                  : integer;
      TRFC                  : integer;
      TRP                   : integer;
      TRTP                  : integer;
      TWR                   : integer;
      TWTR                  : integer;
      SIM_ONLY              : integer;
      RST_ACT_LOW           : integer;
      CLK_PERIOD            : integer
      );
    port (
      sys_rst_n             : in    std_logic;
      clk0                  : in    std_logic;
      clk90                 : in    std_logic;
      clk200                : in    std_logic;
      clkdiv0               : in    std_logic;
      locked                : in    std_logic;
      ddr2_a                : out   std_logic_vector((ROW_WIDTH-1) downto 0);
      ddr2_ba               : out   std_logic_vector((BANK_WIDTH-1) downto 0);
      ddr2_ras_n            : out   std_logic;
      ddr2_cas_n            : out   std_logic;
      ddr2_we_n             : out   std_logic;
      ddr2_cs_n             : out   std_logic_vector((CS_WIDTH-1) downto 0);
      ddr2_odt              : out   std_logic_vector((ODT_WIDTH-1) downto 0);
      ddr2_cke              : out   std_logic_vector((CKE_WIDTH-1) downto 0);
      ddr2_ck               : out   std_logic_vector((CLK_WIDTH-1) downto 0);
      ddr2_ck_n             : out   std_logic_vector((CLK_WIDTH-1) downto 0);
      ddr2_dq               : inout std_logic_vector((DQ_WIDTH-1) downto 0);
      ddr2_dqs              : inout std_logic_vector((DQS_WIDTH-1) downto 0);
      ddr2_dqs_n            : inout std_logic_vector((DQS_WIDTH-1) downto 0);
      ddr2_dm               : out   std_logic_vector((DM_WIDTH-1) downto 0);
      
      clk0_tb               : out   std_logic;
      rst0_tb               : out   std_logic;
      app_af_afull          : out   std_logic;
      app_wdf_afull         : out   std_logic;
      rd_data_valid         : out   std_logic;
      rd_data_fifo_out      : out   std_logic_vector(APPDATA_WIDTH-1 downto 0);
      app_af_wren           : in    std_logic;
      app_af_cmd            : in    std_logic_vector(2 downto 0);
      app_af_addr           : in    std_logic_vector(30 downto 0);
      app_wdf_wren          : in    std_logic;
      app_wdf_data          : in    std_logic_vector(APPDATA_WIDTH-1 downto 0);
      app_wdf_mask_data     : in    std_logic_vector(((APPDATA_WIDTH/8)-1) downto 0);
      
      phy_init_done         : out   std_logic
      );
  end component;

  component ddr2_model is
    port (
      ck      : in    std_logic;
      ck_n    : in    std_logic;
      cke     : in    std_logic;
      cs_n    : in    std_logic;
      ras_n   : in    std_logic;
      cas_n   : in    std_logic;
      we_n    : in    std_logic;
      dm_rdqs : inout std_logic_vector((DEVICE_WIDTH/16) downto 0);
      ba      : in    std_logic_vector((BANK_WIDTH - 1) downto 0);
      addr    : in    std_logic_vector((ROW_WIDTH - 1) downto 0);
      dq      : inout std_logic_vector((DEVICE_WIDTH - 1) downto 0);
      dqs     : inout std_logic_vector((DEVICE_WIDTH/16) downto 0);
      dqs_n   : inout std_logic_vector((DEVICE_WIDTH/16) downto 0);
      rdqs_n  : out   std_logic_vector((DEVICE_WIDTH/16) downto 0);
      odt     : in    std_logic
      );
  end component;

  component WireDelay
    generic (
      Delay_g : time;
      Delay_rd : time);
    port (
      A : inout Std_Logic;
      B : inout Std_Logic;
     reset : in Std_Logic);
  end component;

  component ddr2_tb_top is
    generic (
      BANK_WIDTH        : integer;
      COL_WIDTH         : integer;
      DM_WIDTH          : integer;
      DQ_WIDTH          : integer;
      ROW_WIDTH         : integer;
      APPDATA_WIDTH     : integer;
      ECC_ENABLE        : integer;
      BURST_LEN         : integer
      );
    port (
      clk0              : in  std_logic;
      rst0              : in  std_logic;
      app_af_afull      : in  std_logic;
      app_wdf_afull     : in  std_logic;
      rd_data_valid     : in  std_logic;
      rd_data_fifo_out  : in  std_logic_vector(APPDATA_WIDTH-1 downto 0);
      phy_init_done     : in  std_logic;
      app_af_wren       : out std_logic;
      app_af_cmd        : out std_logic_vector(2 downto 0);
      app_af_addr       : out std_logic_vector(30 downto 0);
      app_wdf_wren      : out std_logic;
      app_wdf_data      : out std_logic_vector(APPDATA_WIDTH-1 downto 0);
      app_wdf_mask_data : out std_logic_vector(((APPDATA_WIDTH/8)-1) downto 0);
      error             : out std_logic
      );
  end component;

  signal sys_clk                  : std_logic := '0';
  signal sys_clk_n                : std_logic;
  signal sys_clk_p                : std_logic;
  signal sys_clk200               : std_logic:= '0';
  signal clk200_n                 : std_logic;
  signal clk200_p                 : std_logic;
  signal sys_rst_n                : std_logic := '0';
  signal sys_rst_out              : std_logic;
  signal sys_rst_i                : std_logic;
  signal gnd                      : std_logic_vector(1 downto 0);

  signal ddr2_dq_sdram            : std_logic_vector((DQ_WIDTH - 1) downto 0);
  signal ddr2_dqs_sdram           : std_logic_vector((DQS_WIDTH - 1) downto 0);
  signal ddr2_dqs_n_sdram         : std_logic_vector((DQS_WIDTH - 1) downto 0);
  signal ddr2_dm_sdram            : std_logic_vector((DM_WIDTH - 1) downto 0);
  signal ddr2_clk_sdram           : std_logic_vector((CLK_WIDTH - 1) downto 0);
  signal ddr2_clk_n_sdram         : std_logic_vector((CLK_WIDTH - 1) downto 0);
  signal ddr2_address_sdram       : std_logic_vector((ROW_WIDTH - 1) downto 0);
  signal ddr2_ba_sdram            : std_logic_vector((BANK_WIDTH - 1) downto 0);
  signal ddr2_ras_n_sdram         : std_logic;
  signal ddr2_cas_n_sdram         : std_logic;
  signal ddr2_we_n_sdram          : std_logic;
  signal ddr2_cs_n_sdram          : std_logic_vector((CS_WIDTH - 1) downto 0);
  signal ddr2_cke_sdram           : std_logic_vector((CKE_WIDTH - 1) downto 0);
  signal ddr2_odt_sdram           : std_logic_vector((ODT_WIDTH - 1) downto 0);
  signal error                    : std_logic;
  signal phy_init_done            : std_logic;
  

  -- Only RDIMM memory parts support the reset signal,
  -- hence the ddr2_reset_n_sdram and ddr2_reset_n_fpga signals can be
  -- ignored for other memory parts
  signal ddr2_reset_n_sdram       : std_logic;
  signal ddr2_reset_n_fpga        : std_logic;
  signal ddr2_address_reg         : std_logic_vector((ROW_WIDTH - 1) downto 0);
  signal ddr2_ba_reg              : std_logic_vector((BANK_WIDTH - 1) downto 0);
  signal ddr2_cke_reg             : std_logic_vector((CKE_WIDTH - 1) downto 0);
  signal ddr2_ras_n_reg           : std_logic;
  signal ddr2_cas_n_reg           : std_logic;
  signal ddr2_we_n_reg            : std_logic;
  signal ddr2_cs_n_reg            : std_logic_vector((CS_WIDTH - 1) downto 0);
  signal ddr2_odt_reg             : std_logic_vector((ODT_WIDTH - 1) downto 0);

  signal dq_vector                : std_logic_vector(15 downto 0);
  signal dqs_vector               : std_logic_vector(1 downto 0);
  signal dqs_n_vector             : std_logic_vector(1 downto 0);
  signal dm_vector                : std_logic_vector(1 downto 0);
  signal command                  : std_logic_vector(2 downto 0);
  signal enable                   : std_logic;
  signal enable_o                 : std_logic;
  signal ddr2_dq_fpga             : std_logic_vector((DQ_WIDTH - 1) downto 0);
  signal ddr2_dqs_fpga            : std_logic_vector((DQS_WIDTH - 1) downto 0);
  signal ddr2_dqs_n_fpga          : std_logic_vector((DQS_WIDTH - 1) downto 0);
  signal ddr2_dm_fpga             : std_logic_vector((DM_WIDTH - 1) downto 0);
  signal ddr2_clk_fpga            : std_logic_vector((CLK_WIDTH - 1) downto 0);
  signal ddr2_clk_n_fpga          : std_logic_vector((CLK_WIDTH - 1) downto 0);
  signal ddr2_address_fpga        : std_logic_vector((ROW_WIDTH - 1) downto 0);
  signal ddr2_ba_fpga             : std_logic_vector((BANK_WIDTH - 1) downto 0);
  signal ddr2_ras_n_fpga          : std_logic;
  signal ddr2_cas_n_fpga          : std_logic;
  signal ddr2_we_n_fpga           : std_logic;
  signal ddr2_cs_n_fpga           : std_logic_vector((CS_WIDTH - 1) downto 0);
  signal ddr2_cke_fpga            : std_logic_vector((CKE_WIDTH - 1) downto 0);
  signal ddr2_odt_fpga            : std_logic_vector((ODT_WIDTH - 1) downto 0);
  
  signal clk0_tb            : std_logic;
  signal rst0_tb            : std_logic;
  signal app_af_afull       : std_logic;
  signal app_wdf_afull      : std_logic;
  signal rd_data_valid      : std_logic;
  signal rd_data_fifo_out   : std_logic_vector(APPDATA_WIDTH-1 downto 0);
  signal app_af_wren        : std_logic;
  signal app_af_cmd         : std_logic_vector(2 downto 0);
  signal app_af_addr        : std_logic_vector(30 downto 0);
  signal app_wdf_wren       : std_logic;
  signal app_wdf_data       : std_logic_vector(APPDATA_WIDTH-1 downto 0);
  signal app_wdf_mask_data  : std_logic_vector((APPDATA_WIDTH/8)-1 downto 0);

  signal sys_clk_ibufg      : std_logic;
  signal clk0_bufg          : std_logic;
  signal clk0_bufg_in       : std_logic;
  signal clk90_bufg         : std_logic;
  signal clk90_bufg_in      : std_logic;
  signal clk200_bufg        : std_logic;
  signal clkdiv0_bufg       : std_logic;
  signal clkdiv0_bufg_in    : std_logic;
  signal clk200_ibufg       : std_logic;
  signal clkfbout_clkfbin   : std_logic;
  signal locked             : std_logic;
  signal clk0               : std_logic;
  signal clk90              : std_logic;
  signal clk200             : std_logic;
  signal clkdiv0            : std_logic;
  signal sys_rst            : std_logic;

begin
  gnd <= "00";
   --***************************************************************************
   -- Clock generation and reset
   --***************************************************************************
  process
  begin
    sys_clk <= not sys_clk;
    wait for (TCYC_SYS_DIV2);
  end process;

   sys_clk_p <= sys_clk;
   sys_clk_n <= not sys_clk;

   process
   begin
     sys_clk200 <= not sys_clk200;
     wait for (TCYC_200);
   end process;

   clk200_p <= sys_clk200;
   clk200_n <= not sys_clk200;

   process
   begin
      sys_rst_n <= '0';
      wait for 200 ns;
      sys_rst_n <= '1';
      wait;
   end process;

  sys_rst_i   <=  not sys_rst_n;
  sys_rst_out <= (sys_rst_n) when (RST_ACT_LOW = 1) else (not sys_rst_n);

   clk0    <= clk0_bufg;
  clk90   <= clk90_bufg;
  clk200  <= clk200_bufg;
  clkdiv0 <= clkdiv0_bufg;

  --***************************************************************************
  -- Differential input clock input buffers
  --***************************************************************************

  u_ibufg_sys_clk : IBUFGDS_LVPECL_25
    port map (
      I  => sys_clk_p,
      IB => sys_clk_n,
      O  => sys_clk_ibufg
      );

  u_ibufg_clk200 : IBUFGDS_LVPECL_25
    port map (
      I  => clk200_p,
      IB => clk200_n,
      O  => clk200_ibufg
      );

  --***************************************************************************
  -- Global clock generation and distribution
  --***************************************************************************

  gen_pll_adv: if (CLK_GENERATOR = "PLL") generate
  begin
    u_pll_adv: PLL_ADV
      generic map (
        BANDWIDTH          => "OPTIMIZED",
        CLKIN1_PERIOD      => CLK_PERIOD_NS,
        CLKIN2_PERIOD      => 10.000,
        CLKOUT0_DIVIDE     => CLK_PERIOD_INT,
        CLKOUT1_DIVIDE     => CLK_PERIOD_INT,
        CLKOUT2_DIVIDE     => CLK_PERIOD_INT*2,
        CLKOUT3_DIVIDE     => 1,
        CLKOUT4_DIVIDE     => 1,
        CLKOUT5_DIVIDE     => 1,
        CLKOUT0_PHASE      => 0.000,
        CLKOUT1_PHASE      => 90.000,
        CLKOUT2_PHASE      => 0.000,
        CLKOUT3_PHASE      => 0.000,
        CLKOUT4_PHASE      => 0.000,
        CLKOUT5_PHASE      => 0.000,
        CLKOUT0_DUTY_CYCLE => 0.500,
        CLKOUT1_DUTY_CYCLE => 0.500,
        CLKOUT2_DUTY_CYCLE => 0.500,
        CLKOUT3_DUTY_CYCLE => 0.500,
        CLKOUT4_DUTY_CYCLE => 0.500,
        CLKOUT5_DUTY_CYCLE => 0.500,
        COMPENSATION       => "SYSTEM_SYNCHRONOUS",
        DIVCLK_DIVIDE      => 1,
        CLKFBOUT_MULT      => CLK_PERIOD_INT,
        CLKFBOUT_PHASE     => 0.0,
        REF_JITTER         => 0.005000
        )
      port map (
        CLKFBIN     => clkfbout_clkfbin,
        CLKINSEL    => '1',
        CLKIN1      => sys_clk_ibufg,
        CLKIN2      => '0',
        DADDR       => (others => '0'),
        DCLK        => '0',
        DEN         => '0',
        DI          => (others => '0'),
        DWE         => '0',
        REL         => '0',
        RST         => sys_rst_i,
        CLKFBDCM    => open,
        CLKFBOUT    => clkfbout_clkfbin,
        CLKOUTDCM0  => open,
        CLKOUTDCM1  => open,
        CLKOUTDCM2  => open,
        CLKOUTDCM3  => open,
        CLKOUTDCM4  => open,
        CLKOUTDCM5  => open,
        CLKOUT0     => clk0_bufg_in,
        CLKOUT1     => clk90_bufg_in,
        CLKOUT2     => clkdiv0_bufg_in,
        CLKOUT3     => open,
        CLKOUT4     => open,
        CLKOUT5     => open,
        DO          => open,
        DRDY        => open,
        LOCKED      => locked
        );
  end generate;

  gen_dcm_base: if (CLK_GENERATOR = "DCM") generate
  begin
    u_dcm_base : DCM_BASE
      generic map (
        CLKIN_PERIOD          => CLK_PERIOD_NS,
        CLKDV_DIVIDE          => 2.0,
        DLL_FREQUENCY_MODE    => DLL_FREQ_MODE,
        DUTY_CYCLE_CORRECTION => true,
        FACTORY_JF            => X"F0F0"
        )
      port map (
        CLK0                  => clk0_bufg_in,
        CLK180                => open,
        CLK270                => open,
        CLK2X                 => open,
        CLK2X180              => open,
        CLK90                 => clk90_bufg_in,
        CLKDV                 => clkdiv0_bufg_in,
        CLKFX                 => open,
        CLKFX180              => open,
        LOCKED                => locked,
        CLKFB                 => clk0_bufg,
        CLKIN                 => sys_clk_ibufg,
        RST                   => sys_rst_i
        );
  end generate;

  u_bufg_clk0 : BUFG
    port map (
      O => clk0_bufg,
      I => clk0_bufg_in
      );

  u_bufg_clk90 : BUFG
    port map (
      O => clk90_bufg,
      I => clk90_bufg_in
      );

  u_bufg_clk200 : BUFG
    port map (
      O => clk200_bufg,
      I => clk200_ibufg
      );

  u_bufg_clkdiv0 : BUFG
    port map (
      O  => clkdiv0_bufg,
      I  => clkdiv0_bufg_in
    );

   --***************************************************************************
   -- FPGA memory controller
   --***************************************************************************

  u_mem_controller : mig_top
    generic map (
      BANK_WIDTH            => BANK_WIDTH,
      CKE_WIDTH             => CKE_WIDTH,
      CLK_WIDTH             => CLK_WIDTH,
      COL_WIDTH             => COL_WIDTH,
      CS_NUM                => CS_NUM,
      CS_WIDTH              => CS_WIDTH,
      CS_BITS               => CS_BITS,
      DM_WIDTH                     => DM_WIDTH,
      DQ_WIDTH              => DQ_WIDTH,
      DQ_PER_DQS            => DQ_PER_DQS,
      DQ_BITS               => DQ_BITS,
      DQS_WIDTH             => DQS_WIDTH,
      DQS_BITS              => DQS_BITS,
      HIGH_PERFORMANCE_MODE => HIGH_PERFORMANCE_MODE,
      ODT_WIDTH             => ODT_WIDTH,
      ROW_WIDTH             => ROW_WIDTH,
      APPDATA_WIDTH         => APPDATA_WIDTH,
      ADDITIVE_LAT          => ADDITIVE_LAT,
      BURST_LEN             => BURST_LEN,
      BURST_TYPE            => BURST_TYPE,
      CAS_LAT               => CAS_LAT,
      ECC_ENABLE            => ECC_ENABLE,
      MULTI_BANK_EN         => MULTI_BANK_EN,
      ODT_TYPE              => ODT_TYPE,
      REDUCE_DRV            => REDUCE_DRV,
      REG_ENABLE            => REG_ENABLE,
      TREFI_NS              => TREFI_NS,
      TRAS                  => TRAS,
      TRCD                  => TRCD,
      TRFC                  => TRFC,
      TRP                   => TRP,
      TRTP                  => TRTP,
      TWR                   => TWR,
      TWTR                  => TWTR,
      SIM_ONLY              => SIM_ONLY,
      RST_ACT_LOW           => RST_ACT_LOW,
      CLK_PERIOD            => CLK_PERIOD
      )
    port map (
      clk0              => clk0,
      clk90             => clk90,
      clk200            => clk200,
      clkdiv0           => clkdiv0,
      locked            => locked,
      sys_rst_n         => sys_rst_out,
      ddr2_ras_n        => ddr2_ras_n_fpga,
      ddr2_cas_n        => ddr2_cas_n_fpga,
      ddr2_we_n         => ddr2_we_n_fpga,
      ddr2_cs_n         => ddr2_cs_n_fpga,
      ddr2_cke          => ddr2_cke_fpga,
      ddr2_odt          => ddr2_odt_fpga,
      ddr2_dm           => ddr2_dm_fpga,
      ddr2_dq           => ddr2_dq_fpga,
      ddr2_dqs          => ddr2_dqs_fpga,
      ddr2_dqs_n        => ddr2_dqs_n_fpga,
      ddr2_ck           => ddr2_clk_fpga,
      ddr2_ck_n         => ddr2_clk_n_fpga,
      ddr2_ba           => ddr2_ba_fpga,
      ddr2_a            => ddr2_address_fpga,
      
      clk0_tb           => clk0_tb,
      rst0_tb           => rst0_tb,
      app_af_afull      => app_af_afull,
      app_wdf_afull     => app_wdf_afull,
      rd_data_valid     => rd_data_valid,
      rd_data_fifo_out  => rd_data_fifo_out,
      app_af_wren       => app_af_wren,
      app_af_cmd        => app_af_cmd,
      app_af_addr       => app_af_addr,
      app_wdf_wren      => app_wdf_wren,
      app_wdf_data      => app_wdf_data,
      app_wdf_mask_data => app_wdf_mask_data,
      
      phy_init_done     => phy_init_done
      );

  --***************************************************************************
  -- Delay insertion modules for each signal
  --***************************************************************************
  -- Use standard non-inertial (transport) delay mechanism for unidirectional
  -- signals from FPGA to SDRAM
  ddr2_address_sdram  <= TRANSPORT ddr2_address_fpga after TPROP_PCB_CTRL;
  ddr2_ba_sdram       <= TRANSPORT ddr2_ba_fpga      after TPROP_PCB_CTRL;
  ddr2_ras_n_sdram    <= TRANSPORT ddr2_ras_n_fpga   after TPROP_PCB_CTRL;
  ddr2_cas_n_sdram    <= TRANSPORT ddr2_cas_n_fpga   after TPROP_PCB_CTRL;
  ddr2_we_n_sdram     <= TRANSPORT ddr2_we_n_fpga    after TPROP_PCB_CTRL;
  ddr2_cs_n_sdram     <= TRANSPORT ddr2_cs_n_fpga    after TPROP_PCB_CTRL;
  ddr2_cke_sdram      <= TRANSPORT ddr2_cke_fpga     after TPROP_PCB_CTRL;
  ddr2_odt_sdram      <= TRANSPORT ddr2_odt_fpga     after TPROP_PCB_CTRL;
  ddr2_clk_sdram      <= TRANSPORT ddr2_clk_fpga     after TPROP_PCB_CTRL;
  ddr2_clk_n_sdram    <= TRANSPORT ddr2_clk_n_fpga   after TPROP_PCB_CTRL;
  ddr2_reset_n_sdram  <= TRANSPORT ddr2_reset_n_fpga after TPROP_PCB_CTRL;
  ddr2_dm_sdram       <= TRANSPORT ddr2_dm_fpga      after TPROP_PCB_DATA;

  dq_delay: for i in 0 to DQ_WIDTH - 1 generate
    u_delay_dq: WireDelay
      generic map (
        Delay_g => TPROP_PCB_DATA,
        Delay_rd => TPROP_PCB_DATA_RD)
      port map(
        A => ddr2_dq_fpga(i),
        B => ddr2_dq_sdram(i),
        reset => sys_rst_n);
  end generate;

  dqs_delay: for i in 0 to DQS_WIDTH - 1 generate
    u_delay_dqs: WireDelay
      generic map (
        Delay_g => TPROP_DQS,
        Delay_rd => TPROP_DQS_RD)
      port map(
        A => ddr2_dqs_fpga(i),
        B => ddr2_dqs_sdram(i),
        reset => sys_rst_n);
  end generate;

  dqs_n_delay: for i in 0 to DQS_WIDTH - 1 generate
    u_delay_dqs: WireDelay
      generic map (
        Delay_g => TPROP_DQS,
        Delay_rd => TPROP_DQS_RD)
      port map(
        A => ddr2_dqs_n_fpga(i),
        B => ddr2_dqs_n_sdram(i),
        reset => sys_rst_n);
  end generate;

  -- Extra one clock pipelining for RDIMM address and
  -- control signals is implemented here (Implemented external to memory model)
  process (ddr2_clk_sdram)
  begin
    if (rising_edge(ddr2_clk_sdram(0))) then
      if ( ddr2_reset_n_sdram = '0' ) then
        ddr2_ras_n_reg    <= '1';
        ddr2_cas_n_reg    <= '1';
        ddr2_we_n_reg     <= '1';
        ddr2_cs_n_reg     <= (others => '1');
        ddr2_odt_reg      <= (others => '0');
      else
        ddr2_address_reg  <= TRANSPORT ddr2_address_sdram after TCYC_SYS_DIV2;
        ddr2_ba_reg       <= TRANSPORT ddr2_ba_sdram      after TCYC_SYS_DIV2;
        ddr2_ras_n_reg    <= TRANSPORT ddr2_ras_n_sdram   after TCYC_SYS_DIV2;
        ddr2_cas_n_reg    <= TRANSPORT ddr2_cas_n_sdram   after TCYC_SYS_DIV2;
        ddr2_we_n_reg     <= TRANSPORT ddr2_we_n_sdram    after TCYC_SYS_DIV2;
        ddr2_cs_n_reg     <= TRANSPORT ddr2_cs_n_sdram    after TCYC_SYS_DIV2;
        ddr2_odt_reg      <= TRANSPORT ddr2_odt_sdram     after TCYC_SYS_DIV2;
      end if;
    end if;
  end process;

  -- to avoid tIS violations on CKE when reset is deasserted
  process (ddr2_clk_n_sdram)
  begin
    if (rising_edge(ddr2_clk_n_sdram(0))) then
      if ( ddr2_reset_n_sdram = '0' ) then
        ddr2_cke_reg      <= (others => '0');
      else
        ddr2_cke_reg      <= TRANSPORT ddr2_cke_sdram after TCYC_SYS_0;
      end if;
    end if;
  end process;

  --***************************************************************************
  -- Memory model instances
  --***************************************************************************
  
  comp_16: if (DEVICE_WIDTH = 16) generate
    -- if memory part is x16
    registered_dimm: if (REG_ENABLE = 1) generate
      -- if the memory part is Registered DIMM
      gen_cs: for j in 0 to (CS_NUM - 1) generate
        gen: for i in 0 to (DQS_WIDTH/2 - 1) generate
          u_mem0: ddr2_model
            port map (
              ck        => ddr2_clk_sdram(CLK_WIDTH*i/DQS_WIDTH),
              ck_n      => ddr2_clk_n_sdram(CLK_WIDTH*i/DQS_WIDTH),
              cke       => ddr2_cke_reg(j),
              cs_n      => ddr2_cs_n_reg((j)),
              ras_n     => ddr2_ras_n_reg,
              cas_n     => ddr2_cas_n_reg,
              we_n      => ddr2_we_n_reg,
              dm_rdqs   => ddr2_dm_sdram((2*(i+1))-1 downto i*2),
              ba        => ddr2_ba_reg,
              addr      => ddr2_address_reg,
              dq        => ddr2_dq_sdram((16*(i+1))-1 downto i*16),
              dqs       => ddr2_dqs_sdram((2*(i+1))-1 downto i*2),
              dqs_n     => ddr2_dqs_n_sdram((2*(i+1))-1 downto i*2),
              rdqs_n    => open,
              odt       => ddr2_odt_reg(j)
              );
        end generate gen;
      end generate gen_cs;
    end generate registered_dimm;
    -- if the memory part is component or unbuffered DIMM
    comp16_mul8: if (((DQ_WIDTH mod 16) /= 0) and (REG_ENABLE = 0)) generate
      -- for the memory part x16, if the data width is not multiple
      -- of 16, memory models are instantiated for all data with x16
      -- memory model and except for MSB data. For the MSB data
      -- of 8 bits, all memory data, strobe and mask data signals are
      -- replicated to make it as x16 part. For example if the design
      -- is generated for data width of 72, memory model x16 parts
      -- instantiated for 4 times with data ranging from 0 to 63.
      -- For MSB data ranging from 64 to 71, one x16 memory model
      -- by replicating the 8-bit data twice and similarly
      -- the case with data mask and strobe.
      gen_cs: for j in 0 to (CS_NUM - 1) generate
        gen: for i in 0 to (DQ_WIDTH/16 - 1) generate
          u_mem0: ddr2_model
            port map (
              ck        => ddr2_clk_sdram(CLK_WIDTH*i/DQS_WIDTH),
            ck_n      => ddr2_clk_n_sdram(CLK_WIDTH*i/DQS_WIDTH),
              cke       => ddr2_cke_sdram(j),
              cs_n      => ddr2_cs_n_sdram(j),
              ras_n     => ddr2_ras_n_sdram,
              cas_n     => ddr2_cas_n_sdram,
              we_n      => ddr2_we_n_sdram,
              dm_rdqs   => ddr2_dm_sdram((2*(i+1))-1 downto i*2),
              ba        => ddr2_ba_sdram,
              addr      => ddr2_address_sdram,
              dq        => ddr2_dq_sdram((16*(i+1))-1 downto i*16),
              dqs       => ddr2_dqs_sdram((2*(i+1))-1 downto i*2),
              dqs_n     => ddr2_dqs_n_sdram((2*(i+1))-1 downto i*2),
              rdqs_n    => open,
              odt       => ddr2_odt_sdram(j)
              );
        end generate gen;

        --Logic to assign the remaining bits of DQ and DQS
        u1: for i in 0 to 7 generate
           u_delay_dq: WireDelay
              generic map (
                 Delay_g  => 0 ps,
                 Delay_rd => 0 ps)
              port map(
                A => ddr2_dq_sdram(DQ_WIDTH - 8 + i),
                B => dq_vector(i),
                reset => sys_rst_n);
        end generate;

        u2: WireDelay
          generic map (
            Delay_g  => 0 ps,
            Delay_rd => 0 ps)
          port map(
            A => ddr2_dqs_sdram(DQS_WIDTH - 1),
            B => dqs_vector(0),
            reset => sys_rst_n);

        u3: WireDelay
          generic map (
            Delay_g  => 0 ps,
            Delay_rd => 0 ps)
          port map(
            A => ddr2_dqs_n_sdram(DQS_WIDTH - 1),
            B => dqs_n_vector(0),
            reset => sys_rst_n);

        dq_vector(15 downto 8) <= dq_vector(7 downto 0);
        dqs_vector(1)          <= dqs_vector(0);
        dqs_n_vector(1)        <= dqs_n_vector(0);
        dm_vector              <= (ddr2_dm_sdram(DM_WIDTH - 1) &
                                   ddr2_dm_sdram(DM_WIDTH - 1));

        u_mem1: ddr2_model
          port map (
            ck        => ddr2_clk_sdram(CLK_WIDTH-1),
            ck_n      => ddr2_clk_n_sdram(CLK_WIDTH-1),
            cke       => ddr2_cke_sdram(j),
            cs_n      => ddr2_cs_n_sdram(j),
            ras_n     => ddr2_ras_n_sdram,
            cas_n     => ddr2_cas_n_sdram,
            we_n      => ddr2_we_n_sdram,
            dm_rdqs   => dm_vector,
            ba        => ddr2_ba_sdram,
            addr      => ddr2_address_sdram,
            dq        => dq_vector,
            dqs       => dqs_vector,
            dqs_n     => dqs_n_vector,
            rdqs_n    => open,
            odt       => ddr2_odt_sdram(j)
            );
      end generate gen_cs;
    end generate comp16_mul8;
    comp16_mul16: if (((DQ_WIDTH mod 16) = 0) and (REG_ENABLE = 0)) generate
      -- if the data width is multiple of 16
      gen_cs: for j in 0 to (CS_NUM - 1) generate
        gen: for i in 0 to ((DQS_WIDTH/2) - 1) generate
          u_mem0: ddr2_model
            port map (
              ck        => ddr2_clk_sdram(CLK_WIDTH*i/DQS_WIDTH),
            ck_n      => ddr2_clk_n_sdram(CLK_WIDTH*i/DQS_WIDTH),
              cke       => ddr2_cke_sdram(j),
              cs_n      => ddr2_cs_n_sdram(j),
              ras_n     => ddr2_ras_n_sdram,
              cas_n     => ddr2_cas_n_sdram,
              we_n      => ddr2_we_n_sdram,
              dm_rdqs   => ddr2_dm_sdram((2*(i+1))-1 downto i*2),
              ba        => ddr2_ba_sdram,
              addr      => ddr2_address_sdram,
              dq        => ddr2_dq_sdram((16*(i+1))-1 downto i*16),
              dqs       => ddr2_dqs_sdram((2*(i+1))-1 downto i*2),
              dqs_n     => ddr2_dqs_n_sdram((2*(i+1))-1 downto i*2),
              rdqs_n    => open,
              odt       => ddr2_odt_sdram(j)
              );
        end generate gen;
      end generate gen_cs;
    end generate comp16_mul16;
  end generate comp_16;

  comp_8: if (DEVICE_WIDTH = 8) generate
    -- if the memory part is x8
    registered_dimm: if (REG_ENABLE = 1) generate
      -- if the memory part is Registered DIMM
      gen_cs: for j in 0 to (CS_NUM - 1) generate
        gen: for i in 0 to (DQS_WIDTH - 1) generate
          u_mem0: ddr2_model
            port map (
              ck        => ddr2_clk_sdram(CLK_WIDTH*i/DQS_WIDTH),
              ck_n      => ddr2_clk_n_sdram(CLK_WIDTH*i/DQS_WIDTH),
              cke       => ddr2_cke_reg(j),
              cs_n      => ddr2_cs_n_reg((j)),
              ras_n     => ddr2_ras_n_reg,
              cas_n     => ddr2_cas_n_reg,
              we_n      => ddr2_we_n_reg,
              dm_rdqs   => ddr2_dm_sdram(i downto i),
              ba        => ddr2_ba_reg,
              addr      => ddr2_address_reg,
              dq        => ddr2_dq_sdram((8*(i+1))-1 downto i*8),
              dqs       => ddr2_dqs_sdram(i downto i),
              dqs_n     => ddr2_dqs_n_sdram(i downto i),
              rdqs_n    => open,
              odt       => ddr2_odt_reg(j)
              );
        end generate gen;
      end generate gen_cs;
    end generate registered_dimm;
    comp8_mul8: if (REG_ENABLE = 0) generate
      -- if the memory part is component or unbuffered DIMM
      gen_cs: for j in 0 to (CS_NUM - 1) generate
        gen: for i in 0 to DQS_WIDTH - 1 generate
          u_mem0: ddr2_model
            port map (
              ck        => ddr2_clk_sdram(CLK_WIDTH*i/DQS_WIDTH),
            ck_n      => ddr2_clk_n_sdram(CLK_WIDTH*i/DQS_WIDTH),
              cke       => ddr2_cke_sdram(j),
              cs_n      => ddr2_cs_n_sdram(j),
              ras_n     => ddr2_ras_n_sdram,
              cas_n     => ddr2_cas_n_sdram,
              we_n      => ddr2_we_n_sdram,
              dm_rdqs   => ddr2_dm_sdram(i downto i),
              ba        => ddr2_ba_sdram,
              addr      => ddr2_address_sdram,
              dq        => ddr2_dq_sdram((8*(i+1))-1 downto i*8),
              dqs       => ddr2_dqs_sdram(i downto i),
              dqs_n     => ddr2_dqs_n_sdram(i downto i),
              rdqs_n    => open,
              odt       => ddr2_odt_sdram(j)
              );
        end generate gen;
      end generate gen_cs;
    end generate comp8_mul8;
  end generate comp_8;

  comp_4: if (DEVICE_WIDTH = 4) generate
    -- if the memory part is x4
    registered_dimm: if (REG_ENABLE = 1) generate
      -- if the memory part is Registered DIMM
      gen_cs: for j in 0 to (CS_NUM - 1) generate
        gen: for i in 0 to (DQS_WIDTH - 1) generate
          u_mem0: ddr2_model
            port map (
              ck        => ddr2_clk_sdram(CLK_WIDTH*i/DQS_WIDTH),
              ck_n      => ddr2_clk_n_sdram(CLK_WIDTH*i/DQS_WIDTH),
              cke       => ddr2_cke_reg(j),
              cs_n      => ddr2_cs_n_reg((j)),
              ras_n     => ddr2_ras_n_reg,
              cas_n     => ddr2_cas_n_reg,
              we_n      => ddr2_we_n_reg,
              dm_rdqs   => ddr2_dm_sdram(i downto i),
              ba        => ddr2_ba_reg,
              addr      => ddr2_address_reg,
              dq        => ddr2_dq_sdram((4*(i+1))-1 downto i*4),
              dqs       => ddr2_dqs_sdram(i downto i),
              dqs_n     => ddr2_dqs_n_sdram(i downto i),
              rdqs_n    => open,
              odt       => ddr2_odt_reg(j)
              );
        end generate gen;
      end generate gen_cs;
    end generate registered_dimm;
    comp4_mul4: if (REG_ENABLE = 0) generate
      -- if the memory part is component or unbuffered DIMM
      gen_cs: for j in 0 to (CS_NUM - 1) generate
        gen: for i in 0 to DQS_WIDTH - 1 generate
          u_mem0: ddr2_model
            port map (
              ck        => ddr2_clk_sdram(CLK_WIDTH*i/DQS_WIDTH),
            ck_n      => ddr2_clk_n_sdram(CLK_WIDTH*i/DQS_WIDTH),
              cke       => ddr2_cke_sdram(j),
              cs_n      => ddr2_cs_n_sdram(j),
              ras_n     => ddr2_ras_n_sdram,
              cas_n     => ddr2_cas_n_sdram,
              we_n      => ddr2_we_n_sdram,
              dm_rdqs   => ddr2_dm_sdram(i downto i),
              ba        => ddr2_ba_sdram,
              addr      => ddr2_address_sdram,
              dq        => ddr2_dq_sdram((4*(i+1))-1 downto i*4),
              dqs       => ddr2_dqs_sdram(i downto i),
              dqs_n     => ddr2_dqs_n_sdram(i downto i),
              rdqs_n    => open,
              odt       => ddr2_odt_sdram(j)
              );
        end generate gen;
      end generate gen_cs;
    end generate comp4_mul4;
  end generate comp_4;
  
  -- synthesizable test bench provided for wotb designs
  u_tb_top : ddr2_tb_top
    generic map (
      BANK_WIDTH    => BANK_WIDTH,
      COL_WIDTH     => COL_WIDTH,
      DM_WIDTH      => DM_WIDTH,
      DQ_WIDTH      => DQ_WIDTH,
      ROW_WIDTH     => ROW_WIDTH,
      APPDATA_WIDTH => APPDATA_WIDTH,
      ECC_ENABLE    => ECC_ENABLE,
      BURST_LEN     => BURST_LEN
      )
    port map (
      clk0              => clk0_tb,
      rst0              => rst0_tb,
      app_af_afull      => app_af_afull,
      app_wdf_afull     => app_wdf_afull,
      rd_data_valid     => rd_data_valid,
      rd_data_fifo_out  => rd_data_fifo_out,
      phy_init_done     => phy_init_done,
      app_af_wren       => app_af_wren,
      app_af_cmd        => app_af_cmd,
      app_af_addr       => app_af_addr,
      app_wdf_wren      => app_wdf_wren,
      app_wdf_data      => app_wdf_data,
      app_wdf_mask_data => app_wdf_mask_data,
      error             => error
      );


end architecture;
