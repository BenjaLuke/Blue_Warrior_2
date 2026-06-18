        output "BW2.ROM"

BIOS_KERNEL:

		include "BASICOS/BIOS.asm"				                        ; Incluímos las referencias a la BIOS

VARIABLES:

		include	"BASICOS/VARIABLES.asm"				                    ; Incluímos las referencias a las variables que se usarán en el juego
		include	"BOSSES/VARIABLES BOSSES.asm"

/**********************
 ****** PAGINA 0 ******
 ****** SLOT   1 ******     
 **********************/    
		org		#4000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 0 - Preparacion y animación de marca
				
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

MARCA:
        include "MENU Y TRANSICIONES/ANIMACION DE MARCA sc7.asm" 

        include "AUDIOS/FMPAC FOUND.asm"

        ds      #8000-$-#2200   
				                                        ; Colocamos el resto del programa siempre en el mismo sitio    
		include "BASICOS/RUTINAS CERRADAS (con etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (con etiquetas).asm"
        include "PALETAS/PALETAS (con etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (con etiquetas).asm"        

        ds		#8000-$

/**********************
 ****** PAGINA 0 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 1 ******
 ****** SLOT   2 ******     
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 1 - gráficos de marca parte 1

GRAFICOS_MOAI_1:

        incbin  "GRAFICOS/PRESENTACIONES/SOLOTITULO1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 1 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 2 ******
 ****** SLOT   2 ******    
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 2 - Caambio de page a menú

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
; RESUMEN: 3 - Cinemáticas y pantalla de push space key 

		include	"MENU Y TRANSICIONES/MENU.asm"
		; Menu reducido a espera de tecla. Espacio libre reservado para futuras necesidades.

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
 ****** SLOT   2 ******     graficos presentación
 **********************/
		org		#8000													
; RESUMEN: 4 - Gráficos de push space key

PANTALLA_DE_PRESENTACION_1:

		incbin  "GRAFICOS/PRESENTACIONES/DIBUJO_MENU1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 4 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 5 ******
 ****** SLOT   2 ******     graficos presentación Y PALETAS DE PRESENTACION
 **********************/
		org		#8000													
; RESUMEN: 5 - Gráficos de presentación y las paletas

PANTALLA_DE_PRESENTACION_2:

		incbin  "GRAFICOS/PRESENTACIONES/DIBUJO_MENU2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 5 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 6 ******
 ****** SLOT   2 ******     libre para necesidades del menu
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 6 - Gráficos de cinematica parte 7-8 (Parte 1)
CINEMATICA_7_8_1:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA7Y8-1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 6 ******
 ******   END    ******
 **********************/


