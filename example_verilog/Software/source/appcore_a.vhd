--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    appcore_a.vhd - Behavioral
-- Project Name:   appsfpga (Applications FPGA)
-- Description: This is the architecture for module appcore, which simply
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

ARCHITECTURE Behavioral OF appcore IS

-- Original TPG/apps components ----------------------------------
COMPONENT pgen
PORT (clk_g                      : IN STD_LOGIC;
      locked_init_rstz_gq        : IN STD_LOGIC;
      pll_locked_rstz_gq         : IN STD_LOGIC;
      init_active_gq             : IN STD_LOGIC;
      cnts_active_cnt_q          : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
      cnts_active_cnten_q        : IN STD_LOGIC;
      cnts_pattern_cnt_q         : IN STD_LOGIC_VECTOR (26 DOWNTO 0);
      appsfpga_io_comp_data_en_q : IN STD_LOGIC;
      appsfpga_io_ns_flip_en_q   : IN STD_LOGIC;
      appsfpga_io_reset_type_q   : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      appsfpga_io_rowaddrmode_q  : IN STD_LOGIC;
      appsfpga_io_WDT_enbl_q     : IN STD_LOGIC;
      appsfpga_io_STEP_VCC_enbl_q: IN STD_LOGIC;
      appsfpga_io_float_q        : IN STD_LOGIC;
      in_dmd_type                : IN STD_LOGIC_VECTOR( 3 DOWNTO 0 );
      -- new
      usb_pattern_force          : IN STD_LOGIC;
      usb_pattern_nmbr           : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      
      pgen_data_valid_q          : OUT STD_LOGIC;
      pgen_dout_a_q              : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_dout_b_q              : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_dout_c_q              : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_dout_d_q              : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      pgen_rowmd_q               : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_rowad_q               : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      pgen_blkad_q               : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_blkmd_q               : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_comp_data_q           : OUT STD_LOGIC;
      pgen_ns_flip_q             : OUT STD_LOGIC;
      pgen_STEP_VCC_q            : OUT STD_LOGIC;
      pgen_rst2blkz_q            : OUT STD_LOGIC
      );
END COMPONENT;

COMPONENT cnts
PORT (clk_g                   : IN STD_LOGIC;
      locked_init_rstz_gq     : IN STD_LOGIC;
      appsfpga_io_cnthalt_q   : IN STD_LOGIC;
         dvalid_space_info   : OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
      in_dmd_type             : IN STD_LOGIC_VECTOR( 3 DOWNTO 0 );
      cnts_active_cnt_q       : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
      cnts_active_cnten_q     : OUT STD_LOGIC;
      cnts_pattern_cnt_q      : OUT STD_LOGIC_VECTOR (26 DOWNTO 0)
      );
END COMPONENT;

-- New gui apps components ----------------------------------------
COMPONENT DMD_control 
    PORT ( system_clk                           : IN    STD_LOGIC;
           system_reset                         : IN    STD_LOGIC;
           start_block_write                    : IN    STD_LOGIC;
           DMD_RowLoads                         : IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
           dmd_1080p_connected                  : IN    STD_LOGIC;	   
           quarter_buss_connected               : IN    STD_LOGIC;
           
           fifo_ab_data_out                     : IN    STD_LOGIC_VECTOR(127 DOWNTO 0);
           fifo_cd_data_out                     : IN    STD_LOGIC_VECTOR(127 DOWNTO 0);
           dmd_row_fifo_reset                   : IN    STD_LOGIC;
           dmd_get_row_data                     : OUT   STD_LOGIC;
           gpio_external_reset                  : IN    STD_LOGIC;
           external_reset_enable                : IN    STD_LOGIC;
           --DDC control
           ddc_init_active                      : IN    STD_LOGIC;
           dmd_dout_a                           : OUT   STD_LOGIC_VECTOR(63 DOWNTO 0);
           dmd_dout_b                           : OUT   STD_LOGIC_VECTOR(63 DOWNTO 0);
           dmd_dout_c                           : OUT   STD_LOGIC_VECTOR(63 DOWNTO 0);
           dmd_dout_d                           : OUT   STD_LOGIC_VECTOR(63 DOWNTO 0);
           dmd_dvalid                           : OUT   STD_LOGIC
           );

