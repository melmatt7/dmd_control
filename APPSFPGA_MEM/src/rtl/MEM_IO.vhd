library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

library DDR2;
use DDR2.DDR2_PKG.all;

entity MEM_IO is
    port(
        system_clk                  : in std_logic;
        system_reset                : in std_logic;
		  
        mem_preload_done			: out std_logic;

        
        --ddr2 signals
        mem_locked					: in std_logic;
        mem_clk200					: in std_logic;
        mem_clk0					: in std_logic;
        mem_clk90					: in std_logic;
        mem_clkdiv0					: in std_logic;
        mem_clk						: out std_logic;
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

        num_patterns                : in std_logic_vector(14 downto 0);
        dmd_1080p_connected         : in std_logic;

        --usb interface
        wr_data                     : in std_logic_vector(127 downto 0);
        wr_valid                    : in std_logic;
        mem_get_data                : out std_logic;

        --dmd control interface
        rd_ab_fifo_out              : out std_logic_vector(127 downto 0);
        rd_cd_fifo_out              : out std_logic_vector(127 downto 0);
        dmd_get_data                : in std_logic;
        rd_ab_fifo_valid            : out std_logic;
        rd_cd_fifo_valid            : out std_logic;
        rd_pattern_id               : in std_logic_vector(14 downto 0);
        mem_read_enable             : in std_logic;
        mem_rd_fifo_reset           : in std_logic
    );
end entity MEM_IO;

