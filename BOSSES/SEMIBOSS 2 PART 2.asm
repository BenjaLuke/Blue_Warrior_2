MAGIA_ROCK_FX_PART2_SEMIBOSS_2						equ		13
FX_CANAL_0_PART2_SEMIBOSS_2							equ		0
BANCO_FX_PART2_SEMIBOSS_2							equ		31
BANCO_COMUN_PART2_SEMIBOSS_2						equ		10
BANCO_SPRITES_PART2_SEMIBOSS_2						equ		32
BANCO_FASE_OFFSET_MAGIA_PART2_SEMIBOSS_2			equ		20

DATAS_COPY_TAM_PART2_SEMIBOSS_2						equ		15
COPIAS_RESTO_RAYO_PART2_SEMIBOSS_2					equ		9
RAYO_BUCLES_EXTERIORES_PART2_SEMIBOSS_2				equ		2
PAUSA_RAYO_PART2_SEMIBOSS_2							equ		5
RAYO_CAMBIA_ADJUST_EN_B_PART2_SEMIBOSS_2			equ		7
ADJUST_ACTIVO_PART2_SEMIBOSS_2						equ		1
ROCA_MAGIA_DANO_PART2_SEMIBOSS_2					equ		4
VIDA_INICIAL_ROCKAGER_PART2_SEMIBOSS_2				equ		40

ROCKAGER_LIMITES_CANT_PART2_SEMIBOSS_2				equ		6
ROCKAGER_LIMITES_TAM_PART2_SEMIBOSS_2				equ		7
ROCKAGER_ANCHO_COLISION_PART2_SEMIBOSS_2			equ		37
SECUENCIA_ROCKAGER_DOS_PART2_SEMIBOSS_2				equ		2
EMPUJE_DEPH_ROCKAGER_PART2_SEMIBOSS_2				equ		10
X_CENTRO_PANTALLA_PART2_SEMIBOSS_2					equ		128
FX_TOQUE_DEPH_PART2_SEMIBOSS_2						equ		3

PIEDRAS_CANT_PART2_SEMIBOSS_2						equ		6
PIEDRAS_ACTIVAS_COLISION_PART2_SEMIBOSS_2			equ		4
PIEDRA_TAM_DATOS_PART2_SEMIBOSS_2					equ		4
PIEDRA_ESTADO_QUIETA_PART2_SEMIBOSS_2				equ		25
PIEDRA_ESTADO_FIN_BUCLE_PART2_SEMIBOSS_2			equ		26
PIEDRA_ESTADO_SALE_DISPARADA_PART2_SEMIBOSS_2		equ		27
PIEDRA_ESTADO_REBOTA_PART2_SEMIBOSS_2				equ		24
PIEDRA_ESTADO_COGE_PART2_SEMIBOSS_2					equ		8
PIEDRA_ESTADO_TOCA_SUELO_PART2_SEMIBOSS_2			equ		16
PIEDRA_PARON_FOTOGRAMA_1_PART2_SEMIBOSS_2			equ		18
PIEDRA_PARON_FOTOGRAMA_2_PART2_SEMIBOSS_2			equ		54
PIEDRA_PARON_FOTOGRAMA_3_PART2_SEMIBOSS_2			equ		90
PIEDRA_PATRON_BASE_PART2_SEMIBOSS_2					equ		60*4
PIEDRA_REBOTE_PASO_PART2_SEMIBOSS_2					equ		10
PIEDRA_LIMITE_X_REBOTE_PART2_SEMIBOSS_2				equ		245
PIEDRA_LIMITE_Y_REBOTE_PART2_SEMIBOSS_2				equ		211
PIEDRA_COLISION_MARGEN_PART2_SEMIBOSS_2				equ		8
PROTA_COLISION_ANCHO_PART2_SEMIBOSS_2				equ		20
CORAZONES_X_BASE_PART2_SEMIBOSS_2					equ		43
MAGIA_X_BASE_PART2_SEMIBOSS_2						equ		25

