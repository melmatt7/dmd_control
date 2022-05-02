library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity USB_IO is
    port
    (
        --clocks
        ifclk               :in std_logic; --48MHz usb clock
        system_clk          :in std_logic; --200MHz system clock
        mem_clk             :in std_logic; --150MHz DDR2 memory clock

        --resets
        reset_i             :in std_logic; --external reset
        system_reset        :in std_logic; --reset from appfpga_io
        
        --usb ports
        bidir               :inout std_logic_vector(15 downto 0); --bidirectional usb data
		  --usb_din				 :in std_logic_vector(15 downto 0); --simulation only
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
        reg_data_valid      :out std_logic
    );
end USB_IO;

architecture Behavioral of USB_IO is
	 
    component PLL_USB is
	  port(
			CLKIN1_IN  :in std_logic;
			RST_IN     :in std_logic;
			CLKOUT0_OUT:out std_logic;
			CLKOUT1_OUT:out std_logic;
			CLKOUT2_OUT:out std_logic;
			LOCKED_OUT :out std_logic);
    end component; 
	 
	 component FIFO_RCV2 IS
	 PORT(
		  din           : IN    std_logic_vector(15 DOWNTO 0);
		  rd_clk        : IN    std_logic;
		  rd_en         : IN    std_logic;
		  rst           : IN    std_logic;
		  wr_clk        : IN    std_logic;
		  wr_en         : IN    std_logic;
		  dout          : OUT   std_logic_vector(127 DOWNTO 0);
		  empty         : OUT   std_logic;
		  full          : OUT   std_logic);
	 end component;

    component fifo is
	  port(
			WR_CLK          :in std_logic;
			RD_CLK          :in std_logic;
			RST             :in std_logic;
			WR_EN           :in std_logic;
			RD_EN           :in std_logic;
			DIN             :in std_logic_vector(15 downto 0);
			DOUT            :out std_logic_vector(127 downto 0);
			VALID				 :out std_logic;
			FULL            :out std_logic;
			EMPTY           :out std_logic
	  );
    end component;
	 
	 component fifo_register is
	 port(
			din			:in std_logic_vector(31 downto 0);
			rd_clk		:in std_logic;
			rd_en		:in std_logic;
			rst			:in std_logic;
			wr_clk		:in std_logic;
			wr_en		:in std_logic;
			dout		:out std_logic_vector(31 downto 0);
			empty		:out std_logic;
			full		:out std_logic
	);
	end component;
	 

    signal gpif_from_port           :std_logic_vector(15 downto 0);
	 signal gpif_test           :std_logic_vector(15 downto 0);
    signal gpif_to_port             :std_logic_vector(15 downto 0);
    signal gpif_out_enable_n        :std_logic;
    
    signal clk_u                    :std_logic;
    signal clk_180_u                :std_logic;
    signal ifclk_bufg               :std_logic;

    signal USB_PLL_LOCKED_OUT       :std_logic;

    signal arst_usb                 :std_logic;
    signal arst_usb_1q              :std_logic;

    signal usb_recv_fifo_wr_en      :std_logic;

    signal mem_fifo_empty           :std_logic;
    signal mem_fifo_full            :std_logic;

    -- signal usb_single_data          :std_logic_vector(15 downto 0);
    -- signal usb_single_data_1q       :std_logic_vector(15 downto 0);
    -- signal usb_single_data_2q       :std_logic_vector(15 downto 0);
	 signal dmd_single_data				:std_logic_vector(15 downto 0);
	 signal dmd_single_data_1q			:std_logic_vector(15 downto 0);
	 signal dmd_single_data_2q	  	   :std_logic_vector(15 downto 0);

    signal data_fifo_wr_en_if       :std_logic;
    signal data_fifo_wr_en_if_1q    :std_logic;

    signal mem_fifo_wren            :std_logic;
    signal mem_fifo_ren             :std_logic;
	 
	 signal dmd_fifo_rd_en				:std_logic;

    signal dmd_1080p_connected_1q   :std_logic;
    signal dmd_1080p_connected_2q   :std_logic;

    signal fifo_ab_wen              :std_logic;
    signal fifo_cd_wen              :std_logic;
    signal usb_data_in_count        :std_logic_vector(6 downto 0);

    signal fifo_ren_1q              :std_logic;
    signal fifo_ren_2q              :std_logic;
    signal fifo_wen_1q              :std_logic;
    signal fifo_wen_2q              :std_logic;
    signal fifo_regn_1q             :std_logic;
    signal fifo_regn_2q             :std_logic;

    signal reg_fifo_in_rd_en        :std_logic;
    signal reg_fifo_in_rd_en_1q     :std_logic;
    signal reg_fifo_in_sclk         :std_logic_vector(31 downto 0);
    signal reg_fifo_in_sclk_1q      :std_logic_vector(31 downto 0);
    signal reg_fifo_in_empty        :std_logic;
    signal reg_fifo_in_empty_1q     :std_logic;
    signal reg_fifo_in_full         :std_logic;
    signal reg_fifo_in_din          :std_logic_vector(31 downto 0);

    signal reg_fifo_out_rd_en       :std_logic;
    signal reg_fifo_out_rd_en_1q    :std_logic;
    signal reg_fifo_out_clk_usb 	:std_logic_vector(31 DOWNTO 0);
    signal reg_fifo_out_empty	    :std_logic;
    signal reg_fifo_out_full 	    :std_logic;
    signal reg_fifo_out_din 	    :std_logic_vector(31 DOWNTO 0);

    signal reg_read_valid           :std_logic;
    signal reg_read_valid_1q        :std_logic;

    signal register_write_fifo_wren :std_logic;
    signal register_read_fifo_wren  :std_logic;
    signal register_write_enable    :std_logic;
    signal register_data_buffer_if  :std_logic_vector(15 downto 0);
    signal register_address_buffer_if   :std_logic_vector(7 downto 0);
	 constant SIM :boolean := false;
	 
	 signal usb_din_cnt	:std_logic_vector(11 downto 0);
	 signal row_cnt      :std_logic_vector(11 downto 0);
	 signal usb_recv_fifo_wr_en_q1 :std_logic;
	 signal num_data     :std_logic_vector(15 downto 0);