architecture Behavioral of MEM_IO is

    component mig_top is
        generic(
            BANK_WIDTH               : integer;
            CKE_WIDTH                : integer;
            CLK_WIDTH                : integer;
            COL_WIDTH                : integer;
            CS_NUM                   : integer;
            CS_WIDTH                 : integer;
            CS_BITS                  : integer;
            DM_WIDTH                 : integer;
            DQ_WIDTH                 : integer;
            DQ_PER_DQS               : integer;
            DQS_WIDTH                : integer;
            DQ_BITS                  : integer;
            DQS_BITS                 : integer;
            ODT_WIDTH                : integer;
            ROW_WIDTH                : integer;
            ADDITIVE_LAT             : integer;
            BURST_LEN                : integer;
            BURST_TYPE               : integer;
            CAS_LAT                  : integer;
            ECC_ENABLE               : integer;
            APPDATA_WIDTH            : integer;
            MULTI_BANK_EN            : integer;
            TWO_T_TIME_EN            : integer;
            ODT_TYPE                 : integer;
            REDUCE_DRV               : integer;
            REG_ENABLE               : integer;
            TREFI_NS                 : integer;
            TRAS                     : integer;
            TRCD                     : integer;
            TRFC                     : integer;
            TRP                      : integer;
            TRTP                     : integer;
            TWR                      : integer;
            TWTR                     : integer;
            HIGH_PERFORMANCE_MODE    : boolean;
            SIM_ONLY                 : integer;
            DEBUG_EN                 : integer;
            CLK_PERIOD               : integer;
            --DLL_FREQ_MODE            : string;
            --CLK_TYPE                 : string;
            --NOCLK200                 : boolean;
            RST_ACT_LOW              : integer
        );
        port(
            ddr2_dq               : inout  std_logic_vector((DQ_WIDTH-1) downto 0);
            ddr2_a                : out   std_logic_vector((ROW_WIDTH-1) downto 0);
            ddr2_ba               : out   std_logic_vector((BANK_WIDTH-1) downto 0);
            ddr2_ras_n            : out   std_logic;
            ddr2_cas_n            : out   std_logic;
            ddr2_we_n             : out   std_logic;
            ddr2_cs_n             : out   std_logic_vector((CS_WIDTH-1) downto 0);
            ddr2_odt              : out   std_logic_vector((ODT_WIDTH-1) downto 0);
            ddr2_cke              : out   std_logic_vector((CKE_WIDTH-1) downto 0);
            ddr2_dm               : out   std_logic_vector((DM_WIDTH-1) downto 0);

            sys_rst_n             : in    std_logic;
            phy_init_done         : out   std_logic;
            locked          	  : in    std_logic;
            rst0_tb               : out   std_logic;
            clk0_tb               : out   std_logic;
            clk0				  : in		std_logic;
            clk90				  : in		std_logic;
            clkdiv0				  : in		std_logic;
            clk200				  : in		std_logic;
           
            app_wdf_afull         : out   std_logic;
            app_af_afull          : out   std_logic;
            rd_data_valid         : out   std_logic;
            app_wdf_wren          : in    std_logic;
            app_af_wren           : in    std_logic;
            app_af_addr           : in    std_logic_vector(30 downto 0);
            app_af_cmd            : in    std_logic_vector(2 downto 0);
            rd_data_fifo_out      : out   std_logic_vector((APPDATA_WIDTH-1) downto 0);
            app_wdf_data          : in    std_logic_vector((APPDATA_WIDTH-1) downto 0);
            app_wdf_mask_data     : in    std_logic_vector((APPDATA_WIDTH/8-1) downto 0);

            ddr2_dqs              : inout  std_logic_vector((DQS_WIDTH-1) downto 0);
            ddr2_dqs_n            : inout  std_logic_vector((DQS_WIDTH-1) downto 0);
            ddr2_ck               : out   std_logic_vector((CLK_WIDTH-1) downto 0);
            ddr2_ck_n             : out   std_logic_vector((CLK_WIDTH-1) downto 0)
        );
    end component;

    component read_fifo is
        port (
            WR_CLK          :in std_logic;
			RD_CLK          :in std_logic;
			RST             :in std_logic;
			WR_EN           :in std_logic;
			RD_EN           :in std_logic;
			DIN             :in std_logic_vector(127 downto 0);
			DOUT            :out std_logic_vector(127 downto 0);
			FULL            :out std_logic;
			EMPTY           :out std_logic
        );
    end component;

    --ddr2 apps interface signals
    signal clk0                         :std_logic;
    signal rst0                         :std_logic;
    signal phy_init_done                :std_logic;
    signal system_reset_n               :std_logic;

    signal app_af_afull                 :std_logic;
    signal app_wdf_afull                :std_logic;
    signal rd_data_valid                :std_logic;
    signal rd_data_fifo_out             :std_logic_vector(127 downto 0);
    
    signal app_af_wren                  :std_logic;
    signal app_af_cmd                   :std_logic_vector(2 downto 0);
    signal app_af_addr                  :std_logic_vector(30 downto 0);
    signal app_wdf_wren                 :std_logic;
    signal app_wdf_data                 :std_logic_vector(127 downto 0);
    signal app_wdf_mask_data            :std_logic_vector(15 downto 0);
	
    constant READ                       :std_logic_vector(2 downto 0) := "001";
    constant WRITE                      :std_logic_vector(2 downto 0) := "000";
    constant max_offset                 :std_logic_vector(12 downto 0):= "1100000000000"; -- for xga pattern: 1024*768/128=6144

    signal wr_offset_addr               :std_logic_vector(12 downto 0);
    signal rd_offset_addr               :std_logic_vector(12 downto 0);
    signal write_pattern_count          :std_logic_vector(14 downto 0);
    signal burst_indicator              :std_logic;
    signal wr_ready                     :std_logic;

    signal mem_preload_done_1           :std_logic;
	signal pattern_read_done_1			 :std_logic;
	signal read_enable      			:std_logic;

    signal rd_ab_fifo_wren              :std_logic;
    signal rd_cd_fifo_wren              :std_logic;
    signal rd_ab_fifo_full              :std_logic;
    signal rd_ab_fifo_empty             :std_logic;
    signal rd_cd_fifo_full              :std_logic;
    signal rd_cd_fifo_empty             :std_logic;


    signal dmd_1080p_connected_1q       :std_logic;
    signal dmd_1080p_connected_2q       :std_logic;
    signal mem_data_in_count            :std_logic_vector(6 downto 0);
	 
	type control_states is (S0, S1, S2);
    signal current_state                :control_states;
    signal next_state                   :control_states;
	 
    