FX_ROCA_TOCA_SUELO_PART2_SEMIBOSS_2					equ		29
FX_ROCA_SALE_PART2_SEMIBOSS_2						equ		27
FX_ROCA_COGE_PART2_SEMIBOSS_2						equ		28
TIEMPO_ADJUST_TOCA_SUELO_PART2_SEMIBOSS_2			equ		5
COLOR_ALEATORIO_ACTIVO_PART2_SEMIBOSS_2				equ		1

VRAM_SPRITES_PATRONES_PART2_SEMIBOSS_2				equ		#4000
VRAM_SPRITES_ATRIBUTOS_PART2_SEMIBOSS_2				equ		#4A00
VRAM_SPRITES_COLOR_PART2_SEMIBOSS_2					equ		#4800
SPRITE_ROCAS_ATR_BASE_PART2_SEMIBOSS_2				equ		VRAM_SPRITES_ATRIBUTOS_PART2_SEMIBOSS_2+18*4
COLOR_PIEDRAS_DESTINO_PART2_SEMIBOSS_2				equ		VRAM_SPRITES_COLOR_PART2_SEMIBOSS_2+16*14
COLOR_PIEDRAS_TAM_PART2_SEMIBOSS_2					equ		16*2
COLOR_PIEDRAS_PASO_PART2_SEMIBOSS_2					equ		32

SPRITE_ATRIBUTOS_TAM_PART2_SEMIBOSS_2				equ		3
SECUENCIA_ROCKAGER_UNO_PART2_SEMIBOSS_2				equ		1
SECUENCIA_ROCKAGER_TRES_PART2_SEMIBOSS_2			equ		3

SPRITES_ACTIVOS_ROCKAGER_OFS_PART2_SEMIBOSS_2		equ		5
SPRITES_FIJOS_ROCKAGER_CANT_PART2_SEMIBOSS_2		equ		7
BANCO_STAGE_2_A_PART2_SEMIBOSS_2					equ		12
BANCO_STAGE_2_B_PART2_SEMIBOSS_2					equ		17
VRAM_GRAFICOS_ORIGEN_PART2_SEMIBOSS_2				equ		#8000
VRAM_GRAFICOS_DESTINO_1_PART2_SEMIBOSS_2			equ		#8000
VRAM_GRAFICOS_DESTINO_2_PART2_SEMIBOSS_2			equ		#C000
TAM_BANCO_GRAFICOS_PART2_SEMIBOSS_2					equ		16384

MAGIA_ROCK:

.MIRAMOS_SI_PUEDE_HACER_MAGIA:
	
	ld		a,(MAGIAS)
	or		a
	ret		z

	dec		a
	ld		(MAGIAS),a

	di															; Paramos la música
	call	hltmus
	ei

    call    PAGE_31_A_SEGMENT_2
	ld		a,MAGIA_ROCK_FX_PART2_SEMIBOSS_2
	ld		c,FX_CANAL_0_PART2_SEMIBOSS_2
	call	ayFX_INIT
    call    PAGE_10_A_SEGMENT_2

.ANIMACION:

	push	iy
	push	ix
		
.PALETA_A_GRISES:

	ld		a,(ESTADO_COLOR_PERM)
	push	af
	call	BUCLE_PINTA_TILES.PINTA_PALETA_GRIS

.VUELCA_TROZOS_DE_DOS_1:

    ld      hl,COPIA_PARTE_1_DE_DOS_A_TRES_PARA_RAYO
 	ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS	       
	ld		bc,DATAS_COPY_TAM_PART2_SEMIBOSS_2
	ldir

.TROZO_1_EN_UNA_PIEZA:

    ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	call   	DOCOPY

.VUELCA_TROZOS_DE_DOS_2:

    ld      hl,COPIA_PARTE_2_DE_DOS_A_TRES_PARA_RAYO
 	ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS	       
	ld		bc,DATAS_COPY_TAM_PART2_SEMIBOSS_2
	ldir
    ld		ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS

.TROZO_2_EN_UNA_PIEZA:

    ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	call   	DOCOPY

.VUELCA_TROZOS_DE_DOS_3:

    ld      hl,COPIA_PARTE_3_DE_DOS_A_TRES_PARA_RAYO
 	ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS	       
	ld		bc,DATAS_COPY_TAM_PART2_SEMIBOSS_2
	ldir
    ld		ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS

.TROZO_3_EN_UNA_PIEZA:

    ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	call   	DOCOPY

