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
	ld		a,13
	ld		c,0
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
	ld		bc,15
	ldir

.TROZO_1_EN_UNA_PIEZA:

    ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	call   	DOCOPY

.VUELCA_TROZOS_DE_DOS_2:

    ld      hl,COPIA_PARTE_2_DE_DOS_A_TRES_PARA_RAYO
 	ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS	       
	ld		bc,15
	ldir
    ld		ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS

.TROZO_2_EN_UNA_PIEZA:

    ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	call   	DOCOPY

.VUELCA_TROZOS_DE_DOS_3:

    ld      hl,COPIA_PARTE_3_DE_DOS_A_TRES_PARA_RAYO
 	ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS	       
	ld		bc,15
	ldir
    ld		ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS

.TROZO_3_EN_UNA_PIEZA:

    ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	call   	DOCOPY

.RESTO_DE_COPIAS:

	ld	hl,COPIA_1_A_2

	ld	b,9
		
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

	ld	b,2

.bucle_de_copys_3:

	push	bc
	ld		hl,COPIA_RAYO_1_1
	ld		ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	ld		b,15

.bucle_de_copys_2:

	push	bc
	push	hl
	ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
	ld		bc,15
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
	ld		de,15
	or		a
	adc		hl,de

	ld		a,5
	call	BUCLE_PINTA_TILES.rutina_de_pausa

	pop		bc

	ld		a,b
	cp		7
	jp		nz,.sin_cambio_en_Adjust

    ld      a,1
    ld      (TIEMPO_DE_ADJUST),a		

.sin_cambio_en_Adjust:

	djnz	.bucle_de_copys_2

	pop		bc
	djnz	.bucle_de_copys_3

.restamos_vida_a_rockagers:

.primer_rockager:

	ld		a,(VIDA_ROCKAGER_1)
	sub		4
	ld		(VIDA_ROCKAGER_1),a

	cp		40
	jp		c,.segundo_rockager

	xor		a
	ld		(VIDA_ROCKAGER_1),a

.segundo_rockager:

	ld		a,(VIDA_ROCKAGER_2)
	sub		4
	ld		(VIDA_ROCKAGER_2),a

	cp		40
	jp		c,.repintamos_puntos_de_magia

	xor		a
	ld		(VIDA_ROCKAGER_2),a

.repintamos_puntos_de_magia:

		call	PINTAMOS_LOS_PUNTOS_DE_MAGIA_ROCK
       	ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2
		di
		call	cntmus
		ei

        ld		a,10
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
		ld		b,6

.control_x:

		ld		a,(ix)						; 19
		ld		de,(X_DEPH)					; 20
		cp		e							; 4
		jp		nc,.fin_bucle				; 10
		add		a,37						; 7
		cp		e							; 4
		jp		c,.fin_bucle				; 10
											; Total 74 20,43% + rápido
		ld		a,(SECUENCIA_DE_ROCKAGER)
		cp		2
		jp		z,.control_y_2
		jp		.control_y_1

.fin_bucle:

		ld		de,7
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
	ld		a,3
	ld		c,0
	call	ayFX_INIT
    call    PAGE_10_A_SEGMENT_2

	ld		a,(X_DEPH)
	cp		128
	jp		nc,.RETROCEDE

.ADELANTA:
	add		10
	ld		(X_DEPH),a
	ret

.RETROCEDE:

	sub		10
	ld		(X_DEPH),a
	ret

RUTINA_ROCAS:

.PREPARAMOS_ENTRADA:

	push	ix
	push	iy

	ld		b,6
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

	ld		a,26
	ld		(ix+3),a

	ld		iy,VARIABLE_UN_USO
	ld		a,(ix+2)
[2]	add		a
	add		60*4
	ld		(ix+2),a
	
	ld		a,(ix)
	sub		10
	ld		(ix),a
	cp		245
	jp		nc,.SALE_DISPARADA_1

	ld		a,(ix+1)
	sub		10
	ld		(ix+1),a
	cp		211
	jp		c,.SALTO_DESDE_REBOTA

.SALE_DISPARADA_1:

	ld		a,24
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
	cp		25
	jp		nc,.SEGUIMOS_SIN_PARON

	ld		a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
	cp		18
	jp		z,.VOLVEMOS
	cp		54
	jp		z,.VOLVEMOS
	cp		90
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
	inc		a
	and		00000001b
	ld		(ix+2),a

.SALTO_DESDE_REBOTA:

	ld		iy,VARIABLE_UN_USO
	ld		a,(ix)
	sub		8
	ld		(iy+1),a
	ld		a,(ix+1)
	sub		8
	ld		(iy),a
	ld		a,(ix+2)
[2]	add		a
	add		60*4
	ld		(iy+2),a

	call	.MAS_DE_UN_USO_1
	call	.MAS_DE_UN_USO_2
	ld		a,(iy+2)
	add		8
	ld		(iy+2),a

.COMUN_PINTA_Y_DESAPARECE:
	
	call	.MAS_DE_UN_USO_1
	ld		de,4
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
	ld		hl,#4A00+18*4
	or		a
	adc		hl,de

	ret

.MAS_DE_UN_USO_2:

	ex		de,hl
	ld		hl,VARIABLE_UN_USO
	push	bc
	ld		bc,3
	call	PON_COLOR_2.sin_bc_impuesta
	pop		bc

	ret

