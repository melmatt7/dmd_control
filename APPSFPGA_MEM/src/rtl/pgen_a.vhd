
--------------------------------------------------------------------------------
-- Create Date:    4/21/2009
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_a.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture for module pgen, which produces all the
--              data and control signals sent to the dmd controller. It creates
--              these signals using the counters in module cnts and by muxing
--              signals created by pgs, pgd, pgq, and pgg. This allows the user to
--              choose either single block phased reset, dual, quad block phased
--              reset, or global reset.
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2009-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

--component declarations library
LIBRARY ddc4100;
USE ddc4100.appsfpga_dmd_types_pkg.ALL;

ARCHITECTURE Behavioral OF pgen IS

--single block phased reset
COMPONENT pgen_pgs
PORT (clk_g                      : IN STD_LOGIC;
      locked_init_rstz_gq        : IN STD_LOGIC;
      cnts_active_cnten_q        : IN STD_LOGIC;
      pgen_row                   : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      pgen_ns_flip               : IN STD_LOGIC;

      WL_count                   : IN STD_LOGIC_VECTOR( 5 DOWNTO 0 );
      BSA_count                  : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
      row_count                  : IN STD_LOGIC_VECTOR ( 10 DOWNTO 0 );

      pgen_pgs_row_valid         : OUT STD_LOGIC;
      pgen_pgs_rowmd             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgs_blkad_q           : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_pgs_blkmd_q           : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgs_data_valid_q      : OUT STD_LOGIC
      );
END COMPONENT;

--dual block phased reset
COMPONENT pgen_pgd
PORT (clk_g                      : IN STD_LOGIC;
      locked_init_rstz_gq        : IN STD_LOGIC;
      cnts_active_cnten_q        : IN STD_LOGIC;
      pgen_row                   : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      pgen_ns_flip               : IN STD_LOGIC;

      WL_count                   : IN STD_LOGIC_VECTOR( 5 DOWNTO 0 );
      BSA_count                  : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
      row_count                  : IN STD_LOGIC_VECTOR ( 10 DOWNTO 0 );

      pgen_pgd_row_valid         : OUT STD_LOGIC;
      pgen_pgd_rowmd             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgd_blkad_q           : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_pgd_blkmd_q           : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgd_data_valid_q      : OUT STD_LOGIC
      );
END COMPONENT;

--global reset
COMPONENT pgen_pgg
PORT (clk_g                      : IN STD_LOGIC;
      locked_init_rstz_gq        : IN STD_LOGIC;
      cnts_active_cnten_q        : IN STD_LOGIC;
      pgen_row                   : IN STD_LOGIC_VECTOR (10 DOWNTO 0);

      WL_count                   : IN STD_LOGIC_VECTOR( 5 DOWNTO 0 );
      BSA_count                  : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
      row_count                  : IN STD_LOGIC_VECTOR ( 10 DOWNTO 0 );

      pgen_pgg_row_valid         : OUT STD_LOGIC;
      pgen_pgg_rowmd             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgg_blkad_q           : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_pgg_blkmd_q           : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgg_data_valid_q      : OUT STD_LOGIC
      );
END COMPONENT;

--quad block phased reset
COMPONENT pgen_pgq
PORT (clk_g                      : IN STD_LOGIC;
      locked_init_rstz_gq        : IN STD_LOGIC;
      cnts_active_cnten_q        : IN STD_LOGIC;
      pgen_row                   : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      pgen_ns_flip               : IN STD_LOGIC;

      WL_count                   : IN STD_LOGIC_VECTOR( 5 DOWNTO 0 );
      BSA_count                  : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
      row_count                  : IN STD_LOGIC_VECTOR ( 10 DOWNTO 0 );

      pgen_pgq_row_valid         : OUT STD_LOGIC;
      pgen_pgq_rowmd             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgq_blkad_q           : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_pgq_blkmd_q           : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgq_data_valid_q      : OUT STD_LOGIC
      );
END COMPONENT;

COMPONENT pgen_clear
PORT (clk_g                      : IN STD_LOGIC;
      locked_init_rstz_gq        : IN STD_LOGIC;
      cnts_active_cnten_q        : IN STD_LOGIC;
      pgen_row                   : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      clear_block                : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_ns_flip               : IN STD_LOGIC;

      WL_count                   : IN STD_LOGIC_VECTOR( 5 DOWNTO 0 );
      BSA_count                  : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
      row_count                  : IN STD_LOGIC_VECTOR ( 10 DOWNTO 0 );

      --pgen_pgc_row_valid         : OUT STD_LOGIC;
      pgen_pgc_rowmd             : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgc_blkad_q           : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      pgen_pgc_blkmd_q           : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      pgen_pgc_data_valid_q      : OUT STD_LOGIC
      );
END COMPONENT;

--single block clear
SIGNAL    pgen_pgc_data_valid_q       : STD_LOGIC;
SIGNAL    pgen_pgc_rowmd              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgc_blkad_q            : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL    pgen_pgc_blkmd_q            : STD_LOGIC_VECTOR (1 DOWNTO 0);
--SIGNAL    pgen_pgc_row_valid          : STD_LOGIC;
SIGNAL    clear_block                 : STD_LOGIC_VECTOR (3 DOWNTO 0);