/**********************
 ****** PAGINA 7 ******
 ****** SLOT   2 ******     
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 7 - Gráficos de cinematica parte 5-6 (Parte 1)
CINEMATICA_5_6_1:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA5Y6-1.DAT"

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
; RESUMEN: 8 - Gráf. cinemat. p. 5-6 (Part 2) y slot1
CINEMATICA_5_6_2:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA5Y6-2.DAT"

CARGA_SLOT_JUEGO:

		ld		a,9
		ld      (DIRPA1),a											; Banco 1, pagina 3 del MEGAROM
        jp      COMIENZA_JUEGO

CARGA_SLOT_MAPA:

		ld		a,68
		ld      (DIRPA1),a											    ; Banco 1, pagina 39 del MEGAROM
		jp      MUESTRA_MAPA

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
; RESUMEN: 9 - Motor del juego 1

		include "MOTOR/NUCLEOBW2_1.asm"				                            ; Incluímos el motor del juego 1

        ds      #8000-$-#2200 

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

REANUDA_MUSICA_DESDE_SLOT1:

            ld      a,(MUSICA_ON_OFF)
            or      a
            ret     z

            di
            ld      a,(FASE)
            add     20
            call    CHANGE_BANK_2
            call    cntmus
            call    PAGE_10_A_SEGMENT_2
            ei
            ret

INICIA_MUSICA_EXTRA:

			include "AUDIOS/INICIA MUSICA_EXTRA.asm"
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
; RESUMEN: 10 - Motor del juego 2

        include	"BASICOS/MARCADOR.asm"
       	include	"BASICOS/SPRITE ON DEPH.asm"
    	include "BASICOS/SPRITE ON ENEMIGO.asm"
        include	"BASICOS/DATAS.asm"
		include	"BASICOS/TABLAS.asm"
        include	"BASICOS/LISTAS.asm"
		include	"MOTOR/NUCLEOBW2_2.asm"


CARGA_SLOT_REGRESO_A_JUEGO:

		ld		a,(FASE)
		inc		a
		ld		(FASE),a

		ld		b,150   												; Pausa para que termine la musica fanfarria de ganar a boss

.ESPERA_MUSICA_ANTERIOR_TRAS_BOSS:

		halt
		djnz	.ESPERA_MUSICA_ANTERIOR_TRAS_BOSS

		di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a

		ld 		a,(RG0SAV)												; Disable Line Interrupt: Reset R#0 bit 4
		and		11101111B
		ld		(RG0SAV),a
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM
		ei

		ld		a,68
		ld      (DIRPA1),a											    ; Banco 1, pagina 39 del MEGAROM
        jp      MUESTRA_MAPA_TRAS_BOSS

CARGA_SLOT_PARA_GAME_OVER:

		di

		ld		a,38
		ld      (DIRPA1),a											    ; Banco 1, pagina 39 del MEGAROM
		jp		MOSTRAMOS_GAME_OVER

CARGA_SLOT_JUEGO_TRAS_GAME_OVER:

		di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a

		ld		a,10
		ld		(DIRPA2),a

		ld		a,9
		ld      (DIRPA1),a											    ; Banco 1, pagina 39 del MEGAROM
		ret
VAMOS_A_BOSS_ADECUADO:

		ld		a,(FASE)
		add		25
		ld      (DIRPA1),a											    ; Banco 1, pagina 26-30 del MEGAROM
		jp		RUTINA_BOSS_1

MUERTE_POR_TOQUES_DESDE_BOSS:

		ld		a,9
		ld      (DIRPA1),a
		jp		MUERTE_POR_TOQUES

AGILIZA_MAPA:

		ld		hl,40
		ld		(LINEA_A_LEER),hl
		jp		CONTROL.teclado

HACIA_CINEMATICAS_FINALES:

		; CAMBIA EL SLOT 1 Y PONE EL SECTOR 67
		ld		a,67
		ld      (DIRPA1),a											    ; Banco 1, pagina
		jp		CINEMATICAS_FINALES

MENU:

		di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a
		ld		sp,0xE500
		ld 		a,(RG0SAV)
		and		11101111B
		ld		(RG0SAV),a
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM

		ld		a,0
		ld      (DIRPA1),a

		jp		MARCA

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
; RESUMEN: 11 - Gráficos de fase 1 parte 1

GRAFICOS_FASE_1_1:

			incbin 	"GRAFICOS/FASES/FASE1-1.DAT"

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
; RESUMEN: 12 - Gráficos de fase 2 parte 1 

GRAFICOS_FASE_2_1:

			incbin 	"GRAFICOS/FASES/FASE2-1.DAT"

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
; RESUMEN: 13 - Gráficos de fase 3 parte 1

GRAFICOS_FASE_3_1:

			incbin 	"GRAFICOS/FASES/FASE3-1.DAT"

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
; RESUMEN: 14 - Gráficos de fase 4 parte 1

GRAFICOS_FASE_4_1:

			incbin 	"GRAFICOS/FASES/FASE4-1.DAT"

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
; RESUMEN: 15 - Gráficos de fase 5 parte 1

GRAFICOS_FASE_5_1:

			incbin 	"GRAFICOS/FASES/FASE5-1.DAT"

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
; RESUMEN: 16 - Gráficos de fase 1 parte 2

GRAFICOS_FASE_1_2:

			incbin 	"GRAFICOS/FASES/FASE1-2.DAT"

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
; RESUMEN: 17 - Gráficos de fase 2 parte 2

GRAFICOS_FASE_2_2:

			incbin 	"GRAFICOS/FASES/FASE2-2.DAT"

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
; RESUMEN: 18 - Gráficos de fase 3 parte 2

GRAFICOS_FASE_3_2:

			incbin 	"GRAFICOS/FASES/FASE3-2.DAT"

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
; RESUMEN: 19 - Gráficos de fase 4 parte 2

GRAFICOS_FASE_4_2:

			incbin 	"GRAFICOS/FASES/FASE4-2.DAT"

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
; RESUMEN: 20 - Gráficos de fase 5 parte 2

GRAFICOS_FASE_5_2:

			incbin 	"GRAFICOS/FASES/FASE5-2.DAT"

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
; RESUMEN: 21 - Músicas de la fase 1 

M_STAGE_1:

		incbin 	"AUDIOS/TEMAS/FASE 1/STAGE 1.mbm"
		ds		#8000+4400-$

M_BOSS_1:

		incbin	"AUDIOS/TEMAS/FASE 1/BOSS 1.mbm"
		ds		#8000+4400+3800-$

M_FANFARE_1:

		incbin 	"AUDIOS/TEMAS/FASE 1/S1_INTRO.mbm"
		ds      #8000+4400+3800+600-$    

M_WIN_1:

		incbin 	"AUDIOS/TEMAS/OTRAS/FASE_WIN.mbm"
		ds		#8000+4400+3800+600+670-$

M_GAME_OVER_1:

		incbin	"AUDIOS/TEMAS/OTRAS/GAME_OVER.MBM"
		ds		#8000+4400+3800+600+670+2070-$
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
; RESUMEN: 22 - Músicas de la fase 2
M_STAGE_2:

		incbin 	"AUDIOS/TEMAS/FASE 2/STAGE 2.mbm"
		ds		#8000+4400-$

M_BOSS_2:

		incbin	"AUDIOS/TEMAS/FASE 2/BOSS 2.mbm"
		ds		#8000+4400+3800-$

M_FANFARE_2:

		incbin 	"AUDIOS/TEMAS/FASE 2/S2_INTRO.mbm"
		ds      #8000+4400+3800+600-$    

M_WIN_2:

		incbin 	"AUDIOS/TEMAS/OTRAS/FASE_WIN.mbm"
		ds		#8000+4400+3800+600+670-$

M_GAME_OVER_2:

		incbin	"AUDIOS/TEMAS/OTRAS/GAME_OVER.MBM"
		ds		#8000+4400+3800+600+670+2070-$

M_INTRO_BOSS_2:

		incbin 	"AUDIOS/TEMAS/FASE 2/BOSS 2 INTRO.MBM"
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
; RESUMEN: 23 - Músicas de la fase 3
M_STAGE_3:

		incbin 	"AUDIOS/TEMAS/FASE 3/STAGE 3.mbm"
		ds		#8000+4400-$

M_BOSS_3:

		incbin	"AUDIOS/TEMAS/FASE 3/BOSS 3.mbm"
		ds		#8000+4400+3800-$

M_FANFARE_3:

		incbin 	"AUDIOS/TEMAS/FASE 3/S3_INTRO.mbm"
		ds      #8000+4400+3800+600-$    

M_WIN_3:

		incbin 	"AUDIOS/TEMAS/OTRAS/FASE_WIN.mbm"
		ds		#8000+4400+3800+600+670-$

M_GAME_OVER_3:

		incbin	"AUDIOS/TEMAS/OTRAS/GAME_OVER.MBM"
		ds		#8000+4400+3800+600+670+2070-$
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
; RESUMEN: 24 - Músicas de la fase 4
M_STAGE_4:

		incbin 	"AUDIOS/TEMAS/FASE 4/STAGE 4.mbm"
		ds		#8000+4400-$

M_BOSS_4:

		incbin	"AUDIOS/TEMAS/FASE 4/BOSS 4.mbm"
		ds		#8000+4400+3800-$
 
M_FANFARE_4:

		incbin 	"AUDIOS/TEMAS/FASE 4/S4_INTRO.mbm"
		ds      #8000+4400+3800+600-$    

M_WIN_4:

		incbin 	"AUDIOS/TEMAS/OTRAS/FASE_WIN.mbm"
		ds		#8000+4400+3800+600+670-$

M_GAME_OVER_4:

		incbin	"AUDIOS/TEMAS/OTRAS/GAME_OVER.MBM"
		ds		#8000+4400+3800+600+670+2070-$
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
; RESUMEN: 25 - Músicas de la fase 5
M_STAGE_5:

		incbin 	"AUDIOS/TEMAS/FASE 5/STAGE 5.mbm"
		ds		#8000+4400-$

M_BOSS_5:

		incbin	"AUDIOS/TEMAS/FASE 5/BOSS 5.mbm"
		ds		#8000+4400+3800-$
 
M_FANFARE_5:

		incbin 	"AUDIOS/TEMAS/FASE 5/S5_INTRO.mbm"
		ds      #8000+4400+3800+600-$    

M_WIN_5:

		incbin 	"AUDIOS/TEMAS/OTRAS/FASE_WIN.mbm"
		ds		#8000+4400+3800+600+670-$

M_GAME_OVER_5:

		incbin	"AUDIOS/TEMAS/OTRAS/GAME_OVER.MBM"
		ds		#8000+4400+3800+600+670+2070-$
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
; RESUMEN: 26 - Rutinas de Boss 1
		include	"BOSSES/BOSS 1.asm"

		ds      #5E00-$                                                 ; Colocamos el resto del programa siempre en el mismo sitio

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

DANO_MAGIA_EN_AGONIX_BOSS_1:

		ld		a,(VIDA_AGONIX_BOSS_1)
		or		a
		ret		z
		call	CALCULA_DANO_MAGIA_BOSS_1
		ld		c,a
		ld		a,(VIDA_AGONIX_BOSS_1)
		cp		c
		jr		nc,.RESTA_DANO_MAGIA_AGONIX_BOSS_1
		xor		a
		jr		.GUARDA_VIDA_MAGIA_AGONIX_BOSS_1

.RESTA_DANO_MAGIA_AGONIX_BOSS_1:

		sub		c

.GUARDA_VIDA_MAGIA_AGONIX_BOSS_1:

		ld		(VIDA_AGONIX_BOSS_1),a
		push	af
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_1
		pop		af
		or		a
		jp		z,MUERTE_DE_AGONIX_BOSS_1
		ret

CALCULA_DANO_MAGIA_BOSS_1:

		ld		a,(ARMA_USANDO)
		cp		3
		jr		c,.DANO_MAGIA_FLECHA_BOSS_1
		cp		6
		jr		c,.DANO_MAGIA_FUEGO_BOSS_1
		ld		a,6
		ret

.DANO_MAGIA_FLECHA_BOSS_1:

		ld		a,24
		ret

.DANO_MAGIA_FUEGO_BOSS_1:

		ld		a,3
		ret

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
; RESUMEN: 27 - Rutinas de Boss 2
		include	"BOSSES/BOSS 2.asm"
		
CALCULA_DANO_MAGIA_BOSS_2:

		ld		a,(ARMA_USANDO)
		cp		3
		jr		c,.DANO_MAGIA_FLECHA_BOSS_2
		cp		6
		jr		c,.DANO_MAGIA_FUEGO_BOSS_2
		ld		a,6
		ret

.DANO_MAGIA_FLECHA_BOSS_2:

		ld		a,24
		ret

.DANO_MAGIA_FUEGO_BOSS_2:

		ld		a,3
		ret
        ds      #5E00-$                                                 ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

DANO_MAGIA_EN_DAVEANIX_BOSS_2:

		ld		a,(VIDA_DAVEANIX_BOSS_2)
		or		a
		ret		z

		ld		b,a								; B = vida actual de Daveanix

		call	CALCULA_DANO_MAGIA_BOSS_2
		ld		c,a								; C = daño de magia

		ld		a,(VIDA_ROCKAGER_BOSS_2)
		or		a
		jr		z,.ROCKAGER_YA_NO_PROTEGE_A_DAVEANIX_BOSS_2


		; Si Rockager sigue vivo, Daveanix no puede bajar de 5.
		; Es la misma idea que ya usas con los proyectiles normales.

		ld		a,b								; A = vida actual de Daveanix
		cp		6
		ret		c								; Si ya tiene 1-5, no recibe más daño mientras Rockager viva

		sub		c
		jr		c,.MINIMO_VIDA_DAVEANIX_CON_ROCKAGER_BOSS_2
		cp		6
		jr		nc,.GUARDA_VIDA_MAGIA_DAVEANIX_BOSS_2

.MINIMO_VIDA_DAVEANIX_CON_ROCKAGER_BOSS_2:

		ld		a,5
		jr		.GUARDA_VIDA_MAGIA_DAVEANIX_BOSS_2


.ROCKAGER_YA_NO_PROTEGE_A_DAVEANIX_BOSS_2:

		ld		a,b								; A = vida actual de Daveanix
		sub		c
		jr		nc,.GUARDA_VIDA_MAGIA_DAVEANIX_BOSS_2

		xor		a
		jr		.GUARDA_VIDA_MAGIA_DAVEANIX_BOSS_2


.GUARDA_VIDA_MAGIA_DAVEANIX_BOSS_2:

		ld		(VIDA_DAVEANIX_BOSS_2),a

		push	af
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_2
		pop		af

		or		a								; Z activo si Daveanix ha muerto
		ret



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
; RESUMEN: 28 - Rutinas de Boss 3
		include	"BOSSES/BOSS 3.asm"

        ds      #5E00-$                                                 ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

DANO_MAGIA_EN_CHUMIINIX_BOSS_3:

		ld		a,(VIDA_CHUMINIX_BOSS_3)
		or		a
		ret		z
		call	CALCULA_DANO_MAGIA_BOSS_3
		ld		c,a
		ld		a,(VIDA_CHUMINIX_BOSS_3)
		cp		c
		jr		nc,.RESTA_DANO_MAGIA_CHUMIINIX_BOSS_3
		xor		a
		jr		.GUARDA_VIDA_MAGIA_CHUMINIX_BOSS_3

.RESTA_DANO_MAGIA_CHUMIINIX_BOSS_3:

		sub		c

.GUARDA_VIDA_MAGIA_CHUMINIX_BOSS_3:

		ld		(VIDA_CHUMINIX_BOSS_3),a
		push	af
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_3
		pop		af
		or		a								; Z activo si Chuminix ha muerto
		ret

CALCULA_DANO_MAGIA_BOSS_3:

		ld		a,(ARMA_USANDO)
		cp		3
		jr		c,.DANO_MAGIA_FLECHA_BOSS_3
		cp		6
		jr		c,.DANO_MAGIA_FUEGO_BOSS_3
		ld		a,6
		ret

.DANO_MAGIA_FLECHA_BOSS_3:

		ld		a,24
		ret

.DANO_MAGIA_FUEGO_BOSS_3:

		ld		a,3
		ret  

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
; RESUMEN: 29 - Rutinas de Boss 4
		include	"BOSSES/BOSS 4.asm"

        ds      #5E00-$                                                 ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

DANO_MAGIA_EN_ERRECENYX_BOSS_4:

		ld		a,(VIDA_ERRECENYX_BOSS_4)
		or		a
		ret		z
		call	CALCULA_DANO_MAGIA_BOSS_4
		ld		c,a
		ld		a,(VIDA_ERRECENYX_BOSS_4)
		cp		c
		jr		nc,.RESTA_DANO_MAGIA_ERRECENYX_BOSS_4
		xor		a
		jr		.GUARDA_VIDA_MAGIA_ERRECENYX_BOSS_4

.RESTA_DANO_MAGIA_ERRECENYX_BOSS_4:

		sub		c

.GUARDA_VIDA_MAGIA_ERRECENYX_BOSS_4:

		ld		(VIDA_ERRECENYX_BOSS_4),a
		push	af
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_4
		pop		af
		or		a								; Z activo si Errecenyx ha muerto
		ret

CALCULA_DANO_MAGIA_BOSS_4:

		ld		a,(ARMA_USANDO)
		cp		3
		jr		c,.DANO_MAGIA_FLECHA_BOSS_4
		cp		6
		jr		c,.DANO_MAGIA_FUEGO_BOSS_4
		ld		a,6
		ret

.DANO_MAGIA_FLECHA_BOSS_4:

		ld		a,24
		ret

.DANO_MAGIA_FUEGO_BOSS_4:

		ld		a,3
		ret

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
; RESUMEN: 30 - Rutinas de Boss 5
		include	"BOSSES/BOSS 5.asm"

        ds      #5E00-$                                                 ; Colocamos el resto del programa siempre en el mismo sitio    

		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"        

DANO_MAGIA_EN_IDIUS_BOSS_5:

		ld		a,(VIDA_IDIUS_BOSS_5)
		or		a
		ret		z
		call	CALCULA_DANO_MAGIA_BOSS_5
		ld		c,a
		ld		a,(VIDA_IDIUS_BOSS_5)
		cp		c
		jr		nc,.RESTA_DANO_MAGIA_IDIUS_BOSS_5
		xor		a
		jr		.GUARDA_VIDA_MAGIA_IDIUS_BOSS_5

.RESTA_DANO_MAGIA_IDIUS_BOSS_5:

		sub		c

.GUARDA_VIDA_MAGIA_IDIUS_BOSS_5:

		ld		(VIDA_IDIUS_BOSS_5),a
		push	af
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_5
		pop		af
		or		a								; Z activo si Idus ha muerto
		ret

CALCULA_DANO_MAGIA_BOSS_5:

		ld		a,(ARMA_USANDO)
		cp		3
		jr		c,.DANO_MAGIA_FLECHA_BOSS_5
		cp		6
		jr		c,.DANO_MAGIA_FUEGO_BOSS_5
		ld		a,6
		ret

.DANO_MAGIA_FLECHA_BOSS_5:

		ld		a,24
		ret

.DANO_MAGIA_FUEGO_BOSS_5:

		ld		a,3
		ret

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
; RESUMEN: 31 - Efectos de sonido
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
; RESUMEN: 32 - Sprites comunes Y rayos de la magia
		include	"GRAFICOS/FASES COMUN/SPRITES.asm"
		include "PALETAS/GLOBALES/COLORES SPRITES.asm"
RAYOS_EN_PACK:

		incbin 	"GRAFICOS/FASES COMUN/RAYOS_48x112.DAT"	        
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
; RESUMEN: 33 - Mapa de la fase 1 y sus paletas
MAPA_CONSTANTE_FASE_1:	

		include	"MAPAS/CONSTANTE FASE 1.asm"

        include "MAPAS/EVENTOS FASE 1.asm"
PALETA_STAGE_1_1:

		incbin "PALETAS/FASES/FASE1-1.PALETE"
PALETA_STAGE_1_2_1:

		incbin "PALETAS/FASES/FASE1-2-1.PALETE"

PALETA_STAGE_1_2_2:

		incbin "PALETAS/FASES/FASE1-2-2.PALETE"
		
PALETA_STAGE_1_2_3:

		incbin "PALETAS/FASES/FASE1-2-3.PALETE"

PALETA_STAGE_1_2_4:

		incbin "PALETAS/FASES/FASE1-2-4.PALETE"

PALETA_STAGE_1_2_5:

		incbin "PALETAS/FASES/FASE1-2-5.PALETE"
		
PALETA_STAGE_1_2_6:

		incbin "PALETAS/FASES/FASE1-2-6.PALETE"
PALETA_STAGE_1_3:

		incbin "PALETAS/FASES/FASE1-3.PALETE"
PALETA_STAGE_1_1_FADE_OUT:

		incbin "PALETAS/FASES/FASE1-1.FADOUT"

PALETA_STAGE_1_1_FADE_IN:

		incbin "PALETAS/FASES/FASE1-1.FADEIN"		

PALETA_STAGE_1_2_FADE_OUT:

		incbin "PALETAS/FASES/FASE1-1.FADOUT"

PALETA_STAGE_1_2_FADE_IN:

		incbin "PALETAS/FASES/FASE1-1.FADEIN"		

PALETA_STAGE_1_3_FADE_OUT:

		incbin "PALETAS/FASES/FASE1-1.FADOUT"

PALETA_STAGE_1_3_FADE_IN:

		incbin "PALETAS/FASES/FASE1-1.FADEIN"		

PALETA_GRISES_STAGE_1:

		incbin "PALETAS/GLOBALES/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_1:

		incbin "PALETAS/GLOBALES/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_1:

		incbin "PALETAS/FASES COMUN/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_1:

		incbin	"PALETAS/GLOBALES/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_1:

		incbin	"PALETAS/GLOBALES/BLANCOS A NEGROS.FADEOUT"

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
; RESUMEN: 34 - Mapa de la fase 2 y sus paletas
MAPA_CONSTANTE_FASE_2:	

		include	"MAPAS/CONSTANTE FASE 2.asm"

        include "MAPAS/EVENTOS FASE 2.asm"

PALETA_STAGE_2_1:

		incbin "PALETAS/FASES/FASE2-1.PALETE"
PALETA_STAGE_2_2_1:

		incbin "PALETAS/FASES/FASE2-2-1.PALETE"

PALETA_STAGE_2_2_2:

		incbin "PALETAS/FASES/FASE2-2-2.PALETE"
		
PALETA_STAGE_2_2_3:

		incbin "PALETAS/FASES/FASE2-2-3.PALETE"

PALETA_STAGE_2_2_4:

		incbin "PALETAS/FASES/FASE2-2-4.PALETE"

PALETA_STAGE_2_2_5:

		incbin "PALETAS/FASES/FASE2-2-5.PALETE"
		
PALETA_STAGE_2_2_6:

		incbin "PALETAS/FASES/FASE2-2-6.PALETE"

PALETA_STAGE_2_3:

		incbin "PALETAS/FASES/FASE2-3.PALETE"

PALETA_STAGE_2_1_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_2_1_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_2_2_FADE_OUT:

		incbin "PALETAS/FASES/FASE2-2.FADOUT"

PALETA_STAGE_2_2_FADE_IN:

		incbin "PALETAS/FASES/FASE2-2.FADEIN"		

PALETA_STAGE_2_3_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_2_3_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_GRISES_STAGE_2:

		incbin "PALETAS/GLOBALES/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_2:

		incbin "PALETAS/GLOBALES/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_2:

		incbin "PALETAS/FASES COMUN/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_2:

		incbin	"PALETAS/GLOBALES/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_2:

		incbin	"PALETAS/GLOBALES/BLANCOS A NEGROS.FADEOUT"

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
; RESUMEN: 35 - Mapa de la fase 3 (parte 1) y sus paletas
MAPA_CONSTANTE_FASE_3_0:	

		include	"MAPAS/CONSTANTE FASE 3-0.asm"

        include "MAPAS/EVENTOS FASE 3-0.asm"

PALETA_STAGE_3_1_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"
PALETA_STAGE_3_2_1_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"

PALETA_STAGE_3_2_2_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"
		
PALETA_STAGE_3_2_3_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"

PALETA_STAGE_3_2_4_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"

PALETA_STAGE_3_2_5_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"
		
PALETA_STAGE_3_2_6_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"

PALETA_STAGE_3_3_0:

		incbin "PALETAS/FASES/FASE3-1.PALETE"

PALETA_STAGE_3_1_0_FADE_OUT:

		incbin "PALETAS/FASES/FASE3-1.FADEOUT"

PALETA_STAGE_3_1_0_FADE_IN:

		incbin "PALETAS/FASES/FASE3-1.FADEIN"

PALETA_STAGE_3_2_0_FADE_OUT:

		incbin "PALETAS/FASES/FASE3-1.FADEOUT"

PALETA_STAGE_3_2_0_FADE_IN:

		incbin "PALETAS/FASES/FASE3-1.FADEIN"		

PALETA_STAGE_3_3_0_FADE_OUT:

		incbin "PALETAS/FASES/FASE3-1.FADEOUT"

PALETA_STAGE_3_3_0_FADE_IN:

		incbin "PALETAS/FASES/FASE3-1.FADEIN"		

PALETA_GRISES_STAGE_3_0:

		incbin "PALETAS/GLOBALES/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_3_0:

		incbin "PALETAS/GLOBALES/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_3_0:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_3_0:

		incbin "PALETAS/FASES COMUN/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_3_0:

		incbin	"PALETAS/GLOBALES/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_3_0:

		incbin	"PALETAS/GLOBALES/BLANCOS A NEGROS.FADEOUT"


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
; RESUMEN: 36 - Mapa de la fase 4 y sus paletas
MAPA_CONSTANTE_FASE_4:	

		include	"MAPAS/CONSTANTE FASE 4.asm"

        include "MAPAS/EVENTOS FASE 4.asm"

PALETA_STAGE_4_1:

		incbin "PALETAS/FASES/FASE4-1.PALETE"
PALETA_STAGE_4_2_1:

		incbin "PALETAS/FASES/FASE4-2-6.PALETE"

PALETA_STAGE_4_2_2:

		incbin "PALETAS/FASES/FASE4-2-5.PALETE"
		
PALETA_STAGE_4_2_3:

		incbin "PALETAS/FASES/FASE4-2-4.PALETE"

PALETA_STAGE_4_2_4:

		incbin "PALETAS/FASES/FASE4-2-3.PALETE"

PALETA_STAGE_4_2_5:

		incbin "PALETAS/FASES/FASE4-2-2.PALETE"
		
PALETA_STAGE_4_2_6:

		incbin "PALETAS/FASES/FASE4-2-1.PALETE"

PALETA_STAGE_4_3:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_4_1_FADE_OUT:

		incbin "PALETAS/FASES/FASE4-1.FADEOUT"

PALETA_STAGE_4_1_FADE_IN:

		incbin "PALETAS/FASES/FASE4-1.FADEIN"

PALETA_STAGE_4_2_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_4_2_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_STAGE_4_3_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_4_3_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_GRISES_STAGE_4:

		incbin "PALETAS/GLOBALES/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_4:

		incbin "PALETAS/GLOBALES/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_4:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_4:

		incbin "PALETAS/FASES COMUN/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_4:

		incbin	"PALETAS/GLOBALES/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_4:

		incbin	"PALETAS/GLOBALES/BLANCOS A NEGROS.FADEOUT"

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
; RESUMEN: 37 - Mapa de la fase 5 y sus paletas
MAPA_CONSTANTE_FASE_5:	

		include	"MAPAS/CONSTANTE FASE 5.asm"

        include "MAPAS/EVENTOS FASE 5.asm"

PALETA_STAGE_5_1:

		incbin "PALETAS/FASES/FASE5-1.PALETE"
PALETA_STAGE_5_2_1:

		incbin "PALETAS/FASES/FASE5-2-1.PALETE"

PALETA_STAGE_5_2_2:

		incbin "PALETAS/FASES/FASE5-2-2.PALETE"
		
PALETA_STAGE_5_2_3:

		incbin "PALETAS/FASES/FASE5-2-3.PALETE"

PALETA_STAGE_5_2_4:

		incbin "PALETAS/FASES/FASE5-2-4.PALETE"

PALETA_STAGE_5_2_5:

		incbin "PALETAS/FASES/FASE5-2-5.PALETE"
		
PALETA_STAGE_5_2_6:

		incbin "PALETAS/FASES/FASE5-2-6.PALETE"

PALETA_STAGE_5_3:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_5_1_FADE_OUT:

		incbin "PALETAS/FASES/FASE5-1.FADOUT"

PALETA_STAGE_5_1_FADE_IN:

		incbin "PALETAS/FASES/FASE5-1.FADEIN"
PALETA_STAGE_5_2_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_5_2_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_STAGE_5_3_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_5_3_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_GRISES_STAGE_5:

		incbin "PALETAS/GLOBALES/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_5:

		incbin "PALETAS/GLOBALES/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_5:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_5:

		incbin "PALETAS/FASES COMUN/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_5:

		incbin	"PALETAS/GLOBALES/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_5:

		incbin	"PALETAS/GLOBALES/BLANCOS A NEGROS.FADEOUT"

PALETA_BOSS_1_FADE_OUT:

		incbin	"PALETAS/BOSSES/BOSS1.FADEOUT"

PALETA_BOSS_2_FADE_OUT:

		incbin	"PALETAS/BOSSES/BOSS2.FADEOUT"

PALETA_BOSS_3_FADE_OUT:

		incbin	"PALETAS/BOSSES/BOSS3.FADEOUT"

PALETA_BOSS_4_FADE_OUT:

		incbin	"PALETAS/BOSSES/BOSS4.FADEOUT"

PALETA_BOSS_5_FADE_OUT:

		incbin	"PALETAS/BOSSES/BOSS5.FADEOUT"

TABLA_PALETAS_FADE_OUT_BOSS:

		dw		PALETA_BOSS_1_FADE_OUT
		dw		PALETA_BOSS_2_FADE_OUT
		dw		PALETA_BOSS_3_FADE_OUT
		dw		PALETA_BOSS_4_FADE_OUT
		dw		PALETA_BOSS_5_FADE_OUT

TABLA_PASOS_FADE_OUT_BOSS:

		db		8,8,7,8,8


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
; RESUMEN: 38 - Semi Boss de la fase 2 (parte 1)
		include "BASICOS/GAME OVER 2.asm"

		include	"BOSSES/SEMIBOSS 2 PART 1.asm"

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
; RESUMEN: 39 - Músicas que no caben en su fase o globales
M_THE_BEST:

		incbin	"AUDIOS/TEMAS/FASE 5/THE BEST.mbm"

M_PUENTE:

		incbin	"AUDIOS/TEMAS/FASE 1/PUENTE.mbm"

M_MENU:

		incbin	"AUDIOS/TEMAS/OTRAS/MENU.mbm"

M_SEMIBOSS_2:

		incbin	"AUDIOS/TEMAS/FASE 2/SEMIBOSS.mbm"   

M_MAP:
		incbin	"AUDIOS/TEMAS/OTRAS/MAPA.mbm"  

M_VAGONETA:

		incbin	"AUDIOS/TEMAS/FASE 3/VAGONETA.mbm"

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
; RESUMEN: 40 - Gráficos de marca parte 2
GRAFICOS_MOAI_2:

        incbin  "GRAFICOS/PRESENTACIONES/SOLOTITULO2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 40 *****
 ******   END    ******
 **********************/
 /**********************
  ****** PAGINA 41 *****
  ****** SLOT   2 ******     gráficos de marca parte 3
  **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 41 - Gráficos de marca parte 3
GRAFICOS_MOAI_3:

        incbin  "GRAFICOS/PRESENTACIONES/SOLOTITULO3.DAT"

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
; RESUMEN: 42 - Gráficos de Rockager parte 1
        incbin  "GRAFICOS/BOSSES/ROCKAGER1.DAT"

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
; RESUMEN: 43 - Gráficos de Rockager parte 2
        incbin  "GRAFICOS/BOSSES/ROCKAGER2.DAT"

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
; RESUMEN: 44 - Semi Boss de la fase 2 (parte 2)
		include	"BOSSES/SEMIBOSS 2 PART 2.asm"

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
 ****** SLOT   2 ******     graficos status
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 45 - Gráficos de status durante boss fases 1 y 2
STATUS_BOSS_1:
		incbin "GRAFICOS/STATUS/STATUS BOSS 1.DAT"
STATUS_BOSS_2_AND_SEMIBOSS_2:
       	incbin  "GRAFICOS/STATUS/STATUS BOSS 2 AND SEMIBOSS 2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 45 *****
 ******   END    ******
 **********************/

 /**********************
  ****** PAGINA 46 *****
  ****** SLOT   2 ******     graficos Daveatnix 1-1
  **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 46 - Gráficos de Daveatnix parte 1-1
        incbin  "GRAFICOS/BOSSES/TILES DAVEATNIX 11.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 46 *****
 ******   END    ******
 **********************/

 /**********************
  ****** PAGINA 47 *****
  ****** SLOT   2 ******     graficos Daveatnix 1-2
  **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 47 - Gráficos de Daveatnix parte 1-2
        incbin  "GRAFICOS/BOSSES/TILES DAVEATNIX 12.DAT"

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
; RESUMEN: 48 - Gráficos de Daveatnix parte 2-1
        incbin  "GRAFICOS/BOSSES/TILES DAVEATNIX 21.DAT"

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
; RESUMEN: 49 - Gráficos de Daveatnix parte 2-2
        incbin  "GRAFICOS/BOSSES/TILES DAVEATNIX 22.DAT"

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
; RESUMEN: 50 - Gráficos de Agonix parte 1-1
        incbin  "GRAFICOS/BOSSES/TILES AGONIX 11.DAT"

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
; RESUMEN: 51 - Gráficos de Agonix parte 1-2
        incbin  "GRAFICOS/BOSSES/TILES AGONIX 12.DAT"

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
; RESUMEN: 52 - Gráficos de Agonix parte 2-1
        incbin  "GRAFICOS/BOSSES/TILES AGONIX 21.DAT"

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
; RESUMEN: 53 - Gráficos de Agonix parte 2-2
        incbin  "GRAFICOS/BOSSES/TILES AGONIX 22.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 53 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 54 *****
 ****** SLOT   2 ******     graficos Idius 1-1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 54 - Gráficos de Idius parte 1-1
        incbin  "GRAFICOS/BOSSES/TILES IDIUS 11.DAT"

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
; RESUMEN: 55 - Gráficos de Idius parte 1-2
        incbin  "GRAFICOS/BOSSES/TILES IDIUS 12.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 55 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 56 ******
 ****** SLOT   2 ******     graficos Errecenyx 1-1
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 56 - Gráficos de Errecenyx parte 1-1
        incbin  "GRAFICOS/BOSSES/TILES ERRECENYX 11.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 56 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 57 ******
 ****** SLOT   2 ******     graficos Errecenyx 1-2
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 57 - Gráficos de Errecenyx parte 1-2
        incbin  "GRAFICOS/BOSSES/TILES ERRECENYX 12.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 57 ******
 ******   END    ******
 **********************/

   /**********************
 ****** PAGINA 58 ******
 ****** SLOT   2 ******     graficos status
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 58 - Gráficos de status durante boss fases 3 y 4
STATUS_BOSS_3:
		incbin "GRAFICOS/STATUS/STATUS BOSS 3.DAT"
STATUS_BOSS_4:
       	incbin  "GRAFICOS/STATUS/STATUS BOSS 4.DAT"
        ds		#C000-$

/**********************
 ****** PAGINA 58 ******
 ******   END    ******
 **********************/

   /**********************
 ****** PAGINA 59 ******
 ****** SLOT   2 ******     graficos status
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 59 - Gráficos de status durante boss fase 5
STATUS_BOSS_5:
       	incbin  "GRAFICOS/STATUS/STATUS BOSS 5.DAT"
        ds		#C000-$

/**********************
 ****** PAGINA 59 ******
 ******   END    ******
 **********************/
    /**********************
 ****** PAGINA 60 ******
 ****** SLOT   2 ******     graficos cinematica
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

; RESUMEN: 60 - Gráficos de cinematica parte 1-1
CINEMATICA_1_2_1:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA1Y2-1.DAT"
        ds		#C000-$

/**********************
 ****** PAGINA 60 ******
 ******   END    ******
 **********************/
    /**********************
 ****** PAGINA 61 ******
 ****** SLOT   2 ******     graficos cinematica
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC

; RESUMEN: 61 - Gráficos de cinematica parte 1-2
CINEMATICA_1_2_2:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA1Y2-2.DAT"
        ds		#C000-$

/**********************
 ****** PAGINA 61 ******
 ******   END    ******
 **********************/
    /**********************
 ****** PAGINA 62 ******
 ****** SLOT   2 ******     graficos cinematica
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 62 - Gráficos de cinematica parte 2-1
CINEMATICA_3_4_1:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA3Y4-1.DAT"
        ds		#C000-$

/**********************
 ****** PAGINA 62 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 63 ******
 ****** SLOT   2 ******     graficos cinematica
 **********************/

		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 63 - Gráficos de cinematica parte 2-2
