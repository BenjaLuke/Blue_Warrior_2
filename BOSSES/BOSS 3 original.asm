VIDA_INICIAL_CHUMINIX_BOSS_3:				equ	120
VIDA_TOTAL_INICIAL_BOSS_3:					equ	VIDA_INICIAL_CHUMINIX_BOSS_3
VIDA_ANCHO_BARRA_BOSS_3:					equ	99

PAGINA_REGRESO_BOSS_3:						equ	29

; VRAM / sprites
SPRITES_ATRIBUTOS_VRAM_BOSS_3:				equ	#4A00
SPRITES_COLOR_VRAM_BOSS_3:					equ	#4800
PATRONES_SPRITES_VRAM_BOSS_3:				equ	#4000
PAGE_1_VRAM_Y_BOSS_3:						equ	#0100
PAGE_2_VRAM_Y_BOSS_3:						equ	#0200
PAGE_X_VRAM_BOSS_3:							equ	#0000
SPRITES_LIMPIA_INICIAL_BOSS_3:				equ	10
SPRITES_LIMPIA_CANT_INICIAL_BOSS_3:			equ	22
BARRO_PATRON_INICIAL_BOSS_3:				equ	100
BARRO_PATRON_DERECHA_BOSS_3:					equ	BARRO_PATRON_INICIAL_BOSS_3
BARRO_PATRON_IZQUIERDA_BOSS_3:				equ	BARRO_PATRON_INICIAL_BOSS_3+4
BARRO_COLOR_INICIAL_BOSS_3:					equ	BARRO_PATRON_INICIAL_BOSS_3/4
BARRO_CANTIDAD_BOSS_3:						equ	4
COVID_EXPLOSION_PATRON_INICIAL_BOSS_3:		equ	BARRO_PATRON_INICIAL_BOSS_3-8
COVID_EXPLOSION_PATRON_FINAL_BOSS_3:		equ	BARRO_PATRON_INICIAL_BOSS_3
COVID_PATRON_INICIAL_BOSS_3:				equ	BARRO_PATRON_INICIAL_BOSS_3+BARRO_CANTIDAD_BOSS_3*4
COVID_PATRON_CANT_BOSS_3:					equ	2

BUBBLES_PATRON_INICIAL_BOSS_3:              equ COVID_PATRON_INICIAL_BOSS_3+COVID_PATRON_CANT_BOSS_3*4
BUBBLES_PATRON_CANT_BOSS_3:                 equ 2
BUBBLES_BOSS_3_SPRITE_INICIAL:              equ PROYECTIL_BOSS_3_SPRITE_FINAL
BUBBLES_BOSS_3_CANTIDAD:                    equ 2
BUBBLES_COLOR_VRAM_BOSS_3:                  equ SPRITES_COLOR_VRAM_BOSS_3+BUBBLES_BOSS_3_SPRITE_INICIAL*16

COVID_BOSS_3_CADA_CICLOS:					equ	10
COVID_BOSS_3_CANTIDAD:						equ	4
COVID_BOSS_3_X_INICIAL:						equ	0
COVID_BOSS_3_Y_INICIAL:						equ	0
COVID_BOSS_3_Y_OCULTO:						equ	217
COVID_BOSS_3_Y_MUERTE:						equ	217
COVID_BOSS_3_PASO_Y:						equ	1
COVID_BOSS_3_TABLA_X_LONGITUD:				equ	128
BARROS_MUERTE_CANTIDAD_BOSS_3:				equ	8
BARROS_MUERTE_SPRITE_INICIAL_BOSS_3:			equ	10
BARROS_MUERTE_ATRIBUTOS_VRAM_BOSS_3:			equ	SPRITES_ATRIBUTOS_VRAM_BOSS_3+BARROS_MUERTE_SPRITE_INICIAL_BOSS_3*4
BARROS_MUERTE_COLOR_VRAM_BOSS_3:				equ	SPRITES_COLOR_VRAM_BOSS_3+BARROS_MUERTE_SPRITE_INICIAL_BOSS_3*16
BARROS_MUERTE_PASOS_ENTRE_COPY_BOSS_3:		equ	8
BARROS_MUERTE_SALIDA_PAUSA_BOSS_3:			equ	1
BARROS_MUERTE_ENTRADA_PAUSA_BOSS_3:			equ	1
BARROS_MUERTE_Y_OCULTA_BOSS_3:				equ	217
BARROS_MUERTE_X_OCULTA_BOSS_3:				equ	255
BARROS_MUERTE_PASO_X_BOSS_3:					equ	3
COPY_SIN_OFFSET_BOSS_3:						equ	#00
COPY_LOGICA_NORMAL_BOSS_3:					equ	10010000b
COPY_LOGICA_RELLENO_BOSS_3:					equ	11000000b