--single block phased reset values
SIGNAL    pgen_pgs_data_valid_q       : STD_LOGIC;
SIGNAL    pgen_pgs_rowmd              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgs_blkad_q            : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL    pgen_pgs_blkmd_q            : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgs_row_valid          : STD_LOGIC;
--dual block phased reset values
SIGNAL    pgen_pgd_data_valid_q       : STD_LOGIC;
SIGNAL    pgen_pgd_rowmd              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgd_blkad_q            : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL    pgen_pgd_blkmd_q            : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgd_row_valid          : STD_LOGIC;
--global reset values
SIGNAL    pgen_pgg_data_valid_q       : STD_LOGIC;
SIGNAL    pgen_pgg_rowmd              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgg_blkad_q            : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL    pgen_pgg_blkmd_q            : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgg_row_valid          : STD_LOGIC;
--quad block phased reset values
SIGNAL    pgen_pgq_data_valid_q       : STD_LOGIC;
SIGNAL    pgen_pgq_rowmd              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgq_blkad_q            : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL    pgen_pgq_blkmd_q            : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_pgq_row_valid          : STD_LOGIC;
--delay registers
SIGNAL    pgen_data_valid             : STD_LOGIC;
SIGNAL    pgen_rowmd                  : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    pgen_blkad                  : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL    pgen_blkmd                  : STD_LOGIC_VECTOR (1 DOWNTO 0);
--reset indicated by inputs and reset being used
SIGNAL    current_reset_type          : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL    rowaddrmode                 : STD_LOGIC;

SIGNAL    pgen_row                    : STD_LOGIC_VECTOR (10 DOWNTO 0);
SIGNAL    pgen_rowad                  : STD_LOGIC_VECTOR (10 DOWNTO 0);
SIGNAL    douta                       : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutb                       : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutc                       : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutd                       : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    douta_temp1                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutb_temp1                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutc_temp1                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutd_temp1                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    douta_temp2                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutb_temp2                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutc_temp2                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    doutd_temp2                 : STD_LOGIC_VECTOR (63 downto 0);
SIGNAL    pattern                     : STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL    pattern1                    : STD_LOGIC_VECTOR( 2 DOWNTO 0 );
SIGNAL    pattern2                    : STD_LOGIC_VECTOR( 2 DOWNTO 0 );
SIGNAL    comp_data                   : STD_LOGIC;
SIGNAL    pgen_ns_flip                : STD_LOGIC;
SIGNAL    pgen_stepvcc                : STD_LOGIC;
SIGNAL    douta1q                     : STD_LOGIC_VECTOR(63 downto 0);
SIGNAL    doutb1q                     : STD_LOGIC_VECTOR(63 downto 0);
SIGNAL    doutc1q                     : STD_LOGIC_VECTOR(63 downto 0);
SIGNAL    doutd1q                     : STD_LOGIC_VECTOR(63 downto 0);

SIGNAL    cnts_active_cnt_q1          : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL    cnts_active_cnt_q2          : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL    cnts_active_cnt_q3          : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL    cnts_active_cnt_q4          : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL    pgen_row_q1                 : STD_LOGIC_VECTOR( 10 DOWNTO 0 );
SIGNAL    pgen_row_q2                 : STD_LOGIC_VECTOR( 10 DOWNTO 0 );
SIGNAL    cnts_pattern_cnt_q1         : STD_LOGIC_VECTOR( 26 DOWNTO 0 );
SIGNAL    cnts_pattern_cnt_q2         : STD_LOGIC_VECTOR( 26 DOWNTO 0 );
SIGNAL    cnts_pattern_cnt_q3         : STD_LOGIC_VECTOR( 26 DOWNTO 0 );
SIGNAL    cnts_pattern_cnt_q4         : STD_LOGIC_VECTOR( 26 DOWNTO 0 );
SIGNAL    hold_count                  : STD_LOGIC_VECTOR( 6 DOWNTO 0 );
SIGNAL    hold_count_flag_q           : STD_LOGIC;
SIGNAL    hold_count_flag_q1          : STD_LOGIC;
SIGNAL    hold_count_flag_q2          : STD_LOGIC;
SIGNAL    hold_count_flag_q3          : STD_LOGIC;

SIGNAL    assign_type                 : DMD_TYPE_ASSIGN; -- type defined in appsfpga_dmd_types_pkg.vhd
SIGNAL    WL_count                    : STD_LOGIC_VECTOR( 5 DOWNTO 0 );
SIGNAL    BSA_count                   : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL    row_count                   : STD_LOGIC_VECTOR(10 DOWNTO 0 );
SIGNAL    pattern_diag                : STD_LOGIC_VECTOR(127 DOWNTO 0 );


type DMD_LINE_ARRAY is array (0 to 31) of std_logic_vector(63 downto 0); -- Longest Line is 1280
SIGNAL dmd_line_a : DMD_LINE_ARRAY ;
SIGNAL dmd_line_b : DMD_LINE_ARRAY ;


BEGIN


PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     --low 11 bits of pattern counter correspond to current row
     pgen_row    <= (OTHERS => '0'); --          
     clear_block <= (OTHERS => '0'); --           
     hold_count <= (OTHERS => '0'); --             
     hold_count_flag_q   <= '0';
     hold_count_flag_q1  <= '0';
     hold_count_flag_q2  <= '0';
     hold_count_flag_q3  <= '0';

     cnts_pattern_cnt_q1 <= (OTHERS => '0');
     cnts_pattern_cnt_q2 <= (OTHERS => '0');
     cnts_pattern_cnt_q3 <= (OTHERS => '0'); 
     cnts_pattern_cnt_q4 <= (OTHERS => '0'); 
     pattern  <= (OTHERS => '0'); --                
     pattern1 <= (OTHERS => '0'); --                 
     pattern2 <= (OTHERS => '0'); --                  
   ELSIF clk_g = '1' AND clk_g'event THEN
     --low 11 bits of pattern counter correspond to current row
     pgen_row    <= cnts_pattern_cnt_q (10 DOWNTO 0);
     clear_block <= cnts_pattern_cnt_q (21 DOWNTO 18); --(21 DOWNTO 18);  14 to 11 for simulation
     hold_count <= cnts_pattern_cnt_q (17 DOWNTO 11); 
     IF hold_count = "0000001" THEN  -- only load data when hold_count is 1.
       hold_count_flag_q  <= '1';
     ELSE
       hold_count_flag_q  <= '0';
     END IF;
     hold_count_flag_q1  <= hold_count_flag_q ;
     hold_count_flag_q2  <= hold_count_flag_q1 ;
     hold_count_flag_q3  <= hold_count_flag_q2 ;

     --test pattern generation
     --this may be modified to create different output test patterns by changing the dout assignment process
     cnts_pattern_cnt_q1 <= cnts_pattern_cnt_q  AFTER 1 PS;
     cnts_pattern_cnt_q2 <= cnts_pattern_cnt_q1 AFTER 1 PS;
     cnts_pattern_cnt_q3 <= cnts_pattern_cnt_q2 AFTER 1 PS;
     cnts_pattern_cnt_q4 <= cnts_pattern_cnt_q3 AFTER 1 PS;
     IF usb_pattern_force = '0' THEN  -- use counter value
       pattern  <= cnts_pattern_cnt_q3(26 DOWNTO 24);
       pattern1 <= cnts_pattern_cnt_q1(26 DOWNTO 24);
       pattern2 <= cnts_pattern_cnt_q1(26 DOWNTO 24);
     ELSE -- force pattern number from USB 
       pattern  <= usb_pattern_nmbr;
       pattern1 <= usb_pattern_nmbr;
       pattern2 <= usb_pattern_nmbr;
     END IF;
   END IF;
END PROCESS;


    -- DMD type:
    -- 0000   .95" 1080p Type A
    -- 0001   .7" XGA Type A
    -- 0010   .55" XGA Type A
    -- 0011   .55" XGA Type X
    -- 0100   .65" 1080p Diamond (Not supported in phase 1)
    -- 0101   .95" WUXGA Type A
	-- 0111   .65 NIR WXGA

-- Assign DMD types
assign_type <= TEN80 WHEN   in_dmd_type = "0000" ELSE
               XGA   WHEN   in_dmd_type = "0001" ELSE
               XGA   WHEN   in_dmd_type = "0010" ELSE
               XGA   WHEN   in_dmd_type = "0011" ELSE
               WUXGA WHEN   in_dmd_type = "0101" ELSE
               WXGA  WHEN   in_dmd_type = "0111" ELSE
               ZEROES;

WL_count  <= GET_WL_COUNT(assign_type);
BSA_count <= GET_BSA_COUNT(assign_type);
row_count <= GET_ROW_COUNT(assign_type);


i_pgen_clear : pgen_clear
PORT MAP (clk_g            => clk_g,
     locked_init_rstz_gq   => locked_init_rstz_gq,
     cnts_active_cnten_q   => cnts_active_cnten_q,
     pgen_row              => pgen_row,
     clear_block           => clear_block, --
     pgen_ns_flip          => pgen_ns_flip,
     WL_count              => WL_count,
     BSA_count             => BSA_count,
     row_count             => row_count,
     pgen_pgc_rowmd        => pgen_pgc_rowmd,
     pgen_pgc_blkad_q      => pgen_pgc_blkad_q,
     pgen_pgc_blkmd_q      => pgen_pgc_blkmd_q,
     pgen_pgc_data_valid_q => pgen_pgc_data_valid_q
     );

i_pgen_pgs : pgen_pgs
PORT MAP (clk_g            => clk_g,
     locked_init_rstz_gq   => locked_init_rstz_gq,
     cnts_active_cnten_q   => cnts_active_cnten_q,
     pgen_row              => pgen_row,
     pgen_ns_flip          => pgen_ns_flip,
     WL_count              => WL_count,
     BSA_count             => BSA_count,
     row_count             => row_count,
     pgen_pgs_row_valid    => pgen_pgs_row_valid,
     pgen_pgs_rowmd        => pgen_pgs_rowmd,
     pgen_pgs_blkad_q      => pgen_pgs_blkad_q,
     pgen_pgs_blkmd_q      => pgen_pgs_blkmd_q,
     pgen_pgs_data_valid_q => pgen_pgs_data_valid_q
     );

