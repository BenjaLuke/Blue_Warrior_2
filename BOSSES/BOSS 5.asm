VIDA_INICIAL_IDIUS_BOSS_5:				equ	160
VIDA_TOTAL_INICIAL_BOSS_5:					equ	VIDA_INICIAL_IDIUS_BOSS_5
VIDA_ANCHO_BARRA_BOSS_5:					equ	99

PAGINA_REGRESO_BOSS_5:						equ	30

; VRAM / sprites
SPRITES_ATRIBUTOS_VRAM_BOSS_5:				equ	#4A00
SPRITES_COLOR_VRAM_BOSS_5:					equ	#4800
PATRONES_SPRITES_VRAM_BOSS_5:				equ	#4000
PAGE_1_VRAM_Y_BOSS_5:						equ	#0100
PAGE_2_VRAM_Y_BOSS_5:						equ	#0200
PAGE_3_VRAM_Y_BOSS_5:						equ	#0300
PAGE_X_VRAM_BOSS_5:							equ	#0000
SPRITES_LIMPIA_INICIAL_BOSS_5:				equ	10
SPRITES_LIMPIA_CANT_INICIAL_BOSS_5:			equ	22
BARRO_PATRON_INICIAL_BOSS_5:				equ	100
BARRO_PATRON_DERECHA_BOSS_5:					equ	BARRO_PATRON_INICIAL_BOSS_5
BARRO_PATRON_IZQUIERDA_BOSS_5:				equ	BARRO_PATRON_INICIAL_BOSS_5+4
BARRO_COLOR_INICIAL_BOSS_5:					equ	BARRO_PATRON_INICIAL_BOSS_5/4
BARRO_CANTIDAD_BOSS_5:						equ	4

BUBBLES_PATRON_INICIAL_BOSS_5:              equ BARRO_PATRON_INICIAL_BOSS_5+BARRO_CANTIDAD_BOSS_5*4
BUBBLES_PATRON_CANT_BOSS_5:                 equ 2
BUBBLES_BOSS_5_SPRITE_INICIAL:              equ PROYECTIL_BOSS_5_SPRITE_FINAL
BUBBLES_BOSS_5_CANTIDAD:                    equ 2
BUBBLES_COLOR_VRAM_BOSS_5:                  equ SPRITES_COLOR_VRAM_BOSS_5+BUBBLES_BOSS_5_SPRITE_INICIAL*16

BARROS_MUERTE_CANTIDAD_BOSS_5:				equ	8
BARROS_MUERTE_SPRITE_INICIAL_BOSS_5:			equ	10
BARROS_MUERTE_ATRIBUTOS_VRAM_BOSS_5:			equ	SPRITES_ATRIBUTOS_VRAM_BOSS_5+BARROS_MUERTE_SPRITE_INICIAL_BOSS_5*4
BARROS_MUERTE_COLOR_VRAM_BOSS_5:				equ	SPRITES_COLOR_VRAM_BOSS_5+BARROS_MUERTE_SPRITE_INICIAL_BOSS_5*16
BARROS_MUERTE_PASOS_ENTRE_COPY_BOSS_5:		equ	8
BARROS_MUERTE_SALIDA_PAUSA_BOSS_5:			equ	1
BARROS_MUERTE_ENTRADA_PAUSA_BOSS_5:			equ	1
BARROS_MUERTE_Y_OCULTA_BOSS_5:				equ	217
BARROS_MUERTE_X_OCULTA_BOSS_5:				equ	255
BARROS_MUERTE_PASO_X_BOSS_5:					equ	3
COPY_SIN_OFFSET_BOSS_5:						equ	#00
COPY_LOGICA_NORMAL_BOSS_5:					equ	10010000b
COPY_LOGICA_RELLENO_BOSS_5:					equ	11000000b

; Proyectiles del boss
PROYECTILES_BOSS_5_CANTIDAD:				equ	8
PROYECTIL_BOSS_5_ESPERA_INICIAL:			equ	15
PROYECTIL_BOSS_5_SPRITE_INICIAL:			equ	22
PROYECTIL_BOSS_5_SPRITE_FINAL:				equ	30
PROYECTIL_BOSS_5_Y_OCULTO:					equ	217
PROYECTIL_BOSS_5_SPRITES_ACTIVOS_OFS:		equ	12
PROYECTIL_BOSS_5_ATRIBUTOS_VRAM:			equ	SPRITES_ATRIBUTOS_VRAM_BOSS_5+PROYECTIL_BOSS_5_SPRITE_INICIAL*4
PROYECTIL_BOSS_5_COLOR_VRAM:				equ	SPRITES_COLOR_VRAM_BOSS_5+PROYECTIL_BOSS_5_SPRITE_INICIAL*16
IDIUS_EXPLOSION_PATRON_INICIAL_BOSS_5:		equ	BARRO_PATRON_INICIAL_BOSS_5-8
IDIUS_EXPLOSION_PATRON_FINAL_BOSS_5:		equ	BARRO_PATRON_INICIAL_BOSS_5
PROYECTIL_BOSS_5_PATRON_SPRITE:				equ	BARRO_PATRON_INICIAL_BOSS_5
PROYECTIL_BOSS_5_OFFSET_DER_X:				equ	98-8
PROYECTIL_BOSS_5_OFFSET_IZQ_X:				equ	29-8
PROYECTIL_BOSS_5_OFFSET_Y:					equ	25-8
PROYECTIL_BOSS_5_OFFSET_BOCA_X:				equ	9
PROYECTIL_BOSS_5_OFFSET_BOCA_Y:				equ	33
PROYECTIL_BOSS_5_FOTOGRAMA_DISPARO:			equ	3
PROYECTIL_BOSS_5_DIRECCION_MIN:				equ	1
PROYECTIL_BOSS_5_DIRECCION_MAX:				equ	11
; Salida y muerte de Agonix
COLOR_ALEATORIO_SIN_CAMBIOS_BOSS_5:			equ	1
IDIUS_PAUSA_BOCA_BOSS_5:					equ	100
IDIUS_LIMPIA_SPRITE_INICIAL_BOSS_5:		equ	10
IDIUS_LIMPIA_SPRITES_CANT_BOSS_5:			equ	20

IDIUS_MUERTE_SX_BOSS_5:					equ	0
IDIUS_MUERTE_SY_BOSS_5:					equ	IDIUS_MOVIMIENTO_Y_BOSS_5
IDIUS_MUERTE_DX_BOSS_5:					equ	0
IDIUS_MUERTE_DY_BOSS_5:					equ	IDIUS_MOVIMIENTO_Y_BOSS_5+1
IDIUS_MUERTE_ANCHO_BOSS_5:					equ	IDIUS_MOVIMIENTO_ANCHO_BOSS_5
IDIUS_MUERTE_ALTO_BOSS_5:					equ	IDIUS_MOVIMIENTO_ALTO_BOSS_5
IDIUS_MUERTE_Y_LIMITE_VISIBLE_BOSS_5:		equ	IDIUS_MUERTE_DY_BOSS_5+IDIUS_MUERTE_ALTO_BOSS_5
IDIUS_MUERTE_BUCLES_BOSS_5:				equ	IDIUS_MUERTE_Y_LIMITE_VISIBLE_BOSS_5-IDIUS_MUERTE_DY_BOSS_5
IDIUS_MUERTE_FX_BOSS_5:					equ	31
IDIUS_MUERTE_FX_CANAL_BOSS_5:				equ	0
IDIUS_MUERTE_PAUSA_BOSS_5:					equ	8
BARROS_MUERTE_Y_BOSS_5:						equ	IDIUS_MUERTE_DY_BOSS_5+IDIUS_MUERTE_ALTO_BOSS_5-16
BARROS_MUERTE_X_MIN_OFFSET_BOSS_5:			equ	20
BARROS_MUERTE_X_MAX_OFFSET_BOSS_5:			equ	IDIUS_MUERTE_ANCHO_BOSS_5-20
BUBBLES_MUERTE_Y_OBJETIVO_BOSS_5:			equ	IDIUS_MOVIMIENTO_Y_BOSS_5
BUBBLES_MUERTE_PATRON_1_BOSS_5:				equ	BUBBLES_PATRON_INICIAL_BOSS_5
BUBBLES_MUERTE_PATRON_2_BOSS_5:				equ	BUBBLES_PATRON_INICIAL_BOSS_5+4
BUBBLES_MUERTE_VELOCIDAD_MAX_BOSS_5:			equ	5
IDIUS_BUFFER_X_BOSS_5:						equ	0
IDIUS_BUFFER_Y_BOSS_5:						equ	0

DEPH_SALIDA_SPRITES_INICIO_BOSS_5:			equ	1
DEPH_SALIDA_SPRITES_CANT_BOSS_5:			equ	45

IDIUS_MOVIMIENTO_Y_BOSS_5:					equ	28
IDIUS_MOVIMIENTO_PASO_X_BOSS_5:			equ	6
IDIUS_MOVIMIENTO_ESPERA_BOSS_5:			equ	6
IDIUS_MOVIMIENTO_PAG_DERECHA_BOSS_5:		equ	1
IDIUS_MOVIMIENTO_ANCHO_BOSS_5:				equ	70
IDIUS_MOVIMIENTO_ALTO_BOSS_5:				equ	74
IDIUS_MOVIMIENTO_X_VISIBLE_DERECHA_BOSS_5:	equ	256-IDIUS_MOVIMIENTO_ANCHO_BOSS_5
IDIUS_MOVIMIENTO_FOTOGRAMAS_BOSS_5:			equ	9
IDIUS_MOVIMIENTO_PAUSA_OCULTO_BOSS_5:		equ	40
IDIUS_MOVIMIENTO_BORRA_ANCHO_BOSS_5:		equ	6
IDIUS_MOVIMIENTO_BORRA_ALTO_BOSS_5:		equ	74
IDIUS_MOVIMIENTO_BORRA_COLOR_BOSS_5:		equ	#66


RUTINA_BOSS_5:

		call	stpmus

		ld      a,0
		ld      hl,SPRITES_ATRIBUTOS_VRAM_BOSS_5+SPRITES_LIMPIA_INICIAL_BOSS_5*4
		ld      bc,SPRITES_LIMPIA_CANT_INICIAL_BOSS_5*4
		call    FILVRM_RAM

