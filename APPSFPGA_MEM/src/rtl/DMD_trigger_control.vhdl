library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

--component declarations library
LIBRARY ddc4100;
USE ddc4100.appsfpga_dmd_types_pkg.ALL;

entity DMD_trigger_control is
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

        --Memory signals
        rd_ab_fifo_valid            :in std_logic;
        rd_cd_fifo_valid            :in std_logic;
		  rd_ab_fifo_data_valid			:in std_logic;
		  rd_cd_fifo_data_valid			:in std_logic;
        dmd_get_row_data            :out std_logic;
        dmd_row_fifo_reset          :in std_logic;
        rd_ab_fifo_out              :in std_logic_vector(127 downto 0);
        rd_cd_fifo_out              :in std_logic_vector(127 downto 0);
		  mem_preload_done				:in std_logic;
		  mem_read_enable					:out std_logic;
		  trigger_miss					   :out std_logic; --test only
        
        --GPIO trigger
        trigger                     :in std_logic
    );
end DMD_trigger_control;

architecture Behavioral of DMD_trigger_control is
    component write_counter
    port(
        --clock and reset
        clk_g                   :in std_logic;
        locked_init_rstz_gq     :in std_logic;

        counter_en              :in std_logic;
		  counter_reset			  :in std_logic;

        in_dmd_type             :in std_logic_vector(3 downto 0 );
        row_count               :in std_logic_vector(10 downto 0);

        --active, blank, and pattern counters and enable signals
        cnts_row_pos_cnt        :out std_logic_vector(10 downto 0)
    );
	 end component;
	 
	 signal get_row_data						 :std_logic;
	 
    signal trigger_1                    :std_logic;
    signal trigger_1q                   :std_logic;
	 signal trigger_2q						 :std_logic;

    signal dmd_1080p_connected_1q       :std_logic;
    signal dmd_1080p_connected_2q       :std_logic;
	 signal every_other_row					 :std_logic;
	 
    signal dmd_ab			  :std_logic_vector(127 downto 0);
    signal dmd_cd			  :std_logic_vector(127 downto 0);
    signal dmd_ab_swap		  :std_logic_vector(127 downto 0);
    signal dmd_cd_swap		  :std_logic_vector(127 downto 0);
	 
    signal cnts_row_pos_cnt   :std_logic_vector(10 downto 0);
    signal cnts_row_pos_cnt_q1:std_logic_vector(10 downto 0);
	 signal cnts_row_pos_cnt_q2:std_logic_vector(10 downto 0);


	 
	 --reset indicated by inputs and reset being used
	 signal    current_reset_type          : std_logic_vector (1 downto 0);
	 signal    rowaddrmode                 : std_logic;
	 

	 
	 signal assign_type                 :DMD_TYPE_ASSIGN; -- type defined in appsfpga_dmd_types_pkg.vhd
	 signal WL_count                    :std_logic_vector(5 downto 0);
	 signal BSA_count                   :std_logic_vector(4 downto 0);
	 signal row_count                   :std_logic_vector(10 downto 0);

    signal counter_en           :std_logic;
	 signal counter_reset 		  :std_logic;

    type control_states is (S0, S1);
    signal current_state                :control_states;
    signal next_state                   :control_states;
	 
	 signal dmd_dvalid_1q					 :std_logic;
	 signal dmd_dvalid_2q					 :std_logic;
	 signal dmd_dvalid_1 					 :std_logic;
	 
	 signal blk_dvalid						 :std_logic;
	 
	 signal data_in_count 					 :std_logic_vector(3 downto 0);
	 signal trigger_miss_1					 :std_logic; --test only
	 signal rst_enable						 :std_logic;
	 signal rst_count							 :std_logic_vector(3 downto 0);

    begin
        trigger_write_counter : write_counter
        port map(
        --clock and reset
        clk_g                   => clk_g,
        locked_init_rstz_gq     => locked_init_rstz_gq,

        counter_en              => counter_en,
		  counter_reset			  => counter_reset,

        in_dmd_type             => in_dmd_type,
        row_count               => row_count,

        --active, blank, and pattern counters and enable signals
        cnts_row_pos_cnt        => cnts_row_pos_cnt
        );

        -- DMD type:
        -- 0000   .95" 1080p Type A
        -- 0001   .7" XGA Type A
        -- 0010   .55" XGA Type A
        -- 0011   .55" XGA Type X
        -- 0100   .65" 1080p Diamond (Not supported in phase 1)
        -- 0101   .95" WUXGA Type A
        -- 0111   .65 NIR WXGA

        -- Assign DMD types
        assign_type <= TEN80 when   in_dmd_type = "0000" else
                       XGA   when   in_dmd_type = "0001" else
                       XGA   when   in_dmd_type = "0010" else
                       XGA   when   in_dmd_type = "0011" else
                       WUXGA when   in_dmd_type = "0101" else
                       WXGA  when   in_dmd_type = "0111" else
                       ZEROES;

        WL_count  <= GET_WL_COUNT(assign_type);
        BSA_count <= GET_BSA_COUNT(assign_type);
        row_count <= GET_ROW_COUNT(assign_type);

        process (clk_g, locked_init_rstz_gq)
        begin
        if locked_init_rstz_gq = '0' then
            cnts_row_pos_cnt_q1 <= (OTHERS => '0');
            cnts_row_pos_cnt_q2 <= (OTHERS => '0');
        elsif clk_g = '1' and clk_g'event then
            cnts_row_pos_cnt_q1 <= cnts_row_pos_cnt    AFTER 1 PS;
            cnts_row_pos_cnt_q2 <= cnts_row_pos_cnt_q1 AFTER 1 PS;
        end if;
        end process;
		  
        process (clk_g, locked_init_rstz_gq)
        begin
        if locked_init_rstz_gq = '0' then
				dmd_dvalid_1q <= '0';
				dmd_dvalid_2q <= '0';
        elsif clk_g = '1' and clk_g'event then
				dmd_dvalid_1q <= dmd_dvalid_1 AFTER 1 PS;
				dmd_dvalid_2q <= dmd_dvalid_1q AFTER 1 PS;
        end if;
        end process;
		  
		  dmd_dvalid <= dmd_dvalid_1q or blk_dvalid;

