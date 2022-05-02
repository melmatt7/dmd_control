`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:43:59 04/27/2021
// Design Name:   appsfpga
// Module Name:   /home/ise/Documents/APPSFPGA_DDR2/src/sim/appsfpga_tb.v
// Project Name:  APPSFPGA_DDR2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: appsfpga
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`define x1Gb
`define sg3
`define x8
module appsfpga_tb;

// memory controller parameters
   parameter BANK_WIDTH            = 3;      // # of memory bank addr bits
   parameter CKE_WIDTH             = 2;      // # of memory clock enable outputs
   parameter CLK_WIDTH             = 2;      // # of clock outputs
   parameter CLK_TYPE              = "SINGLE_ENDED";       // # of clock type
   parameter COL_WIDTH             = 10;     // # of memory column bits
   parameter CS_NUM                = 2;      // # of separate memory chip selects
   parameter CS_WIDTH              = 2;      // # of total memory chip selects
   parameter CS_BITS               = 1;      // set to log2(CS_NUM) (rounded up)
   parameter DM_WIDTH              = 8;      // # of data mask bits
   parameter DQ_WIDTH              = 64;      // # of data width
   parameter DQ_PER_DQS            = 8;      // # of DQ data bits per strobe
   parameter DQS_WIDTH             = 8;      // # of DQS strobes
   parameter DQ_BITS               = 6;      // set to log2(DQS_WIDTH*DQ_PER_DQS)
   parameter DQS_BITS              = 3;      // set to log2(DQS_WIDTH)
   parameter HIGH_PERFORMANCE_MODE = "TRUE"; // Sets the performance mode for IODELAY elements
   parameter ODT_WIDTH             = 2;      // # of memory on-die term enables
   parameter ROW_WIDTH             = 14;     // # of memory row & # of addr bits
   parameter APPDATA_WIDTH         = 128;     // # of usr read/write data bus bits
   parameter ADDITIVE_LAT          = 0;      // additive write latency
   parameter BURST_LEN             = 4;      // burst length (in double words)
   parameter BURST_TYPE            = 0;      // burst type (=0 seq; =1 interlved)
   parameter CAS_LAT               = 3;      // CAS latency
   parameter ECC_ENABLE            = 0;      // enable ECC (=1 enable)
   parameter MULTI_BANK_EN         = 1;      // enable bank management
   parameter TWO_T_TIME_EN         = 1;      // 2t timing for unbuffered dimms
   parameter ODT_TYPE              = 1;      // ODT (=0(none),=1(75),=2(150),=3(50))
   parameter REDUCE_DRV            = 0;      // reduced strength mem I/O (=1 yes)
   parameter REG_ENABLE            = 0;      // registered addr/ctrl (=1 yes)
   parameter TREFI_NS              = 7800;   // auto refresh interval (ns)
   parameter TRAS                  = 40000;  // active->precharge delay
   parameter TRCD                  = 15000;  // active->read/write delay
   parameter TRFC                  = 127500;  // ref->ref, ref->active delay
   parameter TRP                   = 15000;  // precharge->command delay
   parameter TRTP                  = 7500;   // read->precharge delay
   parameter TWR                   = 15000;  // used to determine wr->prech
   parameter TWTR                  = 7500;   // write->read delay
   parameter SIM_ONLY              = 1;      // = 0 to allow power up delay
   parameter DEBUG_EN              = 0;      // Enable debug signals/controls
   parameter RST_ACT_LOW           = 1;      // =1 for active low reset, =0 for active high
   parameter DLL_FREQ_MODE         = "HIGH"; // DCM Frequency range
   parameter CLK_PERIOD            = 6666;   // Core/Mem clk period (in ps)

   localparam DEVICE_WIDTH    = 8;      // Memory device data width
   localparam real CLK_PERIOD_NS   = CLK_PERIOD / 1000.0;
   localparam real TCYC_200           = 5.0;
   localparam real TPROP_DQS          = 0.01;  // Delay for DQS signal during Write Operation
   localparam real TPROP_DQS_RD       = 0.01;  // Delay for DQS signal during Read Operation
   localparam real TPROP_PCB_CTRL     = 0.01;  // Delay for Address and Ctrl signals
   localparam real TPROP_PCB_DATA     = 0.01;  // Delay for data signal during Write operation
   localparam real TPROP_PCB_DATA_RD  = 0.01;  // Delay for data signal during Read operation

	// Inputs
	reg clk_i;
	reg reset_i;
	reg [2:0] ddc_version_i;
	reg [3:0] dmd_type_i;
	reg apps_cntl_an;
	reg apps_cntl_ap;
	reg clk_usb;
	reg ctl0;
	reg ctl1;
	reg ctl2;
	reg [2:0] gpioa_i;
	reg gpio_ext_rest_in;
	reg in_rst_active_i;
	reg in_init_active_i;
	reg [7:0] in_dip_sw_i;
	reg in_pb_sw_i;
	reg apps_logic_rstn;
	reg trigger;

	// Outputs
	wire finished_iv_o;
	wire arstz_o;
	wire clk_r_o;
	wire [15:0] dout_ap_o;
	wire [15:0] dout_an_o;
	wire [15:0] dout_bp_o;
	wire [15:0] dout_bn_o;
	wire [15:0] dout_cp_o;
	wire [15:0] dout_cn_o;
	wire [15:0] dout_dp_o;
	wire [15:0] dout_dn_o;
	wire dclk_ap_o;
	wire dclk_an_o;
	wire dclk_bp_o;
	wire dclk_bn_o;
	wire dclk_cp_o;
	wire dclk_cn_o;
	wire dclk_dp_o;
	wire dclk_dn_o;
	wire dvalid_ap_o;
	wire dvalid_an_o;
	wire dvalid_bp_o;
	wire dvalid_bn_o;
	wire dvalid_cp_o;
	wire dvalid_cn_o;
	wire dvalid_dp_o;
	wire dvalid_dn_o;
	wire [1:0] rowmd_o;
	wire [10:0] rowad_o;
	wire stepvcc_o;
	wire comp_data_o;
	wire ns_flip_o;
	wire [3:0] blkad_o;
	wire [1:0] blkmd_o;
	wire wdt_enablez_o;
	wire pwr_floatz_o;
	wire rst2blkz_o;
	wire ddcspare0;
	wire rdy0;
	wire rdy1;
	wire rdy2;
	wire [2:0] gpioa_o;
	wire gpio_reset_complete_o;
	wire [30:0] apps_testpt;

	// Bidirs
	wire [15:0] bidir;
	
	// ddr2 signals
	wire mem_init_done;
	wire mem_read_ready;
   wire [DQ_WIDTH-1:0]          ddr2_dq_sdram;
   wire [DQS_WIDTH-1:0]         ddr2_dqs_sdram;
   wire [DQS_WIDTH-1:0]         ddr2_dqs_n_sdram;
   wire [DM_WIDTH-1:0]          ddr2_dm_sdram;
   reg [DM_WIDTH-1:0]           ddr2_dm_sdram_tmp;
   reg [CLK_WIDTH-1:0]          ddr2_clk_sdram;
   reg [CLK_WIDTH-1:0]          ddr2_clk_n_sdram;
   reg [ROW_WIDTH-1:0]          ddr2_address_sdram;
   reg [BANK_WIDTH-1:0]         ddr2_ba_sdram;
   reg                          ddr2_ras_n_sdram;
   reg                          ddr2_cas_n_sdram;
   reg                          ddr2_we_n_sdram;
   reg [CS_WIDTH-1:0]           ddr2_cs_n_sdram;
   reg [CKE_WIDTH-1:0]          ddr2_cke_sdram;
   reg [ODT_WIDTH-1:0]          ddr2_odt_sdram;


   wire [DQ_WIDTH-1:0]          ddr2_dq_fpga;
   wire [DQS_WIDTH-1:0]         ddr2_dqs_fpga;
   wire [DQS_WIDTH-1:0]         ddr2_dqs_n_fpga;
   wire [DM_WIDTH-1:0]          ddr2_dm_fpga;
   wire [CLK_WIDTH-1:0]         ddr2_clk_fpga;
   wire [CLK_WIDTH-1:0]         ddr2_clk_n_fpga;
   wire [ROW_WIDTH-1:0]         ddr2_address_fpga;
   wire [BANK_WIDTH-1:0]        ddr2_ba_fpga;
   wire                         ddr2_ras_n_fpga;
   wire                         ddr2_cas_n_fpga;
   wire                         ddr2_we_n_fpga;
   wire [CS_WIDTH-1:0]          ddr2_cs_n_fpga;
   wire [CKE_WIDTH-1:0]         ddr2_cke_fpga;
   wire [ODT_WIDTH-1:0]         ddr2_odt_fpga;
	
   // Only RDIMM memory parts support the reset signal,
   // hence the ddr2_reset_n signal can be ignored for other memory parts
   wire                          ddr2_reset_n;
   reg [ROW_WIDTH-1:0]           ddr2_address_reg;
   reg [BANK_WIDTH-1:0]          ddr2_ba_reg;
   reg [CKE_WIDTH-1:0]           ddr2_cke_reg;
   reg                           ddr2_ras_n_reg;
   reg                           ddr2_cas_n_reg;
   reg                           ddr2_we_n_reg;
   reg [CS_WIDTH-1:0]            ddr2_cs_n_reg;
   reg [ODT_WIDTH-1:0]           ddr2_odt_reg;


	// Instantiate the Unit Under Test (UUT)
	appsfpga uut (
		.clk_i(clk_i), 
		.reset_i(reset_i), 
		.finished_iv_o(finished_iv_o), 
		.arstz_o(arstz_o), 
		.clk_r_o(clk_r_o), 
		.dout_ap_o(dout_ap_o), 
		.dout_an_o(dout_an_o), 
		.dout_bp_o(dout_bp_o), 
		.dout_bn_o(dout_bn_o), 
		.dout_cp_o(dout_cp_o), 
		.dout_cn_o(dout_cn_o), 
		.dout_dp_o(dout_dp_o), 
		.dout_dn_o(dout_dn_o), 
		.dclk_ap_o(dclk_ap_o), 
		.dclk_an_o(dclk_an_o), 
		.dclk_bp_o(dclk_bp_o), 
		.dclk_bn_o(dclk_bn_o), 
		.dclk_cp_o(dclk_cp_o), 
		.dclk_cn_o(dclk_cn_o), 
		.dclk_dp_o(dclk_dp_o), 
		.dclk_dn_o(dclk_dn_o), 
		.dvalid_ap_o(dvalid_ap_o), 
		.dvalid_an_o(dvalid_an_o), 
		.dvalid_bp_o(dvalid_bp_o), 
		.dvalid_bn_o(dvalid_bn_o), 
		.dvalid_cp_o(dvalid_cp_o), 
		.dvalid_cn_o(dvalid_cn_o), 
		.dvalid_dp_o(dvalid_dp_o), 
		.dvalid_dn_o(dvalid_dn_o), 
		.rowmd_o(rowmd_o), 
		.rowad_o(rowad_o), 
		.stepvcc_o(stepvcc_o), 
		.comp_data_o(comp_data_o), 
		.ns_flip_o(ns_flip_o), 
		.blkad_o(blkad_o), 
		.blkmd_o(blkmd_o), 
		.wdt_enablez_o(wdt_enablez_o), 
		.ddc_version_i(ddc_version_i), 
		.dmd_type_i(dmd_type_i), 
		.pwr_floatz_o(pwr_floatz_o), 
		.apps_cntl_an(apps_cntl_an), 
		.apps_cntl_ap(apps_cntl_ap), 
		.rst2blkz_o(rst2blkz_o), 
		.ddcspare0(ddcspare0), 
		.clk_usb(clk_usb), 
		.rdy0(rdy0), 
		.rdy1(rdy1), 
		.rdy2(rdy2), 
		.ctl0(ctl0), 
		.ctl1(ctl1), 
		.ctl2(ctl2), 
		.gpioa_o(gpioa_o), 
		.gpioa_i({trigger, gpioa_i[1:0]}), 
		.gpio_ext_rest_in(gpio_ext_rest_in), 
		.gpio_reset_complete_o(gpio_reset_complete_o), 
		.bidir(bidir), 
		.ddr2_a(ddr2_address_fpga), 
		.ddr2_ba(ddr2_ba_fpga), 
		.ddr2_ras_n(ddr2_ras_n_fpga), 
		.ddr2_cas_n(ddr2_cas_n_fpga), 
		.ddr2_we_n(ddr2_we_n_fpga), 
		.ddr2_cs_n(ddr2_cs_n_fpga), 
		.ddr2_odt(ddr2_odt_fpga), 
		.ddr2_cke(ddr2_cke_fpga), 
		.ddr2_ck(ddr2_clk_fpga), 
		.ddr2_ck_n(ddr2_clk_n_fpga), 
		.ddr2_dq(ddr2_dq_fpga), 
		.ddr2_dqs(ddr2_dqs_fpga), 
		.ddr2_dqs_n(ddr2_dqs_n_fpga), 
		.ddr2_dm(ddr2_dm_fpga), 
		.led0(mem_init_done),
		.led1(mem_read_ready),
		.in_rst_active_i(in_rst_active_i), 
		.in_init_active_i(in_init_active_i), 
		.in_dip_sw_i(in_dip_sw_i), 
		.in_pb_sw_i(in_pb_sw_i), 
		.apps_logic_rstn(apps_logic_rstn), 
		.apps_testpt(apps_testpt) 
//		.trigger(trigger)
	);
	parameter SYS_CLK_PERIOD = 20;
	parameter USB_CLK_PERIOD = 20.83;
	// 768*1024/128=49152
	reg [15:0] pattern1[49152:1];
	reg [15:0] pattern2[49152:1];
	reg [15:0] pattern3[49152:1];
	reg [15:0] usb_data_in;
	wire [15:0] usb_data_out;
	assign bidir = (ctl1 == 1) ? usb_data_in : 16'dz;
	assign usb_data_out = (ctl1 == 0) ? bidir : 16'dz;
