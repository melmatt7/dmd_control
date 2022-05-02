-------------------------------------------------------------------------------
-- Copyright (c) 2021 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : chipscopeB.vhd
-- /___/   /\     Timestamp  : Mon May 17 18:58:59 UTC 2021
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY chipscopeB IS
  port (
    CONTROL0: inout std_logic_vector(35 downto 0));
END chipscopeB;

ARCHITECTURE chipscopeB_a OF chipscopeB IS
BEGIN

END chipscopeB_a;
