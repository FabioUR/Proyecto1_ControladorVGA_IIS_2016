//////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Engineer: Steven León.
// 
// Create Date:    14:25:45 08/19/2016 
// Design Name:    
// Module Name:    Controlador_VGA.
// Project Name:   Controlador_VGA.
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
module Controlador_VGA
	(
	input wire [2:0] ctrl_rgb,
	input wire RESET,
	input wire CLK,
	output wire [2:0] graph_rgb,
	output wire h_sync,
	output wire v_sync
   );
	
	wire [9:0] X, Y;
	wire reloj;
	
	Sincronizador_VGA S1(.RESET(RESET), .CLK(CLK), .sincro_horiz(h_sync), .sincro_vert(v_sync), .pixel_X(X), .pixel_Y(Y), .p_tick(reloj));
	Generador_Pixeles G1(.ctrl_rgb(ctrl_rgb), .graph_rgb(graph_rgb), .CLK(reloj), .pix_x(X), .pix_y(Y));
		
endmodule
