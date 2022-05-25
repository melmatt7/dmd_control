--------------------------------------------------------------------------------
-- Create Date:    6/16/05
-- Design Name:    Discovery (DDC4100)
-- Module Name:    pgen_pgd_a.vhd - Behavioral
-- Project Name:   DDC4100 (Applications FPGA)
-- Description: This is the architecture for the module pgen_pgd, which will
--              create signals unique to operation in the dual block phased
--              reset mode including row valid, row mode, block mode, block
--              address, and data valid.
-- Dependencies:
-- Revision: Clearcase Controlled
-- Additional Comments:
-- Copyright (C) 2005-2016 Texas Instruments Incorporated 
-- ALL RIGHTS RESERVED 
--
--------------------------------------------------------------------------------


ARCHITECTURE Behavioral OF pgen_pgd IS

SIGNAL      data_valid           : STD_LOGIC;
SIGNAL      data_valid_q         : STD_LOGIC;
SIGNAL      blkmode              : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      blkaddr              : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL      rowmd                : STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL      row_valid            : STD_LOGIC;
SIGNAL      max_row_count        : STD_LOGIC_VECTOR( 10 DOWNTO 0 );
SIGNAL      row_load             : STD_LOGIC_VECTOR( 6 DOWNTO 0 );
SIGNAL      cnts_active_cnten_q1 : STD_LOGIC;
SIGNAL      cnts_active_cnten_q2 : STD_LOGIC;
SIGNAL      pgen_row_q           : STD_LOGIC_VECTOR (10 DOWNTO 0);
SIGNAL      pgen_row_q1          : STD_LOGIC_VECTOR (10 DOWNTO 0);
SIGNAL      xga                  : STD_LOGIC;
SIGNAL      block_rst0           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst1           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst2           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst3           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst4           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst5           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst6           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst7           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst8           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst9           : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst10          : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst11          : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst12          : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst13          : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst14          : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL      block_rst15          : STD_LOGIC_VECTOR(10 DOWNTO 0);

BEGIN

-- Function defined in appsfpga_dmd_types_pkg
max_row_count <= row_count + 100; -- Added counts to ensure enough settling time

-- The number of rows in each reset group is determined by the DMD type:
--  .95" 1080p Type A       : 72 rows (36 * 2 DADs)
--  .7" XGA Type A          : 48 rows
--  .55" XGA Type A         : 48 rows
--  .55" XGA Type X         : 48 rows
--  .95" WUXGA Type A       : 80 rows (40 * 2 DADs)
--  .65 WXGA NIR            : 50 rows
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      row_load <= (OTHERS => '0');
      xga <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF WL_count = "100100" THEN -- if DMD type is 1080p (36)
         row_load <= "1001000" AFTER 1 PS;  -- 72
         xga <= '0' AFTER 1 PS;
      ELSIF WL_count = "110000" THEN -- if DMD type is XGA (48)
         row_load <= "0110000" AFTER 1 PS;   -- 48
         xga <= '1' AFTER 1 PS;
      ELSIF WL_count = "101000" THEN -- if DMD type is WUXGA (40)
         row_load <= "1010000" AFTER 1 PS; -- 80
         xga <= '0' AFTER 1 PS;
      ELSIF WL_count = "110010" THEN -- if DMD type is WXGA (50)  -- New
         row_load <= "0110010" AFTER 1 PS; -- 50
         xga <= '1' AFTER 1 PS;         
      ELSE
         row_load <= (OTHERS => '0') AFTER 1 PS;
         xga <= '0' AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