.RESTO_DE_COPIAS:

	ld	hl,COPIA_1_A_2

	ld	b,COPIAS_RESTO_RAYO_PART2_SEMIBOSS_2
		
.bucle_de_copys_1:

	push	bc
	call	DOCOPY
	pop		bc
	djnz	.bucle_de_copys_1

.VUELCA_RAYOS_EN_TRES:

	ld		hl,COPIA_RAYOS_A_VRAM
	ld		de,RAYOS_EN_PACK
	call	PAGE_32_A_SEGMENT_2
	call	HMMC
	call	PAGE_10_A_SEGMENT_2

.COPIA_RAYOS_EN_FOTOGRAMAS_ADECUADOS_Y_ANIMACION:

	ld		hl,COPIA_RAYOS_A_1
	call	DOCOPY
	call	DOCOPY
	call	DOCOPY

    xor      a
    ld      (TIEMPO_DE_ADJUST),a

	ld	b,RAYO_BUCLES_EXTERIORES_PART2_SEMIBOSS_2

.bucle_de_copys_3:

	push	bc
	ld		hl,COPIA_RAYO_1_1
	ld		ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	ld		b,DATAS_COPY_TAM_PART2_SEMIBOSS_2

.bucle_de_copys_2:

	push	bc
	push	hl
	ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	ld		bc,DATAS_COPY_TAM_PART2_SEMIBOSS_2
	ldir

	pop		hl
	push	ix
	push	hl
	pop		ix
	pop		ix
	push	hl

.RAYOS_EN_UNO:

	ld		hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	call	DOCOPY
	
.regreso_de_bucle:

	pop		hl
	ld		de,DATAS_COPY_TAM_PART2_SEMIBOSS_2
	or		a
	adc		hl,de

	ld		a,PAUSA_RAYO_PART2_SEMIBOSS_2
	call	BUCLE_PINTA_TILES.rutina_de_pausa

	pop		bc

	ld		a,b
	cp		RAYO_CAMBIA_ADJUST_EN_B_PART2_SEMIBOSS_2
	jp		nz,.sin_cambio_en_Adjust

    ld      a,ADJUST_ACTIVO_PART2_SEMIBOSS_2
    ld      (TIEMPO_DE_ADJUST),a		

.sin_cambio_en_Adjust:

	djnz	.bucle_de_copys_2

	pop		bc
	djnz	.bucle_de_copys_3

.restamos_vida_a_rockagers:

.primer_rockager:

	ld		a,(VIDA_ROCKAGER_1)
	sub		ROCA_MAGIA_DANO_PART2_SEMIBOSS_2
	ld		(VIDA_ROCKAGER_1),a

	cp		VIDA_INICIAL_ROCKAGER_PART2_SEMIBOSS_2
	jp		c,.segundo_rockager

	xor		a
	ld		(VIDA_ROCKAGER_1),a

.segundo_rockager:

	ld		a,(VIDA_ROCKAGER_2)
	sub		ROCA_MAGIA_DANO_PART2_SEMIBOSS_2
	ld		(VIDA_ROCKAGER_2),a

	cp		VIDA_INICIAL_ROCKAGER_PART2_SEMIBOSS_2
	jp		c,.repintamos_puntos_de_magia

	xor		a
	ld		(VIDA_ROCKAGER_2),a

.repintamos_puntos_de_magia:

		call	PINTAMOS_LOS_PUNTOS_DE_MAGIA_ROCK
       	ld      a,(FASE)
        add     BANCO_FASE_OFFSET_MAGIA_PART2_SEMIBOSS_2
        call    CHANGE_BANK_2
		di
		call	cntmus
		ei

        ld		a,BANCO_COMUN_PART2_SEMIBOSS_2
		call	CHANGE_BANK_2

.VUELVE_A_PINTAR_TRES_EN_NEGRO:

    ld      hl,COPIA_NEGRO_EN_3
[2] call    DOCOPY

	ld		a,(VARIABLE_UN_USO3)
	or		a
	jp		z,.final
	
.final:

		pop		af
		ld		(ESTADO_COLOR_PERM),a
		xor		a
		ld		(TIEMPO_DE_ADJUST),a
		
		pop		ix
		pop		iy
		ret

REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH_ROCK:

		ld		a,(INMUNE)
		or		a
		jp		z,.adelante
		dec		a
		ld		(INMUNE),a

.adelante:

		ld		ix,.LIMITES_ROCKAGERS
		ld		iy,.LIMITE_VARIABLE_Y_SUPERIOR
		ld		b,ROCKAGER_LIMITES_CANT_PART2_SEMIBOSS_2

.control_x:

		ld		a,(ix)						; 19
		ld		de,(X_DEPH)					; 20
		cp		e							; 4
		jp		nc,.fin_bucle				; 10
		add		a,ROCKAGER_ANCHO_COLISION_PART2_SEMIBOSS_2	; 7
		cp		e							; 4
		jp		c,.fin_bucle				; 10
											; Total 74 20,43% + rápido
		ld		a,(SECUENCIA_DE_ROCKAGER)
		cp		SECUENCIA_ROCKAGER_DOS_PART2_SEMIBOSS_2
		jp		z,.control_y_2
		jp		.control_y_1

.fin_bucle:

		ld		de,ROCKAGER_LIMITES_TAM_PART2_SEMIBOSS_2
		add		ix,de
		djnz	.control_x

		ret


.control_y_1:

		ld		c,(ix+3)
		ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
		cp		c
		jp		nc,.fin_bucle
		ld		c,(ix+2)

		jp		.control_y_1_2

.control_y_2:

		ld		c,(ix+5)
		ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
		cp		c
		jp		nc,.fin_bucle
		ld		c,(ix+4)


.control_y_1_2:

		cp		c
		jp		c,.fin_bucle
		sub		c
		ld		e,a
		ld		d,0
		add		iy,de
		ld		c,(iy)
		ld		a,(ix+6)
		add		c
		push	af
		pop		de
		ld		a,(Y_DEPH)
		cp		d
		ld		iy,.LIMITE_VARIABLE_Y_SUPERIOR
		jp		c,.fin_bucle

		ld		c,(ix+1)
		cp		c
		jp		nc,.fin_bucle

		jp		.recibe_un_toque

.LIMITES_ROCKAGERS:

		db		32,92,04,34,04,34
		db		44

		db		20,140,40,70,76,106
		db		92

		db		66,172,76,106,148,178
		db		124

		db		158,92,76,106,184,214
		db		44

		db		210,140,40,70,112,142
		db		92

		db		159,172,04,34,40,70
		db		124

.LIMITE_VARIABLE_Y_SUPERIOR:

		db		43
		db		39,34,30,27,23
		db		19,15,12,08
		db		05,06,05,02,01
		db		06
		db		01,02,05,06,05
		db		08,12,15,19
		db		23,27,30,34,39
		db		43

.recibe_un_toque:

	call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH.DANO_DE_PUPA

	call	PINTA_CORAZONES_VIDA_DEPH_ADECUADOS

	call    PAGE_31_A_SEGMENT_2
	ld		a,FX_TOQUE_DEPH_PART2_SEMIBOSS_2
	ld		c,FX_CANAL_0_PART2_SEMIBOSS_2
	call	ayFX_INIT
    call    PAGE_10_A_SEGMENT_2

	ld		a,(X_DEPH)
	cp		X_CENTRO_PANTALLA_PART2_SEMIBOSS_2
	jp		nc,.RETROCEDE

.ADELANTA:
	add		EMPUJE_DEPH_ROCKAGER_PART2_SEMIBOSS_2
	ld		(X_DEPH),a
	ret

.RETROCEDE:

	sub		EMPUJE_DEPH_ROCKAGER_PART2_SEMIBOSS_2
	ld		(X_DEPH),a
	ret

RUTINA_ROCAS:

.PREPARAMOS_ENTRADA:

	push	ix
	push	iy

	ld		b,PIEDRAS_CANT_PART2_SEMIBOSS_2
	xor		a
	ld		(VARIABLE_UN_USO3),a

.BUCLE_6_PIEDRAS:

	jp		.BUCLE_6_PIEDRAS_EXT