i_pgen_pgd : pgen_pgd
PORT MAP (clk_g            => clk_g,
     locked_init_rstz_gq   => locked_init_rstz_gq,
     cnts_active_cnten_q   => cnts_active_cnten_q,
     pgen_row              => pgen_row,
     pgen_ns_flip          => pgen_ns_flip,
     WL_count              => WL_count,
     BSA_count             => BSA_count,
     row_count             => row_count,
     pgen_pgd_row_valid    => pgen_pgd_row_valid,
     pgen_pgd_rowmd        => pgen_pgd_rowmd,
     pgen_pgd_blkad_q      => pgen_pgd_blkad_q,
     pgen_pgd_blkmd_q      => pgen_pgd_blkmd_q,
     pgen_pgd_data_valid_q => pgen_pgd_data_valid_q
     );

i_pgen_pgg : pgen_pgg
PORT MAP (clk_g            => clk_g,
     locked_init_rstz_gq   => locked_init_rstz_gq,
     cnts_active_cnten_q   => cnts_active_cnten_q,
     pgen_row              => pgen_row,
     WL_count              => WL_count,
     BSA_count             => BSA_count,
     row_count             => row_count,
     pgen_pgg_row_valid    => pgen_pgg_row_valid,
     pgen_pgg_rowmd        => pgen_pgg_rowmd,
     pgen_pgg_blkad_q      => pgen_pgg_blkad_q,
     pgen_pgg_blkmd_q      => pgen_pgg_blkmd_q,
     pgen_pgg_data_valid_q => pgen_pgg_data_valid_q
     );

i_pgen_pgq : pgen_pgq
PORT MAP (clk_g            => clk_g,
     locked_init_rstz_gq   => locked_init_rstz_gq,
     cnts_active_cnten_q   => cnts_active_cnten_q,
     pgen_row              => pgen_row,
     WL_count              => WL_count,
     BSA_count             => BSA_count,
     row_count             => row_count,
     pgen_ns_flip          => pgen_ns_flip,
     pgen_pgq_row_valid    => pgen_pgq_row_valid,
     pgen_pgq_rowmd        => pgen_pgq_rowmd,
     pgen_pgq_blkad_q      => pgen_pgq_blkad_q,
     pgen_pgq_blkmd_q      => pgen_pgq_blkmd_q,
     pgen_pgq_data_valid_q => pgen_pgq_data_valid_q
     );

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      pgen_data_valid_q <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF hold_count_flag_q3 = '1' THEN
         pgen_data_valid_q <= pgen_data_valid AFTER 1 PS;
      ELSE
         pgen_data_valid_q <= '0';
      END IF;
   END IF;
END PROCESS;

--mux values from sub-blocks to create data valid signal
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     pgen_data_valid <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
     IF pattern = "111" THEN
       pgen_data_valid <= pgen_pgc_data_valid_q AFTER 1 PS;
     ELSIF current_reset_type = "00" THEN -- single block phased reset
       pgen_data_valid <= pgen_pgs_data_valid_q AFTER 1 PS;
     ELSIF current_reset_type = "01" THEN -- dual block phased reset
       pgen_data_valid <= pgen_pgd_data_valid_q AFTER 1 PS;
     ELSIF current_reset_type = "10" THEN -- global reset
       pgen_data_valid <= pgen_pgg_data_valid_q AFTER 1 PS;
     ELSE -- quad block phased reset
       pgen_data_valid <= pgen_pgq_data_valid_q AFTER 1 PS;
     END IF;
   END IF;
END PROCESS;

--mux values from sub-blocks to create block address signal
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     pgen_blkad <= "0000" AFTER 1 PS;
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF appsfpga_io_float_q = '1' THEN -- float
         pgen_blkad <= "1100" AFTER 1 PS;
      ELSIF pattern = "111" THEN
         pgen_blkad <= pgen_pgc_blkad_q AFTER 1 PS;
      ELSIF current_reset_type = "00" THEN -- single block phased reset
         pgen_blkad <= pgen_pgs_blkad_q AFTER 1 PS;
      ELSIF current_reset_type = "01" THEN -- dual block phased reset
         pgen_blkad <= pgen_pgd_blkad_q AFTER 1 PS;
      ELSIF current_reset_type = "10" THEN -- global reset
         pgen_blkad <= pgen_pgg_blkad_q AFTER 1 PS;
      ELSE -- quad block phased reset
         pgen_blkad <= pgen_pgq_blkad_q AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      pgen_blkmd_q <= "00";
      pgen_blkad_q <= "0000";
   ELSIF clk_g = '1' AND clk_g'event THEN
      pgen_blkmd_q <= pgen_blkmd AFTER 1 PS;
      pgen_blkad_q <= pgen_blkad AFTER 1 PS;
   END IF;
END PROCESS;

