--------------------------------------------------------------------------------
-- Create Date:    6/16/05 
-- Design Name:    Discovery (DDC4100)
-- Module Name:    cnts_a_1and16clks.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture for module cnts, which contains all
--              counters needed to control timing of output signals.
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2005-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------


ARCHITECTURE Behavioral OF cnts IS

SIGNAL      active_cnt           : STD_LOGIC_VECTOR (4 DOWNTO 0);
SIGNAL      active_cnten         : STD_LOGIC;
SIGNAL      blank_cnt            : STD_LOGIC_VECTOR (4 DOWNTO 0);
SIGNAL      blank_cnten          : STD_LOGIC;
SIGNAL      pattern_cnt          : STD_LOGIC_VECTOR (26 DOWNTO 0);
SIGNAL      pattern_cnten        : STD_LOGIC;
SIGNAL      pattern_cnten1q      : STD_LOGIC;
SIGNAL      active_clks          : STD_LOGIC_VECTOR (4 DOWNTO 0);

CONSTANT    BLANK_CLKS           : STD_LOGIC_VECTOR (4 DOWNTO 0) := "01111";
CONSTANT    PATTERN_START        : STD_LOGIC_VECTOR (26 DOWNTO 0) := "111000000000000000000000000"; -- start with clears
signal      reset_del_q          : STD_LOGIC_VECTOR (3 DOWNTO 0) ;
signal      appsfpga_io_cnthalt_qq  : STD_LOGIC;

BEGIN

dvalid_space_info   <= "0011" ;                                  

-- Pick active clk value based on dmd type
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      active_clks <= "00111";
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF in_dmd_type = "1111" THEN          --.9 WQXGA (20 clks/rowcycle) 
         active_clks <= "01001" AFTER 1 ps;  -- (clks/2 - 1)
      ELSIF in_dmd_type = "1110" THEN       --.65 1080P (32 clks/rowcycle)
         active_clks <= "01111" AFTER 1 ps;  -- (clks/2 - 1)
      ELSIF in_dmd_type = "0111" THEN       --.65 WXGA NIR(40 clks/rowcycle)
         active_clks <= "10011" AFTER 1 ps;  -- (clks/2 - 1)
      ELSE 
         active_clks <= "00111" AFTER 1 ps;  -- Everything else (16 clks/row cycle)
      END IF;
   END IF;
END PROCESS;

-- synchronous version of reset release
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      reset_del_q <= "0000";
   ELSIF clk_g = '1' AND clk_g'event THEN
      reset_del_q(0) <= '1';
      reset_del_q(1) <= reset_del_q(0);
      reset_del_q(2) <= reset_del_q(1);
      reset_del_q(3) <= reset_del_q(2);
   END IF;
END PROCESS;


--active counter keeps track of selected number of valid output data cycles
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      active_cnt <= "00000";
   ELSIF clk_g = '1' AND clk_g'event THEN
    IF reset_del_q(3) = '0' THEN -- added for sync reset
      active_cnt <= "00000"; -- added for sync reset, should be same as async
    ELSE -- added for sync reset

     IF (active_cnt = active_clks) THEN
       active_cnt <= "00000";
     ELSIF active_cnten = '1' THEN
       active_cnt <= active_cnt + 1 AFTER 1 PS;
     END IF;

    END IF;  -- added for sync reset
   END IF;
END PROCESS;

-----------------------------------------------
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      cnts_active_cnt_q <= "00000";
   ELSIF clk_g = '1' AND clk_g'event THEN
    IF reset_del_q(3) = '0' THEN -- added for sync reset
      cnts_active_cnt_q <= "00000"; -- added for sync reset, should be same as async
    ELSE -- added for sync reset

      cnts_active_cnt_q <= active_cnt;

    END IF;  -- added for sync reset
   END IF;
END PROCESS;
------------------------------------------------

--blank counter keeps track of 16 cycles of "blank" time, meaning no output
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      blank_cnt <= (OTHERS => '0');
   ELSIF clk_g = '1' AND clk_g'event THEN
    IF reset_del_q(3) = '0' THEN -- added for sync reset
      blank_cnt <= (OTHERS => '0'); -- added for sync reset, should be same as async
    ELSE -- added for sync reset

     IF blank_cnten = '1' THEN
       blank_cnt <= blank_cnt + 1 AFTER 1 PS;
     ELSIF active_cnten='1' THEN
       blank_cnt <= (OTHERS => '0') AFTER 1 PS;
     END IF ;

    END IF ; -- added for sync reset
   END IF;
END PROCESS;


--activate the active counter when blank counter is finished
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      active_cnten <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
    IF reset_del_q(3) = '0' THEN -- added for sync reset
      active_cnten <= '0';
    ELSE -- added for sync reset

      IF active_cnt = active_clks THEN
         active_cnten <= '0' AFTER 1 PS; -- DWR changed from '0'
      ELSIF blank_cnt(4 downto 0) = BLANK_CLKS THEN -- changed
         active_cnten <= '1' AFTER 1 PS;
      END IF;

    END IF ; -- added for sync reset
   END IF;
END PROCESS;

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      cnts_active_cnten_q  <= '0';
      appsfpga_io_cnthalt_qq <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
    IF reset_del_q(3) = '0' THEN -- added for sync reset
      cnts_active_cnten_q  <= '0';
      appsfpga_io_cnthalt_qq <= '0';
    ELSE -- added for sync reset
      If (pattern_cnt(10 downto 0) = "11111111111") AND (active_cnt = active_clks) THEN -- only enable before next load of DMD at top
        appsfpga_io_cnthalt_qq <= appsfpga_io_cnthalt_q;
      END IF;

      cnts_active_cnten_q  <= active_cnten AND (NOT appsfpga_io_cnthalt_qq);

    END IF ; -- added for sync reset
   END IF;
END PROCESS;


--activate the blank counter when active counter is finished
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      blank_cnten  <= '1';
   ELSIF clk_g = '1' AND clk_g'event THEN
    IF reset_del_q(3) = '0' THEN -- added for sync reset
      blank_cnten  <= '1';
    ELSE -- added for sync reset

      IF active_cnt = active_clks THEN
             blank_cnten <= '1' AFTER 1 PS;
      ELSIF blank_cnt(4 downto 0) = BLANK_CLKS THEN -- changed
             blank_cnten <= '0' AFTER 1 PS;
      END IF;

    END IF ; -- added for sync reset
   END IF;
END PROCESS;


--increment row when active counter finishes
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN
      pattern_cnten <= '0';
      pattern_cnten1q <= '0';
      pattern_cnt <= PATTERN_START;
   ELSIF clk_g = '1' AND clk_g'event THEN
    IF reset_del_q(3) = '0' THEN -- added for sync reset
      pattern_cnten <= '0';
      pattern_cnten1q <= '0';
      pattern_cnt <= PATTERN_START;
    ELSE -- added for sync reset

      IF active_cnt = active_clks THEN
         pattern_cnten <= '1' AFTER 1 PS;     -- not used to pull pipeline stage in
      ELSE
         pattern_cnten <= '0' AFTER 1 PS;
      END IF;
      pattern_cnten1q <= pattern_cnten AFTER 1 PS;

      IF pattern_cnten = '1' THEN  -- use pattern_cnten1q to delay it one more clock
         pattern_cnt <= pattern_cnt + 1 AFTER 1 PS;
      END IF;

    END IF ; -- added for sync reset
   END IF;
END PROCESS;

cnts_pattern_cnt_q   <= pattern_cnt; -- output to appcore

END Behavioral;
