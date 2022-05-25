--------------------------------------------------------------------------------
-- Create Date:    01/09/2008
-- Design Name:    Discovery (DDC4100)
-- Module Name:    appsfpga_a - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture for module appsfpga. top level module 
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


ARCHITECTURE Behavioral OF appsfpga IS

COMPONENT appsfpga_io
PORT (clk_i                      : IN STD_LOGIC;
      pwrgdz                     : IN STD_LOGIC;
      --other control signals
      in_init_active_i           : IN STD_LOGIC;
      in_dip_sw_i                : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      in_pb_sw_i                 : IN STD_LOGIC;
      in_dmd_type                : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0 );
      -- signals going to LVDS
      appcore_data_valid_q       : IN STD_LOGIC;
      appcore_dout_a_q           : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_b_q           : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_c_q           : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      appcore_dout_d_q           : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      -- single ended control signals
      appcore_rowmd_q            : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      appcore_rowad_q            : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      appcore_blkad_q            : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      appcore_blkmd_q            : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      appsfpga_io_rowmd_q        : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      appsfpga_io_rowad_q        : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      appsfpga_io_blkad_q        : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      appsfpga_io_blkmd_q        : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      --global and reference clock
      clk_g                      : OUT STD_LOGIC;
      arst_gq                    : OUT STD_LOGIC;
      clk_r_o                    : OUT STD_LOGIC;
      pll_locked_rstz_gq         : OUT STD_LOGIC;
      init_active_gq             : OUT STD_LOGIC;

      pll_speed_info      : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

      --LVDS outputs
      appsfpga_io_dout_ap        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_an        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_bp        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_bn        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_cp        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_cn        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_dp        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dout_dn        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      appsfpga_io_dclk_ap        : OUT STD_LOGIC;
      appsfpga_io_dclk_an        : OUT STD_LOGIC;
      appsfpga_io_dclk_bp        : OUT STD_LOGIC;
      appsfpga_io_dclk_bn        : OUT STD_LOGIC;
      appsfpga_io_dclk_cp        : OUT STD_LOGIC;
      appsfpga_io_dclk_cn        : OUT STD_LOGIC;
      appsfpga_io_dclk_dp        : OUT STD_LOGIC;
      appsfpga_io_dclk_dn        : OUT STD_LOGIC;
      appsfpga_io_dvalid_ap      : OUT STD_LOGIC;
      appsfpga_io_dvalid_an      : OUT STD_LOGIC;
      appsfpga_io_dvalid_bp      : OUT STD_LOGIC;
      appsfpga_io_dvalid_bn      : OUT STD_LOGIC;
      appsfpga_io_dvalid_cp      : OUT STD_LOGIC;
      appsfpga_io_dvalid_cn      : OUT STD_LOGIC;
      appsfpga_io_dvalid_dp      : OUT STD_LOGIC;
      appsfpga_io_dvalid_dn      : OUT STD_LOGIC;
      --user inputs
      appsfpga_io_comp_data_en_q : OUT STD_LOGIC;
      appsfpga_io_ns_flip_en_q   : OUT STD_LOGIC;
      appsfpga_io_cnthalt_q      : OUT STD_LOGIC;
      appsfpga_io_reset_type_q   : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      appsfpga_io_rowaddrmode_q  : OUT STD_LOGIC;
      appsfpga_io_WDT_enbl_q     : OUT STD_LOGIC;
      appsfpga_io_STEP_VCC_enbl_q: OUT STD_LOGIC;
      appsfpga_io_pwr_floatz_q   : OUT STD_LOGIC;
      appsfpga_io_float_q        : OUT STD_LOGIC
      );
END COMPONENT;

COMPONENT appcore
PORT (
      clk_g                      : IN STD_LOGIC;
      pll_locked_rstz_gq         : IN STD_LOGIC;
      init_active_gq             : IN STD_LOGIC;
      in_ddc_version          : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
     pll_speed_info      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);

      --user inputs
      appsfpga_io_comp_data_en_q : IN STD_LOGIC;
      appsfpga_io_ns_flip_en_q   : IN STD_LOGIC;
      appsfpga_io_cnthalt_q      : IN STD_LOGIC;
      appsfpga_io_reset_type_q   : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
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
      appcore_rowad_q            : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
      appcore_blkad_q            : OUT STD_LOGIC_VECTOR(3 downto 0);
      appcore_blkmd_q            : OUT STD_LOGIC_VECTOR(1 downto 0);
      --outputs determined by user inputs
      appcore_comp_data_q        : OUT STD_LOGIC;
      appcore_ns_flip_q          : OUT STD_LOGIC;
      appcore_STEP_VCC_q         : OUT STD_LOGIC;
      appcore_rst2blkz_q         : OUT STD_LOGIC;
      appscore_pwr_floatz_q      : OUT STD_LOGIC;
      appcore_load4z_q           : OUT STD_LOGIC;
      
     -- USB/gui signals
      clk_usb			 : IN	 STD_LOGIC;
      reset_i                    : IN    STD_LOGIC;
      rdy0			 : OUT   STD_LOGIC;
      rdy1			 : OUT   STD_LOGIC;
      rdy2			 : OUT   STD_LOGIC;
      ctl0			 : IN	 STD_LOGIC;
      ctl1			 : IN	 STD_LOGIC;
      ctl2			 : IN	 STD_LOGIC;
      gpioa_o			 : OUT   STD_LOGIC_VECTOR(2 DOWNTO 0);
      gpioa_i			 : IN	 STD_LOGIC_VECTOR(2 DOWNTO 0);
      gpio_ext_rest_in  	 : IN	 STD_LOGIC;
      gpio_reset_complete_o	 : OUT   STD_LOGIC;
      bidir			 : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)          
      );