END COMPONENT;

COMPONENT USB_IO_CLK
    PORT ( 
           --CLOCKS
           ifclk                                : IN    STD_LOGIC;
           system_clk                           : IN    STD_LOGIC;
        
           --RESETS
           reset_i                              : IN    STD_LOGIC;
           system_reset                         : IN    STD_LOGIC;
           
           --PORTS
           bidir                                : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           fifo_wen                             : IN    STD_LOGIC;
           fifo_ren                             : IN    STD_LOGIC;
           fifo_regn                            : IN    STD_LOGIC;
        
           dmd_1080p_connected                  : IN    STD_LOGIC;
		   
           --DMD ROW 
           fifo_ab_data_out                     : OUT   STD_LOGIC_VECTOR(127 DOWNTO 0);
           fifo_cd_data_out                     : OUT   STD_LOGIC_VECTOR(127 DOWNTO 0);
           dmd_get_row_data                     : IN    STD_LOGIC;
           dmd_row_fifo_reset                   : IN    STD_LOGIC;

           --Register Data
           reg_data_from_USB                    : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
           reg_data_to_USB                      : IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
           reg_addra_USB                        : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0);
           reg_data_valid                       : OUT   STD_LOGIC
           );    
END COMPONENT;

COMPONENT D4100_registers
    PORT ( system_clk                           : IN    STD_LOGIC;
           system_reset                         : IN    STD_LOGIC;

         pll_speed_info      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
         dvalid_space_info   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
         BUILD_NUMBER        : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);

           --USB interface
           reg_address                          : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
           reg_write_data                       : IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
           write_reg_vail                       : IN    STD_LOGIC;
           reg_read_data                        : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
           fifo_reset                           : OUT   STD_LOGIC;
        
           gpio_out                             : OUT   STD_LOGIC_VECTOR(2 DOWNTO 0);
           gpio_in                              : IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
           gpio_external_reset                  : IN    STD_LOGIC;
           external_reset_enable                : OUT   STD_LOGIC;
           GPIO_reset_complete                  : OUT   STD_LOGIC;
        
           --DDC Control
           DMD_type                             : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
           DDC_version                          : IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
           DMD_blk_md                           : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);
           DMD_blk_ad                           : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
           DMD_row_md                           : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);
           DMD_row_ad                           : OUT   STD_LOGIC_VECTOR(10 DOWNTO 0);
           DMD_pwr_float                        : OUT   STD_LOGIC;
           DMD_wdt                              : OUT   STD_LOGIC;
           DMD_ns_flip                          : OUT   STD_LOGIC;
           DMD_comp_data                        : OUT   STD_LOGIC;
           DMD_step_vcc                         : OUT   STD_LOGIC;
          -- DMD_ext_reset                        : OUT   STD_LOGIC;
           DMD_rst2blkz                         : OUT   STD_LOGIC;
           -- 
           load4_en                             : OUT STD_LOGIC;
           tpg_en                               : OUT STD_LOGIC; 
           pattern_force                        : OUT STD_LOGIC;
           switch_en                            : OUT STD_LOGIC;
           pattern_nmbr                         : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
           swtch_override_val                   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
 
           DMD_RowLoads                         : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
           dmd_write_block                      : OUT   STD_LOGIC);
END COMPONENT;

