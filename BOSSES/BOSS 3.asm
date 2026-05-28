VIDA_INICIAL_CHUMINIX_BOSS_3:				equ	120
VIDA_TOTAL_INICIAL_BOSS_3:					equ	VIDA_INICIAL_CHUMINIX_BOSS_3
VIDA_ANCHO_BARRA_BOSS_3:					equ	99

PAGINA_REGRESO_BOSS_3:						equ	29

; VRAM / sprites
SPRITES_ATRIBUTOS_VRAM_BOSS_3:				equ	#4A00
SPRITES_LIMPIA_INICIAL_BOSS_3:				equ	10
SPRITES_LIMPIA_CANT_INICIAL_BOSS_3:			equ	22


RUTINA_BOSS_3:

		call	stpmus

		ld      a,0
		ld      hl,SPRITES_ATRIBUTOS_VRAM_BOSS_3+SPRITES_LIMPIA_INICIAL_BOSS_3*4
		ld      bc,SPRITES_LIMPIA_CANT_INICIAL_BOSS_3*4
		call    FILVRM_RAM

.VARIABLES:

		ld		a,PAGINA_REGRESO_BOSS_3
		ld		(PAGINA_DE_REGRESO),a
		xor		a
		ld		(VALORES_EXPLOSION_CON_ROCK),a
		ld		(VALORES_EXPLOSION_CON_ROCK+1),a
		ld		(VALORES_EXPLOSION_CON_ROCK+2),a
		ld		(VALORES_EXPLOSION_CON_ROCK+3),a
		ld		a,VIDA_INICIAL_CHUMINIX_BOSS_3
		ld		(VIDA_CHUMINIX_BOSS_3),a

.COPIA_A_1_PARTE_ALTA:

        ld      ix,BOSS_3_PAGE_2_A_PAGE_1_COMPLETA
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .BUCLE_PINTA_DATAS

        ld      iy,DATAS_COPY_RECUP_SCROLL
        ld      a,(PUNTO_DEL_SCROLL)

        ld      (iy+2),a
        ld      b,a
        ld      a,0
        sub     b
        ld      (iy+10),a
        push    af
        xor     a
        ld      (iy+11),a
        ld      hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		call	VDPREADY

.COPIA_A_1_PARTE_BAJA:
        
        ld      ix,BOSS_3_PAGE_2_A_PAGE_1_COMPLETA
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .BUCLE_PINTA_DATAS

        ld      iy,DATAS_COPY_RECUP_SCROLL
        ld      a,(PUNTO_DEL_SCROLL)
        ld      b,a
        ld      a,0
        sub     b
        ld      (iy+6),a
        pop     af
        dec     a
        ld      b,a
        ld      a,#FF
        sub     b
        ld      (iy+10),a
        xor     a
        ld      (iy+11),a
        ld      hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY 
        call    VDPREADY

.GUARDA_DATOS_VIDA_CHUMINIX:

        ld      ix,BOSS_3_COPI_MARCADOR_BOSSES_CORAZONES_VACIOS
        ld      iy,DATAS_COR_EMPT_MALO
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_CORAZONES_EMPTY_DEPH:

        ld      ix,BOSS_3_COPY_CORAZONES_EMPTY_DEPH
        ld      iy,CORAZONES_DEPH_EN_BOSSES
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_PUNTOS_MAGIA:

        ld      ix,BOSS_3_COPY_PUNTOS_MAGIA
        ld      iy,PUNTOS_MAGIA_EN_BOSSES
        call    .BUCLE_PINTA_DATAS

.VARIABLES_DE_DEPH_RETOCADAS:

        ld      a,(PUNTO_DEL_SCROLL)
        ld      b,a
        ld      a,(Y_DEPH)
        sub     b
        ld      (Y_DEPH),a
        add     32
        ld      (Y_FALSA_PARA_DEPH),a

.PUNTO_DE_SCROLL_RETOCADO:

        ld      a,0
        ld      (PUNTO_DEL_SCROLL),a

.COLOCA_SPRITES_DEPH_EN_SU_SITIO:
        
        call    PINTA_SPRITE_DEPH
		call	CARGA_SPRITES_BARRO_BOSS_3
		call    ANIMACION_BOSS_3_COMIENZO

.CAMBIA_PAGE_PARA_OCULTAR:

        ld      a,1
        ld      (SET_PAGE),a

.COPIA_ESCENARIO_RECOLOCADO_A_PAGE_2:

 		ld	hl,BOSS_3_PAGE_1_A_PAGE_2_COMPLETA
		call	DOCOPY
        call    VDPREADY

