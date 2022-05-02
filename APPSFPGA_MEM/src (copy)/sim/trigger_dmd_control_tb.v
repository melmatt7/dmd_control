`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:51:17 05/03/2021
// Design Name:   DMD_trigger_control
// Module Name:   /home/ise/Documents/APPSFPGA_DDR2/src/sim/trigger_dmd_control_tb.v
// Project Name:  APPSFPGA_DDR2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DMD_trigger_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module trigger_dmd_control_tb;

	// Inputs
	reg clk_g;
	reg locked_init_rstz_gq;
	reg dmd_1080p_connected;
	reg quarter_buss_connected;
	reg appsfpga_io_comp_data_en_q;
	reg appsfpga_io_ns_flip_en_q;
	reg [1:0] appsfpga_io_reset_type_q;
	reg appsfpga_io_rowaddrmode_q;
	reg appsfpga_io_WDT_enbl_q;
	reg appsfpga_io_STEP_VCC_enbl_q;
	reg appsfpga_io_float_q;
	reg [3:0] in_dmd_type;
	reg ddc_init_active;
	
	wire rd_ab_fifo_valid;
//	reg rd_ab_fifo_valid;
	reg rd_cd_fifo_valid;
	
//	reg rd_ab_fifo_data_valid;
	wire rd_ab_fifo_data_valid;
	
	reg rd_cd_fifo_data_valid;
	reg dmd_row_fifo_reset;
	
//	reg [127:0] rd_ab_fifo_out;
	wire [127:0] rd_ab_fifo_out;
	
	reg [127:0] rd_cd_fifo_out;
	reg mem_preload_done;
	reg trigger;

	// Outputs
	wire [63:0] dmd_dout_a;
	wire [63:0] dmd_dout_b;
	wire [63:0] dmd_dout_c;
	wire [63:0] dmd_dout_d;
	wire dmd_dvalid;
	wire [1:0] dmd_rowmd;
	wire [10:0] dmd_rowad;
	wire [3:0] dmd_blkad;
	wire [1:0] dmd_blkmd;
	wire dmd_STEP_VCC;
	wire dmd_comp_data;
	wire dmd_ns_flip;
	wire dmd_rst2blkz;
	wire dmd_get_row_data;
	wire mem_read_enable;

	// Instantiate the Unit Under Test (UUT)
	DMD_trigger_control uut (
		.clk_g(clk_g), 
		.locked_init_rstz_gq(locked_init_rstz_gq), 
		.dmd_1080p_connected(dmd_1080p_connected), 
		.quarter_buss_connected(quarter_buss_connected), 
		.appsfpga_io_comp_data_en_q(appsfpga_io_comp_data_en_q), 
		.appsfpga_io_ns_flip_en_q(appsfpga_io_ns_flip_en_q), 
		.appsfpga_io_reset_type_q(appsfpga_io_reset_type_q), 
		.appsfpga_io_rowaddrmode_q(appsfpga_io_rowaddrmode_q), 
		.appsfpga_io_WDT_enbl_q(appsfpga_io_WDT_enbl_q), 
		.appsfpga_io_STEP_VCC_enbl_q(appsfpga_io_STEP_VCC_enbl_q), 
		.appsfpga_io_float_q(appsfpga_io_float_q), 
		.in_dmd_type(in_dmd_type), 
		.ddc_init_active(ddc_init_active), 
		.dmd_dout_a(dmd_dout_a), 
		.dmd_dout_b(dmd_dout_b), 
		.dmd_dout_c(dmd_dout_c), 
		.dmd_dout_d(dmd_dout_d), 
		.dmd_dvalid(dmd_dvalid), 
		.dmd_rowmd(dmd_rowmd), 
		.dmd_rowad(dmd_rowad), 
		.dmd_blkad(dmd_blkad), 
		.dmd_blkmd(dmd_blkmd), 
		.dmd_STEP_VCC(dmd_STEP_VCC), 
		.dmd_comp_data(dmd_comp_data), 
		.dmd_ns_flip(dmd_ns_flip), 
		.dmd_rst2blkz(dmd_rst2blkz), 
		.rd_ab_fifo_valid(rd_ab_fifo_valid), 
		.rd_cd_fifo_valid(rd_cd_fifo_valid),
		.rd_ab_fifo_data_valid(rd_ab_fifo_data_valid), 
		.rd_cd_fifo_data_valid(rd_cd_fifo_data_valid), 
		.dmd_get_row_data(dmd_get_row_data), 
		.dmd_row_fifo_reset(dmd_row_fifo_reset), 
		.rd_ab_fifo_out(rd_ab_fifo_out), 
		.rd_cd_fifo_out(rd_cd_fifo_out), 
		.mem_read_enable(mem_read_enable), 
		.mem_preload_done(mem_preload_done),  
		.trigger(trigger)
	);
	
	reg [127:0] pattern1[6144:1];
	reg [127:0] pattern2[6144:1];
	reg [127:0] pattern3[6144:1];
	reg [31:0] counter;
	reg read_en;
	
	//load test patterns from files
	initial begin
		$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/128pattern1.txt", pattern1);
		$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/128pattern2.txt", pattern2);
		$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/128pattern3.txt", pattern3);
	end
	
	task trigger_gen_task;
	begin
		trigger = 1;
		read_en = 1;
		//rd_ab_fifo_valid = 1;
		#40;
		trigger = 0;
	end
	endtask
	
	always #2.5 clk_g = ~clk_g;
	always #3.33 mem_clk = ~mem_clk;
	
	reg test_fifo_wren;
	reg [127:0] test_fifo_in;
	reg mem_clk;
	wire rd_ab_fifo_full;
	wire rd_ab_fifo_empty;
	assign rd_ab_fifo_valid = ~rd_ab_fifo_empty;
	
	read_fifo rd_ab_fifo (
		.wr_clk(mem_clk),
		.rd_clk(clk_g),
		.rst(~locked_init_rstz_gq),
		.wr_en(test_fifo_wren),
		.rd_en(dmd_get_row_data),
		.din(test_fifo_in),
		.dout(rd_ab_fifo_out),
		.valid(rd_ab_fifo_data_valid),
		.full(rd_ab_fifo_full),
		.prog_empty(rd_ab_fifo_empty),
		.empty()
	);
	
	always@(posedge mem_clk) begin
		if(locked_init_rstz_gq == 0) begin
			test_fifo_wren <= 0;
			test_fifo_in <= 0;
			counter <= 1;
			read_en <= 0;
		end else begin
			if (read_en == 1) begin
				if (counter == 32'd6145) begin
					test_fifo_wren <= 0;
					counter <= 1;
					test_fifo_in <= 0;
					read_en <= 0;
				end else begin
					test_fifo_in <= test_fifo_in + 1;
					counter <= counter + 1;
					test_fifo_wren <= 1;
				end
			end else begin
				test_fifo_wren <= 0;
			end
		end
	end
				


	initial begin
		// Initialize Inputs
		clk_g = 0;
		mem_clk = 0;
		locked_init_rstz_gq = 0;
		dmd_1080p_connected = 0;
		quarter_buss_connected = 0;
		appsfpga_io_comp_data_en_q = 0;
		appsfpga_io_ns_flip_en_q = 0;
		appsfpga_io_reset_type_q = 2'b10; //global reset mode
		appsfpga_io_rowaddrmode_q = 1;
		appsfpga_io_WDT_enbl_q = 0;
		appsfpga_io_STEP_VCC_enbl_q = 0;
		appsfpga_io_float_q = 0;
		in_dmd_type = 4'b0001;
		ddc_init_active = 1;
		dmd_row_fifo_reset = 0;
		mem_preload_done = 0;
		trigger = 0;

		// Wait 100 ns for global reset to finish
		#100;
      locked_init_rstz_gq = 1;
		mem_preload_done = 1;
		ddc_init_active = 0;
		// Add stimulus here
		#200;
		trigger_gen_task();
		#80000
		trigger_gen_task();
		#80000
		trigger_gen_task();
		#80000
		trigger_gen_task();
		#80000
		trigger_gen_task();
	end
      
endmodule