--- TPG Apps signals
SIGNAL cnts_active_cnt_q         : STD_LOGIC_VECTOR (4 DOWNTO 0);
SIGNAL cnts_active_cnten_q       : STD_LOGIC;
SIGNAL cnts_blank_cnt_q          : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL cnts_blank_cnten_q        : STD_LOGIC;
SIGNAL cnts_pattern_cnt_q        : STD_LOGIC_VECTOR (26 DOWNTO 0);
SIGNAL pgen_data_valid_q         : STD_LOGIC;
SIGNAL pgen_dout_a_q             : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL pgen_dout_b_q             : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL pgen_dout_c_q             : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL pgen_dout_d_q             : STD_LOGIC_VECTOR (63 DOWNTO 0);
SIGNAL pgen_rowmd_q              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL pgen_rowad_q              : STD_LOGIC_VECTOR (10 DOWNTO 0);
SIGNAL pgen_blkad_q              : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL pgen_blkmd_q              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL pgen_comp_data_q          : STD_LOGIC;
SIGNAL pgen_ns_flip_q            : STD_LOGIC;
SIGNAL pgen_STEP_VCC_q           : STD_LOGIC;
SIGNAL pgen_rst2blkz_q           : STD_LOGIC;
SIGNAL locked_init_rstz_gq       : STD_LOGIC;

-- New gui signals --------------

  -- DMD control signals
SIGNAL dmd_write_block              : STD_LOGIC;
SIGNAL DMD_RowLoads                 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL full_buss_connected          : STD_LOGIC;
SIGNAL quarter_buss_connected          : STD_LOGIC;

SIGNAL fifo_ab_data_out             : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL fifo_cd_data_out             : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL dmd_row_fifo_reset           : STD_LOGIC;
SIGNAL dmd_get_row_data             : STD_LOGIC;
SIGNAL gpio_external_reset          : STD_LOGIC;
SIGNAL external_reset_enable        : STD_LOGIC;
SIGNAL gui_dmd_dout_a               : STD_LOGIC_VECTOR(63 DOWNTO 0);  
SIGNAL gui_dmd_dout_b               : STD_LOGIC_VECTOR(63 DOWNTO 0); 
SIGNAL gui_dmd_dout_c               : STD_LOGIC_VECTOR(63 DOWNTO 0); 
SIGNAL gui_dmd_dout_d               : STD_LOGIC_VECTOR(63 DOWNTO 0); 
SIGNAL gui_dmd_dvalid               : STD_LOGIC;                    

   --- USB Comm signals
SIGNAL ifclk                         : STD_LOGIC;
SIGNAL fifo_wen                      : STD_LOGIC;
SIGNAL fifo_ren                      : STD_LOGIC;
SIGNAL fifo_regn                     : STD_LOGIC;
SIGNAL reg_data_from_USB             : STD_LOGIC_VECTOR(15 DOWNTO 0); 
SIGNAL reg_data_to_USB               : STD_LOGIC_VECTOR(15 DOWNTO 0);              
SIGNAL reg_addra_USB                 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL reg_data_valid                : STD_LOGIC;

   --- D4100 Register signals
--SIGNAL   pll_speed_info      :  STD_LOGIC_VECTOR(1 DOWNTO 0); -- comes from input to this module from appsfpga_io
SIGNAL   dvalid_space_info   :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL   BUILD_NUMBER        :  STD_LOGIC_VECTOR(7 DOWNTO 0) := x"0D";

SIGNAL gpio_out                  : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL gpio_in                   : STD_LOGIC_VECTOR(2 DOWNTO 0);
-- redeclared ??  SIGNAL GPIO_reset_complete_o     : STD_LOGIC;
SIGNAL gui_blkmd                 : STD_LOGIC_VECTOR(1 DOWNTO 0);     -- *To be Muxed
SIGNAL gui_blkad                 : STD_LOGIC_VECTOR(3 DOWNTO 0);     -- *To be Muxed
SIGNAL gui_rowmd                 : STD_LOGIC_VECTOR(1 DOWNTO 0);     -- *To be Muxed
SIGNAL gui_rowad                 : STD_LOGIC_VECTOR(10 DOWNTO 0);    -- *To be Muxed
--SIGNAL appscore_pwr_floatz_q     : STD_LOGIC;   -- * (goes to IO)
SIGNAL gui_wdt_enablez_q         : STD_LOGIC;   -- *To be Muxed
SIGNAL gui_ns_flip               : STD_LOGIC;   -- *To be Muxed
SIGNAL gui_comp_data             : STD_LOGIC;   -- *To be Muxed
--SIGNAL DMD_ext_reset             : STD_LOGIC;   -- *To be Muxed??
SIGNAL gui_rst2blkz              : STD_LOGIC;   -- *To be Muxed
SIGNAL gui_pwr_floatz_q          : STD_LOGIC;

