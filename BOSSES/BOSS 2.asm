VIDA_INICIAL_ROCKAGER_BOSS_2:			equ	40
VIDA_INICIAL_DAVEANIX_BOSS_2:			equ	40
VIDA_TOTAL_INICIAL_BOSS_2:				equ	VIDA_INICIAL_ROCKAGER_BOSS_2+VIDA_INICIAL_DAVEANIX_BOSS_2
VIDA_ANCHO_BARRA_BOSS_2:				equ	99

PAGINA_REGRESO_BOSS_2:					equ	27

; VRAM / sprites
SPRITES_ATRIBUTOS_VRAM_BOSS_2:			equ	#4A00
SPRITES_COLOR_VRAM_BOSS_2:				equ	#4800
PATRONES_SPRITES_VRAM_BOSS_2:			equ	#4000
PAGE_1_VRAM_Y_BOSS_2:					equ	#0100
PAGE_2_VRAM_Y_BOSS_2:					equ	#0200
PAGE_X_VRAM_BOSS_2:						equ	#0000
SPRITES_LIMPIA_INICIAL_BOSS_2:			equ	10
SPRITES_LIMPIA_CANT_INICIAL_BOSS_2:		equ	22
COPY_SIN_OFFSET_BOSS_2:					equ	#00
COPY_LOGICA_NORMAL_BOSS_2:				equ	10010000b

; Proyectiles del boss
PROYECTILES_BOSS_2_CANTIDAD:			equ	8
PROYECTIL_BOSS_2_ESPERA_INICIAL:		equ	15
PROYECTIL_BOSS_2_ESPERA_ENTRE_DISPAROS:	equ	60
PROYECTIL_BOSS_2_SPRITE_INICIAL:		equ	22
PROYECTIL_BOSS_2_SPRITE_FINAL:			equ	30
PROYECTIL_BOSS_2_Y_OCULTO:				equ	217
PROYECTIL_BOSS_2_SPRITES_ACTIVOS_OFS:	equ	12
PROYECTIL_BOSS_2_ATRIBUTOS_VRAM:		equ	SPRITES_ATRIBUTOS_VRAM_BOSS_2+PROYECTIL_BOSS_2_SPRITE_INICIAL*4
PROYECTIL_BOSS_2_COLOR_VRAM:			equ	SPRITES_COLOR_VRAM_BOSS_2+PROYECTIL_BOSS_2_SPRITE_INICIAL*16
PROYECTIL_BOSS_2_PATRON_SPRITE:			equ	160
PROYECTIL_BOSS_2_EMISOR_DER_X:			equ	129
PROYECTIL_BOSS_2_EMISOR_DER_Y:			equ	54
PROYECTIL_BOSS_2_EMISOR_IZQ_X:			equ	110
PROYECTIL_BOSS_2_EMISOR_IZQ_Y:			equ	55

; Salida y muerte de Daveanix
COLOR_ALEATORIO_SIN_CAMBIOS_BOSS_2:		equ	1
DAVEANIX_PAUSA_BOCA_BOSS_2:				equ	100
DAVEANIX_LIMPIA_SPRITE_INICIAL_BOSS_2:	equ	10
DAVEANIX_LIMPIA_SPRITES_CANT_BOSS_2:	equ	20
DAVEANIX_MUERTE_BUCLES_BOSS_2:			equ	64
DAVEANIX_MUERTE_FX_BOSS_2:				equ	25
DAVEANIX_MUERTE_FX_CANAL_BOSS_2:		equ	0
DAVEANIX_MUERTE_PAUSA_BOSS_2:			equ	8

DAVEANIX_BOCA_SX_BOSS_2:				equ	128
DAVEANIX_BOCA_SY_BOSS_2:				equ	224
DAVEANIX_BOCA_DX_BOSS_2:				equ	112
DAVEANIX_BOCA_DY_BOSS_2:				equ	78
DAVEANIX_BOCA_ANCHO_BOSS_2:				equ	32
DAVEANIX_BOCA_ALTO_BOSS_2:				equ	16

DAVEANIX_MUERTE_SX_BOSS_2:				equ	96
DAVEANIX_MUERTE_SY_BOSS_2:				equ	45
DAVEANIX_MUERTE_DX_BOSS_2:				equ	96
DAVEANIX_MUERTE_DY_BOSS_2:				equ	46
DAVEANIX_MUERTE_ANCHO_BOSS_2:			equ	64
DAVEANIX_MUERTE_ALTO_BOSS_2:			equ	53
DAVEANIX_BUFFER_X_BOSS_2:				equ	0
DAVEANIX_BUFFER_Y_BOSS_2:				equ	0

DEPH_SALIDA_SPRITES_INICIO_BOSS_2:		equ	1
DEPH_SALIDA_SPRITES_CANT_BOSS_2:		equ	45

RUTINA_BOSS_2:

		call	stpmus

		ld      a,0
		ld      hl,SPRITES_ATRIBUTOS_VRAM_BOSS_2+SPRITES_LIMPIA_INICIAL_BOSS_2*4
		ld      bc,SPRITES_LIMPIA_CANT_INICIAL_BOSS_2*4
		call    FILVRM_RAM

.VARIABLES:

		ld		a,PAGINA_REGRESO_BOSS_2
		ld		(PAGINA_DE_REGRESO),a
		xor		a
		ld		(PROYECTIL_BOSS_2_DIRECCION),a
		ld		(PROYECTIL_BOSS_2_PASO_TABLA),a
		ld		(PROYECTIL_BOSS_2_X),a
		ld		(PROYECTIL_BOSS_2_SIGUIENTE_EMISOR),a
		ld		a,PROYECTIL_BOSS_2_ESPERA_INICIAL
		ld		(PROYECTIL_BOSS_2_ESPERA),a
		ld		a,PROYECTIL_BOSS_2_SPRITE_INICIAL
		ld		(PROYECTIL_BOSS_2_SPRITE_ACTUAL),a
		ld		(PROYECTIL_BOSS_2_SIGUIENTE_SPRITE),a
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_2_SPRITES_ACTIVOS_OFS
		ld		a,l
		ld		(PROYECTIL_BOSS_2_PUNTERO_SPRITES_ACTIVOS),a
		ld		a,h
		ld		(PROYECTIL_BOSS_2_PUNTERO_SPRITES_ACTIVOS+1),a
		ld		hl,PROYECTIL_BOSS_2_ATRIBUTOS_VRAM
		ld		a,l
		ld		(PROYECTIL_BOSS_2_DIRECCION_VRAM_ATRIBUTOS),a
		ld		a,h
		ld		(PROYECTIL_BOSS_2_DIRECCION_VRAM_ATRIBUTOS+1),a
		ld		hl,PROYECTIL_BOSS_2_COLOR_VRAM
		ld		a,l
		ld		(PROYECTIL_BOSS_2_DIRECCION_VRAM_COLOR),a
		ld		a,h
		ld		(PROYECTIL_BOSS_2_DIRECCION_VRAM_COLOR+1),a
		xor		a
		ld		(ROCKAGER_MUERTO),a
		ld		(PAUSA_EN_ANIMACION_ROCKAGER),a
		ld		(POSICION_DERRUMBE_ROCKAGER),a
		ld		(FOTOGRAMA_SECUENCIA_ROCKAGER_2),a
		ld		(SPRITES_ACTIVOS+PROYECTIL_BOSS_2_SPRITES_ACTIVOS_OFS),a
		ld		(VALORES_EXPLOSION_CON_ROCK),a
		ld		(VALORES_EXPLOSION_CON_ROCK+1),a
		ld		(VALORES_EXPLOSION_CON_ROCK+2),a
		ld		(VALORES_EXPLOSION_CON_ROCK+3),a
		ld		a,VIDA_INICIAL_ROCKAGER_BOSS_2
		ld		(VIDA_ROCKAGER_BOSS_2),a
		ld		a,VIDA_INICIAL_DAVEANIX_BOSS_2
		ld		(VIDA_DAVEANIX_BOSS_2),a
		ld		a,PROYECTIL_BOSS_2_Y_OCULTO
		ld		(PROYECTIL_BOSS_2_Y),a
		call	INICIALIZA_POOL_PROYECTILES_BOSS_2

        ; Variables a reiniciar


        push    ix
        push    iy
        push    bc
        push    de