.DESAPARECE:

	ld		iy,VARIABLE_UN_USO
	xor		a
	ld		(iy),a
	ld		(iy+1),a
	ld		(iy+2),a
	call	.MAS_DE_UN_USO_1	
	call	.MAS_DE_UN_USO_2
	jp		.COMUN_PINTA_Y_DESAPARECE

.FIN_DEL_BUCLE:

	ld		a,(VARIABLE_UN_USO3)
	inc		a
	ld		(VARIABLE_UN_USO3),a

	djnz	.BUCLE_6_PIEDRAS

.VOLVEMOS:

	pop		iy
	pop		ix
	ret

.SALE_DISPARADA:

	ld		a,PIEDRA_ESTADO_FIN_BUCLE_PART2_SEMIBOSS_2
	ld		(ix+3),a

	ld		iy,VARIABLE_UN_USO
	ld		a,(ix+2)
[2]	add		a
	add		PIEDRA_PATRON_BASE_PART2_SEMIBOSS_2
	ld		(ix+2),a
	
	ld		a,(ix)
	sub		PIEDRA_REBOTE_PASO_PART2_SEMIBOSS_2
	ld		(ix),a
	cp		PIEDRA_LIMITE_X_REBOTE_PART2_SEMIBOSS_2
	jp		nc,.SALE_DISPARADA_1

	ld		a,(ix+1)
	sub		PIEDRA_REBOTE_PASO_PART2_SEMIBOSS_2
	ld		(ix+1),a
	cp		PIEDRA_LIMITE_Y_REBOTE_PART2_SEMIBOSS_2
	jp		c,.SALTO_DESDE_REBOTA

.SALE_DISPARADA_1:

	ld		a,PIEDRA_ESTADO_REBOTA_PART2_SEMIBOSS_2
	ld		(ix+3),a
	JP		.SALTO_DESDE_REBOTA

.BUCLE_6_PIEDRAS_EXT:

	ld		a,(SECUENCIA_DE_ROCKAGER)
	or		a
	jp		nz,.SEGUIMOS_SIN_PARON

	ld		a,(VARIABLE_UN_USO3)
	ld		ix,VALORES_SPRITES_PIEDRAS
[2]	add		a
	ld		d,0
	ld		e,a
	add		ix,de
	ld		a,(ix+3)
	cp		PIEDRA_ESTADO_QUIETA_PART2_SEMIBOSS_2
	jp		nc,.SEGUIMOS_SIN_PARON

	ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
	cp		PIEDRA_PARON_FOTOGRAMA_1_PART2_SEMIBOSS_2
	jp		z,.VOLVEMOS
	cp		PIEDRA_PARON_FOTOGRAMA_2_PART2_SEMIBOSS_2
	jp		z,.VOLVEMOS
	cp		PIEDRA_PARON_FOTOGRAMA_3_PART2_SEMIBOSS_2
	jp		z,.VOLVEMOS

.SEGUIMOS_SIN_PARON:

	ld		a,(VARIABLE_UN_USO3)
	ld		ix,VALORES_SPRITES_PIEDRAS
	ld		iy,.DATA_RECORRIDO_ROCA_1
[2]	add		a
	ld		d,0
	ld		e,a
	add		ix,de
	push	de
	pop		hl
	xor		a
[12] adc	hl,de	
	push	hl
	pop		de
	add		iy,de

	ld		a,(ix+3)
	or		a
	call	z,.SALE
	cp		PIEDRA_ESTADO_COGE_PART2_SEMIBOSS_2
	call	Z,.COGE
	cp		PIEDRA_ESTADO_TOCA_SUELO_PART2_SEMIBOSS_2
	call	z,.TOCA_SUELO
	cp		PIEDRA_ESTADO_QUIETA_PART2_SEMIBOSS_2
	jp		z,.DESAPARECE
	cp		PIEDRA_ESTADO_FIN_BUCLE_PART2_SEMIBOSS_2
	jp		z,.FIN_DEL_BUCLE
	cp		PIEDRA_ESTADO_SALE_DISPARADA_PART2_SEMIBOSS_2
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
	inc		a
	and		00000001b
	ld		(ix+2),a