.DEVUELVE_LA_PAGE_2:

        ld      a,2
        ld      (SET_PAGE),a

.CAMBIAMOS_MAS_VARIABLES_PARA_EL_CAMBIO_DE_SCROLL:

		ld	a,202
		ld	(DONDE_VA_LA_INTERRUPCION_LINEAL),a 

		ld	a,240
		ld	(Y_PINTA_SCROLL),a

 		ld	a,159
		ld	(LIM_Y_INF),a	
			
		ld	a,190
		ld	(LIM_MUERTE),a

		ld	a,195
		ld	(Y_LINEA_INT),a

.CARGA_CHUMINIX_PARTE_1:

        ld      a,71
        ld		b,72
        call	.CARGA_PANTALLA_COMPLETA

.CARGA_STATUS_BOSS:

        ld      a,58
        call	CHANGE_BANK_2

        ld		hl,STATUS_BOSS_3												; Carga gráficos status
        ld		de,#0000+(256*200)/2
        ld		bc,(256*54)/2
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,10
        call	CHANGE_BANK_2  

.PINTA_STATUS:

        ld      b,15
        ld      hl,BOSS_3_COPIA_PARTE_PAGE_2_DE_STATUS
		call	DOCOPY 

        ld      b,15
        ld      hl,BOSS_3_COPIA_STATUS_BOSS_A_PAGE_2
		call	DOCOPY 
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_3

.BORRA_CORAZONES_QUE_SOBRAN:

        ld      a,(CORAZONES)
        ld      b,4
        
.BUCLE_BORRA_CORAZONES_DE_MAS:

        ex      af,af'
        ld      a,b
        ld      (CORAZONES),a
        call    .PINTA_CORAZONES_VIDA_DEPH_ADECUADOS
        ex      af,af'
        cp      b
        jp      z,.FINAL_BUCLE_CORAZONES
        djnz    .BUCLE_BORRA_CORAZONES_DE_MAS

.FINAL_BUCLE_CORAZONES:

        ld      (CORAZONES),a

.PINTA_MAGIAS_REALES:

	ld		ix,PUNTOS_MAGIA_EN_BOSSES
	ld		a,(MAGIAS)
[3]	add		a
	ld		c,25
	add		c
	ld		(ix),a
	ld		hl,PUNTOS_MAGIA_EN_BOSSES
	call	DOCOPY
		
.PREPARACION_PELEA:
.EMPIEZA_LA_MUSICA:

		include	"../AUDIOS/INICIA MUSICA_BOSS.asm"


; todo el codigo de enfrentamiento

		jp	BUCLE_PELEA_BOSS_3

.CARGA_PANTALLA_COMPLETA:

		push	bc
        call	CHANGE_BANK_2
                                                                       
        ld		hl,#8000							; Posición de lectura			
        ld		de,#8000							; Posición de escritura
        ld		bc,16384							; Bits a leer
        call	PON_COLOR_2.sin_bc_impuesta

		pop		af
        call	CHANGE_BANK_2
                                                                        
        ld		hl,#8000									
        ld		de,#C000
        ld		bc,16384
        call	PON_COLOR_2.sin_bc_impuesta
		call	VDPREADY

		ld		a,10
        jp		CHANGE_BANK_2

.PINTA_CORAZONES_VIDA_DEPH_ADECUADOS:

	ld		ix,CORAZONES_DEPH_EN_BOSSES
	ld		a,(CORAZONES)
	ld		c,a
[9]	add		c
	ld		c,43
	add		c
	ld		(ix),a
	ld		(ix+4),a
    ld      hl,CORAZONES_DEPH_EN_BOSSES
	push	bc
	call   	DOCOPY
	pop		bc
	ret

.BUCLE_PINTA_DATAS:

        ld      b,15

.BUCLE_PINTA_DATAS_1:

        ld      a,(ix)
        ld      (iy),a
        ld      de,1
        add     ix,de
        add     iy,de
        djnz    .BUCLE_PINTA_DATAS_1
        ret


; -----------------------------------------------------------------------------
; Rutinas reservadas de entrada del Boss 3.
; De momento solo dejan el punto de enganche preparado.
; -----------------------------------------------------------------------------
CARGA_SPRITES_BARRO_BOSS_3:

		; Aqui se cargaran los sprites/patrones especificos del Boss 3 si hacen falta.
		ret

ANIMACION_BOSS_3_COMIENZO:

		; Aqui se lanzara la animacion inicial del Boss 3 si hace falta.
		ret