CINEMATICA_3_4_2:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA3Y4-2.DAT"
        ds		#C000-$

/**********************
 ****** PAGINA 63 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 64******
 ****** SLOT   2 ******     Mapa
 **********************/

		org		#8000
; RESUMEN: 64 - Mapa de la fase 3-1

MAPA_CONSTANTE_FASE_3_1:	

		include	"MAPAS/CONSTANTE FASE 3-1.asm"

        include "MAPAS/EVENTOS FASE 3-1.asm"

PALETA_STAGE_3_1_1:

		incbin "PALETAS/FASES/FASE3-1.PALETE"
PALETA_STAGE_3_2_1_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_2_2_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
		
PALETA_STAGE_3_2_3_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_2_4_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_2_5_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
		
PALETA_STAGE_3_2_6_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_3_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_1_1_FADE_OUT:

		incbin "PALETAS/FASES/FASE3-1.FADEOUT"

PALETA_STAGE_3_1_1_FADE_IN:

		incbin "PALETAS/FASES/FASE3-1.FADEIN"

PALETA_STAGE_3_2_1_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_3_2_1_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_STAGE_3_3_1_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_3_3_1_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_GRISES_STAGE_3_1:

		incbin "PALETAS/GLOBALES/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_3_1:

		incbin "PALETAS/GLOBALES/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_3_1:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_3_1:

		incbin "PALETAS/FASES COMUN/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_3_1:

		incbin	"PALETAS/GLOBALES/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_3_1:

		incbin	"PALETAS/GLOBALES/BLANCOS A NEGROS.FADEOUT"


        ds		#C000-$