.SALTO_DESDE_REBOTA:

	ld		iy,VARIABLE_UN_USO
	ld		a,(ix)
	sub		PIEDRA_COLISION_MARGEN_PART2_SEMIBOSS_2
	ld		(iy+1),a
	ld		a,(ix+1)
	sub		PIEDRA_COLISION_MARGEN_PART2_SEMIBOSS_2
	ld		(iy),a
	ld		a,(ix+2)
[2]	add		a
	add		PIEDRA_PATRON_BASE_PART2_SEMIBOSS_2
	ld		(iy+2),a

	call	.MAS_DE_UN_USO_1
	call	.MAS_DE_UN_USO_2
	ld		a,(iy+2)
	add		8
	ld		(iy+2),a

.COMUN_PINTA_Y_DESAPARECE:
	
	call	.MAS_DE_UN_USO_1
	ld		de,PIEDRA_TAM_DATOS_PART2_SEMIBOSS_2
	or		a
	adc		hl,de
	call	.MAS_DE_UN_USO_2

	ld		a,(ix+3)
	inc		a
	ld		(ix+3),a

	jp		.FIN_DEL_BUCLE

.MAS_DE_UN_USO_1:

	ld		a,(VARIABLE_UN_USO3)
	and		00000001b
[3]	add		a
	ld		e,a
	ld		d,0
	ld		hl,SPRITE_ROCAS_ATR_BASE_PART2_SEMIBOSS_2
	or		a
	adc		hl,de

	ret

.MAS_DE_UN_USO_2:

	ex		de,hl
	ld		hl,VARIABLE_UN_USO
	push	bc
	ld		bc,SPRITE_ATRIBUTOS_TAM_PART2_SEMIBOSS_2
	call	PON_COLOR_2.sin_bc_impuesta
	pop		bc

	ret

.TOCA_SUELO:

		push	af
        ld      a,TIEMPO_ADJUST_TOCA_SUELO_PART2_SEMIBOSS_2
        ld      (TIEMPO_DE_ADJUST),a
        ld      a,COLOR_ALEATORIO_ACTIVO_PART2_SEMIBOSS_2
        ld      (COLOR_ALEATORIO),a

        ld      a,FX_ROCA_TOCA_SUELO_PART2_SEMIBOSS_2
        ld      c,FX_CANAL_0_PART2_SEMIBOSS_2

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.SALE:

		push	af
        ld      a,FX_ROCA_SALE_PART2_SEMIBOSS_2
        ld      c,FX_CANAL_0_PART2_SEMIBOSS_2

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.COGE:

		push	af
        ld      a,FX_ROCA_COGE_PART2_SEMIBOSS_2
        ld      c,FX_CANAL_0_PART2_SEMIBOSS_2

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.DATA_RECORRIDO_ROCA_1:

	db	8,41
	db	10,46
	db	19,48
	db	28,52
	db	36,56
	db	44,60
	db	50,65
	db	56,71
	db	63,76
	
	db	74,82
	db	86,87
	db	101,95
	db	114,102
	db	126,112
	db	137,122
	db	147,133
	db	156,148
	
	db	166,139
	db	178,133
	db	190,129
	db	208,124
	db	216,121
	db	229,120
	db	243,118
	db	255,117

	db	0,0

.DATA_RECORRIDO_ROCA_2:

	db	255,102
	db	242,104
	db	233,106
	db	222,110
	db	212,116
	db	205,123
	db	197,132
	db	192,142
	db	191,153

	db	175,148
	db	162,145
	db	148,144
	db	130,146
	db	115,152
	db	99,159
	db	89,172
	db	83,156
	
	db	75,175
	db	66,167
	db	60,160
	db	49,154
	db	40,149
	db	27,145
	db	16,144
	db	10,145

	db	0,0

.DATA_RECORRIDO_ROCA_3:
	
	db	8,133	
	db	9,110	
	db	14,108	
	db	21,110	
	db	25,108	
	db	33,109	
	db	39,112	
	db	44,117	
	db	48,121
		
	db	68,114	
	db	84,115	
	db	95,119	
	db	106,124	
	db	116,134	
	db	125,147	
	db	128,161	
	db	132,180
		
	db	146,166	
	db	161,155	
	db	176,147	
	db	193,141	
	db	210,136	
	db	225,131	
	db	241,129	
	db	255,127

	db	0,0