.COPIA_A_1_PARTE_ALTA:

        ld      ix,BOSS_2_PAGE_2_A_PAGE_1_COMPLETA
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
        
        ld      ix,BOSS_2_PAGE_2_A_PAGE_1_COMPLETA
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

.GUARDA_DATOS_VIDAS_ROCKAGER:

        ld      ix,BOSS_2_COPI_MARCADOR_BOSSES_CORAZONES_VACIOS
        ld      iy,DATAS_COR_EMPT_MALO
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_CORAZONES_EMPTY_DEPH:

        ld      ix,BOSS_2_COPY_CORAZONES_EMPTY_DEPH
        ld      iy,CORAZONES_DEPH_EN_BOSSES
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_PUNTOS_MAGIA:

        ld      ix,BOSS_2_COPY_PUNTOS_MAGIA
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

.CAMBIA_PAGE_PARA_OCULTAR:

        ld      a,1
        ld      (SET_PAGE),a

.COPIA_ESCENARIO_RECOLOCADO_A_PAGE_2:

 		ld	hl,BOSS_2_PAGE_1_A_PAGE_2_COMPLETA
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

.CARGA_ROCAGER_1:

        ld      a,42
        ld		b,43
        call	.CARGA_PANTALLA_COMPLETA

.CARGA_STATUS_BOSS:

        ld      a,45
        call	CHANGE_BANK_2

        ld		hl,STATUS_BOSS_2_AND_SEMIBOSS_2												; Carga gráficos status
        ld		de,#0000+(256*200)/2
        ld		bc,(256*54)/2
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,10
        call	CHANGE_BANK_2  

.PINTA_STATUS:

        ld      b,15
        ld      hl,BOSS_2_COPIA_PARTE_PAGE_2_DE_STATUS
		call	DOCOPY 

        ld      b,15
        ld      hl,BOSS_2_COPIA_STATUS_BOSS_A_PAGE_2
		call	DOCOPY 
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_2

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

.PINTA_MAGIAS_REALES

	ld		ix,PUNTOS_MAGIA_EN_BOSSES
	ld		a,(MAGIAS)
[3]	add		a
	ld		c,25
	add		c
	ld		(ix),a
	ld		hl,PUNTOS_MAGIA_EN_BOSSES
	call	DOCOPY