SIGNAL tcexpire                  : STD_LOGIC;

SIGNAL gui_load4_en              : STD_LOGIC;
SIGNAL usb_tpg_en                : STD_LOGIC; 
SIGNAL usb_pattern_force         : STD_LOGIC;
SIGNAL usb_switch_en             : STD_LOGIC;
SIGNAL usb_pattern_nmbr          : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL usb_swtch_override_val    : STD_LOGIC_VECTOR(7 DOWNTO 0);  

SIGNAL muxed_comp_data_en_q      : STD_LOGIC; 
SIGNAL muxed_ns_flip_en_q        : STD_LOGIC; 
SIGNAL muxed_reset_type_q        : STD_LOGIC_VECTOR(1 DOWNTO 0); 
SIGNAL muxed_rowaddr_mode_q      : STD_LOGIC; 
SIGNAL muxed_wdt_en_q            : STD_LOGIC; 
SIGNAL muxed_cnthalt_q           : STD_LOGIC;
SIGNAL muxed_mirror_float_q      : STD_LOGIC;

SIGNAL muxed_out_data_valid_q        : STD_LOGIC;
SIGNAL muxed_out_dout_a_q            : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL muxed_out_dout_b_q            : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL muxed_out_dout_c_q            : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL muxed_out_dout_d_q            : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL muxed_out_rowmd_q             : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL muxed_out_rowad_q             : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL muxed_out_blkmd_q             : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL muxed_out_blkad_q             : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL muxed_out_comp_data_q         : STD_LOGIC;
SIGNAL muxed_out_ns_flip_q           : STD_LOGIC;
SIGNAL muxed_out_rst2blkz_q          : STD_LOGIC;
SIGNAL muxed_out_load4_q             : STD_LOGIC;

SIGNAL system_reset                  : STD_LOGIC;

BEGIN

-- Adding the new USB functionality
system_reset              <=  NOT pll_locked_rstz_gq;
                                                        
DMD_CONTROL_INST : DMD_control 
  PORT MAP (system_clk                 => clk_g,                       
            system_reset               => system_reset,              
            start_block_write          => dmd_write_block,
            DMD_RowLoads               => DMD_RowLoads,
            dmd_1080p_connected        => full_buss_connected,
           quarter_buss_connected     => quarter_buss_connected ,
            fifo_ab_data_out           => fifo_ab_data_out,
            fifo_cd_data_out           => fifo_cd_data_out,
            dmd_row_fifo_reset         => dmd_row_fifo_reset,
            dmd_get_row_data           => dmd_get_row_data,
            gpio_external_reset        => gpio_external_reset,
            external_reset_enable      => external_reset_enable,
            ddc_init_active            => init_active_gq,
            dmd_dout_a                 => gui_dmd_dout_a,
            dmd_dout_b                 => gui_dmd_dout_b,
            dmd_dout_c                 => gui_dmd_dout_c,
            dmd_dout_d                 => gui_dmd_dout_d,
            dmd_dvalid                 => gui_dmd_dvalid
);
                                
USB_COMM : USB_IO_CLK
  PORT MAP (ifclk                      => ifclk,
            system_clk                 => clk_g, 
            reset_i                    => reset_i,
            system_reset               => system_reset,
            bidir                      => bidir,
            fifo_wen                   => fifo_wen,
            fifo_ren                   => fifo_ren,
            fifo_regn                  => fifo_regn,
            dmd_1080p_connected        => full_buss_connected,
            fifo_ab_data_out           => fifo_ab_data_out,
            fifo_cd_data_out           => fifo_cd_data_out,
            dmd_get_row_data           => dmd_get_row_data,
            dmd_row_fifo_reset         => dmd_row_fifo_reset,
            reg_data_from_USB          => reg_data_from_USB,
            reg_data_to_USB            => reg_data_to_USB,
            reg_addra_USB              => reg_addra_USB,
            reg_data_valid             => reg_data_valid);
        