/**********************
 ****** PAGINA 64******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 65******
 ****** SLOT   2 ******     Mapa
 **********************/

		org		#8000
; RESUMEN: 65 - Mapa de la fase 3-2
MAPA_CONSTANTE_FASE_3_2:	

		include	"MAPAS/CONSTANTE FASE 3-2.asm"

        include "MAPAS/EVENTOS FASE 3-2.asm"

PALETA_STAGE_3_1_2:

		incbin "PALETAS/FASES/FASE3-1.PALETE"
PALETA_STAGE_3_2_1_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_2_2_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
		
PALETA_STAGE_3_2_3_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_2_4_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_2_5_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
		
PALETA_STAGE_3_2_6_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_3_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"

PALETA_STAGE_3_1_2_FADE_OUT:

		incbin "PALETAS/FASES/FASE3-1.FADEOUT"

PALETA_STAGE_3_1_2_FADE_IN:

		incbin "PALETAS/FASES/FASE3-1.FADEIN"

PALETA_STAGE_3_2_2_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_3_2_2_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_STAGE_3_3_2_FADE_OUT:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"

PALETA_STAGE_3_3_2_FADE_IN:

		incbin "PALETAS/GLOBALES/OSCURO.FADES"		

PALETA_GRISES_STAGE_3_2:

		incbin "PALETAS/GLOBALES/GRISES.PALETE"