END COMPONENT;

SIGNAL      clk_g                      : STD_LOGIC;
SIGNAL      arst_gq                    : STD_LOGIC;
-- SIGNAL      appsfpga_io_locked         : STD_LOGIC;
SIGNAL      appsfpga_io_comp_data_en_q : STD_LOGIC;
SIGNAL      appsfpga_io_ns_flip_en_q   : STD_LOGIC;
SIGNAL      appsfpga_io_cnthalt_q      : STD_LOGIC;
SIGNAL      appsfpga_io_reset_type_q   : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      appsfpga_io_rowaddrmode_q  : STD_LOGIC;
SIGNAL      appcore_dout_a_q           : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL      appcore_dout_b_q           : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL      appcore_dout_c_q           : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL      appcore_dout_d_q           : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL      appcore_comp_data_q        : STD_LOGIC;
SIGNAL      appcore_ns_flip_q          : STD_LOGIC;
SIGNAL      appcore_blkad_q            : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL      appcore_blkmd_q            : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      appcore_rowmd_q            : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      appcore_rowad_q            : STD_LOGIC_VECTOR (10 DOWNTO 0);
SIGNAL      appcore_data_valid_q       : STD_LOGIC;
SIGNAL      appsfpga_io_blkad_q        : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL      appsfpga_io_blkmd_q        : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      appsfpga_io_rowmd_q        : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      appsfpga_io_rowad_q        : STD_LOGIC_VECTOR (10 DOWNTO 0);
--SIGNAL      appsfpga_io_data_valid_q   : STD_LOGIC;
SIGNAL      appsfpga_io_dout_ap        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dout_an        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dout_bp        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dout_bn        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dout_cp        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dout_cn        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dout_dp        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dout_dn        : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL      appsfpga_io_dclk_ap        : STD_LOGIC;
SIGNAL      appsfpga_io_dclk_an        : STD_LOGIC;
SIGNAL      appsfpga_io_dclk_bp        : STD_LOGIC;
SIGNAL      appsfpga_io_dclk_bn        : STD_LOGIC;
SIGNAL      appsfpga_io_dclk_cp        : STD_LOGIC;
SIGNAL      appsfpga_io_dclk_cn        : STD_LOGIC;
SIGNAL      appsfpga_io_dclk_dp        : STD_LOGIC;
SIGNAL      appsfpga_io_dclk_dn        : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_ap      : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_an      : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_bp      : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_bn      : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_cp      : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_cn      : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_dp      : STD_LOGIC;
SIGNAL      appsfpga_io_dvalid_dn      : STD_LOGIC;
SIGNAL      appsfpga_io_WDT_enbl_q     : STD_LOGIC;
SIGNAL      appsfpga_io_STEP_VCC_enbl_q: STD_LOGIC;
SIGNAL      appsfpga_io_pwr_floatz_q   : STD_LOGIC;
SIGNAL      appsfpga_io_float_q        : STD_LOGIC;
SIGNAL      appcore_STEP_VCC_q         : STD_LOGIC;
SIGNAL      appcore_rst2blkz_q         : STD_LOGIC;
SIGNAL      appscore_pwr_floatz_q      : STD_LOGIC;
SIGNAL      appcore_load4z_q	       : STD_LOGIC;
SIGNAL      in_dmd_type                : STD_LOGIC_VECTOR( 3 DOWNTO 0 );
SIGNAL      in_dmd_type_q              : STD_LOGIC_VECTOR( 3 DOWNTO 0 );
SIGNAL      io_pll_reset               : STD_LOGIC;

SIGNAL      pll_locked_rstz_gq         : STD_LOGIC;
SIGNAL      init_active_gq             : STD_LOGIC;
SIGNAL   pll_speed_info    :  STD_LOGIC_VECTOR(1 DOWNTO 0);

--- reset switch debounce logic
SIGNAL      twenty_us_pulse            : STD_LOGIC;
SIGNAL      debounce_delay_cnt         : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
SIGNAL      reset_pb_capture1q         : STD_LOGIC;
SIGNAL      reset_pb_capture2q         : STD_LOGIC;
SIGNAL      reset_pb_capture3q         : STD_LOGIC;
SIGNAL      reset_pb_capture4q         : STD_LOGIC;
SIGNAL      debounced_logic_rstz       : STD_LOGIC;