; Proyectiles del boss
PROYECTILES_BOSS_3_CANTIDAD:				equ	8
PROYECTIL_BOSS_3_ESPERA_INICIAL:			equ	15
PROYECTIL_BOSS_3_SPRITE_INICIAL:			equ	22
PROYECTIL_BOSS_3_SPRITE_FINAL:				equ	30
PROYECTIL_BOSS_3_Y_OCULTO:					equ	217
PROYECTIL_BOSS_3_SPRITES_ACTIVOS_OFS:		equ	12
PROYECTIL_BOSS_3_ATRIBUTOS_VRAM:			equ	SPRITES_ATRIBUTOS_VRAM_BOSS_3+PROYECTIL_BOSS_3_SPRITE_INICIAL*4
PROYECTIL_BOSS_3_COLOR_VRAM:				equ	SPRITES_COLOR_VRAM_BOSS_3+PROYECTIL_BOSS_3_SPRITE_INICIAL*16
COVID_BOSS_3_SPRITE_INICIAL:					equ	PROYECTIL_BOSS_3_SPRITE_INICIAL-COVID_BOSS_3_CANTIDAD
COVID_BOSS_3_SPRITE_FINAL:					equ	PROYECTIL_BOSS_3_SPRITE_INICIAL
COVID_BOSS_3_ATRIBUTOS_VRAM:					equ	SPRITES_ATRIBUTOS_VRAM_BOSS_3+COVID_BOSS_3_SPRITE_INICIAL*4
COVID_COLOR_VRAM_BOSS_3:					equ	SPRITES_COLOR_VRAM_BOSS_3+COVID_BOSS_3_SPRITE_INICIAL*16
PROYECTIL_BOSS_3_PATRON_SPRITE:				equ	BARRO_PATRON_INICIAL_BOSS_3
PROYECTIL_BOSS_3_OFFSET_DER_X:				equ	98-8
PROYECTIL_BOSS_3_OFFSET_IZQ_X:				equ	29-8
PROYECTIL_BOSS_3_OFFSET_Y:					equ	25-8
PROYECTIL_BOSS_3_OFFSET_BOCA_X:				equ	9
PROYECTIL_BOSS_3_OFFSET_BOCA_Y:				equ	33
PROYECTIL_BOSS_3_FOTOGRAMA_DISPARO:			equ	3
PROYECTIL_BOSS_3_DIRECCION_MIN:				equ	1
PROYECTIL_BOSS_3_DIRECCION_MAX:				equ	11
; Salida y muerte de Agonix
COLOR_ALEATORIO_SIN_CAMBIOS_BOSS_3:			equ	1
CHUMINIX_PAUSA_BOCA_BOSS_3:					equ	100
CHUMINIX_LIMPIA_SPRITE_INICIAL_BOSS_3:		equ	10
CHUMINIX_LIMPIA_SPRITES_CANT_BOSS_3:			equ	20