//	assign bidir = 16'd44;
	
	reg [31:0] count;
	reg [3:0] pattern_id;
	reg pattern_write_en;

	
	//system clock
	initial begin
		clk_i = 0;
		forever
		#(SYS_CLK_PERIOD/2) clk_i = ~clk_i;
	end
	
	//usb clock
	initial begin
		clk_usb = 0;
		forever
		#(USB_CLK_PERIOD/2) clk_usb = ~clk_usb;
	end
	
	task reset_task;
	input[15:0] reset_time;
	begin
		reset_i = 1;
		gpio_ext_rest_in = 1;
		#reset_time;
		reset_i = 0;
		gpio_ext_rest_in = 0;
	end
	endtask
	
	task pattern_write_task;
	input [15:0] data_in;
	begin
		usb_data_in = data_in;
		ctl0 = 0;
		ctl1 = 1;
		ctl2 = 1;
		#USB_CLK_PERIOD;
	end
	endtask

	task reg_addr_write_task;
	input [15:0] data_in;
	begin
		ctl0 = 1;
		ctl1 = 1;
		ctl2 = 0;
		usb_data_in = data_in;
		#USB_CLK_PERIOD;
		ctl0 = 0;
		ctl1 = 0;
		ctl2 = 0;
	end
	endtask
	
	task reg_data_write_task;
	input [15:0] data_in;
	begin
		ctl0 = 0;
		ctl1 = 1;
		ctl2 = 0;
		usb_data_in = data_in;
		#USB_CLK_PERIOD;
		ctl0 = 0;
		ctl1 = 0;
		ctl2 = 0;
	end
	endtask
	
	task trigger_gen_task;
	begin
		trigger = 1;
		#50;
		trigger = 0;
	end
	endtask
	
	//task output_compare_task;
	//begin
	
	
	//load test patterns from files
	initial begin
		$readmemb("/home/ise/Desktop/APPSFPGA_DDR2/src/sim/new_pattern_1.txt", pattern1);
		$readmemb("/home/ise/Desktop/APPSFPGA_DDR2/src/sim/new_pattern_2.txt", pattern2);
		$readmemb("/home/ise/Desktop/APPSFPGA_DDR2/src/sim/new_pattern_3.txt", pattern3);
	end
	
	// test pattern write
	always@(posedge clk_usb) begin
		if (reset_i == 1) begin
			ctl0 <= 0;
			ctl1 <= 0;
			ctl2 <= 0;
			usb_data_in <= 16'd0;
			count <= 0;
			pattern_id <= 0;
			pattern_write_en <= 1;
		end else if (pattern_write_en == 1 && mem_init_done == 1) begin
			ctl0 <= 0;
			ctl1 <= 1;
			ctl2 <= 1;
			count <= count + 1;
			
			case (pattern_id)
				4'd0 : usb_data_in <= pattern1[count];
				4'd1 : usb_data_in <= pattern2[count];
				4'd2 : usb_data_in <= pattern3[count];
				default : usb_data_in <= 16'dz;
			endcase
			
			if (count == 32'd49152) begin
				pattern_id <= pattern_id + 1;
				count <= 0;
			end
			
			if (pattern_id == 4'd3)
				pattern_write_en <= 0;
		end else begin
			usb_data_in <= 16'dz;
			ctl0 <= 0;
			ctl1 <= 0;
			ctl2 <= 0;
		end
	end
	
	//stimulius
	initial begin
		// Initialize Inputs
		ddc_version_i = 3'b110;
		dmd_type_i = 4'b0001; //XGA
		apps_cntl_an = 0; //unused
		apps_cntl_ap = 0; //unused
		ctl0 = 0;
		ctl1 = 0;
		ctl2 = 0;
		gpioa_i = 0;
		gpio_ext_rest_in = 1;
		in_rst_active_i = 0;
		in_init_active_i = 1;
		in_dip_sw_i = 8'd0; //switches
		in_pb_sw_i = 0; //push buttons
		apps_logic_rstn = 0; //reset push button capture
		trigger = 0;
		
		//reset system for 100ns
		reset_task(100);
		$display("system reset done @ %t", $time);
		
		//memory read write fifo reset
		reg_data_write_task(16'd3);
		reg_addr_write_task(16'd31);
		#50;
		reg_data_write_task(16'd0);
		reg_addr_write_task(16'd31);
		$display("memory fifo reset done @ %t", $time);
		
		//control data and address
		// number of patterns (3)
		reg_data_write_task(16'd2);
		reg_addr_write_task(16'd30);
		$display("number of pattern write done @ %t", $time);
		#50;
		// memory mode enable
		reg_data_write_task(16'd1);
		reg_addr_write_task(16'd32);
		$display("memory enable write done @ %t", $time);
		#50;
		// memory mode enable
		reg_data_write_task(16'd0);
		reg_addr_write_task(16'd24);
		$display("memory enable write done @ %t", $time);
		
		// test patterns write
//		fork : wait_mem_init
//			begin
//				#10000;
//				disable wait_mem_init;
//			end
//			begin
//				@(posedge mem_init_done);
//				disable wait_mem_init;
//			end
//		join

		// clock the input
//		count = 0;
//		repeat(49152)
//		begin
//			count = count + 1;
//			pattern_write_task(pattern1[count]);
//		end
//		$display("test pattern 1 write done @ %t", $time);
//		
//		count = 0;
//		repeat(49152)
//		begin
//			count = count + 1;
//			pattern_write_task(pattern2[count]);
//		end
//		$display("test pattern 2 write done @ %t", $time);
//		
//		count = 0;
//		repeat(49152)
//		begin
//			count = count + 1;
//			pattern_write_task(pattern3[count]);
//		end
//		$display("test pattern 3 write done @ %t", $time);
		
		ctl0 = 0;
		ctl1 = 0;
		ctl2 = 0;

		//trigger puls generation for next pattern reading
//		fork : wait_mem_ready
//			begin
//				#10000;
//				disable wait_mem_ready;
//			end
//			begin
//				@(posedge mem_read_ready);
//				disable wait_mem_ready;
//			end
//		join
		
		// read pattern 1
		trigger_gen_task();
		#100000;
		
		// read pattern 2
		trigger_gen_task();
		#100000;
		
		// read pattern 3
		trigger_gen_task();
		#100000;
		
		// read pattern 1
		trigger_gen_task();
		#100000;
	end
	
	
// =============================================================================
//                             BOARD Parameters
// =============================================================================
// These parameter values can be changed to model varying board delays
// between the Virtex-5 device and the memory model


  always @( * ) begin
    ddr2_clk_sdram        <=  #(TPROP_PCB_CTRL) ddr2_clk_fpga;
    ddr2_clk_n_sdram      <=  #(TPROP_PCB_CTRL) ddr2_clk_n_fpga;
    ddr2_address_sdram    <=  #(TPROP_PCB_CTRL) ddr2_address_fpga;
    ddr2_ba_sdram         <=  #(TPROP_PCB_CTRL) ddr2_ba_fpga;
    ddr2_ras_n_sdram      <=  #(TPROP_PCB_CTRL) ddr2_ras_n_fpga;
    ddr2_cas_n_sdram      <=  #(TPROP_PCB_CTRL) ddr2_cas_n_fpga;
    ddr2_we_n_sdram       <=  #(TPROP_PCB_CTRL) ddr2_we_n_fpga;
    ddr2_cs_n_sdram       <=  #(TPROP_PCB_CTRL) ddr2_cs_n_fpga;
    ddr2_cke_sdram        <=  #(TPROP_PCB_CTRL) ddr2_cke_fpga;
    ddr2_odt_sdram        <=  #(TPROP_PCB_CTRL) ddr2_odt_fpga;
    ddr2_dm_sdram_tmp     <=  #(TPROP_PCB_DATA) ddr2_dm_fpga;//DM signal generation
  end

  assign ddr2_dm_sdram = ddr2_dm_sdram_tmp;


// Controlling the bi-directional BUS
  genvar dqwd;
  generate
    for (dqwd = 0;dqwd < DQ_WIDTH;dqwd = dqwd+1) begin : dq_delay
      WireDelay #
       (
        .Delay_g     (TPROP_PCB_DATA),
        .Delay_rd    (TPROP_PCB_DATA_RD)
       )
      u_delay_dq
       (
        .A           (ddr2_dq_fpga[dqwd]),
        .B           (ddr2_dq_sdram[dqwd]),
        .reset       (~reset_i)
       );
    end
  endgenerate

  genvar dqswd;
  generate
    for (dqswd = 0;dqswd < DQS_WIDTH;dqswd = dqswd+1) begin : dqs_delay
      WireDelay #
       (
        .Delay_g     (TPROP_DQS),
        .Delay_rd    (TPROP_DQS_RD)
       )
      u_delay_dqs
       (
        .A           (ddr2_dqs_fpga[dqswd]),
        .B           (ddr2_dqs_sdram[dqswd]),
        .reset       (~reset_i)
       );

      WireDelay #
       (
        .Delay_g     (TPROP_DQS),
        .Delay_rd    (TPROP_DQS_RD)
       )
      u_delay_dqs_n
       (
        .A           (ddr2_dqs_n_fpga[dqswd]),
        .B           (ddr2_dqs_n_sdram[dqswd]),
        .reset       (~reset_i)
       );
    end
  endgenerate
  
   // Extra one clock pipelining for RDIMM address and
   // control signals is implemented here (Implemented external to memory model)
   always @( posedge ddr2_clk_sdram[0] ) begin
      if ( reset_i == 1'b1 ) begin
         ddr2_ras_n_reg    <= 1'b1;
         ddr2_cas_n_reg    <= 1'b1;
         ddr2_we_n_reg     <= 1'b1;
         ddr2_cs_n_reg     <= {CS_WIDTH{1'b1}};
         ddr2_odt_reg      <= 1'b0;
      end
      else begin
         ddr2_address_reg  <= #(CLK_PERIOD_NS/2) ddr2_address_sdram;
         ddr2_ba_reg       <= #(CLK_PERIOD_NS/2) ddr2_ba_sdram;
         ddr2_ras_n_reg    <= #(CLK_PERIOD_NS/2) ddr2_ras_n_sdram;
         ddr2_cas_n_reg    <= #(CLK_PERIOD_NS/2) ddr2_cas_n_sdram;
         ddr2_we_n_reg     <= #(CLK_PERIOD_NS/2) ddr2_we_n_sdram;
         ddr2_cs_n_reg     <= #(CLK_PERIOD_NS/2) ddr2_cs_n_sdram;
         ddr2_odt_reg      <= #(CLK_PERIOD_NS/2) ddr2_odt_sdram;
      end
   end

   // to avoid tIS violations on CKE when reset is deasserted
   always @( posedge ddr2_clk_n_sdram[0] )
      if ( reset_i == 1'b1 )
         ddr2_cke_reg      <= 1'b0;
      else
         ddr2_cke_reg      <= #(CLK_PERIOD_NS) ddr2_cke_sdram;
   //***************************************************************************
   // Memory model instances
   //***************************************************************************
   
   genvar i, j;
   generate
      if (DEVICE_WIDTH == 16) begin
         // if memory part is x16
         if ( REG_ENABLE ) begin
           // if the memory part is Registered DIMM
           for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
             for(i = 0; i < DQS_WIDTH/2; i = i+1) begin : gen
                ddr2_model u_mem0
                  (
                   .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                   .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                   .cke       (ddr2_cke_reg[j]),
                   .cs_n      (ddr2_cs_n_reg[j]),
                   .ras_n     (ddr2_ras_n_reg),
                   .cas_n     (ddr2_cas_n_reg),
                   .we_n      (ddr2_we_n_reg),
                   .dm_rdqs   (ddr2_dm_sdram[(2*(i+1))-1 : i*2]),
                   .ba        (ddr2_ba_reg),
                   .addr      (ddr2_address_reg),
                   .dq        (ddr2_dq_sdram[(16*(i+1))-1 : i*16]),
                   .dqs       (ddr2_dqs_sdram[(2*(i+1))-1 : i*2]),
                   .dqs_n     (ddr2_dqs_n_sdram[(2*(i+1))-1 : i*2]),
                   .rdqs_n    (),
                   .odt       (ddr2_odt_reg[j])
                   );
             end
           end
         end
         else begin
             // if the memory part is component or unbuffered DIMM
            if ( DQ_WIDTH%16 ) begin
              // for the memory part x16, if the data width is not multiple
              // of 16, memory models are instantiated for all data with x16
              // memory model and except for MSB data. For the MSB data
              // of 8 bits, all memory data, strobe and mask data signals are
              // replicated to make it as x16 part. For example if the design
              // is generated for data width of 72, memory model x16 parts
              // instantiated for 4 times with data ranging from 0 to 63.
              // For MSB data ranging from 64 to 71, one x16 memory model
              // by replicating the 8-bit data twice and similarly
              // the case with data mask and strobe.
              for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
                for(i = 0; i < DQ_WIDTH/16 ; i = i+1) begin : gen
                   ddr2_model u_mem0
                     (
                      .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                     .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                      .cke       (ddr2_cke_sdram[j]),
                      .cs_n      (ddr2_cs_n_sdram[j]),
                      .ras_n     (ddr2_ras_n_sdram),
                      .cas_n     (ddr2_cas_n_sdram),
                      .we_n      (ddr2_we_n_sdram),
                      .dm_rdqs   (ddr2_dm_sdram[(2*(i+1))-1 : i*2]),
                      .ba        (ddr2_ba_sdram),
                      .addr      (ddr2_address_sdram),
                      .dq        (ddr2_dq_sdram[(16*(i+1))-1 : i*16]),
                      .dqs       (ddr2_dqs_sdram[(2*(i+1))-1 : i*2]),
                      .dqs_n     (ddr2_dqs_n_sdram[(2*(i+1))-1 : i*2]),
                      .rdqs_n    (),
                      .odt       (ddr2_odt_sdram[j])
                      );
                end
                   ddr2_model u_mem1
                     (
                      .ck        (ddr2_clk_sdram[CLK_WIDTH-1]),
                      .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH-1]),
                      .cke       (ddr2_cke_sdram[j]),
                      .cs_n      (ddr2_cs_n_sdram[j]),
                      .ras_n     (ddr2_ras_n_sdram),
                      .cas_n     (ddr2_cas_n_sdram),
                      .we_n      (ddr2_we_n_sdram),
                      .dm_rdqs   ({ddr2_dm_sdram[DM_WIDTH - 1],
                                   ddr2_dm_sdram[DM_WIDTH - 1]}),
                      .ba        (ddr2_ba_sdram),
                      .addr      (ddr2_address_sdram),
                      .dq        ({ddr2_dq_sdram[DQ_WIDTH - 1 : DQ_WIDTH - 8],
                                   ddr2_dq_sdram[DQ_WIDTH - 1 : DQ_WIDTH - 8]}),
                      .dqs       ({ddr2_dqs_sdram[DQS_WIDTH - 1],
                                   ddr2_dqs_sdram[DQS_WIDTH - 1]}),
                      .dqs_n     ({ddr2_dqs_n_sdram[DQS_WIDTH - 1],
                                   ddr2_dqs_n_sdram[DQS_WIDTH - 1]}),
                      .rdqs_n    (),
                      .odt       (ddr2_odt_sdram[j])
                      );
              end
            end
            else begin
              // if the data width is multiple of 16
              for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
                for(i = 0; i < DQS_WIDTH/2; i = i+1) begin : gen
                   ddr2_model u_mem0
                     (
                      .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                     .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                      .cke       (ddr2_cke_sdram[j]),
                      .cs_n      (ddr2_cs_n_sdram[j]),
                      .ras_n     (ddr2_ras_n_sdram),
                      .cas_n     (ddr2_cas_n_sdram),
                      .we_n      (ddr2_we_n_sdram),
                      .dm_rdqs   (ddr2_dm_sdram[(2*(i+1))-1 : i*2]),
                      .ba        (ddr2_ba_sdram),
                      .addr      (ddr2_address_sdram),
                      .dq        (ddr2_dq_sdram[(16*(i+1))-1 : i*16]),
                      .dqs       (ddr2_dqs_sdram[(2*(i+1))-1 : i*2]),
                      .dqs_n     (ddr2_dqs_n_sdram[(2*(i+1))-1 : i*2]),
                      .rdqs_n    (),
                      .odt       (ddr2_odt_sdram[j])
                      );
                end
              end
            end
         end

      end else
        if (DEVICE_WIDTH == 8) begin
           // if the memory part is x8
           if ( REG_ENABLE ) begin
             // if the memory part is Registered DIMM
             for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
               for(i = 0; i < DQ_WIDTH/DQ_PER_DQS; i = i+1) begin : gen
                  ddr2_model u_mem0
                    (
                     .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                     .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                     .cke       (ddr2_cke_reg[j]),
                     .cs_n      (ddr2_cs_n_reg[j]),
                     .ras_n     (ddr2_ras_n_reg),
                     .cas_n     (ddr2_cas_n_reg),
                     .we_n      (ddr2_we_n_reg),
                     .dm_rdqs   (ddr2_dm_sdram[i]),
                     .ba        (ddr2_ba_reg),
                     .addr      (ddr2_address_reg),
                     .dq        (ddr2_dq_sdram[(8*(i+1))-1 : i*8]),
                     .dqs       (ddr2_dqs_sdram[i]),
                     .dqs_n     (ddr2_dqs_n_sdram[i]),
                     .rdqs_n    (),
                     .odt       (ddr2_odt_reg[j])
                     );
               end
             end
           end
           else begin
             // if the memory part is component or unbuffered DIMM
             for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
               for(i = 0; i < DQS_WIDTH; i = i+1) begin : gen
                  ddr2_model u_mem0
                    (
                     .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                    .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                     .cke       (ddr2_cke_sdram[j]),
                     .cs_n      (ddr2_cs_n_sdram[j]),
                     .ras_n     (ddr2_ras_n_sdram),
                     .cas_n     (ddr2_cas_n_sdram),
                     .we_n      (ddr2_we_n_sdram),
                     .dm_rdqs   (ddr2_dm_sdram[i]),
                     .ba        (ddr2_ba_sdram),
                     .addr      (ddr2_address_sdram),
                     .dq        (ddr2_dq_sdram[(8*(i+1))-1 : i*8]),
                     .dqs       (ddr2_dqs_sdram[i]),
                     .dqs_n     (ddr2_dqs_n_sdram[i]),
                     .rdqs_n    (),
                     .odt       (ddr2_odt_sdram[j])
                     );
               end
             end
           end

        end else
          if (DEVICE_WIDTH == 4) begin
             // if the memory part is x4
             if ( REG_ENABLE ) begin
               // if the memory part is Registered DIMM
               for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
                  for(i = 0; i < DQS_WIDTH; i = i+1) begin : gen
                     ddr2_model u_mem0
                       (
                        .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                        .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                        .cke       (ddr2_cke_reg[j]),
                        .cs_n      (ddr2_cs_n_reg[j]),
                        .ras_n     (ddr2_ras_n_reg),
                        .cas_n     (ddr2_cas_n_reg),
                        .we_n      (ddr2_we_n_reg),
                        .dm_rdqs   (ddr2_dm_sdram[i]),
                        .ba        (ddr2_ba_reg),
                        .addr      (ddr2_address_reg),
                        .dq        (ddr2_dq_sdram[(4*(i+1))-1 : i*4]),
                        .dqs       (ddr2_dqs_sdram[i]),
                        .dqs_n     (ddr2_dqs_n_sdram[i]),
                        .rdqs_n    (),
                        .odt       (ddr2_odt_reg[j])
                        );
                  end
               end
             end
             else begin
               // if the memory part is component or unbuffered DIMM
               for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
                 for(i = 0; i < DQS_WIDTH; i = i+1) begin : gen
                    ddr2_model u_mem0
                      (
                       .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                      .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                       .cke       (ddr2_cke_sdram[j]),
                       .cs_n      (ddr2_cs_n_sdram[j]),
                       .ras_n     (ddr2_ras_n_sdram),
                       .cas_n     (ddr2_cas_n_sdram),
                       .we_n      (ddr2_we_n_sdram),
                       .dm_rdqs   (ddr2_dm_sdram[i]),
                       .ba        (ddr2_ba_sdram),
                       .addr      (ddr2_address_sdram),
                       .dq        (ddr2_dq_sdram[(4*(i+1))-1 : i*4]),
                       .dqs       (ddr2_dqs_sdram[i]),
                       .dqs_n     (ddr2_dqs_n_sdram[i]),
                       .rdqs_n    (),
                       .odt       (ddr2_odt_sdram[j])
                       );
                 end
               end
             end
          end
   endgenerate

endmodule

