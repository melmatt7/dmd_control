--'''''''''''''''''''''''''' THIS IS SAMPLE CODE ONLY! '''''''''''''''''''''''''''''''''
--''                                                                                  ''
--''  Module Name:                                                                    ''
--''                                                                                  ''
--''        USB_REG_INST                                                              ''
--''                                                                                  ''
--''  Abstract:                                                                       ''
--''                                                                                  ''
--''        Register read and writes                                                  ''
--''                                                                                  ''
--''  Notes:                                                                          ''
--''                                                                                  ''
--''      THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY       ''
--''      KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE         ''
--''      IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR       ''
--''      PURPOSE.                                                                    ''
--''                                                                                  ''
--''  Build Date 10/29/2008, Dallas, TX                                               ''
--''                                                                                  ''
--''  Copyright (c) 2008 Texas Instruments, Incorporated                              ''
--''  All Rights Reserved.                                                            ''
--''                                                                                  ''
--''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;  
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY D4100_registers is
  PORT ( system_clk 		: IN  STD_LOGIC;
         system_reset	        : IN  STD_LOGIC;
	 --USB interface
	 pll_speed_info      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
	 dvalid_space_info   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
	 BUILD_NUMBER        : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
	 reg_address	        : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
	 reg_write_data         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
	 write_reg_vail         : IN  STD_LOGIC;
	 reg_read_data          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 fifo_reset	        : OUT STD_LOGIC;
	
	 gpio_out		: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 gpio_in		: IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	 gpio_external_reset    : IN  STD_LOGIC;
	 external_reset_enable  : OUT STD_LOGIC;
	 GPIO_reset_complete    : OUT STD_LOGIC;
	
	 --DDC Control
	 DMD_type		: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
	 DDC_version		: IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	 DMD_blk_md		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	 DMD_blk_ad		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 DMD_row_md		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	 DMD_row_ad		: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	 DMD_pwr_float  	: OUT STD_LOGIC;
	 DMD_wdt	        : OUT STD_LOGIC;
	 DMD_ns_flip		: OUT STD_LOGIC;
	 DMD_comp_data  	: OUT STD_LOGIC;
	 DMD_step_vcc		: OUT STD_LOGIC;
	-- DMD_ext_reset  	: OUT STD_LOGIC;
	 DMD_rst2blkz	        : OUT STD_LOGIC;
	 -- 
	 load4_en               : OUT STD_LOGIC;
	 tpg_en                 : OUT STD_LOGIC; 
	 pattern_force          : OUT STD_LOGIC;
	 switch_en              : OUT STD_LOGIC;
	 pattern_nmbr           : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 swtch_override_val     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
	 --
	
	 DMD_RowLoads		: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 dmd_write_block	: OUT STD_LOGIC;
	 num_patterns : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
	 update_mode : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
			  
END D4100_registers;

ARCHITECTURE Behavioral OF D4100_registers IS

SIGNAL echo		       : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL global_reset	       : STD_LOGIC;
SIGNAL block_reset	       : STD_LOGIC;
SIGNAL active_block_mem        : STD_LOGIC;

SIGNAL DMD_blk_md_1	       : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL DMD_blk_ad_1	       : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL DMD_row_md_1	       : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL DMD_row_ad_1	       : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL DMD_pwr_float_1         : STD_LOGIC;
SIGNAL DMD_wdt_1	       : STD_LOGIC;
SIGNAL DMD_ns_flip_1	       : STD_LOGIC;
SIGNAL DMD_comp_data_1         : STD_LOGIC;
SIGNAL DMD_step_vcc_1          : STD_LOGIC;
SIGNAL DMD_rst2blkz_1	       : STD_LOGIC;

SIGNAL DMD_ext_reset_1         : STD_LOGIC;

SIGNAL dmd_write_block_1q      : STD_LOGIC;
SIGNAL dmd_write_block_1       : STD_LOGIC;

SIGNAL DMD_RowLoads_1	       : STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL fifo_reset_1	       : STD_LOGIC;
SIGNAL fifo_reset_1q	       : STD_LOGIC; 

SIGNAL gpio_out_1	       : STD_LOGIC_VECTOR(2 DOWNTO 0);

-- new merged gui/tpg registers
SIGNAL load4_1                 : STD_LOGIC;
SIGNAL pat_force_1             : STD_LOGIC; 
SIGNAL sw_en_1                 : STD_LOGIC; 
SIGNAL tpg_en_1                : STD_LOGIC;
SIGNAL sw_override_val_1       : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL pattern_sel_1           : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL num_patterns_1 			 : STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL update_mode_1 			 : STD_LOGIC_VECTOR(2 DOWNTO 0);

SIGNAL ResetComplete	       	 : STD_LOGIC;
SIGNAL dmd_write_block_2q      : STD_LOGIC;
SIGNAL dmd_write_block_3q      : STD_LOGIC;
SIGNAL DMD_ext_reset_1q        : STD_LOGIC;
SIGNAL gpio_external_reset_1q  : STD_LOGIC;

SIGNAL GPIO_reset_complete_1   : STD_LOGIC;
SIGNAL GPIO_reset_complete_1q  : STD_LOGIC;

SIGNAL reset_complete_count    : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL GPIO_reset_complete_f   : STD_LOGIC;
SIGNAL APPSFPGA_CODE_VERSION   : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL DISCOVERY_VERSION       : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
BEGIN

APPSFPGA_CODE_VERSION <= "00" & pll_speed_info & dvalid_space_info & BUILD_NUMBER; 
DISCOVERY_VERSION     <= x"AC02";

--Register Read Proccess
PROCESS(system_clk, system_reset)--, reg_address)
BEGIN
  IF system_reset = '1' THEN
    reg_read_data <= x"ABCD";
  ELSIF system_clk'EVENT AND system_clk = '1' THEN
    CASE reg_address is
      WHEN x"00"  => reg_read_data <= DISCOVERY_VERSION AFTER 1 PS;
      WHEN x"01"  => reg_read_data <= APPSFPGA_CODE_VERSION AFTER 1 PS;
      WHEN x"02"  => reg_read_data <= echo AFTER 1 PS;
  --  
      WHEN x"10"  => reg_read_data <= "000000000000"   & DMD_type(3 downto 0) AFTER 1 PS;
      WHEN x"11"  => reg_read_data <= "0000000000000"   & DDC_version(2 downto 0) AFTER 1 PS;
  --
      WHEN x"14"  => reg_read_data <= "00000000000000"  & DMD_row_md_1(1 downto 0) AFTER 1 PS;
      WHEN x"15"  => reg_read_data <= "00000"         & DMD_row_ad_1(10 downto 0) AFTER 1 PS;
      WHEN x"16"  => reg_read_data <= "00000000"	     & load4_1 & DMD_rst2blkz_1 & DMD_ext_reset_1 &  DMD_pwr_float_1 & DMD_wdt_1 & DMD_ns_flip_1 & DMD_comp_data_1 & DMD_step_vcc_1 AFTER 1 PS;
      WHEN x"17"  => reg_read_data <= "00000000000000"  & DMD_blk_md_1(1 downto 0) AFTER 1 PS;
      WHEN x"18"  => reg_read_data <= "000000000000"    & DMD_blk_ad_1(3 downto 0) AFTER 1 PS;  
      WHEN x"19"  => reg_read_data <= "00000000"        & gpio_in & gpio_out_1 & '0' & gpio_external_reset AFTER 1 PS;
      WHEN x"20"  => reg_read_data <= DMD_RowLoads_1 AFTER 1 PS;
      WHEN x"21"  => reg_read_data <= "000000000000000" & ResetComplete AFTER 1 PS;
      --WHEN x"22"  => reg_read_data <= "000000000000000" & GPIO_reset_complete_1  AFTER 1 PS;
--
      WHEN x"24"  => reg_read_data <= "0000000000000"   & pat_force_1 & sw_en_1 & tpg_en_1 AFTER 1 PS;
      WHEN x"25"  => reg_read_data <= "00000000"        & sw_override_val_1 AFTER 1 PS; 
      WHEN x"26"  => reg_read_data <= "0000000000000"   & pattern_sel_1 AFTER 1 PS; 
		WHEN x"27" => reg_read_data <= "0" & num_patterns_1 AFTER 1 PS;
		WHEN x"28" => reg_read_data <= "0000000000000" & update_mode_1 AFTER 1 PS;
  
      WHEN OTHERS => reg_read_data <= x"DEAD" AFTER 1 PS;
    END CASE;	  
  END IF;
END PROCESS;


--Processes the in comeing register Write commands.  
PROCESS(system_clk, system_reset)
BEGIN
  IF system_reset = '1' THEN
    dmd_write_block_1	    <= '0';
    global_reset	    <= '0';
    block_reset 	    <= '0';
    active_block_mem	    <= '0'; 

    DMD_blk_md_1            <= "00";
    DMD_blk_ad_1            <= "0000";
    DMD_row_md_1            <= "00";
    DMD_row_ad_1            <= "00000000000";
    DMD_RowLoads_1          <= x"0000";

    DMD_step_vcc_1          <= '0';
    DMD_comp_data_1         <= '0';
    DMD_ns_flip_1           <= '0';
    DMD_wdt_1		    <= '1';	 -- 0 = WDT on, 1 = WDT off
    DMD_pwr_float_1         <= '1';
    DMD_ext_reset_1         <= '0';				    
    DMD_rst2blkz_1          <= '0';
    fifo_reset_1            <= '0';

	gpio_out_1             <= "000";
    echo                   <= x"EECC" ;
    -- new registers
    load4_1                 <= '0';  --  STD_LOGIC;
    pat_force_1             <= '0';  --  STD_LOGIC; 
    sw_en_1                 <= '1';  --  STD_LOGIC; 
    tpg_en_1                <= '1';  --  STD_LOGIC;
    sw_override_val_1       <= "00000000";  --  STD_LOGIC_VECTOR(7 DOWNTO 0);
    pattern_sel_1           <= "000";       --  STD_LOGIC_VECTOR(2 DOWNTO 0); 
	 num_patterns_1 <= "000000000000000"; --  STD_LOGIC_VECTOR(14 DOWNTO 0);
	 update_mode_1 <= "000";	--  STD_LOGIC_VECTOR(2 DOWNTO 0);
	 
    GPIO_reset_complete_1   <= '0';
  ELSIF system_clk'EVENT AND system_clk = '1' THEN

    -- pulse generation
    IF fifo_reset_1q = '1' THEN
      fifo_reset_1 <= '0';
    END IF;
    IF dmd_write_block_1q = '1' THEN
      dmd_write_block_1 <= '0';
    END IF; 
    IF GPIO_reset_complete_1q = '1' THEN
  	    GPIO_reset_complete_1 <= '0';
    END IF;
  
    IF write_reg_vail = '1' THEN
      CASE reg_address IS
        WHEN x"02" =>  
	  echo                   <= reg_write_data;
	  
        WHEN x"03" =>  
	  dmd_write_block_1      <= reg_write_data(0);
          global_reset           <= reg_write_data(1);
          block_reset	         <= reg_write_data(2);
          active_block_mem       <= reg_write_data(3);   -- 0=first, 1=second
          fifo_reset_1           <= reg_write_data(4); 				        

        WHEN x"14" =>  
	  DMD_row_md_1           <= reg_write_data(1 downto 0);
	  
        WHEN x"15" =>  
	  DMD_row_ad_1           <= reg_write_data(10 downto 0);
        
        WHEN x"16" =>  
	  DMD_step_vcc_1         <= reg_write_data(0);
          DMD_comp_data_1        <= reg_write_data(1);
          DMD_ns_flip_1          <= reg_write_data(2);
          DMD_wdt_1	         <= reg_write_data(3);
          DMD_pwr_float_1        <= reg_write_data(4);
          DMD_ext_reset_1        <= reg_write_data(5);
          DMD_rst2blkz_1         <= reg_write_data(6);
          load4_1                <= reg_write_data(7);

        WHEN x"17" =>  
	  DMD_blk_md_1           <= reg_write_data(1 downto 0);
	  
        WHEN x"18" =>  
	  DMD_blk_ad_1           <= reg_write_data(3 downto 0);
	  
        WHEN x"19" =>  
	  gpio_out_1	         <= reg_write_data(2 downto 0);
        		
        WHEN x"20" =>  
	  DMD_RowLoads_1         <= reg_write_data;

        -- x"21" Read Only
        
        WHEN x"22" =>  
	  GPIO_reset_complete_1  <= reg_write_data(0);

        WHEN x"24" =>
          tpg_en_1               <= reg_write_data(0);
          sw_en_1                <= reg_write_data(1);
	  pat_force_1            <= reg_write_data(2);

        WHEN x"25" => 
          sw_override_val_1      <= reg_write_data(7 downto 0);
          
        WHEN x"26" => 
	  pattern_sel_1          <= reg_write_data(2 downto 0);
	  
			WHEN x"27"=>
			num_patterns_1 <= reg_write_data(14 downto 0);
			
			WHEN x"28"=>
			update_mode_1 <= reg_write_data(2 downto 0);
                								
        WHEN OTHERS =>  NULL;
      END CASE;
    END IF;
  END IF;
END PROCESS;


--Creates queues needed to pulse signals that need plusing
PROCESS(system_clk, system_reset)
BEGIN
  IF system_reset = '1' THEN
    fifo_reset_1q          <= '0';
    dmd_write_block_1q     <= '0';
    GPIO_reset_complete_1q <= '0';
  ELSIF system_clk'EVENT AND system_clk = '1' THEN
    fifo_reset_1q          <= fifo_reset_1;
    dmd_write_block_1q     <= dmd_write_block_1;
    GPIO_reset_complete_1q <= GPIO_reset_complete_1;
  END IF;
END PROCESS;

--creates a 1us Pulse when GPIO_reset_complete_1 is written to
PROCESS(system_clk, system_reset)
BEGIN
  IF system_reset = '1' THEN
    reset_complete_count  <= x"00";
    GPIO_reset_complete_f <= '0';
  ELSIF system_clk'EVENT AND system_clk = '1' THEN
    IF GPIO_reset_complete_1 = '1' THEN
      reset_complete_count    <= x"C8";
    ELSE
      IF reset_complete_count > x"00" THEN
  	GPIO_reset_complete_f <= '1';
  	reset_complete_count  <= reset_complete_count - x"01";
      ELSE
  	GPIO_reset_complete_f <= '0';
      END IF;
    END IF;
  END IF;
END PROCESS;

--Controls the ResetComplete Register,  when external reset go from disable to enabled
--the Reset complete register is cleared.  when the external reset trigger is received. the 
--reset complete register is set high.
PROCESS(system_clk, system_reset, DMD_ext_reset_1)
BEGIN
  IF system_reset = '1' THEN
    DMD_ext_reset_1q       <= '0';
    gpio_external_reset_1q <= '0';
    ResetComplete          <= '0';
  ELSIF system_clk'EVENT AND system_clk = '1' THEN
    DMD_ext_reset_1q       <= DMD_ext_reset_1;
    gpio_external_reset_1q <= gpio_external_reset;
    IF DMD_ext_reset_1 = '1' AND DMD_ext_reset_1q = '0' then
      ResetComplete <= '0';
    ELSIF DMD_ext_reset_1 = '1' AND gpio_external_reset_1q = '0' AND gpio_external_reset = '1' THEN
      ResetComplete <= '1';
    END IF;
  END IF;
END PROCESS;


--Renaming section
--DMD_ext_reset       <= DMD_ext_reset_1; 
fifo_reset            <= fifo_reset_1;
dmd_write_block       <= dmd_write_block_1;
dmd_write_block       <= dmd_write_block_1;
external_reset_enable <= DMD_ext_reset_1;
DMD_blk_md            <= DMD_blk_md_1;
DMD_blk_ad            <= DMD_blk_ad_1;
DMD_row_md            <= DMD_row_md_1;
DMD_row_ad            <= DMD_row_ad_1;
DMD_pwr_float         <= DMD_pwr_float_1;
DMD_wdt               <= DMD_wdt_1;
DMD_ns_flip           <= DMD_ns_flip_1;
DMD_comp_data         <= DMD_comp_data_1;
DMD_step_vcc          <= DMD_step_vcc_1;
DMD_rst2blkz          <= DMD_rst2blkz_1;
DMD_RowLoads          <= DMD_RowLoads_1;
gpio_out              <= gpio_out_1;
GPIO_reset_complete   <= GPIO_reset_complete_f;
--
swtch_override_val    <= sw_override_val_1;
pattern_nmbr          <= pattern_sel_1;
num_patterns <= num_patterns_1;
update_mode <= update_mode_1;
load4_en              <= load4_1;
tpg_en                <= tpg_en_1;
pattern_force         <= pat_force_1;
switch_en             <= sw_en_1;

end Behavioral;

