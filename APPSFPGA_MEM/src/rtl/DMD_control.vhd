--'''''''''''''''''''''''''' THIS IS SAMPLE CODE ONLY! '''''''''''''''''''''''''''''''''
--''                                                                                  ''
--''  Module Name:                                                                    ''
--''                                                                                  ''
--''        DMD_CONTROL_INST                                                          ''
--''                                                                                  ''
--''  Abstract:                                                                       ''
--''                                                                                  ''
--''        Controls the signals to the DDC4000	                                      ''
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity DMD_control is
    Port ( system_clk 				 : IN  STD_LOGIC;
           system_reset 			 : IN  STD_LOGIC;
			  start_block_write		 : IN  STD_LOGIC;
	        DMD_RowLoads 			 : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
	        dmd_1080p_connected  	 : IN  STD_LOGIC;	
           quarter_buss_connected : IN    STD_LOGIC;	   
	        fifo_ab_data_out		 : IN  STD_LOGIC_VECTOR (127 DOWNTO 0);
	        fifo_cd_data_out		 : IN  STD_LOGIC_VECTOR (127 DOWNTO 0);
	        dmd_row_fifo_reset     : IN  STD_LOGIC;
	        dmd_get_row_data		 : OUT STD_LOGIC;
     	     gpio_external_reset  	 : IN  STD_LOGIC;
	        external_reset_enable	 : IN  STD_LOGIC;
	        --DDC control
	        ddc_init_active			 : IN  STD_LOGIC;
	        dmd_dout_a				 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	        dmd_dout_b				 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	        dmd_dout_c				 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	        dmd_dout_d				 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	        dmd_dvalid				 : OUT STD_LOGIC
	   );
			  
end DMD_control;			  


architecture Behavioral of DMD_control is


COMPONENT counter_4096 IS
    PORT ( clk           : IN  STD_LOGIC;
           rst           : IN  STD_LOGIC;
           count         : IN  STD_LOGIC;
           up_down       : IN  STD_LOGIC;
           counter_value : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END COMPONENT;


SIGNAL 	dmd_ab			  : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL 	dmd_cd			  : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL 	dmd_ab_swap		  : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL 	dmd_cd_swap		  : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	dvalid_f		     : STD_LOGIC;
SIGNAL 	dvalid_f_1q      : STD_LOGIC;

SIGNAL 	row_write_pos_rst   : STD_LOGIC;
SIGNAL	row_write_pos_count : STD_LOGIC;
SIGNAL	row_write_pos_ud	  : STD_LOGIC;
SIGNAL	row_write_pos_cnt	  : STD_LOGIC_VECTOR(11 DOWNTO 0);

SIGNAL outclkphase                : STD_LOGIC;
SIGNAL rows_to_load	             : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL decrement_row_load_counter : STD_LOGIC;

SIGNAL fifo_ab_data_out_1q        : STD_LOGIC_VECTOR(127 downto 0);
SIGNAL fifo_cd_data_out_1q	       : STD_LOGIC_VECTOR(127 downto 0);
SIGNAL every_other_row            : STD_LOGIC;
SIGNAL gpio_external_reset_1q	    : STD_LOGIC;
SIGNAL get_row_data		          : STD_LOGIC;

SIGNAL dmd_1080p_connected_1q     : STD_LOGIC;
SIGNAL dmd_1080p_connected_2q     : STD_LOGIC;

TYPE   delay_states IS (S1, S2, S3, S4, S5, S5B, S6, S7, S8, S9);
SIGNAL C_BLOCK_WRITE_STATE        : delay_states;

begin


DMD_row_write_possition_int : counter_4096
PORT MAP( 
  clk           => system_clk,
  rst           => row_write_pos_rst,
  count         => row_write_pos_count,
  up_down       => row_write_pos_ud,
  counter_value => row_write_pos_cnt);
    			    
row_write_pos_ud     <= '1';	

PROCESS (system_clk, system_reset)
BEGIN
   IF system_reset = '1' THEN
     outclkphase <= '0';
   ELSIF system_clk'EVENT and system_clk = '1' THEN
     outclkphase <= NOT outclkphase;
   END IF;
END PROCESS;
	
	
-------------------------------------------------------------------
--		 States:	
--			S1  - Wait for DDC to become ready
--			S2  - Checks if there are rows to be loaded	
--			S3  - Force even # colock between Row Loads
--			S4  - One clock cycle
--			S5  - Setup Row Load Flags, send row
--           S5B- Get other data for quarter buss
--			S6  - Clear Row Load Flags
--			S7  - Return to State 1
--			S8  - not used
--			S9  - not used
-------------------------------------------------------------------
		
		

--State Logic
PROCESS (system_clk, system_reset)
BEGIN
  IF system_reset = '1' THEN
    C_BLOCK_WRITE_STATE        <= S1;
    dvalid_f		           <= '0';
    row_write_pos_rst	       <= '1';      
    get_row_data	           <= '0';
    decrement_row_load_counter <= '0';
    row_write_pos_count  <= '1';
  ELSIF system_clk'EVENT and system_clk = '1' THEN
    CASE C_BLOCK_WRITE_STATE IS
      WHEN S1  =>
  	    IF ddc_init_active = '0' THEN
  	      C_BLOCK_WRITE_STATE <= S2 AFTER 1 PS;
  	    END IF;
      WHEN S2 =>
  	    IF rows_to_load > x"0000" THEN
  	      decrement_row_load_counter <= '1' AFTER 1 PS;
  	      C_BLOCK_WRITE_STATE <= S3 AFTER 1 PS;
  	    END IF;
      WHEN S3 => 
  	    decrement_row_load_counter <= '0'  AFTER 1 PS;
  	    IF (outclkphase = '1') THEN	-- force even # clocks between DVALID 
  	      C_BLOCK_WRITE_STATE <= S4 AFTER 1 PS; 
  	    END IF;
      WHEN S4  =>
  	    C_BLOCK_WRITE_STATE <= S5 AFTER 1 PS;
        row_write_pos_rst	<= '1' AFTER 1 PS;  
        row_write_pos_count  <= '1' AFTER 1 PS;		
      WHEN S5  =>
  	    dvalid_f <= '1' AFTER 1 PS;		
  	    row_write_pos_rst	<= '0' AFTER 1 PS;
		IF ( quarter_buss_connected = '0') THEN
          get_row_data <= '1' AFTER 1 PS;		
		  if (row_write_pos_cnt >= x"006") THEN -- 8-2
	        if dmd_1080p_connected_2q = '1' AND every_other_row = '1' then
		      get_row_data <= '0';
  	        end if;
  	        C_BLOCK_WRITE_STATE <= S6 AFTER 1 PS; 
          end if;			
		ELSE 	
          get_row_data <= '0' AFTER 1 PS;		
  	      C_BLOCK_WRITE_STATE <= S5B AFTER 1 PS;   
  	    END IF;
      WHEN S5B  =>
        get_row_data <= '1' AFTER 1 PS;	-- move FIFO after getting shifted data
  	    dvalid_f <= '1' AFTER 1 PS;		
  	    row_write_pos_rst	<= '0' AFTER 1 PS;
		IF (row_write_pos_cnt >= x"012" AND quarter_buss_connected = '1') THEN -- 40 clocks total, use 20-2
  	      C_BLOCK_WRITE_STATE <= S6 AFTER 1 PS;   
		ELSE 
  	      C_BLOCK_WRITE_STATE <= S5 AFTER 1 PS;   
  	    END IF;		
		
      WHEN S6  =>
  	    row_write_pos_rst	<= '1' AFTER 1 PS;
  	    dvalid_f <= '0' AFTER 1 PS;			
  	    get_row_data <= '0' AFTER 1 PS;
  	    C_BLOCK_WRITE_STATE <= S7 AFTER 1 PS;
      WHEN S7 =>
  	    dvalid_f <= '0' AFTER 1 PS;
  	    C_BLOCK_WRITE_STATE <= S8;
      WHEN s8 =>
  	    C_BLOCK_WRITE_STATE <= S9;
      WHEN s9 =>
        C_BLOCK_WRITE_STATE <= s1;      			
      WHEN OTHERS => 
  	    C_BLOCK_WRITE_STATE <= S1 AFTER 1 PS;		    
    END CASE;
  END IF;
END PROCESS;
			  
dmd_get_row_data <= get_row_data;

--Starts the row write state machine
PROCESS (system_clk, system_reset)
BEGIN
	IF system_reset = '1' THEN
	  rows_to_load <= (OTHERS => '0');
	  gpio_external_reset_1q <= '0';
	ELSIF system_clk'EVENT AND system_clk = '1' THEN
	  --For the external reset if enabled
	  gpio_external_reset_1q <= gpio_external_reset;
	  IF(external_reset_enable = '1' AND gpio_external_reset = '1' AND gpio_external_reset_1q = '0') THEN
	    rows_to_load <= x"0001";
	  ELSE
	    IF start_block_write = '1' THEN
	      rows_to_load <= DMD_RowLoads;
	    ELSIF decrement_row_load_counter = '1' THEN
	      rows_to_load <= rows_to_load - x"0001";
	    ELSE
	      rows_to_load <= rows_to_load;
	    END IF;
	  END IF;
	END IF;
END PROCESS;



PROCESS (system_reset, system_clk)
BEGIN
  IF (system_reset = '1') THEN
    dmd_1080p_connected_1q <= '0' ;
    dmd_1080p_connected_2q <= '0';
  ELSIF rising_edge(system_clk) THEN
    dmd_1080p_connected_1q <= dmd_1080p_connected AFTER 1 PS;
    dmd_1080p_connected_2q <= dmd_1080p_connected_1q AFTER 1 PS;     
  END IF;
END PROCESS;		


----Zero Pads the 1080p data
PROCESS(system_clk, system_reset)
BEGIN
	IF system_reset = '1' THEN
		dmd_ab <= x"00000000000000000000000000000000";
		dmd_cd <= x"00000000000000000000000000000000";
		fifo_ab_data_out_1q <= (OTHERS => '0');
		fifo_cd_data_out_1q <= (OTHERS => '0');
		dvalid_f_1q <= '0';
		every_other_row <= '0';
	ELSIF system_clk'EVENT AND system_clk = '1' THEN
		
		--clear every other fifo row flag when a dmd_row_fifo_reset event happens
		if dmd_row_fifo_reset = '1' then
			every_other_row <= '0';
		end if;

		if dmd_1080p_connected_2q = '1' then
		   if get_row_data = '1' then	
				fifo_ab_data_out_1q <= fifo_ab_data_out;
				fifo_cd_data_out_1q <= fifo_cd_data_out;
           end if;
			--1080p connected, got to zero pad
           if every_other_row = '0' then
			 if row_write_pos_cnt = x"000" then
               dmd_ab <= x"0000000000000000" & fifo_ab_data_out(127 downto 64);
               dmd_cd <= fifo_cd_data_out;
             elsif row_write_pos_cnt = x"007" then
               dmd_ab <= fifo_ab_data_out_1q(63 downto 0) & fifo_ab_data_out(127 downto 64);
               dmd_cd <= fifo_cd_data_out(127 downto 64) & x"0000000000000000";
               every_other_row <= '1' after 1 ps;
             else
               dmd_ab <= fifo_ab_data_out_1q(63 downto 0) & fifo_ab_data_out(127 downto 64);
               dmd_cd <= fifo_cd_data_out;
             end if;
           else
             if row_write_pos_cnt = x"000" then
               dmd_ab <= x"0000000000000000" & fifo_ab_data_out_1q(63 downto 0);
               dmd_cd <= fifo_cd_data_out_1q(63 downto 0) & fifo_cd_data_out(127 downto 64);
             elsif row_write_pos_cnt = x"007" then
               dmd_ab <= fifo_ab_data_out_1q;
               dmd_cd <= fifo_cd_data_out_1q(63 downto 0) & x"0000000000000000";
               every_other_row <= '0';
             else
               dmd_ab <= fifo_ab_data_out_1q;
              dmd_cd <= fifo_cd_data_out_1q(63 downto 0) & fifo_cd_data_out(127 downto 64);
             end if;
           end if;
        elsif ( quarter_buss_connected = '1') THEN		
		  if (get_row_data <= '0') THEN 
            for i in 0 to 63 loop
              dmd_ab(i*2+1 downto i*2) <=  fifo_ab_data_out( i*2) & '0'; --& x"0";
            end loop;
          else
            for i in 0 to 63 loop
              dmd_ab(i*2+1 downto i*2) <=  fifo_ab_data_out( i*2+1) & '0'; --& x"0";
            end loop;
          end if;			
		else 
          --XGA DMD connected
          dmd_ab <= fifo_ab_data_out;
        end if;
        dvalid_f_1q <= dvalid_f;
	END IF;
END PROCESS;

--Defines for the DDR outputs to the DDC
--Align data to properly be directed to channel A, B, C or D	

dmd_ab_swap <= dmd_ab(127 DOWNTO 112) & dmd_ab(95 DOWNTO 80) & dmd_ab(63 DOWNTO 48) & dmd_ab(31 DOWNTO 16) &
                         dmd_ab(111 DOWNTO 96) & dmd_ab(79 DOWNTO 64) & dmd_ab(47 DOWNTO 32) & dmd_ab(15 DOWNTO 0);

dmd_cd_swap <= dmd_cd(127 DOWNTO 112) & dmd_cd(95 DOWNTO 80) & dmd_cd(63 DOWNTO 48) & dmd_cd(31 DOWNTO 16) &
                         dmd_cd(111 DOWNTO 96) & dmd_cd(79 DOWNTO 64) & dmd_cd(47 DOWNTO 32) & dmd_cd(15 DOWNTO 0);	

dmd_dvalid <= dvalid_f_1q;
dmd_dout_a <= dmd_ab_swap(127 DOWNTO 64);		
dmd_dout_b <= dmd_ab_swap(63  DOWNTO  0);		
dmd_dout_c <= dmd_cd_swap(127 DOWNTO 64);		
dmd_dout_d <= dmd_cd_swap(63  DOWNTO  0);		

END Behavioral;