SIGNAL      reset_delay_cnt            : STD_LOGIC_VECTOR(18 DOWNTO 0 );
SIGNAL      onesixty_us_pulse          : STD_LOGIC;

SIGNAL      pwr_float_capture1q         : STD_LOGIC;
SIGNAL      pwr_float_capture2q         : STD_LOGIC;
SIGNAL      pwr_float_capture3q         : STD_LOGIC;
SIGNAL      debounced_pwr_float_iq      : STD_LOGIC;

SIGNAL      dip_sw_capture1q           : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL      dip_sw_capture2q           : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL      dip_sw_capture3q           : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL      debounced_dip_sw_iq        : STD_LOGIC_VECTOR(7 DOWNTO 0);


SIGNAL      clk_i_div                  : STD_LOGIC;
SIGNAL      clk_g_div                  : STD_LOGIC;


SIGNAL      rdy0_tmp                   : STD_LOGIC;
SIGNAL      rdy1_tmp                   : STD_LOGIC;
SIGNAL      rdy2_tmp                   : STD_LOGIC;

BEGIN

 -- Top level reset from 2 sources.
-- io_pll_reset <= reset_i OR (NOT apps_logic_rstz);
 io_pll_reset <= reset_i OR (NOT debounced_logic_rstz);

i_appsfpga_io: appsfpga_io
PORT MAP (clk_i                       => clk_i,
          pwrgdz                      => io_pll_reset,
          in_init_active_i            => in_init_active_i,
          in_dip_sw_i(7 DOWNTO 0)     => debounced_dip_sw_iq(7 DOWNTO 0),
          in_pb_sw_i                  => debounced_pwr_float_iq,
          in_dmd_type                 => in_dmd_type_q,
          appcore_data_valid_q        => appcore_data_valid_q,
          appcore_dout_a_q            => appcore_dout_a_q,
          appcore_dout_b_q            => appcore_dout_b_q,
          appcore_dout_c_q            => appcore_dout_c_q,
          appcore_dout_d_q            => appcore_dout_d_q,
          -- single ended control signals
          appcore_rowmd_q             => appcore_rowmd_q,
          appcore_rowad_q             => appcore_rowad_q,
          appcore_blkad_q             => appcore_blkad_q,
          appcore_blkmd_q             => appcore_blkmd_q,
          appsfpga_io_rowmd_q         => appsfpga_io_rowmd_q,
          appsfpga_io_rowad_q         => appsfpga_io_rowad_q,
          appsfpga_io_blkad_q         => appsfpga_io_blkad_q,
          appsfpga_io_blkmd_q         => appsfpga_io_blkmd_q,          
          clk_g                       => clk_g,
          arst_gq                     => arst_gq,        
          clk_r_o                     => clk_r_o,
          pll_locked_rstz_gq          => pll_locked_rstz_gq,
          init_active_gq              => init_active_gq,

         pll_speed_info    => pll_speed_info,    -- :  STD_LOGIC_VECTOR(1 DOWNTO 0);
          --LVDS outputs
          appsfpga_io_dout_ap         => appsfpga_io_dout_ap,
          appsfpga_io_dout_an         => appsfpga_io_dout_an,
          appsfpga_io_dout_bp         => appsfpga_io_dout_bp,
          appsfpga_io_dout_bn         => appsfpga_io_dout_bn,
          appsfpga_io_dout_cp         => appsfpga_io_dout_cp,
          appsfpga_io_dout_cn         => appsfpga_io_dout_cn,
          appsfpga_io_dout_dp         => appsfpga_io_dout_dp,
          appsfpga_io_dout_dn         => appsfpga_io_dout_dn,
          appsfpga_io_dclk_ap         => appsfpga_io_dclk_ap,
          appsfpga_io_dclk_an         => appsfpga_io_dclk_an,
          appsfpga_io_dclk_bp         => appsfpga_io_dclk_bp,
          appsfpga_io_dclk_bn         => appsfpga_io_dclk_bn,
          appsfpga_io_dclk_cp         => appsfpga_io_dclk_cp,
          appsfpga_io_dclk_cn         => appsfpga_io_dclk_cn,
          appsfpga_io_dclk_dp         => appsfpga_io_dclk_dp,
          appsfpga_io_dclk_dn         => appsfpga_io_dclk_dn,
          appsfpga_io_dvalid_ap       => appsfpga_io_dvalid_ap,
          appsfpga_io_dvalid_an       => appsfpga_io_dvalid_an,          
          appsfpga_io_dvalid_bp       => appsfpga_io_dvalid_bp,
          appsfpga_io_dvalid_bn       => appsfpga_io_dvalid_bn,
          appsfpga_io_dvalid_cp       => appsfpga_io_dvalid_cp,
          appsfpga_io_dvalid_cn       => appsfpga_io_dvalid_cn,
          appsfpga_io_dvalid_dp       => appsfpga_io_dvalid_dp,
          appsfpga_io_dvalid_dn       => appsfpga_io_dvalid_dn,
          --user inputs
          appsfpga_io_comp_data_en_q  => appsfpga_io_comp_data_en_q,
          appsfpga_io_ns_flip_en_q    => appsfpga_io_ns_flip_en_q,
          appsfpga_io_cnthalt_q       => appsfpga_io_cnthalt_q,
          appsfpga_io_reset_type_q    => appsfpga_io_reset_type_q,
          appsfpga_io_rowaddrmode_q   => appsfpga_io_rowaddrmode_q,
          appsfpga_io_WDT_enbl_q      => appsfpga_io_WDT_enbl_q,
          appsfpga_io_STEP_VCC_enbl_q => appsfpga_io_STEP_VCC_enbl_q,
          appsfpga_io_pwr_floatz_q    => appsfpga_io_pwr_floatz_q,
          appsfpga_io_float_q         => appsfpga_io_float_q
        );