.VARIABLES:

		ld		a,PAGINA_REGRESO_BOSS_5
		ld		(PAGINA_DE_REGRESO),a
		xor		a
		ld		(PROYECTIL_BOSS_5_DIRECCION),a
		ld		(PROYECTIL_BOSS_5_PASO_TABLA),a
		ld		(PROYECTIL_BOSS_5_X),a
		ld		(PROYECTIL_BOSS_5_SIGUIENTE_EMISOR),a
		ld		a,PROYECTIL_BOSS_5_ESPERA_INICIAL
		ld		(PROYECTIL_BOSS_5_ESPERA),a
		ld		a,PROYECTIL_BOSS_5_SPRITE_INICIAL
		ld		(PROYECTIL_BOSS_5_SPRITE_ACTUAL),a
		ld		(PROYECTIL_BOSS_5_SIGUIENTE_SPRITE),a
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_5_SPRITES_ACTIVOS_OFS
		ld		a,l
		ld		(PROYECTIL_BOSS_5_PUNTERO_SPRITES_ACTIVOS),a
		ld		a,h
		ld		(PROYECTIL_BOSS_5_PUNTERO_SPRITES_ACTIVOS+1),a
		ld		hl,PROYECTIL_BOSS_5_ATRIBUTOS_VRAM
		ld		a,l
		ld		(PROYECTIL_BOSS_5_DIRECCION_VRAM_ATRIBUTOS),a
		ld		a,h
		ld		(PROYECTIL_BOSS_5_DIRECCION_VRAM_ATRIBUTOS+1),a
		ld		hl,PROYECTIL_BOSS_5_COLOR_VRAM
		ld		a,l
		ld		(PROYECTIL_BOSS_5_DIRECCION_VRAM_COLOR),a
		ld		a,h
		ld		(PROYECTIL_BOSS_5_DIRECCION_VRAM_COLOR+1),a
		xor		a
		ld		(SPRITES_ACTIVOS+PROYECTIL_BOSS_5_SPRITES_ACTIVOS_OFS),a
		ld		(VALORES_EXPLOSION_CON_ROCK),a
		ld		(VALORES_EXPLOSION_CON_ROCK+1),a
		ld		(VALORES_EXPLOSION_CON_ROCK+2),a
		ld		(VALORES_EXPLOSION_CON_ROCK+3),a
		ld		a,VIDA_INICIAL_IDIUS_BOSS_5
		ld		(VIDA_IDIUS_BOSS_5),a
		ld		a,255
		ld		(IDIUS_BOSS_5_X),a
		xor		a
		ld		(IDIUS_BOSS_5_Y),a
		ld		(IDIUS_BOSS_5_DIRECCION),a
		ld		(IDIUS_BOSS_5_FOTOGRAMA),a
		ld		(IDIUS_BOSS_5_MODO),a
		inc		a
		ld		(IDIUS_BOSS_5_TIEMPO_MODO),a
		xor		a
		ld		a,IDIUS_MOVIMIENTO_ESPERA_BOSS_5
		ld		(IDIUS_BOSS_5_ESPERA_MOVIMIENTO),a
		ld		a,PROYECTIL_BOSS_5_Y_OCULTO
		ld		(PROYECTIL_BOSS_5_Y),a
		call	INICIALIZA_POOL_PROYECTILES_BOSS_5

        ; Variables a reiniciar


        push    ix
        push    iy
        push    bc
        push    de

.COPIA_A_1_PARTE_ALTA:

        ld      ix,BOSS_5_PAGE_2_A_PAGE_1_COMPLETA
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
        
        ld      ix,BOSS_5_PAGE_2_A_PAGE_1_COMPLETA
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

.GUARDA_DATOS_VIDA_IDIUS:

        ld      ix,BOSS_5_COPI_MARCADOR_BOSSES_CORAZONES_VACIOS
        ld      iy,DATAS_COR_EMPT_MALO
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_CORAZONES_EMPTY_DEPH:

        ld      ix,BOSS_5_COPY_CORAZONES_EMPTY_DEPH
        ld      iy,CORAZONES_DEPH_EN_BOSSES
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_PUNTOS_MAGIA:

        ld      ix,BOSS_5_COPY_PUNTOS_MAGIA
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
		call	CARGA_SPRITES_BARRO_BOSS_5

.CAMBIA_PAGE_PARA_OCULTAR:

        ld      a,1
        ld      (SET_PAGE),a

.COPIA_ESCENARIO_RECOLOCADO_A_PAGE_2:

 		ld	hl,BOSS_5_PAGE_1_A_PAGE_2_COMPLETA
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

.CARGA_IDIUS_PARTE_1:

        ld      a,54
        ld		b,55
        call	.CARGA_PANTALLA_COMPLETA

.CARGA_STATUS_BOSS:

        ld      a,59
        call	CHANGE_BANK_2

        ld		hl,STATUS_BOSS_5												; Carga gráficos status
        ld		de,#0000+(256*200)/2
        ld		bc,(256*54)/2
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,10
        call	CHANGE_BANK_2  

.PINTA_STATUS:

        ld      b,15
        ld      hl,BOSS_5_COPIA_PARTE_PAGE_2_DE_STATUS
		call	DOCOPY 

        ld      b,15
        ld      hl,BOSS_5_COPIA_STATUS_BOSS_A_PAGE_2
		call	DOCOPY 
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_5

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

		jp	BUCLE_PELEA_BOSS_5

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
; OJO: debe ir DESPUES de RUTINA_BOSS_5 para que la entrada del banco
; siga empezando en RUTINA_BOSS_5. Si se coloca antes, el boss puede entrar
; por esta rutina y colgarse antes de iniciar el flujo normal.
; -----------------------------------------------------------------------------
CARGA_SPRITES_BARRO_BOSS_5:
		
		call	PAGE_32_A_SEGMENT_2

		; Los dos patrones anteriores al barro quedan reservados para la
		; explosion de impacto: 92 y 96. NO se cargan aqui: ya estan
		; en VRAM en el sitio adecuado.
		; Barro empieza en 100: 100,104,108,112.
		ld		hl,SPRITE_BARRO
		ld		de,PATRONES_SPRITES_VRAM_BOSS_5+BARRO_PATRON_INICIAL_BOSS_5*8
		ld		bc,8*4*BARRO_CANTIDAD_BOSS_5
		call	PON_COLOR_2.sin_bc_impuesta

        ; Los BUBBLES quedan despues del barro.
        ld      hl,SPRITE_BUBBLES
        ld      de,PATRONES_SPRITES_VRAM_BOSS_5+BUBBLES_PATRON_INICIAL_BOSS_5*8
        ld      bc,8*4*BUBBLES_PATRON_CANT_BOSS_5
        call    PON_COLOR_2.sin_bc_impuesta

		; El color de sprites en SCREEN 7 va por NUMERO DE SPRITE,
		; no por patron. Los proyectiles usan los sprites 22-29,
		; asi que sus colores deben arrancar en #4800 + 22*16 = #4960.
		ld		de,PROYECTIL_BOSS_5_COLOR_VRAM
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.BUCLE_COLOR_BARRO_BOSS_5:

		push	bc
		push	de
		ld		hl,COLOR_BARRO
		ld		bc,16
		call	PON_COLOR_2.sin_bc_impuesta
		pop		de
		ld		a,e
		add		16
		ld		e,a
		jr		nc,.SIN_ACARREO_COLOR_BARRO_BOSS_5
		inc		d

.SIN_ACARREO_COLOR_BARRO_BOSS_5:

		pop		bc
		djnz	.BUCLE_COLOR_BARRO_BOSS_5

		call    PAGE_32_A_SEGMENT_2
        ld      de,BUBBLES_COLOR_VRAM_BOSS_5
        ld      b,BUBBLES_BOSS_5_CANTIDAD

.BUCLE_COLOR_BUBBLES_BOSS_5:

        push    bc
        push    de
        ld      hl,COLOR_BUBBLES
        ld      bc,16
        call    PON_COLOR_2.sin_bc_impuesta
        pop     de
        ld      a,e
        add     16
        ld      e,a
        jr      nc,.SIN_ACARREO_COLOR_BUBBLES_BOSS_5
        inc     d

.SIN_ACARREO_COLOR_BUBBLES_BOSS_5:

        pop     bc
        djnz    .BUCLE_COLOR_BUBBLES_BOSS_5

        call    PAGE_10_A_SEGMENT_2
		ret

BUCLE_PELEA_BOSS_5:

		HALT
		ld		a,(CORAZONES)
		or		a
		jp		z,MUERTE_DEPH_EN_BOSS_5
		call	NUCLEO_DE_LA_PELEA_BOSS_5
		call	CONTROLA_INMUNIDAD_DEPH_BOSS_5
		
		call	CONTROL_LODO_Y_MOVIMIENTO_DEPH_BOSS_5
		call	SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_5
		call	PINTA_PROYECTILES_DE_DEPH_EN_BOSS_5
        call    REVISAMOS_COLISION_CON_IDIUS_Y_DEPH
		call	ON_SPRITE_GLOBAL_BOSS_5
		call	REVISAMOS_COLISION_CON_IDIUS_Y_PROYECTILES_DEPH
		call	MUEVE_IDIUS_BOSS_5
		call	PINTA_EXPLOSION_IDIUS_BOSS_5


        ld      a,(TIEMPO_DE_ADJUST)
        or      a
        jr      z,.CONTROL_POST_BUCLE_2
        dec     a
	ld      (TIEMPO_DE_ADJUST),a
	jr      nz,.CONTROL_POST_BUCLE_2
	xor     a
	ld      (COLOR_ALEATORIO),a

.CONTROL_POST_BUCLE_2:

		call	PINTA_PROYECTIL_BOSS_5
		jp	BUCLE_PELEA_BOSS_5

NUCLEO_DE_LA_PELEA_BOSS_5:

		call	CONTROL_DISPARO_IDIUS_BOSS_5
		call	SECUENCIA_PROYECTIL_BOSS_5						; doble velocidad
		call	SECUENCIA_PROYECTIL_BOSS_5						; doble velocidad
		ret

CONTROL_DISPARO_IDIUS_BOSS_5:

		ret
		ld		a,(PROYECTIL_BOSS_5_ESPERA)
		or		a
		jr		z,.INTENTA_DISPARAR_PROYECTIL_IDIUS_BOSS_5
		dec		a
		ld		(PROYECTIL_BOSS_5_ESPERA),a
		ret		nz

.INTENTA_DISPARAR_PROYECTIL_IDIUS_BOSS_5:

		call	COMPRUEBA_MOMENTO_DISPARO_IDIUS_BOSS_5
		or		a
		ret		z
		ld		a,PROYECTIL_BOSS_5_ESPERA_INICIAL
		ld		(PROYECTIL_BOSS_5_ESPERA),a
		jp		ACTIVA_PROYECTIL_BOSS_5

COMPRUEBA_MOMENTO_DISPARO_IDIUS_BOSS_5:

		ld		a,(IDIUS_BOSS_5_FOTOGRAMA)
		cp		PROYECTIL_BOSS_5_FOTOGRAMA_DISPARO
		jr		nz,.NO_DISPARA_IDIUS_BOSS_5

		; Solo disparamos en el mismo bucle en que se va a pintar
		; el fotograma 3, que es el de la boca abierta.
		ld		a,(IDIUS_BOSS_5_ESPERA_MOVIMIENTO)
		cp		1
		jr		nz,.NO_DISPARA_IDIUS_BOSS_5

		call	CALCULA_RECORTE_IDIUS_BOSS_5
		ld		a,(VARIABLE_UN_USO2)			; ancho visible copiado
		cp		PROYECTIL_BOSS_5_OFFSET_BOCA_X+1
		jr		c,.NO_DISPARA_IDIUS_BOSS_5
		ld		a,(VARIABLE_UN_USO)			; recorte de origen por la izquierda
		cp		PROYECTIL_BOSS_5_OFFSET_BOCA_X+1
		jr		nc,.NO_DISPARA_IDIUS_BOSS_5
		ld		a,(VARIABLE_UN_USO3)			; X real donde se copia IDIUS
		add		PROYECTIL_BOSS_5_OFFSET_BOCA_X
		jr		c,.NO_DISPARA_IDIUS_BOSS_5

		ld		a,1
		ret

.NO_DISPARA_IDIUS_BOSS_5:

		xor		a
		ret

