library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

library DDR2;
use DDR2.DDR2_PKG.all;

entity appscore is
    port (
        clk_g                           :in std_logic;
        pll_locked_rstz_gq              :in std_logic;
        init_active_gq                  :in std_logic;
        in_ddc_version                  :in std_logic_vector(2 downto 0);

        mem_clk0				: in STD_LOGIC;
        mem_clk2x				: in STD_LOGIC;
        mem_clk2x90			: in STD_LOGIC;
        mem_clk200         : in STD_LOGIC;
        pll_mem_locked     : in STD_LOGIC;

        pll_speed_info                  :in std_logic_vector(1 downto 0);

        --user inputs
        in_dmd_type                     :in std_logic_vector(3 downto 0);
        appsfpga_io_comp_data_en_q 		 :in std_logic;
        appsfpga_io_ns_flip_en_q   		 :in std_logic;
        appsfpga_io_cnthalt_q      	 	 :in std_logic;
        appsfpga_io_reset_type_q   	 	 :in std_logic_vector(1 downto 0);
--        appsfpga_io_init_active    :in std_logic;
        appsfpga_io_rowaddrmode_q  		 :in std_logic;
        appsfpga_io_WDT_enbl_q     		 :in std_logic;
        appsfpga_io_STEP_VCC_enbl_q	 	 :in std_logic;
        appsfpga_io_float_q        		 :in std_logic;
        
        --data and control output values
        appcore_data_valid_q       : out std_logic;
        appcore_dout_a_q           : out std_logic_vector(63 DOWNTO 0);
        appcore_dout_b_q           : out std_logic_vector(63 DOWNTO 0);
        appcore_dout_c_q           : out std_logic_vector(63 DOWNTO 0);
        appcore_dout_d_q           : out std_logic_vector(63 DOWNTO 0);
        appcore_rowmd_q            : out std_logic_vector(1 DOWNTO 0);
        appcore_rowad_q            : out std_logic_vector(10 DOWNTO 0);
        appcore_blkad_q            : out std_logic_vector(3 DOWNTO 0);
        appcore_blkmd_q            : out std_logic_vector(1 DOWNTO 0);

        --outputs determined by user inputs
        appcore_comp_data_q        : out std_logic;
        appcore_ns_flip_q          : out std_logic;
        appcore_STEP_VCC_q         : out std_logic;
        appcore_rst2blkz_q         : out std_logic;
        appscore_pwr_floatz_q      : out std_logic;
        appcore_load4z_q           : out std_logic;
		
        --DDR2 interface
        ddr2_a                          : out std_logic_vector((ROW_WIDTH-1) downto 0);
        ddr2_ba                         : out std_logic_vector((BANK_WIDTH-1) downto 0);
        ddr2_ras_n                      : out std_logic;
        ddr2_cas_n                      : out std_logic;
        ddr2_we_n                       : out std_logic;
        ddr2_cs_n                       : out std_logic_vector((CS_WIDTH-1) downto 0);
        ddr2_odt                        : out std_logic_vector((ODT_WIDTH-1) downto 0);
        ddr2_cke                        : out std_logic_vector((CKE_WIDTH-1) downto 0);
        ddr2_ck                         : out std_logic_vector((CLK_WIDTH-1) downto 0);
        ddr2_ck_n                       : out std_logic_vector((CLK_WIDTH-1) downto 0);
        ddr2_dq                         : inout std_logic_vector((DQ_WIDTH-1) downto 0);
        ddr2_dqs                        : inout std_logic_vector((DQS_WIDTH-1) downto 0);
        ddr2_dqs_n                      : inout std_logic_vector((DQS_WIDTH-1) downto 0);
        ddr2_dm                         : out std_logic_vector((DM_WIDTH-1) downto 0);
		  
		  mem_init_done						 : out std_logic;
		  mem_read_ready					 	 : out std_logic;
 
        --USB interface
        clk_usb                         :in std_logic;
        reset_i                         :in std_logic;
        rdy0                            :out std_logic;
        rdy1                            :out std_logic;
        rdy2                            :out std_logic;
        ctl0                            :in std_logic;
        ctl1                            :in std_logic;
        ctl2                            :in std_logic;
        gpioa_o                         :out std_logic_vector(2 downto 0);
        gpioa_i                         :in std_logic_vector(2 downto 0);
        gpio_ext_rest_in                :in std_logic;
        gpio_reset_complete_o           :out std_logic;
        bidir                           :inout std_logic_vector(15 downto 0);
		  
        --Trigger
        trigger								 :in std_logic;
		  
		  --test only
		  trigger_miss							 :out std_logic;
		  
		  --Parameters
		  mem_en									 :in std_logic;
		  num_patterns							 :out std_logic_vector(14 downto 0);
		  mem_wr_fifo_reset					 :in std_logic;
		  mem_rd_fifo_reset					 :in std_logic
		  
    );
end appscore;

