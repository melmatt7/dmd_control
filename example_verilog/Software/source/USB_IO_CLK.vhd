--'''''''''''''''''''''''''' THIS IS SAMPLE CODE ONLY! '''''''''''''''''''''''''''''''''
--''                                                                                  ''
--''  Module Name:                                                                    ''
--''                                                                                  ''
--''        USB_COMM                                                                  ''
--''                                                                                  ''
--''  Abstract:                                                                       ''
--''                                                                                  ''
--''        USB interface, contains Row Data FIFO                                     ''
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

ENTITY USB_IO_CLK is
    PORT 
	 (
	  --CLOCKS
	  ifclk 				  : IN    STD_LOGIC;
	  system_clk				  : IN    STD_LOGIC;
	
	  --RESETS
	  reset_i				  : IN    STD_LOGIC;
	  system_reset  			  : IN    STD_LOGIC;
	 
	  --PORTS
	  bidir 				  : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	  fifo_wen				  : IN    STD_LOGIC;
	  fifo_ren				  : IN    STD_LOGIC;
	  fifo_regn				  : IN    STD_LOGIC;
	
	  dmd_1080p_connected			  : IN    STD_LOGIC;
	
	  --DMD ROW 
	  fifo_ab_data_out			  : OUT   STD_LOGIC_VECTOR(127 DOWNTO 0);
	  fifo_cd_data_out			  : OUT   STD_LOGIC_VECTOR(127 DOWNTO 0);
	  dmd_get_row_data			  : IN    STD_LOGIC;
	  dmd_row_fifo_reset			  : IN    STD_LOGIC;
	--  data_dmd_cycle_fifo_empty		  : OUT   STD_LOGIC;

	  --Register Data
	  reg_data_from_USB			  : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
	  reg_data_to_USB			  : IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
	  reg_addra_USB 			  : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0);
	  reg_data_valid			  : OUT   STD_LOGIC);	 
		
END USB_IO_CLK;


ARCHITECTURE Behavioral OF USB_IO_CLK IS

COMPONENT pll_usb IS
   PORT ( CLKIN1_IN   : IN    STD_LOGIC;
          RST_IN      : IN    STD_LOGIC;
          CLKOUT0_OUT : OUT   STD_LOGIC;
          CLKOUT1_OUT : OUT   STD_LOGIC;
          CLKOUT2_OUT : OUT   STD_LOGIC;
          LOCKED_OUT  : OUT   STD_LOGIC);
END COMPONENT;

COMPONENT fifo_register IS
   PORT ( din         : IN    STD_LOGIC_VECTOR(31 DOWNTO 0);
	  rd_clk      : IN    STD_LOGIC;
	  rd_en       : IN    STD_LOGIC;
	  rst         : IN    STD_LOGIC;
	  wr_clk      : IN    STD_LOGIC;
	  wr_en       : IN    STD_LOGIC;
	  dout        : OUT   STD_LOGIC_VECTOR(31 DOWNTO 0);
	  empty       : OUT   STD_LOGIC;
	  full        : OUT   STD_LOGIC);
END COMPONENT;

COMPONENT FIFO_RCV2 IS
   PORT (
	din           : IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
	rd_clk        : IN    STD_LOGIC;
	rd_en         : IN    STD_LOGIC;
	rst           : IN    STD_LOGIC;
	wr_clk        : IN    STD_LOGIC;
	wr_en         : IN    STD_LOGIC;
	dout          : OUT   STD_LOGIC_VECTOR(127 DOWNTO 0);
	empty         : OUT   STD_LOGIC;
	full          : OUT   STD_LOGIC);
END COMPONENT;


SIGNAL gpif_from_port		   : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL gpif_to_port		   : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL gpif_out_enable_n	   : STD_LOGIC;
SIGNAL data_fifo_wr_en_if	   : STD_LOGIC;

SIGNAL clk_u			   : STD_LOGIC;
SIGNAL clk_180_u		   : STD_LOGIC;
SIGNAL ifclk_bufg	           : STD_LOGIC;

SIGNAL register_address_buffer_if  : STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL USB_PLL_LOCKED_OUT	   : STD_LOGIC;

SIGNAL register_data_buffer_if     : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL register_write_fifo_wr_en   : STD_LOGIC;
SIGNAL register_write_enable       : STD_LOGIC;

SIGNAL reg_fifo_in_rd_en	   : STD_LOGIC;
SIGNAL reg_fifo_in_rd_en_1q	   : STD_LOGIC;
SIGNAL reg_fifo_in_sclk 	   : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reg_fifo_in_sclk_1q         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reg_fifo_in_empty	   : STD_LOGIC;
SIGNAL reg_fifo_in_empty_1q	   : STD_LOGIC;
SIGNAL reg_fifo_in_full 	   : STD_LOGIC;
SIGNAL reg_fifo_in_din 	           : STD_LOGIC_vECTOR(31 DOWNTO 0);

SIGNAL reg_fifo_out_rd_en          : STD_LOGIC;
SIGNAL reg_fifo_out_rd_en_1q       : STD_LOGIC;
SIGNAL reg_fifo_out_clk_usb 	   : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reg_fifo_out_empty	   : STD_LOGIC;
SIGNAL reg_fifo_out_full 	   : STD_LOGIC;
SIGNAL reg_fifo_out_din 	   : STD_LOGIC_vECTOR(31 DOWNTO 0);

SIGNAL dmd_fifo_rd_en		   : STD_LOGIC;

--SIGNAL test_counter		   : STD_LOGIC_VECTOR(15 DOWNTO 0);
       
SIGNAL dmd_single_data  	   : STD_LOGIC_VECTOR(15 DOWNTO 0);
--SIGNAL dmd_single_data_swap        : STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL dmd_single_data_1q	   : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL dmd_single_data_2q	   : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL usb_recv_fifo_wr_en	   : STD_LOGIC;
SIGNAL data_fifo_wr_en_if_1q	   : STD_LOGIC;
    
--SIGNAL fifo_every_other 	   : STD_LOGIC;

SIGNAL fifo_ab_wen		   : STD_LOGIC;
SIGNAL fifo_cd_wen		   : STD_LOGIC;
SIGNAL usb_data_in_count	   : STD_LOGIC_VECTOR(6 DOWNTO 0);

SIGNAL arst_usb                    : STD_LOGIC;
SIGNAL arst_usb_1q                 : STD_LOGIC;

SIGNAL dmd_1080p_connected_1q      : STD_LOGIC;
SIGNAL dmd_1080p_connected_2q      : STD_LOGIC;

SIGNAL FIFO_REN_1q                 : STD_LOGIC;
SIGNAL FIFO_REN_2q 		   : STD_LOGIC;
SIGNAL FIFO_WEN_1q                 : STD_LOGIC;
SIGNAL FIFO_WEN_2q 		   : STD_LOGIC;
SIGNAL FIFO_REGN_1q                : STD_LOGIC;
SIGNAL FIFO_REGN_2q		   : STD_LOGIC;

SIGNAL reg_read_valid              : STD_LOGIC;
SIGNAL reg_read_valid_1q           : STD_LOGIC;

SIGNAL register_read_fifo_wr_en    : STD_LOGIC;

begin



DATA_loop:
FOR i IN 0 TO 15 GENERATE
  IOBUF_inst : IOBUF
   generic map (
      DRIVE => 12,
      IBUF_DELAY_VALUE => "0", -- Specify the amount of added input delay for buffer, "0"-"16" (Spartan-3E/3A only)
      IFD_DELAY_VALUE => "AUTO", -- Specify the amount of added delay for input register, "AUTO", "0"-"8" (Spartan-3E/3A only)
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => gpif_from_port(i),   	-- Buffer output
      IO => BIDIR(i),   			-- Buffer inout port (connect directly to top-level port)
      I => gpif_to_port(i),     	-- Buffer input
      T => gpif_out_enable_n     -- 3-state enable input. When '0' IO = I when '1' O = IO
   );
END GENERATE;

i_bufg_ifclk : bufg
  PORT map (
    O => ifclk_bufg, -- Clock buffer output
    I => ifclk  -- Clock buffer input (connect directly to top-level port)
);
		
i_pll_usb : pll_usb
PORT MAP(
     CLKIN1_IN   => ifclk_bufg  ,
     RST_IN      => reset_i,
     CLKOUT0_OUT => clk_u,   -- 133MHz
     CLKOUT1_OUT => clk_180_u,  -- 266MHz
     CLKOUT2_OUT => OPEN,   -- 266MHz 180deg
     LOCKED_OUT  => USB_PLL_LOCKED_OUT
    );

PROCESS (reset_i, clk_u)
BEGIN
  IF (reset_i = '1') THEN
    arst_usb    <= '1' ;
    arst_usb_1q <= '1';
  ELSIF rising_edge(clk_u) THEN
    arst_usb_1q <= NOT USB_PLL_LOCKED_OUT AFTER 1 PS;
    arst_usb    <= arst_usb_1q AFTER 1 PS;     
  END IF;
END PROCESS;		
		

fifo_usb_ab : FIFO_RCV2
	port map(
	din 	 => dmd_single_data_2q,
	rd_clk   => system_clk,
	rd_en    => dmd_fifo_rd_en,
	rst	 => dmd_row_fifo_reset,
	wr_clk   => clk_180_u,
	wr_en    => fifo_ab_wen,
	dout     => fifo_ab_data_out,
	empty    => open, 
	full     => open);
	
fifo_usb_cd : FIFO_RCV2
	port map(
	din 	 => dmd_single_data_2q,
	rd_clk   => system_clk,
	rd_en    => dmd_fifo_rd_en,
	rst	 => dmd_row_fifo_reset,
	wr_clk   => clk_180_u,
	wr_en    => fifo_cd_wen,
	dout     => fifo_cd_data_out,
	empty    => open, 
	full     => open);
	
PROCESS (arst_usb, clk_180_u)
BEGIN
  IF (arst_usb = '1') THEN
    dmd_1080p_connected_1q <= '0' ;
    dmd_1080p_connected_2q <= '0';
  ELSIF rising_edge(clk_180_u) THEN
    dmd_1080p_connected_1q <= dmd_1080p_connected AFTER 1 PS;
    dmd_1080p_connected_2q <= dmd_1080p_connected_1q AFTER 1 PS; 
  END IF;
END PROCESS;
		

--put the incomeing usb data into the correct FIFO	
PROCESS(clk_180_u, arst_usb, dmd_row_fifo_reset)
BEGIN
	IF arst_usb = '1' OR dmd_row_fifo_reset = '1' THEN
		fifo_ab_wen <= '0';
		fifo_cd_wen <= '0';
		usb_data_in_count <= "0000000";
	ELSIF clk_180_u'EVENT AND clk_180_u = '1' THEN
		if usb_recv_fifo_wr_en = '1' then
			if dmd_1080p_connected_2q = '1' then
			   usb_data_in_count <= usb_data_in_count + "0000001";
				if usb_data_in_count <= x"3B" then     --ab data to be written to ab fifo
					fifo_ab_wen <= '1';
					fifo_cd_wen <= '0';
				elsif usb_data_in_count <= x"76" then  --cd data to be written to the cd fifo
					fifo_ab_wen <= '0';
					fifo_cd_wen <= '1';
				else
					-- reset counter
				usb_data_in_count <= "0000000";    --set to  all one. will roll over on increment below
				end if;
			else																--XGA
				fifo_ab_wen <= '1';
			end if;
		else
			fifo_ab_wen <= '0';
			fifo_cd_wen <= '0';
		end if;
	END IF;
END PROCESS;

--Data queues
PROCESS(clk_180_u, arst_usb)
BEGIN
	IF arst_usb = '1' THEN
		data_fifo_wr_en_if_1q <= '0';
		dmd_single_data_1q <= x"0000";
		dmd_single_data_2q <= x"0000";
	ELSIF clk_180_u'EVENT AND clk_180_u = '1' THEN
		data_fifo_wr_en_if_1q <= data_fifo_wr_en_if;
                for i in 0 to 15 loop
                  dmd_single_data_1q(i) <= dmd_single_data(15-i);
                end loop;  -- i
		dmd_single_data_2q <= dmd_single_data_1q;
	END IF;
END PROCESS;


--Data queues
PROCESS(clk_180_u, arst_usb)
BEGIN
	IF arst_usb = '1' THEN
		FIFO_REN_1q  <= '0';
		FIFO_REN_2q  <= '0';
		FIFO_WEN_1q  <= '0';
		FIFO_WEN_2q  <= '0';
		FIFO_REGN_1q <= '0';
		FIFO_REGN_2q <= '0';
	ELSIF clk_180_u'EVENT AND clk_180_u = '1' THEN
		FIFO_REN_1q  <= FIFO_REN;
		FIFO_REN_2q  <= FIFO_REN_1q;
		FIFO_WEN_1q  <= FIFO_WEN;
		FIFO_WEN_2q  <= FIFO_WEN_1q;
		FIFO_REGN_1q <= FIFO_REGN;
		FIFO_REGN_2q <= FIFO_REGN_1q;
	END IF;
END PROCESS;

		

PROCESS(system_clk, system_reset)
BEGIN
	IF system_reset = '1' THEN
		reg_fifo_in_sclk_1q <= (OTHERS => '0');
	ELSIF system_clk'EVENT AND system_clk = '1' THEN
		reg_fifo_in_sclk_1q <= reg_fifo_in_sclk;
	END IF;
END PROCESS;
		
--incoming fifo for register trasactions

REG_FIFO_IN : fifo_register
	port map (
		din    	=> reg_fifo_in_din,
		rd_clk 	=> system_clk,
		rd_en	=> reg_fifo_in_rd_en,
		rst	=> arst_usb,
		wr_clk	=> clk_180_u,
		wr_en	=> register_write_fifo_wr_en, 
		dout	=> reg_fifo_in_sclk,
		empty	=> reg_fifo_in_empty,
		full	=> reg_fifo_in_full);

reg_fifo_out_din <= "0000000000000000" & reg_data_to_USB;		
		
REG_FIFO_OUT : fifo_register
	port map (
		din    	=> reg_fifo_out_din,
		rd_clk 	=> clk_180_u,
		rd_en	=> reg_fifo_out_rd_en,
		rst	=> arst_usb,
		wr_clk	=> system_clk,
		wr_en	=> register_read_fifo_wr_en, 
		dout	=> reg_fifo_out_clk_usb,
		empty	=> reg_fifo_out_empty,
		full	=> reg_fifo_out_full);


--Process to latch the gpif data from the USB interface into a data buffer, and to controll the fifo write enble flag.

process(clk_180_u, arst_usb)
begin
	IF arst_usb = '1' THEN
		data_fifo_wr_en_if <= '0';
		dmd_single_data    <= (OTHERS => '0');
	ELSIF clk_180_u'EVENT AND clk_180_u = '1' THEN
		if FIFO_WEN = '0' AND FIFO_REN = '1' AND FIFO_REGN = '1' THEN
			dmd_single_data <= gpif_from_port(7 downto 0) & gpif_from_port(15 downto 8);
			data_fifo_wr_en_if <= '1';		
		else
			data_fifo_wr_en_if <= '0';
	
	   end if;
	END IF;
end process;

--set the register Address
process(clk_180_u, arst_usb)
begin
	IF arst_usb = '1' THEN
		register_address_buffer_if <= x"00";
	ELSIF clk_180_u'EVENT AND clk_180_u = '1' THEN
		IF FIFO_WEN = '1' AND FIFO_REN = '1' AND FIFO_REGN = '0' THEN
		        register_address_buffer_if <= gpif_from_port(7 DOWNTO 0);
	        END IF;
	END IF;
end process;


--writes register data to the fifo
process(clk_180_u, arst_usb)
begin
	IF arst_usb = '1' THEN
		register_data_buffer_if   <= x"0000";
		register_write_enable     <= '0';
		register_write_fifo_wr_en <= '0';
	ELSIF clk_180_u'EVENT AND clk_180_u = '1' THEN
		if FIFO_WEN = '0' AND FIFO_REN = '1' AND FIFO_REGN = '0' THEN
			register_data_buffer_if   <= gpif_from_port;
			register_write_enable     <= '1';
			register_write_fifo_wr_en <= '1';
	        elsif FIFO_WEN = '1' AND FIFO_REN = '1' AND FIFO_REGN = '0' THEN
			register_data_buffer_if   <= x"0000";
			register_write_enable     <= '0';
			register_write_fifo_wr_en <= '1';		
		else
			register_write_fifo_wr_en <= '0';
	   end if;
	END IF;
end process;


reg_fifo_in_rd_en  <= NOT reg_fifo_in_empty;
reg_fifo_out_rd_en <= NOT reg_fifo_out_empty;

register_read_fifo_wr_en <= reg_read_valid_1q;

--sets flag when new reg data is avalible
process(system_clk, system_reset)
begin
	if system_reset = '1' then
		reg_data_valid       <= '0';
		reg_read_valid       <= '0';
		reg_read_valid_1q    <= '0';
		reg_fifo_in_empty_1q <= '0';
		reg_fifo_in_rd_en_1q <= '0';
	elsif system_clk'EVENT and system_clk = '1' then
	        reg_fifo_in_empty_1q <= reg_fifo_in_empty;
		reg_read_valid_1q    <= reg_read_valid;
		reg_fifo_in_rd_en_1q <= reg_fifo_in_rd_en;
		if (reg_fifo_in_rd_en_1q = '1') then
		  if (reg_fifo_in_sclk(31) = '1' AND reg_fifo_in_empty = '1' AND reg_fifo_in_empty_1q = '0') THEN
			reg_data_valid <= '1';
			reg_read_valid <= '0';
	          else
		        reg_data_valid <= '0';
			reg_read_valid <= '1';
	          end if;
		else 
			reg_data_valid <= '0';
			reg_read_valid <= '0';
		end if;
	end if;
end process;


--renames
usb_recv_fifo_wr_en <= data_fifo_wr_en_if AND data_fifo_wr_en_if_1q;

dmd_fifo_rd_en      <= dmd_get_row_data;
gpif_to_port        <= reg_fifo_out_clk_usb(15 DOWNTO 0);
reg_data_from_USB   <= reg_fifo_in_sclk_1q(15 downto 0);
reg_addra_USB 	    <= reg_fifo_in_sclk_1q(23 downto 16 );
reg_fifo_in_din     <= register_write_enable & "0000000" & register_address_buffer_if & register_data_buffer_if;

gpif_out_enable_n   <= fifo_ren;


end Behavioral;