; terremoto pequeño
.TERREMOTO_MINI:

		ld		a,10
		ld		(TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

		ld		a,25
		ld		c,0
        call    PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
        call   	PAGE_10_A_SEGMENT_2

; caen rocas
		ld		a,100
		call	BUCLE_PINTA_TILES.rutina_de_pausa

; Pintamos los sprites adecuados para este enemigo

.PIEDRAS_A_INICIO:

    ld		ix,VALORES_SPRITES_PIEDRAS
    ld      a,25
    ld      de,4        
    ld      b,6

.BUCLE_TRANQUILIZA_PIEDRAS:

    ld      (ix+3),a
    add     ix,de
    djnz    .BUCLE_TRANQUILIZA_PIEDRAS

.VOLCAMOS_LOS_NUEVOS_SPRITES_DE_PIEDRA:

	ld		hl,SPRITE_OJOS_ROCKAGER
	ld		de,#4000+56*8*4
	ld		bc,8*8*4
    call    PAGE_32_A_SEGMENT_2
	call	PON_COLOR_2.sin_bc_impuesta
    call    PAGE_10_A_SEGMENT_2

.COLOR_PIEDRAS:

	ld		de,#4800+16*14
	ld  	b,6

.BUCLE_PINTA_PIEDRAS:

	push    bc
	ld      hl,BOSS_2_COLOR_PIEDRA_1
	ld		bc,16*2
	push    de
	call  	PON_COLOR_2.sin_bc_impuesta
	pop     hl
	ld      de,32
	or      a
	adc     hl,de
	ex		de,hl
	pop     bc
	djnz    .BUCLE_PINTA_PIEDRAS

; se abren los 4 agujeros del suelo para rockager
.ANIMACION_AGUJEROS_SUELO:

		call	.ANIMACION_COMUN_1
        ld      ix,BOSS_2_DATA_APARECEN_AGUJEROS
        ld      iy,DATAS_COPY_RECUP_SCROLL

		call	.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV

		call	.ANIMACION_COMUN_2
		cp		16
		ld		(FOTOGRAMA_SECUENCIA_DAV),a
		jp		nz,.ANIMACION_AGUJEROS_SUELO

.CARGA_DAV_1:

        ld      a,46
        ld		b,47
        call	.CARGA_PANTALLA_COMPLETA

		ld		a,9
		call	.CARGA_DAV_COMUN

.BUCLE_DAV_1:

		call	.ANIMACION_COMUN_1
        ld      ix,BOSS_2_DATAS_APARECE_DAVAENIX_1
        ld      iy,DATAS_COPY_RECUP_SCROLL

		call	.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV

		call	.ANIMACION_COMUN_2
		cp		9
		ld		(FOTOGRAMA_SECUENCIA_DAV),a
		jp		nz,.BUCLE_DAV_1

; Se abre pared y ... 
.CARGA_DAV_2:

        ld      a,48
        ld		b,49
        call	.CARGA_PANTALLA_COMPLETA

		ld		a,12
		call	.CARGA_DAV_COMUN

.BUCLE_DAV_2:

		call	.ANIMACION_COMUN_1
        ld      ix,BOSS_2_DATAS_APARECE_DAVAENIX_2
        ld      iy,DATAS_COPY_RECUP_SCROLL

		call	.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV

		call	.ANIMACION_COMUN_2
		cp		12
		ld		(FOTOGRAMA_SECUENCIA_DAV),a
		jp		nz,.BUCLE_DAV_2

; ...aparece Daveatnyx con gran terremoto
.EMPIEZA_LA_MUSICA:

		include	"../AUDIOS/INICIA MUSICA_BOSS.asm"

.CARGA_ROCAGER_2:

		xor		a
		ld		(FOTOGRAMA_SECUENCIA_ROCKAGER_3),a

        ld      a,42
        ld		b,43
        call	.CARGA_PANTALLA_COMPLETA

; todo el codigo de enfrentamiento

		jp	BUCLE_PELEA_BOSS_2

.ANIMACION_COMUN_1:

		ld		a,(FOTOGRAMA_SECUENCIA_DAV)
        ld      e,a
        ld      d,0
        push    de
        pop     hl
        or      a
[5]     adc     hl,de
        ex      de,hl
		ret

.ANIMACION_COMUN_2:

		ld		a,(TIEMPO_DE_ADJUST)
		dec		a
		ld		(TIEMPO_DE_ADJUST),a

		ld		a,25
		ld		c,0
        call    PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
        call   	PAGE_10_A_SEGMENT_2

		push    de
        call    .PINTAMOS_FOTOGRAMA
        pop     de
        ld      a,(FOTOGRAMA_SECUENCIA_DAV)
		inc		a
		ret

.CARGA_DAV_COMUN:

		ld		(TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

		xor		a
		ld      (FOTOGRAMA_SECUENCIA_DAV),a
		ret

.PINTAMOS_FOTOGRAMA:

 		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		jp		VDPREADY

.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV:

		ld		a,8
		call	BUCLE_PINTA_TILES.rutina_de_pausa

        add     ix,de
        ld      a,(ix+1)
        ld      (iy),a
        ld      a,(ix)
        ld      (iy+2),a
		ld		a,COLOR_ALEATORIO_SIN_CAMBIOS_BOSS_2
		ld		(iy+3),a
        ld      a,(ix+3)
        ld      (iy+4),a
        ld      a,(ix+2)
        ld      (iy+6),a
		ld		a,2
		ld		(iy+7),a
        ld      a,(ix+5)
        ld      (iy+8),a
		xor		a
		ld		(iy+9),a
        ld      a,(ix+4)
        ld      (iy+10),a

        ret

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

BUCLE_PELEA_BOSS_2:

		HALT
		ld		a,(CORAZONES)
		or		a
		jp		z,MUERTE_DEPH_EN_BOSS_2
		call	NUCLEO_DE_LA_PELEA_BOSS_2
		call	CONTROLA_INMUNIDAD_DEPH_BOSS_2
		
		call	MOVIMIENTO_DEPH_EN_BOSS_2
		call	SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_2
		call	PINTA_PROYECTILES_DE_DEPH_EN_BOSS_2
        call    REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH_ROCK_BOSS_2
		call	ON_SPRITE_GLOBAL
		call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES_ROCK_BOSS_2
		call	REVISAMOS_SI_MUERE_ROCKAGER_BOSS_2

        ld      a,(VELOCIDAD_ROCKAGER)                  ;  [ Esta secuencia pone una pausa a la velocidad de los rockagers
        inc     a                                       ;  [
        and     00000011B                               ;  [
        ld      (VELOCIDAD_ROCKAGER),a                  ;  [
        jr      nz,.CONTROL_POST_BUCLE_1                ;  [

		call	ANIMA_ROCKAGERS_EN_BOSS_2
		ld		a,(ROCKAGER_MUERTO)
		cp		2
		jr		z,.SIN_RUTINA_ROCAS_BOSS_2
		call	RUTINA_ROCAS_EN_BOSS_2

.SIN_RUTINA_ROCAS_BOSS_2:
		call	PINTA_EXPLOSION_ROCK_BOSS_2

.CONTROL_POST_BUCLE_1:

        ld      a,(TIEMPO_DE_ADJUST)
        or      a
        jr      z,.CONTROL_POST_BUCLE_2
        dec     a
	ld      (TIEMPO_DE_ADJUST),a
	jr      nz,.CONTROL_POST_BUCLE_2
	xor     a
	ld      (COLOR_ALEATORIO),a

.CONTROL_POST_BUCLE_2:

		call	PINTA_PROYECTIL_BOSS_2
		jp	BUCLE_PELEA_BOSS_2

NUCLEO_DE_LA_PELEA_BOSS_2:

		call	ACTIVA_PROYECTIL_BOSS_2
		call	SECUENCIA_PROYECTIL_BOSS_2
		ret

CONTROLA_INMUNIDAD_DEPH_BOSS_2:

		ld		a,(INMUNE)
		or		a
		ret		z
		dec		a
		ld		(INMUNE),a
		ret

INICIALIZA_POOL_PROYECTILES_BOSS_2:

		xor		a
		ld		(PROYECTIL_BOSS_2_SIGUIENTE_EMISOR),a
		ld		(PROYECTIL_BOSS_2_INDICE_ACTUAL),a
		ld		hl,PROYECTILES_BOSS_2_DIRECCION
		ld		b,PROYECTILES_BOSS_2_CANTIDAD

.INICIALIZA_DIRECCIONES_PROYECTIL_BOSS_2:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_DIRECCIONES_PROYECTIL_BOSS_2
		ld		hl,PROYECTILES_BOSS_2_PASO_TABLA
		ld		b,PROYECTILES_BOSS_2_CANTIDAD

.INICIALIZA_PASOS_PROYECTIL_BOSS_2:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_PASOS_PROYECTIL_BOSS_2
		ld		hl,PROYECTILES_BOSS_2_X
		ld		b,PROYECTILES_BOSS_2_CANTIDAD

.INICIALIZA_X_PROYECTIL_BOSS_2:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_X_PROYECTIL_BOSS_2
		ld		a,PROYECTIL_BOSS_2_Y_OCULTO
		ld		hl,PROYECTILES_BOSS_2_Y
		ld		b,PROYECTILES_BOSS_2_CANTIDAD

.INICIALIZA_Y_PROYECTIL_BOSS_2:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_Y_PROYECTIL_BOSS_2
		xor		a
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_2_SPRITES_ACTIVOS_OFS
		ld		b,PROYECTILES_BOSS_2_CANTIDAD

.INICIALIZA_SPRITES_ACTIVOS_PROYECTIL_BOSS_2:

		ld		(hl),a
		inc		hl
		djnz	.INICIALIZA_SPRITES_ACTIVOS_PROYECTIL_BOSS_2
		ld		a,PROYECTIL_BOSS_2_SPRITE_INICIAL
		ld		(PROYECTIL_BOSS_2_SIGUIENTE_SPRITE),a
		ld		(PROYECTIL_BOSS_2_SPRITE_ACTUAL),a
		ld		a,PROYECTIL_BOSS_2_ESPERA_INICIAL
		ld		(PROYECTIL_BOSS_2_ESPERA),a
		ret

ACTIVA_PROYECTIL_BOSS_2:

		ld		a,(PROYECTIL_BOSS_2_ESPERA)
		dec		a
		ld		(PROYECTIL_BOSS_2_ESPERA),a
		ret		nz
		ld		a,PROYECTIL_BOSS_2_ESPERA_ENTRE_DISPAROS
		ld		(PROYECTIL_BOSS_2_ESPERA),a

		call	RESERVA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_2
		ret		z
		ld		a,(PROYECTIL_BOSS_2_SIGUIENTE_EMISOR)
		or		a
		jr		z,.EMISOR_1_PROYECTIL_BOSS_2
		ld		b,PROYECTIL_BOSS_2_EMISOR_DER_X
		ld		c,PROYECTIL_BOSS_2_EMISOR_DER_Y
		jr		.ALTERNA_EMISOR_PROYECTIL_BOSS_2

.EMISOR_1_PROYECTIL_BOSS_2:

		ld		b,PROYECTIL_BOSS_2_EMISOR_IZQ_X
		ld		c,PROYECTIL_BOSS_2_EMISOR_IZQ_Y

.ALTERNA_EMISOR_PROYECTIL_BOSS_2:

		call	PINTA_OJOS_DE_DISPARO_BOSS_2
		call	GUARDA_POSICION_PROYECTIL_BOSS_2_ACTUAL
		ld		a,(PROYECTIL_BOSS_2_SIGUIENTE_EMISOR)
		xor		1
		ld		(PROYECTIL_BOSS_2_SIGUIENTE_EMISOR),a
		call	OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_2_ACTUAL
		xor		a
		ld		(hl),a
		call	CALCULA_DIRECCION_BASE_PROYECTIL_BOSS_2
		push	af
		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_2_ACTUAL
		pop		af
		ld		(hl),a
		call	CARGA_COLOR_PROYECTIL_BOSS_2_ACTUAL
		ret

PINTA_OJOS_DE_DISPARO_BOSS_2:

		push	af
		push	bc
		push	hl
		ld		a,b
		cp		120
		jr		c,.EMISOR_PEQUENO_BOSS_2
		ld		hl,OJO_DERECHO_NORMAL
		call	DOCOPY
		call	VDPREADY
		ld		hl,OJO_IZQUIERDO_ROJO
		call	DOCOPY
		call	VDPREADY
		pop		hl
		pop		bc
		pop		af
		ret

.EMISOR_PEQUENO_BOSS_2:

		ld		hl,OJO_DERECHO_ROJO
		call	DOCOPY
		call	VDPREADY
		ld		hl,OJO_IZQUIERDO_NORMAL
		call	DOCOPY
		call	VDPREADY
		pop		hl
		pop		bc
		pop		af
		ret

SECUENCIA_PROYECTIL_BOSS_2:

		ld		b,PROYECTILES_BOSS_2_CANTIDAD
		xor		a
		ld		(PROYECTIL_BOSS_2_INDICE_ACTUAL),a

.BUCLE_SECUENCIA_PROYECTIL_BOSS_2:

		push	bc
		call	LEE_DIRECCION_TABLA_PROYECTIL_BOSS_2
		or		a
		jr		z,.SIGUIENTE_PROYECTIL_BOSS_2
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
		call	DESACTIVA_PROYECTIL_BOSS_2
		jr		.SIGUIENTE_PROYECTIL_BOSS_2

.SIGUIENTE_PROYECTIL_BOSS_2:

		ld		a,(PROYECTIL_BOSS_2_INDICE_ACTUAL)
		inc		a
		ld		(PROYECTIL_BOSS_2_INDICE_ACTUAL),a
		pop		bc
		djnz	.BUCLE_SECUENCIA_PROYECTIL_BOSS_2
		ret

.PROYECTIL_2:

		call	INC_X_PROYECTIL_BOSS_2_ACTUAL

.PROYECTIL_1:

		call	SUB_2_Y_PROYECTIL_BOSS_2_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_2
		jr		.SIGUIENTE_PROYECTIL_BOSS_2

.PROYECTIL_4:

		call	INC_Y_PROYECTIL_BOSS_2_ACTUAL

.PROYECTIL_3:

		call	INC_X_PROYECTIL_BOSS_2_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_2
		jr		.SIGUIENTE_PROYECTIL_BOSS_2

.PROYECTIL_6:

		call	DEC_X_PROYECTIL_BOSS_2_ACTUAL

.PROYECTIL_5:

		call	INC_Y_PROYECTIL_BOSS_2_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_2
		jr		.SIGUIENTE_PROYECTIL_BOSS_2

.PROYECTIL_8:

		call	SUB_2_Y_PROYECTIL_BOSS_2_ACTUAL

.PROYECTIL_7:

		call	DEC_X_PROYECTIL_BOSS_2_ACTUAL
		call	COMPRUEBA_LIMITES_PROYECTIL_BOSS_2
		jr		.SIGUIENTE_PROYECTIL_BOSS_2

COMPRUEBA_LIMITES_PROYECTIL_BOSS_2:

		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_2_ACTUAL
		ld		a,(hl)
		cp		5
		jp		c,DESACTIVA_PROYECTIL_BOSS_2
		cp		192
		jp		nc,DESACTIVA_PROYECTIL_BOSS_2
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_2_ACTUAL
		ld		a,(hl)
		cp		251
		jp		nc,DESACTIVA_PROYECTIL_BOSS_2
		ret

DESACTIVA_PROYECTIL_BOSS_2:

		xor		a
		push	af
		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_2_ACTUAL
		pop		af
		ld		(hl),a
		push	af
		call	OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_2_ACTUAL
		pop		af
		ld		(hl),a
		push	af
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_2_ACTUAL
		pop		af
		ld		(hl),a
		call	OBTIENE_PUNTERO_SPRITES_ACTIVOS_PROYECTIL_BOSS_2
		xor		a
		ld		(hl),a
		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_2_ACTUAL
		ld		a,PROYECTIL_BOSS_2_Y_OCULTO
		ld		(hl),a
		call	OCULTA_SPRITE_PROYECTIL_BOSS_2_EN_VRAM
		ret

PINTA_PROYECTIL_BOSS_2:

		ld		b,PROYECTILES_BOSS_2_CANTIDAD
		xor		a
		ld		(PROYECTIL_BOSS_2_INDICE_ACTUAL),a

.BUCLE_PINTA_PROYECTIL_BOSS_2:

		push	bc
		call	PINTA_UN_PROYECTIL_BOSS_2
		ld		a,(PROYECTIL_BOSS_2_INDICE_ACTUAL)
		inc		a
		ld		(PROYECTIL_BOSS_2_INDICE_ACTUAL),a
		pop		bc
		djnz	.BUCLE_PINTA_PROYECTIL_BOSS_2
		ret

PINTA_UN_PROYECTIL_BOSS_2:

		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_2_ACTUAL
		ld		a,(hl)
		or		a
		ret		z
		jp		CARGA_ATRIBUTOS_PROYECTIL_BOSS_2

PINTA_PROYECTIL_BOSS_2_1:

		ld		(hl),a
		call	OBTIENE_DIRECCION_ATRIBUTOS_PROYECTIL_BOSS_2
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		bc,3
		call	PON_COLOR_2.sin_bc_impuesta
		ret

CARGA_ATRIBUTOS_PROYECTIL_BOSS_2:

		ld		hl,PROPIEDADES_PATRON_SPRITE
		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_2_ACTUAL
		ld		a,(hl)
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		(hl),a
		inc		hl
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_2_ACTUAL
		ld		a,(hl)
		ld		hl,PROPIEDADES_PATRON_SPRITE+1
		ld		(hl),a
		inc		hl
		ld		a,PROYECTIL_BOSS_2_PATRON_SPRITE
		jr		PINTA_PROYECTIL_BOSS_2_1

CARGA_COLOR_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_DIRECCION_COLOR_PROYECTIL_BOSS_2
		ld		hl,TABLA_COLOR_SPRITE_CENTRAL_BOSS_2
		ld		bc,16
		call	PON_COLOR_2.sin_bc_impuesta
		ret

OCULTA_SPRITE_PROYECTIL_BOSS_2_EN_VRAM:

		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		a,PROYECTIL_BOSS_2_Y_OCULTO
		ld		(hl),a
		inc		hl
		xor		a
		ld		(hl),a
		inc		hl
		ld		(hl),a
		call	OBTIENE_DIRECCION_ATRIBUTOS_PROYECTIL_BOSS_2
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		bc,3
		call	PON_COLOR_2.sin_bc_impuesta
		ret

OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL:

		ld		a,(PROYECTIL_BOSS_2_INDICE_ACTUAL)
		ld		e,a
		ld		d,0
		ret

OBTIENE_PUNTERO_X_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL
		ld		hl,PROYECTILES_BOSS_2_X
		add		hl,de
		ret

OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL
		ld		hl,PROYECTILES_BOSS_2_Y
		add		hl,de
		ret

OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL
		ld		hl,PROYECTILES_BOSS_2_DIRECCION
		add		hl,de
		ret

OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL
		ld		hl,PROYECTILES_BOSS_2_PASO_TABLA
		add		hl,de
		ret

GUARDA_POSICION_PROYECTIL_BOSS_2_ACTUAL:

		push	bc
		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_2_ACTUAL
		pop		bc
		ld		(hl),b
		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_2_ACTUAL
		ld		(hl),c
		ret

INC_X_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_2_ACTUAL
		inc		(hl)
		ret

DEC_X_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_PUNTERO_X_PROYECTIL_BOSS_2_ACTUAL
		dec		(hl)
		ret

INC_Y_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_2_ACTUAL
		inc		(hl)
		ret

SUB_2_Y_PROYECTIL_BOSS_2_ACTUAL:

		call	OBTIENE_PUNTERO_Y_PROYECTIL_BOSS_2_ACTUAL
		ld		a,(hl)
		sub		2
		ld		(hl),a
		ret

OBTIENE_PUNTERO_SPRITES_ACTIVOS_PROYECTIL_BOSS_2:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL
		ld		hl,SPRITES_ACTIVOS+PROYECTIL_BOSS_2_SPRITES_ACTIVOS_OFS
		add		hl,de
		ret

OBTIENE_DIRECCION_ATRIBUTOS_PROYECTIL_BOSS_2:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL
		ld		a,e
		add		a,a
		ld		e,a
		ld		d,0
		ld		hl,TABLA_DIRECCIONES_VRAM_ATRIBUTOS_PROYECTIL_BOSS_2
		add		hl,de
		ld		e,(hl)
		inc		hl
		ld		d,(hl)
		ret

OBTIENE_DIRECCION_COLOR_PROYECTIL_BOSS_2:

		call	OBTIENE_OFFSET_PROYECTIL_BOSS_2_ACTUAL
		ld		a,e
		add		a,a
		ld		e,a
		ld		d,0
		ld		hl,TABLA_DIRECCIONES_VRAM_COLOR_PROYECTIL_BOSS_2
		add		hl,de
		ld		e,(hl)
		inc		hl
		ld		d,(hl)
		ret

RESERVA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_2:

		ld		a,(PROYECTIL_BOSS_2_SIGUIENTE_SPRITE)
		ld		b,PROYECTILES_BOSS_2_CANTIDAD

.BUSCA_SPRITE_LIBRE_PROYECTIL_BOSS_2:

		ld		c,a
		sub		PROYECTIL_BOSS_2_SPRITE_INICIAL
		ld		e,a
		ld		d,0
		ld		hl,PROYECTILES_BOSS_2_DIRECCION
		add		hl,de
		ld		a,(hl)
		or		a
		jr		z,.RESERVA_SPRITE_LIBRE_PROYECTIL_BOSS_2
		ld		a,c
		inc		a
		cp		PROYECTIL_BOSS_2_SPRITE_FINAL
		jr		c,.SIGUE_BUSQUEDA_SPRITE_LIBRE_PROYECTIL_BOSS_2
		ld		a,PROYECTIL_BOSS_2_SPRITE_INICIAL

.SIGUE_BUSQUEDA_SPRITE_LIBRE_PROYECTIL_BOSS_2:

		djnz	.BUSCA_SPRITE_LIBRE_PROYECTIL_BOSS_2
		xor		a
		ret

.RESERVA_SPRITE_LIBRE_PROYECTIL_BOSS_2:

		ld		a,e
		ld		(PROYECTIL_BOSS_2_INDICE_ACTUAL),a
		ld		a,c
		ld		(PROYECTIL_BOSS_2_SPRITE_ACTUAL),a
		call	OBTIENE_PUNTERO_SPRITES_ACTIVOS_PROYECTIL_BOSS_2
		ld		a,1
		ld		(hl),a
		ld		a,c
		inc		a
		cp		PROYECTIL_BOSS_2_SPRITE_FINAL
		jr		c,.GUARDA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_2
		ld		a,PROYECTIL_BOSS_2_SPRITE_INICIAL

.GUARDA_SIGUIENTE_SPRITE_LIBRE_PROYECTIL_BOSS_2:

		ld		(PROYECTIL_BOSS_2_SIGUIENTE_SPRITE),a
		ld		a,1
		or		a
		ret
CALCULA_DIRECCION_BASE_PROYECTIL_BOSS_2:
		ld      a,11
		ld		c,0
		call 	PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
		call	PAGE_10_A_SEGMENT_2

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

LEE_DIRECCION_TABLA_PROYECTIL_BOSS_2:

		call	OBTIENE_PUNTERO_DIRECCION_PROYECTIL_BOSS_2_ACTUAL
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
		ld		hl,TABLA_DIRECCIONES_PROYECTIL_BOSS_2
		add		hl,de
		push	hl
		call	OBTIENE_PUNTERO_PASO_TABLA_PROYECTIL_BOSS_2_ACTUAL
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

MOVIMIENTO_DEPH_EN_BOSS_2:

		include	"COMUN/MOVIMIENTO EN BOSSES.asm"

SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_2:

		include	"COMUN/SECUENCIA PROYECTILES PROPIOS EN BOSSES.asm"

PINTA_PROYECTILES_DE_DEPH_EN_BOSS_2:

		include	"COMUN/PINTADO PROYECTILES PROPIOS EN BOSSES.asm"

ON_SPRITE_GLOBAL:

	ld	b,4
	xor	a
	ld	(VARIABLE_UN_USO3),a
	call	BUCLE_REVISION_4_PIEDRAS_BOSS_2
	jp	BUCLE_REVISION_TODOS_LOS_PROYECTILES_OJO_BOSS_2

GUARDA_ESTADO_PROYECTIL_BOSS_2:

        ld      hl,PROYECTIL_BOSS_2_X
        ld      de,COPIA_PROYECTIL_BOSS_2_X
        ld      bc,14
        ldir
        ret


RESTAURA_ESTADO_PROYECTIL_BOSS_2:

        ld      hl,COPIA_PROYECTIL_BOSS_2_X
        ld      de,PROYECTIL_BOSS_2_X
        ld      bc,14
        ldir
        ret
		
BUCLE_REVISION_4_PIEDRAS_BOSS_2:

	push bc
	ld	ix,VALORES_SPRITES_PIEDRAS
[2]	add	a
	ld	e,a
	ld	d,0
	add	ix,de
	
	ld	a,(ix)
	sub	8
	ld	c,a
	ld	a,(X_DEPH)
	add	20
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix)
	add	8
	ld	c,a
	ld	a,(X_DEPH)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	sub	8
	ld	c,a
	ld	a,(Y_DEPH)
	add	20
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	add	8
	ld	c,a
	ld	a,(Y_DEPH)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE
	
	call	DANO_DEPH_EN_BOSS_2
	pop		bc
	ret

.SIGUIENTE_EN_EL_BUCLE:

	pop 	bc
	ld		a,(VARIABLE_UN_USO3)
	inc		a
	ld		(VARIABLE_UN_USO3),a
	djnz 	BUCLE_REVISION_4_PIEDRAS_BOSS_2

.FIN_DE_ON_SPRITE_CON_ROCAS:

	ret

DANO_DEPH_EN_BOSS_2:

	call	DANO_DEPH_EN_BOSS_COMUN
	call	RUTINA_BOSS_2.PINTA_CORAZONES_VIDA_DEPH_ADECUADOS
	ret

MUERTE_DEPH_EN_BOSS_2:

	call	PREPARA_VRAM_PARA_MUERTE_DEPH_EN_BOSS
	jp		MUERTE_POR_TOQUES_DESDE_BOSS

PINTA_MARCADORES_VIDA_FINAL_BOSS_2:

		ld		a,(VIDA_ROCKAGER_BOSS_2)
		ld		c,a
		ld		a,(VIDA_DAVEANIX_BOSS_2)
		add		c
		call	CONVIERTE_VIDA_FINAL_A_BARRA_BOSS_2

		or		a
		ret		z
		ld		b,a
		ld		a,VIDA_ANCHO_BARRA_BOSS_2
		sub		b
		ld		c,151
		add		c

		ld		ix,DATAS_COR_EMPT_MALO
		ld		(ix+4),a
		ld		a,b
		ld		(ix+8),a
		xor		a
		ld		(ix+9),a

	 	ld	    hl,DATAS_COR_EMPT_MALO
		jp		DOCOPY

CONVIERTE_VIDA_FINAL_A_BARRA_BOSS_2:

		ld		c,a
		ld		a,VIDA_TOTAL_INICIAL_BOSS_2
		sub		c
        ld      b,a
        xor     a
        ld      d,a
        ld      l,a

.BUCLE_ESCALA_VIDA_FINAL_BOSS_2:

        ld      a,b
        or      a
        jr      z,.FIN_ESCALA_VIDA_FINAL_BOSS_2

        dec     b

        ld      a,l
        add     a,VIDA_ANCHO_BARRA_BOSS_2

.AJUSTA_ESCALA_VIDA_FINAL_BOSS_2:

        cp      VIDA_TOTAL_INICIAL_BOSS_2
        jr      c,.GUARDA_RESTO_ESCALA_VIDA_FINAL_BOSS_2

        sub     VIDA_TOTAL_INICIAL_BOSS_2
        inc     d
        jr      .AJUSTA_ESCALA_VIDA_FINAL_BOSS_2

.GUARDA_RESTO_ESCALA_VIDA_FINAL_BOSS_2:

        ld      l,a
        jr      .BUCLE_ESCALA_VIDA_FINAL_BOSS_2

.FIN_ESCALA_VIDA_FINAL_BOSS_2:

        ld      a,d
        ld      h,a
        ld      a,l
        or      a
        ld      a,h
        ret     z
        inc     a
        ret

BUCLE_REVISION_TODOS_LOS_PROYECTILES_OJO_BOSS_2:

		ld		hl,PROYECTILES_BOSS_2_DIRECCION
		ld		ix,PROYECTILES_BOSS_2_X
		ld		iy,PROYECTILES_BOSS_2_Y
		ld		b,PROYECTILES_BOSS_2_CANTIDAD

.BUCLE_REVISION_PROYECTILES_OJO_BOSS_2:

        ld      a,(hl)
        or      a
        jr      z,.SIGUIENTE_PROYECTIL_OJO_BOSS_2

        ; --- Comprobar X ---
        ld      a,(X_DEPH)
        add     a,20
        sub     (ix+0)          ; A = X_DEPH + 20 - X_PROYECTIL
        cp      36              ; 20 + 16
        jr      nc,.SIGUIENTE_PROYECTIL_OJO_BOSS_2

        ; --- Comprobar Y ---
        ld      a,(Y_DEPH)
        add     a,20
        sub     (iy+0)          ; A = Y_DEPH + 20 - Y_PROYECTIL
        cp      36              ; 20 + 16
        jr      nc,.SIGUIENTE_PROYECTIL_OJO_BOSS_2

        ; Si llega aquí, hay colisión

		call	DESACTIVA_PROYECTIL_OJO_BOSS_2_ACTUAL
		call	DANO_DEPH_EN_BOSS_2
		ret

.SIGUIENTE_PROYECTIL_OJO_BOSS_2:

		inc		hl
		inc		ix
		inc		iy
		djnz	.BUCLE_REVISION_PROYECTILES_OJO_BOSS_2
		ret

DESACTIVA_PROYECTIL_OJO_BOSS_2_ACTUAL:

		push	hl
		or		a
		ld		de,PROYECTILES_BOSS_2_DIRECCION
		sbc		hl,de
		ld		a,l
		ld		(PROYECTIL_BOSS_2_INDICE_ACTUAL),a
		pop		hl
		jp		DESACTIVA_PROYECTIL_BOSS_2

REVISAMOS_SI_MUERE_ROCKAGER_BOSS_2:

		ld		a,(ROCKAGER_MUERTO)
		or		a
		ret		nz
		ld		a,(VIDA_ROCKAGER_BOSS_2)
		or		a
		ret		nz
		ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
		cp		102
		jr		nc,.MUERTE_POSICION_4_BOSS_2
		cp		70
		jr		nc,.MUERTE_POSICION_3_BOSS_2
		cp		38
		jr		nc,.MUERTE_POSICION_2_BOSS_2
		ld		a,2
		jr		.GUARDA_MUERTE_ROCKAGER_BOSS_2

.MUERTE_POSICION_2_BOSS_2:

		ld		a,3
		jr		.GUARDA_MUERTE_ROCKAGER_BOSS_2

.MUERTE_POSICION_3_BOSS_2:

		ld		a,4
		jr		.GUARDA_MUERTE_ROCKAGER_BOSS_2

.MUERTE_POSICION_4_BOSS_2:

		ld		a,1

.GUARDA_MUERTE_ROCKAGER_BOSS_2:

		ld		(POSICION_DERRUMBE_ROCKAGER),a
		ld		a,1
		ld		(ROCKAGER_MUERTO),a
		xor		a
		ld		(PAUSA_EN_ANIMACION_ROCKAGER),a
		ld		(FOTOGRAMA_SECUENCIA_ROCKAGER_2),a
		ld		hl,30
		ld		(SCORE_A_SUMAR),hl
		call	SUMA_SCORE
		ret

REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH_ROCK_BOSS_2:

		ld		a,(ROCKAGER_MUERTO)
		or		a
		ret		nz

		ld		a,32

		ld	ix,BOSS_2_LIMITES_ROCKAGERS
		ld	iy,BOSS_2_LIMITE_VARIABLE_Y_SUPERIOR
		ld	b,4

.adelante:

.control_x:

		ld	a,(ix)					; 19
		ld	de,(X_DEPH)				; 20
		cp	e					; 4
		jp	nc,.fin_bucle				; 10
		add	a,37					; 7
		cp	e					; 4
		jp	c,.fin_bucle				; 10
								; Total 74 20,43% + rápido
		jp	.control_y_2

.fin_bucle:

		ld	de,5
		add	ix,de
		djnz	.control_x

		ret

.control_y_2:

		ld	c,(ix+3)        ; 0 - X INFERIOR
                                        ; 1 - Y SUPERIOR
                                        ; 2 - FOTOGRAMA INFERIOR
                                        ; 3 - FOTOGRAMA SUPERIOR
                                        ; 4 - Y INFERIOR
		ld	a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
		cp	c
		jp	nc,.fin_bucle
		ld	c,(ix+2)

.control_y_1_2:

		cp	c
		jp	c,.fin_bucle
		sub	c
		ld	e,a
		ld	d,0
		add	iy,de
		ld	c,(iy)
		ld	a,(ix+4)
		add	c
		push	af
		pop	de
		ld	a,(Y_DEPH)
		cp	d
		ld	iy,BOSS_2_LIMITE_VARIABLE_Y_SUPERIOR
		jp	c,.fin_bucle

		ld	c,(ix+1)
		cp	c
		jp	nc,.fin_bucle

		jp	.recibe_un_toque

.recibe_un_toque:

	call	DANO_DEPH_EN_BOSS_2
	ret

REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES_ROCK_BOSS_2:

		ld		iy,PROYECTILES
		ld		b,6

.BUCLE_6_PROYECTILES_ROCK_BOSS_2:

		push	bc
		ld		a,(iy+2)
		cp		#FF
		jp		z,.PASAMOS_AL_SIGUIENTE_PROYECTIL_ROCK_BOSS_2

		ld		a,(ROCKAGER_MUERTO)
		or		a
		jr		nz,.REVISA_IMPACTO_DAVEANIX_BOSS_2

		ld		ix,BOSS_2_DATAS_REVISIONES_ROCK_BOSS_2
		ld		de,4
		ld		b,4

.REVISION_1_ROCK_BOSS_2:

		ld		c,(ix)
		ld		a,(iy)
		cp		c
		jr		c,.SIGUIENTE_REVISION_ROCK_BOSS_2
		sub		11
		cp		c
		jr		nc,.SIGUIENTE_REVISION_ROCK_BOSS_2
		ld		c,(ix+1)
		ld		a,(iy+1)
		cp		c
		jr		c,.SIGUIENTE_REVISION_ROCK_BOSS_2
		sub		8
		cp		c
		jr		nc,.SIGUIENTE_REVISION_ROCK_BOSS_2

		ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
		cp		(ix+2)
		jr		c,.SIGUIENTE_REVISION_ROCK_BOSS_2
		cp		(ix+3)
		jr		nc,.SIGUIENTE_REVISION_ROCK_BOSS_2

		ld		a,(VIDA_ROCKAGER_BOSS_2)
		or		a
		jr		z,.SOBRE_EL_PROYECTIL_ROCK_BOSS_2
		dec		a
		ld		(VIDA_ROCKAGER_BOSS_2),a
		call	PINTA_MARCADORES_VIDA_FINAL_BOSS_2

.SOBRE_EL_PROYECTIL_ROCK_BOSS_2:

		call	.LIMPIA_PROYECTIL_TRAS_IMPACTO_BOSS_2
		pop		bc
		ret

.SOBRE_EL_PROYECTIL_MUERTE_DAVEANIX_BOSS_2:

		call	.LIMPIA_PROYECTIL_TRAS_IMPACTO_BOSS_2
		pop		bc
		jp		MUERTE_DE_DAVEANIX_BOSS_2

.LIMPIA_PROYECTIL_TRAS_IMPACTO_BOSS_2:

		ld		a,5
		ld		c,0
		call	TIRA_FX_BOSS_2

		xor		a
		ld		(iy+8),a
		ld		a,(iy+12)
		call	SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_2.DEJA_LIBRE_SPRITE_EN_RAM

		ld		ix,VALORES_EXPLOSION_CON_ROCK
		ld		a,(iy)
		ld		(ix+1),a
		ld		a,(iy+1)
		sub		8
		ld		(ix),a
		ld		a,23*4
		ld		(ix+2),a
		ret

.SIGUIENTE_REVISION_ROCK_BOSS_2:

		add		ix,de
		djnz	.REVISION_1_ROCK_BOSS_2

.REVISA_IMPACTO_DAVEANIX_BOSS_2:

		ld		a,(iy+1)
		cp		58
		jr		c,.PASAMOS_AL_SIGUIENTE_PROYECTIL_ROCK_BOSS_2
		sub		58
		cp		15
		jr		nc,.PASAMOS_AL_SIGUIENTE_PROYECTIL_ROCK_BOSS_2
		ld		hl,BOSS_2_DATAS_REVISIONES_X_DAVEANIX_BOSS_2
		ld		b,2

.REVISION_DAVEANIX_BOSS_2:

        ld      c,(hl)
        inc     hl
        ld      a,(iy)
        cp      c
        jr      c,.SIGUIENTE_REVISION_DAVEANIX_BOSS_2
        sub     c
        cp      (hl)
        jr      nc,.SIGUIENTE_REVISION_DAVEANIX_BOSS_2


        ; Primero miramos la vida de Daveanix
        ld      a,(VIDA_DAVEANIX_BOSS_2)
        or      a
        jr      z,.SOBRE_EL_PROYECTIL_ROCK_BOSS_2

        ; Si vida de Daveanix >= 6, se le puede restar siempre
        cp      6
        jr      nc,.RESTAR_VIDA_DAVEANIX_BOSS_2

        ; Si vida de Daveanix < 6, sólo se resta si Rockager está muerto
        ld      a,(VIDA_ROCKAGER_BOSS_2)
        or      a
        jr      nz,.SOBRE_EL_PROYECTIL_ROCK_BOSS_2

        ; Recuperamos la vida de Daveanix porque A ahora contiene vida de Rockager
        ld      a,(VIDA_DAVEANIX_BOSS_2)


.RESTAR_VIDA_DAVEANIX_BOSS_2:

        dec     a
        ld      (VIDA_DAVEANIX_BOSS_2),a
        push    af
        call    PINTA_MARCADORES_VIDA_FINAL_BOSS_2
        pop     af
        or      a
        jr      z,.SOBRE_EL_PROYECTIL_MUERTE_DAVEANIX_BOSS_2
        jr      .SOBRE_EL_PROYECTIL_ROCK_BOSS_2

.SIGUIENTE_REVISION_DAVEANIX_BOSS_2:

		inc		hl
		djnz	.REVISION_DAVEANIX_BOSS_2

.PASAMOS_AL_SIGUIENTE_PROYECTIL_ROCK_BOSS_2:

		ld		de,16
		add		iy,de
		pop		bc
		dec		b
		jp		nz,.BUCLE_6_PROYECTILES_ROCK_BOSS_2
		ret

PINTA_EXPLOSION_ROCK_BOSS_2:

		ld		ix,VALORES_EXPLOSION_CON_ROCK
		ld		a,(ix+2)
		or		a
		ret		z
		cp		25*4
		jr		nz,.PINTAMOS_EXPLOSION_ROCK_BOSS_2

		xor		a
		ld		(ix+2),a

.PINTAMOS_EXPLOSION_ROCK_BOSS_2:

		ld		de,#4A00+17*4
		ld		hl,VALORES_EXPLOSION_CON_ROCK
		ld		bc,3
		call	PON_COLOR_2.sin_bc_impuesta

		ld		de,#4800+17*16
		ld		hl,.COLOR_EXPLOSION_ROCK_BOSS_2
		ld		bc,16
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,(ix+2)
		or		a
		ret		z
		add		4
		ld		(ix+2),a
		ret

.COLOR_EXPLOSION_ROCK_BOSS_2:

		DB      $03,$03,$03,$03,$03,$03,$03,$03
		DB      $03,$03,$03,$03,$03,$03,$03,$03

TIRA_FX_BOSS_2:

		call	PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
		jp		PAGE_10_A_SEGMENT_2

ANIMA_ROCKAGERS_EN_BOSS_2:

		ld		a,(ROCKAGER_MUERTO)
		cp		1
		jp		z,.ANIMA_MUERTE_ROCKAGER_BOSS_2
		cp		2
		ret		z

.ACTIVA_ROCAS_FASE_2:

        ld      ix,VALORES_SPRITES_PIEDRAS
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        cp      6
        jp      z,.ACTIVANDO_COMUN_2
        cp      6+32
        jp      z,.ACTIVANDO_2_2
        cp      6+32+32
        jp      z,.ACTIVANDO_3_2
        cp      6+32+32+32
        jp      z,.ACTIVANDO_4_2
     
        jp      .SECUENCIA_2_CONT_2

.ACTIVANDO_2_2:

        ld      de,4
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_3_2:

        ld      de,8
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_4_2:

        ld      de,12

.ACTIVANDO_COMUN_PRE_2:

        add     ix,de

.ACTIVANDO_COMUN_2:

        xor     a
        ld      (ix+3),a

		srl		a
		ld		a,r
		and		00000011B
		ld		(RECORRIDO_ROCA),a

.SECUENCIA_2_CONT_2:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)

.MIRAMOS_SI_SALTA_AGUJERO:

        cp      32+32+32+32
        jp      z,.CAMBIO_DE_FOTOGRAMA_A_CERO
        jp      .CAMBIO_DE_FOTOGRAMA

.CAMBIO_DE_FOTOGRAMA_A_CERO:

        xor     a

.CAMBIO_DE_FOTOGRAMA:

        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a

.SEGUIMOS_CON_EL_FOTOGRAMA:

        ld      e,a
        ld      d,0
        push    de
        pop     hl
        or      a
 [5]    adc     hl,de
        ex      de,hl
        ld      ix,BOSS_2_DATA_SECUENCIA_2_ROCKAGER
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        inc     a
        cp      128
        jp      c,.SALVAMOS_FOTOGRAMA_2
        xor     a

.SALVAMOS_FOTOGRAMA_2:

        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        
        jp      .PINTAMOS_FOTOGRAMA

.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER:

        add     ix,de
        ld      a,(ix)
        ld      (iy),a
        ld      a,(ix+1)
        ld      (iy+2),a
        ld      a,(ix+2)
        ld      (iy+4),a
        ld      a,(ix+3)
        ld      (iy+6),a
        ld      a,(ix+4)
        ld      (iy+8),a
        ld      a,(ix+5)
        ld      (iy+10),a

        ret

.PAUSA_DE_ANIMACION_2:

        ld      a,(PAUSA_EN_ANIMACION_ROCKAGER)
        inc     a
        and     00000111b
        ld      (PAUSA_EN_ANIMACION_ROCKAGER),a
        or      a
        jp      nz,.PINTAMOS_FOTOGRAMA
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        inc     a
        jp      .SALVAMOS_FOTOGRAMA_2

.PINTAMOS_FOTOGRAMA:

 		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
        ret

.ANIMA_MUERTE_ROCKAGER_BOSS_2:

		ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_2)
		ld		b,a
[2]		sla		a
[2]		add		b
		ld		l,a
		ld		h,0
		ld		a,(POSICION_DERRUMBE_ROCKAGER)
		ld		e,a
		ld		d,0
		or		a
[36]		adc		hl,de
		ex		de,hl
		ld		ix,BOSS_2_DATA_MUERE_ROCKAGER
		ld		iy,DATAS_COPY_RECUP_SCROLL
		call	.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER
		call	.PINTAMOS_FOTOGRAMA
		ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_2)
		inc		a
		cp		5
		jr		nz,.SALVA_FOTOGRAMA_MUERTE_BOSS_2
		ld		a,2
		ld		(ROCKAGER_MUERTO),a

		xor		a
		ld		hl,VALORES_SPRITES_PIEDRAS
		ld		b,24

.BUCLE_LIMPIA_VARIABLES_ROCAS_ROCKAGER_BOSS_2:

		ld		(hl),a
		inc		hl
		djnz	.BUCLE_LIMPIA_VARIABLES_ROCAS_ROCKAGER_BOSS_2

		ld		hl,BOSS_2_VACIO_SPRITES_ROCAS_ROCKAGER_BOSS_2
		ld		de,#4A00+18*4
		ld		bc,16
		call	PON_COLOR_2.sin_bc_impuesta

		ret

.SALVA_FOTOGRAMA_MUERTE_BOSS_2:

		ld		(FOTOGRAMA_SECUENCIA_ROCKAGER_2),a
		ret

RUTINA_ROCAS_EN_BOSS_2:

.PREPARAMOS_ENTRADA:

	push	ix
	push	iy

	ld		b,4
	xor		a
	ld		(VARIABLE_UN_USO3),a

.BUCLE_4_PIEDRAS:

	jr		.BUCLE_4_PIEDRAS_EXT

.DESAPARECE:

	xor		a
	ld		hl,VARIABLE_UN_USO
	ld		(hl),a
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
		call	.PINTA_DOS_SPRITES_ROCA_BOSS_2
	jp		.COMUN_PINTA_Y_DESAPARECE

.FIN_DEL_BUCLE:

	ld		hl,VARIABLE_UN_USO3
	inc		(hl)

	djnz	.BUCLE_4_PIEDRAS

.VOLVEMOS:

	pop		iy
	pop		ix
	ret

.SALE_DISPARADA:

	ld		(ix+3),26

	ld		a,(ix+2)
[2]	add		a
	add		60*4
	ld		(ix+2),a
	
	ld		a,(ix)
	sub		10
	ld		(ix),a
	cp		245
	jr		nc,.SALE_DISPARADA_1

	ld		a,(ix+1)
	sub		10
	ld		(ix+1),a
	cp		211
	jr		c,.SALTO_DESDE_REBOTA

.SALE_DISPARADA_1:

	ld		(ix+3),24
	jr		.SALTO_DESDE_REBOTA


.BUCLE_4_PIEDRAS_EXT:

.SEGUIMOS_SIN_PARON:

	ld		a,(VARIABLE_UN_USO3)
[2]	add		a
	ld		d,0
	ld		e,a
	ld		ix,VALORES_SPRITES_PIEDRAS
	add		ix,de
	ld		iy,BOSS_2_DATA_RECORRIDO_ROCA_1_1
	ld		h,d
	ld		l,e
[12]	add		hl,de
	push	hl
	pop		de
	add		iy,de

	ld		a,(RECORRIDO_ROCA)
	or		a
	jr		z,.SEGUIMOS_TRAS_AZAR
	cp		2
	jr		z,.SEGUNDA_OPCION

.TERCERA_OPCION:

	ld		de,26*4*2
	add		iy,de
	jr		.SEGUIMOS_TRAS_AZAR

.SEGUNDA_OPCION:

	ld		de,26*4*2*2
	add		iy,de	

.SEGUIMOS_TRAS_AZAR:

	ld		a,(ix+3)
	or		a
	call	z,.SALE
	cp		8
	call	Z,.COGE
	cp		16
	call	z,.TOCA_SUELO
	cp		25
	jp		z,.DESAPARECE
	cp		26
	jp		z,.FIN_DEL_BUCLE
	cp		27
	jp		z,.SALE_DISPARADA

	add		a
	ld		e,a
	ld		d,0
	add		iy,de

	ld		a,(iy)
	ld		(ix),a
	ld		a,(iy+1)
	ld		(ix+1),a

	ld		a,(ix+2)
	xor		1
	ld		(ix+2),a

.SALTO_DESDE_REBOTA:

	ld		a,(ix)
	sub		8
	ld		(VARIABLE_UN_USO+1),a
	ld		a,(ix+1)
	sub		8
	ld		(VARIABLE_UN_USO),a
	ld		a,(ix+2)
[2]	add		a
	add		60*4
	ld		(VARIABLE_UN_USO+2),a

	call	.PINTA_DOS_SPRITES_ROCA_BOSS_2

.COMUN_PINTA_Y_DESAPARECE:

	ld		a,(ix+3)
	inc		a
	ld		(ix+3),a

	jp		.FIN_DEL_BUCLE

.MAS_DE_UN_USO_1:

	ld		hl,#4A00+18*4
	ld		a,(VARIABLE_UN_USO3)
	rrca
	ret		nc
	ld		l,#50
	ret

.MAS_DE_UN_USO_2:

	ex		de,hl
	ld		hl,VARIABLE_UN_USO
	push	bc
	ld		bc,3
	call	PON_COLOR_2.sin_bc_impuesta
	pop		bc
	ret

.PINTA_DOS_SPRITES_ROCA_BOSS_2:

	call	.MAS_DE_UN_USO_1
	call	.MAS_DE_UN_USO_2
	ld		a,(VARIABLE_UN_USO+2)
	add		8
	ld		(VARIABLE_UN_USO+2),a
[4]	inc		l
	call	.MAS_DE_UN_USO_2
	ret


.TOCA_SUELO:

		push	af

        ld      a,5
        ld      (TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

        ld      a,29
        ld      c,0
        call    A_31_DESDE_10

		pop		af
		ret


.SALE:

		push	af
        ld      a,27
        ld      c,0

        call    A_31_DESDE_10
		pop		af

		ret

.COGE:

		push	af
        ld      a,28
        ld      c,0

        call    A_31_DESDE_10
		pop		af

		ret

MUERTE_DE_DAVEANIX_BOSS_2:
; paramos la música
		call	stpmus
		
; Daveanix abre la boca
		ld		hl,COPY_DAVEANIX_PRE_PAUSA_BOSS_2
		call	DOCOPY

; Nos aseguramos que el prota no está en modo transparente ni el fondo en colores varios
		ld		a,COLOR_ALEATORIO_SIN_CAMBIOS_BOSS_2
		ld		(COLOR_ALEATORIO),a
		xor		a
		ld		(INMUNE),a
; clor rojo de fondo
        ld      a,3
        ld      (BDRCLR),a
        call    CHGCOLOR_RAM

        ld      a,1
        ld      (COLOR_ALEATORIO),a

        ld      a,60        ; o lo que dure la escena
        ld      (TIEMPO_DE_ADJUST),a

; pequeña pausa
		ld		a,DAVEANIX_PAUSA_BOCA_BOSS_2
		call	BUCLE_PINTA_TILES.rutina_de_pausa

; limpiamos sprites
		xor		a
		ld		hl,SPRITES_ATRIBUTOS_VRAM_BOSS_2+DAVEANIX_LIMPIA_SPRITE_INICIAL_BOSS_2*4
		ld		bc,DAVEANIX_LIMPIA_SPRITES_CANT_BOSS_2*4
		call	FILVRM_RAM
		
; animamos la muerte de Daveanix		
		ld		b,DAVEANIX_MUERTE_BUCLES_BOSS_2



.BUCLE_ANIMA_MUERTE_DAVEANIX_BOSS_2:

		push	bc

; audio de terremoto
		ld		a,DAVEANIX_MUERTE_FX_BOSS_2
		ld		c,DAVEANIX_MUERTE_FX_CANAL_BOSS_2
        call    PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
        call   	PAGE_10_A_SEGMENT_2		
		
		ld		hl,COPY_ANIMA_MUERTE_DAVEANIX_A_BUFFER_BOSS_2
		call	DOCOPY
		ld		hl,COPY_ANIMA_MUERTE_DAVEANIX_DESDE_BUFFER_BOSS_2
		call	DOCOPY
		ld		a,DAVEANIX_MUERTE_PAUSA_BOSS_2
		call	BUCLE_PINTA_TILES.rutina_de_pausa
		pop		bc
		djnz	.BUCLE_ANIMA_MUERTE_DAVEANIX_BOSS_2
		
; devolvemos los colores
		call	PREPARA_VRAM_PARA_MUERTE_DEPH_EN_BOSS

        xor     a
        ld      (BDRCLR),a
        call    CHGCOLOR_RAM

        ld      (TIEMPO_DE_ADJUST),a
        ld      b,a
        ld      c,18
        call    WRTVDP_EN_RAM

        ld      a,2
        ld      (COLOR_ALEATORIO),a


TERMINANDO_LA_BATALLA_b2:

		include	"../AUDIOS/INICIA MUSICA_WIN.asm"

		ld		hl,TODOS_LOS_SPRITES
		call	PAGE_32_A_SEGMENT_2
		ld		de,PATRONES_SPRITES_VRAM_BOSS_2+DEPH_SALIDA_SPRITES_INICIO_BOSS_2*8*4
		ld		bc,DEPH_SALIDA_SPRITES_CANT_BOSS_2*8*4
		call	PON_COLOR_2.sin_bc_impuesta
		call	PAGE_10_A_SEGMENT_2
		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM
		call	PAGE_10_A_SEGMENT_2

CAMINITO_A_PUERTA_b2:

		include	"../VARIOS USOS/PASEITO HASTA PUERTA.asm"		
SALUDO_b2:

		include	"../VARIOS USOS/SALUDO_GANA_FASE.asm"		

FADE_DEPH_b2:

;		ld		hl,FADE_DEPH_A_NEGRO_b2
;		include	"VARIOS USOS/FADE DEPH SALIENDO DE ESCENA.asm"

ULTIMO_DESPLAZAMIENTO_b2:

		include	"../VARIOS USOS/PASEITO DENTRO DE PUERTA.asm"	

VOLVEMOS_b2:

		jp		CARGA_SLOT_REGRESO_A_JUEGO

FADE_DEPH_A_NEGRO_b2:

		incbin	"../PALETAS/BOSS2 DEPH.FADEOUT"

FADE_FASE_1_3_A_NEGRO_b2:

		incbin	"../PALETAS/BOSS2.fadeout"

	include	"BOSS 2 DATA.asm"