--determine validity of data passed on the top level output
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
      cnts_active_cnten_q1 <= '0';
      cnts_active_cnten_q2 <= '0';

      data_valid <= '0';
      data_valid_q <= '0';
      pgen_pgd_data_valid_q <= '0';
   ELSIF clk_g = '1' AND clk_g'event THEN
      cnts_active_cnten_q1 <= cnts_active_cnten_q AFTER 1 PS;
      cnts_active_cnten_q2 <= cnts_active_cnten_q1 AFTER 1 PS;

      IF pgen_row = "00000000000" AND cnts_active_cnten_q1 = '1' THEN
        data_valid <= '1' AFTER 1 PS;
      ELSIF cnts_active_cnten_q1 = '1' THEN
        data_valid <= '1' AFTER 1 PS;
      ELSE
        data_valid <= '0' AFTER 1 PS;
      END IF;
      data_valid_q <= data_valid AFTER 1 PS;
      pgen_pgd_data_valid_q <= data_valid_q AFTER 1 PS;
   END IF;
END PROCESS;

--determine if the current row is in the range of the dmd
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     row_valid <= '0' ;
   ELSIF clk_g = '1' AND clk_g'event THEN
     IF pgen_row = "00000000000" THEN
        row_valid <= '1' AFTER 1 PS;
     ELSIF pgen_row = max_row_count THEN
        row_valid <= '0' AFTER 1 PS;
     ELSE
        row_valid <= row_valid AFTER 1 PS;
     END IF;
  END IF;
END PROCESS;

pgen_pgd_row_valid <= row_valid;

PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     pgen_pgd_blkmd_q <= "00" ;
     pgen_pgd_blkad_q <= "0000" ;
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF data_valid_q = '1' THEN
         pgen_pgd_blkmd_q <= blkmode AFTER 1 PS;
         pgen_pgd_blkad_q <= blkaddr AFTER 1 PS;
      ELSE
         pgen_pgd_blkmd_q <= "00" AFTER 1 PS;
         pgen_pgd_blkad_q <= "0000" AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