architecture Behavioral of appscore is
    -- Original TPG/apps components ----------------------------------
    component pgen
    port (
        clk_g                      : in std_logic;
        locked_init_rstz_gq        : in std_logic;
        pll_locked_rstz_gq         : in std_logic;
        init_active_gq             : in std_logic;
        cnts_active_cnt_q          : in std_logic_vector (4 downto 0);
        cnts_active_cnten_q        : in std_logic;
        cnts_pattern_cnt_q         : in std_logic_vector (26 downto 0);
        appsfpga_io_comp_data_en_q : in std_logic;
        appsfpga_io_ns_flip_en_q   : in std_logic;
        appsfpga_io_reset_type_q   : in std_logic_vector(1 downto 0);
        appsfpga_io_rowaddrmode_q  : in std_logic;
        appsfpga_io_WDT_enbl_q     : in std_logic;
        appsfpga_io_STEP_VCC_enbl_q: in std_logic;
        appsfpga_io_float_q        : in std_logic;
        in_dmd_type                : in std_logic_vector( 3 downto 0 );
        -- new
        usb_pattern_force          : in std_logic;
        usb_pattern_nmbr           : in std_logic_vector(2 downto 0);
        
        pgen_data_valid_q          : out std_logic;
        pgen_dout_a_q              : out std_logic_vector (63 downto 0);
        pgen_dout_b_q              : out std_logic_vector (63 downto 0);
        pgen_dout_c_q              : out std_logic_vector (63 downto 0);
        pgen_dout_d_q              : out std_logic_vector (63 downto 0);
        pgen_rowmd_q               : out std_logic_vector (1 downto 0);
        pgen_rowad_q               : out std_logic_vector (10 downto 0);
        pgen_blkad_q               : out std_logic_vector (3 downto 0);
        pgen_blkmd_q               : out std_logic_vector (1 downto 0);
        pgen_comp_data_q           : out std_logic;
        pgen_ns_flip_q             : out std_logic;
        pgen_STEP_VCC_q            : out std_logic;
        pgen_rst2blkz_q            : out std_logic
        );
    end component;

    component cnts
    port (
        clk_g                   : in std_logic;
        locked_init_rstz_gq     : in std_logic;
        appsfpga_io_cnthalt_q   : in std_logic;
        dvalid_space_info   : out  std_logic_vector(3 downto 0);
        in_dmd_type             : in std_logic_vector( 3 downto 0 );
        cnts_active_cnt_q       : out std_logic_vector (4 downto 0);
        cnts_active_cnten_q     : out std_logic;
        cnts_pattern_cnt_q      : out std_logic_vector (26 downto 0)
        );
    end component;


    -- New gui apps components ----------------------------------------
    component DMD_control 
    port ( 
        system_clk                           : in    std_logic;
        system_reset                         : in    std_logic;
        start_block_write                    : in    std_logic;
        DMD_RowLoads                         : in    std_logic_vector(15 downto 0);
        dmd_1080p_connected                  : in    std_logic;	   
        quarter_buss_connected               : in    std_logic;
        
        fifo_ab_data_out                     : in    std_logic_vector(127 downto 0);
        fifo_cd_data_out                     : in    std_logic_vector(127 downto 0);
        dmd_row_fifo_reset                   : in    std_logic;
        dmd_get_row_data                     : out   std_logic;
        gpio_external_reset                  : in    std_logic;
        external_reset_enable                : in    std_logic;
        --DDC control
        ddc_init_active                      : in    std_logic;
        dmd_dout_a                           : out   std_logic_vector(63 downto 0);
        dmd_dout_b                           : out   std_logic_vector(63 downto 0);
        dmd_dout_c                           : out   std_logic_vector(63 downto 0);
        dmd_dout_d                           : out   std_logic_vector(63 downto 0);
        dmd_dvalid                           : out   std_logic
        );
    end component;
	 
	 -- DDR2 memory and trigger controlled DMD components --------------
	 component DMD_trigger_control
	 port (
        clk_g		                  :in std_logic;
        locked_init_rstz_gq         :in std_logic;
        dmd_1080p_connected         :in std_logic;
        quarter_buss_connected      :in std_logic;

        --user inputs
        appsfpga_io_comp_data_en_q  :in std_logic;
        appsfpga_io_ns_flip_en_q    :in std_logic;
        appsfpga_io_reset_type_q    :in std_logic_vector(1 downto 0);
        appsfpga_io_rowaddrmode_q   :in std_logic;
        appsfpga_io_WDT_enbl_q      :in std_logic;
        appsfpga_io_STEP_VCC_enbl_q :in std_logic;
        appsfpga_io_float_q         :in std_logic;
        in_dmd_type                 :in std_logic_vector(3 downto 0);
		  update_mode                 :in std_logic_vector(2 downto 0);

        --DDC control
        ddc_init_active             :in std_logic;
        dmd_dout_a                  :out std_logic_vector(63 downto 0);
        dmd_dout_b                  :out std_logic_vector(63 downto 0);
        dmd_dout_c                  :out std_logic_vector(63 downto 0);
        dmd_dout_d                  :out std_logic_vector(63 downto 0);
        dmd_dvalid                  :out std_logic;
        dmd_rowmd                   :out std_logic_vector(1 downto 0);
        dmd_rowad                   :out std_logic_vector(10 downto 0);
        dmd_blkad                   :out std_logic_vector(3 downto 0);
        dmd_blkmd                   :out std_logic_vector(1 downto 0);
        dmd_STEP_VCC                :out std_logic;

        --user input associated outputs
        dmd_comp_data                   :out std_logic;
        dmd_ns_flip                     :out std_logic;
        dmd_rst2blkz                    :out std_logic;
		  
		  mem_read_enable					:out std_logic;
		  rd_pattern_id						:in std_logic_vector(14 downto 0);
		  num_patterns                : in std_logic_vector(14 downto 0);
		  
        --Memory signals
        rd_ab_fifo_valid            :in std_logic;
        rd_cd_fifo_valid            :in std_logic;
        dmd_get_row_data            :out std_logic;
        dmd_row_fifo_reset          :in std_logic;
        rd_ab_fifo_out              :in std_logic_vector(127 downto 0);
        rd_cd_fifo_out              :in std_logic_vector(127 downto 0);
		  rd_ab_fifo_data_valid			:in std_logic;
		  rd_cd_fifo_data_valid			:in std_logic;
		  mem_preload_done				:in std_logic;
		  
		  trigger_miss						:out std_logic; --test only
        
        --GPIO trigger
        trigger                     :in std_logic
    );
	 end component;

    component USB_IO
    port
    (
        --clocks
        ifclk               :in std_logic; --48MHz usb clock
        system_clk          :in std_logic; --200MHz system clock
        mem_clk             :in std_logic; --DDR2 memory clock

        --resets
        reset_i             :in std_logic; --external reset
        system_reset        :in std_logic; --reset from appfpga_io
		  
        --usb ports
        bidir               :inout std_logic_vector(15 downto 0); --bidirectional usb data
        fifo_wen            :in std_logic;
        fifo_ren            :in std_logic;
        fifo_regn           :in std_logic;

        --data to dmd
        dmd_1080p_connected :in std_logic;
        fifo_ab_data_out    :out std_logic_vector(127 downto 0);
        fifo_cd_data_out    :out std_logic_vector(127 downto 0);
        dmd_get_row_data    :in std_logic;
        dmd_row_fifo_reset  :in std_logic;

        --data to ddr2
        mem_wr_data         :out std_logic_vector(127 downto 0);
        mem_wr_data_valid   :out std_logic;
		  mem_wr_valid			 :out std_logic;
        mem_get_data        :in std_logic;
        mem_fifo_reset      :in std_logic;

        --register data
        reg_data_from_usb   :out std_logic_vector(15 downto 0);
        reg_data_to_usb     :in std_logic_vector(15 downto 0);
        reg_addra_USB       :out std_logic_vector(7 downto 0);
        reg_data_valid      :out std_logic;
		  
		  update_mode         :in std_logic_vector(2 downto 0)
    );
    end component;

    component MEM_IO_Verilog
    port(
        system_clk                  : in std_logic;
        system_reset                : in std_logic;
		  
		  mem_clk0							: in std_logic;
		  mem_clk2x							: in std_logic;
		  mem_clk2x90						: in std_logic;
		  mem_clk200						: in std_logic;
		  pll_mem_locked					: in std_logic;
        
        --ddr2 signals
        ddr2_a                      : out std_logic_vector((ROW_WIDTH-1) downto 0);
        ddr2_ba                     : out std_logic_vector((BANK_WIDTH-1) downto 0);
        ddr2_ras_n                  : out std_logic;
        ddr2_cas_n                  : out std_logic;
        ddr2_we_n                   : out std_logic;
        ddr2_cs_n                   : out std_logic_vector((CS_WIDTH-1) downto 0);
        ddr2_odt                    : out std_logic_vector((ODT_WIDTH-1) downto 0);
        ddr2_cke                    : out std_logic_vector((CKE_WIDTH-1) downto 0);
        ddr2_ck                     : out std_logic_vector((CLK_WIDTH-1) downto 0);
        ddr2_ck_n                   : out std_logic_vector((CLK_WIDTH-1) downto 0);
        ddr2_dq                     : inout std_logic_vector((DQ_WIDTH-1) downto 0);
        ddr2_dqs                    : inout std_logic_vector((DQS_WIDTH-1) downto 0);
        ddr2_dqs_n                  : inout std_logic_vector((DQS_WIDTH-1) downto 0);
        ddr2_dm                     : out std_logic_vector((DM_WIDTH-1) downto 0);
		  
		  mem_init_done					: out std_logic;
		  rd_pattern_id					: out std_logic_vector(14 downto 0);
		  mem_read_enable					: in std_logic;

        num_patterns                : in std_logic_vector(14 downto 0);
		  update_mode						: in std_logic_vector(2 downto 0);
        --dmd_1080p_connected         : in std_logic;

        --usb interface
        wr_data                     : in std_logic_vector(127 downto 0);
        wr_valid                    : in std_logic;
		  wr_data_valid					: in std_logic;
        mem_get_data                : out std_logic;

        --dmd control interface
        rd_ab_fifo_out              : out std_logic_vector(127 downto 0);
        rd_cd_fifo_out              : out std_logic_vector(127 downto 0);
        dmd_get_data                : in std_logic;
        rd_ab_fifo_valid            : out std_logic;
        rd_cd_fifo_valid            : out std_logic;
		  rd_ab_fifo_data_valid			: out std_logic;
		  rd_cd_fifo_data_valid			: out std_logic;
		  mem_preload_done				: out std_logic;
        mem_rd_fifo_reset           : in std_logic
    );
    end component;

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
           dmd_write_block                      : OUT   STD_LOGIC;
			  num_patterns									: OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
			  update_mode 									: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END COMPONENT;