CONTROLA_INMUNIDAD_DEPH_BOSS_5:

		ld		a,(INMUNE)
		or		a
		ret		z
		dec		a
		ld		(INMUNE),a
		ret

INICIALIZA_POOL_PROYECTILES_BOSS_5:

		xor		a
		ld		(PROYECTIL_BOSS_5_SIGUIENTE_EMISOR),a
		ld		(PROYECTIL_BOSS_5_INDICE_ACTUAL),a
		ld		hl,PROYECTILES_BOSS_5_DIRECCION
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.INICIALIZA_DIRECCIONES_PROYECTIL_BOSS_5:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_DIRECCIONES_PROYECTIL_BOSS_5
		ld		hl,PROYECTILES_BOSS_5_PASO_TABLA
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.INICIALIZA_PASOS_PROYECTIL_BOSS_5:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_PASOS_PROYECTIL_BOSS_5
		ld		hl,PROYECTILES_BOSS_5_X
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.INICIALIZA_X_PROYECTIL_BOSS_5:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_X_PROYECTIL_BOSS_5
		ld		a,PROYECTIL_BOSS_5_Y_OCULTO
		ld		hl,PROYECTILES_BOSS_5_Y
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.INICIALIZA_Y_PROYECTIL_BOSS_5:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_Y_PROYECTIL_BOSS_5
		xor		a
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_5_SPRITES_ACTIVOS_OFS
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.INICIALIZA_SPRITES_ACTIVOS_PROYECTIL_BOSS_5:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_SPRITES_ACTIVOS_PROYECTIL_BOSS_5
		ld		a,PROYECTIL_BOSS_5_SPRITE_INICIAL
		ld		(PROYECTIL_BOSS_5_SIGUIENTE_SPRITE),a
		ld		(PROYECTIL_BOSS_5_SPRITE_ACTUAL),a
		ld		a,PROYECTIL_BOSS_5_ESPERA_INICIAL
		ld		(PROYECTIL_BOSS_5_ESPERA),a
		ret

ACTIVA_PROYECTIL_BOSS_5:

		call	CALCULA_RECORTE_IDIUS_BOSS_5
		ld		a,(VARIABLE_UN_USO2)			; si la boca no esta dentro
		cp		PROYECTIL_BOSS_5_OFFSET_BOCA_X+1	; de la parte visible, no dispara
		ret		c
		ld		a,(VARIABLE_UN_USO)
		cp		PROYECTIL_BOSS_5_OFFSET_BOCA_X+1
		ret		nc

		ld		a,(VARIABLE_UN_USO3)			; X donde se esta copiando IDIUS
		add		PROYECTIL_BOSS_5_OFFSET_BOCA_X
		ret		c
		ld		b,a
		ld		(PROYECTIL_BOSS_5_X),a
		ld		a,IDIUS_MOVIMIENTO_Y_BOSS_5+PROYECTIL_BOSS_5_OFFSET_BOCA_Y
		ld		c,a
		ld		(PROYECTIL_BOSS_5_Y),a
		call	CALCULA_DIRECCION_BASE_PROYECTIL_BOSS_5		; A = direccion hacia Deph
		jp		CREA_PROYECTIL_IDIUS_BOSS_5

CREA_PROYECTIL_IDIUS_BOSS_5:

		ld		(PROYECTIL_BOSS_5_DIRECCION),a
		call	RESERVA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_5
		ret		z
		ld		a,(PROYECTIL_BOSS_5_X)
		ld		b,a
		ld		a,(PROYECTIL_BOSS_5_Y)
		ld		c,a
		call	GUARDA_POSICION_PROYECTIL_BOSS_5_ACTUAL
		call	OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_5_ACTUAL
		xor		a
		ld		(hl),a
		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(PROYECTIL_BOSS_5_DIRECCION)
		ld		(hl),a
		call	CARGA_COLOR_PROYECTIL_BOSS_5_ACTUAL
		ret

SECUENCIA_PROYECTIL_BOSS_5:

		ld		b,PROYECTILES_BOSS_5_CANTIDAD
		xor		a
		ld		(PROYECTIL_BOSS_5_INDICE_ACTUAL),a

.BUCLE_SECUENCIA_PROYECTIL_BOSS_5:

		push	bc
		call	LEE_DIRECCION_TABLA_PROYECTIL_BOSS_5
		or		a
		jr		z,.SIGUIENTE_PROYECTIL_BOSS_5
		cp		2
		jr		z,.PROYECTIL_2
		cp		1
		jr		z,.PROYECTIL_1
		cp		4
		jr		z,.PROYECTIL_4
		cp		3
		jr		z,.PROYECTIL_3
		cp		6
		jr		z,.PROYECTIL_6
		cp		5
		jr		z,.PROYECTIL_5
		cp		8
		jr		z,.PROYECTIL_8
		cp		7
		jr		z,.PROYECTIL_7
		call	DESACTIVA_PROYECTIL_BOSS_5
		jr		.SIGUIENTE_PROYECTIL_BOSS_5

.SIGUIENTE_PROYECTIL_BOSS_5:

		ld		a,(PROYECTIL_BOSS_5_INDICE_ACTUAL)
		inc		a
		ld		(PROYECTIL_BOSS_5_INDICE_ACTUAL),a
		pop		bc
		djnz	.BUCLE_SECUENCIA_PROYECTIL_BOSS_5
		ret

.PROYECTIL_2:

		call	INC_X_PROYECTIL_BOSS_5_ACTUAL

.PROYECTIL_1:

		call	SUB_2_Y_PROYECTIL_BOSS_5_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_5
		jr		.SIGUIENTE_PROYECTIL_BOSS_5

.PROYECTIL_4:

		call	INC_Y_PROYECTIL_BOSS_5_ACTUAL

.PROYECTIL_3:

		call	INC_X_PROYECTIL_BOSS_5_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_5
		jr		.SIGUIENTE_PROYECTIL_BOSS_5

.PROYECTIL_6:

		call	DEC_X_PROYECTIL_BOSS_5_ACTUAL

.PROYECTIL_5:

		call	INC_Y_PROYECTIL_BOSS_5_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_5
		jr		.SIGUIENTE_PROYECTIL_BOSS_5

.PROYECTIL_8:

		call	SUB_2_Y_PROYECTIL_BOSS_5_ACTUAL

.PROYECTIL_7:

		call	DEC_X_PROYECTIL_BOSS_5_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_5
		jr		.SIGUIENTE_PROYECTIL_BOSS_5

COMPRUEBA_LIMITES_PROYECTIL_BOSS_5:

		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		cp		5
		jp		c,DESACTIVA_PROYECTIL_BOSS_5
		cp		192
		jp		nc,DESACTIVA_PROYECTIL_BOSS_5
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		cp		251
		jp		nc,DESACTIVA_PROYECTIL_BOSS_5
		ret

DESACTIVA_PROYECTIL_BOSS_5:

		xor		a
		push	af
		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_5_ACTUAL
		pop		af
		ld		(hl),a
		push	af
		call	OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_5_ACTUAL
		pop		af
		ld		(hl),a
		push	af
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_5_ACTUAL
		pop		af
		ld		(hl),a
		call	OBTIENE_PUNTERO_SPRITES_ACTIVOS_PROYECTIL_BOSS_5
		xor		a
		ld		(hl),a
		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_5_ACTUAL
		ld		a,PROYECTIL_BOSS_5_Y_OCULTO
		ld		(hl),a
		call	OCULTA_SPRITE_PROYECTIL_BOSS_5_EN_VRAM
		ret

PINTA_PROYECTIL_BOSS_5:

		ld		a,(PROYECTIL_BOSS_5_PASO_TABLA)				; contador global de animacion barro
		inc		a
		and		00000011b						; 0,1,2,3 = barro 1,2,3,4
		ld		(PROYECTIL_BOSS_5_PASO_TABLA),a

		ld		b,PROYECTILES_BOSS_5_CANTIDAD
		xor		a
		ld		(PROYECTIL_BOSS_5_INDICE_ACTUAL),a

.BUCLE_PINTA_PROYECTIL_BOSS_5:

		push	bc
		call	PINTA_UN_PROYECTIL_BOSS_5
		ld		a,(PROYECTIL_BOSS_5_INDICE_ACTUAL)
		inc		a
		ld		(PROYECTIL_BOSS_5_INDICE_ACTUAL),a
		pop		bc
		djnz	.BUCLE_PINTA_PROYECTIL_BOSS_5
		ret

PINTA_UN_PROYECTIL_BOSS_5:

		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		or		a
		ret		z
		jp		CARGA_ATRIBUTOS_PROYECTIL_BOSS_5

PINTA_PROYECTIL_BOSS_5_1:

		ld		(hl),a
		call	OBTIENE_DIRECCION_ATRIBUTOS_PROYECTIL_BOSS_5
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		bc,3
		call	PON_COLOR_2.sin_bc_impuesta
		ret

CARGA_ATRIBUTOS_PROYECTIL_BOSS_5:

		ld		hl,PROPIEDADES_PATRON_SPRITE
		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		(hl),a
		inc		hl
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		ld		hl,PROPIEDADES_PATRON_SPRITE+1
		ld		(hl),a
		inc		hl
		ld		a,(PROYECTIL_BOSS_5_PASO_TABLA)
		and		00000011b
		add		a,a
		add		a,a
		add		a,BARRO_PATRON_INICIAL_BOSS_5
		jr		PINTA_PROYECTIL_BOSS_5_1

CARGA_COLOR_PROYECTIL_BOSS_5_ACTUAL:

		; El color del barro ya queda precargado al entrar en el boss
		; para todos los slots de proyectil 22-29.
		; No lo copiamos aqui porque durante la pelea COLOR_BARRO
		; no tiene por que estar paginado en RAM. Si lo leemos aqui,
		; podemos sobreescribir el color bueno con basura o ceros.
		ret

OCULTA_SPRITE_PROYECTIL_BOSS_5_EN_VRAM:

		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		a,PROYECTIL_BOSS_5_Y_OCULTO
		ld		(hl),a
		inc		hl
		xor		a
		ld		(hl),a
		inc		hl
		ld		(hl),a
		call	OBTIENE_DIRECCION_ATRIBUTOS_PROYECTIL_BOSS_5
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		bc,3
		call	PON_COLOR_2.sin_bc_impuesta
		ret

OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL:

		ld		a,(PROYECTIL_BOSS_5_INDICE_ACTUAL)
		ld		e,a
		ld		d,0
		ret

OBTIENE_PUNTERO_X_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL
		ld		hl,PROYECTILES_BOSS_5_X
		add		hl,de
		ret

OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL
		ld		hl,PROYECTILES_BOSS_5_Y
		add		hl,de
		ret

OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL
		ld		hl,PROYECTILES_BOSS_5_DIRECCION
		add		hl,de
		ret

OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL
		ld		hl,PROYECTILES_BOSS_5_PASO_TABLA
		add		hl,de
		ret

GUARDA_POSICION_PROYECTIL_BOSS_5_ACTUAL:

		push	bc
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_5_ACTUAL
		pop		bc
		ld		(hl),b
		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_5_ACTUAL
		ld		(hl),c
		ret

INC_X_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_5_ACTUAL
		inc		(hl)
		ret

DEC_X_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_5_ACTUAL
		dec		(hl)
		ret

INC_Y_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_5_ACTUAL
		inc		(hl)
		ret

SUB_2_Y_PROYECTIL_BOSS_5_ACTUAL:

		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		sub		2
		ld		(hl),a
		ret

