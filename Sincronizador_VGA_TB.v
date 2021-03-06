`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers:	Fabio Ure�a y Steven Le�n.
//
// Create Date:   03:48:12 08/19/2016
// Design Name:   
// Module Name:   Sincronizador_VGA_TB.
// Project Name:  Controlador_VGA.
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
		#100;
        
		// Add stimulus here
		RESET = 0;
		
		#16831990; // Tiempo que tarda para un pantallazo.
		
		$stop;
	end
      
endmodule