i_appcore: appcore
PORT MAP (clk_g                          => clk_g,
          pll_locked_rstz_gq             => pll_locked_rstz_gq,
          init_active_gq                 => init_active_gq,
          in_ddc_version =>  ddc_version_i , --         : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          pll_speed_info => pll_speed_info, --      : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
 
          appsfpga_io_comp_data_en_q     => appsfpga_io_comp_data_en_q,
          appsfpga_io_ns_flip_en_q       => appsfpga_io_ns_flip_en_q,
          appsfpga_io_cnthalt_q          => appsfpga_io_cnthalt_q,
          appsfpga_io_reset_type_q       => appsfpga_io_reset_type_q,
          appsfpga_io_rowaddrmode_q      => appsfpga_io_rowaddrmode_q,
          in_dmd_type                    => in_dmd_type_q,
          appcore_data_valid_q           => appcore_data_valid_q,
          appcore_dout_a_q               => appcore_dout_a_q ,
          appcore_dout_b_q               => appcore_dout_b_q ,
          appcore_dout_c_q               => appcore_dout_c_q ,
          appcore_dout_d_q               => appcore_dout_d_q ,
          appcore_rowmd_q (1  DOWNTO 0)  => appcore_rowmd_q (1  DOWNTO 0),
          appcore_rowad_q (10  DOWNTO 0) => appcore_rowad_q (10  DOWNTO 0),
          appcore_blkad_q (3  DOWNTO 0)  => appcore_blkad_q (3  DOWNTO 0),
          appcore_blkmd_q (1  DOWNTO 0)  => appcore_blkmd_q (1  DOWNTO 0),
          appcore_comp_data_q            => appcore_comp_data_q,
          appcore_ns_flip_q              => appcore_ns_flip_q,
          appsfpga_io_WDT_enbl_q         => appsfpga_io_WDT_enbl_q,
          appsfpga_io_STEP_VCC_enbl_q    => appsfpga_io_STEP_VCC_enbl_q,
          appcore_STEP_VCC_q             => appcore_STEP_VCC_q,
          appcore_rst2blkz_q             => appcore_rst2blkz_q,
          appscore_pwr_floatz_q          => appscore_pwr_floatz_q,   -- OUT STD_LOGIC;
          appsfpga_io_float_q            => appsfpga_io_float_q,
          appcore_load4z_q               => appcore_load4z_q,        -- OUT STD_LOGIC;
          -- USB/GUI signals
	  clk_usb                        => clk_usb,		 	  
	  reset_i                        => reset_i,
	  rdy0  	        	 => rdy0_tmp,		 
	  rdy1  	        	 => rdy1_tmp,		 
	  rdy2  	        	 => rdy2_tmp,		 
	  ctl0  	        	 => ctl0,		 
	  ctl1  	        	 => ctl1,		 
	  ctl2  	        	 => ctl2,		 
	  gpioa_o	        	 => gpioa_o,		 
	  gpioa_i	        	 => gpioa_i,		 
	  gpio_ext_rest_in      	 => gpio_ext_rest_in,	 
	  gpio_reset_complete_o 	 => gpio_reset_complete_o,
	  bidir 	        	 => bidir	  
	  );

	  
	  rdy0  	        	 <= rdy0_tmp;		 
	  rdy1  	        	 <= rdy1_tmp;		 
	  rdy2  	        	 <= rdy2_tmp;		 
--indicate initialization of fpga complete
finished_iv_o <= '1';

--turn off step up voltage
stepvcc_o <= '0';

--Signal renaming section


dout_ap_o <= appsfpga_io_dout_ap;
dout_an_o <= appsfpga_io_dout_an;
dvalid_ap_o <= appsfpga_io_dvalid_ap;
dvalid_an_o <= appsfpga_io_dvalid_an;
dclk_ap_o <= appsfpga_io_dclk_ap;
dclk_an_o <= appsfpga_io_dclk_an;