PALETA_GRISES_FADE_OUT_STAGE_3_2:

		incbin "PALETAS/GLOBALES/GRISES.FADEOUT"
PALETA_OSCURO_STAGE_3_2:

		incbin "PALETAS/GLOBALES/OSCURO.PALETE"
PALETA_MARCADOR_STAGE_3_2:

		incbin "PALETAS/FASES COMUN/MARCADOR.PALETE"

PALETA_GRIS_BLANCO_3_2:

		incbin	"PALETAS/GLOBALES/GRISES A BLANCOS.FADEOUT"

PALETA_BLANCO_NEGRO_3_2:

		incbin	"PALETAS/GLOBALES/BLANCOS A NEGROS.FADEOUT"


        ds		#C000-$

/**********************
 ****** PAGINA 65******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 66 ******
 ****** SLOT   2 ******     
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 66 - Gráficos de cinematica parte 7-8 (Parte 2)
CINEMATICA_7_8_2:
       	incbin  "GRAFICOS/PRESENTACIONES/CINEMATICA7Y8-2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 66 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 67 ******
 ****** SLOT   1 ******    
 **********************/
		org		#4000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 67 - Cinemáticas finales

CINEMATICAS_FINALES:

		include "MENU Y TRANSICIONES/CINEMATICAS FINALES.asm"

        ds      #8000-$-#2200   
			                                        ; Colocamos el resto del programa siempre en el mismo sitio    
		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"     
        ds		#8000-$