--    component control_registers
--    port(
--        system_clk              :in std_logic;
--        system_reset            :in std_logic;
--
--        --USB interface
--        pll_speed_info          :in  std_logic_vector(1 downto 0);
--        dvalid_space_info       :in  std_logic_vector(3 downto 0);
--        BUILD_NUMBER            :in  std_logic_vector(7 downto 0);
--        reg_address             :in std_logic_vector(7 downto 0);
--        reg_write_data          :in std_logic_vector(15 downto 0);
--        write_reg_valid         :in std_logic;
--        reg_read_data           :out std_logic_vector(15 downto 0);
--        fifo_reset              :out std_logic;
--
--        num_patterns            :out std_logic_vector(14 downto 0); --number of patterns
--        mem_rd_fifo_reset		  :out std_logic;
--        mem_wr_fifo_reset		  :out std_logic;
--        mem_en						  :out std_logic;
--
--        gpio_out                :out std_logic_vector(2 downto 0);
--        gpio_in                 :in std_logic_vector(2 downto 0);
--        gpio_external_reset     :in std_logic;
--        external_reset_enable   :out std_logic;
--        GPIO_reset_complete     :out std_logic;
--
--        --DDC control
--        DMD_type		        :in  std_logic_vector(3 downto 0);
--        DDC_version		        :in  std_logic_vector(2 downto 0);
--        DMD_blk_md		        :out std_logic_vector(1 downto 0);
--        DMD_blk_ad		        :out std_logic_vector(3 downto 0);
--        DMD_row_md		        :out std_logic_vector(1 downto 0);
--        DMD_row_ad		        :out std_logic_vector(10 downto 0);
--        DMD_pwr_float  	        :out std_logic;
--        DMD_wdt	                :out std_logic;
--        DMD_ns_flip		        :out std_logic;
--        DMD_comp_data  	        :out std_logic;
--        DMD_step_vcc		    :out std_logic;
--        --DMD_ext_reset  	        : out std_logic;
--        DMD_rst2blkz	        :out std_logic;
--        --
--        load4_en                :out std_logic;
--        tpg_en                  :out std_logic; 
--        pattern_force           :out std_logic;
--        switch_en               :out std_logic;
--        pattern_nmbr            :out std_logic_vector(2 downto 0);
--        swtch_override_val      :out std_logic_vector(7 downto 0);
--        --
--        
--        DMD_RowLoads		    :out std_logic_vector(15 downto 0);
--        dmd_write_block	        :out std_logic
--    );
--    end component;


    signal ifclk                :std_logic;
    signal system_reset         :std_logic;
    -- DMD control signals
    signal dmd_write_block      :std_logic;
    signal dmd_row_fifo_reset   :std_logic;
    signal full_buss_connected  :std_logic;
    signal quarter_buss_connected :std_logic;
    signal DMD_RowLoads         :std_logic_vector(15 downto 0);
	 
    signal fifo_ab_data_out     :std_logic_vector(127 downto 0);
    signal fifo_cd_data_out     :std_logic_vector(127 downto 0);
    signal dmd_get_row_data     :std_logic;

    signal reg_data_from_usb    :std_logic_vector(15 downto 0);
    signal reg_data_to_usb      :std_logic_vector(15 downto 0);
    signal reg_addra_USB        :std_logic_vector(7 downto 0);
    signal reg_data_valid       :std_logic;

    signal mem_wr_data          :std_logic_vector(127 downto 0);
    signal mem_wr_data_valid    :std_logic;
	 signal mem_wr_valid			  :std_logic;
    signal mem_get_data         :std_logic;
    signal mem_fifo_reset       :std_logic;

    signal fifo_wen             :std_logic;
    signal fifo_ren             :std_logic;
    signal fifo_regn            :std_logic;


    signal mem_rd_ab_fifo_out      :std_logic_vector(127 downto 0);
    signal mem_rd_cd_fifo_out      :std_logic_vector(127 downto 0);
    signal mem_rd_ab_fifo_valid :std_logic;
    signal mem_rd_cd_fifo_valid :std_logic;
	 signal mem_rd_ab_fifo_data_valid :std_logic;
	 signal mem_rd_cd_fifo_data_valid :std_logic;
    signal dmd_get_mem_data     :std_logic;
	 signal mem_preload_done	    :std_logic;
	 signal mem_read_enable			:std_logic;
    signal mem_rd_pattern_id		:std_logic_vector(14 downto 0);
	 
    signal dvalid_space_info    :std_logic_vector(3 downto 0);
    signal BUILD_NUMBER         :std_logic_vector(7 downto 0);

    signal gpio_out             :std_logic_vector(2 downto 0);
    signal gpio_in              :std_logic_vector(2 downto 0);

    signal gpio_external_reset  :std_logic;
    signal external_reset_enable:std_logic;
	 
    signal mem_dmd_dout_a                  :std_logic_vector(63 downto 0);
    signal mem_dmd_dout_b                  :std_logic_vector(63 downto 0);
    signal mem_dmd_dout_c                  :std_logic_vector(63 downto 0);
    signal mem_dmd_dout_d                  :std_logic_vector(63 downto 0);
    signal mem_dmd_dvalid                  :std_logic;
    signal mem_dmd_rowmd                   :std_logic_vector(1 downto 0);
    signal mem_dmd_rowad                   :std_logic_vector(10 downto 0);
    signal mem_dmd_blkad                   :std_logic_vector(3 downto 0);
    signal mem_dmd_blkmd                   :std_logic_vector(1 downto 0);
    signal mem_dmd_STEP_VCC                :std_logic;
    signal mem_dmd_comp_data               :std_logic;
    signal mem_dmd_ns_flip                 :std_logic;
    signal mem_dmd_rst2blkz                :std_logic;

    signal gui_dmd_dout_a               	: std_logic_vector(63 downto 0);  
    signal gui_dmd_dout_b               	: std_logic_vector(63 downto 0); 
    signal gui_dmd_dout_c               	: std_logic_vector(63 downto 0); 
    signal gui_dmd_dout_d               	: std_logic_vector(63 downto 0); 
    signal gui_dmd_dvalid               	: std_logic;

    signal gui_blkmd            :std_logic_vector(1 downto 0);     -- *To be Muxed
    signal gui_blkad            :std_logic_vector(3 downto 0);     -- *To be Muxed
    signal gui_rowmd            :std_logic_vector(1 downto 0);     -- *To be Muxed
    signal gui_rowad            :std_logic_vector(10 downto 0);    -- *To be Muxed

    signal gui_wdt_enablez_q    :std_logic;
    signal gui_ns_flip          :std_logic;
    signal gui_comp_data        :std_logic;
    signal gui_rst2blkz         :std_logic;
    signal gui_pwr_floatz_q     :std_logic;

    signal tcexpire             :std_logic;

    signal gui_load4_en         :std_logic;
    signal usb_tpg_en                : std_logic; 
    signal usb_pattern_force         : std_logic;
    signal usb_switch_en             : std_logic;
    signal usb_pattern_nmbr          : std_logic_vector(2 downto 0);
    signal usb_swtch_override_val    : std_logic_vector(7 downto 0);
	 signal usb_num_patterns			 : std_logic_vector(14 downto 0);
	 signal usb_update_mode			 : std_logic_vector(2 downto 0);

    signal muxed_comp_data_en_q      : std_logic; 
    signal muxed_ns_flip_en_q        : std_logic; 
    signal muxed_reset_type_q        : std_logic_vector(1 downto 0); 
    signal muxed_rowaddr_mode_q      : std_logic; 
    signal muxed_wdt_en_q            : std_logic; 
    signal muxed_cnthalt_q           : std_logic;
    signal muxed_mirror_float_q      : std_logic;

    signal muxed_out_data_valid_q        : std_logic;
    signal muxed_out_dout_a_q            : std_logic_vector(63 downto 0);
    signal muxed_out_dout_b_q            : std_logic_vector(63 downto 0);
    signal muxed_out_dout_c_q            : std_logic_vector(63 downto 0);
    signal muxed_out_dout_d_q            : std_logic_vector(63 downto 0);
    signal muxed_out_rowmd_q             : std_logic_vector(1 downto 0);
    signal muxed_out_rowad_q             : std_logic_vector(10 downto 0);
    signal muxed_out_blkmd_q             : std_logic_vector(1 downto 0);
    signal muxed_out_blkad_q             : std_logic_vector(3 downto 0);
    signal muxed_out_comp_data_q         : std_logic;
    signal muxed_out_ns_flip_q           : std_logic;
    signal muxed_out_rst2blkz_q          : std_logic;
    signal muxed_out_load4_q             : std_logic;

    --- TPG Apps signals
    signal cnts_active_cnt_q         : std_logic_vector (4 downto 0);
    signal cnts_active_cnten_q       : std_logic;
    signal cnts_blank_cnt_q          : std_logic_vector (3 downto 0);
    signal cnts_blank_cnten_q        : std_logic;
    signal cnts_pattern_cnt_q        : std_logic_vector (26 downto 0);
    signal pgen_data_valid_q         : std_logic;
    signal pgen_dout_a_q             : std_logic_vector (63 downto 0);
    signal pgen_dout_b_q             : std_logic_vector (63 downto 0);
    signal pgen_dout_c_q             : std_logic_vector (63 downto 0);
    signal pgen_dout_d_q             : std_logic_vector (63 downto 0);
    signal pgen_rowmd_q              : std_logic_vector (1 downto 0);
    signal pgen_rowad_q              : std_logic_vector (10 downto 0);
    signal pgen_blkad_q              : std_logic_vector (3 downto 0);
    signal pgen_blkmd_q              : std_logic_vector (1 downto 0);
    signal pgen_comp_data_q          : std_logic;
    signal pgen_ns_flip_q            : std_logic;
    signal pgen_STEP_VCC_q           : std_logic;
    signal pgen_rst2blkz_q           : std_logic;
    signal locked_init_rstz_gq       : std_logic;




