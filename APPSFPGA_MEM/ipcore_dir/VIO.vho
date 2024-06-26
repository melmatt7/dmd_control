-------------------------------------------------------------------------------
-- Copyright (c) 2021 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: Xilinx CORE Generator
--  /   /         Filename   : VIO.vho
-- /___/   /\     Timestamp  : Sun Jun 06 21:37:37 UTC 2021
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: ISE Instantiation template
-- Component Identifier: xilinx.com:ip:chipscope_vio:1.05.a
-------------------------------------------------------------------------------
-- The following code must appear in the VHDL architecture header:

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
component VIO
  PORT (
    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    CLK : IN STD_LOGIC;
    SYNC_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));

end component;

-- COMP_TAG_END ------ End COMPONENT Declaration ------------
-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.
------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG

your_instance_name : VIO
  port map (
    CONTROL => CONTROL,
    CLK => CLK,
    SYNC_OUT => SYNC_OUT);

-- INST_TAG_END ------ End INSTANTIATION Template ------------