CHUMINIX_MUERTE_SX_BOSS_3:					equ	0
CHUMINIX_MUERTE_SY_BOSS_3:					equ	CHUMINIX_MOVIMIENTO_Y_BOSS_3
CHUMINIX_MUERTE_DX_BOSS_3:					equ	0
CHUMINIX_MUERTE_DY_BOSS_3:					equ	CHUMINIX_MOVIMIENTO_Y_BOSS_3+1
CHUMINIX_MUERTE_ANCHO_BOSS_3:					equ	CHUMINIX_MOVIMIENTO_ANCHO_BOSS_3
CHUMINIX_MUERTE_ALTO_BOSS_3:					equ	CHUMINIX_MOVIMIENTO_ALTO_BOSS_3
CHUMINIX_MUERTE_Y_LIMITE_VISIBLE_BOSS_3:		equ	CHUMINIX_MUERTE_DY_BOSS_3+CHUMINIX_MUERTE_ALTO_BOSS_3
CHUMINIX_MUERTE_BUCLES_BOSS_3:				equ	CHUMINIX_MUERTE_Y_LIMITE_VISIBLE_BOSS_3-CHUMINIX_MUERTE_DY_BOSS_3
CHUMINIX_MUERTE_FX_BOSS_3:					equ	31
CHUMINIX_MUERTE_FX_CANAL_BOSS_3:				equ	0
CHUMINIX_MUERTE_PAUSA_BOSS_3:					equ	8
BARROS_MUERTE_Y_BOSS_3:						equ	CHUMINIX_MUERTE_DY_BOSS_3+CHUMINIX_MUERTE_ALTO_BOSS_3-16
BARROS_MUERTE_X_MIN_OFFSET_BOSS_3:			equ	20
BARROS_MUERTE_X_MAX_OFFSET_BOSS_3:			equ	CHUMINIX_MUERTE_ANCHO_BOSS_3-20
BUBBLES_MUERTE_Y_OBJETIVO_BOSS_3:			equ	CHUMINIX_MOVIMIENTO_Y_BOSS_3
BUBBLES_MUERTE_PATRON_1_BOSS_3:				equ	BUBBLES_PATRON_INICIAL_BOSS_3
BUBBLES_MUERTE_PATRON_2_BOSS_3:				equ	BUBBLES_PATRON_INICIAL_BOSS_3+4
BUBBLES_MUERTE_VELOCIDAD_MAX_BOSS_3:			equ	5
CHUMINIX_BUFFER_X_BOSS_3:						equ	0
CHUMINIX_BUFFER_Y_BOSS_3:						equ	0

DEPH_SALIDA_SPRITES_INICIO_BOSS_3:			equ	1
DEPH_SALIDA_SPRITES_CANT_BOSS_3:			equ	45

DEPH_LODO_LIMITE_Y_BOSS_3:				equ	85
DEPH_LODO_ESTADO_NORMAL_BOSS_3:			equ	0
DEPH_LODO_ESTADO_ACTIVO_BOSS_3:			equ	1
DEPH_LODO_PATRON_INICIO_BOSS_3:			equ	5
DEPH_LODO_PATRON_CANT_BOSS_3:			equ	18
DEPH_LODO_COLOR_INICIO_BOSS_3:			equ	4
DEPH_LODO_COLOR_CANT_BOSS_3:			equ	6
DEPH_LODO_SPRITES_VRAM_BOSS_3:			equ	PATRONES_SPRITES_VRAM_BOSS_3+DEPH_LODO_PATRON_INICIO_BOSS_3*8*4
DEPH_LODO_SPRITES_NORMAL_OFFSET_BOSS_3:	equ	(DEPH_LODO_PATRON_INICIO_BOSS_3-DEPH_SALIDA_SPRITES_INICIO_BOSS_3)*8*4
DEPH_LODO_COLOR_VRAM_BOSS_3:				equ	SPRITES_COLOR_VRAM_BOSS_3+DEPH_LODO_COLOR_INICIO_BOSS_3*16