USB_REG_INST : D4100_registers
  PORT MAP (system_clk                 => clk_g,
            system_reset               => system_reset,              

         pll_speed_info    => pll_speed_info,    -- :  STD_LOGIC_VECTOR(1 DOWNTO 0);
         dvalid_space_info => dvalid_space_info, -- :  STD_LOGIC_VECTOR(3 DOWNTO 0);
         BUILD_NUMBER      => BUILD_NUMBER,      -- :  STD_LOGIC_VECTOR(7 DOWNTO 0);

            reg_address                => reg_addra_USB,
            reg_write_data             => reg_data_from_USB,
            write_reg_vail             => reg_data_valid,
            reg_read_data              => reg_data_to_USB,
            fifo_reset                 => dmd_row_fifo_reset,
            gpio_out                   => gpio_out,
            gpio_in                    => gpio_in,
            gpio_external_reset        => gpio_external_reset,
            external_reset_enable      => external_reset_enable,
            GPIO_reset_complete        => GPIO_reset_complete_o,
            DMD_type                   => in_dmd_type,      
            DDC_version                => in_ddc_version,
            DMD_blk_md                 => gui_blkmd,            -- rename this and mux ???
            DMD_blk_ad                 => gui_blkad,             -- rename this and mux ???
            DMD_row_md                 => gui_rowmd,       -- rename this and mux ???             
            DMD_row_ad                 => gui_rowad,        -- rename this and mux ???
            DMD_pwr_float              => gui_pwr_floatz_q,  -- rename this and mux ???
            DMD_wdt                    => gui_wdt_enablez_q,  -- rename this and mux ???
            DMD_ns_flip                => gui_ns_flip,        -- rename this and mux ???
            DMD_comp_data              => gui_comp_data,     -- rename this and mux ???
            DMD_step_vcc               => OPEN,     
           -- DMD_ext_reset              => DMD_ext_reset,
            DMD_rst2blkz               => gui_rst2blkz,   -- rename this and mux ???
            load4_en                   => gui_load4_en,  -- rename this and mux ???
            tpg_en                     => usb_tpg_en,   
            pattern_force              => usb_pattern_force,   
            switch_en                  => usb_switch_en,   
            pattern_nmbr               => usb_pattern_nmbr,   
            swtch_override_val         => usb_swtch_override_val,        
            DMD_RowLoads               => DMD_RowLoads,
            dmd_write_block            => dmd_write_block);

  -- Gui Signal rename section
      -- DMD type:
    -- 0000   .95" 1080p Type A (Full Bus)
    -- 0001   .7" XGA Type A
    -- 0010   .55" XGA Type A
    -- 0011   .55" XGA Type X
    -- 0100   .65" 1080p Diamond (Not supported in phase 1)
    -- 0101   .95" WUXGA Type A (Full Bus)
    -- 0111   .65 WXGA NIR      (Quarter Bus)

full_buss_connected     <= '1' WHEN  (in_dmd_type = "0000" OR in_dmd_type = "0101") ELSE
                           '0';

quarter_buss_connected  <= '1' WHEN   in_dmd_type = "0111" ELSE
                            '0';
						 

  fifo_wen                <= ctl0;
  fifo_ren                <= ctl1;                   
  fifo_regn               <= ctl2;
  ifclk                   <= clk_usb;
  gpio_in                 <= GPIOA_i;
  GPIOA_o                 <= gpio_out;
  gpio_external_reset     <= GPIO_EXT_REST_in;

  rdy0                    <= '1';
  rdy1                    <= '1';
  tcexpire                <= '0';
  rdy2                    <= tcexpire;