.TOCA_SUELO:

		push	af
        ld      a,5
        ld      (TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

        ld      a,29
        ld      c,0

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.SALE:

		push	af
        ld      a,27
        ld      c,0

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.COGE:

		push	af
        ld      a,28
        ld      c,0

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

	ld	b,6
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
	
	call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH.DANO_DE_PUPA

	call	PINTA_CORAZONES_VIDA_DEPH_ADECUADOS

	call    PAGE_31_A_SEGMENT_2
	ld		a,3
	ld		c,0
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
	ld		c,43
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
	ld		c,25
	add		c
	ld		(ix),a
	ld		hl,PUNTOS_MAGIA_EN_BOSSES
	jp		DOCOPY

PREPARACION_ROCKAGER:

    ld		ix,VALORES_SPRITES_PIEDRAS
    ld      a,25
    ld      de,4        
    ld      b,6

.BUCLE_TRANQUILIZA_PIEDRAS:

    ld      (ix+3),a
    add     ix,de
    djnz    .BUCLE_TRANQUILIZA_PIEDRAS

.VOLCAMOS_LOS_NUEVOS_SPRITES_DE_PIEDRA:

	ld		hl,SPRITES_ROCKAGER_MAREADO
	ld		de,#4000+57*8*4
	ld		bc,7*8*4
    call    PAGE_32_A_SEGMENT_2
	call	PON_COLOR_2.sin_bc_impuesta
    call    PAGE_10_A_SEGMENT_2

.COLOR_PIEDRAS:

	ld		de,#4800+16*14
	ld  	b,6

.BUCLE_PINTA_PIEDRAS:

	push    bc
	ld      hl,COLOR_PIEDRA_1
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


.COLOR_MAREO_PINTA:

    ld		de,#4800+15*16
    ld      hl,.COLOR_MAREO
    ld      bc,16*2
	call	PON_COLOR_2.sin_bc_impuesta

	ret

.COLOR_MAREO:

	DB      $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
	DB      $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
	DB      $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
	DB      $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F

PINTA_MAREO:

.PRIMERA_REVISION:

		ld		ix,.DATAS_fotd_fotu_x_y_1

        ld      a,(SECUENCIA_DE_ROCKAGER)
        cp      1
        ret     z
        cp      3
        ret     z
        cp      2
        jp      z,.REVISION_SECUENCIA_2

.REVISION_SECUENCIA_1:

		xor		a
		ld		(VARIABLE_UN_USO),a
        ld		de,#4A00+16*4

.SECUENCIA_1_ROCK_1:

        ld      a,(VIDA_ROCKAGER_1)
        cp      10
        jp      nc,.SECUENCIA_1_ROCK_2

		ld		b,3
		call	.REVISA_TRES_POSICIONES_1

.SECUENCIA_1_ROCK_2:

		ld		ix,.DATAS_fotd_fotu_x_y_2
        ld      a,(VIDA_ROCKAGER_2)
        cp      10
        ret     nc

        ld		de,#4A00+15*4
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)

		ld		b,3

.REVISA_TRES_POSICIONES_1:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
		cp		98
		call	nc,.LIMPIA_ROCK

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
		call	.RUTINA_COMUN
[4]		inc		ix
		djnz	.REVISA_TRES_POSICIONES_1
		ret

.REVISION_SECUENCIA_2:

        ld      a,(VIDA_ROCKAGER_1)
        cp      10
        ret     nc

        ld      a,(VIDA_ROCKAGER_2)
        cp      10
        ret     nc

		ld		ix,.DATAS_fotd_fotu_x_y_3

        ld		de,#4A00+15*4

		ld		b,6

.REVISA_TRES_POSICIONES_2:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
		cp		206
		call	nc,.LIMPIA_ROCK

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
		call	.RUTINA_COMUN
[4]		inc		ix
		djnz	.REVISA_TRES_POSICIONES_2
		ret

.RUTINA_COMUN:

		ld		c,(ix)
        cp      c
        jp    	c,.LIMPIA_ROCK
		ld		c,(ix+1)
        cp      c
        ret    	nc

        ld      a,(ix+2)
        ld      c,(ix+3)
        jp    .PINTA_ROCK_COMUN

.DATAS_fotd_fotu_x_y_1:

		db		13,26,54,62
		db		49,62,39,110
		db		85,98,86,142

.DATAS_fotd_fotu_x_y_2:

		db		13,26,183,142
		db		49,62,231,110
		db		85,98,182,63

.DATAS_fotd_fotu_x_y_3:

		db		13,26,54,62
		db		49,62,183,142
		db		85,98,39,110
		db		121,134,231,110
		db		157,170,86,142
		db		193,206,182,63

.LIMPIA_ROCK:

        ld    	a,255
        ld      c,0

.PINTA_ROCK_COMUN:

        ld      iy,VALORES_SPRITE_MAREO
        ld      (iy),c
        ld      (iy+1),a
        ld      a,(iy+2)
        add     a,4
        ld      (iy+2),a
        cp      60*4
        jp      nz,.PINTA_ROCK_COMUN_PARTE_2

        ld      a,57*4
        ld      (iy+2),a

.PINTA_ROCK_COMUN_PARTE_2:

        ld      hl,VALORES_SPRITE_MAREO
		ld      bc,3
		call	PON_COLOR_2.sin_bc_impuesta
		ld		b,1
		ret
;    ds      #8000-$-#2200-#1799                                        ; Colocamos el resto del programa siempre en el mismo sitio    

RECARGAMOS_GRAFICOS_STAGE_X:
RECARGAMOS_GRAFICOS_STAGE_2:

    ld      a,12
    call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
    ld		hl,#8000												; Carga gráficos fase
    ld		de,#8000
    ld		bc,16384
    call	PON_COLOR_2.sin_bc_impuesta

    ld      a,17
    call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
    ld		hl,#8000												; Carga gráficos fase
    ld		de,#C000
    ld		bc,16384
    call	PON_COLOR_2.sin_bc_impuesta

    ld  	a,10
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