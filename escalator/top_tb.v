`timescale 10ns / 10ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:19:16 07/26/2024
// Design Name:   escalator_using_shift_register
// Module Name:   /home/ise/day1/escalator/top_tb.v
// Project Name:  escalator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: escalator_using_shift_register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_tb;

	// Inputs
	reg clk;
	reg rst_n;
	reg [3:0] requested_floor;

	// Outputs
	wire [3:0] required_floor;

	// Instantiate the Unit Under Test (UUT)
	escalator_using_shift_register uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.requested_floor(requested_floor), 
		.required_floor(required_floor)
	);
	
	always #1 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		#1 rst_n=1'b1;
		
		#1 requested_floor=4'b0010;
		#1 requested_floor=4'b0100;
		#1 requested_floor=4'b0100;
		#1 requested_floor=4'b1000;
		#1 requested_floor=4'b0010;
		#1 requested_floor=4'b0001;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
		#100 $finish;

	end
      
endmodule
