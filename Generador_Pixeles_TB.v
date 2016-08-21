`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Engineer: Steven León.
//
// Create Date:   02:19:48 08/19/2016
// Design Name:   
// Module Name:   Generador_Pixeles_TB.
// Project Name:  Controlador_VGA.
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Generador_Pixeles
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Generador_Pixeles_TB();

	// Inputs
	reg [9:0] pix_x;
	reg [9:0] pix_y;
	reg [2:0] ctrl_rgb;
	reg CLK;

	// Outputs
	wire [2:0] graph_rgb;

	// Instantiate the Unit Under Test (UUT)
	Generador_Pixeles uut (
		.pix_x(pix_x), 
		.pix_y(pix_y), 
		.ctrl_rgb(ctrl_rgb), 
		.graph_rgb(graph_rgb),
		.CLK(CLK)
	);

	always # 20 CLK = !CLK;
		
	always @ (posedge CLK)
	begin
		if (pix_x == 799) begin
			pix_x <= 0;
			if (pix_y == 524) begin
				pix_y <= 0;
				ctrl_rgb <= ctrl_rgb + 1;
			end
			else begin
				pix_y <= pix_y + 1;
			end
		end
		else begin
			pix_x <= pix_x + 1;
		end
	end
	
	initial 
	begin
		// Initialize Inputs
		CLK = 1;
		pix_x = 10'b0000000000;
		pix_y = 10'b0000000000;
		ctrl_rgb = 3'b000;

		#21440000; // Tiempo para mostrar hasta segunda pantalla (color = 001), línea y = 144.
      $stop;

	end
      
endmodule
