//////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Engineer: Fabio Ureña Rojas.
// 
// Create Date:    17:17:32 08/11/2016 
// Design Name:    
// Module Name:    Sincronizador_VGA.
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

module Sincronizador_VGA(
	input wire CLK, RESET,
	output wire sincro_horiz, sincro_vert, p_tick,
	output wire [9:0] pixel_X, pixel_Y
    );
	
	//declaración de constantes
	//parametros de sincronización del controlador VGA 640x480
	//dichos valores o parametros salen de las graficas
	localparam HM = 640   ; //area de muestro horizontal
	localparam H_izq = 48 ; //borde izquierdo horizontal
	localparam H_der = 16 ; //borde derecho horizontal
	localparam H_retraz=96; //retrazo horizontal
	localparam VM = 480   ; //area de muestro vertical
	localparam V_sup = 10 ; //borde superior vertical
	localparam V_inf = 33 ; //borde inferior vertical
	localparam V_retraz=2 ; //retrazo vertical
	
	//modulo 2 contadores
	reg mod2_registro;
	wire mod2_siguiente;
	
	//contadores sincronos
	reg [9:0] cont_horiz_regist, cont_horiz_siguiente; //cont=contador
	reg [9:0] cont_vert_regist, cont_vert_siguiente;   //cont=contador
	
	//salida del buffer 
	reg sincr_vert_reg, sincr_horiz_reg; //registro vertical sincronizador, registro horizontal soncronizador
	wire sincr_vert_siguiente, sincr_horiz_siguiente; // sincronización vertical siguiente, sincronización horizontal siguiente
	
	//Estado de señal
	wire horiz_fin, vert_fin, pixel_tick; // finalización horizontal, final vertical,
	
	//Cuerpo/Registros
	
	always @ (posedge CLK, posedge RESET)
	
		if (RESET) begin //caracteristicas del reinicio de pantalla
			mod2_registro <= 1'b0;
			cont_vert_regist <= 0;
			cont_horiz_regist <=0;
			sincr_vert_reg <=1'b0;
			sincr_horiz_reg <=1'b0;
		end
		else begin
			mod2_registro <= mod2_siguiente;
			cont_vert_regist <= cont_vert_siguiente;
			cont_horiz_regist <=cont_horiz_siguiente;
			sincr_vert_reg <=sincr_vert_siguiente;
			sincr_horiz_reg <=sincr_horiz_siguiente;
		end
	
	//mod_2 circuito para generar 25MHz habilitador pulga 
	assign mod2_siguiente =~mod2_registro;
	assign pixel_tick = mod2_registro;
	
	//Estados de señal
	//FIN indicador Contador horizontal 0-799
	assign horiz_fin = (cont_horiz_regist==(HM+H_izq+H_der+H_retraz-1));
	//FIN indicador contador vertical 0-524
	assign vert_fin = (cont_vert_regist==(VM+V_sup+V_inf+V_retraz-1));
	
	//etapa de contador sincronico horizontal 800
	always @* begin
		if (pixel_tick) //25MHz pulso
			if (horiz_fin) 
				cont_horiz_siguiente = 0;
			else
				cont_horiz_siguiente = cont_horiz_regist + 1;
		else
			cont_horiz_siguiente = cont_horiz_regist;
	end
	//etapa contador sincrono vertical 525
	always @* begin
		if (pixel_tick & horiz_fin) begin
			if (vert_fin)
				cont_vert_siguiente = 0;
			else
				cont_vert_siguiente = cont_vert_regist + 1;
		end
		else
			cont_vert_siguiente = cont_vert_regist;
	end
	
//	Se toma en cuenta la parte de retrazo, de 656-751 en horizontal
// Asignando un valor booleano a sincr_horiz_siguiente
	
	assign sincr_horiz_siguiente = ((cont_horiz_regist >= (HM+H_der)) && (cont_horiz_regist <= (HM+H_der+H_retraz-1)));
	
// Se toma en cuenta la parte de retrazo, de 490 a 491
// Asignando un valor booleano a sincr_vert_siguiente
	assign sincr_vert_siguiente = ((cont_vert_regist >= (VM+V_sup)) && (cont_vert_regist <= (VM+V_sup+V_retraz-1)));
	
//Señales de salida, las cuales van al generador de pixeles
	assign sincro_horiz = ~sincr_horiz_reg;
	assign sincro_vert = ~sincr_vert_reg;
	assign pixel_X = cont_horiz_regist;
	assign pixel_Y = cont_vert_regist;
	assign p_tick = pixel_tick;
	
endmodule