.DATA_RECORRIDO_ROCA_4:
	
	db	255,92	
	db	251,95	
	db	248,97	
	db	245,98	
	db	243,102	
	db	241,106	
	db	240,109	
	db	238,112	
	db	237,120
		
	db	225,107	
	db	205,100	
	db	185,98	
	db	160,101	
	db	143,108	
	db	122,115	
	db	104,126	
	db	92,140
		
	db	81,127	
	db	71,117	
	db	62,110	
	db	50,103	
	db	41,99	
	db	26,95	
	db	13,93
	db	0,93

	db	0,0

.DATA_RECORRIDO_ROCA_5:

	db	8,125
	db	14,118
	db	31,114
	db	43,113
	db	55,116
	db	68,125
	db	78,133
	db	88,143
	db	94,153
	
	db	96,141
	db	99,128
	db	106,115
	db	113,104
	db	124,95
	db	133,88
	db	145,86
	db	153,90
	
	db	164,75
	db	177,61
	db	188,53
	db	203,45
	db	218,39
	db	234,38
	db	245,39
	db	255,43
	db	0,0

.DATA_RECORRIDO_ROCA_6:

	db	255,26
	db	245,26
	db	236,30
	db	226,35
	db	217,42
	db	212,47
	db	204,54
	db	196,61
	db	191,73
	
	db	187,64
	db	178,59
	db	170,58
	db	159,55
	db	151,56
	db	141,59
	db	131,64
	db	124,73
	
	db	103,71
	db	79,80
	db	59,93
	db	42,110
	db	29,128
	db	17,150
	db	8,170
	db	0,193

ON_SPRITE_CON_ROCAS:

	ld	b,PIEDRAS_ACTIVAS_COLISION_PART2_SEMIBOSS_2
	xor	a
	ld	(VARIABLE_UN_USO3),a

.BUCLE_REVISION_6_PIEDRAS:

	push bc
	ld	ix,VALORES_SPRITES_PIEDRAS
[2]	add	a
	ld	e,a
	ld	d,0
	add	ix,de

	ld	a,(ix)
	sub	PIEDRA_COLISION_MARGEN_PART2_SEMIBOSS_2
	ld	c,a
	ld	a,(X_DEPH)
	add	PROTA_COLISION_ANCHO_PART2_SEMIBOSS_2
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix)
	add	PIEDRA_COLISION_MARGEN_PART2_SEMIBOSS_2
	ld	c,a
	ld	a,(X_DEPH)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	sub	PIEDRA_COLISION_MARGEN_PART2_SEMIBOSS_2
	ld	c,a
	ld	a,(Y_DEPH)
	add	PROTA_COLISION_ANCHO_PART2_SEMIBOSS_2
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	add	PIEDRA_COLISION_MARGEN_PART2_SEMIBOSS_2
	ld	c,a
	ld	a,(Y_DEPH)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE
	
	call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH.DANO_DE_PUPA

	call	PINTA_CORAZONES_VIDA_DEPH_ADECUADOS

	call    PAGE_31_A_SEGMENT_2
	ld		a,FX_TOQUE_DEPH_PART2_SEMIBOSS_2
	ld		c,FX_CANAL_0_PART2_SEMIBOSS_2
	call	ayFX_INIT
    call    PAGE_10_A_SEGMENT_2
	pop		bc
	ret

.SIGUIENTE_EN_EL_BUCLE:

	pop 	bc
	ld		a,(VARIABLE_UN_USO3)
	inc		a
	ld		(VARIABLE_UN_USO3),a
	djnz 	.BUCLE_REVISION_6_PIEDRAS

.FIN_DE_ON_SPRITE_CON_ROCAS:

	ret

PINTA_CORAZONES_VIDA_DEPH_ADECUADOS:

	ld		ix,CORAZONES_DEPH_EN_BOSSES
	ld		a,(CORAZONES)
	ld		c,a
[9]	add		c
	ld		c,CORAZONES_X_BASE_PART2_SEMIBOSS_2
	add		c
	ld		(ix),a
	ld		(ix+4),a
    ld      hl,CORAZONES_DEPH_EN_BOSSES
	push	bc
	call   	DOCOPY
	pop		bc
	ret