dout_bp_o <= appsfpga_io_dout_bp;
dout_bn_o <= appsfpga_io_dout_bn;
dvalid_bp_o <= appsfpga_io_dvalid_bp;
dvalid_bn_o <= appsfpga_io_dvalid_bn;
dclk_bp_o <= appsfpga_io_dclk_bp;
dclk_bn_o <= appsfpga_io_dclk_bn;

dout_cp_o <= appsfpga_io_dout_cp;
dout_cn_o <= appsfpga_io_dout_cn;
dvalid_cp_o <= appsfpga_io_dvalid_cp;
dvalid_cn_o <= appsfpga_io_dvalid_cn;
dclk_cp_o <= appsfpga_io_dclk_cp;
dclk_cn_o <= appsfpga_io_dclk_cn;

dout_dp_o <= appsfpga_io_dout_dp;
dout_dn_o <= appsfpga_io_dout_dn;
dvalid_dp_o <= appsfpga_io_dvalid_dp;
dvalid_dn_o <= appsfpga_io_dvalid_dn;
dclk_dp_o <= appsfpga_io_dclk_dp;
dclk_dn_o <= appsfpga_io_dclk_dn;

rowmd_o <= appsfpga_io_rowmd_q;
rowad_o <= appsfpga_io_rowad_q;
comp_data_o <= appcore_comp_data_q;
ns_flip_o <= appcore_ns_flip_q;
blkad_o <= appsfpga_io_blkad_q;
blkmd_o <= appsfpga_io_blkmd_q;
pwr_floatz_o <= appsfpga_io_pwr_floatz_q AND appscore_pwr_floatz_q;
-- arstz_o <= pll_locked_rstz_gq AND apps_logic_rstz;
arstz_o <= pll_locked_rstz_gq;
wdt_enablez_o <= NOT appsfpga_io_WDT_enbl_q;
-- stepvcc_o <= appcore_STEP_VCC_q;  -- removed per discussions 7/10/09.
rst2blkz_o <= appcore_rst2blkz_q;


PROCESS (io_pll_reset, clk_i)
BEGIN
  IF (io_pll_reset = '1') THEN
    clk_i_div <= '0';
  ELSIF rising_edge(clk_i) THEN
    clk_i_div <= not clk_i_div AFTER 1 PS;
  END IF;
END PROCESS;

PROCESS (io_pll_reset, clk_g)
BEGIN
  IF (io_pll_reset = '1') THEN
    clk_g_div <= '0';
  ELSIF rising_edge(clk_g) THEN
    clk_g_div <= not clk_g_div AFTER 1 PS;
  END IF;
END PROCESS;

-- synchronizing dmd_type signals
PROCESS (io_pll_reset, clk_g)
BEGIN
  IF (io_pll_reset = '1') THEN
    in_dmd_type <= (OTHERS => '0');
    in_dmd_type_q <= (OTHERS => '0');
  ELSIF rising_edge(clk_g) THEN
    in_dmd_type <= dmd_type_i AFTER 1 PS;
    in_dmd_type_q <= in_dmd_type AFTER 1 PS;
  END IF;
END PROCESS;

------------------------------------------------------------
-- Pushbutton/DIP Switch Debounce --
-- Generates a 50 MHz clock puls once every 20 us.
-- If the switch is asserted for 3 pulses, pass the reset on
-- to the core.  If it's deasserted for 3 pulses, deassert.


-- 20 us counter (about)
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    debounce_delay_cnt <= "0000000000";
    twenty_us_pulse    <= '0' AFTER 1 PS;
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (debounce_delay_cnt < "1111111111") THEN
       debounce_delay_cnt <= debounce_delay_cnt + "0000000001" AFTER 1 PS;
       twenty_us_pulse    <= '0' AFTER 1 PS;
    ELSE
       debounce_delay_cnt <= "0000000000" AFTER 1 PS;
       twenty_us_pulse    <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    reset_delay_cnt      <= "0000000000000000000";
    onesixty_us_pulse    <= '0' AFTER 1 PS;      -- actually 5ms with new bits added
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (reset_delay_cnt < "1111111111111111111") THEN
       reset_delay_cnt      <= reset_delay_cnt + "0000000000000000001" AFTER 1 PS;
       onesixty_us_pulse    <= '0' AFTER 1 PS;
    ELSE
       reset_delay_cnt      <= "0000000000000000000" AFTER 1 PS;
       onesixty_us_pulse    <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