begin
--	 IF_SIM: if SIM = true generate
--		 DATA_loop: for i in 0 to 15 generate
--			  gpif_from_port(i) <= usb_din(i) when gpif_out_enable_n = '1'  else 'Z';
--		 end generate;
--	 end generate;
	 
	 IF_SIM_NOT: if SIM = false generate
		 DATA_loop:
		 for i in 0 to 15 generate
			  IOBUF_inst : IOBUF
			  generic map (
					DRIVE => 12,
					IBUF_DELAY_VALUE => "0", -- Specify the amount of added input delay for buffer, "0"-"16" (Spartan-3E/3A only)
					IFD_DELAY_VALUE => "AUTO", -- Specify the amount of added delay for input register, "AUTO", "0"-"8" (Spartan-3E/3A only)
					IOSTANDARD => "DEFAULT",
					SLEW => "SLOW")
			  port map (
					O => gpif_from_port(i),   	-- Buffer output
					IO => bidir(i),   			-- Buffer inout port (connect directly to top-level port)
					I => gpif_to_port(i),     	-- Buffer input
					T => gpif_out_enable_n     -- 3-state enable input. When '0' IO = I when '1' O = IO
			  );
		 end generate;
    end generate;

    i_bufg_ifclk : bufg
    port map (
        O => ifclk_bufg, -- Clock buffer output
        I => ifclk  -- Clock buffer input (connect directly to top-level port)
    );
		
    i_pll_usb : PLL_USB
    port map(
        CLKIN1_IN   => ifclk_bufg  ,
        RST_IN      => reset_i,
        CLKOUT0_OUT => clk_u,   -- 133MHz
        CLKOUT1_OUT => clk_180_u,  -- 266MHz
        CLKOUT2_OUT => OPEN,   -- 266MHz 180deg
        LOCKED_OUT  => USB_PLL_LOCKED_OUT);

    process(reset_i, clk_u)
    begin
        if (reset_i = '1') then
            arst_usb <= '1';
            arst_usb_1q <= '1';
        elsif rising_edge(clk_u) then
            arst_usb_1q <= not USB_PLL_LOCKED_OUT after 1 ps;
            arst_usb <= arst_usb_1q after 1 ps;
        end if;
    end process;

    fifo_usb_ab : FIFO_RCV2
    port map(
        din 	 => dmd_single_data_2q,
        rd_clk   => system_clk,
        rd_en    => dmd_fifo_rd_en,
        rst	 => dmd_row_fifo_reset,
        wr_clk   => clk_180_u,
        wr_en    => fifo_ab_wen,
        dout     => fifo_ab_data_out,
        empty    => open, 
        full     => open);
