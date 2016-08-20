`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers:	Fabio Ureña y Steven León.
//
// Create Date:   03:48:12 08/19/2016
// Design Name:   Controlador_VGA.
// Module Name:   Sincronizador_VGA_TB.
// Project Name:  
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sincronizador_VGA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Sincronizador_VGA_TB ();

	// Inputs
	reg CLK;
	reg RESET;

	// Outputs
	wire sincro_horiz;
	wire sincro_vert;
	
	//wire video_on;
	wire p_tick;
	wire [9:0] pixel_X;
	wire [9:0] pixel_Y;

	// Instantiate the Unit Under Test (UUT)
	Sincronizador_VGA uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.sincro_horiz(sincro_horiz), 
		.sincro_vert(sincro_vert),
		.p_tick(p_tick),
		.pixel_X(pixel_X),
		.pixel_Y(pixel_Y)
	);

	always #10 CLK=!CLK;
	
	
	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;

		// Wait 100 ns for global reset to finish
		#110;
        
		// Add stimulus here
		RESET = 0;
		
		//#17358000;
		#34716000;
		
		$stop;
	end
      
endmodule