--- Original tpg/apps function
i_pgen : pgen
PORT MAP (clk_g                            => clk_g,
          locked_init_rstz_gq              => locked_init_rstz_gq,
          pll_locked_rstz_gq               => pll_locked_rstz_gq,
          init_active_gq                   => init_active_gq,
          cnts_active_cnt_q (4 DOWNTO 0)   => cnts_active_cnt_q (4 DOWNTO 0),
          cnts_active_cnten_q              => cnts_active_cnten_q,
          cnts_pattern_cnt_q (26 DOWNTO 0) => cnts_pattern_cnt_q (26 DOWNTO 0),
          appsfpga_io_comp_data_en_q       => muxed_comp_data_en_q,
          appsfpga_io_ns_flip_en_q         => muxed_ns_flip_en_q,
          appsfpga_io_reset_type_q         => muxed_reset_type_q,
          appsfpga_io_WDT_enbl_q           => muxed_wdt_en_q,
          appsfpga_io_STEP_VCC_enbl_q      => appsfpga_io_STEP_VCC_enbl_q,
          appsfpga_io_float_q              => muxed_mirror_float_q,
          in_dmd_type                      => in_dmd_type,
          -- new
          usb_pattern_force                => usb_pattern_force,  -- IN STD_LOGIC;
          usb_pattern_nmbr                 => usb_pattern_nmbr,  -- IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          --
          appsfpga_io_rowaddrmode_q        => muxed_rowaddr_mode_q,
          pgen_data_valid_q                => pgen_data_valid_q,
          pgen_dout_a_q (63 DOWNTO 0)      => pgen_dout_a_q (63 DOWNTO 0),
          pgen_dout_b_q (63 DOWNTO 0)      => pgen_dout_b_q (63 DOWNTO 0),
          pgen_dout_c_q (63 DOWNTO 0)      => pgen_dout_c_q (63 DOWNTO 0),
          pgen_dout_d_q (63 DOWNTO 0)      => pgen_dout_d_q (63 DOWNTO 0),
          pgen_rowmd_q  (1 DOWNTO 0)       => pgen_rowmd_q  (1 DOWNTO 0),
          pgen_rowad_q  (10 DOWNTO 0)      => pgen_rowad_q  (10 DOWNTO 0),
          pgen_blkad_q  (3 DOWNTO 0)       => pgen_blkad_q  (3 DOWNTO 0),
          pgen_blkmd_q  (1 DOWNTO 0)       => pgen_blkmd_q  (1 DOWNTO 0),
          pgen_comp_data_q                 => pgen_comp_data_q,
          pgen_ns_flip_q                   => pgen_ns_flip_q,
          pgen_STEP_VCC_q                  => pgen_STEP_VCC_q,
          pgen_rst2blkz_q                  => pgen_rst2blkz_q
          );