OBTIENE_PUNTERO_SPRITES_ACTIVOS_PROYECTIL_BOSS_5:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_5_SPRITES_ACTIVOS_OFS
		add		hl,de
		ret

OBTIENE_DIRECCION_ATRIBUTOS_PROYECTIL_BOSS_5:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL
		ld		a,e
		add		a,a
		ld		e,a
		ld		d,0
		ld		hl,TABLA_DIRECCIONES_VRAM_ATRIBUTOS_PROYECTIL_BOSS_5
		add		hl,de
		ld		e,(hl)
		inc		hl
		ld		d,(hl)
		ret

OBTIENE_DIRECCION_COLOR_PROYECTIL_BOSS_5:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_5_ACTUAL
		ld		a,e
		add		a,a
		ld		e,a
		ld		d,0
		ld		hl,TABLA_DIRECCIONES_VRAM_COLOR_PROYECTIL_BOSS_5
		add		hl,de
		ld		e,(hl)
		inc		hl
		ld		d,(hl)
		ret

RESERVA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_5:

		ld		a,(PROYECTIL_BOSS_5_SIGUIENTE_SPRITE)
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.BUSCA_SPRITE_LIBRE_PROYECTIL_BOSS_5:

		ld		c,a
		sub		PROYECTIL_BOSS_5_SPRITE_INICIAL
		ld		e,a
		ld		d,0
		ld		hl,PROYECTILES_BOSS_5_DIRECCION
		add		hl,de
		ld		a,(hl)
		or		a
		jr		z,.RESERVA_SPRITE_LIBRE_PROYECTIL_BOSS_5
		ld		a,c
		inc		a
		cp		PROYECTIL_BOSS_5_SPRITE_FINAL
		jr		c,.SIGUE_BUSQUEDA_SPRITE_LIBRE_PROYECTIL_BOSS_5
		ld		a,PROYECTIL_BOSS_5_SPRITE_INICIAL

.SIGUE_BUSQUEDA_SPRITE_LIBRE_PROYECTIL_BOSS_5:

		djnz	.BUSCA_SPRITE_LIBRE_PROYECTIL_BOSS_5
		xor		a
		ret

.RESERVA_SPRITE_LIBRE_PROYECTIL_BOSS_5:

		ld		a,e
		ld		(PROYECTIL_BOSS_5_INDICE_ACTUAL),a
		ld		a,c
		ld		(PROYECTIL_BOSS_5_SPRITE_ACTUAL),a
		call	OBTIENE_PUNTERO_SPRITES_ACTIVOS_PROYECTIL_BOSS_5
		ld		a,1
		ld		(hl),a
		ld		a,c
		inc		a
		cp		PROYECTIL_BOSS_5_SPRITE_FINAL
		jr		c,.GUARDA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_5
		ld		a,PROYECTIL_BOSS_5_SPRITE_INICIAL

.GUARDA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_5:

		ld		(PROYECTIL_BOSS_5_SIGUIENTE_SPRITE),a
		ld		a,1
		or		a
		ret
CALCULA_DIRECCION_BASE_PROYECTIL_BOSS_5:
		push	bc									; conserva B=x emisor y C=y emisor
		ld      a,11
		ld		c,0
		call 	PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
		call	PAGE_10_A_SEGMENT_2
		pop		bc

		ld		a,(X_DEPH)
		ld		e,a
		ld		a,b
		add		8
		ld		d,a
		ld		a,e
		sub		d
		jr		nc,.DEPH_A_LA_DERECHA
		ld		a,d
		sub		e
		ld		h,7
		jr		.COMPARA_DISTANCIAS

.DEPH_A_LA_DERECHA:

		ld		h,2

.COMPARA_DISTANCIAS:

		cp		8
		jr		c,.CENTRO
		ld		l,a
		ld		a,(Y_DEPH)
		cp		c
		jr		c,.ANGULO_EXTREMO
		sub		c
		ld		e,a
		ld		a,l
		add		a,a
		jr		c,.ANGULO_EXTREMO
		add		a,a
		jr		c,.ANGULO_EXTREMO
		cp		e
		jr		c,.ANGULO_CERRADO
		jr		z,.ANGULO_CERRADO
		ld		a,l
		add		a,a
		jr		c,.ANGULO_ABIERTO
		cp		e
		jr		c,.ANGULO_DIAGONAL
		jr		z,.ANGULO_DIAGONAL
		ld		a,l
		cp		e
		jr		c,.ANGULO_MEDIO
		jr		z,.ANGULO_MEDIO
		ld		a,e
		add		a,a
		jr		c,.ANGULO_ABIERTO
		cp		l
		jr		c,.ANGULO_EXTREMO
		jr		z,.ANGULO_ABIERTO

.ANGULO_ABIERTO:

		ld		a,h
		inc		a
		inc		a
		inc		a
		ret

.ANGULO_DIAGONAL:

		ld		a,h
		inc		a
		inc		a
		ret

.ANGULO_MEDIO:

		ld		a,h
		inc		a
		ret

.ANGULO_CERRADO:

		ld		a,h
		ret

.ANGULO_EXTREMO:

		ld		a,h
		inc		a
		inc		a
		inc		a
		inc		a
		ret

.CENTRO:

		ld		a,1
		ret

LEE_DIRECCION_TABLA_PROYECTIL_BOSS_5:

		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		or		a
		ret		z
		cp		12
		jr		nc,.DIRECCION_INVALIDA
		dec		a
		ld		b,a
		add		a,a
		add		a,b
		ld		e,a
		ld		d,0
		ld		hl,TABLA_DIRECCIONES_PROYECTIL_BOSS_5
		add		hl,de
		push	hl
		call	OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_5_ACTUAL
		ld		a,(hl)
		ld		c,a
		inc		a
		ld		(hl),a
		cp		3
		jr		c,.NO_REINICIA_PASO_TABLA
		xor		a
		ld		(hl),a

.NO_REINICIA_PASO_TABLA:

		pop		hl
		ld		b,0
		add		hl,bc
		ld		a,(hl)
		ret

.DIRECCION_INVALIDA:

		xor		a
		ret


CONTROL_LODO_Y_MOVIMIENTO_DEPH_BOSS_5:

		jp		MOVIMIENTO_DEPH_EN_BOSS_5

MOVIMIENTO_DEPH_EN_BOSS_5:

		ld		a,PAGINA_REGRESO_BOSS_5
		ld		(PAGINA_DE_REGRESO),a
		include	"COMUN/MOVIMIENTO EN BOSSES.asm"

MUEVE_IDIUS_BOSS_5:

		push	af
		push	bc
		push	de
		push	hl
		push	ix
		push	iy

		ld		a,(IDIUS_BOSS_5_ESPERA_MOVIMIENTO)
		dec		a
		ld		(IDIUS_BOSS_5_ESPERA_MOVIMIENTO),a
		jp		nz,.FIN_MOVIMIENTO_IDIUS

		ld		a,IDIUS_MOVIMIENTO_ESPERA_BOSS_5
		ld		(IDIUS_BOSS_5_ESPERA_MOVIMIENTO),a

		ld		a,(IDIUS_BOSS_5_TIEMPO_MODO)
		or		a
		jr		z,.SIGUE_SECUENCIA_IDIUS
		dec		a
		ld		(IDIUS_BOSS_5_TIEMPO_MODO),a
		jr		nz,.FIN_MOVIMIENTO_IDIUS
		call	COLOCA_IDIUS_EN_POSICION_RANDOM_BOSS_5

.SIGUE_SECUENCIA_IDIUS:

		ld		a,(IDIUS_BOSS_5_MODO)
		ld		c,a
		ld		b,0
		ld		hl,TABLA_SECUENCIA_IDIUS_BOSS_5
		add		hl,bc
		ld		a,(hl)
		or		a
		jr		nz,.PINTA_FOTOGRAMA_SECUENCIA_IDIUS
		call	RESTAURA_FONDO_IDIUS_BOSS_5
		jr		.AVANZA_SECUENCIA_IDIUS

.PINTA_FOTOGRAMA_SECUENCIA_IDIUS:

		ld		a,(hl)
		ld		(IDIUS_BOSS_5_FOTOGRAMA),a
		call	PINTA_IDIUS_BOSS_5

.AVANZA_SECUENCIA_IDIUS:

		ld		a,(IDIUS_BOSS_5_MODO)
		inc		a
		cp		TABLA_SECUENCIA_IDIUS_BOSS_5_FIN-TABLA_SECUENCIA_IDIUS_BOSS_5
		jr		c,.GUARDA_PASO_SECUENCIA_IDIUS
		call	RESTAURA_FONDO_IDIUS_BOSS_5
		xor		a
		ld		(IDIUS_BOSS_5_MODO),a
		ld		a,IDIUS_MOVIMIENTO_PAUSA_OCULTO_BOSS_5
		ld		(IDIUS_BOSS_5_TIEMPO_MODO),a
		jr		.FIN_MOVIMIENTO_IDIUS

.GUARDA_PASO_SECUENCIA_IDIUS:

		ld		(IDIUS_BOSS_5_MODO),a

.FIN_MOVIMIENTO_IDIUS:

		pop		iy
		pop		ix
		pop		hl
		pop		de
		pop		bc
		pop		af
		ret

COLOCA_IDIUS_EN_POSICION_RANDOM_BOSS_5:

		ld		a,r
		and		00001111b

.AJUSTA_RANDOM_POSICION_IDIUS_BOSS_5:

		cp		9
		jr		c,.RANDOM_POSICION_IDIUS_OK_BOSS_5
		sub		9
		jr		.AJUSTA_RANDOM_POSICION_IDIUS_BOSS_5

.RANDOM_POSICION_IDIUS_OK_BOSS_5:

		ld		c,a
		ld		b,0
		ld		hl,TABLA_POSICIONES_IDIUS_X_BOSS_5
		add		hl,bc
		ld		a,(hl)
		ld		(IDIUS_BOSS_5_X),a
		ld		hl,TABLA_POSICIONES_IDIUS_Y_BOSS_5
		add		hl,bc
		ld		a,(hl)
		ld		(IDIUS_BOSS_5_Y),a
		xor		a
		ld		(IDIUS_BOSS_5_MODO),a
		jp		GUARDA_FONDO_IDIUS_BOSS_5

PINTA_IDIUS_BOSS_5:

		ld		a,(IDIUS_BOSS_5_FOTOGRAMA)
		or		a
		ret		z
		dec		a
		ld		c,a
		ld		b,0
		ld		hl,BOSS_5_IDIUS_SX
		add		hl,bc
		ld		a,(hl)
		ld		(VARIABLE_UN_USO),a
		ld		hl,BOSS_5_IDIUS_SY
		add		hl,bc
		ld		a,(hl)
		ld		(VARIABLE_UN_USO+1),a

		ld		ix,BOSS_5_COPY_MOVIMIENTO_IDIUS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	RUTINA_BOSS_5.BUCLE_PINTA_DATAS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		ld		a,(VARIABLE_UN_USO)
		ld		(iy),a
		ld		a,(VARIABLE_UN_USO+1)
		ld		(iy+2),a
		ld		a,(IDIUS_BOSS_5_X)
		ld		(iy+4),a
		xor		a
		ld		(iy+5),a
		ld		a,(IDIUS_BOSS_5_Y)
		ld		(iy+6),a
		ld		a,PAGE_2_VRAM_Y_BOSS_5/256
		ld		(iy+7),a
		call	CALCULA_ANCHO_VISIBLE_IDIUS_BOSS_5
		ld		(iy+8),a
		xor		a
		ld		(iy+9),a
		jp		COPY_IDIUS_ACTUAL_BOSS_5