--
--    fifo_usb_cd : FIFO_RCV2
--	port map(
--        din 	 => dmd_single_data_2q,
--        rd_clk   => system_clk,
--        rd_en    => dmd_fifo_rd_en,
--        rst	 => dmd_row_fifo_reset,
--        wr_clk   => clk_180_u,
--        wr_en    => fifo_cd_wen,
--        dout     => fifo_cd_data_out,
--        empty    => open, 
--        full     => open);

--    fifo_ab_data_out <= (others => '0');
	 fifo_cd_data_out <= (others => '0');

    mem_data_fifo : fifo
    port map(
        WR_CLK => clk_180_u,
        RD_CLK => mem_clk,
        RST => mem_fifo_reset,
        WR_EN => mem_fifo_wren,
        RD_EN => mem_fifo_ren,
        DIN => dmd_single_data_2q,
        DOUT => mem_wr_data,
		  VALID => mem_wr_data_valid,
        FULL => mem_fifo_full,
        EMPTY => mem_fifo_empty);

    process(clk_180_u, arst_usb)
    begin
        if arst_usb = '1' then
            dmd_1080p_connected_1q <= '0';
            dmd_1080p_connected_2q <= '0';
				usb_recv_fifo_wr_en_q1 <= '0';
        elsif rising_edge(clk_180_u) then
            dmd_1080p_connected_1q <= dmd_1080p_connected AFTER 1 PS;
            dmd_1080p_connected_1q <= dmd_1080p_connected_1q AFTER 1 PS; 
				usb_recv_fifo_wr_en_q1 <= usb_recv_fifo_wr_en;
        end if;
    end process;

    --put the incomeing usb data into the correct FIFO	
    process(clk_180_u, arst_usb, dmd_row_fifo_reset, mem_fifo_reset)
    begin
        if arst_usb = '1' or mem_fifo_reset = '1' then
            fifo_ab_wen <= '0';
            fifo_cd_wen <= '0';
            usb_data_in_count <= "0000000";
				mem_fifo_wren <= '0';
				usb_din_cnt <= (others => '0');
				row_cnt		<= (others => '0');
				num_data    <= (others => '0');
        elsif clk_180_u'event and clk_180_u = '1' then
            if usb_recv_fifo_wr_en = '1' then
	
					 if usb_din_cnt <= "000000111111" then
					     mem_fifo_wren <= '1';
						  num_data <= num_data + "0000000000000001";
						  usb_din_cnt <= usb_din_cnt + "000000000001";
					 else
					     if row_cnt = "00000000" or row_cnt = "00101111" then