/**********************
 ****** PAGINA 67 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 68 ******
 ****** SLOT   1 ******    
 **********************/
		org		#4000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 68 - Muestra mapa antes de fase

MUESTRA_MAPA:

		include "ANIMACIONES/MAPA DE SITUACION.asm"

        ds      #8000-$-#2200   
			                                        ; Colocamos el resto del programa siempre en el mismo sitio    
		include "BASICOS/RUTINAS CERRADAS (sin etiquetas).asm"				            ; Incluímos las referencias a la BIOS
		include "AUDIOS/LANZADOR EFECTOS PSG (sin etiquetas).asm"
        include "PALETAS/PALETAS (sin etiquetas).asm"
		include "AUDIOS/LANZADOR FMPACK Y MUSIC MODULE (sin etiquetas).asm"     
        ds		#8000-$

/**********************
 ****** PAGINA 68 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 69 ******
 ****** SLOT   2 ******    
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 69 - Gráficos mapa parte 1

GRAFICOS_MAPA_1:

        incbin  "GRAFICOS/PRESENTACIONES/MAPA01.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 69 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 70 ******
 ****** SLOT   2 ******    
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 70 - Gráficos mapa parte 2

GRAFICOS_MAPA2_1:

		incbin  "GRAFICOS/PRESENTACIONES/MAPA02.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 70 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 71 ******
 ****** SLOT   2 ******    
 **********************/

		org		#8000											