BUCLE_PELEA_BOSS_3:

		HALT
		call	SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_3
		call	PINTA_PROYECTILES_DE_DEPH_EN_BOSS_3
        call    REVISAMOS_COLISION_CON_CHUMINIX_Y_DEPH
		call	ON_SPRITE_GLOBAL_BOSS_3
		call	REVISAMOS_COLISION_CON_CHUMINIX_Y_PROYECTILES_DEPH
		call	MUEVE_CHUMINIX_BOSS_3
		jp		BUCLE_PELEA_BOSS_3

PINTA_MARCADORES_VIDA_FINAL_BOSS_3:

		ld		a,(VIDA_CHUMINIX_BOSS_3)
		call	CONVIERTE_VIDA_FINAL_A_BARRA_BOSS_3

        ; Si es el ancho total, lo dejamos tal cual
        ; para que al morir borre la barra completa.
        cp      VIDA_ANCHO_BARRA_BOSS_3
        jr      z,.ANCHO_BARRA_BOSS_3_OK

        ; Redondeamos hacia abajo a múltiplos de 6
        ; 1-5   -> 0
        ; 6-11  -> 6
        ; 12-17 -> 12
        ; 18-23 -> 18
        ; etc.
        ld      b,0

.REDONDEA_BARRA_A_6_BOSS_3:

        cp      6
        jr      c,.FIN_REDONDEA_BARRA_A_6_BOSS_3

        sub     6
        ld      c,a
        ld      a,b
        add     a,6
        ld      b,a
        ld      a,c

        jr      .REDONDEA_BARRA_A_6_BOSS_3

.FIN_REDONDEA_BARRA_A_6_BOSS_3:

        ld      a,b

.ANCHO_BARRA_BOSS_3_OK:

        or      a
        ret     z
        ld      b,a
        ld      a,VIDA_ANCHO_BARRA_BOSS_3
        sub     b
        ld      c,151
        add     c

		ld		ix,DATAS_COR_EMPT_MALO
		ld		(ix+4),a
		ld		a,b
		ld		(ix+8),a
		xor		a
		ld		(ix+9),a

	 	ld	    hl,DATAS_COR_EMPT_MALO
		jp		DOCOPY

CONVIERTE_VIDA_FINAL_A_BARRA_BOSS_3:

		ld		c,a
		ld		a,VIDA_TOTAL_INICIAL_BOSS_3
		sub		c
        ld      b,a
        xor     a
        ld      d,a
        ld      l,a

.BUCLE_ESCALA_VIDA_FINAL_BOSS_3:

        ld      a,b
        or      a
        jr      z,.FIN_ESCALA_VIDA_FINAL_BOSS_3

        dec     b

        ld      a,l
        add     a,VIDA_ANCHO_BARRA_BOSS_3

.AJUSTA_ESCALA_VIDA_FINAL_BOSS_3:

        cp      VIDA_TOTAL_INICIAL_BOSS_3
        jr      c,.GUARDA_RESTO_ESCALA_VIDA_FINAL_BOSS_3

        sub     VIDA_TOTAL_INICIAL_BOSS_3
        inc     d
        jr      .AJUSTA_ESCALA_VIDA_FINAL_BOSS_3

.GUARDA_RESTO_ESCALA_VIDA_FINAL_BOSS_3:

        ld      l,a
        jr      .BUCLE_ESCALA_VIDA_FINAL_BOSS_3

.FIN_ESCALA_VIDA_FINAL_BOSS_3:

        ld      a,d
        ld      h,a
        ld      a,l
        or      a
        ld      a,h
        ret     z
        inc     a
        ret

SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_3:

		; Aqui ira la secuencia de disparo de los proyectiles propios de Deph durante el Boss 3.
		ret

PINTA_PROYECTILES_DE_DEPH_EN_BOSS_3:

		; Aqui ira el pintado/actualizacion visual de los proyectiles de Deph durante el Boss 3.
		ret

REVISAMOS_COLISION_CON_CHUMINIX_Y_DEPH:

		; Aqui revisaremos la colision directa entre Chuminix y Deph.
		ret

ON_SPRITE_GLOBAL_BOSS_3:

		; Aqui ira el control global de on-sprite/colisiones generales del Boss 3.
		ret

REVISAMOS_COLISION_CON_CHUMINIX_Y_PROYECTILES_DEPH:

		; Aqui revisaremos las colisiones entre Chuminix y los proyectiles de Deph.
		ret

MUEVE_CHUMINIX_BOSS_3:

		; Aqui ira la secuencia de movimiento de Chuminix.
		ret


	include	"BOSS 3 DATA.asm"
