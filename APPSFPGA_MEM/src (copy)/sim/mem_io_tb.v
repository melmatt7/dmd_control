`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:52:00 05/03/2021
// Design Name:   MEM_IO
// Module Name:   /home/ise/Documents/APPSFPGA_DDR2/src/sim/mem_io_tb.v
// Project Name:  APPSFPGA_DDR2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MEM_IO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//`define x1Gb
//`define sg3
//`define x8

module mem_io_tb;
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

   localparam CLK_PERIOD_INT = CLK_PERIOD/1000;

	// Inputs
	reg system_clk;
	reg system_reset;
	reg mem_locked;
	reg mem_clk200;
	wire mem_clk0;
	wire mem_clk90;
	wire mem_clkdiv0;
	reg [14:0] num_patterns;
	reg dmd_1080p_connected;
	reg [127:0] wr_data;
	reg wr_valid;
	reg dmd_get_data;
	reg [14:0] rd_pattern_id;
	reg mem_read_enable;
	reg mem_rd_fifo_reset;

	// Outputs
	wire mem_preload_done;
	wire mem_clk;
	wire mem_init_done;
	wire mem_get_data;
	wire [127:0] rd_ab_fifo_out;
	wire [127:0] rd_cd_fifo_out;
	wire rd_ab_fifo_valid;
	wire rd_cd_fifo_valid;

   // ddr2 signals
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
	
	reg clk0_bufg;
	reg clk0_bufg_in;
	reg clk90_bufg;
	reg clk90_bufg_in;
	reg clk200_bufg;
	reg clkdiv0_bufg;
	reg clkdiv0_bufg_in;
	reg clk200_ibufg;
	reg clkfbout_clkfbin;
	
	

	// Instantiate the Unit Under Test (UUT)
	MEM_IO uut (
		.system_clk(system_clk), 
		.system_reset(system_reset), 
		.mem_preload_done(mem_preload_done), 
		.mem_locked(mem_locked), 
		.mem_clk200(mem_clk200), 
		.mem_clk0(mem_clk0), 
		.mem_clk90(mem_clk90), 
		.mem_clkdiv0(mem_clkdiv0), 
		.mem_clk(mem_clk), 
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
		.mem_init_done(mem_init_done), 
		.num_patterns(num_patterns), 
		.dmd_1080p_connected(dmd_1080p_connected), 
		.wr_data(wr_data), 
		.wr_valid(wr_valid), 
		.mem_get_data(mem_get_data), 
		.rd_ab_fifo_out(rd_ab_fifo_out), 
		.rd_cd_fifo_out(rd_cd_fifo_out), 
		.dmd_get_data(dmd_get_data), 
		.rd_ab_fifo_valid(rd_ab_fifo_valid), 
		.rd_cd_fifo_valid(rd_cd_fifo_valid), 
		.rd_pattern_id(rd_pattern_id), 
		.mem_read_enable(mem_read_enable), 
		.mem_rd_fifo_reset(mem_rd_fifo_reset)
	);
	initial
		system_clk = 1'b0;
   always
      system_clk = #20 ~system_clk;
	
	initial
		mem_clk200 = 0;
	always
		mem_clk200 = #5 ~mem_clk200;
	
	assign mem_clk0    = clk0_bufg;
	assign mem_clk90   = clk90_bufg;
//	assign mem_clk200  = clk200_bufg;
	assign mem_clkdiv0 = clkdiv0_bufg;
	PLL_ADV #
	  (
		.BANDWIDTH          ("OPTIMIZED"),
		.CLKIN1_PERIOD      (20.000),
		.CLKIN2_PERIOD      (10.000),
		.CLKOUT0_DIVIDE     (3),
		.CLKOUT1_DIVIDE     (3),
		.CLKOUT2_DIVIDE     (6),
		.CLKOUT3_DIVIDE     (8),
		.CLKOUT4_DIVIDE     (8),
		.CLKOUT5_DIVIDE     (8),
		.CLKOUT0_PHASE      (0.000),
		.CLKOUT1_PHASE      (90.000),
		.CLKOUT2_PHASE      (0.000),
		.CLKOUT3_PHASE      (0.000),
		.CLKOUT4_PHASE      (0.000),
		.CLKOUT5_PHASE      (0.000),
		.CLKOUT0_DUTY_CYCLE (0.500),
		.CLKOUT1_DUTY_CYCLE (0.500),
		.CLKOUT2_DUTY_CYCLE (0.500),
		.CLKOUT3_DUTY_CYCLE (0.500),
		.CLKOUT4_DUTY_CYCLE (0.500),
		.CLKOUT5_DUTY_CYCLE (0.500),
		.COMPENSATION       ("SYSTEM_SYNCHRONOUS"),
		.DIVCLK_DIVIDE      (1),
		.CLKFBOUT_MULT      (9),
		.CLKFBOUT_PHASE     (0.0),
		.REF_JITTER         (0.005000)
		)
	  u_pll_adv
		 (
		  .CLKFBIN     (clkfbout_clkfbin),
		  .CLKINSEL    (1'b1),
		  .CLKIN1      (system_clk),
		  .CLKIN2      (1'b0),
		  .DADDR       (5'b0),
		  .DCLK        (1'b0),
		  .DEN         (1'b0),
		  .DI          (16'b0),
		  .DWE         (1'b0),
		  .REL         (1'b0),
		  .RST         (system_reset),
		  .CLKFBDCM    (),
		  .CLKFBOUT    (clkfbout_clkfbin),
		  .CLKOUTDCM0  (),
		  .CLKOUTDCM1  (),
		  .CLKOUTDCM2  (),
		  .CLKOUTDCM3  (),
		  .CLKOUTDCM4  (),
		  .CLKOUTDCM5  (),
		  .CLKOUT0     (clk0_bufg_in),
		  .CLKOUT1     (clk90_bufg_in),
		  .CLKOUT2     (clkdiv0_bufg_in),
		  .CLKOUT3     (),
		  .CLKOUT4     (),
		  .CLKOUT5     (),
		  .DO          (),
		  .DRDY        (),
		  .LOCKED      (locked)
		  );
  BUFG u_bufg_clk0
	 (
	  .O (clk0_bufg),
	  .I (clk0_bufg_in)
	  );

  BUFG u_bufg_clk90
	 (
	  .O (clk90_bufg),
	  .I (clk90_bufg_in)
	  );

//  BUFG u_bufg_clk200
//	 (
//	  .O (clk200_bufg),
//	  .I (clk200_ibufg)
//	  );

	BUFG u_bufg_clkdiv0
	 (
	  .O (clkdiv0_bufg),
	  .I (clkdiv0_bufg_in)
	  );

	initial begin
		// Initialize Inputs
		system_reset = 1;
		num_patterns = 3;
		dmd_1080p_connected = 0;
		wr_data = 0;
		wr_valid = 0;
		dmd_get_data = 0;
		rd_pattern_id = 0;
		mem_read_enable = 0;
		mem_rd_fifo_reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		system_reset = 0;
        
		// Add stimulus here
		wr_data = 128'd45;
		wr_valid = 1;
		

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
        .reset       (system_reset)
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
        .reset       (system_reset)
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
        .reset       (system_reset)
       );
    end
  endgenerate
   // Extra one clock pipelining for RDIMM address and
   // control signals is implemented here (Implemented external to memory model)
   always @( posedge ddr2_clk_sdram[0] ) begin
      if ( ddr2_reset_n == 1'b0 ) begin
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
      if ( ddr2_reset_n == 1'b0 )
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