COPY_IDIUS_ACTUAL_BOSS_5:

		xor		a
		ld		(iy+1),a
		ld		(iy+9),a
		ld		(iy+11),a
		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		jp		VDPREADY

GUARDA_FONDO_IDIUS_BOSS_5:

		ld		ix,BOSS_5_COPY_GUARDA_FONDO_IDIUS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	RUTINA_BOSS_5.BUCLE_PINTA_DATAS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		ld		a,(IDIUS_BOSS_5_X)
		ld		(iy),a
		xor		a
		ld		(iy+1),a
		ld		(iy+4),a
		ld		(iy+5),a
		ld		a,(IDIUS_BOSS_5_Y)
		ld		(iy+2),a
		xor		a
		ld		(iy+6),a
		jr		COPY_FONDO_IDIUS_BOSS_5

RESTAURA_FONDO_IDIUS_BOSS_5:

		ld		ix,BOSS_5_COPY_RESTAURA_FONDO_IDIUS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	RUTINA_BOSS_5.BUCLE_PINTA_DATAS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		xor		a
		ld		(iy),a
		ld		(iy+1),a
		ld		(iy+2),a
		ld		a,(IDIUS_BOSS_5_X)
		ld		(iy+4),a
		xor		a
		ld		(iy+5),a
		ld		a,(IDIUS_BOSS_5_Y)
		ld		(iy+6),a

COPY_FONDO_IDIUS_BOSS_5:

		call	CALCULA_ANCHO_VISIBLE_IDIUS_BOSS_5
		ld		(iy+8),a
		xor		a
		ld		(iy+9),a
		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		jp		VDPREADY

CALCULA_RECORTE_IDIUS_BOSS_5:

		xor		a
		ld		(VARIABLE_UN_USO),a
		ld		a,IDIUS_MOVIMIENTO_ANCHO_BOSS_5
		ld		(VARIABLE_UN_USO2),a
		ld		a,(IDIUS_BOSS_5_X)
		ld		(VARIABLE_UN_USO3),a
		ret

CALCULA_ANCHO_VISIBLE_IDIUS_BOSS_5:

		ld		a,(IDIUS_BOSS_5_X)
		ld		b,a
		add		IDIUS_MOVIMIENTO_ANCHO_BOSS_5
		ld		a,IDIUS_MOVIMIENTO_ANCHO_BOSS_5
		ret		nc
		xor		a
		sub		b
		ret

BORRA_RASTRO_IDIUS_BOSS_5:

		push	af
		push	bc
		push	hl
		push	ix
		push	iy

		ld		ix,BOSS_5_BORRA_MOVIMIENTO_IDIUS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	RUTINA_BOSS_5.BUCLE_PINTA_DATAS
		ld		iy,DATAS_COPY_RECUP_SCROLL

		call	CALCULA_RECORTE_IDIUS_BOSS_5
		ld		a,(VARIABLE_UN_USO3)
		ld		c,a
		ld		a,(VARIABLE_UN_USO2)
		add		c
		jp		c,.FIN_BORRA_RASTRO_IDIUS
		jp		z,.FIN_BORRA_RASTRO_IDIUS

.GUARDA_X_BORRA_RASTRO_IDIUS:

		ld		(iy+4),a
		xor		a
		ld		(iy+5),a
		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		call	VDPREADY

.FIN_BORRA_RASTRO_IDIUS:

		pop		iy
		pop		ix
		pop		hl
		pop		bc
		pop		af
		ret

BORRA_RASTRO_IZQUIERDA_IDIUS_BOSS_5:

		push	af
		push	hl
		push	ix
		push	iy

		ld		ix,BOSS_5_BORRA_MOVIMIENTO_IDIUS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	RUTINA_BOSS_5.BUCLE_PINTA_DATAS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		xor		a
		ld		(iy+4),a
		ld		(iy+5),a
		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		call	VDPREADY

		pop		iy
		pop		ix
		pop		hl
		pop		af
		ret

SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_5:

		include	"COMUN/SECUENCIA PROYECTILES PROPIOS EN BOSSES.asm"

PINTA_PROYECTILES_DE_DEPH_EN_BOSS_5:

		include	"COMUN/PINTADO PROYECTILES PROPIOS EN BOSSES.asm"

ON_SPRITE_GLOBAL_BOSS_5:

	ret
	call	BUCLE_REVISION_TODOS_LOS_PROYECTILES_OJO_BOSS_5
	ret

PINTA_MARCADORES_VIDA_FINAL_BOSS_5:

		ld		a,(VIDA_IDIUS_BOSS_5)
		call	CONVIERTE_VIDA_FINAL_A_BARRA_BOSS_5

        ; Si es el ancho total, lo dejamos tal cual
        ; para que al morir borre la barra completa.
        cp      VIDA_ANCHO_BARRA_BOSS_5
        jr      z,.ANCHO_BARRA_BOSS_5_OK

        ; Redondeamos hacia abajo a múltiplos de 6
        ; 1-5   -> 0
        ; 6-11  -> 6
        ; 12-17 -> 12
        ; 18-23 -> 18
        ; etc.
        ld      b,0

.REDONDEA_BARRA_A_6_BOSS_5:

        cp      6
        jr      c,.FIN_REDONDEA_BARRA_A_6_BOSS_5

        sub     6
        ld      c,a
        ld      a,b
        add     a,6
        ld      b,a
        ld      a,c

        jr      .REDONDEA_BARRA_A_6_BOSS_5

.FIN_REDONDEA_BARRA_A_6_BOSS_5:

        ld      a,b

.ANCHO_BARRA_BOSS_5_OK:

        or      a
        ret     z
        ld      b,a
        ld      a,VIDA_ANCHO_BARRA_BOSS_5
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

CONVIERTE_VIDA_FINAL_A_BARRA_BOSS_5:

		ld		c,a
		ld		a,VIDA_TOTAL_INICIAL_BOSS_5
		sub		c
        ld      b,a
        xor     a
        ld      d,a
        ld      l,a

.BUCLE_ESCALA_VIDA_FINAL_BOSS_5:

        ld      a,b
        or      a
        jr      z,.FIN_ESCALA_VIDA_FINAL_BOSS_5

        dec     b

        ld      a,l
        add     a,VIDA_ANCHO_BARRA_BOSS_5

.AJUSTA_ESCALA_VIDA_FINAL_BOSS_5:

        cp      VIDA_TOTAL_INICIAL_BOSS_5
        jr      c,.GUARDA_RESTO_ESCALA_VIDA_FINAL_BOSS_5

        sub     VIDA_TOTAL_INICIAL_BOSS_5
        inc     d
        jr      .AJUSTA_ESCALA_VIDA_FINAL_BOSS_5

.GUARDA_RESTO_ESCALA_VIDA_FINAL_BOSS_5:

        ld      l,a
        jr      .BUCLE_ESCALA_VIDA_FINAL_BOSS_5

.FIN_ESCALA_VIDA_FINAL_BOSS_5:

        ld      a,d
        ld      h,a
        ld      a,l
        or      a
        ld      a,h
        ret     z
        inc     a
        ret

BUCLE_REVISION_TODOS_LOS_PROYECTILES_OJO_BOSS_5:

		ret
		ld		hl,PROYECTILES_BOSS_5_DIRECCION
		ld		ix,PROYECTILES_BOSS_5_X
		ld		iy,PROYECTILES_BOSS_5_Y
		ld		b,PROYECTILES_BOSS_5_CANTIDAD

.BUCLE_REVISION_PROYECTILES_OJO_BOSS_5:

        ld      a,(hl)
        or      a
        jr      z,.SIGUIENTE_PROYECTIL_OJO_BOSS_5

        ; --- Comprobar X ---
        ld      a,(X_DEPH)
        add     a,20
        sub     (ix+0)          ; A = X_DEPH + 20 - X_PROYECTIL
        cp      36              ; 20 + 16
        jr      nc,.SIGUIENTE_PROYECTIL_OJO_BOSS_5

        ; --- Comprobar Y ---
        ld      a,(Y_DEPH)
        add     a,20
        sub     (iy+0)          ; A = Y_DEPH + 20 - Y_PROYECTIL
        cp      36              ; 20 + 16
        jr      nc,.SIGUIENTE_PROYECTIL_OJO_BOSS_5

        ; Si llega aquí, hay colisión

		call	DESACTIVA_PROYECTIL_OJO_BOSS_5_ACTUAL
		call	DANO_DEPH_EN_BOSS_5
		ret

.SIGUIENTE_PROYECTIL_OJO_BOSS_5:

		inc		hl
		inc		ix
		inc		iy
		djnz	.BUCLE_REVISION_PROYECTILES_OJO_BOSS_5
		ret

DESACTIVA_PROYECTIL_OJO_BOSS_5_ACTUAL:

		push	hl
		or		a
		ld		de,PROYECTILES_BOSS_5_DIRECCION
		sbc		hl,de
		ld		a,l
		ld		(PROYECTIL_BOSS_5_INDICE_ACTUAL),a
		pop		hl
		jp		DESACTIVA_PROYECTIL_BOSS_5

REVISAMOS_COLISION_CON_IDIUS_Y_DEPH:

		ret
		call	CALCULA_RECORTE_IDIUS_BOSS_5
		ld		a,(VARIABLE_UN_USO2)
		or		a
		ret		z
		ld		a,(VARIABLE_UN_USO3)
		ld		c,a
		ld		a,(X_DEPH)
		add		20
		cp		c
		ret		c

		ld		a,(VARIABLE_UN_USO3)
		ld		c,a
		ld		a,(VARIABLE_UN_USO2)
		add		c
		ld		c,a
		ld		a,(X_DEPH)
		cp		c
		ret		nc

		ld		a,(Y_DEPH)
		add		20
		cp		IDIUS_MOVIMIENTO_Y_BOSS_5
		ret		c
		ld		a,(Y_DEPH)
		cp		IDIUS_MOVIMIENTO_Y_BOSS_5+IDIUS_MOVIMIENTO_ALTO_BOSS_5
		ret		nc

		call	DANO_DEPH_EN_BOSS_5
	ret

DANO_DEPH_EN_BOSS_5:

	call	DANO_DEPH_EN_BOSS_COMUN
	call	RUTINA_BOSS_5.PINTA_CORAZONES_VIDA_DEPH_ADECUADOS
	ret

MUERTE_DEPH_EN_BOSS_5:

	call	PREPARA_VRAM_PARA_MUERTE_DEPH_EN_BOSS
	jp		MUERTE_POR_TOQUES_DESDE_BOSS

REVISAMOS_COLISION_CON_IDIUS_Y_PROYECTILES_DEPH:

		ret
		ld		iy,PROYECTILES
		ld		b,6

.BUCLE_PROYECTILES_DEPH_IDIUS_BOSS_5:

		push	bc
		ld		a,(iy+2)
		cp		#FF
		jp		z,.SIGUIENTE_PROYECTIL_DEPH_IDIUS_BOSS_5

		call	CALCULA_RECORTE_IDIUS_BOSS_5
		ld		a,(VARIABLE_UN_USO2)
		or		a
		jp		z,.SIGUIENTE_PROYECTIL_DEPH_IDIUS_BOSS_5
		ld		d,a
		ld		a,(VARIABLE_UN_USO3)
		ld		c,a