--						      usb_din_cnt <= usb_din_cnt + "000000000001";
						      mem_fifo_wren <= '0';
						  else
						      mem_fifo_wren <= '1';
								num_data <= num_data + "0000000000000001";
								usb_din_cnt <= "000000000001";
								if row_cnt = "001011111111" and num_data >= "0000000000000001" then --test only
									row_cnt <= (others => '0');
								else
									row_cnt <= row_cnt + "000000000001";
								end if;
						  end if;
					 end if;
					 
					 --mem_fifo_wren <= '1';
					 
                if dmd_1080p_connected_2q = '1' then
                usb_data_in_count <= usb_data_in_count + "0000001";
                    if usb_data_in_count <= x"3B" then     --ab data to be written to ab fifo
                        fifo_ab_wen <= '1';
                        fifo_cd_wen <= '0';
                    elsif usb_data_in_count <= x"76" then  --cd data to be written to the cd fifo
                        fifo_ab_wen <= '0';
                        fifo_cd_wen <= '1';
                    else
                        -- reset counter
                    usb_data_in_count <= "0000000";    --set to  all one. will roll over on increment below
                    end if;
                else																--XGA
                    fifo_ab_wen <= '1';
                end if;
            else
				
				    if usb_recv_fifo_wr_en_q1 = '1' and (row_cnt = "00000000" or row_cnt = "00101111") then
					     row_cnt <= row_cnt + "000000000001";
						  usb_din_cnt <= (others => '0');
					 end if;
				    --usb_din_cnt <= (others => '0');
					 
                mem_fifo_wren <= '0';
                fifo_ab_wen <= '0';
                fifo_cd_wen <= '0';
            end if;
        end if;
    end process;

    --Data queues
    process(clk_180_u, arst_usb)
    begin
        if arst_usb = '1' then
            data_fifo_wr_en_if_1q <= '0';
            dmd_single_data_1q <= x"0000";
            dmd_single_data_2q <= x"0000";
        elsif clk_180_u'event and clk_180_u = '1' then
            data_fifo_wr_en_if_1q <= data_fifo_wr_en_if;
			   for i in 0 to 15 loop
					 dmd_single_data_1q(i) <= dmd_single_data(15-i);
			   end loop;  -- i
            dmd_single_data_2q <= dmd_single_data_1q;
        end if;
    end process;

    process(clk_180_u, arst_usb)
    begin
        if arst_usb = '1' then
            fifo_ren_1q <= '0';
            fifo_ren_2q <= '0';
            fifo_wen_1q <= '0';
            fifo_wen_2q <= '0';
            fifo_regn_1q <= '0';
            fifo_regn_2q <= '0';
        elsif clk_180_u'event and clk_180_u = '1' then
            fifo_ren_1q <= fifo_ren;
            fifo_ren_2q <= fifo_ren_1q;
            fifo_wen_1q <= fifo_wen;
            fifo_wen_2q <= fifo_wen_1q;
            fifo_regn_1q <= fifo_regn;
            fifo_regn_2q <= fifo_regn_1q;
        end if;
    end process;

    process(system_clk, system_reset)
    begin
        if system_reset = '1' then
            reg_fifo_in_sclk_1q <= (others => '0');
        elsif system_clk'event and system_clk = '1' then
            reg_fifo_in_sclk_1q <= reg_fifo_in_sclk;
        end if;
    end process;

    reg_fifo_in : fifo_register
    port map (
        din => reg_fifo_in_din,
        rd_clk => system_clk,
        rd_en => reg_fifo_in_rd_en,
        rst => arst_usb,
        wr_clk => clk_180_u,
        wr_en => register_write_fifo_wren,
        dout => reg_fifo_in_sclk,
        empty => reg_fifo_in_empty,
        full => reg_fifo_in_full);
    
    reg_fifo_out_din <= "0000000000000000" & reg_data_to_USB;

    reg_fifo_out : fifo_register
    port map (
        din => reg_fifo_out_din,
        rd_clk => clk_180_u,
        rd_en => reg_fifo_out_rd_en,
        rst => arst_usb,
        wr_clk => system_clk,
        wr_en => register_read_fifo_wren,
        dout => reg_fifo_out_clk_usb,
        empty => reg_fifo_out_empty,
        full => reg_fifo_out_full);

    process(clk_180_u, arst_usb)
    begin
        if arst_usb = '1' then
            data_fifo_wr_en_if <= '0';
            dmd_single_data <= (others => '0');
        elsif clk_180_u'event and clk_180_u = '1' then
            if FIFO_WEN = '0' and FIFO_REN = '1' and FIFO_REGN = '1' then
                dmd_single_data <= gpif_from_port(7 downto 0) & gpif_from_port(15 downto 8);
                data_fifo_wr_en_if <= '1';
            else
                data_fifo_wr_en_if <= '0';
            end if;
        end if;
    end process;

    --set the register address
    process(clk_180_u, arst_usb)
    begin
        if arst_usb = '1' then
            register_address_buffer_if <= x"00";
        elsif clk_180_u'event and clk_180_u = '1' then
            if fifo_wen = '1' and fifo_ren = '1' and fifo_regn = '0' then
                register_address_buffer_if <= gpif_from_port(7 downto 0);
            end if;
        end if;
    end process;

    --write register data to the fifo
    process(clk_180_u, arst_usb)
    begin
        if arst_usb = '1' then
            register_data_buffer_if <= x"0000";
            register_write_enable <= '0';
            register_write_fifo_wren <= '0';
        elsif clk_180_u'event and clk_180_u = '1' then
            if fifo_wen = '0' and fifo_ren = '1' and fifo_regn = '0' then
                --register data write command
                register_data_buffer_if <= gpif_from_port;
                register_write_enable <= '1';
                register_write_fifo_wren <= '1';
            elsif fifo_wen = '1' and fifo_ren = '1' and fifo_regn = '0' then
                --register address write command
                register_data_buffer_if <= x"0000";
                register_write_enable <= '0';
                register_write_fifo_wren <= '1';
            else
                register_write_fifo_wren <= '0';
            end if;
        end if;
    end process;
    reg_fifo_in_rd_en <= not reg_fifo_in_empty;

    reg_fifo_out_rd_en <= not reg_fifo_out_empty;

    register_read_fifo_wren <= reg_read_valid_1q;

    --set flag when new reg data is avalible
    process(system_clk, system_reset)
    begin
        if system_reset = '1' then
            reg_data_valid       <= '0';
            reg_read_valid       <= '0';
            reg_read_valid_1q    <= '0';
            reg_fifo_in_empty_1q <= '0';
            reg_fifo_in_rd_en_1q <= '0';
        elsif system_clk'event and system_clk = '1' then
            reg_fifo_in_empty_1q <= reg_fifo_in_empty;
            reg_read_valid_1q    <= reg_read_valid;
            reg_fifo_in_rd_en_1q <= reg_fifo_in_rd_en;
            if (reg_fifo_in_rd_en_1q = '1') then
                if (reg_fifo_in_sclk(31) = '1' and reg_fifo_in_empty = '1' and reg_fifo_in_empty_1q = '0') then
                    reg_data_valid <= '1';
                    reg_read_valid <= '0';
                else
                    reg_data_valid <= '0';
                    reg_read_valid <= '1';
                end if;
            else 
                reg_data_valid <= '0';
                reg_read_valid <= '0';
            end if;
        end if;
    end process;     

    usb_recv_fifo_wr_en <= data_fifo_wr_en_if and data_fifo_wr_en_if_1q;--data_fifo_wr_en_if; --
    gpif_out_enable_n <= fifo_ren;

    mem_fifo_ren <= mem_get_data;
	 mem_wr_valid <= not mem_fifo_empty;

    dmd_fifo_rd_en <= dmd_get_row_data;

    gpif_to_port <= reg_fifo_out_clk_usb(15 downto 0);
    reg_data_from_USB <= reg_fifo_in_sclk_1q(15 downto 0);
    reg_addra_USB <= reg_fifo_in_sclk_1q(23 downto 16 );
    reg_fifo_in_din <= register_write_enable & "0000000" & register_address_buffer_if & register_data_buffer_if;
end Behavioral;