PINTAMOS_LOS_PUNTOS_DE_MAGIA_ROCK:

	ld		ix,PUNTOS_MAGIA_EN_BOSSES
	ld		a,(MAGIAS)
[3]	add		a
	ld		c,MAGIA_X_BASE_PART2_SEMIBOSS_2
	add		c
	ld		(ix),a
	ld		hl,PUNTOS_MAGIA_EN_BOSSES
	jp		DOCOPY

PREPARACION_ROCKAGER:

    ld		ix,VALORES_SPRITES_PIEDRAS
    ld      a,PIEDRA_ESTADO_QUIETA_PART2_SEMIBOSS_2
    ld      de,PIEDRA_TAM_DATOS_PART2_SEMIBOSS_2        
    ld      b,PIEDRAS_CANT_PART2_SEMIBOSS_2

.BUCLE_TRANQUILIZA_PIEDRAS:

    ld      (ix+3),a
    add     ix,de
    djnz    .BUCLE_TRANQUILIZA_PIEDRAS


.COLOR_PIEDRAS:

	ld		de,COLOR_PIEDRAS_DESTINO_PART2_SEMIBOSS_2
	ld  	b,PIEDRAS_CANT_PART2_SEMIBOSS_2

.BUCLE_PINTA_PIEDRAS:

	push    bc
	ld      hl,COLOR_PIEDRA_1
	ld		bc,COLOR_PIEDRAS_TAM_PART2_SEMIBOSS_2
	push    de
	call  	PON_COLOR_2.sin_bc_impuesta
	pop     hl
	ld      de,COLOR_PIEDRAS_PASO_PART2_SEMIBOSS_2
	or      a
	adc     hl,de
	ex		de,hl
	pop     bc
	djnz    .BUCLE_PINTA_PIEDRAS



	ret


RECARGAMOS_GRAFICOS_STAGE_X:
RECARGAMOS_GRAFICOS_STAGE_2:

	xor     a
	ld      ix,SPRITES_ACTIVOS+SPRITES_ACTIVOS_ROCKAGER_OFS_PART2_SEMIBOSS_2
	ld      b,SPRITES_FIJOS_ROCKAGER_CANT_PART2_SEMIBOSS_2

.LIBERA_SPRITES_FIJOS_ROCKAGER:

	ld      (ix),a
	inc     ix
	djnz    .LIBERA_SPRITES_FIJOS_ROCKAGER

    ld      a,BANCO_STAGE_2_A_PART2_SEMIBOSS_2
    call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
    ld		hl,VRAM_GRAFICOS_ORIGEN_PART2_SEMIBOSS_2				; Carga gráficos fase
    ld		de,VRAM_GRAFICOS_DESTINO_1_PART2_SEMIBOSS_2
    ld		bc,TAM_BANCO_GRAFICOS_PART2_SEMIBOSS_2
    call	PON_COLOR_2.sin_bc_impuesta

    ld      a,BANCO_STAGE_2_B_PART2_SEMIBOSS_2
    call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
    ld		hl,VRAM_GRAFICOS_ORIGEN_PART2_SEMIBOSS_2				; Carga gráficos fase
    ld		de,VRAM_GRAFICOS_DESTINO_2_PART2_SEMIBOSS_2
    ld		bc,TAM_BANCO_GRAFICOS_PART2_SEMIBOSS_2
    call	PON_COLOR_2.sin_bc_impuesta

    ld  	a,BANCO_COMUN_PART2_SEMIBOSS_2
    call	CHANGE_BANK_2

    ld      hl,.BORRA_PARTE_DE_STATUS_PAGE_0
	jp		DOCOPY 

.BORRA_PARTE_DE_STATUS_PAGE_0

    dw      #0000,#0000,#0000,#00B4,255,76
	db		#00,#00,10000000b

COLOR_PIEDRA_1:

	; attr 0
	DB 		$01,$02,$02,$02,$02,$02,$02,$02
	DB 		$02,$02,$02,$02,$02,$02,$02,$01
	; attr 1
	DB 		$00,$41,$41,$41,$41,$41,$41,$41
	DB 		$41,$41,$41,$41,$41,$41,$41,$00
