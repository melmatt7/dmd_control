--------------------------------------------------------------------------------
-- Create Date:     
-- Design Name:    Discovery (DDC4100)
-- Module Name:    appsfpga_dmd_types_pkg.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: Package containing DMD type declarations and constant
--                    definitions for data loading characteristics.
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2003-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE APPSFPGA_DMD_TYPES_PKG IS

--types used to define the various DMD types
TYPE DMD_TYPE_ASSIGN IS (XGA, TEN80, WUXGA, WXGA, ZEROES);

FUNCTION GET_WL_COUNT  (dmd_type : DMD_TYPE_ASSIGN) RETURN STD_LOGIC_VECTOR;
FUNCTION GET_BSA_COUNT (dmd_type : DMD_TYPE_ASSIGN) RETURN STD_LOGIC_VECTOR;
FUNCTION GET_ROW_COUNT (dmd_type : DMD_TYPE_ASSIGN) RETURN STD_LOGIC_VECTOR;

END PACKAGE APPSFPGA_DMD_TYPES_PKG;

PACKAGE BODY APPSFPGA_DMD_TYPES_PKG IS
-- #WL in each BSA
CONSTANT XGA_WL_const   : STD_LOGIC_VECTOR(5 DOWNTO 0) := "110000"; --48
CONSTANT TEN80_WL_const : STD_LOGIC_VECTOR(5 DOWNTO 0) := "100100"; --36
CONSTANT WUXGA_WL_const : STD_LOGIC_VECTOR(5 DOWNTO 0) := "101000"; --40
CONSTANT WXGA_WL_const  : STD_LOGIC_VECTOR(5 DOWNTO 0) := "110010"; --50

-- #BSA
CONSTANT XGA_BSA_const   : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000"; --16
CONSTANT TEN80_BSA_const : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01111"; --15
CONSTANT WUXGA_BSA_const : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01111"; --15
CONSTANT WXGA_BSA_const  : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000"; --16

-- Max row
--CONSTANT XGA_ROW_const   : STD_LOGIC_VECTOR(10 DOWNTO 0) := "01100000000"; --768
--CONSTANT TEN80_ROW_const : STD_LOGIC_VECTOR(10 DOWNTO 0) := "10000111000"; --1080
--CONSTANT WUXGA_ROW_const : STD_LOGIC_VECTOR(10 DOWNTO 0) := "10010110000"; --1200

CONSTANT XGA_ROW_const   : STD_LOGIC_VECTOR(10 DOWNTO 0) := "01011111111"; --768-1
CONSTANT TEN80_ROW_const : STD_LOGIC_VECTOR(10 DOWNTO 0) := "10000110111"; --1080-1
CONSTANT WUXGA_ROW_const : STD_LOGIC_VECTOR(10 DOWNTO 0) := "10010101111"; --1200-1
CONSTANT WXGA_ROW_const  : STD_LOGIC_VECTOR(10 DOWNTO 0) := "01100011111"; --800-1


--function to retrieve specific DMD WL loading information
FUNCTION GET_WL_COUNT (dmd_type : DMD_TYPE_ASSIGN) RETURN STD_LOGIC_VECTOR IS
BEGIN
  IF (dmd_type = XGA) THEN
    RETURN XGA_WL_const;
  ELSIF (dmd_type = TEN80) THEN
    RETURN TEN80_WL_const;
  ELSIF (dmd_type = WUXGA) THEN
    RETURN WUXGA_WL_const;
  ELSIF (dmd_type = WXGA) THEN
    RETURN WXGA_WL_const;
  ELSE
    RETURN ("000000");
  END IF;
END GET_WL_COUNT;

--function to retrieve specific DMD BSA information
FUNCTION GET_BSA_COUNT (dmd_type : DMD_TYPE_ASSIGN) RETURN STD_LOGIC_VECTOR IS
BEGIN
  IF (dmd_type = XGA) THEN
    RETURN XGA_BSA_const;
  ELSIF (dmd_type = TEN80) THEN
    RETURN TEN80_BSA_const;
  ELSIF (dmd_type = WUXGA) THEN
    RETURN WUXGA_BSA_const;
  ELSIF (dmd_type = WXGA) THEN
    RETURN WXGA_BSA_const;
  ELSE
    RETURN ("00000");
  END IF;
END GET_BSA_COUNT;

--function to retrieve max row_load information
FUNCTION GET_ROW_COUNT (dmd_type : DMD_TYPE_ASSIGN) RETURN STD_LOGIC_VECTOR IS
BEGIN
  IF (dmd_type = XGA) THEN
    RETURN XGA_ROW_const;
  ELSIF (dmd_type = TEN80) THEN
    RETURN TEN80_ROW_const;
  ELSIF (dmd_type = WUXGA) THEN
    RETURN WUXGA_ROW_const;
  ELSIF (dmd_type = WXGA) THEN
    RETURN WXGA_ROW_const;
  ELSE
    RETURN ("00000000000");
  END IF;
END GET_ROW_COUNT;


END PACKAGE BODY APPSFPGA_DMD_TYPES_PKG;

