-- ----------------------------------------------------------------------------
--
--                   Copyright: Texas Instruments, Inc. (c) 2003-2007
--
--                          TI Proprietary Information
--                                Internal Data
--
--
-- FILE               __filename__
--
-- CURRENT REVISION   main/.1  256M_pkg.vhd
--
-- DESCRIPTION        Package containing DMD type declarations and constant
--                    definitions for data loading characteristics.
-- ASSUMPTIONS
--
-- ISSUES
--
-- CLEARCASE ARCHIVAL SYSTEM FOR __designname__
--
-- --------------------------------------------------------------------------
--
-- REVISION HISTORY
--
--    DATE      WHO       DESCRIPTION
--
-- --------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE DDR2_PKG IS


-- memory controller parameters
constant BANK_WIDTH               : integer := 3; 
                              -- # of memory bank addr bits.
constant CKE_WIDTH                : integer := 2; 
                            -- # of memory clock enable outputs.
constant CLK_WIDTH                : integer := 2; 
                            -- # of clock outputs.
constant COL_WIDTH                : integer := 10; 
                            -- # of memory column bits.
constant CS_NUM                   : integer := 2; 
                            -- # of separate memory chip selects.
constant CS_WIDTH                 : integer := 2; 
                            -- # of total memory chip selects.
constant CS_BITS                  : integer := 1; 
                            -- set to log2(CS_NUM) (rounded up).
constant DM_WIDTH                 : integer := 8; 
                            -- # of data mask bits.
constant DQ_WIDTH                 : integer := 64; 
                            -- # of data width.
constant DQ_PER_DQS               : integer := 8; 
                            -- # of DQ data bits per strobe.
constant DQS_WIDTH                : integer := 8; 
                            -- # of DQS strobes.
constant DQ_BITS                  : integer := 6; 
                            -- set to log2(DQS_WIDTH*DQ_PER_DQS).
constant DQS_BITS                 : integer := 3; 
                            -- set to log2(DQS_WIDTH).
constant ODT_WIDTH                : integer := 2; 
                            -- # of memory on-die term enables.
constant ROW_WIDTH                : integer := 14; 
                            -- # of memory row and # of addr bits.
constant ADDITIVE_LAT             : integer := 0; 
                            -- additive write latency.
constant BURST_LEN                : integer := 4; 
                            -- burst length (in double words).
constant BURST_TYPE               : integer := 0; 
                            -- burst type (=0 seq; =1 interleaved).
constant CAS_LAT                  : integer := 3; 
                            -- CAS latency.
constant ECC_ENABLE               : integer := 0; 
                            -- enable ECC (=1 enable).
constant APPDATA_WIDTH            : integer := 128; 
                            -- # of usr read/write data bus bits.
constant MULTI_BANK_EN            : integer := 1; 
                            -- Keeps multiple banks open. (= 1 enable).
constant TWO_T_TIME_EN            : integer := 1; 
                            -- 2t timing for unbuffered dimms.
constant ODT_TYPE                 : integer := 1; 
                            -- ODT (=0(none),=1(75),=2(150),=3(50)).
constant REDUCE_DRV               : integer := 0; 
                            -- reduced strength mem I/O (=1 yes).
constant REG_ENABLE               : integer := 0; 
                            -- registered addr/ctrl (=1 yes).
constant TREFI_NS                 : integer := 7800; 
                            -- auto refresh interval (ns).
constant TRAS                     : integer := 40000; 
                            -- active->precharge delay.
constant TRCD                     : integer := 15000; 
                            -- active->read/write delay.
constant TRFC                     : integer := 127500; 
                            -- refresh->refresh, refresh->active delay.
constant TRP                      : integer := 15000; 
                            -- precharge->command delay.
constant TRTP                     : integer := 7500; 
                            -- read->precharge delay.
constant TWR                      : integer := 15000; 
                            -- used to determine write->precharge.
constant TWTR                     : integer := 7500; 
                            -- write->read delay.
constant HIGH_PERFORMANCE_MODE    : boolean := TRUE; 
                            -- # = TRUE, the IODELAY performance mode is set
                            -- to high.
                            -- # = FALSE, the IODELAY performance mode is set
                            -- to low.
constant SIM_ONLY                 : integer := 0; 
                            -- = 1 to skip SDRAM power up delay.
constant DEBUG_EN                 : integer := 0; 
                            -- Enable debug signals/controls.
                            -- When this parameter is changed from 0 to 1,
                            -- make sure to uncomment the coregen commands
                            -- in ise_flow.bat or create_ise.bat files in
                            -- par folder.
constant CLK_PERIOD               : integer := 6666; 
                            -- Core/Memory clock period (in ps).
constant DLL_FREQ_MODE            : string := "HIGH"; 
                            -- DCM Frequency range.
constant CLK_TYPE                 : string := "SINGLE_ENDED"; 
                            -- # = "DIFFERENTIAL " ->; Differential input clocks ,
                            -- # = "SINGLE_ENDED" -> Single ended input clocks.
constant NOCLK200                 : boolean := FALSE; 
                            -- clk200 enable and disable
constant RST_ACT_LOW              : integer := 1; 
                            -- =1 for active low reset, =0 for active high.
constant USE_DM_PORT              : integer := 1;
constant FPGA_SPEED_GRADE         : integer := 1;
constant IODELAY_GRP              : string := "IODELAY_MIG";
END PACKAGE;