CHUMINIX_MOVIMIENTO_Y_BOSS_3:					equ	28
CHUMINIX_MOVIMIENTO_PASO_X_BOSS_3:			equ	6
CHUMINIX_MOVIMIENTO_ESPERA_BOSS_3:			equ	6
CHUMINIX_MOVIMIENTO_PAG_DERECHA_BOSS_3:		equ	1
CHUMINIX_MOVIMIENTO_ANCHO_BOSS_3:				equ	96
CHUMINIX_MOVIMIENTO_ALTO_BOSS_3:				equ	62
CHUMINIX_MOVIMIENTO_X_VISIBLE_DERECHA_BOSS_3:	equ	256-CHUMINIX_MOVIMIENTO_ANCHO_BOSS_3
CHUMINIX_MOVIMIENTO_FOTOGRAMAS_BOSS_3:			equ	9
CHUMINIX_MOVIMIENTO_MEDIO_ANCHO_BOSS_3:		equ	48
CHUMINIX_MOVIMIENTO_BORRA_ANCHO_BOSS_3:		equ	6
CHUMINIX_MOVIMIENTO_BORRA_ALTO_BOSS_3:		equ	62
CHUMINIX_MOVIMIENTO_BORRA_COLOR_BOSS_3:		equ	#66


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
		ld		(PROYECTIL_BOSS_3_DIRECCION),a
		ld		(PROYECTIL_BOSS_3_PASO_TABLA),a
		ld		(PROYECTIL_BOSS_3_X),a
		ld		(PROYECTIL_BOSS_3_SIGUIENTE_EMISOR),a
		ld		a,PROYECTIL_BOSS_3_ESPERA_INICIAL
		ld		(PROYECTIL_BOSS_3_ESPERA),a
		ld		a,PROYECTIL_BOSS_3_SPRITE_INICIAL
		ld		(PROYECTIL_BOSS_3_SPRITE_ACTUAL),a
		ld		(PROYECTIL_BOSS_3_SIGUIENTE_SPRITE),a
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_3_SPRITES_ACTIVOS_OFS
		ld		a,l
		ld		(PROYECTIL_BOSS_3_PUNTERO_SPRITES_ACTIVOS),a
		ld		a,h
		ld		(PROYECTIL_BOSS_3_PUNTERO_SPRITES_ACTIVOS+1),a
		ld		hl,PROYECTIL_BOSS_3_ATRIBUTOS_VRAM
		ld		a,l
		ld		(PROYECTIL_BOSS_3_DIRECCION_VRAM_ATRIBUTOS),a
		ld		a,h
		ld		(PROYECTIL_BOSS_3_DIRECCION_VRAM_ATRIBUTOS+1),a
		ld		hl,PROYECTIL_BOSS_3_COLOR_VRAM
		ld		a,l
		ld		(PROYECTIL_BOSS_3_DIRECCION_VRAM_COLOR),a
		ld		a,h
		ld		(PROYECTIL_BOSS_3_DIRECCION_VRAM_COLOR+1),a
		xor		a
		ld		(SPRITES_ACTIVOS+PROYECTIL_BOSS_3_SPRITES_ACTIVOS_OFS),a
		ld		(VALORES_EXPLOSION_CON_ROCK),a
		ld		(VALORES_EXPLOSION_CON_ROCK+1),a
		ld		(VALORES_EXPLOSION_CON_ROCK+2),a
		ld		(VALORES_EXPLOSION_CON_ROCK+3),a
		ld		a,VIDA_INICIAL_CHUMINIX_BOSS_3
		ld		(VIDA_CHUMINIX_BOSS_3),a
		ld		a,255
		ld		(CHUMINIX_BOSS_3_X),a
		xor		a
		ld		(CHUMINIX_BOSS_3_DIRECCION),a
		ld		(CHUMINIX_BOSS_3_FOTOGRAMA),a
		ld		(CHUMINIX_BOSS_3_MODO),a
		ld		(DEPH_LODO_ESTADO_BOSS_3),a
		ld		(DEPH_LODO_ESPERA_BOSS_3),a
		ld		a,CHUMINIX_MOVIMIENTO_ESPERA_BOSS_3
		ld		(CHUMINIX_BOSS_3_ESPERA_MOVIMIENTO),a
		ld		a,PROYECTIL_BOSS_3_Y_OCULTO
		ld		(PROYECTIL_BOSS_3_Y),a

        ; Variables a reiniciar


        push    ix
        push    iy
        push    bc
        push    de

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
; Carga de patrones y colores del barro.
; OJO: debe ir DESPUES de RUTINA_BOSS_3 para que la entrada del banco
; siga empezando en RUTINA_BOSS_3. Si se coloca antes, el boss puede entrar
; por esta rutina y colgarse antes de iniciar el flujo normal.
; -----------------------------------------------------------------------------
CARGA_SPRITES_BARRO_BOSS_3:
		
		call	PAGE_32_A_SEGMENT_2
		; Aquí llamaremos sprites si es necesario

		ret