-- -- Calculates the row numbers for the block resets -- Old process: inefficient for timing and synthesis
-- PROCESS (clk_g)
-- BEGIN
--    IF clk_g = '1' AND clk_g'event THEN
--       block_rst0  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(1 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 1 * row_load
--       block_rst1  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(2 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 2 * row_load
--       block_rst2  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(3 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 3 * row_load
--       block_rst3  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(4 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 4 * row_load
--       block_rst4  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(5 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 5 * row_load
--       block_rst5  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(6 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 6 * row_load
--       block_rst6  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(7 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 7 * row_load
--       block_rst7  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(8 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 8 * row_load
--       block_rst8  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(9 ,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 9 * row_load
--       block_rst9  <= UNSIGNED(CONV_STD_LOGIC_VECTOR(10,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 10 * row_load
--       block_rst10 <= UNSIGNED(CONV_STD_LOGIC_VECTOR(11,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 11 * row_load
--       block_rst11 <= UNSIGNED(CONV_STD_LOGIC_VECTOR(12,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 12 * row_load
--       block_rst12 <= UNSIGNED(CONV_STD_LOGIC_VECTOR(13,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 13 * row_load
--       block_rst13 <= UNSIGNED(CONV_STD_LOGIC_VECTOR(14,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 14 * row_load
--       block_rst14 <= UNSIGNED(CONV_STD_LOGIC_VECTOR(15,4)) * (UNSIGNED(row_load)) AFTER 1 PS;  -- 15 * row_load
--       block_rst15 <= UNSIGNED(CONV_STD_LOGIC_VECTOR(15,4)) * (UNSIGNED(row_load)) + (UNSIGNED(row_load)) AFTER 1 PS;  -- 16 * row_load
-- 
--    END IF;
-- END PROCESS;

-- Sets the row numbers for the block resets
PROCESS (clk_g)
BEGIN
   IF clk_g = '1' AND clk_g'event THEN
--      IF (row_load = "1001000") THEN --72 --- Original with 0 array settling time
--         block_rst0  <= "00001001000" AFTER 1 PS;  -- 1 * row_load = 72
--         block_rst1  <= "00010010000" AFTER 1 PS;  -- 2 * row_load = 144
--         block_rst2  <= "00011011000" AFTER 1 PS;  -- 3 * row_load = 216
--         block_rst3  <= "00100100000" AFTER 1 PS;  -- 4 * row_load = 288
--         block_rst4  <= "00101101000" AFTER 1 PS;  -- 5 * row_load = 360
--         block_rst5  <= "00110110000" AFTER 1 PS;  -- 6 * row_load = 432
--         block_rst6  <= "00111111000" AFTER 1 PS;  -- 7 * row_load = 504
--         block_rst7  <= "01001000000" AFTER 1 PS;  -- 8 * row_load = 576
--         block_rst8  <= "01010001000" AFTER 1 PS;  -- 9 * row_load = 648
--         block_rst9  <= "01011010000" AFTER 1 PS;  -- 10 * row_load = 720
--         block_rst10 <= "01100011000" AFTER 1 PS;  -- 11 * row_load = 792
--         block_rst11 <= "01101100000" AFTER 1 PS;  -- 12 * row_load = 864
--         block_rst12 <= "01110101000" AFTER 1 PS;  -- 13 * row_load = 936
--         block_rst13 <= "01111110000" AFTER 1 PS;  -- 14 * row_load = 1008
--         block_rst14 <= "10000111000" AFTER 1 PS;  -- 15 * row_load = 1080
--         block_rst15 <= "10010000000" AFTER 1 PS;  -- 16 * row_load = 1152  --really only 15 reset groups
      IF (row_load = "1001000") THEN --72
         block_rst0  <= "00001100110" AFTER 1 PS;  -- 1 * row_load = 72+30 = 102         
         block_rst1  <= "00010101110" AFTER 1 PS;  -- 2 * row_load = 144+30 = 174         
         block_rst2  <= "00011110110" AFTER 1 PS;  -- 3 * row_load = 216+30 = 246         
         block_rst3  <= "00100111110" AFTER 1 PS;  -- 4 * row_load = 288+30 = 318         
         block_rst4  <= "00110000110" AFTER 1 PS;  -- 5 * row_load = 360+30 = 390         
         block_rst5  <= "00111001110" AFTER 1 PS;  -- 6 * row_load = 432+30 = 462         
         block_rst6  <= "01000010110" AFTER 1 PS;  -- 7 * row_load = 504+30 = 534          
         block_rst7  <= "01001011110" AFTER 1 PS;  -- 8 * row_load = 576+30 = 606         
         block_rst8  <= "01010100110" AFTER 1 PS;  -- 9 * row_load = 648+30 = 678         
         block_rst9  <= "01011101110" AFTER 1 PS;  -- 10 * row_load = 720+30 = 750         
         block_rst10 <= "01100110110" AFTER 1 PS;  -- 11 * row_load = 792+30 = 822         
         block_rst11 <= "01101111110" AFTER 1 PS;  -- 12 * row_load = 864+30 = 894         
         block_rst12 <= "01111000110" AFTER 1 PS;  -- 13 * row_load = 936+30 = 966         
         block_rst13 <= "10000001110" AFTER 1 PS;  -- 14 * row_load = 1008+30 = 1038
         block_rst14 <= "10001010110" AFTER 1 PS;  -- 15 * row_load = 1080+30 = 1110
         block_rst15 <= "00000011110" AFTER 1 PS;  -- 16 * row_load = 1152+30 = 1182  --unused, really only 15 reset groups
--      ELSIF (row_load = "00000110000") THEN --48 --- Original with 0 array settling time
--         block_rst0  <= "00000110000" AFTER 1 PS;  -- 1 * row_load = 48
--         block_rst1  <= "00001100000" AFTER 1 PS;  -- 2 * row_load = 96
--         block_rst2  <= "00010010000" AFTER 1 PS;  -- 3 * row_load = 144
--         block_rst3  <= "00011000000" AFTER 1 PS;  -- 4 * row_load = 192
--         block_rst4  <= "00011110000" AFTER 1 PS;  -- 5 * row_load = 240
--         block_rst5  <= "00100100000" AFTER 1 PS;  -- 6 * row_load = 288
--         block_rst6  <= "00101010000" AFTER 1 PS;  -- 7 * row_load = 336
--         block_rst7  <= "00110000000" AFTER 1 PS;  -- 8 * row_load = 384
--         block_rst8  <= "00110110000" AFTER 1 PS;  -- 9 * row_load = 432
--         block_rst9  <= "00111100000" AFTER 1 PS;  -- 10 * row_load = 480
--         block_rst10 <= "01000010000" AFTER 1 PS;  -- 11 * row_load = 528
--         block_rst11 <= "01001000000" AFTER 1 PS;  -- 12 * row_load = 576
--         block_rst12 <= "01001110000" AFTER 1 PS;  -- 13 * row_load = 624
--         block_rst13 <= "01010100000" AFTER 1 PS;  -- 14 * row_load = 672
--         block_rst14 <= "01011010000" AFTER 1 PS;  -- 15 * row_load = 720
--         block_rst15 <= "01100000000" AFTER 1 PS;  -- 16 * row_load = 768
      ELSIF (row_load = "00000110000") THEN --48
         block_rst0  <= "00001001110" AFTER 1 PS;  -- 1 * row_load = 48+30 = 78         
         block_rst1  <= "00001111110" AFTER 1 PS;  -- 2 * row_load = 96+30 = 126         
         block_rst2  <= "00010101110" AFTER 1 PS;  -- 3 * row_load = 144+30 = 174         
         block_rst3  <= "00011011110" AFTER 1 PS;  -- 4 * row_load = 192+30 = 222         
         block_rst4  <= "00100001110" AFTER 1 PS;  -- 5 * row_load = 240+30 = 270         
         block_rst5  <= "00100111110" AFTER 1 PS;  -- 6 * row_load = 288+30 = 318         
         block_rst6  <= "00101101110" AFTER 1 PS;  -- 7 * row_load = 336+30 = 366         
         block_rst7  <= "00110011110" AFTER 1 PS;  -- 8 * row_load = 384+30 = 414         
         block_rst8  <= "00111001110" AFTER 1 PS;  -- 9 * row_load = 432+30 = 462         
         block_rst9  <= "00111111110" AFTER 1 PS;  -- 10 * row_load = 480+30 = 510         
         block_rst10 <= "01000101110" AFTER 1 PS;  -- 11 * row_load = 528+30 = 558         
         block_rst11 <= "01001011110" AFTER 1 PS;  -- 12 * row_load = 576+30 = 606         
         block_rst12 <= "01010001110" AFTER 1 PS;  -- 13 * row_load = 624+30 = 654         
         block_rst13 <= "01010111110" AFTER 1 PS;  -- 14 * row_load = 672+30 = 702         
         block_rst14 <= "00000011110" AFTER 1 PS;  -- 15 * row_load = 720+30 = 750         
         block_rst15 <= "01100011110" AFTER 1 PS;  -- 16 * row_load = 768+30 = 798
--      ELSIF (row_load = "00001010000") THEN --80   --- Original with 0 array settling time
--         block_rst0  <= "00001010000" AFTER 1 PS;  -- 1 * row_load = 80
--         block_rst1  <= "00010100000" AFTER 1 PS;  -- 2 * row_load = 160
--         block_rst2  <= "00011110000" AFTER 1 PS;  -- 3 * row_load = 240
--         block_rst3  <= "00101000000" AFTER 1 PS;  -- 4 * row_load = 320
--         block_rst4  <= "00110010000" AFTER 1 PS;  -- 5 * row_load = 400
--         block_rst5  <= "00111100000" AFTER 1 PS;  -- 6 * row_load = 480
--         block_rst6  <= "01000110000" AFTER 1 PS;  -- 7 * row_load = 560
--         block_rst7  <= "01010000000" AFTER 1 PS;  -- 8 * row_load = 640
--         block_rst8  <= "01011010000" AFTER 1 PS;  -- 9 * row_load = 720
--         block_rst9  <= "01100100000" AFTER 1 PS;  -- 10 * row_load = 800
--         block_rst10 <= "01101110000" AFTER 1 PS;  -- 11 * row_load = 880
--         block_rst11 <= "01111000000" AFTER 1 PS;  -- 12 * row_load = 960
--         block_rst12 <= "10000010000" AFTER 1 PS;  -- 13 * row_load = 1040
--         block_rst13 <= "10001100000" AFTER 1 PS;  -- 14 * row_load = 1120
--         block_rst14 <= "10010110000" AFTER 1 PS;  -- 15 * row_load = 1200
--         block_rst15 <= "10100000000" AFTER 1 PS;  -- 16 * row_load = 1280
      ELSIF (row_load = "00001010000") THEN --80
         block_rst0  <= "00001101110" AFTER 1 PS;  -- 1 * row_load = 80+30 = 110         
         block_rst1  <= "00010111110" AFTER 1 PS;  -- 2 * row_load = 160+30 = 190         
         block_rst2  <= "00100001110" AFTER 1 PS;  -- 3 * row_load = 240+30 = 270         
         block_rst3  <= "00101011110" AFTER 1 PS;  -- 4 * row_load = 320+30 = 350         
         block_rst4  <= "00110101110" AFTER 1 PS;  -- 5 * row_load = 400+30 = 430         
         block_rst5  <= "00111111110" AFTER 1 PS;  -- 6 * row_load = 480+30 = 510         
         block_rst6  <= "01001001110" AFTER 1 PS;  -- 7 * row_load = 560+30 = 590         
         block_rst7  <= "01010011110" AFTER 1 PS;  -- 8 * row_load = 640+30 = 670         
         block_rst8  <= "01011101110" AFTER 1 PS;  -- 9 * row_load = 720+30 = 750         
         block_rst9  <= "01100111110" AFTER 1 PS;  -- 10 * row_load = 800+30 = 830         
         block_rst10 <= "01110001110" AFTER 1 PS;  -- 11 * row_load = 880+30 = 910         
         block_rst11 <= "01111011110" AFTER 1 PS;  -- 12 * row_load = 960+30 = 990         
         block_rst12 <= "10000101110" AFTER 1 PS;  -- 13 * row_load = 1040+30 = 1070         
         block_rst13 <= "10001111110" AFTER 1 PS;  -- 14 * row_load = 1120+30 = 1150         
         block_rst14 <= "10011001110" AFTER 1 PS;  -- 15 * row_load = 1200+30 = 1230
         block_rst15 <= "10100011110" AFTER 1 PS;  -- 16 * row_load = 1280+30 = 1310 (unused)
         --- New addition for NIR WXGA
--      ELSIF (row_load = "00000110010") THEN --50
--         block_rst0  <= "00000110010" AFTER 1 PS;  -- 1 * row_load = 50
--         block_rst1  <= "00001100100" AFTER 1 PS;  -- 2 * row_load = 100
--         block_rst2  <= "00010010110" AFTER 1 PS;  -- 3 * row_load = 150
--         block_rst3  <= "00011001000" AFTER 1 PS;  -- 4 * row_load = 200
--         block_rst4  <= "00011111010" AFTER 1 PS;  -- 5 * row_load = 250
--         block_rst5  <= "00100101100" AFTER 1 PS;  -- 6 * row_load = 300
--         block_rst6  <= "00101011110" AFTER 1 PS;  -- 7 * row_load = 350
--         block_rst7  <= "00110010000" AFTER 1 PS;  -- 8 * row_load = 400
--         block_rst8  <= "00111000010" AFTER 1 PS;  -- 9 * row_load = 450
--         block_rst9  <= "00111110100" AFTER 1 PS;  -- 10 * row_load = 500
--         block_rst10 <= "01000100110" AFTER 1 PS;  -- 11 * row_load = 550
--         block_rst11 <= "01001011000" AFTER 1 PS;  -- 12 * row_load = 600
--         block_rst12 <= "01010001010" AFTER 1 PS;  -- 13 * row_load = 650
--         block_rst13 <= "01010111100" AFTER 1 PS;  -- 14 * row_load = 700
--         block_rst14 <= "01011101110" AFTER 1 PS;  -- 15 * row_load = 750
--         block_rst15 <= "01100100000" AFTER 1 PS;  -- 16 * row_load = 800   
         --- TEST -- New addition for NIR WXGA
      ELSIF (row_load = "00000110010") THEN --50
         block_rst0  <= "00001000110" AFTER 1 PS;  -- 1 * row_load + 20 = 70
         block_rst1  <= "00001111000" AFTER 1 PS;  -- 2 * row_load + 20 = 120
         block_rst2  <= "00010101010" AFTER 1 PS;  -- 3 * row_load + 20 = 170
         block_rst3  <= "00011011100" AFTER 1 PS;  -- 4 * row_load + 20 = 220         
         block_rst4  <= "00100001110" AFTER 1 PS;  -- 5 * row_load + 20 = 270         
         block_rst5  <= "00101000000" AFTER 1 PS;  -- 6 * row_load + 20 = 320         
         block_rst6  <= "00101110010" AFTER 1 PS;  -- 7 * row_load + 20 = 370
         block_rst7  <= "00110100100" AFTER 1 PS;  -- 8 * row_load + 20 = 420         
         block_rst8  <= "00111010110" AFTER 1 PS;  -- 9 * row_load + 20 = 470         
         block_rst9  <= "01000001000" AFTER 1 PS;  -- 10 * row_load + 20 = 520         
         block_rst10 <= "01000111010" AFTER 1 PS;  -- 11 * row_load + 20 = 570         
         block_rst11 <= "01001101100" AFTER 1 PS;  -- 12 * row_load + 20 = 620         
         block_rst12 <= "01010011110" AFTER 1 PS;  -- 13 * row_load + 20 = 670         
         block_rst13 <= "01011010000" AFTER 1 PS;  -- 14 * row_load + 20 = 720         
         block_rst14 <= "01100000010" AFTER 1 PS;  -- 15 * row_load + 20 = 770
         block_rst15 <= "01100110100" AFTER 1 PS;  -- 16 * row_load + 20 = 820                         
      ELSE
         block_rst0  <= "00000000000" AFTER 1 PS;  -- default
         block_rst1  <= "00000000000" AFTER 1 PS;  -- 
         block_rst2  <= "00000000000" AFTER 1 PS;  -- 
         block_rst3  <= "00000000000" AFTER 1 PS;  -- 
         block_rst4  <= "00000000000" AFTER 1 PS;  -- 
         block_rst5  <= "00000000000" AFTER 1 PS;  -- 
         block_rst6  <= "00000000000" AFTER 1 PS;  -- 
         block_rst7  <= "00000000000" AFTER 1 PS;  -- 
         block_rst8  <= "00000000000" AFTER 1 PS;  -- 
         block_rst9  <= "00000000000" AFTER 1 PS;  -- 
         block_rst10 <= "00000000000" AFTER 1 PS;  -- 
         block_rst11 <= "00000000000" AFTER 1 PS;  -- 
         block_rst12 <= "00000000000" AFTER 1 PS;  -- 
         block_rst13 <= "00000000000" AFTER 1 PS;  -- 
         block_rst14 <= "00000000000" AFTER 1 PS;  -- 
         block_rst15 <= "00000000000" AFTER 1 PS;  --       
      END IF;   
   END IF;
END PROCESS;


--determine which set of blocks to reset
--if the north/south flip switch is on, the blocks need to be reset in reverse
--order to avoid resetting blocks that have not yet been fully loaded
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     pgen_row_q   <= (OTHERS => '0' ); 
     pgen_row_q1  <= (OTHERS => '0' ); 
     blkmode      <= "00"   ;
     blkaddr      <= "0000" ;
   ELSIF clk_g = '1' AND clk_g'event THEN
     pgen_row_q   <= pgen_row AFTER 1 PS; -- Added pipieline to adjust timing on blkmode and blk address during 0 clock only
     pgen_row_q1  <= pgen_row_q AFTER 1 PS; -- Added pipieline to adjust timing on blkmode and blk address during 0 clock only

      IF data_valid = '1' THEN

--         IF pgen_row_q = "00000000000" THEN
--            blkmode <= "11" AFTER 1 PS;
--            IF pgen_ns_flip = '0' THEN
--               blkaddr <= "0111" AFTER 1 PS;
--            ELSE
--               blkaddr <= "0000" AFTER 1 PS;
--            END IF;

--         ELSIF pgen_row_q = block_rst1 THEN -- 2* row_load
         IF pgen_row_q = block_rst1 THEN -- 2* row_load
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
               blkaddr <= "0000" AFTER 1 PS;
            ELSE
               blkaddr <= "0111" AFTER 1 PS;
            END IF;

         ELSIF pgen_row_q = block_rst3 THEN -- 4* row_load
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
               blkaddr <= "0001" AFTER 1 PS;
            ELSE
               blkaddr <= "0110" AFTER 1 PS;
            END IF;

         ELSIF pgen_row_q = block_rst5 THEN -- 6* row_load
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
               blkaddr <= "0010" AFTER 1 PS;
            ELSE
               blkaddr <= "0101" AFTER 1 PS;
            END IF;

         ELSIF pgen_row_q = block_rst7 THEN -- 8 * row_load
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
               blkaddr <= "0011" AFTER 1 PS;
            ELSE
               blkaddr <= "0100" AFTER 1 PS;
            END IF;

         ELSIF pgen_row_q = block_rst9 THEN -- 10 * row_load
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
               blkaddr <= "0100" AFTER 1 PS;
            ELSE
               blkaddr <= "0011" AFTER 1 PS;
            END IF;

         ELSIF pgen_row_q = block_rst11 THEN -- 12 * row_load
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
               blkaddr <= "0101" AFTER 1 PS;
            ELSE
               blkaddr <= "0010" AFTER 1 PS;
            END IF;

         ELSIF pgen_row_q = block_rst13 THEN -- 14 * row_load
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
              blkaddr <= "0110" AFTER 1 PS;
            ELSE
              blkaddr <= "0001" AFTER 1 PS;
            END IF;

         ELSIF ((pgen_row_q = block_rst14 AND xga = '0') OR      -- 14 * row_load if 15 reset blocks
                (pgen_row_q = block_rst15 AND xga = '1') ) THEN  -- 15 * row_load if 16 reset blocks
            blkmode <= "11" AFTER 1 PS;
            IF pgen_ns_flip = '0' THEN
              blkaddr <= "0111" AFTER 1 PS;
            ELSE
              blkaddr <= "0000" AFTER 1 PS;
            END IF;

         ELSE
            blkmode <= "00" AFTER 1 PS;
            blkaddr <= "0000" AFTER 1 PS;
         END IF;
      ELSE
         blkmode <= "00" AFTER 1 PS;
         blkaddr <= "0000" AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;

--tell dmd when to increment row pointer (01) or reset row pointer (11)
PROCESS (clk_g, locked_init_rstz_gq)
BEGIN
   IF locked_init_rstz_gq = '0' THEN
     rowmd          <= "01" ;
     pgen_pgd_rowmd <= "00" ;
   ELSIF clk_g = '1' AND clk_g'event THEN
      IF pgen_row_q = "0000000000" THEN
         rowmd <= "11" AFTER 1 PS;
      ELSE
         rowmd <= "01" AFTER 1 PS;
      END IF;

      IF data_valid_q = '1' THEN
         pgen_pgd_rowmd <= rowmd AFTER 1 PS;
      ELSE
         pgen_pgd_rowmd <= "00" AFTER 1 PS;
      END IF;
   END IF;
END PROCESS;


END Behavioral;