.REVISA_X_IMPACTO_IDIUS_BOSS_5:

		ld		a,(iy)
		cp		c
		jp		c,.SIGUIENTE_PROYECTIL_DEPH_IDIUS_BOSS_5
		sub		c
		cp		d
		jp		nc,.SIGUIENTE_PROYECTIL_DEPH_IDIUS_BOSS_5

		ld		a,IDIUS_MOVIMIENTO_Y_BOSS_5
		ld		c,a
		ld		a,(iy+1)
		cp		c
		jp		c,.SIGUIENTE_PROYECTIL_DEPH_IDIUS_BOSS_5
		sub		c
		cp		IDIUS_MOVIMIENTO_ALTO_BOSS_5
		jp		nc,.SIGUIENTE_PROYECTIL_DEPH_IDIUS_BOSS_5

		ld		a,(VIDA_IDIUS_BOSS_5)
		or		a
		jr		z,.SOBRE_PROYECTIL_DEPH_IDIUS_BOSS_5
		call	CALCULA_DANO_PROYECTIL_IDIUS_BOSS_5
		ld		c,a
		ld		a,(VIDA_IDIUS_BOSS_5)
		cp		c
		jr		nc,.RESTA_DANO_IDIUS_BOSS_5
		xor		a
		jr		.GUARDA_VIDA_IDIUS_TRAS_IMPACTO_BOSS_5

.RESTA_DANO_IDIUS_BOSS_5:

		sub		c

.GUARDA_VIDA_IDIUS_TRAS_IMPACTO_BOSS_5:

		ld		(VIDA_IDIUS_BOSS_5),a
		push	af
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_5
		pop		af
		or		a
		jr		z,.MUERE_IDIUS_POR_PROYECTIL_BOSS_5

.SOBRE_PROYECTIL_DEPH_IDIUS_BOSS_5:

		call	.LIMPIA_PROYECTIL_TRAS_IMPACTO_IDIUS_BOSS_5
		pop		bc
		ret

.MUERE_IDIUS_POR_PROYECTIL_BOSS_5:

		call	.LIMPIA_PROYECTIL_TRAS_IMPACTO_IDIUS_BOSS_5
		pop		bc
		jp		MUERTE_DE_IDIUS_BOSS_5

.LIMPIA_PROYECTIL_TRAS_IMPACTO_IDIUS_BOSS_5:

		ld		a,5
		ld		c,0
		call	TIRA_FX_BOSS_5

		ld		ix,VALORES_EXPLOSION_CON_ROCK
		ld		a,(iy)
		ld		(ix+1),a
		ld		a,(iy+1)
		sub		8
		ld		(ix),a
		ld		a,IDIUS_EXPLOSION_PATRON_INICIAL_BOSS_5
		ld		(ix+2),a

		ld		a,(iy+12)
		ld		e,a
		ld		d,0
		ld		hl,#4A00
		add		hl,de
		ex		de,hl
		ld		hl,.SPRITE_OCULTO_TRAS_IMPACTO_IDIUS_BOSS_5
		ld		bc,3
		call	PON_COLOR_2.sin_bc_impuesta

		xor		a
		ld		(iy+8),a
		dec		a
		ld		(iy+2),a
		ld		(iy),a
		ld		a,(iy+12)
		call	SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_5.DEJA_LIBRE_SPRITE_EN_RAM
		ret

.SPRITE_OCULTO_TRAS_IMPACTO_IDIUS_BOSS_5:

		db		217,255,0

.SIGUIENTE_PROYECTIL_DEPH_IDIUS_BOSS_5:

		ld		de,16
		add		iy,de
		pop		bc
		dec		b
		jp		nz,.BUCLE_PROYECTILES_DEPH_IDIUS_BOSS_5
		ret

CALCULA_DANO_PROYECTIL_IDIUS_BOSS_5:

		ld		a,(iy+4)
		cp		2
		jr		z,.DANO_HACHA_IDIUS_BOSS_5
		cp		1
		jr		z,.DANO_FUEGO_IDIUS_BOSS_5

.DANO_FLECHA_IDIUS_BOSS_5:

		ld		a,1
		ret

.DANO_HACHA_IDIUS_BOSS_5:

		ld		a,1
		ret

.DANO_FUEGO_IDIUS_BOSS_5:

		ld		a,8
		ret

PINTA_EXPLOSION_IDIUS_BOSS_5:

		ld		ix,VALORES_EXPLOSION_CON_ROCK
		ld		a,(ix+2)
		or		a
		ret		z
		cp		IDIUS_EXPLOSION_PATRON_FINAL_BOSS_5
		jr		nz,.PINTAMOS_EXPLOSION_IDIUS_BOSS_5

		xor		a
		ld		(ix+2),a

.PINTAMOS_EXPLOSION_IDIUS_BOSS_5:

		ld		de,#4A00+17*4
		ld		hl,VALORES_EXPLOSION_CON_ROCK
		ld		bc,3
		call	PON_COLOR_2.sin_bc_impuesta

		ld		de,#4800+17*16
		ld		hl,BOSS_5_COLOR_EXPLOSION_IDIUS
		ld		bc,16
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,(ix+2)
		or		a
		ret		z
		add		4
		ld		(ix+2),a
		ret

INICIALIZA_BUBBLES_MUERTE_IDIUS_BOSS_5:

		call	PAGE_32_A_SEGMENT_2
		ld		de,BARROS_MUERTE_COLOR_VRAM_BOSS_5
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5

.BUCLE_COLOR_BUBBLES_MUERTE_IDIUS_BOSS_5:

		push	bc
		push	de
		ld		hl,COLOR_BUBBLES
		ld		bc,16
		call	PON_COLOR_2.sin_bc_impuesta
		pop		de
		ld		a,e
		add		16
		ld		e,a
		jr		nc,.SIN_ACARREO_COLOR_BUBBLES_MUERTE_IDIUS_BOSS_5
		inc		d

.SIN_ACARREO_COLOR_BUBBLES_MUERTE_IDIUS_BOSS_5:

		pop		bc
		djnz	.BUCLE_COLOR_BUBBLES_MUERTE_IDIUS_BOSS_5
		call	PAGE_10_A_SEGMENT_2

		ld		a,IDIUS_MOVIMIENTO_Y_BOSS_5+IDIUS_MUERTE_ALTO_BOSS_5
		ld		(VARIABLE_UN_USO3),a
		ld		ix,BARROS_MUERTE_IDIUS_X
		ld		iy,BARROS_MUERTE_IDIUS_ESPERA
		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5

.BUCLE_INICIALIZA_BUBBLES_MUERTE_IDIUS_BOSS_5:

		call	RENACE_BUBBLE_MUERTE_IDIUS_BOSS_5
		inc		ix
		inc		iy
		inc		hl
		djnz	.BUCLE_INICIALIZA_BUBBLES_MUERTE_IDIUS_BOSS_5
		xor		a
		ld		(BARROS_MUERTE_IDIUS_CONTADOR),a
		ret

RENACE_BUBBLE_MUERTE_IDIUS_BOSS_5:

		push	bc
		push	de

		ld		a,r
		and		01111111b
		cp		IDIUS_MOVIMIENTO_ANCHO_BOSS_5
		jr		c,.X_RANDOM_BUBBLE_MUERTE_OK_BOSS_5
		sub		32

.X_RANDOM_BUBBLE_MUERTE_OK_BOSS_5:

		ld		b,a
		ld		a,(IDIUS_BOSS_5_X)
		add		b
		ld		(ix),a

		ld		a,(VARIABLE_UN_USO3)
		ld		(iy),a

		ld		a,r
		and		00000111b
		cp		BUBBLES_MUERTE_VELOCIDAD_MAX_BOSS_5
		jr		c,.VELOCIDAD_RANDOM_BUBBLE_MUERTE_OK_BOSS_5
		sub		BUBBLES_MUERTE_VELOCIDAD_MAX_BOSS_5

.VELOCIDAD_RANDOM_BUBBLE_MUERTE_OK_BOSS_5:

		inc		a
		ld		(hl),a

		pop		de
		pop		bc
		ret

MUEVE_BUBBLES_MUERTE_IDIUS_BOSS_5:

		ld		a,32
		ld		c,0
		call	TIRA_FX_BOSS_5
		xor		a
		ld		(VARIABLE_UN_USO),a
		ld		ix,BARROS_MUERTE_IDIUS_X
		ld		iy,BARROS_MUERTE_IDIUS_ESPERA
		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		ld		de,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5

.BUCLE_MUEVE_BUBBLES_MUERTE_IDIUS_BOSS_5:

		ld		a,(hl)
		or		a
		jr		z,.PINTA_BUBBLE_OCULTA_MUERTE_IDIUS_BOSS_5

		ld		c,a
		ld		a,(iy)
		sub		c
		cp		BUBBLES_MUERTE_Y_OBJETIVO_BOSS_5+1
		jr		c,.MATA_O_RENACE_BUBBLE_MUERTE_IDIUS_BOSS_5
		ld		(iy),a
		jr		.PINTA_BUBBLE_ACTIVA_MUERTE_IDIUS_BOSS_5

.MATA_O_RENACE_BUBBLE_MUERTE_IDIUS_BOSS_5:

		ld		a,(VARIABLE_UN_USO2)
		or		a
		jr		z,.MATA_BUBBLE_MUERTE_IDIUS_BOSS_5
		call	RENACE_BUBBLE_MUERTE_IDIUS_BOSS_5
		jr		.PINTA_BUBBLE_ACTIVA_MUERTE_IDIUS_BOSS_5

.MATA_BUBBLE_MUERTE_IDIUS_BOSS_5:

		xor		a
		ld		(hl),a
		jr		.PINTA_BUBBLE_OCULTA_MUERTE_IDIUS_BOSS_5

.PINTA_BUBBLE_ACTIVA_MUERTE_IDIUS_BOSS_5:

		ld		a,(VARIABLE_UN_USO)
		inc		a
		ld		(VARIABLE_UN_USO),a
		ld		a,(iy)
		ld		(de),a
		inc		de
		ld		a,(ix)
		ld		(de),a
		inc		de
		ld		a,(BARROS_MUERTE_IDIUS_CONTADOR)
		and		00000001b
		ld		a,BUBBLES_MUERTE_PATRON_1_BOSS_5
		jr		z,.GUARDA_PATRON_BUBBLE_MUERTE_IDIUS_BOSS_5
		ld		a,BUBBLES_MUERTE_PATRON_2_BOSS_5
		jr		.GUARDA_PATRON_BUBBLE_MUERTE_IDIUS_BOSS_5

.PINTA_BUBBLE_OCULTA_MUERTE_IDIUS_BOSS_5:

		ld		a,BARROS_MUERTE_Y_OCULTA_BOSS_5
		ld		(de),a
		inc		de
		ld		a,BARROS_MUERTE_X_OCULTA_BOSS_5
		ld		(de),a
		inc		de
		xor		a

