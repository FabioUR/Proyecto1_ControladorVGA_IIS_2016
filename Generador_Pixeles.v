//////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Engineer: Steven León.
// 
// Create Date:    19:01:34 08/16/2016 
// Design Name:    
// Module Name:    Generador_Pixeles.
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
module Generador_Pixeles(
	input wire [9:0] pix_x, pix_y, // Coordenadas del escáner del VGA.
	input wire [2:0] ctrl_rgb, // Switches del usuario para elegir color.
	input wire CLK,
	output reg [2:0] graph_rgb // Salida para controlar color en VGA.
   );
	 
	// ------- LÍMITES DE LOS RECTÁNGULOS ------- //
	
	// RECTÁNGULO 1.
	localparam RECT1_X_L = 140;
	localparam RECT1_X_R = 151;
	localparam RECT1_Y_T = 144;
	localparam RECT1_Y_B = 335;
	
	// RECTÁNGULO 2.
	localparam RECT2_X_L = 152;
	localparam RECT2_X_R = 223;
	localparam RECT2_Y_T = 144;
	localparam RECT2_Y_B = 155;
	
	// RECTÁNGULO 3.
	localparam RECT3_X_L = 152;
	localparam RECT3_X_R = 223;
	localparam RECT3_Y_T = 324;
	localparam RECT3_Y_B = 335;
	
	// RECTÁNGULO 4.
	localparam RECT4_X_L = 278;
	localparam RECT4_X_R = 289;
	localparam RECT4_Y_T = 144;
	localparam RECT4_Y_B = 335;
	
	// RECTÁNGULO 5.
	localparam RECT5_X_L = 290;
	localparam RECT5_X_R = 361;
	localparam RECT5_Y_T = 144;
	localparam RECT5_Y_B = 155;
	
	// RECTÁNGULO 6.
	localparam RECT6_X_L = 290;
	localparam RECT6_X_R = 349;
	localparam RECT6_Y_T = 228;
	localparam RECT6_Y_B = 239;
	
	// RECTÁNGULO 7.
	localparam RECT7_X_L = 416;
	localparam RECT7_X_R = 427;
	localparam RECT7_Y_T = 144;
	localparam RECT7_Y_B = 239;
	
	// RECTÁNGULO 8.
	localparam RECT8_X_L = 488;
	localparam RECT8_X_R = 499;
	localparam RECT8_Y_T = 228;
	localparam RECT8_Y_B = 335;
	
	// RECTÁNGULO 9.
	localparam RECT9_X_L = 428;
	localparam RECT9_X_R = 499;
	localparam RECT9_Y_T = 144;
	localparam RECT9_Y_B = 155;
	
	// RECTÁNGULO 10.
	localparam RECT10_X_L = 428;
	localparam RECT10_X_R = 487;
	localparam RECT10_Y_T = 228;
	localparam RECT10_Y_B = 239;
	
	// RECTÁNGULO 11.
	localparam RECT11_X_L = 416;
	localparam RECT11_X_R = 487;
	localparam RECT11_Y_T = 324;
	localparam RECT11_Y_B = 335;
	
	// ------- SEÑALES ACTIVACIÓN DE COLOR ------- //
	
	wire RECT1_on, RECT2_on, RECT3_on, RECT4_on, RECT5_on, RECT6_on, RECT7_on,RECT8_on, RECT9_on, RECT10_on, RECT11_on;
	
	assign RECT1_on = (RECT1_X_L <= pix_x) && (pix_x <= RECT1_X_R) && (RECT1_Y_T <= pix_y) && (pix_y <= RECT1_Y_B);
	assign RECT2_on = (RECT2_X_L <= pix_x) && (pix_x <= RECT2_X_R) && (RECT2_Y_T <= pix_y) && (pix_y <= RECT2_Y_B);
	assign RECT3_on = (RECT3_X_L <= pix_x) && (pix_x <= RECT3_X_R) && (RECT3_Y_T <= pix_y) && (pix_y <= RECT3_Y_B);
	assign RECT4_on = (RECT4_X_L <= pix_x) && (pix_x <= RECT4_X_R) && (RECT4_Y_T <= pix_y) && (pix_y <= RECT4_Y_B);
	assign RECT5_on = (RECT5_X_L <= pix_x) && (pix_x <= RECT5_X_R) && (RECT5_Y_T <= pix_y) && (pix_y <= RECT5_Y_B);
	assign RECT6_on = (RECT6_X_L <= pix_x) && (pix_x <= RECT6_X_R) && (RECT6_Y_T <= pix_y) && (pix_y <= RECT6_Y_B);
	assign RECT7_on = (RECT7_X_L <= pix_x) && (pix_x <= RECT7_X_R) && (RECT7_Y_T <= pix_y) && (pix_y <= RECT7_Y_B);
	assign RECT8_on = (RECT8_X_L <= pix_x) && (pix_x <= RECT8_X_R) && (RECT8_Y_T <= pix_y) && (pix_y <= RECT8_Y_B);
	assign RECT9_on = (RECT9_X_L <= pix_x) && (pix_x <= RECT9_X_R) && (RECT9_Y_T <= pix_y) && (pix_y <= RECT9_Y_B);
	assign RECT10_on = (RECT10_X_L <= pix_x) && (pix_x <= RECT10_X_R) && (RECT10_Y_T <= pix_y) && (pix_y <= RECT10_Y_B);
	assign RECT11_on = (RECT11_X_L <= pix_x) && (pix_x <= RECT11_X_R) && (RECT11_Y_T <= pix_y) && (pix_y <= RECT11_Y_B);
	
	// ------- SELECCIÓN DE COLOR -------//
	
	always @ (posedge CLK) 
	begin
		if (RECT1_on || RECT2_on || RECT3_on || RECT4_on || RECT5_on || RECT6_on || RECT7_on || RECT8_on || RECT9_on || RECT10_on || RECT11_on) 
		begin // Si está el escáner dentro de algún rectángulo.
			graph_rgb <= ctrl_rgb; // Que pinte del color elegido.
		end
		else 
		begin // Fuera de rectángulos. Fondo.
			graph_rgb <= 3'b000; // Que pinte negro.
		end	
	end

endmodule
