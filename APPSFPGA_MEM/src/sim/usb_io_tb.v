`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:20:26 05/16/2021
// Design Name:   USB_IO
// Module Name:   /home/ise/Documents/APPSFPGA_DDR2/usb_io_tb.v
// Project Name:  APPSFPGA_DDR2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: USB_IO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module usb_io_tb;

	// Inputs
	reg ifclk;
	reg system_clk;
	reg mem_clk;
	reg reset_i;
	reg system_reset;
	reg fifo_wen;
	reg fifo_ren;
	reg fifo_regn;
	reg dmd_1080p_connected;
	reg dmd_get_row_data;
	reg dmd_row_fifo_reset;
	reg mem_get_data;
	reg mem_fifo_reset;
	reg [15:0] reg_data_to_usb;
	reg [15:0] usb_din;

	// Outputs
	wire [127:0] fifo_ab_data_out;
	wire [127:0] fifo_cd_data_out;
	wire [127:0] mem_wr_data;
	wire mem_wr_data_valid;
	wire mem_wr_valid;
	wire [15:0] reg_data_from_usb;
	wire [7:0] reg_addra_USB;
	wire reg_data_valid;

	// Bidirs
	wire [15:0] bidir;

	// Instantiate the Unit Under Test (UUT)
	USB_IO uut (
		.ifclk(ifclk), 
		.system_clk(system_clk), 
		.mem_clk(mem_clk), 
		.reset_i(reset_i), 
		.system_reset(system_reset), 
		.bidir(bidir),
		.usb_din(usb_din),
		.fifo_wen(fifo_wen), 
		.fifo_ren(fifo_ren), 
		.fifo_regn(fifo_regn), 
		.dmd_1080p_connected(dmd_1080p_connected), 
		.fifo_ab_data_out(fifo_ab_data_out), 
		.fifo_cd_data_out(fifo_cd_data_out), 
		.dmd_get_row_data(dmd_get_row_data), 
		.dmd_row_fifo_reset(dmd_row_fifo_reset), 
		.mem_wr_data(mem_wr_data), 
		.mem_wr_data_valid(mem_wr_data_valid),
		.mem_wr_valid(mem_wr_valid),
		.mem_get_data(mem_get_data), 
		.mem_fifo_reset(mem_fifo_reset), 
		.reg_data_from_usb(reg_data_from_usb), 
		.reg_data_to_usb(reg_data_to_usb), 
		.reg_addra_USB(reg_addra_USB), 
		.reg_data_valid(reg_data_valid)
	);
	parameter SYS_CLK_PERIOD = 5;
	parameter USB_CLK_PERIOD = 20.83;
	parameter MEM_CLK_PERIOD = 6.66;
	
	reg [15:0] pattern1[49152:1];
	reg [15:0] pattern2[49152:1];
	reg [15:0] pattern3[49152:1];
	
	//system clock
	initial begin
		system_clk = 0;
		forever
		#(SYS_CLK_PERIOD/2) system_clk = ~system_clk;
	end
	
	//usb clock
	initial begin
		mem_clk = 0;
		forever
		#(MEM_CLK_PERIOD/2) mem_clk = ~mem_clk;
	end
	
	//usb clock
	initial begin
		ifclk = 0;
		forever
		#(USB_CLK_PERIOD/2) ifclk = ~ifclk;
	end
	
	//load test patterns from files
	initial begin
		$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/new_pattern_1.txt", pattern1);
		$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/new_pattern_2.txt", pattern2);
		$readmemb("/home/ise/Desktop/APPSFPGA_MEM/src/sim/new_pattern_3.txt", pattern3);
	end 
	
	task pattern_write_task;
	input [15:0] data_in;
	begin
		usb_din = data_in;
		fifo_wen = 0;
		fifo_ren = 1;
		fifo_regn = 1;
		#USB_CLK_PERIOD;
	end
	endtask

	task reg_addr_write_task;
	input [15:0] data_in;
	begin
		fifo_wen = 1;
		fifo_ren = 1;
		fifo_regn = 0;
		usb_din = data_in;
		#USB_CLK_PERIOD;
		fifo_wen = 0;
		fifo_ren = 0;
		fifo_regn = 0;
	end
	endtask
	
	task reg_data_write_task;
	input [15:0] data_in;
	begin
		fifo_wen = 0;
		fifo_ren = 1;
		fifo_regn = 0;
		usb_din = data_in;
		#USB_CLK_PERIOD;
		fifo_wen = 0;
		fifo_ren = 0;
		fifo_regn = 0;
	end
	endtask
	
	reg start_pattern_write;
	reg[31:0] counter = 0;
	reg[3:0] current_pattern;
	
	always@(posedge ifclk) begin
		if(system_reset == 1) begin
			usb_din <= 0;
			current_pattern <= 0;
			counter <= 1;
		end else if(start_pattern_write == 1) begin
			case (current_pattern)
				0: usb_din <= pattern1[counter];
				1: usb_din <= pattern2[counter];
				2: usb_din <= pattern3[counter];
				default: usb_din <= 0;
			endcase

			if(counter == 49152) begin
				counter <= 1;
				if(current_pattern == 2) begin
					start_pattern_write <= 0;
				end else begin
					current_pattern <= current_pattern + 1;
				end
			end else begin
				counter <= counter + 1;
			end
			fifo_wen <= 0;
			fifo_ren <= 1;
			fifo_regn <= 1;
		end else begin
			usb_din <= 0;
			fifo_wen <= 0;
			fifo_ren <= 0;
			fifo_regn <= 0;
		end
	end
	
	always@(posedge mem_clk) begin
		if (reset_i == 1) begin
			mem_get_data <= 0;
		end else if(mem_wr_valid == 1) begin
			mem_get_data <= 1;
		end else begin
			mem_get_data <= 0;
		end
	end

	initial begin
		// Initialize Inputs
		reset_i = 1;
		system_reset = 1;
		fifo_wen = 0;
		fifo_ren = 0;
		fifo_regn = 0;
		dmd_1080p_connected = 0;
		dmd_get_row_data = 0;
		dmd_row_fifo_reset = 1;
		mem_get_data = 0;
		mem_fifo_reset = 1;
		reg_data_to_usb = 0;
		start_pattern_write = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset_i = 0;
		system_reset = 0;
		dmd_row_fifo_reset = 0;
		mem_fifo_reset = 0;
		
		#1000; //wait for arst_usb to pull down
		//memory read write fifo reset
		reg_addr_write_task(16'd31);
		reg_data_write_task(16'd3);
		
		#50;
		reg_addr_write_task(16'd31);
		reg_data_write_task(16'd0);

		$display("memory fifo reset done @ %t", $time);
		
		//control data and address
		// number of patterns (3)
		reg_addr_write_task(16'd2);
		reg_data_write_task(16'd30);
		
		$display("number of pattern write done @ %t", $time);
		#50;
		// memory mode enable
		reg_addr_write_task(16'd1);
		reg_data_write_task(16'd32);
		
		
		$display("memory enable write done @ %t", $time);
		#50;
		// memory mode enable
		reg_addr_write_task(16'd0);
		reg_data_write_task(16'd24);
		
		$display("memory enable write done @ %t", $time);
		
		#100;
		start_pattern_write = 1;
	end
      
endmodule

