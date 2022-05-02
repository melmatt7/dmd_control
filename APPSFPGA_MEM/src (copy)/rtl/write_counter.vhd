library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity write_counter is
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
end write_counter;

architecture Behavioral of write_counter is
    signal active_cnt           :std_logic_vector(4 downto 0);
    signal active_cnten         :std_logic;
    --signal row_pos_count_en     :std_logic;
    signal active_clks          :std_logic_vector(4 downto 0);
	 signal cnts_row_pos_cnt_1	  :std_logic_vector(10 downto 0);
    begin
        -- Pick active clk value based on dmd type
        process (clk_g, locked_init_rstz_gq)
        begin
            if (locked_init_rstz_gq = '0') then
                active_clks <= "00111";
            elsif clk_g = '1' AND clk_g'event then
                if in_dmd_type = "1111" then          --.9 WQXGA (20 clks/rowcycle) 
                    active_clks <= "01001" AFTER 1 ps;  -- (clks/2 - 1)
                elsif in_dmd_type = "1110" then       --.65 1080P (32 clks/rowcycle)
                    active_clks <= "01111" AFTER 1 ps;  -- (clks/2 - 1)
                elsif in_dmd_type = "0111" then       --.65 WXGA NIR(40 clks/rowcycle)
                    active_clks <= "10011" AFTER 1 ps;  -- (clks/2 - 1)
                else 
                    active_clks <= "00111" AFTER 1 ps;  -- Everything else (16 clks/row cycle)
                end if;
            end if;
        end process;

        --active counter keeps track of selected number of valid output data cycles
        process (clk_g, locked_init_rstz_gq)
        begin
        if (locked_init_rstz_gq = '0' or counter_reset = '1') then
            active_cnt <= "00000";
        elsif clk_g = '1' AND clk_g'event then
            if active_cnten = '1' then
					if (active_cnt = active_clks) then
						 active_cnt <= "00000";
					else
						 active_cnt <= active_cnt + 1 AFTER 1 PS;
					end if;
            end if;
        end if;
        end process;
		  
		  active_cnten <= counter_en;

        --increment row when active counter finishes
        process (clk_g, locked_init_rstz_gq)
        begin
            if (locked_init_rstz_gq = '0' or counter_reset = '1') then
                cnts_row_pos_cnt_1 <= "00000000000";
            ELSIF clk_g = '1' AND clk_g'event then
                if active_cnt = active_clks and counter_en = '1' then
                    if cnts_row_pos_cnt_1 = row_count then
                        cnts_row_pos_cnt_1 <= "00000000000" AFTER 1 PS;
                    else
                        cnts_row_pos_cnt_1 <= cnts_row_pos_cnt_1 + "00000000001" AFTER 1 PS;
                    end if;
                end if;
            end if;
        end process;
		  
		  cnts_row_pos_cnt <= cnts_row_pos_cnt_1;
    end Behavioral;