-- Trigger is generated here. remove when external trig implemented
	--test only
	signal      trigger_i							: STD_LOGIC;
	signal trigger_j : STD_LOGIC;
	constant 	period_1s						: STD_LOGIC_VECTOR(27 downto 0) := "1011111010111100001000000000";
	constant    period_22kHz					: STD_LOGIC_VECTOR(27 downto 0) := "0000000000000010001110000010";
	constant    period_25kHz					: STD_LOGIC_VECTOR(27 downto 0) := "0000000000000001111101000000";
	constant    period_10kHz					: STD_LOGIC_VECTOR(27 downto 0) := "0000000000000100111000100000";
	
	constant    period_21_5kHz					: STD_LOGIC_VECTOR(27 downto 0) := "0000000000000101001111111100";
	constant    period_21kHz					: STD_LOGIC_VECTOR(27 downto 0) := "0000000000000010010100110011";
	signal      trigger_counter				: STD_LOGIC_VECTOR(27 downto 0);

begin

process(clk_g, system_reset) begin
	if system_reset = '1' then
		trigger_counter <= (others => '0');
		trigger_i <= '0';
	elsif rising_edge(clk_g) and mem_preload_done = '1' then
		if trigger_counter >= period_21kHz then
			trigger_i <= '1';
			trigger_counter <= (others => '0');
		else
			trigger_i <= '0';
			trigger_counter <= trigger_counter + "0000000000000000000000000001";
		end if;
	end if;
	
	