; RESUMEN: 71 - Gráficos de Chuminix parte 1-1
        incbin  "GRAFICOS/BOSSES/TILES CHUMINIX 11.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 71 ******
 ******   END    ******
 **********************/

/**********************
 ****** PAGINA 72 ******
 ****** SLOT   2 ******   
 **********************/

		org		#8000											
; RESUMEN: 72 - Gráficos de Chuminix parte 1-2
        incbin  "GRAFICOS/BOSSES/TILES CHUMINIX 12.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 72 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 73******
 ****** SLOT   1 ******     Música you're the best
 **********************/

		org		#8000
; RESUMEN: 73 - Músicas que no caben en su fase o globales
M_FINAL:

		incbin "AUDIOS/TEMAS/OTRAS/FINAL.mbm"

M_CREDITS:

		incbin "AUDIOS/TEMAS/OTRAS/CREDITS.mbm"

M_LABERINT:

		incbin	"AUDIOS/TEMAS/FASE 5/LABERINT.mbm"
		
        ds		#c000-$

/**********************
 ****** PAGINA 73******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 74 ******
 ****** SLOT   2 ******   
 **********************/

		org		#8000											
; RESUMEN: 74 - Gráficos de Diamante parte 1
GRAFICOS_GRAN_DIAMANTE_1:
        incbin  "GRAFICOS/DIAMANTE/DIAMANTE-1.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 74 ******

 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 75 ******
 ****** SLOT   2 ******   
 **********************/

		org		#8000											
; RESUMEN: 75 - Gráficos de Diamante parte 2
GRAFICOS_GRAN_DIAMANTE_2:
        incbin  "GRAFICOS/DIAMANTE/DIAMANTE-2.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 75 ******

 ******   END    ******
 **********************/
/**********************
 ****** PAGINA 76 ******
 ****** SLOT   2 ******    
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 76 - Gráficos mapa 2 parte 1

GRAFICOS_MAPA2_2:

		incbin  "GRAFICOS/PRESENTACIONES/MAPA03.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 76 ******
 ******   END    ******
 **********************/

 /**********************
 ****** PAGINA 77 ******
 ****** SLOT   2 ******    
 **********************/
		org		#8000													; Esta página está pensada para ir de la dirección $4000 a la $7CCC
; RESUMEN: 77 - Gráficos mapa 2 parte 2

GRAFICOS_MAPA_2:

		incbin  "GRAFICOS/PRESENTACIONES/MAPA04.DAT"

        ds		#C000-$

/**********************
 ****** PAGINA 77 ******
 ******   END    ******
 **********************/
