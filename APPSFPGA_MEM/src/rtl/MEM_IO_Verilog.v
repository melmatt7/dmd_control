`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:57:58 05/11/2021 
// Design Name: 
// Module Name:    mig 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MEM_IO_Verilog#(
	parameter BANK_WIDTH              = 3,       
										// # of memory bank addr bits.
	parameter CKE_WIDTH               = 2,       
										// # of memory clock enable outputs.
	parameter CLK_WIDTH               = 2,       
										// # of clock outputs.
	parameter COL_WIDTH               = 10,       
										// # of memory column bits.
	parameter CS_NUM                  = 2,       
										// # of separate memory chip selects.
	parameter CS_WIDTH                = 2,       
										// # of total memory chip selects.
	parameter CS_BITS                 = 1,       
										// set to log2(CS_NUM) (rounded up).
	parameter DM_WIDTH                = 8,       
										// # of data mask bits.
	parameter DQ_WIDTH                = 64,       
										// # of data width.
	parameter DQ_PER_DQS              = 8,       
										// # of DQ data bits per strobe.
	parameter DQS_WIDTH               = 8,       
										// # of DQS strobes.
	parameter DQ_BITS                 = 6,       
										// set to log2(DQS_WIDTH*DQ_PER_DQS).
	parameter DQS_BITS                = 3,       
										// set to log2(DQS_WIDTH).
	parameter ODT_WIDTH               = 2,       
										// # of memory on-die term enables.
	parameter ROW_WIDTH               = 14,       
										// # of memory row and # of addr bits.
	parameter ADDITIVE_LAT            = 0,       
										// additive write latency.
	parameter BURST_LEN               = 4,       
										// burst length (in double words).
	parameter BURST_TYPE              = 0,       
										// burst type (=0 seq; =1 interleaved).
	parameter CAS_LAT                 = 3,       
										// CAS latency.
	parameter ECC_ENABLE              = 0,       
										// enable ECC (=1 enable).
	parameter APPDATA_WIDTH           = 128,       
										// # of usr read/write data bus bits.
	parameter MULTI_BANK_EN           = 1,       
										// Keeps multiple banks open. (= 1 enable).
	parameter TWO_T_TIME_EN           = 1,       
										// 2t timing for unbuffered dimms.
	parameter ODT_TYPE                = 1,       
										// ODT (=0(none),=1(75),=2(150),=3(50)).
	parameter REDUCE_DRV              = 0,       
										// reduced strength mem I/O (=1 yes).
	parameter REG_ENABLE              = 0,       
										// registered addr/ctrl (=1 yes).
	parameter TREFI_NS                = 7800,       
										// auto refresh interval (ns).
	parameter TRAS                    = 40000,       
										// active->precharge delay.
	parameter TRCD                    = 15000,       
										// active->read/write delay.
	parameter TRFC                    = 127500,       
										// refresh->refresh, refresh->active delay.
	parameter TRP                     = 15000,       
										// precharge->command delay.
	parameter TRTP                    = 7500,       
										// read->precharge delay.
	parameter TWR                     = 15000,       
										// used to determine write->precharge.
	parameter TWTR                    = 7500,       
										// write->read delay.
	parameter HIGH_PERFORMANCE_MODE   = "TRUE",       
								// # = TRUE, the IODELAY performance mode is set
								// to high.
								// # = FALSE, the IODELAY performance mode is set
								// to low.
	parameter SIM_ONLY                = 0,       
										// = 1 to skip SDRAM power up delay.
	parameter DEBUG_EN                = 0,       
										// Enable debug signals/controls.
										// When this parameter is changed from 0 to 1,
										// make sure to uncomment the coregen commands
										// in ise_flow.bat or create_ise.bat files in
										// par folder.
	parameter CLK_PERIOD              = 6666,       
										// Core/Memory clock period (in ps).
	parameter RST_ACT_LOW             = 1        
										// =1 for active low reset, =0 for active high.
   )
(
	inout  [DQ_WIDTH-1:0]              ddr2_dq,
	output [ROW_WIDTH-1:0]             ddr2_a,
	output [BANK_WIDTH-1:0]            ddr2_ba,
	output                             ddr2_ras_n,
	output                             ddr2_cas_n,
	output                             ddr2_we_n,
	output [CS_WIDTH-1:0]              ddr2_cs_n,
	output [ODT_WIDTH-1:0]             ddr2_odt,
	output [CKE_WIDTH-1:0]             ddr2_cke,
	output [DM_WIDTH-1:0]              ddr2_dm,
	output                             mem_init_done,
	inout  [DQS_WIDTH-1:0]             ddr2_dqs,
	inout  [DQS_WIDTH-1:0]             ddr2_dqs_n,
	output [CLK_WIDTH-1:0]             ddr2_ck,
	output [CLK_WIDTH-1:0]             ddr2_ck_n,
	
	input mem_clk0,
	input mem_clk2x,
	input mem_clk2x90,
	input mem_clk200,
	input pll_mem_locked,
	input system_clk,
	input system_reset,
	output mem_preload_done,
	input mem_read_enable,
	input[14:0] num_patterns,
//	input dmd_1080p_connected,
	input [127:0] wr_data,
	input wr_valid,
	input wr_data_valid,
	output mem_get_data,
	output[127:0] rd_ab_fifo_out,
	output[127:0] rd_cd_fifo_out,
	input dmd_get_data,
	output rd_ab_fifo_valid,
	output rd_cd_fifo_valid,
	output rd_ab_fifo_data_valid,
	output rd_cd_fifo_data_valid,
	input mem_rd_fifo_reset
    );
	 
	wire clk0;
	wire rst0;
	wire system_reset_n;
	wire rd_ab_fifo_afull;
	wire rd_cd_fifo_afull;
	wire rd_ab_fifo_empty;
	wire rd_cd_fifo_empty;
	
	reg rd_ab_fifo_wren;
	reg rd_cd_fifo_wren;
	
	parameter            S0  = 3'd0 ;
    parameter            S1  = 3'd1 ;
    parameter            S2  = 3'd2 ;
	 
	reg[2:0] current_state;
	reg[2:0] next_state;
	
	reg mem_preload_done1;
	reg pattern_read_done1;
	reg[14:0] write_pattern_count;
	reg burst_indicator;
	reg[13:0] wr_offset_addr;
	reg[13:0] rd_offset_addr;
	wire wr_ready;
	wire rd_ready;
	
	reg mem_get_data1;
	
	parameter[13:0] max_offset = 14'd3072;
	parameter[2:0] READ = 3'b001;
	parameter[2:0] WRITE = 3'b000;
	
	wire app_af_afull;
	wire app_wdf_afull;
	wire rd_data_valid;
	wire[127:0] rd_data_fifo_out;
	
	reg[127:0] rd_data_fifo_out_1q;
	
	reg app_af_wren, app_wdf_wren;
	reg[2:0] app_af_cmd;
	reg[30:0] app_af_addr;
	reg[127:0] app_wdf_data;
	reg[15:0] app_wdf_mask_data;
	
//	reg dmd_1080p_connected_1q;
	wire dmd_1080p_connected_2q;
	
	reg[14:0] rd_pattern_id;
	
	reg mem_preload_done_1q;
	reg mem_preload_done_2q;
	
	reg[6:0] mem_data_in_count;
	
	wire mem_read_enable_out;
	reg mem_read_enable_q1;
	reg mem_read_enable_q2;
	reg mem_read_enable_q3;
	reg mem_read_enable_q4;
	wire mem_read_enable_1;
	reg pattern_read_done_q1;
	
//	reg[14:0] num_patterns_q1;
//	reg[14:0] num_patterns_q2;
	
	
	
	assign system_reset_n = ~system_reset;
	 
	mig_top u_mig_top (
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
   .sys_rst_n(system_reset_n),
   .phy_init_done(phy_init_done),
   .rst0_tb(rst0),
   .clk0_tb(),
   .locked(pll_mem_locked),
   .clk0(mem_clk2x),
   .clk90(mem_clk2x90),
   .clkdiv0(mem_clk0),
   .clk200(mem_clk200),
   .app_wdf_afull(app_wdf_afull),
   .app_af_afull(app_af_afull),
   .rd_data_valid(rd_data_valid),
   .app_wdf_wren(app_wdf_wren),
   .app_af_wren(app_af_wren),
   .app_af_addr(app_af_addr),
   .app_af_cmd(app_af_cmd),
   .rd_data_fifo_out(rd_data_fifo_out),
   .app_wdf_data(app_wdf_data),
   .app_wdf_mask_data(app_wdf_mask_data),
   .ddr2_dqs(ddr2_dqs),
   .ddr2_dqs_n(ddr2_dqs_n),
   .ddr2_ck(ddr2_ck),
   .ddr2_ck_n(ddr2_ck_n)
	);
	
	read_fifo rd_ab_fifo (
	.wr_clk(clk0),
	.rd_clk(system_clk),
	.rst(rst0),
	.wr_en(rd_ab_fifo_wren),
	.rd_en(dmd_get_data),
	.din(rd_data_fifo_out_1q),
	.dout(rd_ab_fifo_out),
	.valid(rd_ab_fifo_data_valid),
	.full(),
	.prog_full(rd_ab_fifo_afull),
	.prog_empty(rd_ab_fifo_empty),
	.almost_full(ab_fifo_afull),//test
	.empty()
	);
	
	read_fifo rd_cd_fifo (
	.wr_clk(clk0),
	.rd_clk(system_clk),
	.rst(rst0),
	.wr_en(rd_cd_fifo_wren),
	.rd_en(dmd_get_data),
	.din(rd_data_fifo_out_1q),
	.dout(rd_cd_fifo_out),
	.valid(rd_cd_fifo_data_valid),
	.full(),
	.prog_full(rd_cd_fifo_afull),
	.prog_empty(rd_cd_fifo_empty),
	.almost_full(),
	.empty()
	);
	
//	mem_read_enable_fifo i_mem_read_enable_cdc (
//	.wr_clk(system_clk),
//	.rd_clk(clk0),
//	.rst(rst0),
//	.wr_en(~rst0),
//	.rd_en(~rst0),
//	.din(mem_read_enable),
//	.dout(mem_read_enable_out),
//	.valid(mem_read_enable_valid),
//	.full(),
//	.empty()
//	);
	always@(posedge system_clk) begin
		if(system_reset == 1) begin
			mem_read_enable_q1 <= 0;
		end else begin
			mem_read_enable_q1 <= mem_read_enable;
		end
	end
	
	always@(posedge clk0) begin
		if(rst0 == 1) begin
			mem_read_enable_q2 <= 0;
			mem_read_enable_q3 <= 0;
			mem_read_enable_q4 <= 0;
//			num_patterns_q1 <= 0;
//			num_patterns_q2 <= 0;
		end else begin
			mem_read_enable_q2 <= mem_read_enable_q1;
			mem_read_enable_q3 <= mem_read_enable_q2;
			mem_read_enable_q4 <= mem_read_enable_q3;
//			num_patterns_q1 <= num_patterns;
//			num_patterns_q2 <= num_patterns_q1;
		end
	end
	assign mem_read_enable_1 = mem_read_enable_q3 & ~mem_read_enable_q4;
	
	always@(posedge clk0) begin
		if (rst0 == 1) current_state <= 0;
		else current_state <= next_state;
	end
	
	always@(*) begin
		case(current_state)
			S0:
				if (mem_preload_done1 == 0 && phy_init_done == 1)
					next_state = S1;
				else if (mem_read_enable_1 == 1)
					next_state = S2;
				else
					next_state = S0;
			S1:
				if(mem_preload_done1 == 1)
					next_state = S0;
				else
					next_state = S1;
			S2:
				if(pattern_read_done1 == 1)
					next_state = S0;
				else
					next_state = S2;
			default: next_state = S0;
		endcase
	end
	
	always@(posedge clk0) begin
		if(rst0 == 1) begin
			app_wdf_wren <= 0;
			app_wdf_data <= 0;
			app_wdf_mask_data <= 0;
			app_af_wren <= 0;
			app_af_cmd <= WRITE;
			app_af_addr <= 0;
			burst_indicator <= 0;
			
			write_pattern_count <= 0;
			wr_offset_addr <= 0;
			mem_preload_done1 <= 0;
			mem_get_data1 <= 0;
			
			rd_offset_addr <= 0;
			pattern_read_done1 <= 0;
		end else begin
			case(current_state)
				S0: begin
					app_wdf_data <= 0;
					app_wdf_wren <= 0;
					app_af_wren <= 0;
					app_af_addr <= 0;
					mem_get_data1 <= 0;
					rd_offset_addr <= 0;
					wr_offset_addr <= 0;
					pattern_read_done1 <= 0;
				end
				S1: begin
					if (wr_offset_addr < max_offset) begin
						mem_get_data1 <= wr_ready & wr_valid;
						if(wr_data_valid == 1) begin
							if(burst_indicator == 0) begin
								app_af_addr <=  {write_pattern_count, wr_offset_addr, 2'd0};
								app_af_cmd <= WRITE;
								app_af_wren <= 1;
							end else begin
								app_af_wren <= 0;
								app_af_addr <= 0;
								wr_offset_addr <= wr_offset_addr + 1;
							end	
							app_wdf_data <= wr_data;
							app_wdf_wren <= 1;
							burst_indicator <= ~burst_indicator;
						end else begin
							app_wdf_data <= 0;
							app_wdf_wren <= 0;
							app_af_wren <= 0;
							app_af_addr <= 0;
						end
					end else begin
						mem_get_data1 <= 0;
						app_af_addr <=  {write_pattern_count, wr_offset_addr, 2'd0};
						app_af_cmd <= WRITE;
						app_af_wren <= 1;
						app_wdf_data <= 127'd0;
						wr_offset_addr <= 0;
						
						if(write_pattern_count < num_patterns) begin
							write_pattern_count <= write_pattern_count + 1;
						end else begin
							mem_preload_done1 <= 1;
						end
					end
						
//					mem_get_data1 <= wr_ready & wr_valid;
//					rd_offset_addr <= 0;
//					if(wr_data_valid == 1) begin
//						if(burst_indicator == 0) begin
//							app_af_addr <=  {write_pattern_count, wr_offset_addr, 2'd0};
//							app_af_cmd <= WRITE;
//							app_af_wren <= 1;
//						end else begin
//							app_af_wren <= 0;
//							app_af_addr <= 0;
//							if(wr_offset_addr >= max_offset) begin
//								if(write_pattern_count < num_patterns) begin
//									wr_offset_addr <= 0;
//									write_pattern_count <=  write_pattern_count + 1;
//								end else begin
//									mem_preload_done1 <= 1;
//								end
//							end else begin
//								wr_offset_addr <= wr_offset_addr + 1;
//							end
//						end	
//						
//						app_wdf_data <= wr_data;
//						app_wdf_wren <= 1;
//						burst_indicator <= ~burst_indicator;
//					end else begin
//						app_wdf_data <= 0;
//						app_wdf_wren <= 0;
//						app_af_wren <= 0;
//						app_af_addr <= 0;
//					end
				end
				S2: begin
					if(rd_ready == 1) begin
						app_wdf_data <= 0;
						app_wdf_wren <= 0;
						mem_get_data1 <= 0;
						
						if(rd_offset_addr > max_offset) begin
							pattern_read_done1 <= 1;
							app_af_addr <= 0;
							app_af_wren <= 0;
						end else begin
							app_af_addr <= {rd_pattern_id, rd_offset_addr, 2'd0};
							app_af_cmd <= READ;
							app_af_wren <= 1;
							//change how address is incremented dependent on fs state defined in dmd trigger control
							rd_offset_addr <= rd_offset_addr + 1;
							pattern_read_done1 <= 0;
						end
					end else begin
						app_af_wren <= 0;
					end
				end
				default: begin
					app_wdf_data <= 0;
					app_wdf_wren <= 0;
					app_af_wren <= 0;
					app_af_addr <= 0;
					mem_get_data1 <= 0;
					pattern_read_done1 <= 0;
				end
			endcase
		end
	end
	
	always@(posedge clk0) begin
		if(rst0 == 1) begin
			pattern_read_done_q1 <= 0;
			rd_pattern_id <= 0;
		end else begin
			pattern_read_done_q1 <= pattern_read_done1;
			if(pattern_read_done1 == 1 && pattern_read_done_q1 == 0) begin
				if (rd_pattern_id >= num_patterns)
					rd_pattern_id <= 0;
				else
					rd_pattern_id <= rd_pattern_id + 1;
			end
		end
	end
	
//	always@(posedge clk0) begin
//		if(rst0 == 1) begin
//			rd_data_fifo_out_1q <= 0;
//			rd_ab_fifo_wren <= 0;
//			rd_cd_fifo_wren <= 0;
//		end else begin
//			if(rd_data_valid == 1) begin
//				rd_data_fifo_out_1q <= rd_data_fifo_out;
//				rd_ab_fifo_wren <= 1;
//			end else begin
//				rd_data_fifo_out_1q <= 0;
//				rd_ab_fifo_wren <= 0;
//			end
//		end
//	end	
	
//	always@(posedge clk0) begin
//		if(rst0 == 1) begin
//			dmd_1080p_connected_1q <= 0;
//			dmd_1080p_connected_2q <= 0;
//		end else begin
//			dmd_1080p_connected_1q <= dmd_1080p_connected;
//			dmd_1080p_connected_2q <= dmd_1080p_connected_1q;
//		end
//	end
	assign dmd_1080p_connected_2q = 0;
	//test only
//	reg[12:0] data_read_count;
//	always@(posedge clk0) begin
//		if(rst0 == 1) begin
//			rd_ab_fifo_wren <= 0;
//			rd_cd_fifo_wren <= 0;
//			mem_data_in_count <= 0;
//			data_read_count <= 13'd0;
//			rd_data_fifo_out_1q <= 0;
//		end else begin
//			if(rd_data_valid == 1) begin
//				rd_data_fifo_out_1q <= rd_data_fifo_out;
//				rd_ab_fifo_wren <= 1;
////				if(dmd_1080p_connected_2q == 1) begin
////					mem_data_in_count <= mem_data_in_count + 1;
////					if(mem_data_in_count <= 7'h3b) begin
////						rd_ab_fifo_wren <= 1;
////						rd_cd_fifo_wren <= 0;
////					end else if(mem_data_in_count <= 7'h76) begin
////						rd_ab_fifo_wren <= 0;
////						rd_cd_fifo_wren <= 1;
////					end else begin
////						mem_data_in_count <= 0;
////					end
////				end else begin
////					rd_ab_fifo_wren <= 1;
////				end					
//			end else begin
//				rd_ab_fifo_wren <= 0;
//				rd_cd_fifo_wren <= 0;
//				rd_data_fifo_out_1q <= 0;
//			end
//		end
//	end

	reg[13:0] rd_data_count;
	always@(posedge clk0) begin
		if(rst0 == 1) begin
			rd_data_fifo_out_1q <= 0;
			rd_ab_fifo_wren <= 0;
			rd_cd_fifo_wren <= 0;
			rd_data_count <= 0;
		end else begin
			if (rd_data_valid == 1) begin
				rd_data_count <= rd_data_count + 1;
				
				//[TODO] arbitrary number area
				if (rd_data_count > 0 && rd_data_count < 14'd6145) begin
					rd_ab_fifo_wren <= 1;
					rd_data_fifo_out_1q <= rd_data_fifo_out;
					//rd_data_fifo_out_1q <= {64'd0, 64'hffffffffffffffff};
				end else begin
					rd_data_fifo_out_1q <= 0;
					rd_ab_fifo_wren <= 0;
				end
			end else begin
				rd_data_fifo_out_1q <= 0;
				rd_ab_fifo_wren <= 0;
			end
			if (current_state == S0 && rd_data_count >= 14'd6145) begin
				rd_data_count <= 0;
			end
		end
	end
	reg mem_preload_done_3q;
	always@(posedge clk0) begin
		if(rst0 == 1) begin
			mem_preload_done_3q <= 0;
		end else begin
			mem_preload_done_3q <= mem_preload_done1;
		end
	end
	always@(posedge system_clk) begin
		if(system_reset == 1) begin
			mem_preload_done_1q <= 0;
			mem_preload_done_2q <= 0;
		end else begin
			mem_preload_done_1q <= mem_preload_done_3q;
			mem_preload_done_2q <= mem_preload_done_1q;
		end
	end
	
	assign wr_ready = ~(app_af_afull || app_wdf_afull);
	assign rd_ready = ~(app_af_afull || rd_ab_fifo_afull || rd_cd_fifo_afull);
//	assign rd_ready = ~app_af_afull;
	assign mem_preload_done = mem_preload_done_1q & mem_preload_done_2q;
	assign rd_ab_fifo_valid = ~rd_ab_fifo_empty;
	assign rd_cd_fifo_valid = ~rd_cd_fifo_empty;
	assign mem_get_data = mem_get_data1;
	assign clk0 = mem_clk2x;
	assign mem_init_done = phy_init_done;
	
					
endmodule