--debounce logic: forces a minimum 15ms reset.
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    reset_pb_capture1q   <= '1';
    reset_pb_capture2q   <= '1';
    reset_pb_capture3q   <= '1';
    reset_pb_capture4q   <= '1';
    debounced_logic_rstz <= '1';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (onesixty_us_pulse = '1') THEN
       reset_pb_capture1q  <= apps_logic_rstn    AFTER 1 PS;
       reset_pb_capture2q  <= reset_pb_capture1q AFTER 1 PS;
       reset_pb_capture3q  <= reset_pb_capture2q AFTER 1 PS;
       reset_pb_capture4q  <= reset_pb_capture3q AFTER 1 PS;
    END IF;
    IF (reset_pb_capture1q = '0' AND reset_pb_capture2q = '0' AND reset_pb_capture3q = '0' AND reset_pb_capture4q = '0') THEN
       debounced_logic_rstz <= '0' AFTER 1 PS;
    ELSIF (reset_pb_capture1q = '1' AND reset_pb_capture2q = '1' AND reset_pb_capture3q = '1' AND reset_pb_capture4q = '1') THEN
       debounced_logic_rstz <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 7
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(7)    <= '0';
    dip_sw_capture2q(7)    <= '0';
    dip_sw_capture3q(7)    <= '0';
    debounced_dip_sw_iq(7) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(7)  <= in_dip_sw_i(7)      AFTER 1 PS;
       dip_sw_capture2q(7)  <= dip_sw_capture1q(7) AFTER 1 PS;
       dip_sw_capture3q(7)  <= dip_sw_capture2q(7) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(7) = '0' AND dip_sw_capture2q(7) = '0' AND dip_sw_capture3q(7) = '0') THEN
       debounced_dip_sw_iq(7) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(7) = '1' AND dip_sw_capture2q(7) = '1' AND dip_sw_capture3q(7) = '1') THEN
       debounced_dip_sw_iq(7) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 6
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(6)    <= '0';
    dip_sw_capture2q(6)    <= '0';
    dip_sw_capture3q(6)    <= '0';
    debounced_dip_sw_iq(6) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(6)  <= in_dip_sw_i(6)      AFTER 1 PS;
       dip_sw_capture2q(6)  <= dip_sw_capture1q(6) AFTER 1 PS;
       dip_sw_capture3q(6)  <= dip_sw_capture2q(6) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(6) = '0' AND dip_sw_capture2q(6) = '0' AND dip_sw_capture3q(6) = '0') THEN
       debounced_dip_sw_iq(6) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(6) = '1' AND dip_sw_capture2q(6) = '1' AND dip_sw_capture3q(6) = '1') THEN
       debounced_dip_sw_iq(6) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 5
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(5)    <= '0';
    dip_sw_capture2q(5)    <= '0';
    dip_sw_capture3q(5)    <= '0';
    debounced_dip_sw_iq(5) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(5)  <= in_dip_sw_i(5)      AFTER 1 PS;
       dip_sw_capture2q(5)  <= dip_sw_capture1q(5) AFTER 1 PS;
       dip_sw_capture3q(5)  <= dip_sw_capture2q(5) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(5) = '0' AND dip_sw_capture2q(5) = '0' AND dip_sw_capture3q(5) = '0') THEN
       debounced_dip_sw_iq(5) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(5) = '1' AND dip_sw_capture2q(5) = '1' AND dip_sw_capture3q(5) = '1') THEN
       debounced_dip_sw_iq(5) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 4
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(4)    <= '0';
    dip_sw_capture2q(4)    <= '0';
    dip_sw_capture3q(4)    <= '0';
    debounced_dip_sw_iq(4) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(4)  <= in_dip_sw_i(4)      AFTER 1 PS;
       dip_sw_capture2q(4)  <= dip_sw_capture1q(4) AFTER 1 PS;
       dip_sw_capture3q(4)  <= dip_sw_capture2q(4) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(4) = '0' AND dip_sw_capture2q(4) = '0' AND dip_sw_capture3q(4) = '0') THEN
       debounced_dip_sw_iq(4) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(4) = '1' AND dip_sw_capture2q(4) = '1' AND dip_sw_capture3q(4) = '1') THEN
       debounced_dip_sw_iq(4) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 3
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(3)    <= '0';
    dip_sw_capture2q(3)    <= '0';
    dip_sw_capture3q(3)    <= '0';
    debounced_dip_sw_iq(3) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(3)  <= in_dip_sw_i(3)      AFTER 1 PS;
       dip_sw_capture2q(3)  <= dip_sw_capture1q(3) AFTER 1 PS;
       dip_sw_capture3q(3)  <= dip_sw_capture2q(3) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(3) = '0' AND dip_sw_capture2q(3) = '0' AND dip_sw_capture3q(3) = '0') THEN
       debounced_dip_sw_iq(3) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(3) = '1' AND dip_sw_capture2q(3) = '1' AND dip_sw_capture3q(3) = '1') THEN
       debounced_dip_sw_iq(3) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 2
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(2)    <= '0';
    dip_sw_capture2q(2)    <= '0';
    dip_sw_capture3q(2)    <= '0';
    debounced_dip_sw_iq(2) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(2)  <= in_dip_sw_i(2)      AFTER 1 PS;
       dip_sw_capture2q(2)  <= dip_sw_capture1q(2) AFTER 1 PS;
       dip_sw_capture3q(2)  <= dip_sw_capture2q(2) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(2) = '0' AND dip_sw_capture2q(2) = '0' AND dip_sw_capture3q(2) = '0') THEN
       debounced_dip_sw_iq(2) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(2) = '1' AND dip_sw_capture2q(2) = '1' AND dip_sw_capture3q(2) = '1') THEN
       debounced_dip_sw_iq(2) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 1
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(1)    <= '0';
    dip_sw_capture2q(1)    <= '0';
    dip_sw_capture3q(1)    <= '0';
    debounced_dip_sw_iq(1) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(1)  <= in_dip_sw_i(1)      AFTER 1 PS;
       dip_sw_capture2q(1)  <= dip_sw_capture1q(1) AFTER 1 PS;
       dip_sw_capture3q(1)  <= dip_sw_capture2q(1) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(1) = '0' AND dip_sw_capture2q(1) = '0' AND dip_sw_capture3q(1) = '0') THEN
       debounced_dip_sw_iq(1) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(1) = '1' AND dip_sw_capture2q(1) = '1' AND dip_sw_capture3q(1) = '1') THEN
       debounced_dip_sw_iq(1) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Dip SW 0
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    dip_sw_capture1q(0)    <= '0';
    dip_sw_capture2q(0)    <= '0';
    dip_sw_capture3q(0)    <= '0';
    debounced_dip_sw_iq(0) <= '0';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       dip_sw_capture1q(0)  <= in_dip_sw_i(0)      AFTER 1 PS;
       dip_sw_capture2q(0)  <= dip_sw_capture1q(0) AFTER 1 PS;
       dip_sw_capture3q(0)  <= dip_sw_capture2q(0) AFTER 1 PS;
    END IF;
    IF (dip_sw_capture1q(0) = '0' AND dip_sw_capture2q(0) = '0' AND dip_sw_capture3q(0) = '0') THEN
       debounced_dip_sw_iq(0) <= '0' AFTER 1 PS;
    ELSIF (dip_sw_capture1q(0) = '1' AND dip_sw_capture2q(0) = '1' AND dip_sw_capture3q(0) = '1') THEN
       debounced_dip_sw_iq(0) <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;