end process;

trigger_j <= gpioa_i(0);



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
    -- Adding the new USB functionality
    system_reset            <=  not pll_locked_rstz_gq;

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
	 
	 mem_fifo_reset 			 <= mem_wr_fifo_reset;
	 
	 num_patterns <= usb_num_patterns;
	 
    DMD_TRIGGER_CONTROL_INST : DMD_trigger_control
    port map (
        clk_g		                  => clk_g,
        locked_init_rstz_gq         => locked_init_rstz_gq,
        dmd_1080p_connected         => full_buss_connected,
        quarter_buss_connected      => quarter_buss_connected ,      
        appsfpga_io_comp_data_en_q  => muxed_comp_data_en_q,
        appsfpga_io_ns_flip_en_q    => muxed_ns_flip_en_q,
        appsfpga_io_reset_type_q    => muxed_reset_type_q,
        appsfpga_io_rowaddrmode_q   => muxed_rowaddr_mode_q,
        appsfpga_io_WDT_enbl_q      => muxed_wdt_en_q,
        appsfpga_io_STEP_VCC_enbl_q => appsfpga_io_STEP_VCC_enbl_q,
        appsfpga_io_float_q         => muxed_mirror_float_q,
        in_dmd_type                 => in_dmd_type,
		  update_mode						=> usb_update_mode,
        ddc_init_active             => init_active_gq,
        dmd_dout_a                  => mem_dmd_dout_a,
        dmd_dout_b                  => mem_dmd_dout_b,
        dmd_dout_c                  => mem_dmd_dout_c,
        dmd_dout_d                  => mem_dmd_dout_d,
        dmd_dvalid                  => mem_dmd_dvalid,
        dmd_rowmd                   => mem_dmd_rowmd,
        dmd_rowad                   => mem_dmd_rowad,
        dmd_blkad                   => mem_dmd_blkad,
        dmd_blkmd                   => mem_dmd_blkmd,
        dmd_STEP_VCC                => mem_dmd_STEP_VCC,
        dmd_comp_data               => mem_dmd_comp_data,
        dmd_ns_flip                 => mem_dmd_ns_flip,
        dmd_rst2blkz                => mem_dmd_rst2blkz,
        rd_ab_fifo_valid            => mem_rd_ab_fifo_valid,
        rd_cd_fifo_valid            => mem_rd_cd_fifo_valid,
		  rd_ab_fifo_data_valid       => mem_rd_ab_fifo_data_valid,
		  rd_cd_fifo_data_valid       => mem_rd_cd_fifo_data_valid,
        dmd_get_row_data            => dmd_get_mem_data,
        dmd_row_fifo_reset          => mem_rd_fifo_reset,
        rd_ab_fifo_out              => mem_rd_ab_fifo_out,
        rd_cd_fifo_out              => mem_rd_cd_fifo_out,
        mem_preload_done				=> mem_preload_done,
		  rd_pattern_id					=> mem_rd_pattern_id,
		  num_patterns						=> usb_num_patterns,
		  mem_read_enable             => mem_read_enable,
		  trigger_miss						=> trigger_miss,
        trigger                     => trigger_j --should be trigger
    );
	 



    DMD_CONTROL_INST : DMD_control 
    port map (
        system_clk                 => clk_g,                       
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

    USB_IO_INST : USB_IO
    port map(
        --clocks
        ifclk               => ifclk,
        system_clk          => clk_g,
        mem_clk             => mem_clk2x,
        reset_i             => reset_i,
        system_reset        => system_reset,
        mem_fifo_reset      => mem_fifo_reset,
		  
        bidir               => bidir,
        fifo_wen            => fifo_wen,
        fifo_ren            => fifo_ren,
        fifo_regn           => fifo_regn,
        dmd_1080p_connected => full_buss_connected,
        fifo_ab_data_out    => fifo_ab_data_out,
        fifo_cd_data_out    => fifo_cd_data_out,
        dmd_get_row_data    => dmd_get_row_data,
        dmd_row_fifo_reset  => dmd_row_fifo_reset,
        mem_wr_data         => mem_wr_data,
        mem_wr_data_valid   => mem_wr_data_valid,
		  mem_wr_valid			 => mem_wr_valid,
        mem_get_data        => mem_get_data,
        reg_data_from_usb   => reg_data_from_usb,
        reg_data_to_usb     => reg_data_to_usb,
        reg_addra_USB       => reg_addra_USB,
        reg_data_valid      => reg_data_valid,
		  update_mode  		 => usb_update_mode

    );
    
    MEMORY_IO_INST : MEM_IO_Verilog
    port map(
        system_clk                  => clk_g,
        system_reset                => system_reset,
        mem_clk200				    => mem_clk200,
        mem_clk0					=> mem_clk0,
        mem_clk2x					=> mem_clk2x,
        mem_clk2x90					=> mem_clk2x90,
        pll_mem_locked				=> pll_mem_locked,
        ddr2_a                      => ddr2_a,
        ddr2_ba                     => ddr2_ba,
        ddr2_ras_n                  => ddr2_ras_n,
        ddr2_cas_n                  => ddr2_cas_n,
        ddr2_we_n                   => ddr2_we_n,
        ddr2_cs_n                   => ddr2_cs_n,
        ddr2_odt                    => ddr2_odt,
        ddr2_cke                    => ddr2_cke,
        ddr2_ck                     => ddr2_ck,
        ddr2_ck_n                   => ddr2_ck_n,
        ddr2_dq                     => ddr2_dq,
        ddr2_dqs                    => ddr2_dqs,
        ddr2_dqs_n                  => ddr2_dqs_n,
        ddr2_dm                     => ddr2_dm,
		  mem_init_done					=> mem_init_done,
        num_patterns                => usb_num_patterns,
		  update_mode						=> usb_update_mode,
        --dmd_1080p_connected         => full_buss_connected,
        wr_data                     => mem_wr_data,
        mem_get_data                => mem_get_data,
        wr_data_valid               => mem_wr_data_valid,
		  wr_valid							=> mem_wr_valid,
        dmd_get_data                => dmd_get_mem_data,
		  mem_read_enable				   => mem_read_enable,
        rd_ab_fifo_out              => mem_rd_ab_fifo_out,
        rd_cd_fifo_out              => mem_rd_cd_fifo_out,
        rd_ab_fifo_valid            => mem_rd_ab_fifo_valid,
        rd_cd_fifo_valid            => mem_rd_cd_fifo_valid,
		  rd_ab_fifo_data_valid       => mem_rd_ab_fifo_data_valid,
		  rd_cd_fifo_data_valid       => mem_rd_cd_fifo_data_valid,
        mem_preload_done				=> mem_preload_done,
		  rd_pattern_id					=> mem_rd_pattern_id,
        mem_rd_fifo_reset           => mem_rd_fifo_reset
    );

--    CONTROL_REGISTERS_INIT : control_registers
--    port map(
--        system_clk              => clk_g,
--        system_reset            => system_reset,
--        pll_speed_info          => pll_speed_info,
--        dvalid_space_info       => dvalid_space_info,
--        BUILD_NUMBER            => BUILD_NUMBER,
--        reg_address             => reg_addra_USB,
--        reg_write_data          => reg_data_from_USB,
--        write_reg_valid         => reg_data_valid,
--        reg_read_data           => reg_data_to_USB,
--        fifo_reset              => dmd_row_fifo_reset,
--        num_patterns            => open, --num_patterns,
--        mem_wr_fifo_reset	 	  => open, --mem_fifo_reset,
--        mem_rd_fifo_reset		  => open, --mem_rd_fifo_reset,
--        mem_en						  => open, --mem_en,
--        gpio_out                => gpio_out,
--        gpio_in                 => gpio_in,
--        gpio_external_reset     => gpio_external_reset,
--        external_reset_enable   => external_reset_enable,
--        GPIO_reset_complete     => GPIO_reset_complete_o,
--        DMD_type		        => in_dmd_type,
--        DDC_version		        => in_ddc_version,
--        DMD_blk_md		        => gui_blkmd,
--        DMD_blk_ad		        => gui_blkad,
--        DMD_row_md		        => gui_rowmd,
--        DMD_row_ad		        => gui_rowad,
--        DMD_pwr_float  	        => gui_pwr_floatz_q,
--        DMD_wdt	                => gui_wdt_enablez_q,
--        DMD_ns_flip		        => gui_ns_flip,
--        DMD_comp_data  	        => gui_comp_data,
--        DMD_step_vcc		    => OPEN,
--        --DMD_ext_reset  	        => DMD_ext_reset,
--        DMD_rst2blkz	        => gui_rst2blkz,
--        load4_en                => gui_load4_en,
--        tpg_en                  => usb_tpg_en,
--        pattern_force           => usb_pattern_force,
--        switch_en               => usb_switch_en,
--        pattern_nmbr            => usb_pattern_nmbr,
--        swtch_override_val      => usb_swtch_override_val,
--        DMD_RowLoads		    => DMD_RowLoads,
--        dmd_write_block	        => dmd_write_block
--    );
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
            dmd_write_block            => dmd_write_block,
				num_patterns					=> usb_num_patterns,
				update_mode					=> usb_update_mode);


    --- Original tpg/apps function
    i_pgen : pgen
    PORT MAP (
        clk_g                            => clk_g,
        locked_init_rstz_gq              => locked_init_rstz_gq,
        pll_locked_rstz_gq               => pll_locked_rstz_gq,
        init_active_gq                   => init_active_gq,
        cnts_active_cnt_q (4 downto 0)   => cnts_active_cnt_q (4 downto 0),
        cnts_active_cnten_q              => cnts_active_cnten_q,
        cnts_pattern_cnt_q (26 downto 0) => cnts_pattern_cnt_q (26 downto 0),
        appsfpga_io_comp_data_en_q       => muxed_comp_data_en_q,
        appsfpga_io_ns_flip_en_q         => muxed_ns_flip_en_q,
        appsfpga_io_reset_type_q         => muxed_reset_type_q,
        appsfpga_io_WDT_enbl_q           => muxed_wdt_en_q,
        appsfpga_io_STEP_VCC_enbl_q      => appsfpga_io_STEP_VCC_enbl_q,
        appsfpga_io_float_q              => muxed_mirror_float_q,
        in_dmd_type                      => in_dmd_type,
        usb_pattern_force                => usb_pattern_force,  -- IN STD_LOGIC;
        usb_pattern_nmbr                 => usb_pattern_nmbr,  -- IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        appsfpga_io_rowaddrmode_q        => muxed_rowaddr_mode_q,
        pgen_data_valid_q                => pgen_data_valid_q,
        pgen_dout_a_q (63 downto 0)      => pgen_dout_a_q (63 downto 0),
        pgen_dout_b_q (63 downto 0)      => pgen_dout_b_q (63 downto 0),
        pgen_dout_c_q (63 downto 0)      => pgen_dout_c_q (63 downto 0),
        pgen_dout_d_q (63 downto 0)      => pgen_dout_d_q (63 downto 0),
        pgen_rowmd_q  (1 downto 0)       => pgen_rowmd_q  (1 downto 0),
        pgen_rowad_q  (10 downto 0)      => pgen_rowad_q  (10 downto 0),
        pgen_blkad_q  (3 downto 0)       => pgen_blkad_q  (3 downto 0),
        pgen_blkmd_q  (1 downto 0)       => pgen_blkmd_q  (1 downto 0),
        pgen_comp_data_q                 => pgen_comp_data_q,
        pgen_ns_flip_q                   => pgen_ns_flip_q,
        pgen_STEP_VCC_q                  => pgen_STEP_VCC_q,
        pgen_rst2blkz_q                  => pgen_rst2blkz_q
    );
    
    i_cnts : cnts
    PORT MAP (
        clk_g                            => clk_g,
        locked_init_rstz_gq              => locked_init_rstz_gq,
        appsfpga_io_cnthalt_q            => appsfpga_io_cnthalt_q,
        in_dmd_type                      => in_dmd_type,
        dvalid_space_info => dvalid_space_info, -- :  STD_LOGIC_VECTOR(3 DOWNTO 0);
        cnts_active_cnt_q (4 DOWNTO 0)   => cnts_active_cnt_q (4 DOWNTO 0),
        cnts_active_cnten_q              => cnts_active_cnten_q,
        cnts_pattern_cnt_q (26 DOWNTO 0) => cnts_pattern_cnt_q (26 DOWNTO 0)
    );


    -- Process combining active and reset for use in CNTS block
    process (clk_g, pll_locked_rstz_gq, init_active_gq)
    begin
    if (pll_locked_rstz_gq = '0' or init_active_gq = '1') then
        locked_init_rstz_gq <= '0';
    elsif (clk_g = '1' and clk_g'event) then
        locked_init_rstz_gq <= '1'after 1 PS;
    end if;
    end process;
    
    -- Switch selection mux
    -- This mux (toggled by the USB switch select register) picks the source for the switch inputs. 
    -- If the sw_en is selected (the default mode) the externa; dip switch is used as the source
    -- for the switch values.  If sw_en = 0, the internal USB register values are used for the 
    -- switch settings.

    process (clk_g) --, locked_init_rstz_gq)
    begin
    --  IF (locked_init_rstz_gq = '0') THEN
    --    muxed_comp_data_en_q   <= appsfpga_io_comp_data_en_q;
    --    muxed_ns_flip_en_q     <= appsfpga_io_ns_flip_en_q;
    --    muxed_reset_type_q     <= appsfpga_io_reset_type_q;
    --    muxed_rowaddr_mode_q   <= appsfpga_io_rowaddrmode_q;
    --    muxed_wdt_en_q         <= appsfpga_io_WDT_enbl_q;
    --    muxed_cnthalt_q        <= appsfpga_io_cnthalt_q;
    --    muxed_mirror_float_q   <= appsfpga_io_float_q;
    ----  ELSIF (clk_g = '1' AND clk_g'EVENT) THEN
    if (clk_g = '1' and clk_g'event) then
        if (usb_switch_en = '1') then
            muxed_comp_data_en_q  <= appsfpga_io_comp_data_en_q AFTER 1 PS; 
            muxed_ns_flip_en_q    <= appsfpga_io_ns_flip_en_q   AFTER 1 PS;   
            muxed_reset_type_q    <= appsfpga_io_reset_type_q   AFTER 1 PS;   
            muxed_rowaddr_mode_q  <= appsfpga_io_rowaddrmode_q  AFTER 1 PS; 
            muxed_wdt_en_q        <= appsfpga_io_WDT_enbl_q     AFTER 1 PS;       
            muxed_cnthalt_q       <= appsfpga_io_cnthalt_q      AFTER 1 PS;      
            muxed_mirror_float_q  <= appsfpga_io_float_q        AFTER 1 PS;
        else
            muxed_comp_data_en_q  <= usb_swtch_override_val(2) AFTER 1 PS; 
            muxed_ns_flip_en_q    <= usb_swtch_override_val(3) AFTER 1 PS;   
            muxed_reset_type_q    <= usb_swtch_override_val(5 downto 4) AFTER 1 PS;   
            muxed_rowaddr_mode_q  <= usb_swtch_override_val(6) AFTER 1 PS; 
            muxed_wdt_en_q        <= usb_swtch_override_val(7) AFTER 1 PS;       
            muxed_cnthalt_q       <= usb_swtch_override_val(1) AFTER 1 PS;      
            muxed_mirror_float_q  <= usb_swtch_override_val(0) AFTER 1 PS; 
        end if;
    end if;
    end process;

    -- Output data_ctrl_mux:  This selects whether the data output from appcore 
    -- comes from the USB/apps blocks ot the TPG (default).
    process (clk_g) --, locked_init_rstz_gq)
    begin
    if (clk_g = '1' and clk_g'event) then
        if mem_en = '1' then
            muxed_out_data_valid_q        <= mem_dmd_dvalid AFTER 1 PS;
            muxed_out_dout_a_q            <= mem_dmd_dout_a AFTER 1 PS; 
            muxed_out_dout_b_q            <= mem_dmd_dout_b AFTER 1 PS; 
            muxed_out_dout_c_q            <= mem_dmd_dout_c AFTER 1 PS;
            muxed_out_dout_d_q            <= mem_dmd_dout_d AFTER 1 PS;     
            muxed_out_rowmd_q             <= mem_dmd_rowmd AFTER 1 PS;    
            muxed_out_rowad_q             <= mem_dmd_rowad AFTER 1 PS;
            muxed_out_blkmd_q             <= mem_dmd_blkmd AFTER 1 PS;      
            muxed_out_blkad_q             <= mem_dmd_blkad AFTER 1 PS;
            muxed_out_comp_data_q         <= mem_dmd_comp_data AFTER 1 PS;
            muxed_out_ns_flip_q           <= mem_dmd_ns_flip AFTER 1 PS;
            muxed_out_rst2blkz_q          <= mem_dmd_rst2blkz AFTER 1 PS;
            muxed_out_load4_q             <= '0' AFTER 1 PS;				
        elsif usb_tpg_en = '1' then
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
		 else
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
        end if;
    end if;
    end process;
	
	 mem_read_ready <= mem_preload_done;
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
	 
end Behavioral ; -- Behavioral