--mux values from sub-blocks to create block mode signal
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      pgen_blkmd <= "00" AFTER 1 PS;        ---???
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF appsfpga_io_WDT_enbl_q = '1' THEN      -- allow WDT to reset if enabled
         pgen_blkmd <= "00" AFTER 1 PS;
      ELSIF appsfpga_io_float_q = '1' THEN      -- float
         pgen_blkmd <= "11" AFTER 1 PS;
      ELSIF pattern = "111" THEN
         pgen_blkmd <= pgen_pgc_blkmd_q AFTER 1 PS;
      ELSIF current_reset_type = "00" THEN -- single block phased reset
         pgen_blkmd <= pgen_pgs_blkmd_q AFTER 1 PS;
      ELSIF current_reset_type = "01" THEN -- dual block phased reset
         pgen_blkmd <= pgen_pgd_blkmd_q AFTER 1 PS;
      ELSIF current_reset_type = "10" THEN -- global reset
         pgen_blkmd <= pgen_pgg_blkmd_q AFTER 1 PS;
      ELSE -- quad block phased reset
         pgen_blkmd <= pgen_pgq_blkmd_q AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

--mux values from sub-blocks to create row mode signal
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      pgen_rowmd <= "00" AFTER 1 PS;  -- ???
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF pattern = "111" THEN
         pgen_rowmd <= pgen_pgc_rowmd AFTER 1 PS;
      ELSIF rowaddrmode = '1' THEN
         pgen_rowmd <= "10" AFTER 1 PS;
      ELSIF current_reset_type = "00" THEN -- single block phased reset
         pgen_rowmd <= pgen_pgs_rowmd AFTER 1 PS;
      ELSIF current_reset_type = "01" THEN -- dual block phased reset
         pgen_rowmd <= pgen_pgd_rowmd AFTER 1 PS;
      ELSIF current_reset_type = "10" THEN -- global reset
         pgen_rowmd <= pgen_pgg_rowmd AFTER 1 PS;
      ELSE -- quad block phased reset
         pgen_rowmd <= pgen_pgq_rowmd AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN 
   IF locked_init_rstz_gq = '0' THEN
     pgen_rowad          <= (OTHERS => '0'); 
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF pattern = "111" or rowaddrmode = '0' THEN
          pgen_rowad <= "00000000000";
      ELSE
          pgen_rowad <= cnts_pattern_cnt_q4 (10 DOWNTO 0);
      END IF;
   END IF;
END PROCESS;

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     pgen_rowmd_q <= "00";
     pgen_rowad_q        <= (OTHERS => '0'); 
   ELSIF clk_g = '1' AND clk_g'event THEN
     pgen_rowmd_q <= pgen_rowmd AFTER 1 PS;
     pgen_rowad_q <= pgen_rowad AFTER 1 PS;
   END IF;
END PROCESS;

--allows the user to change the reset type, ns flag, and complement data only
--between frames. wait for global reset row valid to become 0, as it is the last
--to be cleared
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      current_reset_type <= "10" ;
      pgen_ns_flip       <= '0' ;
      comp_data          <= '0';
      rowaddrmode        <= '0' ;
      pgen_rst2blkz_q    <= '0' ;
   ELSIF clk_g = '1' AND clk_g'event THEN
      --IF pgen_data_valid = '0' THEN
      IF hold_count = "1111110" THEN  -- only update when not not load data during hold_count is 1.
         current_reset_type <= appsfpga_io_reset_type_q AFTER 1 PS;
         pgen_ns_flip       <= appsfpga_io_ns_flip_en_q AFTER 1 PS;
         comp_data          <= appsfpga_io_comp_data_en_q AFTER 1 PS;
         rowaddrmode        <= appsfpga_io_rowaddrmode_q AFTER 1 PS;
         IF appsfpga_io_reset_type_q = "11" THEN -- quad block phased reset
            pgen_rst2blkz_q <= '1' AFTER 1 PS;
         ELSE
            pgen_rst2blkz_q <= '0' AFTER 1 PS;
         END IF;
      END IF;
   END IF;
END PROCESS;

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      pgen_comp_data_q <= '0';  
      pgen_ns_flip_q   <= '0';   
   ELSIF clk_g = '1' AND clk_g'event THEN
      pgen_comp_data_q <= comp_data AFTER 1 PS;
      pgen_ns_flip_q   <= pgen_ns_flip AFTER 1 PS;
   END IF;
END PROCESS;


PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF (locked_init_rstz_gq = '0') THEN                      -- ???
      cnts_active_cnt_q1 <= (OTHERS => '0');
      cnts_active_cnt_q2 <= (OTHERS => '0');
      cnts_active_cnt_q3 <= (OTHERS => '0');
      cnts_active_cnt_q4 <= (OTHERS => '0');
      pgen_row_q1        <= (OTHERS => '0');
      pgen_row_q2        <= (OTHERS => '0');
      douta_temp1        <= (OTHERS => '0');
      doutb_temp1        <= (OTHERS => '0');
      doutc_temp1        <= (OTHERS => '0');
      doutd_temp1        <= (OTHERS => '0');
      douta_temp2        <= (OTHERS => '0');
      doutb_temp2        <= (OTHERS => '0');
      doutc_temp2        <= (OTHERS => '0');
      doutd_temp2        <= (OTHERS => '0');
      pattern_diag <= x"80000000000000000000000000000000" ; 
   ELSIF clk_g='1' AND clk_g'event THEN
      cnts_active_cnt_q1 <= cnts_active_cnt_q AFTER 1 PS;
      cnts_active_cnt_q2 <= cnts_active_cnt_q1 AFTER 1 PS;
      cnts_active_cnt_q3 <= cnts_active_cnt_q2 AFTER 1 PS;
      cnts_active_cnt_q4 <= cnts_active_cnt_q3 AFTER 1 PS;
      pgen_row_q1 <= pgen_row AFTER 1 PS;
      pgen_row_q2 <= pgen_row_q1 AFTER 1 PS;

      dmd_line_a(conv_integer(unsigned(cnts_active_cnt_q3))) <= douta_temp1 OR douta_temp2 AFTER 1 PS;
      dmd_line_b(conv_integer(unsigned(cnts_active_cnt_q3))) <= doutb_temp1 OR doutb_temp2 AFTER 1 PS;
	  
      CASE pattern1 IS -- pattern is split up to decrease loading
        WHEN "000" => -- single pixel box
          -- each dout* is 4 DDR output cycles of data. Each 16 bits is reversed on the DMD - i.e. x0001 is the left bit of 16
          -- 64 bits = 4 16 bit groups - x"AAAABBBBCCCCDDDD", a = c0 rising, b = c0 falling, 
          --                                                  c = c1 rising, d = c1 falling where c* is the DMD clock
          IF (pgen_row_q1 = "00000000000") OR (pgen_row_q1 = "00000010000") OR (pgen_row_q1 = row_count) THEN
            douta_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS; -- TOP AND BOTTOM BAR
            doutb_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
            doutc_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
            doutd_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
          ELSIF ( (unsigned(pgen_row_q1)) < (unsigned(row_count)) ) THEN
            IF cnts_active_cnt_q2 = "00000" THEN -- left most side
              IF (assign_type = TEN80) THEN  
                douta_temp1 <= x"0000000080010000" AFTER 1 PS; -- LEFT BAR and line 16 pixels over
                --                       ^ This line 15 pixels from left  
              ELSE						  
                douta_temp1 <= x"8001000000000000" AFTER 1 PS;
              END IF;							  
              doutb_temp1 <= x"0000000000000000" AFTER 1 PS;
              doutc_temp1 <= x"8001000000000000" AFTER 1 PS;
              doutd_temp1 <= x"0000000000000000" AFTER 1 PS;
            ELSIF (assign_type /= WXGA AND cnts_active_cnt_q2 = "00111") OR 
                  (assign_type = WXGA  AND cnts_active_cnt_q2 = "01001") THEN
              douta_temp1 <= x"0000000000000000" AFTER 1 PS; -- RIGHT BAR
              doutb_temp1 <= x"0000000000008000" AFTER 1 PS;
              doutc_temp1 <= x"0000000000000000" AFTER 1 PS;
              doutd_temp1 <= x"0000800000000000" AFTER 1 PS;
            ELSE
              douta_temp1 <= x"0000000000000000" AFTER 1 PS;
              doutb_temp1 <= x"0000000000000000" AFTER 1 PS;
              doutc_temp1 <= x"0000000000000000" AFTER 1 PS;
              doutd_temp1 <= x"0000000000000000" AFTER 1 PS;
            END IF;
          ELSE
            douta_temp1 <= x"0000000000000000" AFTER 1 PS;
            doutb_temp1 <= x"0000000000000000" AFTER 1 PS;
            doutc_temp1 <= x"0000000000000000" AFTER 1 PS;
            doutd_temp1 <= x"0000000000000000" AFTER 1 PS;
          END IF;
      

                  WHEN "001" => -- Thin vertical lines
                      IF pgen_row_q1(0) = '1' THEN
                              douta_temp1 <= x"A5A5A5A5A5A5A5A5" AFTER 1 PS;
                              doutb_temp1 <= x"5A5A5A5A5A5A5A5A" AFTER 1 PS;
                              doutc_temp1 <= x"A5A5A5A5A5A5A5A5" AFTER 1 PS;
                              doutd_temp1 <= x"5A5A5A5A5A5A5A5A" AFTER 1 PS;
                      ELSE
                              douta_temp1 <= x"6969696969696969" AFTER 1 PS;
                              doutb_temp1 <= x"9696969696969696" AFTER 1 PS;
                              doutc_temp1 <= x"6969696969696969" AFTER 1 PS;
                              doutd_temp1 <= x"9696969696969696" AFTER 1 PS;
                      END IF;


                  WHEN "010" =>
                      IF pgen_row_q1(4) = '0' THEN -- small checker boxes
                              douta_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                              doutb_temp1 <= x"0000000000000000" AFTER 1 PS;
                              doutc_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                              doutd_temp1 <= x"0000000000000000" AFTER 1 PS;
                      ELSE
                              douta_temp1 <= x"0000000000000000" AFTER 1 PS;
                              doutb_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                              doutc_temp1 <= x"0000000000000000" AFTER 1 PS;
                              doutd_temp1 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                      END IF;

                  WHEN OTHERS =>
                      douta_temp1 <= x"0000000000000000" AFTER 1 PS;
                      doutb_temp1 <= x"0000000000000000" AFTER 1 PS;
                      doutc_temp1 <= x"0000000000000000" AFTER 1 PS;
                      doutd_temp1 <= x"0000000000000000" AFTER 1 PS;
               END CASE;

                  -- pattern is split up to decrease loading
               CASE pattern2 IS
                  WHEN "011" =>
                      IF pgen_row_q1(0) = '1' THEN
                              douta_temp2 <= x"1111111111111111" AFTER 1 PS;
                              doutb_temp2 <= x"0000000000000000" AFTER 1 PS;
                              doutc_temp2 <= x"1111111111111111" AFTER 1 PS;
                              doutd_temp2 <= x"0000000000000000" AFTER 1 PS;
                      ELSE
                              douta_temp2 <= x"0000000000000000" AFTER 1 PS;
                              doutb_temp2 <= x"0000000000000000" AFTER 1 PS;
                              doutc_temp2 <= x"0000000000000000" AFTER 1 PS;
                              doutd_temp2 <= x"0000000000000000" AFTER 1 PS;
                      END IF;

                  WHEN "100" =>
                      IF pgen_row_q1(1) = '0' THEN
                              douta_temp2 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                              doutb_temp2 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                              doutc_temp2 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                              doutd_temp2 <= x"FFFFFFFFFFFFFFFF" AFTER 1 PS;
                      ELSE
                              douta_temp2 <= x"0000000000000000" AFTER 1 PS;
                              doutb_temp2 <= x"0000000000000000" AFTER 1 PS;
                              doutc_temp2 <= x"0000000000000000" AFTER 1 PS;
                              doutd_temp2 <= x"0000000000000000" AFTER 1 PS;
                      END IF;

                  WHEN "101" =>  -- diagonal line
                      IF pgen_row_q1 = "11111111111" THEN
                         pattern_diag <= x"00000000000000000000000000000001" ; 
                         --section_cnt <= "0000"; -- reset section count
                         --                          ^ This pixel is 1st pixel of line, 1st 2 are off array for 1080p
                         douta_temp2 <= x"0000000000010000" AFTER 1 PS; -- LEFT BAR and line 16 pixels over
                         --               ^   ^   |                                
                         --         shifted off    \ This line 15 pixels from left  
                         doutb_temp2 <= x"0000000000000000" AFTER 1 PS;
                         doutc_temp2 <= x"0001000000000000" AFTER 1 PS; -- first pixel of second half
                         doutd_temp2 <= x"0000000000000000" AFTER 1 PS;
                      ELSE
                         IF cnts_active_cnt_q2 = "00111" THEN
                            pattern_diag <= pattern_diag(126 DOWNTO 0) & pattern_diag(127) ; 
                         END IF;

                         IF cnts_active_cnt_q2(3 DOWNTO 0) = pgen_row_q1(10 DOWNTO 7) THEN  
                           douta_temp2(63 downto 48) <= pattern_diag( 15 downto   0) AFTER 1 PS;
                           douta_temp2(47 downto 32) <= pattern_diag( 47 downto  32) AFTER 1 PS;
                           douta_temp2(31 downto 16) <= pattern_diag( 79 downto  64) AFTER 1 PS; -- start here
                           douta_temp2(15 downto 0)  <= pattern_diag(111 downto  96) AFTER 1 PS;
                           
                           doutb_temp2(63 downto 48) <= pattern_diag( 31 downto  16) AFTER 1 PS;
                           doutb_temp2(47 downto 32) <= pattern_diag( 63 downto  48) AFTER 1 PS;
                           doutb_temp2(31 downto 16) <= pattern_diag( 95 downto  80) AFTER 1 PS;
                           doutb_temp2(15 downto 0)  <= pattern_diag(127 downto 112) AFTER 1 PS;

                           doutc_temp2(63 downto 48) <= pattern_diag( 15 downto   0) AFTER 1 PS; -- start here
                           doutc_temp2(47 downto 32) <= pattern_diag( 47 downto  32) AFTER 1 PS;
                           doutc_temp2(31 downto 16) <= pattern_diag( 79 downto  64) AFTER 1 PS;
                           doutc_temp2(15 downto 0)  <= pattern_diag(111 downto  96) AFTER 1 PS;
                           
                           doutd_temp2(63 downto 48) <= pattern_diag( 31 downto  16) AFTER 1 PS;
                           doutd_temp2(47 downto 32) <= pattern_diag( 63 downto  48) AFTER 1 PS;
                           doutd_temp2(31 downto 16) <= pattern_diag( 95 downto  80) AFTER 1 PS;
                           doutd_temp2(15 downto 0)  <= pattern_diag(127 downto 112) AFTER 1 PS;
                        ELSE
                          douta_temp2 <= x"0000000000000000" AFTER 1 PS;
                          doutb_temp2 <= x"0000000000000000" AFTER 1 PS;
                          doutc_temp2 <= x"0000000000000000" AFTER 1 PS;
                          doutd_temp2 <= x"0000000000000000" AFTER 1 PS;
                        END IF;
                      END IF;

                  WHEN "110" =>
                      IF pgen_row_q1 = "11111111111" THEN
                         douta_temp2 <= x"0001000100010001" AFTER 1 PS;
                         doutb_temp2 <= x"8000800080008000" AFTER 1 PS;
                         doutc_temp2 <= x"0001000100010001" AFTER 1 PS;
                         doutd_temp2 <= x"8000800080008000" AFTER 1 PS;
                      ELSE
                         IF cnts_active_cnt_q3 = "00111" THEN
                          douta_temp2 <= douta(62 downto 0) & douta(63) AFTER 1 PS;
                          doutb_temp2 <= doutb(0) & doutb(63 downto 1) AFTER 1 PS;
                          doutc_temp2 <= doutc(62 downto 0) & doutc(63) AFTER 1 PS;
                          doutd_temp2 <= doutd(0) & doutd(63 downto 1) AFTER 1 PS;
                         END IF;
                      END IF;

                  WHEN OTHERS =>
                      douta_temp2 <= x"0000000000000000" AFTER 1 PS;
                      doutb_temp2 <= x"0000000000000000" AFTER 1 PS;
                      doutc_temp2 <= x"0000000000000000" AFTER 1 PS;
                      doutd_temp2 <= x"0000000000000000" AFTER 1 PS;

          END CASE;

    END IF;