-- Pwr Float PB
PROCESS (clk_i, reset_i)
BEGIN
  IF (reset_i = '1') THEN
    pwr_float_capture1q   <= '1';
    pwr_float_capture2q   <= '1';
    pwr_float_capture3q   <= '1';
    debounced_pwr_float_iq   <= '1';
  ELSIF (clk_i='1' AND clk_i'EVENT) THEN
    IF (twenty_us_pulse = '1') THEN
       pwr_float_capture1q  <= in_pb_sw_i          AFTER 1 PS;
       pwr_float_capture2q  <= pwr_float_capture1q AFTER 1 PS;
       pwr_float_capture3q  <= pwr_float_capture2q AFTER 1 PS;
    END IF;
    IF (pwr_float_capture1q = '0' AND pwr_float_capture2q = '0' AND pwr_float_capture3q = '0') THEN
       debounced_pwr_float_iq <= '0' AFTER 1 PS;
    ELSIF (pwr_float_capture1q = '1' AND pwr_float_capture2q = '1' AND pwr_float_capture3q = '1') THEN
       debounced_pwr_float_iq <= '1' AFTER 1 PS;
    END IF;
  END IF;
END PROCESS;



-- End logic reset pushbutton/dip switch debounce
--------------------------------------
-- Spare 0 placeholder, allocated for load4 operation...
ddcspare0 <= appcore_load4z_q;      --  Driving to 0 activates load4


-- tp0-2 not used
apps_testpt(0) <=  clk_usb;		 	  
apps_testpt(1) <=  reset_i;
apps_testpt(2) <=  rdy0_tmp;		 
apps_testpt(3) <=  rdy1_tmp;		 
apps_testpt(4) <=  rdy2_tmp;		 
apps_testpt(5) <=  ctl0;		 
apps_testpt(6) <=  ctl1;		 
apps_testpt(7) <=  ctl2;		 
--apps_testpt(0)  <=
--apps_testpt(1)  <=
--apps_testpt(2)  <=
--DWR apps_testpt(3)  <=  appcore_data_valid_q;
--DWR apps_testpt(4)  <=  appcore_dout_a_q(48);                  -- reset button
--DWR apps_testpt(5)  <=  appcore_dout_a_q(32);
--DWR apps_testpt(6)  <=  appcore_dout_a_q(16);
--DWR apps_testpt(7)  <=  appcore_dout_a_q(0);
apps_testpt(8)  <=  appcore_data_valid_q;
apps_testpt(9)  <=  appcore_dout_b_q(63);
apps_testpt(10) <=  appcore_dout_b_q(47);
apps_testpt(11) <=  appcore_dout_b_q(31);
apps_testpt(12) <=  appcore_dout_b_q(15);
apps_testpt(13) <=  appcore_data_valid_q;
apps_testpt(14) <=  appcore_dout_c_q(48);
apps_testpt(15) <=  appcore_dout_c_q(32);
apps_testpt(16) <=  appcore_dout_c_q(16);
apps_testpt(17) <=  appcore_dout_c_q(0);
apps_testpt(18) <=  appcore_data_valid_q;
apps_testpt(19) <=  appcore_dout_d_q(63);
apps_testpt(20) <=  appcore_dout_d_q(47);
apps_testpt(21) <=  appcore_dout_d_q(31);
apps_testpt(22) <=  appcore_dout_d_q(15);
apps_testpt(23) <=  appcore_blkmd_q(0);
apps_testpt(24) <=  appcore_blkmd_q(1);
apps_testpt(25) <=  appcore_blkad_q(0);
apps_testpt(26) <=  appcore_blkad_q(1);
apps_testpt(27) <=  appcore_rowmd_q(0);
apps_testpt(28) <=  appcore_rowmd_q(1);
apps_testpt(29) <=  appcore_rowad_q(0);
apps_testpt(30) <=  appcore_rowad_q(1);


-- -- tp0-2 not used
-- --apps_testpt(0)  <=
-- --apps_testpt(1)  <=
-- --apps_testpt(2)  <=
-- apps_testpt(3)  <=  apps_logic_rstz;
-- apps_testpt(4)  <=  reset_i;                  -- reset button
-- apps_testpt(5)  <=  io_pll_reset;
-- apps_testpt(6)  <=  '0';
-- apps_testpt(7)  <=  appsfpga_io_pwr_floatz_q;
-- apps_testpt(8)  <=  appcore_ns_flip_q;
-- apps_testpt(9)  <=  '0';       -- AppsFPGA PLL locked
-- apps_testpt(10) <=  clk_i_div;
-- apps_testpt(11) <=  clk_g_div;
-- apps_testpt(12) <=  in_init_active_i;
-- -- apps_testpt(13) <=  appsfpga_io_dvalid_ap;
-- -- apps_testpt(14) <=  appsfpga_io_dvalid_bp;
-- -- apps_testpt(15) <=  appsfpga_io_dvalid_cp;
-- -- apps_testpt(16) <=  appsfpga_io_dvalid_dp;
-- apps_testpt(13) <=  '0';
-- apps_testpt(14) <=  '0';
-- apps_testpt(15) <=  '0';
-- apps_testpt(16) <=  '0';
-- apps_testpt(17) <=  appcore_dout_a_q(0);
-- apps_testpt(18) <=  appcore_dout_a_q(1);
-- apps_testpt(19) <=  appcore_dout_a_q(2);
-- apps_testpt(20) <=  appcore_dout_a_q(3);
-- apps_testpt(21) <=  appcore_rowmd_q(0);
-- apps_testpt(22) <=  appcore_rowmd_q(1);
-- apps_testpt(23) <=  appcore_blkmd_q(0);
-- apps_testpt(24) <=  appcore_blkmd_q(1);
-- apps_testpt(25) <=  appcore_blkad_q(0);
-- apps_testpt(26) <=  appcore_blkad_q(1);
-- apps_testpt(27) <=  appcore_blkad_q(2);
-- apps_testpt(28) <=  appcore_blkad_q(3);
-- --apps_testpt(29) <=  ;
-- --apps_testpt(30) <=  ;

--apps_testpt(0) <= appsfpga_io_locked;
--apps_testpt(1) <= appsfpga_io_init_active;
--apps_testpt(2) <= appcore_data_valid_q;
--apps_testpt(3) <= appcore_rowmd_q(0);
--apps_testpt(4) <= appcore_rowmd_q(1);
--apps_testpt(5) <= appcore_rowad_q(0);
--apps_testpt(6) <= appcore_rowad_q(1);
--apps_testpt(7) <= appcore_rowad_q(2);
--apps_testpt(8) <= appcore_rowad_q(3);
--apps_testpt(9) <= appcore_rowad_q(4);
--apps_testpt(10) <= appcore_rowad_q(5);
--apps_testpt(11) <= appcore_blkmd_q(0);
--apps_testpt(12) <= appcore_blkmd_q(1);
--apps_testpt(13) <= appcore_blkad_q(0);
--apps_testpt(14) <= appcore_blkad_q(1);
--apps_testpt(15) <= appcore_blkad_q(2);
--apps_testpt(16) <= appcore_blkad_q(3);
--apps_testpt(17) <= appcore_dout_a_q(0);
--apps_testpt(18) <= appcore_dout_a_q(1);
--apps_testpt(19) <= appcore_dout_a_q(2);
--apps_testpt(20) <= appcore_dout_a_q(3);
--apps_testpt(21) <= appcore_dout_a_q(4);
--apps_testpt(22) <= appcore_dout_a_q(5);
--apps_testpt(23) <= appcore_dout_a_q(6);
--apps_testpt(24) <= appcore_dout_a_q(7);
--apps_testpt(25) <= appcore_dout_a_q(8);
--apps_testpt(26) <= appcore_dout_a_q(9);
--apps_testpt(27) <= appcore_dout_a_q(10);
--apps_testpt(28) <= appcore_dout_a_q(11);
--apps_testpt(29) <= appcore_dout_a_q(12);
--apps_testpt(30) <= appcore_dout_a_q(13);

END Behavioral;