.GUARDA_PATRON_BUBBLE_MUERTE_IDIUS_BOSS_5:

		ld		(de),a
		inc		de
		xor		a
		ld		(de),a
		inc		de
		inc		ix
		inc		iy
		inc		hl
		djnz	.BUCLE_MUEVE_BUBBLES_MUERTE_IDIUS_BOSS_5

		ld		hl,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		de,BARROS_MUERTE_ATRIBUTOS_VRAM_BOSS_5
		ld		bc,BARROS_MUERTE_CANTIDAD_BOSS_5*4
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,(BARROS_MUERTE_IDIUS_CONTADOR)
		xor		00000001b
		ld		(BARROS_MUERTE_IDIUS_CONTADOR),a
		ld		a,(VARIABLE_UN_USO)
		ret

ESPERA_FIN_BUBBLES_MUERTE_IDIUS_BOSS_5:

		xor		a
		ld		(VARIABLE_UN_USO2),a

.BUCLE_ESPERA_FIN_BUBBLES_MUERTE_IDIUS_BOSS_5:

		call	MUEVE_BUBBLES_MUERTE_IDIUS_BOSS_5
		or		a
		ret		z
		ld		a,1
		call	BUCLE_PINTA_TILES.rutina_de_pausa
		jr		.BUCLE_ESPERA_FIN_BUBBLES_MUERTE_IDIUS_BOSS_5

INICIALIZA_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		ix,BARROS_MUERTE_IDIUS_X
		ld		iy,BOSS_5_BARROS_MUERTE_OFFSET_X
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5

.BUCLE_INICIALIZA_X_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		a,(IDIUS_BOSS_5_X)
		add		a,(iy)
		ld		(ix),a
		inc		ix
		inc		iy
		djnz	.BUCLE_INICIALIZA_X_BARROS_MUERTE_IDIUS_BOSS_5

		ld		ix,BARROS_MUERTE_IDIUS_ESPERA
		ld		hl,BOSS_5_BARROS_MUERTE_VELOCIDAD
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5

.BUCLE_INICIALIZA_ESPERA_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		a,(hl)
		ld		(ix),a
		inc		hl
		inc		ix
		djnz	.BUCLE_INICIALIZA_ESPERA_BARROS_MUERTE_IDIUS_BOSS_5

		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5
		ld		a,1

.BUCLE_INICIALIZA_ACTIVA_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		(hl),a
		inc		hl
		djnz	.BUCLE_INICIALIZA_ACTIVA_BARROS_MUERTE_IDIUS_BOSS_5

		call	PAGE_32_A_SEGMENT_2
		ld		de,BARROS_MUERTE_COLOR_VRAM_BOSS_5
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5

.BUCLE_COLOR_BARROS_MUERTE_IDIUS_BOSS_5:

		push	bc
		push	de
		ld		hl,COLOR_BARRO
		ld		bc,16
		call	PON_COLOR_2.sin_bc_impuesta
		pop		de
		ld		a,e
		add		16
		ld		e,a
		jr		nc,.SIN_ACARREO_COLOR_BARROS_MUERTE_IDIUS_BOSS_5
		inc		d

.SIN_ACARREO_COLOR_BARROS_MUERTE_IDIUS_BOSS_5:

		pop		bc
		djnz	.BUCLE_COLOR_BARROS_MUERTE_IDIUS_BOSS_5
		jp		PAGE_10_A_SEGMENT_2

ENTRAN_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		ix,BARROS_MUERTE_IDIUS_X
		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		ld		c,0

.BUCLE_PREPARA_ENTRADA_BARROS_MUERTE_IDIUS_BOSS_5:

		bit		0,c
		jr		nz,.BARRO_ENTRA_DESDE_DERECHA_BOSS_5

		xor		a
		jr		.GUARDA_X_ENTRADA_BARRO_MUERTE_IDIUS_BOSS_5

.BARRO_ENTRA_DESDE_DERECHA_BOSS_5:

		ld		a,255

.GUARDA_X_ENTRADA_BARRO_MUERTE_IDIUS_BOSS_5:

		ld		(ix),a
		ld		(hl),1
		inc		ix
		inc		hl
		inc		c
		ld		a,c
		cp		BARROS_MUERTE_CANTIDAD_BOSS_5
		jr		c,.BUCLE_PREPARA_ENTRADA_BARROS_MUERTE_IDIUS_BOSS_5

.BUCLE_ENTRAN_BARROS_MUERTE_IDIUS_BOSS_5:

		call	MUEVE_BARROS_ENTRADA_IDIUS_BOSS_5
		ld		a,BARROS_MUERTE_ENTRADA_PAUSA_BOSS_5
		call	BUCLE_PINTA_TILES.rutina_de_pausa
		ld		a,(BARROS_MUERTE_IDIUS_CONTADOR)
		or		a
		jr		nz,.BUCLE_ENTRAN_BARROS_MUERTE_IDIUS_BOSS_5
		call	ACTIVA_BARROS_MUERTE_IDIUS_BOSS_5
		ret

ACTIVA_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5
		ld		a,1

.BUCLE_ACTIVA_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		(hl),a
		inc		hl
		djnz	.BUCLE_ACTIVA_BARROS_MUERTE_IDIUS_BOSS_5
		ret

MUEVE_BARROS_ENTRADA_IDIUS_BOSS_5:

		xor		a
		ld		(BARROS_MUERTE_IDIUS_CONTADOR),a
		ld		de,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		c,a

.BUCLE_MUEVE_BARROS_ENTRADA_IDIUS_BOSS_5:

		push	de
		ld		b,0
		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		add		hl,bc
		ld		a,(hl)
		or		a
		jr		z,.PINTA_BARRO_ENTRADA_IDIUS_BOSS_5

		push	hl
		ld		hl,BOSS_5_BARROS_MUERTE_OFFSET_X
		add		hl,bc
		ld		a,(IDIUS_BOSS_5_X)
		add		a,(hl)
		ld		d,a
		ld		hl,BARROS_MUERTE_IDIUS_X
		add		hl,bc
		ld		a,(hl)
		bit		0,c
		jr		nz,.MUEVE_BARRO_ENTRADA_IZQUIERDA_IDIUS_BOSS_5

.MUEVE_BARRO_ENTRADA_DERECHA_IDIUS_BOSS_5:

		add		a,BARROS_MUERTE_PASO_X_BOSS_5
		cp		d
		jr		nc,.FIJA_BARRO_ENTRADA_IDIUS_BOSS_5
		ld		(hl),a
		pop		hl
		jr		.SIGUE_BARRO_ENTRANDO_IDIUS_BOSS_5

.MUEVE_BARRO_ENTRADA_IZQUIERDA_IDIUS_BOSS_5:

		ld		e,a
		ld		a,d
		add		a,BARROS_MUERTE_PASO_X_BOSS_5
		cp		e
		jr		nc,.FIJA_BARRO_ENTRADA_IDIUS_BOSS_5
		ld		a,e
		sub		BARROS_MUERTE_PASO_X_BOSS_5
		ld		(hl),a
		pop		hl

.SIGUE_BARRO_ENTRANDO_IDIUS_BOSS_5:

		ld		a,(BARROS_MUERTE_IDIUS_CONTADOR)
		inc		a
		ld		(BARROS_MUERTE_IDIUS_CONTADOR),a
		jr		.PINTA_BARRO_ENTRADA_IDIUS_BOSS_5

.FIJA_BARRO_ENTRADA_IDIUS_BOSS_5:

		ld		a,d
		ld		(hl),a
		pop		hl
		xor		a
		ld		(hl),a

.PINTA_BARRO_ENTRADA_IDIUS_BOSS_5:

		pop		de
		ld		a,BARROS_MUERTE_Y_BOSS_5
		ld		(de),a
		inc		de
		push	de
		ld		b,0
		ld		hl,BARROS_MUERTE_IDIUS_X
		add		hl,bc
		ld		a,(hl)
		pop		de
		ld		(de),a
		inc		de
		bit		0,c
		jr		nz,.PATRON_BARRO_ENTRADA_IZQUIERDA_IDIUS_BOSS_5

.PATRON_BARRO_ENTRADA_DERECHA_IDIUS_BOSS_5:

		ld		a,BARRO_PATRON_DERECHA_BOSS_5
		jr		.GUARDA_PATRON_BARRO_ENTRADA_IDIUS_BOSS_5

.PATRON_BARRO_ENTRADA_IZQUIERDA_IDIUS_BOSS_5:

		ld		a,BARRO_PATRON_IZQUIERDA_BOSS_5

.GUARDA_PATRON_BARRO_ENTRADA_IDIUS_BOSS_5:

		ld		(de),a
		inc		de
		xor		a
		ld		(de),a
		inc		de
		inc		c
		ld		a,c
		cp		BARROS_MUERTE_CANTIDAD_BOSS_5
		jp		c,.BUCLE_MUEVE_BARROS_ENTRADA_IDIUS_BOSS_5

		ld		hl,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		de,BARROS_MUERTE_ATRIBUTOS_VRAM_BOSS_5
		ld		bc,BARROS_MUERTE_CANTIDAD_BOSS_5*4
		jp		PON_COLOR_2.sin_bc_impuesta

MUEVE_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		ix,BARROS_MUERTE_IDIUS_X
		ld		iy,BARROS_MUERTE_IDIUS_ESPERA
		ld		hl,BOSS_5_BARROS_MUERTE_VELOCIDAD
		ld		de,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		b,BARROS_MUERTE_CANTIDAD_BOSS_5

.BUCLE_MUEVE_BARROS_MUERTE_IDIUS_BOSS_5:

		ld		a,(iy)
		dec		a
		ld		(iy),a
		jr		nz,.PINTA_BARRO_MUERTE_IDIUS_BOSS_5

		ld		a,(hl)
		ld		(iy),a
		ld		a,(ix)
		bit		0,b
		jr		nz,.MUEVE_BARRO_DERECHA_MUERTE_IDIUS_BOSS_5

.MUEVE_BARRO_IZQUIERDA_MUERTE_IDIUS_BOSS_5:

		sub		BARROS_MUERTE_PASO_X_BOSS_5
		ld		(ix),a
		ld		c,a
		ld		a,(IDIUS_BOSS_5_X)
		add		a,BARROS_MUERTE_X_MIN_OFFSET_BOSS_5
		cp		c
		jr		z,.PINTA_BARRO_MUERTE_IDIUS_BOSS_5
		jr		c,.PINTA_BARRO_MUERTE_IDIUS_BOSS_5

		ld		a,(IDIUS_BOSS_5_X)
		add		a,BARROS_MUERTE_X_MAX_OFFSET_BOSS_5
		ld		(ix),a
		jr		.PINTA_BARRO_MUERTE_IDIUS_BOSS_5

.MUEVE_BARRO_DERECHA_MUERTE_IDIUS_BOSS_5:

		add		a,BARROS_MUERTE_PASO_X_BOSS_5
		ld		(ix),a
		ld		c,a
		ld		a,(IDIUS_BOSS_5_X)
		add		a,BARROS_MUERTE_X_MAX_OFFSET_BOSS_5
		cp		c
		jr		nc,.PINTA_BARRO_MUERTE_IDIUS_BOSS_5

		ld		a,(IDIUS_BOSS_5_X)
		add		a,BARROS_MUERTE_X_MIN_OFFSET_BOSS_5
		ld		(ix),a

.PINTA_BARRO_MUERTE_IDIUS_BOSS_5:

		ld		a,BARROS_MUERTE_Y_BOSS_5
		ld		(de),a
		inc		de
		ld		a,(ix)
		ld		(de),a
		inc		de
		ld		a,b
		and		00000001b
		jr		nz,.PATRON_BARRO_DERECHA_MUERTE_IDIUS_BOSS_5