ANIMACION_BOSS_3_COMIENZO:

		; Aquí llamaremos animaciones si es necesario
		ret

BUCLE_PELEA_BOSS_3:

		HALT
		ld		a,(CORAZONES)
		or		a
		jp		z,MUERTE_DEPH_EN_BOSS_3
		call	NUCLEO_DE_LA_PELEA_BOSS_3
		
		call	SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_3
		call	PINTA_PROYECTILES_DE_DEPH_EN_BOSS_3
        call    REVISAMOS_COLISION_CON_CHUMINIX_Y_DEPH
		call	ON_SPRITE_GLOBAL_BOSS_3
		call	REVISAMOS_COLISION_CON_CHUMINIX_Y_PROYECTILES_DEPH
		call	MUEVE_CHUMINIX_BOSS_3


        ld      a,(TIEMPO_DE_ADJUST)
        or      a
        jr      z,.CONTROL_POST_BUCLE_2
        dec     a
	ld      (TIEMPO_DE_ADJUST),a
	jr      nz,.CONTROL_POST_BUCLE_2
	xor     a
	ld      (COLOR_ALEATORIO),a

.CONTROL_POST_BUCLE_2:

		jp	BUCLE_PELEA_BOSS_3

NUCLEO_DE_LA_PELEA_BOSS_3:

		call	CONTROL_DISPARO_CHUMINIX_BOSS_3
		call	SECUENCIA_PROYECTIL_BOSS_3						; doble velocidad
		call	SECUENCIA_PROYECTIL_BOSS_3						; doble velocidad
		ret

CONTROL_DISPARO_CHUMINIX_BOSS_3:

		; Aquí el control de disparo de Chuminix.
		ret

INICIALIZA_POOL_PROYECTILES_BOSS_3:

		xor		a
		ld		(PROYECTIL_BOSS_3_SIGUIENTE_EMISOR),a
		ld		(PROYECTIL_BOSS_3_INDICE_ACTUAL),a
		ld		hl,PROYECTILES_BOSS_3_DIRECCION
		ld		b,PROYECTILES_BOSS_3_CANTIDAD

.INICIALIZA_DIRECCIONES_PROYECTIL_BOSS_3:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_DIRECCIONES_PROYECTIL_BOSS_3
		ld		hl,PROYECTILES_BOSS_3_PASO_TABLA
		ld		b,PROYECTILES_BOSS_3_CANTIDAD

.INICIALIZA_PASOS_PROYECTIL_BOSS_3:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_PASOS_PROYECTIL_BOSS_3
		ld		hl,PROYECTILES_BOSS_3_X
		ld		b,PROYECTILES_BOSS_3_CANTIDAD

.INICIALIZA_X_PROYECTIL_BOSS_3:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_X_PROYECTIL_BOSS_3
		ld		a,PROYECTIL_BOSS_3_Y_OCULTO
		ld		hl,PROYECTILES_BOSS_3_Y
		ld		b,PROYECTILES_BOSS_3_CANTIDAD

.INICIALIZA_Y_PROYECTIL_BOSS_3:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_Y_PROYECTIL_BOSS_3
		xor		a
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_3_SPRITES_ACTIVOS_OFS
		ld		b,PROYECTILES_BOSS_3_CANTIDAD

.INICIALIZA_SPRITES_ACTIVOS_PROYECTIL_BOSS_3:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_SPRITES_ACTIVOS_PROYECTIL_BOSS_3
		ld		a,PROYECTIL_BOSS_3_SPRITE_INICIAL
		ld		(PROYECTIL_BOSS_3_SIGUIENTE_SPRITE),a
		ld		(PROYECTIL_BOSS_3_SPRITE_ACTUAL),a
		ld		a,PROYECTIL_BOSS_3_ESPERA_INICIAL
		ld		(PROYECTIL_BOSS_3_ESPERA),a
		ret