-- Process combining active and reset for use in CNTS block
PROCESS (clk_g, pll_locked_rstz_gq, init_active_gq)
  BEGIN
    IF (pll_locked_rstz_gq = '0' OR init_active_gq = '1') THEN
      locked_init_rstz_gq <= '0';
    ELSIF (clk_g = '1' AND clk_g'EVENT) THEN
      locked_init_rstz_gq <= '1'AFTER 1 PS;
   END IF;
END PROCESS;

-- Switch selection mux
-- This mux (toggled by the USB switch select register) picks the source for the switch inputs. 
-- If the sw_en is selected (the default mode) the externa; dip switch is used as the source
-- for the switch values.  If sw_en = 0, the internal USB register values are used for the 
-- switch settings.

PROCESS (clk_g) --, locked_init_rstz_gq)
  BEGIN
  --  IF (locked_init_rstz_gq = '0') THEN
  --    muxed_comp_data_en_q   <= appsfpga_io_comp_data_en_q;
  --    muxed_ns_flip_en_q     <= appsfpga_io_ns_flip_en_q;
  --    muxed_reset_type_q     <= appsfpga_io_reset_type_q;
  --    muxed_rowaddr_mode_q   <= appsfpga_io_rowaddrmode_q;
  --    muxed_wdt_en_q         <= appsfpga_io_WDT_enbl_q;
  --    muxed_cnthalt_q        <= appsfpga_io_cnthalt_q;
  --    muxed_mirror_float_q   <= appsfpga_io_float_q;
  ----  ELSIF (clk_g = '1' AND clk_g'EVENT) THEN
    IF (clk_g = '1' AND clk_g'EVENT) THEN
      IF (usb_switch_en = '1') THEN
        muxed_comp_data_en_q  <= appsfpga_io_comp_data_en_q AFTER 1 PS; 
        muxed_ns_flip_en_q    <= appsfpga_io_ns_flip_en_q   AFTER 1 PS;   
        muxed_reset_type_q    <= appsfpga_io_reset_type_q   AFTER 1 PS;   
        muxed_rowaddr_mode_q  <= appsfpga_io_rowaddrmode_q  AFTER 1 PS; 
        muxed_wdt_en_q        <= appsfpga_io_WDT_enbl_q     AFTER 1 PS;       
        muxed_cnthalt_q       <= appsfpga_io_cnthalt_q      AFTER 1 PS;      
        muxed_mirror_float_q  <= appsfpga_io_float_q        AFTER 1 PS;
      ELSE
        muxed_comp_data_en_q  <= usb_swtch_override_val(2) AFTER 1 PS; 
        muxed_ns_flip_en_q    <= usb_swtch_override_val(3) AFTER 1 PS;   
        muxed_reset_type_q    <= usb_swtch_override_val(5 DOWNTO 4) AFTER 1 PS;   
        muxed_rowaddr_mode_q  <= usb_swtch_override_val(6) AFTER 1 PS; 
        muxed_wdt_en_q        <= usb_swtch_override_val(7) AFTER 1 PS;       
        muxed_cnthalt_q       <= usb_swtch_override_val(1) AFTER 1 PS;      
        muxed_mirror_float_q  <= usb_swtch_override_val(0) AFTER 1 PS; 
      END IF;
   END IF;
END PROCESS;

-- Output data_ctrl_mux:  This selects whether the data output from appcore 
-- comes from the USB/apps blocks ot the TPG (default).
PROCESS (clk_g) --, locked_init_rstz_gq)
  BEGIN
  
--  IF (locked_init_rstz_gq = '0') THEN -- WHY IS Force to this value??   Probably not needed.
--    muxed_out_data_valid_q        <= pgen_data_valid_q ;  -- STD_LOGIC;
--    muxed_out_dout_a_q            <= pgen_dout_a_q;  -- STD_LOGIC_VECTOR(63 DOWNTO 0);
--    muxed_out_dout_b_q            <= pgen_dout_b_q;  -- STD_LOGIC_VECTOR(63 DOWNTO 0);
--    muxed_out_dout_c_q            <= pgen_dout_c_q;  -- STD_LOGIC_VECTOR(63 DOWNTO 0);
--    muxed_out_dout_d_q            <= pgen_dout_d_q;  -- STD_LOGIC_VECTOR(63 DOWNTO 0);
--    muxed_out_rowmd_q             <= pgen_rowmd_q;  -- STD_LOGIC_VECTOR(1 DOWNTO 0);
--    muxed_out_rowad_q             <= pgen_rowad_q;  -- STD_LOGIC_VECTOR(10 DOWNTO 0);
--    muxed_out_blkmd_q             <= pgen_blkmd_q;  -- STD_LOGIC_VECTOR(1 DOWNTO 0);
--    muxed_out_blkad_q             <= pgen_blkad_q;  -- STD_LOGIC_VECTOR(3 DOWNTO 0);
--    muxed_out_comp_data_q         <= pgen_comp_data_q;      
--    muxed_out_ns_flip_q           <= pgen_ns_flip_q;      
--    muxed_out_rst2blkz_q          <= pgen_rst2blkz_q;
--    muxed_out_load4_q             <= '0'  AFTER 1 PS;
--  ELSIF (clk_g = '1' AND clk_g'EVENT) THEN	
    IF (clk_g = '1' AND clk_g'EVENT) THEN
      IF (usb_tpg_en = '1') THEN
        muxed_out_data_valid_q        <= pgen_data_valid_q AFTER 1 PS;
        muxed_out_dout_a_q            <= pgen_dout_a_q AFTER 1 PS; 
        muxed_out_dout_b_q            <= pgen_dout_b_q AFTER 1 PS; 
        muxed_out_dout_c_q            <= pgen_dout_c_q AFTER 1 PS;
        muxed_out_dout_d_q            <= pgen_dout_d_q AFTER 1 PS;     
        muxed_out_rowmd_q             <= pgen_rowmd_q AFTER 1 PS;    
        muxed_out_rowad_q             <= pgen_rowad_q AFTER 1 PS;
        muxed_out_blkmd_q             <= pgen_blkmd_q AFTER 1 PS;      
        muxed_out_blkad_q             <= pgen_blkad_q AFTER 1 PS;
        muxed_out_comp_data_q         <= pgen_comp_data_q AFTER 1 PS;
        muxed_out_ns_flip_q           <= pgen_ns_flip_q AFTER 1 PS;
        muxed_out_rst2blkz_q          <= pgen_rst2blkz_q AFTER 1 PS;
        muxed_out_load4_q             <= '0' AFTER 1 PS;
      ELSE
        muxed_out_data_valid_q        <= gui_dmd_dvalid AFTER 1 PS;
        muxed_out_dout_a_q            <= gui_dmd_dout_a AFTER 1 PS; 
        muxed_out_dout_b_q            <= gui_dmd_dout_b AFTER 1 PS; 
        muxed_out_dout_c_q            <= gui_dmd_dout_c AFTER 1 PS;
        muxed_out_dout_d_q            <= gui_dmd_dout_d AFTER 1 PS;     
        muxed_out_rowmd_q             <= gui_rowmd AFTER 1 PS;    
        muxed_out_rowad_q             <= gui_rowad AFTER 1 PS;
        muxed_out_blkmd_q             <= gui_blkmd AFTER 1 PS;      
        muxed_out_blkad_q             <= gui_blkad AFTER 1 PS;
        muxed_out_comp_data_q         <= gui_comp_data AFTER 1 PS;        
        muxed_out_ns_flip_q           <= gui_ns_flip AFTER 1 PS;        
        muxed_out_rst2blkz_q          <= gui_rst2blkz AFTER 1 PS;
        muxed_out_load4_q             <= gui_load4_en AFTER 1 PS;
      END IF;
    END IF;
END PROCESS;


i_cnts : cnts
PORT MAP (clk_g                            => clk_g,
          locked_init_rstz_gq              => locked_init_rstz_gq,
          appsfpga_io_cnthalt_q            => appsfpga_io_cnthalt_q,
          in_dmd_type                      => in_dmd_type,
         dvalid_space_info => dvalid_space_info, -- :  STD_LOGIC_VECTOR(3 DOWNTO 0);
          cnts_active_cnt_q (4 DOWNTO 0)   => cnts_active_cnt_q (4 DOWNTO 0),
          cnts_active_cnten_q              => cnts_active_cnten_q,
          cnts_pattern_cnt_q (26 DOWNTO 0) => cnts_pattern_cnt_q (26 DOWNTO 0)
          );

-- Output signal renaming section  
appcore_data_valid_q   <= muxed_out_data_valid_q;
appcore_dout_a_q       <= muxed_out_dout_a_q;
appcore_dout_b_q       <= muxed_out_dout_b_q;
appcore_dout_c_q       <= muxed_out_dout_c_q;
appcore_dout_d_q       <= muxed_out_dout_d_q;
appcore_rowmd_q        <= muxed_out_rowmd_q;
appcore_rowad_q        <= muxed_out_rowad_q;
appcore_blkad_q        <= muxed_out_blkad_q;
appcore_blkmd_q        <= muxed_out_blkmd_q;
appcore_comp_data_q    <= muxed_out_comp_data_q;
appcore_ns_flip_q      <= muxed_out_ns_flip_q;
appcore_STEP_VCC_q     <= '0';
appcore_rst2blkz_q     <= muxed_out_rst2blkz_q;
appcore_load4z_q       <= NOT(muxed_out_load4_q);
appscore_pwr_floatz_q  <= gui_pwr_floatz_q;

END Behavioral;