.PATRON_BARRO_IZQUIERDA_MUERTE_IDIUS_BOSS_5:

		ld		a,BARRO_PATRON_IZQUIERDA_BOSS_5
		jr		.GUARDA_PATRON_BARRO_MUERTE_IDIUS_BOSS_5

.PATRON_BARRO_DERECHA_MUERTE_IDIUS_BOSS_5:

		ld		a,BARRO_PATRON_DERECHA_BOSS_5

.GUARDA_PATRON_BARRO_MUERTE_IDIUS_BOSS_5:

		ld		(de),a
		inc		de
		xor		a
		ld		(de),a
		inc		de

		inc		ix
		inc		iy
		inc		hl
		djnz	.BUCLE_MUEVE_BARROS_MUERTE_IDIUS_BOSS_5

		ld		hl,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		de,BARROS_MUERTE_ATRIBUTOS_VRAM_BOSS_5
		ld		bc,BARROS_MUERTE_CANTIDAD_BOSS_5*4
		jp		PON_COLOR_2.sin_bc_impuesta

ESCAPA_BARROS_MUERTE_IDIUS_BOSS_5:

		call	MUEVE_BARROS_SALIDA_IDIUS_BOSS_5
		ld		a,BARROS_MUERTE_SALIDA_PAUSA_BOSS_5
		call	BUCLE_PINTA_TILES.rutina_de_pausa
		ld		a,(BARROS_MUERTE_IDIUS_CONTADOR)
		or		a
		jr		nz,ESCAPA_BARROS_MUERTE_IDIUS_BOSS_5
		ret

MUEVE_BARROS_SALIDA_IDIUS_BOSS_5:

		xor		a
		ld		(BARROS_MUERTE_IDIUS_CONTADOR),a
		ld		de,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		c,a

.BUCLE_MUEVE_BARROS_SALIDA_IDIUS_BOSS_5:

		push	de
		ld		b,0
		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		add		hl,bc
		ld		a,(hl)
		pop		de
		or		a
		jr		z,.PINTA_BARRO_OCULTA_SALIDA_IDIUS_BOSS_5

		ld		a,(BARROS_MUERTE_IDIUS_CONTADOR)
		inc		a
		ld		(BARROS_MUERTE_IDIUS_CONTADOR),a

		push	de
		ld		b,0
		ld		hl,BARROS_MUERTE_IDIUS_ESPERA
		add		hl,bc
		ld		a,(hl)
		dec		a
		ld		(hl),a
		pop		de
		jr		nz,.PINTA_BARRO_ACTIVA_SALIDA_IDIUS_BOSS_5

		push	de
		ld		b,0
		ld		hl,BOSS_5_BARROS_MUERTE_VELOCIDAD
		add		hl,bc
		ld		a,(hl)
		ld		hl,BARROS_MUERTE_IDIUS_ESPERA
		add		hl,bc
		ld		(hl),a
		ld		hl,BARROS_MUERTE_IDIUS_X
		add		hl,bc
		ld		a,(hl)
		bit		0,c
		jr		nz,.MUEVE_BARRO_DERECHA_SALIDA_IDIUS_BOSS_5

.MUEVE_BARRO_IZQUIERDA_SALIDA_IDIUS_BOSS_5:

		cp		BARROS_MUERTE_PASO_X_BOSS_5
		jr		c,.MATA_BARRO_SALIDA_IDIUS_BOSS_5
		sub		BARROS_MUERTE_PASO_X_BOSS_5
		ld		(hl),a
		or		a
		jr		z,.MATA_BARRO_SALIDA_IDIUS_BOSS_5
		pop		de
		jr		.PINTA_BARRO_ACTIVA_SALIDA_IDIUS_BOSS_5

.MUEVE_BARRO_DERECHA_SALIDA_IDIUS_BOSS_5:

		add		a,BARROS_MUERTE_PASO_X_BOSS_5
		jr		c,.MATA_BARRO_SALIDA_IDIUS_BOSS_5
		ld		(hl),a
		cp		255
		jr		z,.MATA_BARRO_SALIDA_IDIUS_BOSS_5
		pop		de
		jr		.PINTA_BARRO_ACTIVA_SALIDA_IDIUS_BOSS_5

.MATA_BARRO_SALIDA_IDIUS_BOSS_5:

		ld		hl,BARROS_MUERTE_IDIUS_ACTIVA
		add		hl,bc
		xor		a
		ld		(hl),a
		ld		a,(BARROS_MUERTE_IDIUS_CONTADOR)
		dec		a
		ld		(BARROS_MUERTE_IDIUS_CONTADOR),a
		pop		de
		jr		.PINTA_BARRO_OCULTA_SALIDA_IDIUS_BOSS_5

.PINTA_BARRO_ACTIVA_SALIDA_IDIUS_BOSS_5:

		ld		a,BARROS_MUERTE_Y_BOSS_5
		ld		(de),a
		inc		de
		push	de
		ld		b,0
		ld		hl,BARROS_MUERTE_IDIUS_X
		add		hl,bc
		ld		a,(hl)
		pop		de
		ld		(de),a
		inc		de
		ld		a,c
		and		00000001b
		jr		nz,.PATRON_BARRO_DERECHA_SALIDA_IDIUS_BOSS_5

.PATRON_BARRO_IZQUIERDA_SALIDA_IDIUS_BOSS_5:

		ld		a,BARRO_PATRON_IZQUIERDA_BOSS_5
		jr		.GUARDA_PATRON_BARRO_SALIDA_IDIUS_BOSS_5

.PATRON_BARRO_DERECHA_SALIDA_IDIUS_BOSS_5:

		ld		a,BARRO_PATRON_DERECHA_BOSS_5
		jr		.GUARDA_PATRON_BARRO_SALIDA_IDIUS_BOSS_5

.PINTA_BARRO_OCULTA_SALIDA_IDIUS_BOSS_5:

		ld		a,BARROS_MUERTE_Y_OCULTA_BOSS_5
		ld		(de),a
		inc		de
		ld		a,BARROS_MUERTE_X_OCULTA_BOSS_5
		ld		(de),a
		inc		de
		xor		a

.GUARDA_PATRON_BARRO_SALIDA_IDIUS_BOSS_5:

		ld		(de),a
		inc		de
		xor		a
		ld		(de),a
		inc		de

		inc		c
		ld		a,c
		cp		BARROS_MUERTE_CANTIDAD_BOSS_5
		jp		c,.BUCLE_MUEVE_BARROS_SALIDA_IDIUS_BOSS_5

		ld		hl,BARROS_MUERTE_IDIUS_ATRIBUTOS
		ld		de,BARROS_MUERTE_ATRIBUTOS_VRAM_BOSS_5
		ld		bc,BARROS_MUERTE_CANTIDAD_BOSS_5*4
		jp		PON_COLOR_2.sin_bc_impuesta

TIRA_FX_BOSS_5:

		call	PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
		jp		PAGE_10_A_SEGMENT_2

MUERTE_DE_IDIUS_BOSS_5:
; paramos la música
		call	stpmus

; Nos aseguramos que el prota no está en modo transparente ni el fondo en colores varios
		ld		a,COLOR_ALEATORIO_SIN_CAMBIOS_BOSS_5
		ld		(COLOR_ALEATORIO),a
		xor		a
		ld		(INMUNE),a

; pequeña pausa
		ld		a,IDIUS_PAUSA_BOCA_BOSS_5
		call	BUCLE_PINTA_TILES.rutina_de_pausa

; limpiamos sprites
		xor		a
		ld		hl,SPRITES_ATRIBUTOS_VRAM_BOSS_5+IDIUS_LIMPIA_SPRITE_INICIAL_BOSS_5*4
		ld		bc,IDIUS_LIMPIA_SPRITES_CANT_BOSS_5*4
		call	FILVRM_RAM
		call	INICIALIZA_BUBBLES_MUERTE_IDIUS_BOSS_5


; animamos la muerte de AGONIX		
		ld		b,IDIUS_MUERTE_BUCLES_BOSS_5

.BUCLE_ANIMA_MUERTE_IDIUS_BOSS_5:

		push	bc

		ld		ix,COPY_ANIMA_MUERTE_IDIUS_A_BUFFER_BOSS_5
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	RUTINA_BOSS_5.BUCLE_PINTA_DATAS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		ld		a,(IDIUS_BOSS_5_X)
		ld		(iy),a
		xor		a
		ld		(iy+1),a
		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY

		ld		ix,COPY_ANIMA_MUERTE_IDIUS_DESDE_BUFFER_BOSS_5
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	RUTINA_BOSS_5.BUCLE_PINTA_DATAS
		ld		iy,DATAS_COPY_RECUP_SCROLL
		ld		a,(IDIUS_BOSS_5_X)
		ld		(iy+4),a
		xor		a
		ld		(iy+5),a
		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		call	VDPREADY

		ld		a,1
		pop		bc
		push	bc
		dec		b
		jr		nz,.RESPAWN_BUBBLES_MUERTE_IDIUS_BOSS_5
		xor		a

.RESPAWN_BUBBLES_MUERTE_IDIUS_BOSS_5:

		ld		(VARIABLE_UN_USO2),a

		ld		b,BARROS_MUERTE_PASOS_ENTRE_COPY_BOSS_5

.BUCLE_BARROS_ENTRE_COPY_MUERTE_IDIUS_BOSS_5:

		push	bc
		call	MUEVE_BUBBLES_MUERTE_IDIUS_BOSS_5
		pop		bc
		djnz	.BUCLE_BARROS_ENTRE_COPY_MUERTE_IDIUS_BOSS_5

		ld		a,IDIUS_MUERTE_PAUSA_BOSS_5
		call	BUCLE_PINTA_TILES.rutina_de_pausa
		pop		bc
		djnz	.BUCLE_ANIMA_MUERTE_IDIUS_BOSS_5

		call	ESPERA_FIN_BUBBLES_MUERTE_IDIUS_BOSS_5
		call	PREPARA_VRAM_PARA_MUERTE_DEPH_EN_BOSS

TERMINANDO_LA_BATALLA_b5:

		include	"../AUDIOS/INICIA MUSICA_WIN.asm"

		ld		hl,TODOS_LOS_SPRITES
		call	PAGE_32_A_SEGMENT_2
		ld		de,PATRONES_SPRITES_VRAM_BOSS_5+DEPH_SALIDA_SPRITES_INICIO_BOSS_5*8*4
		ld		bc,DEPH_SALIDA_SPRITES_CANT_BOSS_5*8*4
		call	PON_COLOR_2.sin_bc_impuesta
		call	PAGE_10_A_SEGMENT_2
		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM
		call	PAGE_10_A_SEGMENT_2

CAMINITO_A_PUERTA_b5:

		include	"../ANIMACIONES/PASEITO HASTA PUERTA.asm"		
SALUDO_b5:

		include	"../ANIMACIONES/SALUDO_GANA_FASE.asm"		

ULTIMO_DESPLAZAMIENTO_b5:

		include	"../ANIMACIONES/PASEITO DENTRO DE PUERTA.asm"	

VOLVEMOS_b5:

		jp		CARGA_SLOT_REGRESO_A_JUEGO

	include	"BOSS 5 DATA.asm"