SECUENCIA_PROYECTIL_BOSS_3:
		; Aquí la secuencia de disparo de los proyectiles del boss, que incluye la lógica para determinar la dirección a disparar según la posición de Chuminix.
		ret

MUEVE_CHUMINIX_BOSS_3:

		; Aquí creamos la secuencia de movimiento de chuminix
		ret

SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_3:

		include	"COMUN/SECUENCIA PROYECTILES PROPIOS EN BOSSES.asm"

PINTA_PROYECTILES_DE_DEPH_EN_BOSS_3:

		include	"COMUN/PINTADO PROYECTILES PROPIOS EN BOSSES.asm"

ON_SPRITE_GLOBAL_BOSS_3:

	jp		REVISAMOS_COLISION_CON_DEPH_Y_COVIDS_BOSS_3

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

REVISAMOS_COLISION_CON_CHUMINIX_Y_DEPH:
		; Aquí revisamos colisiones entre Chuminix y Deph, que pueden ocurrir si Chuminix toca a Deph o si Chuminix toca el barro activo.
		ret

DANO_DEPH_EN_BOSS_3:

	call	DANO_DEPH_EN_BOSS_COMUN
	call	RUTINA_BOSS_3.PINTA_CORAZONES_VIDA_DEPH_ADECUADOS
	ret

MUERTE_DEPH_EN_BOSS_3:

	call	PREPARA_VRAM_PARA_MUERTE_DEPH_EN_BOSS
	jp		MUERTE_POR_TOQUES_DESDE_BOSS

REVISAMOS_COLISION_CON_DEPH_Y_COVIDS_BOSS_3:

		ld		b,COVID_BOSS_3_CANTIDAD
		xor		a
		ld		(COVID_BOSS_3_INDICE_ACTUAL),a

.BUCLE_COLISION_DEPH_COVIDS_BOSS_3:

		push	bc
		ld		a,(hl)
		or		a
		jr		z,.SIGUIENTE_COLISION_DEPH_COVID_BOSS_3

		; Caja Deph/COVID ajustada:
		; Deph aprox. 20x20 contra COVID hitbox 8x4 centrado en sprite 16x16.
		; COVID hitbox: X+4, Y+6, ancho 8, alto 4.

		ld		a,(hl)
		add		4
		ld		c,a
		ld		a,(X_DEPH)
		add		20
		sub		c
		cp		28
		jr		nc,.SIGUIENTE_COLISION_DEPH_COVID_BOSS_3

		ld		a,(hl)
		add		6
		ld		c,a
		ld		a,(Y_DEPH)
		add		20
		sub		c
		cp		24
		jr		nc,.SIGUIENTE_COLISION_DEPH_COVID_BOSS_3

		call	DANO_DEPH_EN_BOSS_3
		pop		bc
		ret

.SIGUIENTE_COLISION_DEPH_COVID_BOSS_3:

		ld		a,(COVID_BOSS_3_INDICE_ACTUAL)
		inc		a
		ld		(COVID_BOSS_3_INDICE_ACTUAL),a
		pop		bc
		djnz	.BUCLE_COLISION_DEPH_COVIDS_BOSS_3
		ret

REVISAMOS_COLISION_CON_CHUMINIX_Y_PROYECTILES_DEPH:


		; Aquí gestionaremos onsprites entre el malo y los proytectiles de Deph.
		ret

TIRA_FX_BOSS_3:

		call	PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
		jp		PAGE_10_A_SEGMENT_2

MUERTE_DE_CHUMINIX_BOSS_3:
; paramos la música
		call	stpmus

; Nos aseguramos que el prota no está en modo transparente ni el fondo en colores varios
		ld		a,COLOR_ALEATORIO_SIN_CAMBIOS_BOSS_3
		ld		(COLOR_ALEATORIO),a
		xor		a
		ld		(INMUNE),a

; pequeña pausa
		ld		a,CHUMINIX_PAUSA_BOCA_BOSS_3
		call	BUCLE_PINTA_TILES.rutina_de_pausa

