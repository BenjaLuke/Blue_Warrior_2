        output "BW2.ROM"

BIOS_KERNEL:

		include "BASICOS/BIOS.asm"				                        ; Incluímos las referencias a la BIOS

VARIABLES:

		include	"BASICOS/VARIABLES.asm"				                    ; Incluímos las referencias a las variables que se usarán en el juego

/**********************
 ****** PAGINA 0 ******
 ****** SLOT   1 ******     preparacion y animación de marca
 **********************/    

		org		#4000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
				
		db 		"AB"													; Cabecera para indicar que esto será una ROM
		word 	INICIO													; Etiqueta en la que comienza todo
		word 	0,0,0,0,0,0

INICIO:

        di								                                ; Desconecta interrupciones
        im 	    1							                            ; Modo de interrupcion 1 
                                                                        ; (en caso de interrupcion, la rutina de servicio
                                                                        ; de interrupcion (ISR) esta en #0038		
        ld 	    sp,0xE500						                        ; Colocamos la pila en esta posicion.

LIMPIA_RAM_PAGE_3:
		ld		ix,VDP
		ld		a,0
		ld		(ix),a

		ld		b,5
		ld		de,VDP+1

.sobre_bucle:

		push	bc
		ld		b,255

.bucle_limpia_RAM:

		push	bc
		ld		hl,VDP
		ld		bc,1
		ldir
		pop		bc
		djnz	.bucle_limpia_RAM

		pop		bc
		djnz	.sobre_bucle

LIMPIA_SALTO_DE_INTERRUPCIONES:

		ld		a,#C9													; A tiene el valor de ret
		ld		(HTIMI),a												; Colocamos ese ret en el gancho H.Timi POR SI EL ORDENADOR TUVIERA ALGO (ALGUN MSX 2 CONTROL DE DISQUETERA)
		ld		(HKEYI),a												; Colocamos ese ret en el gancho H.Key POR SI EL ORDENADOR TUVIERA ALGO
        ei                                                              ; Conecta interrupciones

CREAMOS_UN_MEGAROM:

		ld      hl,VDP_0												; Copia los ajustes de los registros del VDP a la matriz VDP ...
        ld      de,VDP													; Después, lee los registros de VDP con LD A, (VDP + r) ...
        ld      bc,8													; Esto debe colocarse al comienzo del programa 
        ldir															; 
        ld      hl,VDP_8												; 
        ld      de,VDP+8												; 
        ld      bc,17													; 
        ldir
		              																				
		call	SEARCH_SLOT_SET											; La CPU vera esta ROM en la pagina 2		
		xor		a
		ld	    (DIRPA1),a  											; Banco 1, pagina 0 del MEGAROM
		ld		a,1
		ld	    (DIRPA2),a	    										; Banco 2, pagina 1 del MEGAROM

RECONOCEMOS_AL_TURBOR:

		ld		a,[#002D]										        ; Si se trata de un msx2+ O INFERIOR no conectamos el R800
		cp		3
		jp	    nz,PREPARANDO_FMPAC  
/*
		ld	    a,10000010B		                                        ; Conectamos el R800
                                                                        ; Bit 7 enciende el led
                                                                        ; Bit 1 conecta el R800
        call    CHGCPU
*/ 		
		ld		a,1														; Avisamos que existe FM Pac para su anulación durante la partida
		ld		(FMPAC_DESCONECTADO),a

   jp      PREPARANDO_FX
PREPARANDO_FMPAC:

        call    BUSCAMOS_FM_PAC

PREPARANDO_FX:

		xor		a
		ld		(LINEA_PSG_QUE_TOCA),a

		ld      a,31
        call    CHANGE_BANK_2	
		ld		hl,EFECTOS_DE_SONIDO
		call  	ayFX_SETUP
        ld      a,1
        call    CHANGE_BANK_2
PREPARACION_GRAFICA:

        ld      a,5                                                     ; Modo gráfico G4
        call    CHGMOD

 		call	DISSCR_RAM                                              ; Desconecta la pantalla

        ld	    a,0							                            ; a     = el valor que vamos a poner
        ld	    bc,#ffff						                        ; bc	= longitud del area a rellenar con el dato A
        ld	    hl,#0000						                        ; hl	= dirección en la que empieza a pintar
        call	FILVRM_RAM						                        ; Limpiamos toda esta zona de la VRAM 	

        di                    
        xor	    a							                            ; Color de fondo a negro
        ld	    (BDRCLR),a
        ld	    (BAKCLR),a
        ld	    (FORCLR),a
        call	CHGCOLOR_RAM                                            ; Orden a la BIOS

        xor	    a
        ld	    (CLICKSW),a						                        ; Quitamos el sonido de tecla de cursor
                
        ld	    a,(RG9SAV)						                        ; Leo el registro 9 del VDP (Para poner a 60Hz)
        and	    11111101B						                        ; Lo llevo a 60 hz
        ld	    b,a
        ld	    c,9
        call	WRTVDP_EN_RAM						                    ; Lo escribo en el registro 9 del VDP		

        ld	    a,0							                            ; Página 1 a vista
        call	SETPAGE    

REINICIAMOS_MAX_SCORE:

		ld		hl,0
		ld		(MAX_SCORE),hl

        include "MARCA/ANIMACION DE MARCA sc7.asm" 
		; include "MARCA/ANIMACION DE MARCA.asm"

        include "AUDIOS/FMPAC FOUND.asm"

        ds      #8000-$-#2200   
				                                        ; Colocamos el resto del programa siempre en el mismo sitio    
		include "BASICOS/RUTINAS CERRADAS.asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG.asm"
        include "PALETAS/PALETAS.asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE.asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 0 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 1 ******
 ****** SLOT   2 ******     gráficos de marca parte 1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

GRAFICOS_MOAI_1:

        incbin  "GRAFICOS/SOLOTITULO1.DAT" ;incbin  "GRAFICOS/DIGITAL MOAI 1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 1 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 2 ******
 ****** SLOT   2 ******     Gráficos de marca parte 2 y cambio de page a menú
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

GRAFICOS_MOAI_4:

        incbin  "GRAFICOS/SOLOTITULO4.DAT";incbin  "GRAFICOS/DIGITAL MOAI 2.DAT"
CARGA_SLOT_MENU:

		ld		a,3
		ld      (DIRPA1),a											    ; Banco 1, pagina 3 del MEGAROM
        jp      COMIENZA_MENU

        ds		#C000-$

/**********************
 ****** PAGINA 2 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 3 ******
 ****** SLOT   1 ******     Menú
 **********************/

		org		#4000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

		include	"MENU Y TRANSICIONES/MENU.asm"
PALETA_ALTA_MENU:

		incbin	"PALETAS/PALETA_ALTA.pal"

PALETA_BAJA_MENU:

		incbin	"PALETAS/PALETA_BAJA.pal"

        ds      #8000-$-#2200   
			                                        ; Colocamos el resto del programa siempre en el mismo sitio    
		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        




		
        ds		#8000-$

/**********************
 ****** PAGINA 3 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 4 ******
 ****** SLOT   2 ******     graficos menu
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/DIBUJO_MENU1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 4 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 5 ******
 ****** SLOT   2 ******     graficos menu
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/DIBUJO_MENU2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 5 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 6 ******
 ****** SLOT   2 ******     ?
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TITULO_TROZO.DAT"
MONTANAS:
		
        incbin  "GRAFICOS/MONTANAS.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 6 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 7 ******
 ****** SLOT   2 ******     ?
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        ds		#C000-$

/**********************
 ****** PAGINA 7 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 8 ******
 ****** SLOT   2 ******     Cambio de page a juego
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

CARGA_SLOT_JUEGO:

		ld		a,9
		ld      (DIRPA1),a											; Banco 1, pagina 3 del MEGAROM
        jp      COMIENZA_JUEGO

        ds		#C000-$

/**********************
 ****** PAGINA 8 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 9 ******
 ****** SLOT   1 ******     Motor del juego
 **********************/

		org		#4000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

COMIENZA_JUEGO:

		ld		a,(FASE)
		cp		1
		jp		nz,.limpia_solo_sprites

        ld	    a,0							                            ; a     = el valor que vamos a poner
        ld	    bc,#ffff						                        ; bc	= longitud del area a rellenar con el dato A
        ld	    hl,#0000						                        ; hl	= dirección en la que empieza a pintar
        call	FILVRM_RAM						                        ; Limpiamos toda esta zona de la VRAM 

.limpia_solo_sprites:

        ld	    a,0							                            ; a     = el valor que vamos a poner
        ld	    bc,#1980						                        ; bc	= longitud del area a rellenar con el dato A
        ld	    hl,#3B00						                        ; hl	= dirección en la que empieza a pintar
        call	FILVRM_RAM						                        ; Limpiamos toda esta zona de la VRAM 
		
.carga_graficos:
		
		; PAUSA PARA CARGAR LAS LETRAS DEL PREMIO DE LETRAS
		xor		a
		ld		(TENEMOS_D),a
		ld		(TENEMOS_E),a
		ld		(TENEMOS_P),a
		ld		(TENEMOS_H),a
		ld		(CORAZON_CONTENEDOR_COGIDO),a
		; FIN DE LA PAUSA
		
        ld      a,(FASE)
		add		10
        call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
        ld		hl,#8000												; Carga gráficos fase
        ld		de,#8000
        ld		bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,(FASE)
		add		15
        call	CHANGE_BANK_2

        ld		hl,#8000
        ld		de,#c000

		ld		a,(FASE)
		cp		1
		jp		nz,.carga_pequena

		push	hl
		ld		hl,0
		ld		(SCORE_REAL),hl
		pop		hl

.carga_grande:

        ld		bc,16384
		jp		.fin_de_carga

.carga_pequena:

		ld		bc,16384
		
.fin_de_carga:		

        call	PON_COLOR_2.sin_bc_impuesta

		call	DISSCR_RAM

        di

        ld		a,2														; Página 2 a vista
        call	SETPAGE

        ei	
		xor		a
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
        call    PAGE_10_A_SEGMENT_2
		ld		hl,POSICION_COPIA_MARCADOR_1
		call	DOCOPY
		ld		hl,POSICION_COPIA_MARCADOR_2
		call	DOCOPY
			
PREPARACION_SPRITES:
		
		di
			
		ld 		a,(RG1SAV)												; Los hacemos de 16 por 16
		or		00000010B
		ld 		(RG1SAV),a				
		ld		b,a
		ld		c,1
		call	WRTVDP_EN_RAM
			
		ld 		a,(RG8SAV)												; Los activamos
		and		11111101B
		ld 		(RG8SAV),a			
		ld		b,a
		ld		c,8
		call	WRTVDP_EN_RAM		
				
		ld 		a,(RG5SAV)												; Colocamos los punteros de atributos en #4A00 (los colores serán #800 antes que este)
		or		10010111B
		and		10010111b
		ld 		(RG5SAV),a			
		ld		b,a
		ld		c,5
		call	WRTVDP_EN_RAM		
	
		ld 		a,(RG11SAV)												
		and		11111100B
		ld 		(RG11SAV),a			
		ld		b,a
		ld		c,11
		call	WRTVDP_EN_RAM	
				
		ld 		A,(RG6SAV)												; Colocamos el puntero de patrones en #4000
		or  	00001000B
		and		00001000b
		ld 		(RG6SAV),a			
		ld		b,a
		ld		c,6
		call	WRTVDP_EN_RAM     
		di		
		ld		hl,POSICION_PARTIDA_DEPH	
		ld		de,ATRIBUTOS_DEPH_VARIABLES								; Pinta al prota
		ld		bc,40
		ldir		
		ei

CUADRADO_SEPARADOR:

		ld		hl,CUADRADO_NEGRO_SEPARADOR
		ld		de,DATOS_DEL_CUADRADO_NEGRO							
		ld		bc,15
		ldir				
				
PREPARACION_INTERRUPCIONES:

		call	ACTIVAMOS_INTERRUPCIONES_DE_LINEA

		di																; Desconectamos las interrupciones																	
		ld		a,#C3													; #c3 es el código binario de jump (jp)
		ld		[HKEYI],a												; Metemos en HTIMI ese jp
		ld		hl,NUESTRAS_INT											; Con el jp anterior, construimos jp NUESTRA_ISR
		ld		[HKEYI+1],hl											; La ponemos a continuación del jp
		ei																; Conectamos las interrupciones	

		jp		VARIABLES_PARA_EMPEZAR_LA_PARTIDA		
ACTIVAMOS_INTERRUPCIONES_DE_LINEA:

		call	INTRODUCIMOS_LINEA_DE_INTERRUPCION_NUEVA

		di
		ld 		a,(RG0SAV)												; Enable Line Interrupt: Set R#0 bit 4
		or		00010000B
		ld		(RG0SAV),a				
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM	
		ei
		ret
DESACTIVAMOS_INTERRUPCIONES_DE_LINEA:

		di
		ld 		a,(RG0SAV)												; Enable Line Interrupt: Set R#0 bit 4
		and		11011111B
		ld		(RG0SAV),a				
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM	
		ei
		ret			

VARIABLES_PARA_EMPEZAR_LA_PARTIDA:	
																			; Cuando empieza el juego pero que luego no hay que recuperar si muere.
		ld		hl,(MAX_SCORE)
		ld		a,h
		or		l
		jp		z,VARIABLES_PARA_EMPEZAR_LA_PARTIDA_1
		ld		(SCORE_A_SUMAR),hl
		ld		de,1
		or		a
		sbc		hl,de
		ld		(MAX_SCORE),hl

		call	SUMA_SCORE
		ld		hl,0
		ld		(SCORE_A_SUMAR),hl
		call	SUMA_SCORE

		ld      hl,COPIA_SOLO_SCORE
		call    DOCOPY

VARIABLES_PARA_EMPEZAR_LA_PARTIDA_1:

		ld		a,(FASE)
		add		a
		ld		ix,TABLA_DE_TAMANO_DE_FASE
		ld		e,a
		ld		d,0
		add		ix,de
		ld		l,(ix)													; Empezamos a leer por la última linea del mapa e iremos subiendo. Recordemos que cada linea horizontal son 16 tiles de 16 pixeles
		ld		h,(ix+1)
		ld		(LINEA_SALVADA),hl

		xor		a

		ld		(INMUNE),a
		ld		(SEMAFORO_CHECK_POINT),a
		ld		(CAMINO_NUEVA_INT),a
		ld		(HAY_CORAZONES),a
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
		ld		(MARCADOR_ANULADO),a

		inc		a

		ld		(ESTADO_MARCADOR),a
		ld		(MUSICA_ON_OFF),a
		ld		(FX_ON_OFF),a
		ld		(SEMAFORO_VIDA_EXTRA),a
		ld		(HACIA_DONDE_INTERRUPT),a

		inc		a
		ld		(SET_PAGE),a
		
		ld		a,159
		ld		(LIM_Y_INF),a	
			
		ld		a,190
		ld		(LIM_MUERTE),a

		ld		a,195
		ld		(Y_LINEA_INT),a

INICIA_SCROLL:

        ld 	    sp,0xE500						                        ; Re Colocamos la pila en esta posicion.

.SPRITES:


		call	CARGA_1_A_45
		call	CARGA_SKRULLEX_SLIME
		call	CARGA_CORVELLINI_COVID

		ld		a,(FASE)
		cp		1
		jp		z,.VARIABLES_INAMOVIBLES
		cp		2
		jp		z,.SPRITES_STAGE_2
		cp		4
		jp		z,.SPRITES_STAGE_4
		cp		5
		jp		z,.SPRITES_STAGE_5

.SPRITES_STAGE_2:

		call	CARGA_ALFONSERRYX
		jp		.VARIABLES_INAMOVIBLES

.SPRITES_STAGE_4:

		call	CARGA_ECTO_PALLER
		jp		.VARIABLES_INAMOVIBLES

.SPRITES_STAGE_5:

		call	CARGA_MEGADEATH

.VARIABLES_INAMOVIBLES:

		ld		hl,(LINEA_SALVADA)
		ld		(LINEA_A_LEER),hl

		ld		hl,0
		ld		(CUANDO_RALENTIZAMOS),hl
		ld		(CONTROL_DE_C_R),hl
		ld		(CUANDO_PINTAMOS_UN_TILE),hl
		ld		(CONTROL_DE_C_P_U_T),hl	
		ld		(TIME_PARALIZA),hl
		xor		a
		ld		(X_PINTA_SCROLL),a										; La posición X del pintado empieza en 0
		ld		(NUMERO_DE_TILE_EN_LINEA),a								; Irá de 0 a 15 y volverá a empezar reduciendo en 1 LINEA_A_LEER
		ld		(PUNTO_DEL_SCROLL),a									; Dónde comienza situada la pantalla	
		ld		(TIEMPO_DE_ADJUST),a
		ld		(PAUSA_BLOQUEADA),a
		ld		(PARALIZAMOS),a
		ld		(NO_SE_MUEVE),a
		ld		(ECTOPALLERS_NUEVO_NECESARIO),a

		inc		a
		ld		(FINAL_DEL_SCROLL),a									; Activamos el scroll
		ld		(AVANCE_BLOQUEADO),a
		ld		(AGU_ACTIVO),a
		ld		(SPRITE_CAIDO),a
		call	RECUPERA_SPRITES
		
		ld		a,6
		ld		(CAMBIO_POSE),a

		ld		a,10
		ld		(ESTADO_COLOR_PERM),a

		ld		a,10
		ld		(SPRITE_QUE_TOCA),a

		ld		a,20													; El numero de fotograma siempre es el primero de la izquierda abajo, ya que los de arriba son los mismos siempre
		ld		(FOTOGRAMA_DEPH),a

		ld		a,40
		ld		(CADENCIA_DEL_DISPARO),a

		ld		a,100
		ld		(Y_DEPH),a
		ld		(CONTROL_Y),a

		ld		a,120
		ld		(X_DEPH),a

		ld		a,183
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
			
		ld		a,224
		ld		(Y_PINTA_SCROLL),a										; La posición Y del pintado empieza en 200

		call	PINTA_VIDAS
		call	PINTA_CORAZONES																				
		call	PINTA_ARMA
		call	PINTAMOS_LOS_PUNTOS_DE_MAGIA
		ld		hl,INICIA_SCROLL.posible_rectificacion_posicion_int_linea
[2]		push	hl
		call	PINTA_SCORE

.posible_rectificacion_posicion_int_linea:

		ld		a,(ESTADO_MARCADOR)
		or		a
		jp		nz,.entorno_a_1

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		add		20
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
			
.entorno_a_1:

		ld		a,1
		ld		ix,TILE_N
		ld		de,1
		ld		b,4

.bucle_entorno_a_1:

		ld		(ix),a
		add		ix,de
		djnz	.bucle_entorno_a_1
					
		call	BORRA_SPRITES_ACTIVOS

.pinta_proyectiles_y_enemigos:

		ld		b,16
		ld		ix,ENEMIGOS
		ld		a,0
		
.bucle_para_pintar_proyectiles_y_enemigos:
		
		ld		(ix+8),a												; #FF Significa que no debe seguir buscnado porque no hay más proyectiles
		ld		(ix+6),a
		ld		de,16
		add		ix,de
		djnz	.bucle_para_pintar_proyectiles_y_enemigos
						
		ld		hl,PALETA_FASE_1_1_FADE_IN								; Primera paleta de colores
		call	SETPALETE
					
FASE1_PONEMOS_DECORADO_EN_SU_SITIO:

		ld		b,250
		call	COLOCA_IX_EN_EL_LUGAR_ADECUADO_PARA_LEER_TILES
		xor		a
		ld		(ACTIVA_SUCESOS),a	

.bucle_para_decorado:

		push	bc
			
		ld		a,(Y_DEPH)
		dec		a
		ld		(Y_DEPH),a
			
		call	BUCLE_PINTA_TILES
			
		pop		bc
		djnz	.bucle_para_decorado
			
		ld		a,1
		ld		(ACTIVA_SUCESOS),a

		call	SHOW_STATUS_COMP

		ld		hl,M_FANFARE_1
		ld		(MUSIC_ON),hl
        ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2
		call	INICIAMOS_MUSICA
        call    PAGE_10_A_SEGMENT_2
		call	PREPARAMOS_LOS_FX
        ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2

		di
		call	strmus
		ei

        call    PAGE_10_A_SEGMENT_2


		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		nz,.SEGUIMOS

		call	stpmus

.SEGUIMOS:

			call	RECUPERA_SPRITES_SALUDO									; A veces los pierde por el camino. Aquí garantizamos que los tiene cuando los necesita
			ld		a,(MUSICA_ON_OFF)
			or		a
			jp		nz,PRE_CONTROL

			call	CARGA_DEPH_MUSIC_OFF

PRE_CONTROL:

			call	ENASCR_RAM

CONTROL:
		
		ei
		
		call	BUCLE_PINTA_TILES
						
		call	INTRODUCIMOS_LINEA_DE_INTERRUPCION_NUEVA

		ld		a,(CORAZONES)
		or		a
		jp		nz,.control_adjust

		ld		a,(PARPADEO_CORAZONES)
		dec		a
		and		00111111B
		ld		(PARPADEO_CORAZONES),a
		or		a
		jp		z,.corazones_visibles
		cp		00010000B
		jp		nz,.control_adjust

.corazones_invisibles:

		ld		a,12
		ld		c,1
        call    A_31_DESDE_10       

			
		ld		hl,COPIA_CORZONES_VACIOS
		call	DOCOPY
		ld      hl,COPIA_MARCADOR_0_A_MARCADOR_3
		call    DOCOPY
		jp		.control_adjust

.corazones_visibles:

			call	PINTA_CORAZONES

.control_adjust:

			ld		a,(TIEMPO_DE_ADJUST)
			or		a
			jp		z,.control_inmune
			dec		a
			ld		(TIEMPO_DE_ADJUST),a

.control_inmune:

			ld		a,(INMUNE)
			or		a
			jp		z,.primeras_rutinas
			dec		a
			ld		(INMUNE),a

.primeras_rutinas:		
		
			call	RESCATA_ENTORNO
			call	FUERA_DE_PANTALLA
			
			ld		a,(MARCADOR_PULSADO)
			or		a
			jp		z,.teclas
				
.teclas:

.miramos_si_puede_moverse:

			jp	SE_PUEDE_MOVER_Y_EFES_VARIOS
	
.teclado:

			ld		a,(NO_SE_MUEVE)
			or		a
			jp		z,.pre_sigue_comun

			ld		a,(LENTO)
			or		a
			jp		nz,.pre_sigue_comun
						
.si_que_puede:

			xor		a												; Comprobando si ha tocado los cursores
			call	GTSTCK_RAM		
			or		a
			jp		z,.pad1
			
			call	RECUPERA_SPRITES

			ld		b,a
			ld		a,(GUARDA_STRIG)
			ld		(GUARDA_STRIG_2),a
			ld		a,b
			ld		(GUARDA_STRIG),a
				
.comprobamos1:

       		ld      de,TABLA_TECLADO
        	jp      SITUAMOS_PUNTERO_EN_TABLA

.pad1:

			ld		a,1												; Comprobando si ha tocado el pad1
			call	GTSTCK_RAM
			or		a
			jp		z,.comprobamos2	

			call	RECUPERA_SPRITES

			ld		b,a
			ld		a,(GUARDA_STRIG)
			ld		(GUARDA_STRIG_2),a
			ld		a,b
			ld		(GUARDA_STRIG),a
		
.comprobamos2:
		
       		ld      de,TABLA_PAD_1
        	jp      SITUAMOS_PUNTERO_EN_TABLA
						
.upright:

			call	DEPH_PARALIZADO_2.suma_comun_x
			jp		.resta_comun_y

		
.right:

			call	DEPH_PARALIZADO_2.suma_comun_x
			jp		.pre_sigue_comun
		
.rightdown:

			call	DEPH_PARALIZADO_2.suma_comun_x
			jp		.suma_comun_y
		
.downleft:

			call	DEPH_PARALIZADO_2.resta_comun_x
			jp		.suma_comun_y
		
.left:

			call	DEPH_PARALIZADO_2.resta_comun_x		
			jp		.pre_sigue_comun
		
.leftup:

			call	DEPH_PARALIZADO_2.resta_comun_x
		
.resta_comun_y:
		
			ld		a,(TILE_N)
			cp		79
			jp		nc,.pre_sigue_comun

			ld		a,(TILE_N2)
			cp		79
			jp		nc,.pre_sigue_comun

			ld		a,(AVANCE_BLOQUEADO)
			or		a
			jp		nz,.avance_con_reservas

			ld		a,(CONTROL_Y)
			cp		220
			jp		c,.hay_que_restar
			cp		250
			jp		c,.pre_sigue_comun
			jp		.hay_que_restar

.avance_con_reservas:

			ld		a,(CONTROL_Y)
			cp		65
			jp		c,.pre_sigue_comun
			cp		220
			jp		c,.hay_que_restar


.hay_que_restar:
		
			ld		a,(CONTROL_Y)
			dec		a
			ld		(CONTROL_Y),a
			
			ld		a,(Y_DEPH)
			dec		a
		
.pre_sigue_up:

			ld		(Y_DEPH),a
			cp		216
			jp		z,.rectifica_up
			cp		200
			jp		nz,.pre_sigue_comun
				
.rectifica_up:
	
			dec		a
			ld		(Y_DEPH),a

			ld		a,(CONTROL_Y)
			dec		a
			ld		(CONTROL_Y),a
					
			jp		.pre_sigue_comun

.suma_comun_y:

			ld		a,(TILE_S)
			cp		79
			jp		nc,.pre_sigue_comun

			ld		a,(TILE_S2)
			cp		79
			jp		nc,.pre_sigue_comun

			ld		a,(LIM_Y_INF)
			ld		b,a
			ld		a,(CONTROL_Y)
			cp		b
			jp		c,.hay_que_sumar
			cp		210
			jp		c,.pre_sigue_comun

.hay_que_sumar:
		
			ld		a,(CONTROL_Y)
			inc		a
			ld		(CONTROL_Y),a
									
			ld		a,(Y_DEPH)
			inc		a

.pre_sigue_down:

			ld		(Y_DEPH),a
			cp		216
			jp		z,.rectifica_down

			cp		200
			jp		nz,.pre_sigue_comun

.rectifica_down:
		
			add		2
			ld		(Y_DEPH),a

			ld		a,(CONTROL_Y)
			add		2
			ld		(CONTROL_Y),a
		
.pre_sigue_comun:

			ld		a,(PARALIZAMOS)
			or		a
			jp		z,.cambio_de_pose
						
.cambio_de_pose:

			ld		a,(CAMBIO_POSE)
			sub		2
			ld		(CAMBIO_POSE),a
			cp		0
			jp		z,.corrige_y_sigue
			cp		255
			jp		nz,.sigue

.corrige_y_sigue:
		
			ld		a,1
			ld		(CAMBIO_POSE),a
														
.sigue:

			ld		a,(CADENCIA_DEL_DISPARO)
			or		a
			jp		z,.PULSA_ESPACIO
			
			dec		a
			ld		(CADENCIA_DEL_DISPARO),a
			jp		.FIN_RUTINA_GLOBAL
		
.PULSA_ESPACIO:

			ld		a,(BLOQUE_DE_SPRITES_VARIABLE)
			cp		5
			jp		z,.FIN_RUTINA_GLOBAL

			ld		hl,(TIME_PARALIZA)
			ld		de,0
			call	DCOMPR_RAM
			jp		nz,.FIN_RUTINA_GLOBAL

			xor		a
			call	GTTRIG_RAM   
			or		a
			jp		z,.PULSA_BOTON
			
			ld		a,(TRIG_PULSADO)
			or		a
			jp		nz,.PULSA_M
			
			call	NUEVO_PROYECTIL
			
			jp		.PULSA_M
		
.PULSA_BOTON:

			ld		a,1
			call	GTTRIG_RAM
			or		a
			jp		z,.LIBERAMOS_TRIG

			ld		a,(TRIG_PULSADO)
			or		a
			jp		nz,.PULSA_M
			
			call	NUEVO_PROYECTIL	

.LIBERAMOS_TRIG:

			xor		a
			ld		(TRIG_PULSADO),a

.PULSA_M:

			ld		a,4														; Si pulsa M usamos magia
			call	SNSMAT_RAM 
			bit		2,a
			jp		nz,.PULSA_BOTON_2
					
			call	MAGIA
			
			jp		.FIN_RUTINA_GLOBAL
		
.PULSA_BOTON_2:

			ld		a,3
			call	GTTRIG_RAM  
			or		a
			jp		z,.FIN_RUTINA_GLOBAL
			
			call	MAGIA	

.FIN_RUTINA_GLOBAL:
		
			ld		a,(HACIA_DONDE_INTERRUPT)
			or		a
			call	nz,CAMBIAMOS_LA_INTERRUPCION_DE_LINEA_PARA_DESAPARECER

			halt
			call	PINTA_SPRITE_DEPH
			
			call	SECUENCIA_PROYECTILES_Y_ENEMIGOS		
			call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES
			call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH
			call	PINTA_PROYECTILES_ENEMIGOS

.MIRAMOS_SI_HAY_AGUJERO:


			push	ix
			ld		a,(FASE)
			add		32
			call	CHANGE_BANK_2
			call	SITUA_LA_X_E_Y
			call	SITUA_LA_X_E_Y_2
			ld		a,(ix)
			ld		(TILE_CENTRO),a
			ld		a,(ix+1)
			ld		(TILE_CENTRO_2),a
			call	PAGE_10_A_SEGMENT_2
			pop		ix

			jp		MIRAMOS_SI_HAY_AGUJERO

.RECUPERANDO_SPRITES_DEPH:

			ld		hl,SPRITE_DEPH_AGUJERO_1
			ld		de,#4020
			ld		bc,704
			call	PAGE_32_A_SEGMENT_2
			call	PON_COLOR_2.sin_bc_impuesta
			
			ld		hl,COLOR_DEPH_AGUJERO_2
			ld		de,#4820
			ld		bc,64
        	call   	PAGE_32_A_SEGMENT_2
			call	PON_COLOR_2.sin_bc_impuesta

        	ld      a,19
        	ld      c,0
        	CALL   	A_31_DESDE_10

			jp		DEPH_PARALIZADO_2

CARGA_1_A_45:

			ld		hl,TODOS_LOS_SPRITES										; Depositamos los sprites en vram	
			call	CARGA_COMUN_45
			ld		a,(ARMA_USANDO)
			cp		2
			jp		z,CARGA_FLECHA_DOBLE
			ret

CARGA_PIES_EN_LODO:

			ld		hl,SPRITES_BARRO_DEPH
			ld		de,#4000+5*8*4
			ld		bc,18*8*4
			jp		TROZOS_COMUNES_15
CARGA_FLECHA_SIMPLE:

			ld		hl,SPRITE_FLECHA_SIMPLE
			jp		CARGA_COMUN_1_FLECHA
CARGA_FLECHA_DOBLE:
			ld		hl,SPRITE_FLECHA_DOBLE
			jp		CARGA_COMUN_1_FLECHA
CARGA_EJERCICIO:

			ld		hl,SPRITES_EJERCICIO
			JP		CARGA_COMUN_26
CARGA_FRENTE:

			ld		hl,DEPH_DE_FRENTE
			jp		CARGA_COMUN_26
CARGA_STAGE:

			ld		hl,SPRITES_STAGE
			ld		de,#4000+23*8*4
			jp		CARGA_COMUN_6

CARGA_2:

			ld		hl,SPRITES_2
			jp		CARGA_COMUN_1
CARGA_3:

			ld		hl,SPRITES_3
			jp		CARGA_COMUN_1
CARGA_4:

			ld		hl,SPRITES_4
			jp		CARGA_COMUN_1
CARGA_FINAL:

			ld		hl,SPRITES_FINAL
			jp		CARGA_COMUN_1
CARGA_FIREWORKS:

			ld		a,1
			ld		(FIREWORKS_ACTIVO),a
			ld		hl,SPRITES_FIREWORK
			jp		CARGA_COMUN_24
CARGA_V:

			ld		hl,SPRITE_CAMINO_CORRECTO
			ld		de,#4000+37*8*4
			jp		CARGA_COMUN_2
CARGA_X:

			ld		hl,SPRITE_CAMINO_INCORRECTO
			ld		de,#4000+37*8*4
			jp		CARGA_COMUN_2

CARGA_SKRULLEX:

			xor		a
			ld		(ALPHONSERRYX_ACTIVO),a
			ld		hl,SPRITES_SKRULLEX
			ld		de,#4000+46*8*4
			jp		CARGA_COMUN_4
CARGA_SKRULLEX_SLIME:

			ld		hl,SPRITES_SKRULLEX
			ld		de,#4000+46*8*4
			jp		CARGA_COMUN_8

CARGA_SLIME_FUEGO:

			ld		hl,SPRITES_SLIMES_FUEGO
			ld		de,#4000+50*8*4
			jp		CARGA_COMUN_4

CARGA_CORVELLINI_COVID:

			ld		hl,SPRITES_CORVELLINI
			ld		de,#4000+54*8*4
			jp		CARGA_COMUN_10
CARGA_ALFONSERRYX:

			ld		hl,SPRITES_ALPHONSERRYX
			ld		de,#4000+54*8*4
			jp		CARGA_COMUN_4

CARGA_ALFONSERRYX_STAGE_4:

			ld		a,1
			ld		(ALPHONSERRYX_ACTIVO),a
			ld		hl,SPRITES_ALPHONSERRYX
			ld		de,#4000+46*8*4
			jp		CARGA_COMUN_4

CARGA_MEGADEATH:

			ld		hl,SPRITES_MEGADEATH
			ld		de,#4000+54*8*4
			jp		CARGA_COMUN_6
CARGA_ECTO_PALLER:

			ld		hl,SPRITES_ECTO_PALLERS
			ld		de,#4000+50*8*4
			jp		CARGA_COMUN_4
CARGA_ECTO_PALLER_MUERTO:

			ld		hl,SPRITES_ECTO_MUERTO
			ld		de,#4000+50*8*4
			jp		CARGA_COMUN_4
CARGA_INCORRECTO:

			ld		hl,SPRITE_CAMINO_INCORRECTO
			ld		de,#4000+37*8*4
			jp		CARGA_COMUN_2

CARGA_CORRECTO:

			ld		hl,SPRITE_CAMINO_CORRECTO
			ld		de,#4000+37*8*4
			jp		CARGA_COMUN_2
CARGA_COMUN_1:

			ld		de,#4000+28*8*4
			ld		bc,1*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_1_FLECHA:

			ld		de,#4000+39*8*4
			ld		bc,1*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_2:

			ld		bc,2*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_4:

			ld		bc,4*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_6:

			ld		bc,6*8*4
			jp		TROZOS_COMUNES_15			
CARGA_COMUN_8:
			ld		bc,8*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_10:
			ld		bc,10*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_24:

			ld		de,#4000+25*8*4
			ld		bc,24*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_26:

			ld		de,#4000+23*8*4
			ld		bc,26*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_45:

			halt
			ld		de,#4000+1*8*4
			ld		bc,45*8*4
			call	TROZOS_COMUNES_15

		ld		hl,COLORES_DEPH_CASCOS_POSE_3

        call    PAGE_32_A_SEGMENT_2

		ld		de,#4840
		ld		bc,96
		call	PON_COLOR_2.sin_bc_impuesta
        jp    	PAGE_10_A_SEGMENT_2

CARGA_MUSICA_THE_BEST:

		call	stpmus

		ld		a,1
		ld		(MUSICA_BEST_ON),a
			
		ld		a,39
		call	CHANGE_BANK_2

		ld		hl,M_THE_BEST
		ld		(MUSIC_ON),hl
		call	INICIAMOS_MUSICA
		di
		call	strmus
		ei	
		jp		PAGE_10_A_SEGMENT_2
REVISA_LETRAS_DE_LA_FASE:

		ld		a,(TENEMOS_D)
		or		a
		ret		z
		ld		a,(TENEMOS_E)
		or		a
		ret		z
		ld		a,(TENEMOS_P)
		or		a
		ret		z
		ld		a,(TENEMOS_H)
		or		a
		ret		z
		ld		a,(TENEMOS_TODAS)
		inc		a
		ld		(TENEMOS_TODAS),a
		ret
REVISA_LETRAS_DE_TODAS_LAS_FASES:

		ld		a,(TENEMOS_TODAS)
		cp		5
		ret		z
SALTAMOS_EXTRA:

		push	hl
		ld		hl,16
		ld		(LINEA_A_LEER),hl
		pop		hl
		ret
DESCONECTA_PUPA:

		ld		a,1
		ld		(DESACTIVA_PUPA),a
		ret
CONTROL_BUCLES:

.INICIO_BUCLE:

		xor		a
		ld		(SUMA_BUCLE),a
		ld		hl,(LINEA_A_LEER)
		ld		de,1
		or		a
		adc		hl,de
		ld		(LINEA_DE_REGRESO_BUCLE),hl
		ret

.CONTROL_IZQUIERDA:

		ld		a,(X_DEPH)
		cp		5*16
		ret		nc
		ld		a,(SUMA_BUCLE)
		inc		a
		ld		(SUMA_BUCLE),a
		ret

.CONTROL_CENTRO:

		ld		a,(X_DEPH)
		cp		5*16
		ret		c
		cp		11*16
		ret		nc
		ld		a,(SUMA_BUCLE)
		inc		a
		ld		(SUMA_BUCLE),a
		ret

.CONTROL_DERECHA:

		ld		a,(X_DEPH)
		cp		11*16
		ret		c
		ld		a,(SUMA_BUCLE)
		inc		a
		ld		(SUMA_BUCLE),a
		ret

.CONTROL_SUMA_TRES_S5:

		ld		a,(SUMA_BUCLE)
		cp		3
		jp		z,.CONTINUA_S5

.REPITE_S5:

        ld      a,16
        ld      c,0
        call    A_31_DESDE_10   

		push	hl
		ld		hl,(LINEA_DE_REGRESO_BUCLE)
		ld		(LINEA_A_LEER),hl
		pop		hl

		call	CARGA_INCORRECTO
		call	NUEVO_CAMINO_INCORRECTO
		jp		CHECK_POINT.SALTO_PARA_OTROS_CARTELES

.CONTINUA_S5:

        ld      a,15
        ld      c,0
        call    A_31_DESDE_10   

		call	CARGA_CORRECTO
		call	NUEVO_CAMINO_CORRECTO
		jp		CHECK_POINT.SALTO_PARA_OTROS_CARTELES
PREPARAMOS_LOS_FX:

			xor		a
			ld		(LINEA_PSG_QUE_TOCA),a
			

			ld		hl,EFECTOS_DE_SONIDO
			jp		ayFX_SETUP

RECUPERA_SPRITES:
		
		ld		b,a
		ld		a,(SPRITE_CAIDO)
		or		a
		ld		a,b
		ret		z

		push	af

		xor		a
		ld		(SPRITE_CAIDO),a
		
		ld		hl,TODOS_LOS_SPRITES
		ld		de,#4020
		ld		bc,22*8*4
		call	PAGE_32_A_SEGMENT_2
		call	TROZOS_COMUNES_15

        ld      a,20
        ld      c,0
        CALL   	A_31_DESDE_10
		pop		af
		ret

        include "BASICOS/PROYECTILES.asm"
        include "BASICOS/ENEMIGOS.asm"
ENEMIGO_FINAL:

		pop		af										; Sacamos de la pila el ret anterior

PASAMOS_A_LA_SIGUIENTE_FASE:

		jp		$

        ds      #8000-$-#2200 

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 9 ******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 10******
 ****** SLOT   2 ******     Motor del juego 2
 **********************/

		org		#8000

        include	"BASICOS/MARCADOR.asm"
       	include	"BASICOS/SPRITE ON DEPH.asm"
    	include "BASICOS/SPRITE ON ENEMIGO.asm"
        include	"BASICOS/DATAS.asm"
		include	"BASICOS/TABLAS.asm"
        include	"BASICOS/LISTAS.asm"
		include	"AYUDA A NUCLEO.asm"


CARGA_SLOT_REGRESO_A_JUEGO:

		ld		a,(FASE)
		inc		a
		ld		(FASE),a

		ld		a,9
		ld      (DIRPA1),a											    ; Banco 1, pagina 39 del MEGAROM
        jp      COMIENZA_JUEGO

CARGA_SLOT_PARA_GAME_OVER:

		ld		a,38
		ld      (DIRPA1),a											    ; Banco 1, pagina 39 del MEGAROM
		jp		MOSTRAMOS_GAME_OVER

CARGA_SLOT_JUEGO_TRAS_GAME_OVER:

		ld		a,9
		ld      (DIRPA1),a											    ; Banco 1, pagina 39 del MEGAROM
		ret
VAMOS_A_BOSS_ADECUADO:

		ld		a,(FASE)
		add		25
		ld      (DIRPA1),a											    ; Banco 1, pagina 26-30 del MEGAROM
		jp		RUTINA_BOSS_1

AGILIZA_MAPA:

		ld		hl,20
		ld		(LINEA_A_LEER),hl
		jp		CONTROL.teclado
MENU:

		ld		a,0
		ld      (DIRPA1),a

		jp		TRAS_GAME_OVER_JUEGO_AQUI

CARGAMOS_PAGE_ROCKAGER:

		ld		a,38
		ld      (DIRPA1),a

		jp		ROCKAGER

VOLVEMOS_TRAS_ROCKAGER:

		ld		a,9
		ld      (DIRPA1),a

		ret

        ds		#C000-$



/**********************
 ****** PAGINA 10******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 11******
 ****** SLOT   2 ******     fase 1-1
 **********************/

		org		#8000

GRAFICOS_FASE_1_1:

			incbin 	"GRAFICOS/FASE1-1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 11******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 12******
 ****** SLOT   2 ******     Fase 2-1
 **********************/

		org		#8000

GRAFICOS_FASE_2_1:

			incbin 	"GRAFICOS/FASE2-1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 12******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 13******
 ****** SLOT   2 ******     fase 3-1
 **********************/

		org		#8000

GRAFICOS_FASE_3_1:

			incbin 	"GRAFICOS/FASE3-1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 13******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 14******
 ****** SLOT   2 ******     Fase 4-1
 **********************/

		org		#8000

GRAFICOS_FASE_4_1:

			incbin 	"GRAFICOS/FASE4-1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 14******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 15******
 ****** SLOT   2 ******     fase 5-1
 **********************/

		org		#8000

GRAFICOS_FASE_5_1:

			incbin 	"GRAFICOS/FASE5-1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 15******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 16******
 ****** SLOT   2 ******     Fase 1-2
 **********************/

		org		#8000

GRAFICOS_FASE_1_2:

			incbin 	"GRAFICOS/FASE1-2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 16******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 17******
 ****** SLOT   2 ******     fase 2-2
 **********************/

		org		#8000

GRAFICOS_FASE_2_2:

			incbin 	"GRAFICOS/FASE2-2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 17******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 18******
 ****** SLOT   2 ******     Fase 3-2
 **********************/

		org		#8000

GRAFICOS_FASE_3_2:

			incbin 	"GRAFICOS/FASE3-2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 18******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 19******
 ****** SLOT   2 ******     fase 4-2
 **********************/

		org		#8000

GRAFICOS_FASE_4_2:

			incbin 	"GRAFICOS/FASE4-2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 19******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 20******
 ****** SLOT   2 ******     Fase 5-2
 **********************/

		org		#8000

GRAFICOS_FASE_5_2:

			incbin 	"GRAFICOS/FASE5-2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 20******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 21******
 ****** SLOT   2 ******     Musica
 **********************/

		org		#8000

M_STAGE_1:

		incbin 	"AUDIOS/STAGE 1.mbm"

		ds		#8000+4400-$

M_BOSS_1:

		incbin	"AUDIOS/BOSS 1.mbm"

		ds		#8000+4400+3800-$

M_BONUS_1:

		incbin	"AUDIOS/BONUS.mbm"
        
		ds      #8000+4400+3800+3800-$    

M_FANFARE_1:

		incbin 	"AUDIOS/S1_INTRO.mbm"

		ds      #8000+4400+3800+3800+600-$    

M_WIN_1:

		incbin 	"AUDIOS/CLEAR.mbm"

M_GAME_OVER_1:

		incbin	"AUDIOS/GAMEOVER.MBM"

        ds		#C000-$

/**********************
 ****** PAGINA 21******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 22******
 ****** SLOT   2 ******     Musica
 **********************/

		org		#8000

M_STAGE_2:

		incbin 	"AUDIOS/STAGE 2.mbm"


		ds		#8000+4400-$

M_BOSS_2:

		incbin	"AUDIOS/BOSS 2.mbm"

		ds		#8000+4400+3800-$

M_BONUS_2:

		incbin	"AUDIOS/BONUS.mbm"
        
		ds      #8000+4400+3800+3800-$    

M_FANFARE_2:

		incbin 	"AUDIOS/S2_INTRO.mbm"

		ds      #8000+4400+3800+3800+600-$    

M_WIN_2:

		incbin 	"AUDIOS/CLEAR.mbm"

M_GAME_OVER_2:

		incbin	"AUDIOS/GAMEOVER.MBM"

M_INTRO_BOSS_2:

		incbin 	"AUDIOS/BOSS 2 INTRO.MBM"

        ds		#C000-$

/**********************
 ****** PAGINA 22******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 23******
 ****** SLOT   2 ******     Musica
 **********************/

		org		#8000

M_STAGE_3:

		incbin 	"AUDIOS/STAGE 3.mbm"

		ds		#8000+4400-$

M_BOSS_3:

		incbin	"AUDIOS/BOSS 1.mbm"

		ds		#8000+4400+3800-$

M_BONUS_3:

		incbin	"AUDIOS/BONUS.mbm"
        
		ds      #8000+4400+3800+3800-$    

M_FANFARE_3:

		incbin 	"AUDIOS/S3_INTRO.mbm"

		ds      #8000+4400+3800+3800+600-$    

M_WIN_3:

		incbin 	"AUDIOS/CLEAR.mbm"

M_GAME_OVER_3:

		incbin	"AUDIOS/GAMEOVER.MBM"

        ds		#C000-$

/**********************
 ****** PAGINA 23******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 24******
 ****** SLOT   2 ******     Musica
 **********************/

		org		#8000

M_STAGE_4:

		incbin 	"AUDIOS/STAGE 4.mbm"


		ds		#8000+4400-$

M_BOSS_4:

		incbin	"AUDIOS/BOSS 1.mbm"

		ds		#8000+4400+3800-$

M_BONUS_4:

		incbin	"AUDIOS/BONUS.mbm"
        
		ds      #8000+4400+3800+3800-$    

M_FANFARE_4:

		incbin 	"AUDIOS/S4_INTRO.mbm"

		ds      #8000+4400+3800+3800+600-$    

M_WIN_4:

		incbin 	"AUDIOS/CLEAR.mbm"

M_GAME_OVER_4:

		incbin	"AUDIOS/GAMEOVER.MBM"

        ds		#C000-$

/**********************
 ****** PAGINA 24******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 25******
 ****** SLOT   2 ******     Musica
 **********************/

		org		#8000

M_STAGE_5:

		incbin 	"AUDIOS/STAGE 5.mbm"


		ds		#8000+4400-$

M_BOSS_5:

		incbin	"AUDIOS/BOSS 5.mbm"

		ds		#8000+4400+3800-$

M_BONUS_5:

		incbin	"AUDIOS/BONUS.mbm"
        
		ds      #8000+4400+3800+3800-$    

M_FANFARE_5:

		incbin 	"AUDIOS/S5_INTRO.mbm"

		ds      #8000+4400+3800+3800+600-$    

M_WIN_5:

		incbin 	"AUDIOS/CLEAR.mbm"

M_GAME_OVER_5:

		incbin	"AUDIOS/GAMEOVER.MBM"

        ds		#C000-$

/**********************
 ****** PAGINA 25******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 26******
 ****** SLOT   2 ******     Boss
 **********************/

		org		#4000

RUTINA_BOSS_1:

		include	"AUDIOS/INICIA MUSICA_BOSS.asm"

; todo el codigo de enfrentamiento
PULSA_UNA_TECLA_PARA_SEGUIR_b1:

		xor		a
		call	GTTRIG_RAM
		or		a
		jp		z,PULSA_UNA_TECLA_PARA_SEGUIR_b1

TERMINANDO_LA_BATALLA_b1:

		include	"AUDIOS/INICIA MUSICA_WIN.asm"

CAMINITO_A_PUERTA_b1:

		include	"VARIOS USOS/PASEITO HASTA PUERTA.asm"		
SALUDO_b1:

		include	"VARIOS USOS/SALUDO_GANA_FASE.asm"		
FADE_DEPH_b1:

;		ld		hl,FADE_DEPH_A_NEGRO_b1
;		include	"VARIOS USOS/FADE DEPH SALIENDO DE ESCENA.asm"
ULTIMO_DESPLAZAMIENTO_b1:

		include	"VARIOS USOS/PASEITO DENTRO DE PUERTA.asm"		

VOLVEMOS_b1:

		jp		CARGA_SLOT_REGRESO_A_JUEGO

FADE_DEPH_A_NEGRO_b1:

		incbin	"PALETAS/BOSS1 DEPH.FADEOUT"

FADE_FASE_1_3_A_NEGRO_b1:

		incbin	"PALETAS/BOSS1.fadeout"

        ds      #8000-$-#2200                                           ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        
		
        ds		#8000-$

/**********************
 ****** PAGINA 26******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 27******
 ****** SLOT   2 ******     Boss
 **********************/

		org		#4000

		include	"BOSS 2 PARTE 1.asm"

        ds      #8000-$-#2200                                           ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 27******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 28******
 ****** SLOT   2 ******     Boss
 **********************/

		org		#4000

RUTINA_BOSS_3:

		include	"AUDIOS/INICIA MUSICA_BOSS.asm"

; todo el codigo de enfrentamiento
PULSA_UNA_TECLA_PARA_SEGUIR_b3:

		xor		a
		call	GTTRIG_RAM
		or		a
		jp		z,PULSA_UNA_TECLA_PARA_SEGUIR_b3

TERMINANDO_LA_BATALLA_b3:

		include	"AUDIOS/INICIA MUSICA_WIN.asm"

CAMINITO_A_PUERTA_b3:

		include	"VARIOS USOS/PASEITO HASTA PUERTA.asm"		
SALUDO_b3:

		include	"VARIOS USOS/SALUDO_GANA_FASE.asm"		

FADE_DEPH_b3:

;		ld		hl,FADE_DEPH_A_NEGRO_b3
;		include	"VARIOS USOS/FADE DEPH SALIENDO DE ESCENA.asm"

ULTIMO_DESPLAZAMIENTO_b3:

		include	"VARIOS USOS/PASEITO DENTRO DE PUERTA.asm"	
VOLVEMOS_b3:

		jp		CARGA_SLOT_REGRESO_A_JUEGO

FADE_DEPH_A_NEGRO_b3:

		incbin	"PALETAS/BOSS3 DEPH.FADEOUT"

FADE_FASE_1_3_A_NEGRO_b3:

		incbin	"PALETAS/BOSS3.fadeout"

        ds      #8000-$-#2200                                           ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 28******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 29******
 ****** SLOT   2 ******     Boss
 **********************/

		org		#4000

RUTINA_BOSS_4:

		include	"AUDIOS/INICIA MUSICA_BOSS.asm"

; todo el codigo de enfrentamiento
PULSA_UNA_TECLA_PARA_SEGUIR_b4:

		xor		a
		call	GTTRIG_RAM
		or		a
		jp		z,PULSA_UNA_TECLA_PARA_SEGUIR_b4
TERMINANDO_LA_BATALLA_b4:

		include	"AUDIOS/INICIA MUSICA_WIN.asm"

CAMINITO_A_PUERTA_b4:

		include	"VARIOS USOS/PASEITO HASTA PUERTA.asm"		
SALUDO_b4:

		include	"VARIOS USOS/SALUDO_GANA_FASE.asm"		

FADE_DEPH_b4:

;		ld		hl,FADE_DEPH_A_NEGRO_b4
;		include	"VARIOS USOS/FADE DEPH SALIENDO DE ESCENA.asm"

ULTIMO_DESPLAZAMIENTO_b4:

		include	"VARIOS USOS/PASEITO DENTRO DE PUERTA.asm"	
VOLVEMOS_b4:

		jp		CARGA_SLOT_REGRESO_A_JUEGO

FADE_DEPH_A_NEGRO_b4:

		incbin	"PALETAS/BOSS4 DEPH.FADEOUT"

FADE_FASE_1_3_A_NEGRO_b4:

		incbin	"PALETAS/BOSS4.fadeout"

        ds      #8000-$-#2200                                           ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 29******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 30******
 ****** SLOT   2 ******     Boss
 **********************/

		org		#4000

RUTINA_BOSS_5:

		include	"AUDIOS/INICIA MUSICA_BOSS.asm"

; todo el codigo de enfrentamiento
PULSA_UNA_TECLA_PARA_SEGUIR_b5:

		xor		a
		call	GTTRIG_RAM
		or		a
		jp		z,PULSA_UNA_TECLA_PARA_SEGUIR_b5
TERMINANDO_LA_BATALLA_b5:

		include	"AUDIOS/INICIA MUSICA_WIN.asm"

CAMINITO_A_PUERTA_b5:

		include	"VARIOS USOS/PASEITO HASTA PUERTA.asm"		
SALUDO_b5:

		include	"VARIOS USOS/SALUDO_GANA_FASE.asm"		

FADE_DEPH_b5:

;		ld		hl,FADE_DEPH_A_NEGRO_b5
;		include	"VARIOS USOS/FADE DEPH SALIENDO DE ESCENA.asm"

ULTIMO_DESPLAZAMIENTO_b5:

		include	"VARIOS USOS/PASEITO DENTRO DE PUERTA.asm"	
VOLVEMOS_b5:

		jp		CARGA_SLOT_REGRESO_A_JUEGO

FADE_DEPH_A_NEGRO_b5:

		incbin	"PALETAS/BOSS5 DEPH.FADEOUT"

FADE_FASE_1_3_A_NEGRO_b5:

		incbin	"PALETAS/BOSS5.fadeout"

        ds      #8000-$-#2200                                           ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 30******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 31******
 ****** SLOT   2 ******     Fx
 **********************/

		org		#8000
EFECTOS_DE_SONIDO:

			incbin	"AUDIOS/FX.afb"

        ds		#C000-$

/**********************
 ****** PAGINA 31******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 32******
 ****** SLOT   2 ******     Sprites y rayos
 **********************/

		org		#8000

		include	"GRAFICOS/SPRITES.asm"
		include "PALETAS/COLORES SPRITES.asm"
RAYOS_EN_PACK:

		incbin 	"GRAFICOS/RAYOS_48x112.DAT"	        
COPIA_RAYOS_A_VRAM:

		dw	#C0,#0300,48,112
		db	#00,#00,#F0
		
        ds		#C000-$

/**********************
 ****** PAGINA 32******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 33******
 ****** SLOT   2 ******     Mapa
 **********************/

		org		#8000

MAPA_CONSTANTE_FASE_1:	

		include	"MAPAS/CONSTANTE FASE 1.asm"

        include "MAPAS/EVENTOS FASE 1.asm"
PALETA_STAGE_1_1:

		incbin "PALETAS/FASE1-1.PALETE"
PALETA_STAGE_1_2_1:

		incbin "PALETAS/FASE1-2-1.PALETE"

PALETA_STAGE_1_2_2:

		incbin "PALETAS/FASE1-2-2.PALETE"
		
PALETA_STAGE_1_2_3:

		incbin "PALETAS/FASE1-2-3.PALETE"

PALETA_STAGE_1_2_4:

		incbin "PALETAS/FASE1-2-4.PALETE"

PALETA_STAGE_1_2_5:

		incbin "PALETAS/FASE1-2-5.PALETE"
		
PALETA_STAGE_1_2_6:

		incbin "PALETAS/FASE1-2-6.PALETE"
PALETA_STAGE_1_3:

		incbin "PALETAS/FASE1-3.PALETE"
PALETA_STAGE_1_1_FADE_OUT:

		incbin "PALETAS/FASE1-1.FADOUT"

PALETA_STAGE_1_1_FADE_IN:

		incbin "PALETAS/FASE1-1.FADIN"		

PALETA_STAGE_1_2_FADE_OUT:

		incbin "PALETAS/FASE1-1.FADOUT"

PALETA_STAGE_1_2_FADE_IN:

		incbin "PALETAS/FASE1-1.FADIN"		

PALETA_STAGE_1_3_FADE_OUT:

		incbin "PALETAS/FASE1-1.FADOUT"

PALETA_STAGE_1_3_FADE_IN:

		incbin "PALETAS/FASE1-1.FADIN"		

PALETA_GRISES_STAGE_1:

		incbin "PALETAS/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_1:

		incbin "PALETAS/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_1:

		incbin "PALETAS/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_1:

		incbin "PALETAS/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_1:

		incbin	"PALETAS/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_1:

		incbin	"PALETAS/BLANCOS A NEGROS.FADEOUT"

        ds		#C000-$

/**********************
 ****** PAGINA 33******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 34******
 ****** SLOT   2 ******     Mapa
 **********************/

		org		#8000

MAPA_CONSTANTE_FASE_2:	

		include	"MAPAS/CONSTANTE FASE 2.asm"

        include "MAPAS/EVENTOS FASE 2.asm"

PALETA_STAGE_2_1:

		incbin "PALETAS/FASE2-1.PALETE"
PALETA_STAGE_2_2_1:

		incbin "PALETAS/FASE2-2-1.PALETE"

PALETA_STAGE_2_2_2:

		incbin "PALETAS/FASE2-2-2.PALETE"
		
PALETA_STAGE_2_2_3:

		incbin "PALETAS/FASE2-2-3.PALETE"

PALETA_STAGE_2_2_4:

		incbin "PALETAS/FASE2-2-4.PALETE"

PALETA_STAGE_2_2_5:

		incbin "PALETAS/FASE2-2-5.PALETE"
		
PALETA_STAGE_2_2_6:

		incbin "PALETAS/FASE2-2-6.PALETE"

PALETA_STAGE_2_3:

		incbin "PALETAS/FASE2-3.PALETE"

PALETA_STAGE_2_1_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_2_1_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_2_2_FADE_OUT:

		incbin "PALETAS/FASE2-2.FADOUT"

PALETA_STAGE_2_2_FADE_IN:

		incbin "PALETAS/FASE2-2.FADIN"		

PALETA_STAGE_2_3_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_2_3_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"		

PALETA_GRISES_STAGE_2:

		incbin "PALETAS/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_2:

		incbin "PALETAS/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_2:

		incbin "PALETAS/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_2:

		incbin "PALETAS/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_2:

		incbin	"PALETAS/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_2:

		incbin	"PALETAS/BLANCOS A NEGROS.FADEOUT"

        ds		#C000-$

/**********************
 ****** PAGINA 34******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 35******
 ****** SLOT   2 ******     Mapa
 **********************/

		org		#8000

MAPA_CONSTANTE_FASE_3:	

		include	"MAPAS/CONSTANTE FASE 3.asm"

        include "MAPAS/EVENTOS FASE 3.asm"

PALETA_STAGE_3_1:

		incbin "PALETAS/GRISES.PALETE"
PALETA_STAGE_3_2_1:

		incbin "PALETAS/OSCURO.PALETE"

PALETA_STAGE_3_2_2:

		incbin "PALETAS/OSCURO.PALETE"
		
PALETA_STAGE_3_2_3:

		incbin "PALETAS/OSCURO.PALETE"

PALETA_STAGE_3_2_4:

		incbin "PALETAS/OSCURO.PALETE"

PALETA_STAGE_3_2_5:

		incbin "PALETAS/OSCURO.PALETE"
		
PALETA_STAGE_3_2_6:

		incbin "PALETAS/OSCURO.PALETE"

PALETA_STAGE_3_3:

		incbin "PALETAS/OSCURO.PALETE"

PALETA_STAGE_3_1_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_3_1_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_3_2_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_3_2_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"		

PALETA_STAGE_3_3_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_3_3_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"		

PALETA_GRISES_STAGE_3:

		incbin "PALETAS/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_3:

		incbin "PALETAS/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_3:

		incbin "PALETAS/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_3:

		incbin "PALETAS/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_3:

		incbin	"PALETAS/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_3:

		incbin	"PALETAS/BLANCOS A NEGROS.FADEOUT"


        ds		#C000-$

/**********************
 ****** PAGINA 35******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 36******
 ****** SLOT   2 ******     Mapa
 **********************/

		org		#8000

MAPA_CONSTANTE_FASE_4:	

		include	"MAPAS/CONSTANTE FASE 4.asm"

        include "MAPAS/EVENTOS FASE 4.asm"

PALETA_STAGE_4_1:

		incbin "PALETAS/FASE4-1.PALETE"
PALETA_STAGE_4_2_1:

		incbin "PALETAS/FASE4-2-6.PALETE"

PALETA_STAGE_4_2_2:

		incbin "PALETAS/FASE4-2-5.PALETE"
		
PALETA_STAGE_4_2_3:

		incbin "PALETAS/FASE4-2-4.PALETE"

PALETA_STAGE_4_2_4:

		incbin "PALETAS/FASE4-2-3.PALETE"

PALETA_STAGE_4_2_5:

		incbin "PALETAS/FASE4-2-2.PALETE"
		
PALETA_STAGE_4_2_6:

		incbin "PALETAS/FASE4-2-1.PALETE"

PALETA_STAGE_4_3:

		incbin "PALETAS/OSCURO.PALETE"

PALETA_STAGE_4_1_FADE_OUT:

		incbin "PALETAS/FASE4-1.FADOUT"

PALETA_STAGE_4_1_FADE_IN:

		incbin "PALETAS/FASE4-1.FADIN"

PALETA_STAGE_4_2_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_4_2_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"		

PALETA_STAGE_4_3_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_4_3_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"		

PALETA_GRISES_STAGE_4:

		incbin "PALETAS/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_4:

		incbin "PALETAS/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_4:

		incbin "PALETAS/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_4:

		incbin "PALETAS/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_4:

		incbin	"PALETAS/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_4:

		incbin	"PALETAS/BLANCOS A NEGROS.FADEOUT"

        ds		#C000-$

/**********************
 ****** PAGINA 36******
 ******   END    ******
 **********************/



/**********************
 ****** PAGINA 37******
 ****** SLOT   2 ******     Mapa
 **********************/

		org		#8000

MAPA_CONSTANTE_FASE_5:	

		include	"MAPAS/CONSTANTE FASE 5.asm"

        include "MAPAS/EVENTOS FASE 5.asm"

PALETA_STAGE_5_1:

		incbin "PALETAS/FASE5-1.PALETE"
PALETA_STAGE_5_2_1:

		incbin "PALETAS/FASE5-2-1.PALETE"

PALETA_STAGE_5_2_2:

		incbin "PALETAS/FASE5-2-2.PALETE"
		
PALETA_STAGE_5_2_3:

		incbin "PALETAS/FASE5-2-3.PALETE"

PALETA_STAGE_5_2_4:

		incbin "PALETAS/FASE5-2-4.PALETE"

PALETA_STAGE_5_2_5:

		incbin "PALETAS/FASE5-2-5.PALETE"
		
PALETA_STAGE_5_2_6:

		incbin "PALETAS/FASE5-2-6.PALETE"

PALETA_STAGE_5_3:

		incbin "PALETAS/OSCURO.PALETE"

PALETA_STAGE_5_1_FADE_OUT:

		incbin "PALETAS/FASE5-1.FADOUT"

PALETA_STAGE_5_1_FADE_IN:

		incbin "PALETAS/FASE5-1.FADIN"
PALETA_STAGE_5_2_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_5_2_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"		

PALETA_STAGE_5_3_FADE_OUT:

		incbin "PALETAS/OSCURO.FADES"

PALETA_STAGE_5_3_FADE_IN:

		incbin "PALETAS/OSCURO.FADES"		

PALETA_GRISES_STAGE_5:

		incbin "PALETAS/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_5:

		incbin "PALETAS/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_5:

		incbin "PALETAS/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_5:

		incbin "PALETAS/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_5:

		incbin	"PALETAS/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_5:

		incbin	"PALETAS/BLANCOS A NEGROS.FADEOUT"


        ds		#C000-$

/**********************
 ****** PAGINA 37******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 38******
 ****** SLOT   1 ******     Semi Boss page 1
 **********************/

		org		#4000

		include "BASICOS/GAME OVER 2.asm"

		include	"BASICOS/ROCKAGER.asm"

        ds      #8000-$-#2200                                           ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 38******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 39******
 ****** SLOT   1 ******     Música you're the best
 **********************/

		org		#8000

M_THE_BEST:

		incbin	"AUDIOS/THE BEST.mbm"

        ds		#c000-$

/**********************
 ****** PAGINA 39******
 ******   END    ******
 **********************/
/**********************
 ****** PAGINA 40 *****
 ****** SLOT   2 ******     gráficos de marca parte 1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

GRAFICOS_MOAI_2:

        incbin  "GRAFICOS/SOLOTITULO2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 40 *****
 ******   END    ******
 **********************/
 /**********************
  ****** PAGINA 41 *****
  ****** SLOT   2 ******     gráficos de marca parte 1
  **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

GRAFICOS_MOAI_3:

        incbin  "GRAFICOS/SOLOTITULO3.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 41 *****
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 42 ******
 ****** SLOT   2 ******     graficos Rockager 1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/ROCKAGER1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 42 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 43 ******
 ****** SLOT   2 ******     graficos Rockager 2
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/ROCKAGER2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 43 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 44******
 ****** SLOT   1 ******     Semi Boss page 2
 **********************/

		org		#4000

		include	"BASICOS/ROCKAGER_2.asm"

        ds      #8000-$-#2200                                           ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 44******
 ******   END    ******
 **********************/

  /**********************
 ****** PAGINA 45 ******
 ****** SLOT   2 ******     graficos menu
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/STATUS SEMIBOSS 2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 45 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 46 ******
 ****** SLOT   2 ******     graficos Daveatnix 1-1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES DAVEATNIX 11.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 46 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 47 ******
 ****** SLOT   2 ******     graficos Daveatnix 1-2
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES DAVEATNIX 12.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 47 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 48 ******
 ****** SLOT   2 ******     graficos Daveatnix 2-1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES DAVEATNIX 21.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 48 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 49 ******
 ****** SLOT   2 ******     graficos Daveatnix 2-2
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES DAVEATNIX 22.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 49 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 50 ******
 ****** SLOT   2 ******     graficos Agonix 1-1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES AGONIX 11.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 50 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 51 ******
 ****** SLOT   2 ******     graficos Agonix 1-2
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES AGONIX 12.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 51 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 52 ******
 ****** SLOT   2 ******     graficos Agonix 2-1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES AGONIX 21.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 52 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 53 ******
 ****** SLOT   2 ******     graficos Agonix 2-2
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES AGONIX 22.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 53 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 54 ******
 ****** SLOT   2 ******     graficos Idius 1-1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES IDIUS 11.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 54 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 55 ******
 ****** SLOT   2 ******     graficos Idius 1-2
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

        incbin  "GRAFICOS/TILES IDIUS 12.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 55 ******
 ******   END    ******
 **********************/