--        process (clk_g, locked_init_rstz_gq)
--        begin
--            if locked_init_rstz_gq = '0' then
--                dmd_blkmd <= "00";
--                dmd_blkad <= "0000";
--					 blk_dvalid <= '0';
--            elsif clk_g = '1' and clk_g'event then
--					 if cnts_row_pos_cnt = "00000000000" and cnts_row_pos_cnt_q1 = row_count then
--					     dmd_blkmd <= "11";
--						  dmd_blkad <= "1000";
--						  blk_dvalid <= '1';
--					 else
--						  dmd_blkmd <= "00";
--						  dmd_blkad <= "0000";
--						  blk_dvalid <= '0';
--					 end if;
--				end if;
--        end process;
        process (clk_g, locked_init_rstz_gq)
        begin
            if locked_init_rstz_gq = '0' then
                dmd_blkmd <= "00";
                dmd_blkad <= "0000";
					 blk_dvalid <= '0';
					 rst_enable <= '0';
					 rst_count <= "0000";
            elsif clk_g = '1' and clk_g'event then
					 if cnts_row_pos_cnt = "00000000000" and cnts_row_pos_cnt_q1 = row_count then
					     rst_enable <= '1';
					 end if;
					 
					 if rst_enable = '1' then
					     if rst_count = "0111" then
						      rst_enable <= '0';
								rst_count <= "0000";
						  else
						      rst_count <= rst_count + "0001";
						  end if;
						  dmd_blkmd <= "11";
						  dmd_blkad <= "1000";
						  blk_dvalid <= '1';
					 else
					     dmd_blkmd <= "00";
						  dmd_blkad <= "0000";
						  blk_dvalid <= '0';
					 end if;
				end if;
        end process;

        process (clk_g, locked_init_rstz_gq)
            begin
            if locked_init_rstz_gq = '0' then
                dmd_rowmd <= "00";
            elsif clk_g = '1' and clk_g'event then
					 if dmd_dvalid_1 = '0' then
						  dmd_rowmd <= "00" AFTER 1 PS;
					 elsif cnts_row_pos_cnt = "00000000000" then
					     dmd_rowmd <= "11" AFTER 1 PS;
					 else
						  dmd_rowmd <= "01" AFTER 1 PS;
					 end if;
            end if;
        end process;
		  dmd_rowad <= (others => '0');

        --generate trigger pulse
		  --[TODO maybe] remove when external trigger implemented
        --trigger_1 <= trigger_1q and not trigger_2q;
        --process(clk_g, locked_init_rstz_gq)
        --begin
        --    if locked_init_rstz_gq = '0' then
        --        trigger_1q <= '0';
		  --			 trigger_2q <= '0';
        --    elsif clk_g'event and clk_g = '1' then
        --        trigger_1q <= trigger;
		  --		 trigger_2q <= trigger_1q;
        --    end if;
        --end process;
		  
		  --test only
		  process(clk_g, locked_init_rstz_gq)
        begin
            if locked_init_rstz_gq = '0' then
                trigger_miss_1 <= '0';
            elsif clk_g'event and clk_g = '1' then
                if current_state = S1 and trigger = '1' then
						trigger_miss_1 <= '1';
					 end if;
            end if;
        end process;
		  trigger_miss <= trigger_miss_1;

        ------------------------------------------------------------------------
        --S0: IDLE
        --S1: DMD outputs next pattern
        ------------------------------------------------------------------------

        --update the current state
        process(clk_g, locked_init_rstz_gq)
        begin
            if locked_init_rstz_gq = '0' then
                current_state <= S0;
            elsif clk_g'event and clk_g = '1' then
                current_state <= next_state;
            end if;
        end process;
        
        --update the next state
		  --[POI] Area of interest when modifying trigger processing functionality
        process(current_state, data_in_count, trigger, ddc_init_active, mem_preload_done, cnts_row_pos_cnt_q1, cnts_row_pos_cnt, rd_ab_fifo_valid, rd_cd_fifo_valid, rd_ab_fifo_data_valid, rd_cd_fifo_data_valid)
        begin
			 case current_state is
				  when S0 =>
				  counter_en <= '0';
				  get_row_data <= '0';
				  dmd_dvalid_1 <= '0';
				  counter_reset <= '0';
				  mem_read_enable <= '0';
				  if trigger = '1' and ddc_init_active = '0' and mem_preload_done = '1' then
						next_state <= S1;
				  else
						next_state <= S0;
				  end if;
				  
				  when S1 =>
				  if cnts_row_pos_cnt = "00000000000" and cnts_row_pos_cnt_q1 = row_count then
						next_state <= S0;
						counter_reset <= '1';
						counter_en <= '0';
						get_row_data <= '0';
						dmd_dvalid_1 <= '0';
						mem_read_enable <= '0';
				  else
						if data_in_count = "0000" then
							get_row_data <= rd_ab_fifo_valid;
						end if;
						
					   if rd_ab_fifo_data_valid = '1' or rd_cd_fifo_data_valid = '1' then
							counter_en <= '1';
							dmd_dvalid_1 <= '1';
						else
							counter_en <= '0';
							dmd_dvalid_1 <= '0';
						end if;
					   next_state <= S1;
					   counter_reset <= '0';
						mem_read_enable <= '1';
				  end if;
				  
				  when others => next_state <= S0;
			 end case;  
        end process;  
			
		  process(clk_g, locked_init_rstz_gq)
		  begin
				if locked_init_rstz_gq = '0' then
					data_in_count <= (others => '0');
				elsif clk_g'event and clk_g = '1' then
					if current_state = S1 then
						if get_row_data = '1' then
							if data_in_count = "0111" then
								data_in_count <= "0000";
							else
								data_in_count <= data_in_count + "0001";
							end if;
						end if;
					else
						data_in_count <= (others => '0');
					end if;
				end if;
			end process;

		  dmd_get_row_data <= get_row_data;
			
        -------------------------------------------------------------------------------------
        -- Memory Read FIFO logic
        
        process (locked_init_rstz_gq, clk_g)
        begin
            if (locked_init_rstz_gq = '0') then
                dmd_1080p_connected_1q <= '0';
                dmd_1080p_connected_2q <= '0';
            elsif rising_edge(clk_g) then
                dmd_1080p_connected_1q <= dmd_1080p_connected AFTER 1 PS;
                dmd_1080p_connected_2q <= dmd_1080p_connected_1q AFTER 1 PS;
        end if;
        end process;
		  
		  process(clk_g, locked_init_rstz_gq)
        begin
            if locked_init_rstz_gq = '0' then
                dmd_ab <= x"00000000000000000000000000000000";
                dmd_cd <= x"00000000000000000000000000000000";
            elsif clk_g'EVENT AND clk_g = '1' then
					 dmd_ab <= rd_ab_fifo_out;
					 --dmd_ab <= x"0000000000000000ffffffffffffffff";
            end if;
        end process;

        --Defines for the DDR outputs to the DDC
        --Align data to properly be directed to channel A, B, C or D	

        dmd_ab_swap <= dmd_ab(127 downto 112) & dmd_ab(95 downto 80) & dmd_ab(63 downto 48) & dmd_ab(31 downto 16) &
                                dmd_ab(111 downto 96) & dmd_ab(79 downto 64) & dmd_ab(47 downto 32) & dmd_ab(15 downto 0);

        dmd_cd_swap <= dmd_cd(127 downto 112) & dmd_cd(95 downto 80) & dmd_cd(63 downto 48) & dmd_cd(31 downto 16) &
                                dmd_cd(111 downto 96) & dmd_cd(79 downto 64) & dmd_cd(47 downto 32) & dmd_cd(15 downto 0);	

        dmd_dout_a <= dmd_ab_swap(127 downto 64);		
        dmd_dout_b <= dmd_ab_swap(63  downto  0);		
        dmd_dout_c <= dmd_cd_swap(127 downto 64);		
        dmd_dout_d <= dmd_cd_swap(63  downto  0);


		  dmd_comp_data <= '0'; --pgen_comp_data_q;
        dmd_ns_flip <= '0'; --pgen_ns_flip_q;
        dmd_rst2blkz <= '0'; --pgen_rst2blkz_q;
		  
		  dmd_STEP_VCC <= '0';

    end Behavioral;