begin
    MIG_TOP_INIT : mig_top
        generic map(
            BANK_WIDTH => BANK_WIDTH,
            CKE_WIDTH  => CKE_WIDTH,
            CLK_WIDTH  => CLK_WIDTH,
            COL_WIDTH  => COL_WIDTH,
            CS_NUM     => CS_NUM,
            CS_WIDTH   => CS_WIDTH,
            CS_BITS    => CS_BITS,
            DM_WIDTH   => DM_WIDTH,
            DQ_WIDTH   => DQ_WIDTH,
            DQ_PER_DQS => DQ_PER_DQS,
            DQS_WIDTH  => DQS_WIDTH,
            DQ_BITS    => DQ_BITS,
            DQS_BITS   => DQS_BITS,
            ODT_WIDTH  => ODT_WIDTH,
            ROW_WIDTH  => ROW_WIDTH,
            ADDITIVE_LAT  => ADDITIVE_LAT,
            BURST_LEN  => BURST_LEN,
            BURST_TYPE => BURST_TYPE,
            CAS_LAT    => CAS_LAT,
            ECC_ENABLE => ECC_ENABLE,
            APPDATA_WIDTH => APPDATA_WIDTH,
            MULTI_BANK_EN => MULTI_BANK_EN,
            TWO_T_TIME_EN => TWO_T_TIME_EN,
            ODT_TYPE   => ODT_TYPE,
            REDUCE_DRV => REDUCE_DRV,
            REG_ENABLE => REG_ENABLE,
            TREFI_NS   => TREFI_NS,
            TRAS       => TRAS,
            TRCD       => TRCD,
            TRFC       => TRFC,
            TRP        => TRP,
            TRTP       => TRTP,
            TWR        => TWR,
            TWTR       => TWTR,
            HIGH_PERFORMANCE_MODE    => HIGH_PERFORMANCE_MODE,
            SIM_ONLY   => SIM_ONLY,
            DEBUG_EN   => DEBUG_EN,
            CLK_PERIOD => CLK_PERIOD,
            --DLL_FREQ_MODE => DLL_FREQ_MODE,
            --CLK_TYPE   => CLK_TYPE,
            --NOCLK200   => NOCLK200,
            RST_ACT_LOW   => RST_ACT_LOW
        )
        port map(
            ddr2_dq               => ddr2_dq,
            ddr2_a                => ddr2_a,
            ddr2_ba               => ddr2_ba,
            ddr2_ras_n            => ddr2_ras_n,
            ddr2_cas_n            => ddr2_cas_n,
            ddr2_we_n             => ddr2_we_n,
            ddr2_cs_n             => ddr2_cs_n,
            ddr2_odt              => ddr2_odt,
            ddr2_cke              => ddr2_cke,
            ddr2_dm               => ddr2_dm,

            sys_rst_n             => system_reset_n,
            clk200          		 => mem_clk200,
            locked					 => mem_locked,
            phy_init_done         => phy_init_done,
            rst0_tb               => rst0,
            clk0_tb               => clk0,
            clk0						 => mem_clk0,
            clk90						 => mem_clk90,
            clkdiv0					 => mem_clkdiv0,
           
            app_wdf_afull         => app_wdf_afull,
            app_af_afull          => app_af_afull,
            rd_data_valid         => rd_data_valid,
            app_wdf_wren          => app_wdf_wren,
            app_af_wren           => app_af_wren,
            app_af_addr           => app_af_addr,
            app_af_cmd            => app_af_cmd,
            rd_data_fifo_out      => rd_data_fifo_out,
            app_wdf_data          => app_wdf_data,
            app_wdf_mask_data     => app_wdf_mask_data,

            ddr2_dqs              => ddr2_dqs,
            ddr2_dqs_n            => ddr2_dqs_n,
            ddr2_ck               => ddr2_ck,
            ddr2_ck_n             => ddr2_ck_n
        );

    mem_read_ab_fifo : read_fifo
    port map(
        WR_CLK => clk0,
        RD_CLK => system_clk,
        RST => mem_rd_fifo_reset,
        WR_EN => rd_ab_fifo_wren,
        RD_EN => dmd_get_data,
        DIN => rd_data_fifo_out,
        DOUT => rd_ab_fifo_out,
        FULL => rd_ab_fifo_full,
        EMPTY => rd_ab_fifo_empty);
    
    mem_read_cd_fifo : read_fifo
    port map(
        WR_CLK => clk0,
        RD_CLK => system_clk,
        RST => mem_rd_fifo_reset,
        WR_EN => rd_cd_fifo_wren,
        RD_EN => dmd_get_data,
        DIN => rd_data_fifo_out,
        DOUT => rd_cd_fifo_out,
        FULL => rd_cd_fifo_full,
        EMPTY => rd_cd_fifo_empty);
    
    system_reset_n <= not system_reset;
	 
	 -----------------------------------------------
	 --S0: Idle state
	 --S1: Write state
	 --S2: Read state
	 -----------------------------------------------
    process(mem_clk0, rst0)
    begin
        if rst0 = '1' or phy_init_done = '0' then
            current_state <= S0;
        elsif mem_clk0'event and mem_clk0 = '1' then
            current_state <= next_state;
        end if;
    end process;	 
	 
    process(mem_clk0, rst0)
    begin
        if rst0 = '1' or phy_init_done = '0' then
            next_state <= S0;
        elsif mem_clk0'event and mem_clk0 = '1' then
            case current_state is
                when S0 =>
                    if mem_preload_done_1 = '0' then
                        next_state <= S1;
                    elsif read_enable = '1' then
                        next_state <= S2;
                    else
                        next_state <= S0;
                    end if;
                when S1 =>
                    if mem_preload_done_1 = '1' then
                        next_state <= S0;
                    else
                        next_state <= S1;
                    end if;
                when S2 =>
                    if pattern_read_done_1 = '1' then
                        next_state <= S0;
                    else
                        next_state <= S2;
                    end if;
                when others => next_state <= S0;
            end case;
        end if;
    end process;

    process(mem_clk0, rst0)
    begin
        if rst0 = '1' or phy_init_done = '0' then
            write_pattern_count <= "000000000000000";
            wr_offset_addr <= "0000000000000";
				mem_preload_done_1 <= '0';
				mem_get_data <= '0';
        elsif mem_clk0'event and mem_clk0 = '1' then
            if wr_ready = '1' and wr_valid = '1' and current_state = S1 then
                mem_get_data <= '1';
                if wr_offset_addr >= max_offset then
                    write_pattern_count <= write_pattern_count + "000000000000001";
                    if write_pattern_count < num_patterns then
                        wr_offset_addr <= "0000000000000"; -- start the next pattern
                    else
                        mem_preload_done_1 <= '1'; --finished all patterns write
                    end if;
                else
                    wr_offset_addr <= wr_offset_addr + "0000000000001"; -- continue write the same pattern
                end if;
            else
                mem_get_data <= '0';
            end if;
        end if;
    end process;
	 
    process(mem_clk0, rst0)
    begin
        if rst0 = '1' or phy_init_done = '0' then
            rd_offset_addr <= "0000000000000";
            pattern_read_done_1 <= '0';
        elsif mem_clk0'event and mem_clk0 = '1' then
            if current_state = S2 then
                if rd_offset_addr >= max_offset then
                    rd_offset_addr <= "0000000000000";
                    pattern_read_done_1 <= '1';
                else
                    rd_offset_addr <= rd_offset_addr + "0000000000001";
                end if;
            end if;
        end if;
    end process;

    --write and read
    process(mem_clk0, rst0)
    begin
        if rst0 = '1' or phy_init_done = '0' then
            app_wdf_wren <= '0';
            app_wdf_data <= x"00000000000000000000000000000000";
            app_wdf_mask_data <= x"0000";
            app_af_wren <= '0';
            app_af_cmd <= WRITE;
            app_af_addr <= b"0000000000000000000000000000000";
            burst_indicator <= '0';
        elsif mem_clk0'event and mem_clk0 = '1' then
            if current_state = S1 then
                if wr_ready = '1' and wr_valid = '1' then
                    -- for writing 2 consecutive data only 1 address is needed
                    if burst_indicator = '0' then
                        app_af_addr <= write_pattern_count & wr_offset_addr & "000";
                        app_af_cmd <= WRITE;
                        app_af_wren <= '1';
                    else
                        app_af_wren <= '0';
                    end if;
                    app_wdf_data <= wr_data;
                    app_wdf_wren <= '1';
                    burst_indicator <= not burst_indicator;
                else
                    app_wdf_data <= x"00000000000000000000000000000000";
                    app_wdf_wren <= '0';
                    app_af_wren <= '0';
                    app_af_addr <= b"0000000000000000000000000000000";
                end if;
            elsif current_state = S2 then
                app_af_addr <= rd_pattern_id & rd_offset_addr & "000";
                app_af_cmd <= READ;
                app_af_wren <= '1';
            else
                app_wdf_data <= x"00000000000000000000000000000000";
                app_wdf_wren <= '0';
                app_af_wren <= '0';
                app_af_addr <= b"0000000000000000000000000000000";
            end if;
        end if;
    end process;
    
    process(mem_clk0, rst0)
    begin
        if rst0 = '1' then
            dmd_1080p_connected_1q <= '0';
            dmd_1080p_connected_2q <= '0';
        elsif clk0'event and clk0 = '1' then
            dmd_1080p_connected_1q <= dmd_1080p_connected;
            dmd_1080p_connected_2q <= dmd_1080p_connected_1q;
        end if;
    end process;

    --put the incoming memory data into the correct FIFO
    process(mem_clk0, rst0)
    begin
        if rst0 = '1' or mem_rd_fifo_reset = '1' then
            rd_ab_fifo_wren <= '0';
            rd_cd_fifo_wren <= '0';
            mem_data_in_count <= "0000000";
        elsif mem_clk0'event and mem_clk0 = '1' then
            if rd_data_valid = '1' then
                if dmd_1080p_connected_2q = '1' then
                    mem_data_in_count <= mem_data_in_count + "0000001";
                    if mem_data_in_count <= x"3B" then --ab data to be written to ab fifo
                        rd_ab_fifo_wren <= '1';
                        rd_cd_fifo_wren <= '0';
                    elsif mem_data_in_count <= x"76" then --cd data to be written to cd fifo
                        rd_ab_fifo_wren <= '0';
                        rd_cd_fifo_wren <= '1';
                    else
                        --reset counter
                        mem_data_in_count <= "0000000";
                    end if;
                else
                    rd_ab_fifo_wren <= '1'; --XGA
                end if;
            else
                rd_ab_fifo_wren <= '0';
                rd_cd_fifo_wren <= '0';
            end if;
        end if;
    end process;

    wr_ready         <= app_af_afull and app_wdf_afull;
	read_enable      <= mem_read_enable;
    mem_preload_done <= mem_preload_done_1;
    rd_ab_fifo_valid <= not rd_ab_fifo_empty;
    rd_cd_fifo_valid <= not rd_cd_fifo_empty;
	 mem_init_done <= phy_init_done;
end architecture Behavioral;