`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Engineer: Fabio Ureña.
//
// Create Date:   01:28:42 08/21/2016
// Design Name:   
// Module Name:   Controlador_VGA_TB.
// Project Name:  Controlador_VGA.
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: C
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Controlador_VGA_TB;

	// Inputs
	reg [2:0] ctrl_rgb;
	reg RESET;
	reg CLK;

	// Outputs
	wire [2:0] graph_rgb;
	wire h_sync;
	wire v_sync;

	// Instantiate the Unit Under Test (UUT)
	Controlador_VGA uut (
		.ctrl_rgb(ctrl_rgb), 
		.RESET(RESET), 
		.CLK(CLK), 
		.graph_rgb(graph_rgb), 
		.h_sync(h_sync), 
		.v_sync(v_sync)
	);
	
	always #10 CLK = !CLK;
	
	initial begin
		// Initialize Inputs
		ctrl_rgb = 0;
		CLK = 0;
		RESET = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		RESET = 0;
		ctrl_rgb = 3'b010;
		#16831990; // Tiempo que tarda para un pantallazo.
		
		$stop;
	end
      
endmodule