; limpiamos sprites
		xor		a
		ld		hl,SPRITES_ATRIBUTOS_VRAM_BOSS_3+CHUMINIX_LIMPIA_SPRITE_INICIAL_BOSS_3*4
		ld		bc,CHUMINIX_LIMPIA_SPRITES_CANT_BOSS_3*4
		call	FILVRM_RAM


; animamos la muerte de AGONIX		


TERMINANDO_LA_BATALLA_b3:

		include	"../AUDIOS/INICIA MUSICA_WIN.asm"

		ld		hl,TODOS_LOS_SPRITES
		call	PAGE_32_A_SEGMENT_2
		ld		de,PATRONES_SPRITES_VRAM_BOSS_3+DEPH_SALIDA_SPRITES_INICIO_BOSS_3*8*4
		ld		bc,DEPH_SALIDA_SPRITES_CANT_BOSS_3*8*4
		call	PON_COLOR_2.sin_bc_impuesta
		call	PAGE_10_A_SEGMENT_2
		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM
		call	PAGE_10_A_SEGMENT_2

CAMINITO_A_PUERTA_b3:

		include	"../ANIMACIONES/PASEITO HASTA PUERTA.asm"		
		include	"../ANIMACIONES/SALUDO_GANA_FASE.asm"		

ULTIMO_DESPLAZAMIENTO_b3:

		include	"../ANIMACIONES/PASEITO DENTRO DE PUERTA.asm"	

VOLVEMOS_b3:

		jp		CARGA_SLOT_REGRESO_A_JUEGO

; Rutas iniciales de los COVIDs Boss 4.
; Ruta 0: X=0,   Y=0   -> baja y empieza hacia la derecha.
; Ruta 1: X=250, Y=191 -> sube y empieza hacia la izquierda.
; Ruta 2: X=255, Y=0   -> baja y empieza hacia la izquierda.
; Ruta 3: X=0,   Y=191 -> sube y empieza hacia la derecha.
TABLA_X_INICIAL_COVID_BOSS_3:

		db		0,250,255,0

TABLA_Y_INICIAL_COVID_BOSS_3:

		db		0,191,0,191

TABLA_PASO_Y_COVID_BOSS_3:

		db		1,255,1,255			; 255 = -1

; Tabla 0: avance horizontal normal.
; Suma total derecha: 240 px. Suma total izquierda: -240 px.
; Maximo desplazamiento: 4 px por ciclo.
TABLA_MOVIMIENTO_X_COVID_BOSS_3:

		db		1,2,3
[57]	db		4
		db		3,2,1,0
		db		255,254,253			; -1,-2,-3
[57]	db		252				; -4
		db		253,254,255,0		; -3,-2,-1,0

; Tabla 1: recorrido inverso horizontal.
TABLA_MOVIMIENTO_X_COVID_BOSS_3_1:

		db		255,254,253			; -1,-2,-3
[57]	db		252				; -4
		db		253,254,255,0		; -3,-2,-1,0
		db		1,2,3
[57]	db		4
		db		3,2,1,0

; Tabla 2: recorrido inverso horizontal, para salida desde X=255,Y=0.
TABLA_MOVIMIENTO_X_COVID_BOSS_3_2:

		db		255,254,253			; -1,-2,-3
[57]	db		252				; -4
		db		253,254,255,0		; -3,-2,-1,0
		db		1,2,3
[57]	db		4
		db		3,2,1,0

; Tabla 3: avance horizontal normal, para salida desde X=0,Y=191.
TABLA_MOVIMIENTO_X_COVID_BOSS_3_3:

		db		1,2,3
[57]	db		4
		db		3,2,1,0
		db		255,254,253			; -1,-2,-3
[57]	db		252				; -4
		db		253,254,255,0		; -3,-2,-1,0

; Color local para COVIDs del Boss 4.
; Independiente del color COVID general.
COLOR_COVID_BOSS_3:

[16]	db		#0B

; Variables COVID/LODO Boss 4 movidas a VARIABLES BOSSES.asm (RAM).


	include	"BOSS 3 DATA.asm"