END PROCESS;


PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN          -- ???
      douta          <= x"0000000000000000";
      doutb          <= x"0000000000000000";
      doutc          <= x"0000000000000000";
      doutd          <= x"0000000000000000";
      douta1q        <= x"0000000000000000";
      doutb1q        <= x"0000000000000000";
      doutc1q        <= x"0000000000000000";
      doutd1q        <= x"0000000000000000";
      pgen_dout_a_q  <= x"0000000000000000";
      pgen_dout_b_q  <= x"0000000000000000";
      pgen_dout_c_q  <= x"0000000000000000";
      pgen_dout_d_q  <= x"0000000000000000";
   ELSIF clk_g='1' AND clk_g'event THEN
      douta <= douta_temp1 OR douta_temp2 AFTER 1 PS;
      doutb <= doutb_temp1 OR doutb_temp2 AFTER 1 PS;
      doutc <= doutc_temp1 OR doutc_temp2 AFTER 1 PS;
      doutd <= doutd_temp1 OR doutd_temp2 AFTER 1 PS;

    -- DMD type:
    -- 0000   .95" 1080p Type A
    -- 0001   .7" XGA Type A
    -- 0010   .55" XGA Type A
    -- 0011   .55" XGA Type X
    -- 0100   .65" 1080p Diamond (Not supported in phase 1)
    -- 0101   .95" WUXGA Type A
    -- 0111   .65 NIR WXGA
	
    IF (assign_type = TEN80 OR assign_type = WUXGA ) THEN
	   -- 4 data buses)
       douta1q <= douta;
       doutb1q <= doutb;
       doutc1q <= doutc;
       doutd1q <= doutd;	
    ELSIF (assign_type = WXGA) THEN  
        --dmd_line_a(conv_integer(unsigned(cnts_active_cnt_q3))) <= douta_temp1 OR douta_temp2 AFTER 1 PS;
        --dmd_line_b(conv_integer(unsigned(cnts_active_cnt_q3))) <= doutb_temp1 OR doutb_temp2 AFTER 1 PS;
	   IF ( (UNSIGNED(cnts_active_cnt_q4)) = 0) THEN 
	       for i in 0 to 31 loop
             douta1q(i*2+1 downto i*2) <=  douta( i*2) & '0';
             doutb1q(i*2+1 downto i*2) <=  doutb( i*2) & '0';
           end loop;
	    ELSIF (cnts_active_cnt_q4(0) = '0') THEN 
	   --IF (cnts_active_cnt_q3(0) = '0') THEN 
	      for i in 0 to 31 loop
            douta1q(i*2+1 downto i*2) <=  dmd_line_a(conv_integer(unsigned(cnts_active_cnt_q4(4 DOWNTO 1)))) (i*2) & '0';		
            doutb1q(i*2+1 downto i*2) <=  dmd_line_b(conv_integer(unsigned(cnts_active_cnt_q4(4 DOWNTO 1)))) (i*2) & '0';
          end loop;
       ELSE
          for i in 0 to 31 loop
            douta1q(i*2+1 downto i*2) <= dmd_line_a(conv_integer(unsigned(cnts_active_cnt_q4(4 DOWNTO 1)))) (i*2+1) & '0'; 	  
            doutb1q(i*2+1 downto i*2) <= dmd_line_b(conv_integer(unsigned(cnts_active_cnt_q4(4 DOWNTO 1)))) (i*2+1) & '0'; 
          end loop;
		END IF;	
	   doutc1q <= (OTHERS => '0');
       doutd1q <= (OTHERS => '0');
    ELSE      -- XGA 2 buses, tie c & d low.	 
       douta1q <= douta;
       doutb1q <= doutb;
       doutc1q <= (OTHERS => '0');
       doutd1q <= (OTHERS => '0');
    END IF;

  -- pipeline stages for aligning data
    pgen_dout_a_q  <= douta1q AFTER 1 PS;
    pgen_dout_b_q  <= doutb1q AFTER 1 PS;
    pgen_dout_c_q  <= doutc1q AFTER 1 PS;
    pgen_dout_d_q  <= doutd1q AFTER 1 PS;

  END IF; --
END PROCESS;

pgen_STEP_VCC_q <= '0' ;


END Behavioral;
