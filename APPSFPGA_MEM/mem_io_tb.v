`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:04:32 05/26/2021
// Design Name:   MEM_IO_Verilog
// Module Name:   /home/ise/Desktop/APPSFPGA_MEM/mem_io_tb.v
// Project Name:  APPSFPGA_MEM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MEM_IO_Verilog
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_io_tb;

	// Inputs
	wire mem_clk0;
	wire mem_clk2x;
	wire mem_clk2x90;
	wire mem_clk200;
	wire pll_mem_locked;
	reg system_clk;
	reg system_reset;
	reg [14:0] num_patterns;
	reg dmd_1080p_connected;
	wire [127:0] wr_data;
	wire wr_valid;
	wire wr_data_valid;
	reg dmd_get_data;
	reg [14:0] rd_pattern_id;
	reg mem_read_enable;
	reg mem_rd_fifo_reset;

	// Outputs
	wire [13:0] ddr2_a;
	wire [2:0] ddr2_ba;
	wire ddr2_ras_n;
	wire ddr2_cas_n;
	wire ddr2_we_n;
	wire [1:0] ddr2_cs_n;
	wire [1:0] ddr2_odt;
	wire [1:0] ddr2_cke;
	wire [7:0] ddr2_dm;
	wire mem_init_done;
	wire [1:0] ddr2_ck;
	wire [1:0] ddr2_ck_n;
	wire mem_preload_done;
	wire mem_get_data;
	wire [127:0] rd_ab_fifo_out;
	wire [127:0] rd_cd_fifo_out;
	wire rd_ab_fifo_valid;
	wire rd_cd_fifo_valid;
	wire rd_ab_fifo_data_valid;
	wire rd_cd_fifo_data_valid;

	// Bidirs
	wire [63:0] ddr2_dq;
	wire [7:0] ddr2_dqs;
	wire [7:0] ddr2_dqs_n;

	// Instantiate the Unit Under Test (UUT)
	MEM_IO_Verilog uut (
		.ddr2_dq(ddr2_dq), 
		.ddr2_a(ddr2_a), 
		.ddr2_ba(ddr2_ba), 
		.ddr2_ras_n(ddr2_ras_n), 
		.ddr2_cas_n(ddr2_cas_n), 
		.ddr2_we_n(ddr2_we_n), 
		.ddr2_cs_n(ddr2_cs_n), 
		.ddr2_odt(ddr2_odt), 
		.ddr2_cke(ddr2_cke), 
		.ddr2_dm(ddr2_dm), 
		.mem_init_done(mem_init_done), 
		.ddr2_dqs(ddr2_dqs), 
		.ddr2_dqs_n(ddr2_dqs_n), 
		.ddr2_ck(ddr2_ck), 
		.ddr2_ck_n(ddr2_ck_n), 
		.mem_clk0(mem_clk0), 
		.mem_clk2x(mem_clk2x), 
		.mem_clk2x90(mem_clk2x90), 
		.mem_clk200(mem_clk200), 
		.pll_mem_locked(pll_mem_locked), 
		.system_clk(system_clk), 
		.system_reset(system_reset), 
		.mem_preload_done(mem_preload_done), 
		.num_patterns(num_patterns), 
		.dmd_1080p_connected(dmd_1080p_connected), 
		.wr_data(wr_data), 
		.wr_valid(wr_valid), 
		.wr_data_valid(wr_data_valid), 
		.mem_get_data(mem_get_data), 
		.rd_ab_fifo_out(rd_ab_fifo_out), 
		.rd_cd_fifo_out(rd_cd_fifo_out), 
		.dmd_get_data(dmd_get_data), 
		.rd_ab_fifo_valid(rd_ab_fifo_valid), 
		.rd_cd_fifo_valid(rd_cd_fifo_valid), 
		.rd_ab_fifo_data_valid(rd_ab_fifo_data_valid), 
		.rd_cd_fifo_data_valid(rd_cd_fifo_data_valid), 
		.rd_pattern_id(rd_pattern_id), 
		.mem_read_enable(mem_read_enable), 
		.mem_rd_fifo_reset(mem_rd_fifo_reset)
	);
	
	pll_mem i_pll_mem
	(
		.CLKIN1_IN(clk_i),
		.RST_IN(mem_rd_fifo_reset),
		.CLKOUT0_OUT(mem_clk0),   // 75MHz
		.CLKOUT1_OUT(mem_clk2x),  // 150MHz
		.CLKOUT2_OUT(mem_clk2x90),// 150MHz 180deg
		.CLKOUT3_OUT(mem_clk200),
		.LOCKED_OUT(pll_mem_locked)
	 );

   initial begin
      system_reset = 1'b1;
		mem_rd_fifo_reset = 1;
      #500;
      system_reset = 1'b0;
		mem_rd_fifo_reset = 0;
   end

   initial
		system_clk = 0;
	always
		system_clk = #2.5 ~system_clk;
	
	initial
		clk_i = 0;
	always
		clk_i = #10 ~clk_i;

	parameter USB_CLK_PERIOD = 20.83;
	reg [127:0] data[18432:1];
	reg [15:0] usb_data[147456:1];
	reg [31:0] counter;
	reg read_en;
	reg clk_usb;
	reg clk_i;
	reg test_fifo_wren;
	reg [15:0] test_fifo_in;
	wire test_fifo_full;
	wire test_fifo_empty;
	reg start_din;
	
	assign wr_valid = ~test_fifo_empty;
	
	//usb clock
	initial begin
		clk_usb = 0;
		forever
		#(USB_CLK_PERIOD/2) clk_usb = ~clk_usb;
	end
	
	initial begin
		start_din = 0;
		#600;
		start_din = 1;
	end

	//load test patterns from files
	initial begin
		//$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/data.txt", data);
		//$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/usbdata.txt", usb_data);
		$readmemb("/home/ise/ise_proj/dmd-project/src/sim/usbdata.txt", usb_data);

	end
	
	fifo mem_fifo (
		.wr_clk(clk_usb),
		.rd_clk(mem_clk2x),
		.rst(~sys_rst_out),
		.wr_en(test_fifo_wren),
		.rd_en(mem_get_data),
		.din(test_fifo_in),
		.dout(wr_data),
		.valid(wr_data_valid),
		.full(test_fifo_full),
		.empty(test_fifo_empty)
		);
		
	always@(posedge clk_usb, system_reset) begin
		if (system_reset == 1) begin
			test_fifo_wren <= 0;
			test_fifo_in <= 0;
			counter <= 1;
		end else if (start_din == 1) begin
			if (counter == 32'd147457) begin
				test_fifo_wren <= 0;
				test_fifo_in <= 0;
			end else begin
				test_fifo_in <= usb_data[counter];
				test_fifo_wren <= 1;
				counter <= counter + 1;
			end 
		end
	end

	always@(posedge system_clk, system_reset) begin
		if(system_reset == 1) begin
			rd_pattern_id <= 0;
			mem_read_enable <= 0;
			dmd_get_data <= 0;
		end else if(mem_preload_done == 1) begin
			rd_pattern_id <= 1;
			mem_read_enable <= 1;
			
			if(rd_ab_fifo_valid == 1) begin
				dmd_get_data <= 1;
			end else begin
				dmd_get_data <= 0;
			end
		end
	end
			
	initial begin
		num_patterns = 2;
		dmd_1080p_connected = 0;
	end
      
endmodule

