--'''''''''''''''''''''''''' THIS IS SAMPLE CODE ONLY! '''''''''''''''''''''''''''''''''
--''                                                                                  ''
--''  Module Name:                                                                    ''
--''                                                                                  ''
--''        DMD_row_write_possition_int                                               ''
--''                                                                                  ''
--''  Abstract:                                                                       ''
--''                                                                                  ''
--''        Simple 4096 counter 				       												  ''
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

entity counter_4096 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           count : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           counter_value : out  STD_LOGIC_VECTOR (11 downto 0));
end counter_4096;

architecture Behavioral of counter_4096 is

	SIGNAL	counter_value_int					: STD_LOGIC_VECTOR(11 downto 0);


begin

	PROCESS(clk, rst)
		VARIABLE temp		: STD_LOGIC_VECTOR(1 downto 0);
	BEGIN
		IF (rst = '1') THEN
			counter_value_int <= "000000000000";
		ELSIF (clk'EVENT AND clk = '1') THEN
			temp 	:= count & up_down;
			CASE temp IS
				WHEN "00" => counter_value_int <= "000000000000";
				WHEN "01" => counter_value_int <= counter_value_int;
				WHEN "10" => counter_value_int <= counter_value_int - "000000000001";
				WHEN "11" => counter_value_int <= counter_value_int + "000000000001";
				WHEN OTHERS => counter_value_int <= "000000000000";
			END CASE;
		END IF;
	END PROCESS;
	
	
	counter_value <= counter_value_int;

end Behavioral;

