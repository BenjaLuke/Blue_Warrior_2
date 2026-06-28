
ACTIVA_DEMO_ROTATIVO:

			ld		a,(DEMO_SIGUIENTE)
			cp		1
			jr		z,.DEMO_OK
			cp		3
			jr		z,.DEMO_OK
			cp		5
			jr		z,.DEMO_OK
			ld		a,1

.DEMO_OK:

			ld		(DEMO),a
			add		2
			cp		7
			jr		c,.GUARDA_SIGUIENTE
			ld		a,1

.GUARDA_SIGUIENTE:

			ld		(DEMO_SIGUIENTE),a
			ret


LIMPIA_AUDIO_DEMO_MUERTE:

			call	stpmus
			call	GICINI
			xor		a
			ld		(busply),a
			ld		(LINEA_PSG_QUE_TOCA),a
			ret


OBTIENE_LINEA_INICIAL_FASE:

			ld		ix,TABLA_DE_TAMANO_DE_FASE
			ld		a,(DEMO)
			or		a
			jr		z,.TABLA_LINEA_INICIO_OK
			ld		ix,TABLA_DE_TAMANO_DE_FASE_DEMO

.TABLA_LINEA_INICIO_OK:

			ld		a,(FASE)
			add		a
			ld		e,a
			ld		d,0
			add		ix,de
			ld		l,(ix)
			ld		h,(ix+1)
			ret

TABLA_DE_TAMANO_DE_FASE_DEMO:

			dw		0,185,349,460,468,398


REINICIA_CONTROL_DEMO:

			xor		a
			ld		(DEMO_CONTROL_INDICE),a
			ld		(DEMO_CONTROL_CONTADOR),a
			ld		(DEMO_CONTROL_DIRECCION),a
			ld		(DEMO_CONTROL_DISPARO),a
			ret


CONTROL_DEMO_DIRECCION:

			ld		a,(DEMO_CONTROL_CONTADOR)
			or		a
			jr		z,.NUEVO_PASO
			dec		a
			ld		(DEMO_CONTROL_CONTADOR),a
			ld		a,(DEMO_CONTROL_DIRECCION)
			ret

.NUEVO_PASO:

			ld		a,(DEMO_CONTROL_INDICE)
			ld		e,a
			add		a
			add		e
			ld		e,a
			ld		d,0
			ld		hl,TABLA_CONTROL_DEMO
			add		hl,de
			ld		a,(hl)
			or		a
			jr		nz,.PASO_VALIDO
			call	REINICIA_CONTROL_DEMO
			jr		CONTROL_DEMO_DIRECCION

.PASO_VALIDO:

			ld		(DEMO_CONTROL_CONTADOR),a
			inc		hl
			ld		a,(hl)
			ld		(DEMO_CONTROL_DIRECCION),a
			inc		hl
			ld		a,(hl)
			ld		(DEMO_CONTROL_DISPARO),a
			ld		a,(DEMO_CONTROL_INDICE)
			inc		a
			ld		(DEMO_CONTROL_INDICE),a
			ld		a,(DEMO_CONTROL_DIRECCION)
			ret


CONTROL_DEMO_DIRECCION_CON_GUARDA:

			call	CONTROL_DEMO_DIRECCION
			or		a
			ret		z

			ld		b,a
			ld		a,(GUARDA_STRIG)
			ld		(GUARDA_STRIG_2),a
			ld		a,b
			ld		(GUARDA_STRIG),a
			ret


CONTROL_DEMO_HAY_TECLA:

			ld		c,0
			ld		b,11

.BUCLE_TECLAS_DEMO:

			ld		a,c
			call	SNSMAT_RAM
			cp		#ff
			jr		nz,.HAY_TECLA_DEMO
			inc		c
			djnz	.BUCLE_TECLAS_DEMO
			or		a
			ret

.HAY_TECLA_DEMO:

			scf
			ret


TABLA_CONTROL_DEMO:

			db		30,7,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		20,1,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		10,3,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		30,5,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		10,1,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		10,3,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		30,1,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		10,3,0
			db		6,0,1, 6,0,0, 6,0,1, 6,0,0, 6,0,1, 6,0,0
			db		30,5,0
			db		0,0,0


ES_FASE3_VAGON_ACTIVO:

			ld		a,(FASE)
			cp		3
			jr		nz,.NO_ES_FASE3_VAGON_ACTIVO

			ld		a,(SUMA_CAMINO)
			cp		1
			jr		z,.SI_ES_FASE3_VAGON_ACTIVO
			cp		2
			jr		nz,.NO_ES_FASE3_VAGON_ACTIVO

.SI_ES_FASE3_VAGON_ACTIVO:

			scf
			ret

.NO_ES_FASE3_VAGON_ACTIVO:

			or		a
			ret

GUARDA_PAGE_DATOS_FASE_SALVADA:

			ld		a,(PAGE_DATOS_FASE)
			ld		(PAGE_DATOS_FASE_SALVADA),a
			ld		a,(TRAMO_FASE_3)
			ld		(TRAMO_FASE_3_SALVADO),a
			ret

LIMPIA_BLINDAJE_NACIMIENTO_ENEMIGOS:

			xor		a
			ld		hl,ENEMIGOS_BLINDA_NACIMIENTO
			ld		b,10

.BUCLE_LIMPIA_BLINDAJE_NACIMIENTO:

			ld		(hl),a
			inc		hl
			djnz	.BUCLE_LIMPIA_BLINDAJE_NACIMIENTO
			ret

CONTROL_BLINDAJE_NACIMIENTO_ENEMIGOS:

			ld		hl,ENEMIGOS_BLINDA_NACIMIENTO
			ld		b,10

.BUCLE_CONTROL_BLINDAJE_NACIMIENTO:

			ld		a,(hl)
			or		a
			jr		z,.SIGUIENTE_CONTROL_BLINDAJE_NACIMIENTO
			dec		(hl)

.SIGUIENTE_CONTROL_BLINDAJE_NACIMIENTO:

			inc		hl
			djnz	.BUCLE_CONTROL_BLINDAJE_NACIMIENTO
			ret

CONTROL_RESPAWN_ECTO_HUEVOS:

			ld		a,(FASE)
			cp		4
			ret		nz
			ld		a,(ECTO_HUEVOS_RESPAWN)
			or		a
			ret		z
			dec		a
			ld		(ECTO_HUEVOS_RESPAWN),a
			ret		nz
			xor		a
			ld		(ECTOPALLERS_NUEVO_NECESARIO),a
			ld		(ECTOPALLERS_ACTIVO),a
			ld		(ECTO_HUEVOS_GOLPES),a
			ld		(ECTO_PARALIZADO),a
			call	NUEVO_ECTO_PALLERS_TOCA_HUEVOS
			jp		CARGA_ECTO_PALLER

ACTIVA_BLINDAJE_NACIMIENTO_ENEMIGO:

			push	af
			call	PUNTERO_BLINDAJE_NACIMIENTO_ENEMIGO
			ld		a,16
			ld		(hl),a
			pop		af
			ret

ENEMIGO_EN_BLINDAJE_NACIMIENTO:

			push	af
			push	de
			push	ix
			pop		hl
			ld		de,PROYECTILES
			or		a
			sbc		hl,de
			pop		de
			jr		c,.MIRA_BLINDAJE_NACIMIENTO_ENEMIGO
			pop		af
			or		a
			ret

.MIRA_BLINDAJE_NACIMIENTO_ENEMIGO:

			call	PUNTERO_BLINDAJE_NACIMIENTO_ENEMIGO
			ld		a,(hl)
			or		a
			jr		nz,.ENEMIGO_SI_BLINDADO_NACIMIENTO
			pop		af
			or		a
			ret

.ENEMIGO_SI_BLINDADO_NACIMIENTO:

			pop		af
			scf
			ret

NUEVO_PROYECTIL_NORMAL_SI_NO_BLINDADO:

			call	ENEMIGO_EN_BLINDAJE_NACIMIENTO
			ret		c
			jp		NUEVO_PROYECTIL_NORMAL

NUEVO_TRIPLE_PROYECTIL_MEGADEATH:

			ld		a,(ix)
			dec		a
			ld		(ix),a
			ld		a,253
			ld		(MEGADEATH_OFFSET_DISPARO),a
			ld		a,1
			ld		(MEGADEATH_PROYECTIL_SUBE),a
			call	NUEVO_PROYECTIL_NORMAL_SI_NO_BLINDADO

			ld		a,(ix)
			inc		a
			ld		(ix),a
			xor		a
			ld		(MEGADEATH_OFFSET_DISPARO),a
			inc		a
			ld		(MEGADEATH_PROYECTIL_SUBE),a
			call	NUEVO_PROYECTIL_NORMAL_SI_NO_BLINDADO

			ld		a,(ix)
			inc		a
			ld		(ix),a
			ld		a,3
			ld		(MEGADEATH_OFFSET_DISPARO),a
			ld		a,1
			ld		(MEGADEATH_PROYECTIL_SUBE),a
			call	NUEVO_PROYECTIL_NORMAL_SI_NO_BLINDADO

			ld		a,(ix)
			dec		a
			ld		(ix),a
			xor		a
			ld		(MEGADEATH_OFFSET_DISPARO),a
			ld		(MEGADEATH_PROYECTIL_SUBE),a
			ret

SECUENCIA_PROYECTIL_MEGADEATH_SUBE:

			ld		a,(ix+1)
			dec		a
			ld		(ix+1),a
			ld		a,(ix+13)
			dec		a
			ld		(ix+13),a
			jp		nz,TROZOS_COMUNES_28
			ld		a,17
			ld		(ix+6),a
			jp		TROZOS_COMUNES_28

PUNTERO_BLINDAJE_NACIMIENTO_ENEMIGO:

			push	de
			push	bc
			push	ix
			pop		hl
			ld		de,ENEMIGOS
			or		a
			sbc		hl,de
			srl		h
			rr		l
			srl		h
			rr		l
			srl		h
			rr		l
			srl		h
			rr		l
			ld		de,ENEMIGOS_BLINDA_NACIMIENTO
			add		hl,de
			pop		bc
			pop		de
			ret

BLOQUEA_LECTURA_TILES_CAMBIO_PAGE_FASE3:

			ld		a,(FASE)
			cp		3
			jr		nz,.NO_BLOQUEA_LECTURA_TILES_FASE3

			ld		a,(TRAMO_FASE_3)
			or		a
			jr		z,.MIRA_FINAL_TRAMO_FASE3
			cp		1
			jr		z,.MIRA_INICIO_Y_FINAL_TRAMO_FASE3
			cp		2
			jr		z,.MIRA_INICIO_TRAMO_FASE3
			jr		.NO_BLOQUEA_LECTURA_TILES_FASE3

.MIRA_INICIO_Y_FINAL_TRAMO_FASE3:

			call	.MIRA_INICIO_TRAMO_FASE3
			ret		c

.MIRA_FINAL_TRAMO_FASE3:

			ld		hl,(LINEA_A_LEER)
			ld		a,h
			or		a
			jr		nz,.NO_BLOQUEA_LECTURA_TILES_FASE3
			ld		a,l
			cp		16
			jr		c,.SI_BLOQUEA_LECTURA_TILES_FASE3
			jr		.NO_BLOQUEA_LECTURA_TILES_FASE3

.MIRA_INICIO_TRAMO_FASE3:

			ld		hl,(LINEA_A_LEER)
			ld		de,453
			or		a
			sbc		hl,de
			jr		nc,.SI_BLOQUEA_LECTURA_TILES_FASE3

.NO_BLOQUEA_LECTURA_TILES_FASE3:

			or		a
			ret

.SI_BLOQUEA_LECTURA_TILES_FASE3:

			scf
			ret


SUMA_RETENCION_Y_DEPH_POST_RECTIFICA_UP:

			ld		a,2
			ld		(RETENCION_Y_DEPH_POST_RECTIFICA_UP),a
			ret


CONTROL_RETENCION_Y_DEPH_POST_RECTIFICA_UP:

			ld		a,(RETENCION_Y_DEPH_POST_RECTIFICA_UP)
			or		a
			ret		z
			cp		1
			jr		z,.LIBERA_RETENCION_Y_DEPH_POST_RECTIFICA

			ld		a,(Y_DEPH)
			cp		215
			jr		z,.RETENER_Y_DEPH_POST_RECTIFICA
			cp		199
			jr		z,.RETENER_Y_DEPH_POST_RECTIFICA

.LIBERA_RETENCION_Y_DEPH_POST_RECTIFICA:

			xor		a
			ld		(RETENCION_Y_DEPH_POST_RECTIFICA_UP),a
			or		a
			ret

.RETENER_Y_DEPH_POST_RECTIFICA:

			ld		a,1
			ld		(RETENCION_Y_DEPH_POST_RECTIFICA_UP),a
			scf
			ret


CONTROL_RECTIFICA_Y_DEPH_SCROLL_SECTOR_10:

			ld		a,(SPRITE_CAIDO)
			or		a
			jp		nz,BUCLE_PINTA_TILES.RECTIFICA_CONTROL_Y

			call	CONTROL_RETENCION_Y_DEPH_POST_RECTIFICA_UP
			jp		c,BUCLE_PINTA_TILES.SIGUE

			call	ES_FASE3_VAGON_ACTIVO
			call	c,CORRIGE_Y_DEPH_SOLO_FASE3_VAGON.GUARDA_INDICE_16_PRE_CORRIGE_Y

			ld		a,(Y_DEPH)
			dec		a
			ld		(Y_DEPH),a

			cp		216
			jr		z,.RECTIFICA_UP_SCROLL_SECTOR_10

			cp		200
			jp		nz,BUCLE_PINTA_TILES.SIGUE

.RECTIFICA_UP_SCROLL_SECTOR_10:

			dec		a
			ld		(Y_DEPH),a

			call	SUMA_RETENCION_Y_DEPH_POST_RECTIFICA_UP
			jp		BUCLE_PINTA_TILES.SIGUE


PINTA_SPRITE_DEPH_SOLO_ATRIBUTOS_VAGON_SECTOR_10:

		push	ix

		ld		ix,ATRIBUTOS_DEPH_VARIABLES

		ld		a,(INMUNE)
[3]		srl		a
		and		00000001B
		or		a
		jp		z,.PINTA_SPRITE_NORMAL_VAGON

.PINTA_SPRITE_TRANSPARENTE_VAGON:

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		add		23
		jp		.MISMOS_DATOS_VAGON

.PINTA_SPRITE_NORMAL_VAGON:

		ld		a,(Y_DEPH)

.MISMOS_DATOS_VAGON:

		push	af
		add		16
		push	af
		ld		a,(X_DEPH)
		push	af
		add		16

.COMUN_DE_PINTAR_VAGON:

		ld		(ix+9),a
		ld		(ix+13),a
		ld		(ix+29),a
		ld		(ix+33),a
		ld		(ix+37),a

		pop		af
		ld		(ix+1),a
		ld		(ix+5),a
		ld		(ix+17),a
		ld		(ix+21),a
		ld		(ix+25),a

		pop		af
		ld		(ix+16),a
		ld		(ix+20),a
		ld		(ix+24),a
		ld		(ix+28),a
		ld		(ix+32),a
		ld		(ix+36),a

		pop		af
		ld		(ix),a
		ld		(ix+4),a
		ld		(ix+8),a
		ld		(ix+12),a

		ld		a,(FOTOGRAMA_DEPH)
		ld		de,4
		ld		b,6

.PATRONES_VAGON:

		ld		(ix+18),a
		add		4
		add		ix,de
		djnz	.PATRONES_VAGON

		pop		ix

		ld		hl,ATRIBUTOS_DEPH_VARIABLES
		ld		de,#4A00
		ld		bc,40
		jp		PON_COLOR_2.sin_bc_impuesta


PINTA_SPRITE_VAGONETA_TOTAL_SECTOR_10:

		push	ix

		ld		ix,ATRIBUTOS_VAGONETA_VARIABLES

		ld		a,(INMUNE)
[3]		srl		a
		and		00000001B
		or		a
		jp		z,.PINTA_SPRITE_NORMAL_VAGONETA_TOTAL

.PINTA_SPRITE_TRANSPARENTE_VAGONETA_TOTAL:

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		add		23
		jp		.MISMOS_DATOS_VAGONETA_TOTAL

.PINTA_SPRITE_NORMAL_VAGONETA_TOTAL:

		ld		a,(Y_DEPH)

.MISMOS_DATOS_VAGONETA_TOTAL:

		ld		h,a
		ld		a,(X_DEPH)
		sub		5
		ld		l,a

		ld		b,h
		ld		c,l
		ld		a,4
		call	PONE_DOS_MASCARAS_VAGONETA_TOTAL

		ld		b,h
		ld		a,l
		add		16
		ld		c,a
		ld		a,12
		call	PONE_DOS_MASCARAS_VAGONETA_TOTAL

		ld		a,h
		add		16
		ld		b,a
		ld		c,l
		ld		a,20
		call	PONE_DOS_MASCARAS_VAGONETA_TOTAL

		ld		a,h
		add		16
		ld		b,a
		ld		a,l
		add		16
		ld		c,a
		ld		a,28
		call	PONE_DOS_MASCARAS_VAGONETA_TOTAL

		pop		ix

		ld		hl,ATRIBUTOS_VAGONETA_VARIABLES
		ld		de,#4A00
		ld		bc,32
		jp		PON_COLOR_2.sin_bc_impuesta


PONE_DOS_MASCARAS_VAGONETA_TOTAL:

		ld		d,2

.BUCLE:

		ld		(ix),b
		ld		(ix+1),c
		ld		(ix+2),a
		ld		(ix+3),0
		push	de
		ld		de,4
		add		ix,de
		pop		de
		add		4
		dec		d
		jr		nz,.BUCLE
		ret

CONTROL_TILES_PUPA:

			call	ES_FASE3_VAGON_ACTIVO
			jp		c,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

			ld		a,(FASE)
			cp		1
			jp		z,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			cp		4
			jp		z,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS			
			cp		5
			jp		nz,.CONTROL_TILES_PUPA_1

			ld		a,(TILE_CENTRO)
			cp		80
			jp		nc,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			ld		a,(TILE_CENTRO_2)
			cp		80
			jp		nc,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.CONTROL_TILES_PUPA_1:

			ld		a,(DESACTIVA_PUPA)
			or		a
			jp		nz,CONTROL

			ld		a,(TILE_CENTRO)
			cp		48
			jp		c,.CONTROL_TILES_PUPA_2
			cp		80
			jp		nc,.CONTROL_TILES_PUPA_2
			cp		59
			jp		c,.HACEMOS_PUPA
			cp		63
			jp		c,.CONTROL_TILES_PUPA_2

.CONTROL_TILES_PUPA_2:

			ld		a,(TILE_CENTRO_2)
			cp		48
			jp		c,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			cp		96
			jp		nc,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			cp		59
			jp		c,.HACEMOS_PUPA
			cp		63
			jp		c,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.HACEMOS_PUPA:			

			push	af
			call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH.DANO_DE_PUPA
			pop		af

.QUE_CORRIGE:

       		cp		54
			jp		z,.X_LEFT
			cp		55
			jp		z,.Y_DOWN
			cp		56
			jp		z,.X_RIGHT
			cp		57
			jp		z,.Y_UP
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.Y_DOWN:

			ld		a,(Y_DEPH)
			add		2
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			add		2
			ld		(CONTROL_Y),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.Y_UP:

			ld		a,(Y_DEPH)
			sub		2
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			sub		2
			ld		(CONTROL_Y),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.X_RIGHT:

			ld		a,(X_DEPH)
			add		2
			ld		(X_DEPH),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS


.X_LEFT:

			ld		a,(X_DEPH)
			sub		2
			ld		(X_DEPH),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

MIRAMOS_SI_HAY_AGUJERO:

			ld		a,(SUMA_CAMINO)
			or		a
			jp		nz,CONTROL_TILES_PUPA

PRIMERO_MIRAMOS_SI_ES_FASE_4_Y_RELENTIZA_EL_SUELO:

			ld		a,(FASE)
			cp		4
			jp		nz,ESTADO_NORMAL

			ld		a,(TILE_CENTRO)
			cp		48
			jp		c,ESTADO_NORMAL
			cp		68
			jp		nc,ESTADO_NORMAL

			ld		a,(VARIABLE_CARGA_AGUA)
			or		a
			jp		nz,.SOLO_RALENTIZAR

			ld		a,1
			ld		(VARIABLE_CARGA_AGUA),a

			call	CARGA_PIES_EN_LODO



.SOLO_RALENTIZAR:
			
			ld		a,(LENTO)
			inc		a
			and		00000001b
			ld		(LENTO),a
			jp		AHORA_SI_EL_AGUJERO

ESTADO_NORMAL:

			xor		a
			ld		(LENTO),a
			ld		a,(VARIABLE_CARGA_AGUA)
			or		a
			jp		z,AHORA_SI_EL_AGUJERO
			xor		a
			ld		(VARIABLE_CARGA_AGUA),a
		call	CARGA_1_A_25_TRAS_PAUSA
AHORA_SI_EL_AGUJERO:

			ld		hl,(TIME_PARALIZA)
			ld		de,0
			call	DCOMPR_RAM
			jp		nz,DEPH_PARALIZADO_2.CONTROL_TIME_PARALIZA_1

.tile_agujero_1:

			ld		a,(TILE_CENTRO)
			cp		61
			jp		nz,.tile_agujero_2
			
			call	.control_de_y_a_menos
			
			call	.x_divide_16

			add		8	
	 		jp		.paralizamos_a_deph

.tile_agujero_2:

			ld		a,(TILE_CENTRO)
			cp		62
			jp		nz,.tile_agujero_3
			
			call	.control_de_y_a_menos
			
			call	.x_divide_16

			sub		8	
	 		jp		.paralizamos_a_deph

.tile_agujero_3:

			ld		a,(TILE_CENTRO)
			cp		59
			jp		nz,.tile_agujero_4
			
			call	.control_de_y_a_mas
			
			call	.x_divide_16

			add		8	
	 		jp		.paralizamos_a_deph

.tile_agujero_4:

			ld		a,(TILE_CENTRO)
			cp		60
			jp		nz,CONTROL_TILES_PUPA
			
			call	.control_de_y_a_mas
			
			call	.x_divide_16

			sub		8	
	 		jp		.paralizamos_a_deph

.y_divide_16:

			ld		a,(Y_DEPH)
			
			jp		.B11110000

.x_divide_16:

			ld		a,(X_DEPH)

.B11110000:

			and		11110000b
			ret

.control_de_y_a_menos:

			call	.y_divide_16
			call	.control_comun_de_y
			ld		(CONTROL_Y),a
			ret

.control_de_y_a_mas:

			call	.y_divide_16
			add		16
			call	.control_comun_de_y
			add		16
			ld		(CONTROL_Y),a
			ret

.control_comun_de_y:

			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			and		11110000b
			ret

.paralizamos_a_deph:

			ld		(X_DEPH),a
			ld		hl,220
			ld		(TIME_PARALIZA),hl
			xor		a
			ld		(AGU_ACTIVO),a
			inc		a
			ld		(PARALIZAMOS),a
			ld		(SPRITE_CAIDO),a

			jp		CONTROL.RECUPERANDO_SPRITES_DEPH

DEPH_PARALIZADO_2:

			call	PINTA_SPRITE_DEPH_VAGON_AJUSTADO

			jp		CONTROL_TILES_PUPA

.CONTROL_TIME_PARALIZA_1:

			ld		de,1
			or		a
			sbc		hl,de
			ld		(TIME_PARALIZA),hl
			ld		de,30
			call	DCOMPR_RAM
			jp		c,.CONTROL_TIME_PARALIZA_2
			
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.CONTROL_TIME_PARALIZA_2:

			ld		de,0
			call	DCOMPR_RAM
			jp		z,CONTROL_TILES_PUPA

			xor		a
			ld		(PARALIZAMOS),a
			inc		a
			ld		(AGU_ACTIVO),a

			jp		CONTROL_TILES_PUPA

.CONTROL_DE_BLOQUEOS:

			ld		a,(PAUSA_BLOQUEADA)
			cp		5
			jp		z,.CONTROL_Y_BLOQUEOS
			or		a
			jp		z,CONTROL
			dec		a
			ld		(PAUSA_BLOQUEADA),a			
			jp		CONTROL

.CONTROL_Y_BLOQUEOS:

			dec		a
			ld		(PAUSA_BLOQUEADA),a
			xor		a
			ld		(AVANCE_BLOQUEADO),a
			jp		CONTROL

.resta_comun_x:

			ld		a,(TILE_O)
			cp		79
			ret		nc

			ld		a,(X_DEPH)
			cp		0
			ret		z
					
			ld		a,(X_DEPH)
			dec		a
			ld		(X_DEPH),a
			
			ret

.suma_comun_x:

			ld		a,(TILE_E)
			cp		79
			ret		nc

			ld		a,(X_DEPH)
			cp		235
			ret		z
			
			ld		a,(X_DEPH)
			inc		a
			ld		(X_DEPH),a
			
			ret


CONTROL_FASE3_TILE_145_SECTOR_10:

			ld		b,a

			call	ES_FASE3_VAGON_ACTIVO
			jr		c,.TILE_PISABLE_FORZADO

			ld		a,(FASE)
			cp		3
			jr		nz,.mira_si_pisable
			ld		a,d
			ld		(VARIABLE_UN_USO2),a
			ld		a,b
			cp		16
			jr		c,.mira_si_pisable
			cp		22
			jr		nc,.mira_si_pisable
			call	PUEDE_ENTRAR_VAGON_POR_Y
			jr		nc,.mira_si_pisable
			call	PINTA_TRIADA_ENTRADA_FASE3_VAGON
			xor		a
			ld		(FASE3_VAGON_CORRIGE_Y_CADENCIA),a
			dec		a
			ld		(FASE3_VAGON_INDICE_16_PRE_Y),a
			call	CONTROL_VELOCIDAD_FASE_VAGON
			or		a
			ret

.TILE_PISABLE_FORZADO:

			scf
			ret

.mira_si_pisable:

			ld		a,b
			cp		79
			ret

PUEDE_ENTRAR_VAGON_POR_Y:

			push	af
			push	bc
			push	de
			push	hl
			ld		a,(Y_DEPH)
			sub		16
			ld		b,a
			ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
			ld		c,a
			ld		a,b
			sub		c
			cp		64
			jr		c,.NO_PUEDE_ENTRAR_VAGON_POR_Y

.SI_PUEDE_ENTRAR_VAGON_POR_Y:

			pop		hl
			pop		de
			pop		bc
			pop		af
			scf
			ret

.NO_PUEDE_ENTRAR_VAGON_POR_Y:

			pop		hl
			pop		de
			pop		bc
			pop		af
			or		a
			ret


PINTA_TRIADA_ENTRADA_FASE3_VAGON:

			ld		e,b
			cp		19
			jr		nc,.GRUPO_DERECHA

			xor		a
			ld		(FASE3_VAGON_TIPO_MUERTE),a
			ld		a,121
			jr		.CALCULA_DESTINO

.GRUPO_DERECHA:

			ld		a,1
			ld		(FASE3_VAGON_TIPO_MUERTE),a
			ld		a,127

.CALCULA_DESTINO:

			push	af
			call	CALCULA_XY_TILE_FASE3_VAGON_ENTRADA
			call	.COLOCA_X_DEPH_ENTRADA_VAGON
			ld		a,e
			cp		17
			jr		z,.RESTA_UN_TILE
			cp		20
			jr		z,.RESTA_UN_TILE
			cp		18
			jr		z,.RESTA_DOS_TILES
			cp		21
			jr		z,.RESTA_DOS_TILES
			jr		.PINTA

.RESTA_UN_TILE:

			ld		a,b
			sub		16
			ld		b,a
			jr		.PINTA

.RESTA_DOS_TILES:

			ld		a,b
			sub		32
			ld		b,a

.PINTA:

			pop		af
			jp		PINTA_TRIADA_FASE3_VAGON

.COLOCA_X_DEPH_ENTRADA_VAGON:

			ld		a,(Y_DEPH)
			sub		16
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			sub		16
			ld		(CONTROL_Y),a

COLOCA_X_DEPH_ENTRADA_VAGON_SIN_Y:

			ld		a,e
			cp		17
			jr		z,.COLOCA_X_TILE_MENOS_8
			cp		20
			jr		z,.COLOCA_X_TILE_MENOS_8
			cp		18
			jr		z,.COLOCA_X_TILE_MENOS_24
			cp		21
			jr		z,.COLOCA_X_TILE_MENOS_24

			ld		a,b
			add		a,12
			ld		(X_DEPH),a
			ret

.COLOCA_X_TILE_MENOS_8:

			ld		a,b
			sub		4
			ld		(X_DEPH),a
			ret

.COLOCA_X_TILE_MENOS_24:

			ld		a,b
			sub		20
			ld		(X_DEPH),a
			ret

PINTA_TRIADA_SALIDA_FASE3_VAGON:

			ld		e,a
			ld		a,22

.CALCULA_DESTINO:

			push	af
			call	CALCULA_XY_TILE_FASE3_VAGON
			ld		a,c
			sub		20
			ld		d,a
			ld		a,(TILE_FASE3_VAGON_X16)
			add		a,d
			add		16
			ld		c,a
			ld		a,e
			cp		9
			jr		z,.RESTA_UN_TILE
			cp		10
			jr		z,.RESTA_DOS_TILES
			jr		.PINTA

.RESTA_UN_TILE:

			ld		a,b
			sub		16
			ld		b,a
			jr		.PINTA

.RESTA_DOS_TILES:

			ld		a,b
			sub		32
			ld		b,a

.PINTA:

			pop		af
			jp		PINTA_TRIADA_FASE3_VAGON

CALCULA_XY_TILE_FASE3_VAGON:

			ld		a,(X_DEPH)
			add		6
			and		#f0
			ld		b,a
			ld		a,(Y_DEPH)
			add		20
			and		#f0
			ld		c,a
			ret

CALCULA_XY_TILE_FASE3_VAGON_ENTRADA:

			ld		a,(X_DEPH)
			add		a,c
			and		#f0
			ld		b,a
			ld		a,(Y_DEPH)
			ld		d,a
			ld		a,(VARIABLE_UN_USO2)
			add		a,16
			add		a,d
			and		#f0
			ld		c,a
			ret

PINTA_TRIADA_FASE3_VAGON:

			call	PINTA_TILE_FASE3_VAGON_PAGE2
			inc		a
			push	af
			ld		a,b
			add		16
			ld		b,a
			pop		af
			call	PINTA_TILE_FASE3_VAGON_PAGE2
			inc		a
			push	af
			ld		a,b
			add		16
			ld		b,a
			pop		af
			jp		PINTA_TILE_FASE3_VAGON_PAGE2

PINTA_TILE_FASE3_VAGON_PAGE2:

			ld		e,a
			ld		d,0
			push	af
			push	bc
			push	de
			push	hl
			push	ix
			push	iy

			ld		ix,DATOS_DEL_TILE_PARA_COPY
			ld		iy,TABLA_RELACION_PARA_COPY

			push	de
			pop		hl
			or		a
			adc		hl,de
			ex		de,hl
			add		iy,de

			ld		a,(iy)
			ld		(ix),a
			xor		a
			ld		(ix+1),a
			ld		a,(iy+1)
			ld		(ix+2),a
			ld		a,1
			ld		(ix+3),a
			ld		a,b
			ld		(ix+4),a
			xor		a
			ld		(ix+5),a
			ld		a,c
			ld		(ix+6),a
			ld		a,2
			ld		(ix+7),a
			ld		a,16
			ld		(ix+8),a
			ld		(ix+10),a
			xor		a
			ld		(ix+9),a
			ld		(ix+11),a
			ld		(ix+12),a
			ld		(ix+13),a
			ld		a,11010000B
			ld		(ix+14),a

			call	HL_DATOS_DEL_COPY

			pop		iy
			pop		ix
			pop		hl
			pop		de
			pop		bc
			pop		af
			ret

CONTROL_TILES_ESPECIALES_DEPH_COOLDOWN:

			ld		a,(TILE_ESPECIAL_DEPH_COOLDOWN)
			or		a
			ret		z
			dec		a
			ld		(TILE_ESPECIAL_DEPH_COOLDOWN),a
			or		a
			ret		nz
			ld		(TILE_ESPECIAL_DEPH_BLOQUEOS),a
			ret

CONTROL_TILES_ESPECIALES_DEPH:

			ld		a,(TILE_N)
			ld		b,6
			ld		c,0
			call	.CONTROLA_TILE_ESPECIAL_DEPH
			ret		c

			ld		a,(TILE_N2)
			ld		b,14
			ld		c,0
			call	.CONTROLA_TILE_ESPECIAL_DEPH
			ret		c

			ld		a,(TILE_S)
			ld		b,6
			ld		c,16
			call	.CONTROLA_TILE_ESPECIAL_DEPH
			ret		c

			ld		a,(TILE_S2)
			ld		b,14
			ld		c,16
			call	.CONTROLA_TILE_ESPECIAL_DEPH
			ret

.CONTROLA_TILE_ESPECIAL_DEPH:

			call	.BUSCA_TILE_ESPECIAL_DEPH
			ret		nc
			call	.EFECTO_TILE_ESPECIAL_BLOQUEADO
			ret		c
			push	af
			push	de
			call	.CALCULA_XY_TILE_ESPECIAL_DEPH
			pop		de
			pop		af
			push	af
			push	bc
			push	de
			ld		a,e
			call	.EJECUTA_EFECTO_TILE_ESPECIAL_DEPH
			pop		de
			pop		bc
			pop		af
			push	af
			push	bc
			ld		a,e
			call	.BLOQUEA_EFECTO_TILE_ESPECIAL
			pop		bc
			pop		af
			call	PINTA_TILE_FASE3_VAGON_PAGE2
			ld		a,255
			ld		(TILE_ESPECIAL_DEPH_COOLDOWN),a
			scf
			ret

.EFECTO_TILE_ESPECIAL_BLOQUEADO:

			push	af
			push	bc
			push	de
			ld		a,e
			call	.MASCARA_EFECTO_TILE_ESPECIAL
			ld		b,a
			ld		a,(TILE_ESPECIAL_DEPH_BLOQUEOS)
			and		b
			jr		nz,.EFECTO_TILE_ESPECIAL_SI_BLOQUEADO
			pop		de
			pop		bc
			pop		af
			or		a
			ret

.EFECTO_TILE_ESPECIAL_SI_BLOQUEADO:

			pop		de
			pop		bc
			pop		af
			scf
			ret

.BLOQUEA_EFECTO_TILE_ESPECIAL:

			call	.MASCARA_EFECTO_TILE_ESPECIAL
			ld		b,a
			ld		a,(TILE_ESPECIAL_DEPH_BLOQUEOS)
			or		b
			ld		(TILE_ESPECIAL_DEPH_BLOQUEOS),a
			ret

.MASCARA_EFECTO_TILE_ESPECIAL:

			ld		b,a
			ld		a,1
			ld		c,b
			ld		b,c
			ld		c,a
			ld		a,b
			or		a
			ld		a,c
			ret		z

.BUCLE_MASCARA_EFECTO_TILE_ESPECIAL:

			sla		a
			djnz	.BUCLE_MASCARA_EFECTO_TILE_ESPECIAL
			ret

.CALCULA_XY_TILE_ESPECIAL_DEPH:

			push	af
			ld		a,(X_DEPH)
			add		a,b
			and		#f0
			ld		b,a
			ld		a,(Y_PINTA_SCROLL)
			and		#0f
			ld		e,a
			ld		a,(Y_DEPH)
			add		a,c
			sub		e
			and		#f0
			add		a,e
			add		16
			ld		c,a
			pop		af
			ret

.BUSCA_TILE_ESPECIAL_DEPH:

			ld		h,a
			ld		a,(FASE)
			cp		1
			jp		z,.BUSCA_TILE_ESPECIAL_FASE_1
			cp		2
			jp		z,.BUSCA_TILE_ESPECIAL_FASE_2
			cp		3
			jp		z,.BUSCA_TILE_ESPECIAL_FASE_3
			cp		4
			jp		z,.BUSCA_TILE_ESPECIAL_FASE_4
			cp		5
			jp		z,.BUSCA_TILE_ESPECIAL_FASE_5
			or		a
			ret

.BUSCA_TILE_ESPECIAL_FASE_1:

			ld		a,h
			cp		37
			jr		z,.TILE_F1_37
			cp		39
			jr		z,.TILE_F1_39
			cp		42
			jr		z,.TILE_F1_42
			cp		46
			jr		z,.TILE_F1_46
			cp		47
			jr		z,.TILE_F1_47
			or		a
			ret

.TILE_F1_37:
			ld		a,33
			ld		e,1
			scf
			ret
.TILE_F1_39:
			ld		a,33
			ld		e,2
			scf
			ret
.TILE_F1_42:
			ld		a,33
			ld		e,3
			scf
			ret
.TILE_F1_46:
			ld		a,13
			ld		e,4
			scf
			ret
.TILE_F1_47:
			ld		a,33
			ld		e,5
			scf
			ret

.BUSCA_TILE_ESPECIAL_FASE_2:

			ld		a,h
			cp		6
			jr		z,.TILE_F2_6
			cp		7
			jr		z,.TILE_F2_7
			cp		8
			jr		z,.TILE_F2_8
			cp		9
			jr		z,.TILE_F2_9
			cp		12
			jr		z,.TILE_F2_12
			cp		13
			jr		z,.TILE_F2_13
			or		a
			ret

.TILE_F2_6:
			ld		e,0
			jr		.TILE_F2_COMUN
.TILE_F2_7:
			ld		e,1
			jr		.TILE_F2_COMUN
.TILE_F2_8:
			ld		e,2
			jr		.TILE_F2_COMUN
.TILE_F2_9:
			ld		e,3
			jr		.TILE_F2_COMUN
.TILE_F2_12:
			ld		e,4
			jr		.TILE_F2_COMUN
.TILE_F2_13:
			ld		e,5
.TILE_F2_COMUN:
			ld		a,19
			scf
			ret

.BUSCA_TILE_ESPECIAL_FASE_3:

			ld		a,h
			cp		28
			jr		z,.TILE_F3_28
			cp		29
			jr		z,.TILE_F3_29
			cp		30
			jr		z,.TILE_F3_30
			cp		31
			jr		z,.TILE_F3_31
			cp		15
			jr		z,.TILE_F3_15
			or		a
			ret

.TILE_F3_28:
			ld		e,2
			jr		.TILE_F3_COMUN
.TILE_F3_29:
			ld		e,3
			jr		.TILE_F3_COMUN
.TILE_F3_30:
			ld		e,4
			jr		.TILE_F3_COMUN
.TILE_F3_31:
			ld		e,5
			jr		.TILE_F3_COMUN
.TILE_F3_15:
			ld		e,6
.TILE_F3_COMUN:
			xor		a
			scf
			ret

.BUSCA_TILE_ESPECIAL_FASE_4:

			ld		a,h
			cp		19
			jr		z,.TILE_F4_19
			cp		20
			jr		z,.TILE_F4_20
			cp		23
			jr		z,.TILE_F4_23
			cp		35
			jr		z,.TILE_F4_35
			cp		36
			jr		z,.TILE_F4_36
			or		a
			ret

.TILE_F4_19:
			ld		a,4
			ld		e,1
			scf
			ret
.TILE_F4_20:
			ld		a,4
			ld		e,2
			scf
			ret
.TILE_F4_23:
			ld		a,66
			ld		e,3
			scf
			ret
.TILE_F4_35:
			ld		a,3
			ld		e,4
			scf
			ret
.TILE_F4_36:
			ld		a,3
			ld		e,5
			scf
			ret

.BUSCA_TILE_ESPECIAL_FASE_5:

			ld		a,h
			cp		31
			jr		z,.TILE_F5_31
			cp		43
			jr		z,.TILE_F5_43
			cp		45
			jr		z,.TILE_F5_45
			cp		57
			jr		z,.TILE_F5_57
			cp		58
			jr		z,.TILE_F5_58
			cp		63
			jr		z,.TILE_F5_63
			or		a
			ret

.TILE_F5_31:
			xor		a
			ld		e,0
			scf
			ret
.TILE_F5_43:
			xor		a
			ld		e,1
			scf
			ret
.TILE_F5_45:
			ld		a,4
			ld		e,2
			scf
			ret
.TILE_F5_57:
			xor		a
			ld		e,3
			scf
			ret
.TILE_F5_58:
			ld		a,4
			ld		e,4
			scf
			ret
.TILE_F5_63:
			ld		a,4
			ld		e,5
			scf
			ret

.EJECUTA_EFECTO_TILE_ESPECIAL_DEPH:

			cp		0
			jp		z,.EFECTO_TILE_CORAZON_MAX
			cp		1
			jp		z,.EFECTO_TILE_CORAZON
			cp		6
			jp		z,.EFECTO_TILE_VIDA
			sub		2
			jp		.EFECTO_TILE_LETRA

.FX_15_TILE_ESPECIAL:

			ld		a,15
			ld		c,0
			jp		A_31_DESDE_10

.FX_16_TILE_ESPECIAL:

			ld		a,16
			ld		c,0
			jp		A_31_DESDE_10

.EFECTO_TILE_CORAZON_MAX:

			ld		a,(CORAZONES_MAXIMOS)
			cp		5
			jr		nc,.CORAZON_MAX_YA_AL_MAXIMO
			inc		a
			ld		(CORAZONES_MAXIMOS),a
			ld		(CORAZONES),a
			call	PINTA_CORAZONES
			jp		.FX_15_TILE_ESPECIAL

.CORAZON_MAX_YA_AL_MAXIMO:

			ld		(CORAZONES),a
			call	PINTA_CORAZONES
			jp		.FX_16_TILE_ESPECIAL

.EFECTO_TILE_CORAZON:

			ld		a,(CORAZONES_MAXIMOS)
			ld		b,a
			ld		a,(CORAZONES)
			cp		b
			jp		nc,.FX_16_TILE_ESPECIAL
			inc		a
			ld		(CORAZONES),a
			call	PINTA_CORAZONES
			jp		.FX_15_TILE_ESPECIAL

.EFECTO_TILE_VIDA:

			ld		a,(VIDAS)
			cp		5
			jp		nc,.FX_16_TILE_ESPECIAL
			inc		a
			ld		(VIDAS),a
			call	PINTA_VIDAS
			jp		.FX_15_TILE_ESPECIAL

.EFECTO_TILE_LETRA:

			ld		c,a
			ld		a,(FASE)
			dec		a
			add		a
			add		a
			add		c
			ld		b,a
			srl		a
			srl		a
			srl		a
			ld		e,a
			ld		d,0
			ld		hl,LETRAS_FASES_BITS
			add		hl,de
			ld		a,b
			and		00000111b
			ld		b,a
			ld		c,1

.BUCLE_MASK_LETRA_TILE:

			ld		a,b
			or		a
			jr		z,.GUARDA_LETRA_TILE
			sla		c
			dec		b
			jr		.BUCLE_MASK_LETRA_TILE

.GUARDA_LETRA_TILE:

			ld		a,(hl)
			or		c
			ld		(hl),a
			jp		.FX_15_TILE_ESPECIAL


CONTROL_ACCIONES_VAGON_FASE3:

			call	ES_FASE3_VAGON_ACTIVO
			jp		c,.VAGON_ACTIVA_SUCESOS

			jp		CONTROL.PULSA_M

.VAGON_ACTIVA_SUCESOS:

			ld		a,1
			ld		(ACTIVA_SUCESOS),a
			jp		CONTROL.FIN_RUTINA_GLOBAL


SE_PUEDE_MOVER_Y_EFES_VARIOS:

			ld		a,(PARALIZAMOS)
			or		a
			jp		nz,CONTROL.pre_sigue_comun	

			call	CORRIGE_Y_DEPH_SOLO_FASE3_VAGON

			ld		a,6	
			call	SNSMAT_RAM  
			bit		5,a											; Si pulsa f1 pausamos
			jp		z,.PAUSE_VAGON		
			
			ld		a,7
			call	SNSMAT_RAM
			bit		1,a	
			jp		z,AGILIZA_MAPA									; Si pulsa f5 avanza 20 lineas en el mapa			
			xor		a
			ld		(MARCADOR_PULSADO),a
			ld		a,(SUMA_CAMINO)
			or		a
			jp		z,CONTROL.teclado
			call	RUTINA_ESPECIAL_FASE_3
			call	ES_FASE3_VAGON_ACTIVO
			jp		c,CONTROL.FIN_RUTINA_GLOBAL
			jp		CONTROL.pre_sigue_comun

.PAUSE_VAGON:

			ld		a,(SUMA_CAMINO)
			or		a
			jp		z,PAUSE

			call	MARCA_REAPLICA_VAGON_RET

			ld		a,(MARCADOR_PULSADO)
			or		a
			jp		nz,CONTROL.teclado

			ld		a,(PAUSA_BLOQUEADA)
			or		a
			jp		nz,CONTROL.teclado

			ld		a,8
			ld		c,0
			call	A_31_DESDE_10

			di
			call	hltmus
			ei
			call	GICINI
			call	CARGA_SPRITES_VAGONETA_PAUSA

			ld		a,1
			ld		(MARCADOR_PULSADO),a

			ld		a,(TIEMPO_DE_ADJUST)
			ld		(VARIABLE_UN_USO),a
			xor		a
			ld		(TIEMPO_DE_ADJUST),a

			call	LLAMA_PAUSE_VAGON_FASE_3
			call	APLICA_SPRITES_DEPH_VAGON

			ld		a,(VARIABLE_UN_USO)
			ld		(TIEMPO_DE_ADJUST),a

			call	MARCA_REAPLICA_VAGON_RET

			call	REANUDA_MUSICA_DESDE_SLOT1
			jp		CONTROL.teclado

RUTINA_ESPECIAL_FASE_3:

			ld		a,(FASE)
			cp		3
			ret		nz
			call	ES_FASE3_VAGON_ACTIVO
			ret		nc
			ld		a,(FASE3_VAGON_SALTO_PENDIENTE)
			cp		255
			jp		z,RESUELVE_SALTO_FASE3_VAGON
			call	CONTROL_SALTO_FASE3_VAGON
			ret		c
			call	CONTROL_FASE3_TILE_PUNTO_DEPH
			ret

CONTROL_SALTO_FASE3_VAGON:

			ld		a,(FASE3_VAGON_JUMP_ACTIVO)
			or		a
			ret		z

			call	.PULSA_DISPARO_FASE3_VAGON
			ret		nc
			call	.PULSA_DERECHA_SALTO_FASE3_VAGON
			jr		c,.SALTO_DERECHA
			call	.PULSA_IZQUIERDA_SALTO_FASE3_VAGON
			ret		nc
			ld		a,2
			jr		.GUARDA_DIRECCION

.SALTO_DERECHA:

			ld		a,1

.GUARDA_DIRECCION:

			ld		(VARIABLE_UN_USO2),a
			ld		a,(TILE_FASE3_VAGON)
			cp		118
			jr		c,.NO_SALTA_FASE3_VAGON
			cp		130
			ret		nc
			call	PINTA_TRIADA_SALTO_SALE_VAGON
			call	CARGA_DEPH_NORMAL_SALTO_FASE3_VAGON
			ld		a,20
			ld		(FOTOGRAMA_DEPH),a
			xor		a
			ld		(FOTOGRAMA_DEPH_EN_ORDEN),a
			call	PINTA_SPRITE_DEPH_SALTO_VAGONETA
			call	CARGA_COLORES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA
			call	CORRIGE_Y_DEPH_SOLO_FASE3_VAGON.GUARDA_INDICE_16_PRE_CORRIGE_Y
			ld		a,(Y_DEPH)
			sub		16
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			sub		16
			ld		(CONTROL_Y),a
			ld		a,35
			ld		c,0
			call	A_31_DESDE_10
			call	.EJECUTA_PARABOLA_FASE3_VAGON
			call	CORRIGE_Y_DEPH_SOLO_FASE3_VAGON.GUARDA_INDICE_16_PRE_CORRIGE_Y
			ld		a,255
			ld		(FASE3_VAGON_SALTO_PENDIENTE),a
			scf
			ret

.NO_SALTA_FASE3_VAGON:

			or		a
			ret

.PULSA_DISPARO_FASE3_VAGON:

			xor		a
			call	GTTRIG_RAM
			or		a
			jr		nz,.SI_PULSA_DISPARO
			ld		a,1
			call	GTTRIG_RAM
			or		a
			ret		z

.SI_PULSA_DISPARO:

			scf
			ret

.PULSA_DERECHA_SALTO_FASE3_VAGON:

			xor		a
			call	GTSTCK_RAM
			call	.ES_DERECHA_SALTO_FASE3_VAGON
			ret		c
			ld		a,1
			call	GTSTCK_RAM
			jp		.ES_DERECHA_SALTO_FASE3_VAGON

.PULSA_IZQUIERDA_SALTO_FASE3_VAGON:

			xor		a
			call	GTSTCK_RAM
			call	.ES_IZQUIERDA_SALTO_FASE3_VAGON
			ret		c
			ld		a,1
			call	GTSTCK_RAM
			jp		.ES_IZQUIERDA_SALTO_FASE3_VAGON

.ES_DERECHA_SALTO_FASE3_VAGON:

			cp		2
			jr		c,.NO_DERECHA
			cp		5
			jr		nc,.NO_DERECHA
			scf
			ret

.NO_DERECHA:

			or		a
			ret

.ES_IZQUIERDA_SALTO_FASE3_VAGON:

			cp		6
			jr		c,.NO_IZQUIERDA
			cp		9
			jr		nc,.NO_IZQUIERDA
			scf
			ret

.NO_IZQUIERDA:

			or		a
			ret

.EJECUTA_PARABOLA_FASE3_VAGON:

			ld		hl,TABLA_SALTO_FASE3_VAGON_X
			ld		de,TABLA_SALTO_FASE3_VAGON_Y
			ld		b,30

.BUCLE_PARABOLA:

			push	bc
			push	hl
			push	de
			ld		a,(hl)
			ld		c,a
			ld		a,(VARIABLE_UN_USO2)
			cp		1
			jr		z,.SUMA_X_PARABOLA

.RESTA_X_PARABOLA:

			ld		a,(X_DEPH)
			sub		c
			jr		nc,.GUARDA_X_PARABOLA
			xor		a
			jr		.GUARDA_X_PARABOLA

.SUMA_X_PARABOLA:

			ld		a,(X_DEPH)
			add		a,c
			cp		240
			jr		c,.GUARDA_X_PARABOLA
			ld		a,239

.GUARDA_X_PARABOLA:

			ld		(X_DEPH),a
			pop		de
			push	de
			ld		a,(de)
			ld		c,a
			ld		a,(Y_DEPH)
			add		a,c
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			add		a,c
			ld		(CONTROL_Y),a
			halt
			call	PINTA_SPRITE_DEPH_SALTO_VAGONETA
			call	CARGA_COLORES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA
			pop		de
			pop		hl
			inc		hl
			inc		de
			pop		bc
			djnz	.BUCLE_PARABOLA
			ret

CARGA_DEPH_NORMAL_SALTO_FASE3_VAGON:

			ld		hl,SPRITES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA_SECTOR_10
			ld		de,#4000+20*8
			ld		bc,4*32
			call	PON_COLOR_2.sin_bc_impuesta
			jp		CARGA_COLORES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA

CARGA_COLORES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA:

			ld		hl,COLOR_SPRITES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA_SECTOR_10
			ld		de,#4840
			ld		bc,4*16
			jp		PON_COLOR_2.sin_bc_impuesta

PINTA_SPRITE_DEPH_SALTO_VAGONETA:

			push	ix

			ld		ix,ATRIBUTOS_DEPH_VARIABLES

			ld		a,(INMUNE)
[3]			srl		a
			and		00000001B
			or		a
			jp		z,.PINTA_SPRITE_NORMAL_SALTO_VAGON

.PINTA_SPRITE_TRANSPARENTE_SALTO_VAGON:

			ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
			add		23
			jp		.MISMOS_DATOS_SALTO_VAGON

.PINTA_SPRITE_NORMAL_SALTO_VAGON:

			ld		a,(Y_DEPH)

.MISMOS_DATOS_SALTO_VAGON:

			push	af
			add		16
			push	af
			ld		a,(X_DEPH)
			push	af
			add		16

			ld		(ix+9),a
			ld		(ix+13),a
			ld		(ix+25),a
			ld		(ix+29),a

			pop		af
			ld		(ix+1),a
			ld		(ix+5),a
			ld		(ix+17),a
			ld		(ix+21),a

			pop		af
			ld		(ix+16),a
			ld		(ix+20),a
			ld		(ix+24),a
			ld		(ix+28),a
			ld		a,217
			ld		(ix+32),a
			ld		(ix+36),a

			pop		af
			ld		(ix),a
			ld		(ix+4),a
			ld		(ix+8),a
			ld		(ix+12),a

			ld		a,20
			ld		(ix+18),a
			add		4
			ld		(ix+22),a
			add		4
			ld		(ix+26),a
			add		4
			ld		(ix+30),a
			xor		a
			ld		(ix+34),a
			ld		(ix+38),a

			pop		ix

			ld		hl,ATRIBUTOS_DEPH_VARIABLES
			ld		de,#4A00
			ld		bc,40
			jp		PON_COLOR_2.sin_bc_impuesta

SPRITES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA_SECTOR_10:

			db		#00,#03,#01,#00,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00
			db		#1f,#bf,#fe,#e0,#e0,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00

			db		#03,#04,#03,#01,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00
			db		#bf,#7f,#f9,#de,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00

			db		#f8,#fd,#7f,#07,#07,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00
			db		#00,#c0,#80,#00,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00

			db		#f5,#fa,#ff,#7f,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00
			db		#c0,#20,#40,#80,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00

COLOR_SPRITES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA_SECTOR_10:

			db		#04,#04,#04,#04,#01,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00
			db		#41,#41,#41,#41,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00

			db		#04,#04,#04,#04,#01,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00
			db		#41,#41,#41,#41,#00,#00,#00,#00
			db		#00,#00,#00,#00,#00,#00,#00,#00

RESUELVE_SALTO_FASE3_VAGON:

			xor		a
			ld		(FASE3_VAGON_SALTO_PENDIENTE),a
			ld		a,(TILE_FASE3_VAGON)
			cp		16
			jr		c,.MIRA_MARGEN_Y_SALTO_FASE3_VAGON
			cp		22
			jr		nc,.MIRA_MARGEN_Y_SALTO_FASE3_VAGON
.ENTRA_SALTO_FASE3_VAGON:
			ld		b,a
			ld		c,6
			ld		a,(TILE_FASE3_VAGON_X16)
			ld		(VARIABLE_UN_USO2),a
			ld		a,b
			cp		19
			jr		c,.NO_PINTA_TRIADA_ENTRADA_SALTO
			cp		22
			jr		nc,.NO_PINTA_TRIADA_ENTRADA_SALTO
			call	PINTA_TRIADA_ENTRADA_FASE3_VAGON_SALTO

.NO_PINTA_TRIADA_ENTRADA_SALTO:

			ld		a,2
			ld		(SUMA_CAMINO),a
			xor		a
			ld		(FASE3_VAGON_CORRIGE_Y_CADENCIA),a
			call	BUCLE_PINTA_TILES.VELOCIDAD_DE_FASE_GALOPE
			call	APLICA_SPRITES_DEPH_VAGON
			scf
			ret

.MIRA_MARGEN_Y_SALTO_FASE3_VAGON:

			ld		a,(TILE_FASE3_VAGON)
			cp		16
			jr		c,.SALE_SALTO_FASE3_VAGON
			jr		.MUERE_SALTO_FASE3_VAGON

.SALE_SALTO_FASE3_VAGON:

			call	CONTROL_FASE3_TILE_PUNTO_DEPH.SALE_DE_FASE3_VAGON
			scf
			ret

.MUERE_SALTO_FASE3_VAGON:

			ld		a,(TILE_FASE3_VAGON)
			cp		48
			jr		c,.SALTO_MUERTE_ESTRELLADO
			cp		51
			jr		nc,.SALTO_MUERTE_ESTRELLADO
			xor		a
			jr		.GUARDA_MUERTE_SALTO

.SALTO_MUERTE_ESTRELLADO:

			ld		a,1

.GUARDA_MUERTE_SALTO:

			ld		(FASE3_VAGON_TIPO_MUERTE),a
			jp		CONTROL_FASE3_TILE_PUNTO_DEPH.MUERTE_DEPH_FASE3_VAGON

PINTA_TRIADA_SALTO_SALE_VAGON:

			ld		e,a
			cp		124
			ld		a,16
			jr		c,.CALCULA_DESTINO
			ld		a,19

.CALCULA_DESTINO:

			push	af
			call	CALCULA_XY_TILE_FASE3_VAGON
			ld		a,e
			cp		119
			jr		z,.RESTA_UN_TILE
			cp		122
			jr		z,.RESTA_UN_TILE
			cp		125
			jr		z,.RESTA_UN_TILE
			cp		128
			jr		z,.RESTA_UN_TILE
			cp		120
			jr		z,.RESTA_DOS_TILES
			cp		123
			jr		z,.RESTA_DOS_TILES
			cp		126
			jr		z,.RESTA_DOS_TILES
			cp		129
			jr		z,.RESTA_DOS_TILES
			jr		.PINTA

.RESTA_UN_TILE:

			ld		a,b
			sub		16
			ld		b,a
			jr		.PINTA

.RESTA_DOS_TILES:

			ld		a,b
			sub		32
			ld		b,a

.PINTA:

			pop		af
			jp		PINTA_TRIADA_FASE3_VAGON

PINTA_TRIADA_ENTRADA_FASE3_VAGON_Y_MAS_16:

			ld		a,b
			jp		PINTA_TRIADA_ENTRADA_FASE3_VAGON

PINTA_TRIADA_ENTRADA_FASE3_VAGON_SALTO:

			ld		e,b
			ld		a,b
			cp		19
			jr		nc,.GRUPO_DERECHA

			xor		a
			ld		(FASE3_VAGON_TIPO_MUERTE),a
			ld		a,121
			jr		.CALCULA_DESTINO

.GRUPO_DERECHA:

			ld		a,1
			ld		(FASE3_VAGON_TIPO_MUERTE),a
			ld		a,127

.CALCULA_DESTINO:

			push	af
			call	CALCULA_XY_TILE_FASE3_VAGON_ENTRADA
			call	COLOCA_X_DEPH_ENTRADA_VAGON_SIN_Y
			ld		a,e
			cp		17
			jr		z,.RESTA_UN_TILE
			cp		20
			jr		z,.RESTA_UN_TILE
			cp		18
			jr		z,.RESTA_DOS_TILES
			cp		21
			jr		z,.RESTA_DOS_TILES
			jr		.PINTA

.RESTA_UN_TILE:

			ld		a,b
			sub		16
			ld		b,a
			jr		.PINTA

.RESTA_DOS_TILES:

			ld		a,b
			sub		32
			ld		b,a

.PINTA:

			pop		af
			jp		PINTA_TRIADA_FASE3_VAGON

TABLA_SALTO_FASE3_VAGON_X:

			db		2,1,2,1,2,1,2,1,2,1
			db		2,1,2,1,2,1,2,1,2,1
			db		2,1,2,1,2,1,2,1,2,4

TABLA_SALTO_FASE3_VAGON_Y:

			db		252,252,252,254,254,254,254,255,255,255
			db		255,0,0,0,0,0,0,0,0,0
			db		1,1,1,1,2,2,3,3,5,5

CONTROL_FASE3_TILE_PUNTO_DEPH:

			call	CONTROL_FASE3_VAGON_AVANZA_CONTADOR_16
			call	.CONTROL_FASE3_VAGON_MUERTE_TILE
			call	.CONTROL_FASE3_VAGON_SALIDA_TILE
			ret		c

			ld		a,b
			or		a
			ld		a,(TILE_FASE3_VAGON)
			jr		nz,.MIRA_ARRASTRE_X

			push	af
			ld		a,(FASE3_VAGON_ARRASTRE_X)
			cp		1
			jr		z,.ARRASTRE_ACTIVO_SALTA_X_FIJA
			cp		2
			jr		z,.ARRASTRE_ACTIVO_SALTA_X_FIJA
			pop		af

			cp		118
			jp		z,.COLOCA_X_DEPH_EN_TILE_MAS_12
			cp		119
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_4
			cp		120
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_20
			cp		121
			jp		z,.COLOCA_X_DEPH_EN_TILE_MAS_12
			cp		122
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_4
			cp		123
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_20
			cp		124
			jp		z,.COLOCA_X_DEPH_EN_TILE_MAS_12
			cp		125
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_4
			cp		126
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_20
			cp		127
			jp		z,.COLOCA_X_DEPH_EN_TILE_MAS_12
			cp		128
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_4
			cp		129
			jp		z,.COLOCA_X_DEPH_EN_TILE_MENOS_20

.MIRA_ARRASTRE_X:

			push	af
			call	.CONTROL_FASE3_VAGON_ARRASTRE_X
			jp		c,.ARRASTRE_X_CONSUME_CICLO
			pop		af

.MIRA_SECUENCIAS_X:

			cp		52
			jr		c,.SIN_EFECTO
			cp		57
			jr		c,.TABLA_TILE_X_MAS_CADA_2

			cp		68
			jr		c,.MIRA_TILES_ALTOS_X_MAS
			cp		74
			jr		c,.TABLA_TILE_X_MENOS_CADA_2

.MIRA_TILES_ALTOS_X_MAS:

			cp		149
			jr		z,.TABLA_TILE_X_MAS_CADA_2
			cp		150
			jr		z,.TABLA_TILE_X_MAS_CADA_2
			cp		165
			jr		z,.TABLA_TILE_X_MAS_CADA_2
			cp		166
			jr		z,.TABLA_TILE_X_MAS_CADA_2

			cp		153
			jr		z,.TABLA_TILE_X_MENOS_CADA_2
			cp		154
			jr		z,.TABLA_TILE_X_MENOS_CADA_2
			cp		169
			jr		z,.TABLA_TILE_X_MENOS_CADA_2
			cp		170
			jr		z,.TABLA_TILE_X_MENOS_CADA_2
			jr		.SIN_EFECTO

.ARRASTRE_ACTIVO_SALTA_X_FIJA:

			pop		af
			jr		.MIRA_ARRASTRE_X

.TABLA_TILE_X_MAS_CADA_2:

			ld		hl,TABLA_FASE3_VAGON_X_MAS_CADA_2
			jp		.APLICA_TABLA_X

.TABLA_TILE_X_MENOS_CADA_2:

			ld		hl,TABLA_FASE3_VAGON_X_MENOS_CADA_2
			jp		.APLICA_TABLA_X

.SIN_EFECTO:

			ret

.CONTROL_FASE3_VAGON_MUERTE_TILE:

			push	bc
			ld		a,(TILE_FASE3_VAGON)
			cp		160
			jr		nz,.MIRA_TILE_MUERTE_130_138
			ld		a,1
			jr		.GUARDA_TIPO_MUERTE

.MIRA_TILE_MUERTE_130_138:

			cp		130
			jr		c,.NO_HAY_MUERTE_TILE
			cp		139
			jr		nc,.NO_HAY_MUERTE_TILE
			ld		a,1

.GUARDA_TIPO_MUERTE:

			ld		(FASE3_VAGON_TIPO_MUERTE),a
			pop		bc
			pop		af
			jp		.MUERTE_DEPH_FASE3_VAGON

.NO_HAY_MUERTE_TILE:

			pop		bc
			ret

.MUERTE_DEPH_FASE3_VAGON:

			ld		a,(FASE3_VAGON_TIPO_MUERTE)
			or		a
			jp		z,.MUERTE_AL_VACIO
			jp		.MUERTE_ESTRELLADO

.MUERTE_ESTRELLADO:

			ld		a,(TILE_FASE3_VAGON)
			cp		130
			jr		c,.SIN_PINTA_ORIGEN_ESTRELLADO
			cp		139
			jr		nc,.SIN_PINTA_ORIGEN_ESTRELLADO
			call	.PINTA_TRIADA_MUERTE_ESTRELLADO

.SIN_PINTA_ORIGEN_ESTRELLADO:

			call	CARGA_DEPH_NORMAL_SALTO_FASE3_VAGON
			ld		a,(Y_DEPH)
			sub		16
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			sub		16
			ld		(CONTROL_Y),a
			ld		b,32

.BUCLE_CAIDA_ESTRELLADO:

			push	bc
			ld		a,b
			and		1
			jr		z,.PINTA_CAIDA_ESTRELLADO
			ld		a,(Y_DEPH)
			dec		a
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			dec		a
			ld		(CONTROL_Y),a

.PINTA_CAIDA_ESTRELLADO:

			halt
			call	PINTA_SPRITE_DEPH_SALTO_VAGONETA
			call	CARGA_COLORES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA
			pop		bc
			djnz	.BUCLE_CAIDA_ESTRELLADO

			call	BUCLE_PINTA_TILES.PINTA_PALETA_GRIS
			call	stpmus
			ld		a,10
			ld		c,0
			call	A_31_DESDE_10
			call	.CARGA_SPRITES_VAGONETA_APLASTADA
			call	.CARGA_COLORES_VAGONETA_APLASTADA
			call	.PINTA_SPRITE_DEPH_APLASTADO_VAGONETA
			ld		a,240
			call	BUCLE_PINTA_TILES.rutina_de_pausa
			ld		hl,PALETA_GRISES_FADE_OUT
			jp		SALTO_AL_FADEAR_EN_GRISES

.PINTA_TRIADA_MUERTE_ESTRELLADO:

			ld		e,a
			cp		133
			ld		a,22
			jr		c,.CALCULA_DESTINO_MUERTE
			ld		a,25

.CALCULA_DESTINO_MUERTE:

			push	af
			call	.CALCULA_XY_TILE_MUERTE_FASE3_VAGON
			ld		a,e
			cp		131
			jr		z,.RESTA_UN_TILE_MUERTE
			cp		134
			jr		z,.RESTA_UN_TILE_MUERTE
			cp		137
			jr		z,.RESTA_UN_TILE_MUERTE
			cp		132
			jr		z,.RESTA_DOS_TILES_MUERTE
			cp		135
			jr		z,.RESTA_DOS_TILES_MUERTE
			cp		138
			jr		z,.RESTA_DOS_TILES_MUERTE
			jr		.PINTA_TRIADA_MUERTE

.RESTA_UN_TILE_MUERTE:

			ld		a,b
			sub		16
			ld		b,a
			jr		.PINTA_TRIADA_MUERTE

.RESTA_DOS_TILES_MUERTE:

			ld		a,b
			sub		32
			ld		b,a

.PINTA_TRIADA_MUERTE:

			pop		af
			jp		PINTA_TRIADA_FASE3_VAGON

.CALCULA_XY_TILE_MUERTE_FASE3_VAGON:

			push	de
			ld		a,(X_DEPH)
			add		6
			and		#f0
			ld		b,a
			ld		a,(Y_PINTA_SCROLL)
			and		#0f
			ld		d,a
			ld		a,(Y_DEPH)
			add		20
			sub		d
			and		#f0
			add		d
			ld		c,a
			pop		de
			ret

.PINTA_SPRITE_DEPH_APLASTADO_VAGONETA:

			push	ix

			ld		ix,ATRIBUTOS_DEPH_VARIABLES
			ld		a,(Y_DEPH)
			push	af
			add		16
			push	af
			ld		a,(X_DEPH)
			push	af
			add		16

			ld		(ix+9),a
			ld		(ix+13),a
			ld		(ix+25),a
			ld		(ix+29),a

			pop		af
			ld		(ix+1),a
			ld		(ix+5),a
			ld		(ix+17),a
			ld		(ix+21),a

			pop		af
			ld		(ix+16),a
			ld		(ix+20),a
			ld		(ix+24),a
			ld		(ix+28),a
			ld		a,217
			ld		(ix+32),a
			ld		(ix+36),a

			pop		af
			ld		(ix),a
			ld		(ix+4),a
			ld		(ix+8),a
			ld		(ix+12),a

			ld		a,20
			ld		(ix+2),a
			add		4
			ld		(ix+6),a
			add		4
			ld		(ix+10),a
			add		4
			ld		(ix+14),a
			add		4
			ld		(ix+18),a
			add		4
			ld		(ix+22),a
			add		4
			ld		(ix+26),a
			add		4
			ld		(ix+30),a
			xor		a
			ld		(ix+34),a
			ld		(ix+38),a

			pop		ix

			ld		hl,ATRIBUTOS_DEPH_VARIABLES
			ld		de,#4A00
			ld		bc,40
			jp		PON_COLOR_2.sin_bc_impuesta

.CARGA_SPRITES_VAGONETA_APLASTADA:

			ld		hl,SPRITES_VAGONETA_APLASTADA
			ld		de,#4000+20*8
			ld		bc,8*32
			jp		PON_COLOR_2.sin_bc_impuesta

.CARGA_SPRITES_VAGONETA_CAIDA_1:

			ld		hl,SPRITES_CAIDA_1
			ld		de,#4000+20*8
			ld		bc,8*32
			jp		PON_COLOR_2.sin_bc_impuesta

.CARGA_SPRITES_VAGONETA_CAIDA_2:

			ld		hl,SPRITES_CAIDA_2
			ld		de,#4000+20*8
			ld		bc,8*32
			jp		PON_COLOR_2.sin_bc_impuesta

.CARGA_COLORES_VAGONETA_APLASTADA:

			ld		hl,COLOR_SPRITES_VAGONETA_APLASTADO
			ld		de,#4840
			ld		bc,8*16
			jp		PON_COLOR_2.sin_bc_impuesta

.CARGA_COLORES_VAGONETA_CAIDA_1:

			ld		hl,COLOR_SPRITES_VAGONETA_CAIDA_1
			ld		de,#4840
			ld		bc,8*16
			jp		PON_COLOR_2.sin_bc_impuesta

.CARGA_COLORES_VAGONETA_CAIDA_2:

			ld		hl,COLOR_SPRITES_VAGONETA_CAIDA_
			ld		de,#4840
			ld		bc,8*16
			jp		PON_COLOR_2.sin_bc_impuesta

.PONE_ATRIBUTOS_DEPH_CAIDA_A_0:

			ld		hl,ATRIBUTOS_DEPH_VARIABLES
			ld		b,32
			xor		a

.BUCLE_ATRIBUTOS_DEPH_CAIDA_A_0:

			ld		(hl),a
			inc		hl
			djnz	.BUCLE_ATRIBUTOS_DEPH_CAIDA_A_0

			ld		hl,ATRIBUTOS_DEPH_VARIABLES
			ld		de,#4A00
			ld		bc,32
			jp		PON_COLOR_2.sin_bc_impuesta

.MUERTE_AL_VACIO:

			call	CARGA_DEPH_NORMAL_SALTO_FASE3_VAGON
			ld		a,(Y_DEPH)
			sub		16
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			sub		16
			ld		(CONTROL_Y),a
			ld		b,32

.BUCLE_CAIDA_VACIO:

			push	bc
			ld		a,b
			and		1
			jr		z,.PINTA_CAIDA_VACIO
			ld		a,(Y_DEPH)
			dec		a
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			dec		a
			ld		(CONTROL_Y),a

.PINTA_CAIDA_VACIO:

			halt
			call	PINTA_SPRITE_DEPH_SALTO_VAGONETA
			call	CARGA_COLORES_PARTE_INFERIOR_DEPH_SALTO_VAGONETA
			pop		bc
			djnz	.BUCLE_CAIDA_VACIO

			call	BUCLE_PINTA_TILES.PINTA_PALETA_GRIS
			call	stpmus
			ld		a,19
			ld		c,0
			call	A_31_DESDE_10
			call	.CARGA_SPRITES_VAGONETA_CAIDA_1
			call	.CARGA_COLORES_VAGONETA_CAIDA_1
			call	.PINTA_SPRITE_DEPH_APLASTADO_VAGONETA
			ld		a,240
			call	BUCLE_PINTA_TILES.rutina_de_pausa
			call	.CARGA_SPRITES_VAGONETA_CAIDA_2
			call	.CARGA_COLORES_VAGONETA_CAIDA_2
			call	.PINTA_SPRITE_DEPH_APLASTADO_VAGONETA
			ld		a,240
			call	BUCLE_PINTA_TILES.rutina_de_pausa
			call	.PONE_ATRIBUTOS_DEPH_CAIDA_A_0
			ld		a,240
			call	BUCLE_PINTA_TILES.rutina_de_pausa
			ld		hl,PALETA_GRISES_FADE_OUT
			jp		SALTO_AL_FADEAR_EN_GRISES

.CONTROL_FASE3_VAGON_SALIDA_TILE:

			ld		a,(TILE_FASE3_VAGON)
			cp		8
			jr		c,.NO_SALE_VAGON_TILE
			cp		11
			jr		nc,.NO_SALE_VAGON_TILE
			call	PINTA_TRIADA_SALIDA_FASE3_VAGON
			call	.SALE_DE_FASE3_VAGON
			scf
			ret

.NO_SALE_VAGON_TILE:

			or		a
			ret

.SALE_DE_FASE3_VAGON:

			ld		a,(Y_DEPH)
			sub		16
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			sub		16
			ld		(CONTROL_Y),a
			xor		a
			ld		(SUMA_CAMINO),a
			ld		(FASE3_VAGON_CORRIGE_Y_CADENCIA),a
			ld		(FASE3_VAGON_ARRASTRE_X),a
			ld		(FASE3_VAGON_AJUSTE_TILE_CONTADOR),a
			dec		a
			ld		(FASE3_VAGON_INDICE_16_PRE_Y),a
			call	CARGA_1_A_25_TRAS_PAUSA
			call	BUCLE_PINTA_TILES.musica_mas_velocidad
			ret

.ARRASTRE_X_CONSUME_CICLO:

			pop		af
			ret

.CONTROL_FASE3_VAGON_ARRASTRE_X:

			ld		c,a
			call	.ES_TILE_FASE3_VAGON_ARRASTRE_MAS
			jr		c,.TILE_ARRASTRE_MAS

			ld		a,(FASE3_VAGON_ARRASTRE_X)
			cp		1
			jr		z,.LIMPIA_ARRASTRE_MAS
			cp		3
			jr		nz,.MIRA_TILE_ARRASTRE_MENOS

.LIMPIA_ARRASTRE_MAS:

			xor		a
			ld		(FASE3_VAGON_ARRASTRE_X),a
			ld		(FASE3_VAGON_AJUSTE_TILE_CONTADOR),a

.MIRA_TILE_ARRASTRE_MENOS:

			ld		a,c
			call	.ES_TILE_FASE3_VAGON_ARRASTRE_MENOS
			jr		c,.TILE_ARRASTRE_MENOS

			ld		a,(FASE3_VAGON_ARRASTRE_X)
			cp		2
			jr		z,.LIMPIA_ARRASTRE_MENOS
			cp		4
			jr		nz,.SIN_ARRASTRE_X

.LIMPIA_ARRASTRE_MENOS:

			xor		a
			ld		(FASE3_VAGON_ARRASTRE_X),a
			ld		(FASE3_VAGON_AJUSTE_TILE_CONTADOR),a

.SIN_ARRASTRE_X:

			or		a
			ret

.TILE_ARRASTRE_MAS:

			call	.ACTUALIZA_TILE_ARRASTRE_X
			ld		a,(FASE3_VAGON_ARRASTRE_X)
			cp		1
			jr		z,.APLICA_ARRASTRE_MAS
			cp		3
			jr		z,.SIN_ARRASTRE_X
			call	.PUEDE_INICIAR_DESVIO_DERECHA_FASE3_VAGON
			jr		nc,.SIN_ARRASTRE_X
			call	.PULSA_DERECHA_FASE3_VAGON
			jr		nc,.BLOQUEA_ARRASTRE_MAS
			call	.CORRIGE_X_DEPH_ENTRADA_ARRASTRE
			ld		a,1
			ld		(FASE3_VAGON_ARRASTRE_X),a

.APLICA_ARRASTRE_MAS:

			ld		hl,TABLA_FASE3_VAGON_X_MAS_CADA_2
			call	.APLICA_TABLA_X
			scf
			ret

.BLOQUEA_ARRASTRE_MAS:

			ld		a,3
			ld		(FASE3_VAGON_ARRASTRE_X),a
			or		a
			ret

.TILE_ARRASTRE_MENOS:

			call	.ACTUALIZA_TILE_ARRASTRE_X
			ld		a,(FASE3_VAGON_ARRASTRE_X)
			cp		2
			jr		z,.APLICA_ARRASTRE_MENOS
			cp		4
			jr		z,.SIN_ARRASTRE_X
			call	.PUEDE_INICIAR_DESVIO_IZQUIERDA_FASE3_VAGON
			jr		nc,.SIN_ARRASTRE_X
			call	.PULSA_IZQUIERDA_FASE3_VAGON
			jr		nc,.BLOQUEA_ARRASTRE_MENOS
			call	.CORRIGE_X_DEPH_ENTRADA_ARRASTRE
			ld		a,2
			ld		(FASE3_VAGON_ARRASTRE_X),a

.APLICA_ARRASTRE_MENOS:

			ld		hl,TABLA_FASE3_VAGON_X_MENOS_CADA_2
			call	.APLICA_TABLA_X
			scf
			ret

.BLOQUEA_ARRASTRE_MENOS:

			ld		a,4
			ld		(FASE3_VAGON_ARRASTRE_X),a
			or		a
			ret

.PUEDE_INICIAR_DESVIO_DERECHA_FASE3_VAGON:

			scf
			ret

.PUEDE_INICIAR_DESVIO_IZQUIERDA_FASE3_VAGON:

			scf
			ret

.ACTUALIZA_TILE_ARRASTRE_X:

			ld		a,(FASE3_VAGON_AJUSTE_TILE_CONTADOR)
			cp		c
			ret		z
			ld		a,b
			or		a
			ret		nz
			ld		a,c
			ld		(FASE3_VAGON_AJUSTE_TILE_CONTADOR),a
			call	.ES_PRIMER_TILE_ARRASTRE_X
			ret		nc

.LIMPIA_ARRASTRE_X:

			xor		a
			ld		(FASE3_VAGON_ARRASTRE_X),a

.NO_LIMPIA_ARRASTRE_X:

			ret

.ES_PRIMER_TILE_ARRASTRE_X:

			cp		145
			jr		z,.SI_PRIMER_TILE_ARRASTRE_X
			cp		161
			jr		z,.SI_PRIMER_TILE_ARRASTRE_X
			cp		157
			jr		z,.SI_PRIMER_TILE_ARRASTRE_X
			cp		173
			jr		z,.SI_PRIMER_TILE_ARRASTRE_X
			or		a
			ret

.SI_PRIMER_TILE_ARRASTRE_X:

			scf
			ret

.CORRIGE_X_DEPH_ENTRADA_ARRASTRE:

			ld		a,(X_DEPH)
			add		6
			and		11110000b
			ld		(X_DEPH),a
			ret

.ES_TILE_FASE3_VAGON_ARRASTRE_MAS:

			cp		145
			jr		c,.NO_ES_TILE_ARRASTRE_MAS
			cp		148
			jr		c,.SI_ES_TILE_ARRASTRE_MAS
			cp		161
			jr		c,.NO_ES_TILE_ARRASTRE_MAS
			cp		164
			jr		c,.SI_ES_TILE_ARRASTRE_MAS

.NO_ES_TILE_ARRASTRE_MAS:

			or		a
			ret

.SI_ES_TILE_ARRASTRE_MAS:

			scf
			ret

.ES_TILE_FASE3_VAGON_ARRASTRE_MENOS:

			cp		157
			jr		c,.NO_ES_TILE_ARRASTRE_MENOS
			cp		160
			jr		c,.SI_ES_TILE_ARRASTRE_MENOS
			cp		173
			jr		c,.NO_ES_TILE_ARRASTRE_MENOS
			cp		176
			jr		c,.SI_ES_TILE_ARRASTRE_MENOS

.NO_ES_TILE_ARRASTRE_MENOS:

			or		a
			ret

.SI_ES_TILE_ARRASTRE_MENOS:

			scf
			ret

.PULSA_DERECHA_FASE3_VAGON:

			push	bc
			xor		a
			call	GTSTCK_RAM
			call	.ES_STICK_DERECHA_FASE3_VAGON
			jr		c,.PULSA_DERECHA_OK
			ld		a,1
			call	GTSTCK_RAM
			cp		3
			jr		z,.PULSA_DERECHA_PAD_OK
			or		a
			jr		.PULSA_DERECHA_OK

.PULSA_DERECHA_PAD_OK:

			scf

.PULSA_DERECHA_OK:

			pop		bc
			ret

.PULSA_IZQUIERDA_FASE3_VAGON:

			push	bc
			xor		a
			call	GTSTCK_RAM
			call	.ES_STICK_IZQUIERDA_FASE3_VAGON
			jr		c,.PULSA_IZQUIERDA_OK
			ld		a,1
			call	GTSTCK_RAM
			cp		7
			jr		z,.PULSA_IZQUIERDA_PAD_OK
			or		a
			jr		.PULSA_IZQUIERDA_OK

.PULSA_IZQUIERDA_PAD_OK:

			scf

.PULSA_IZQUIERDA_OK:

			pop		bc
			ret

.ES_STICK_DERECHA_FASE3_VAGON:

			cp		2
			jr		c,.NO_STICK_DERECHA
			cp		5
			jr		c,.SI_STICK_DERECHA

.NO_STICK_DERECHA:

			or		a
			ret

.SI_STICK_DERECHA:

			scf
			ret

.ES_STICK_IZQUIERDA_FASE3_VAGON:

			cp		6
			jr		c,.NO_STICK_IZQUIERDA
			cp		9
			jr		c,.SI_STICK_IZQUIERDA

.NO_STICK_IZQUIERDA:

			or		a
			ret

.SI_STICK_IZQUIERDA:

			scf
			ret

.COLOCA_X_DEPH_EN_TILE_MAS_12:
			ld		a,(X_DEPH)
			add		6
			and		11110000b
			add		12
			ld		(X_DEPH),a
			ret

.COLOCA_X_DEPH_EN_TILE_MENOS_4:
			ld		a,(X_DEPH)
			add		6
			and		11110000b
			sub		4
			ld		(X_DEPH),a
			ret

.COLOCA_X_DEPH_EN_TILE_MENOS_20:
			ld		a,(X_DEPH)
			add		6
			and		11110000b
			sub		20
			ld		(X_DEPH),a
			ret

.APLICA_TABLA_X:

			call	LEE_ACCION_TABLA_FASE3_VAGON
			ret		z
			cp		1
			jr		z,.SUMA_X_DEPH_TABLA

.RESTA_X_DEPH_TABLA:

			ld		a,(X_DEPH)
			dec		a
			ld		(X_DEPH),a
			ld		a,(TILE_FASE3_VAGON)
			cp		153
			jr		z,.LIMITA_X_MIN_TILE_MENOS_4
			cp		169
			jr		z,.LIMITA_X_MIN_TILE_MENOS_4
			ret

.SUMA_X_DEPH_TABLA:

			ld		a,(X_DEPH)
			inc		a
			ld		(X_DEPH),a
			ld		a,(TILE_FASE3_VAGON)
			cp		150
			jr		z,.LIMITA_X_MAX_TILE_MENOS_4
			cp		166
			jr		z,.LIMITA_X_MAX_TILE_MENOS_4
			ret

.LIMITA_X_MAX_TILE_MENOS_4:

			ld		a,(X_DEPH)
			ld		e,a
			add		6
			and		11110000b
			sub		4
			cp		e
			ret		nc
			ld		(X_DEPH),a
			ret

.LIMITA_X_MIN_TILE_MENOS_4:

			ld		a,(X_DEPH)
			ld		e,a
			add		6
			and		11110000b
			sub		4
			cp		e
			ret		c
			ld		(X_DEPH),a
			ret

CONTROL_FASE3_VAGON_AVANZA_CONTADOR_16:

			ld		a,(FASE3_VAGON_INDICE_16_PRE_Y)
			cp		255
			jr		z,.CALCULA_CONTADOR_16_FASE3_VAGON
			ld		b,a
			ld		a,255
			ld		(FASE3_VAGON_INDICE_16_PRE_Y),a
			ret

.CALCULA_CONTADOR_16_FASE3_VAGON:

			ld		a,(Y_DEPH)
			add		26
			ld		b,a
			ld		a,(Y_PINTA_SCROLL)
			ld		c,a
			ld		a,b
			sub		c
			and		00001111b
			ld		b,a
			ret

LEE_ACCION_TABLA_FASE3_VAGON:

			ld		e,b
			ld		d,0
			add		hl,de
			ld		a,(hl)
			or		a
			ret

TABLA_FASE3_VAGON_X_MAS_CADA_2:

			db		1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0

TABLA_FASE3_VAGON_X_MENOS_CADA_2:

			db		#FF,0,#FF,0,#FF,0,#FF,0,#FF,0,#FF,0,#FF,0,#FF,0

FUEGO_AVISO_RAILES:

.DEFINE_FUEGO_AVISO_RAILES:

        call    .HAY_FUEGO_AVISO_ACTIVO
        jp      nz,.NO_CREA_FUEGO_AVISO
        ld      a,b
        ld      hl,VALORES_BASICOS_FUEGO_AVISO_RAILES
        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
        call    STANDAR_Y_FUERA_PANTALLA
        xor     a
        ld      (ix+7),a
        ld      (ix+10),a
        ld      (ix+13),a
        ld      a,112
        ld      (ix+14),a
        ld      a,4
        ld      (ix+9),a
        ld      a,3
        ld      (ix+11),a
        call    TROZOS_COMUNES_4
        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE
        ld      a,(SPRITE_QUE_TOCA)
        rlc     a
        rlc     a
        ld      (ix+15),a
        xor     a
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        ld      (FUEGO_AVISO_RAILES_LINEA_ANT),a
        call    .PINTA_COLOR_NORMAL_FUEGO_AVISO
        jp      UN_NUEVO_ENEMIGO.RESOLUCION

.NO_CREA_FUEGO_AVISO:

        xor     a
        ld      (DATOS_A_SACAR),a
        jp      UN_NUEVO_ENEMIGO.NOS_VAMOS

.HAY_FUEGO_AVISO_ACTIVO:

        push    bc
        push    de
        push    ix
        ld      ix,ENEMIGOS
        ld      b,10

.BUSCA_FUEGO_AVISO_ACTIVO:

        ld      a,(ix+2)
        cp      $FF
        jr      z,.SIGUIENTE_FUEGO_AVISO_ACTIVO
        ld      a,(ix+6)
        cp      36
        jr      z,.FUEGO_AVISO_YA_ACTIVO

.SIGUIENTE_FUEGO_AVISO_ACTIVO:

        ld      de,16
        add     ix,de
        djnz    .BUSCA_FUEGO_AVISO_ACTIVO
        pop     ix
        pop     de
        pop     bc
        xor     a
        ret

.FUEGO_AVISO_YA_ACTIVO:

        pop     ix
        pop     de
        pop     bc
        or      1
        ret

.MATA_FUEGO_AVISO_SI_ACTIVO:

        push    bc
        push    de
        push    ix
        ld      ix,ENEMIGOS
        ld      b,10

.BUSCA_FUEGO_AVISO_PARA_MATAR:

        ld      a,(ix+2)
        cp      $FF
        jr      z,.SIGUIENTE_FUEGO_AVISO_PARA_MATAR
        ld      a,(ix+6)
        cp      36
        jr      z,.MATA_FUEGO_AVISO_ACTIVO

.SIGUIENTE_FUEGO_AVISO_PARA_MATAR:

        ld      de,16
        add     ix,de
        djnz    .BUSCA_FUEGO_AVISO_PARA_MATAR
        jr      .FIN_MATA_FUEGO_AVISO

.MATA_FUEGO_AVISO_ACTIVO:

        call    .LIBERA_SPRITES_FUEGO_AVISO
        ld      a,$FF
        ld      (ix+2),a

.FIN_MATA_FUEGO_AVISO:

        xor     a
        ld      (FUEGO_AVISO_RAILES_TIMER),a
        ld      (FUEGO_AVISO_RAILES_RECOLOCA_Y),a
        ld      (FUEGO_AVISO_RAILES_OBJETIVO_X),a
        ld      (FUEGO_AVISO_RAILES_OBJETIVO_Y),a
        ld      (FUEGO_AVISO_RAILES_LINEA_ANT),a
        pop     ix
        pop     de
        pop     bc
        ret

.SECUENCIA_FUEGO_AVISO_RAILES:

        call    .ANIMA_FUEGO_AVISO_RAILES
        ld      a,(FUEGO_AVISO_RAILES_RECOLOCA_Y)
        cp      2
        jr      nz,.EN_VAGONETA

        ld      a,(ix+1)
        add     8
        ld      (ix+1),a
        cp      216
        jp      c,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION
        call    .LIBERA_SPRITES_FUEGO_AVISO
        ld      a,255
        ld      (ix+2),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.EN_VAGONETA:

        ld      a,(FUEGO_AVISO_RAILES_RECOLOCA_Y)
        cp      1
        jr      z,.A_OBJETIVO
        cp      3
        jr      z,.ESPERA_EN_OBJETIVO
        jp      .ERRATICO

.COLOR_NORMAL_FUEGO_AVISO:

        call    .PINTA_COLOR_NORMAL_FUEGO_AVISO
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        ld      (FUEGO_AVISO_RAILES_LINEA_ANT),a
        xor     a
        ld      (FUEGO_AVISO_RAILES_RECOLOCA_Y),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.ESPERA_EN_OBJETIVO:

        call    .PINTA_COLOR_AVISO_FUEGO_AVISO
        ld      a,(FUEGO_AVISO_RAILES_TIMER)
        or      a
        jr      z,.COLOR_NORMAL_FUEGO_AVISO
        dec     a
        ld      (FUEGO_AVISO_RAILES_TIMER),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.A_OBJETIVO:

        call    .PINTA_COLOR_AVISO_FUEGO_AVISO
        ld      a,(FUEGO_AVISO_RAILES_OBJETIVO_X)
        ld      b,a
        ld      c,(ix)
        call    .MUEVE_EJE_OBJETIVO
        ld      (ix),a
        ld      a,(FUEGO_AVISO_RAILES_OBJETIVO_Y)
        ld      b,a
        ld      c,(ix+1)
        call    .MUEVE_EJE_OBJETIVO
        ld      (ix+1),a
        ld      a,(ix)
        ld      b,a
        ld      a,(FUEGO_AVISO_RAILES_OBJETIVO_X)
        cp      b
        jp      nz,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION
        ld      a,(ix+1)
        ld      b,a
        ld      a,(FUEGO_AVISO_RAILES_OBJETIVO_Y)
        cp      b
        jp      nz,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION
        ld      a,150
        ld      (FUEGO_AVISO_RAILES_TIMER),a
        ld      a,3
        ld      (FUEGO_AVISO_RAILES_RECOLOCA_Y),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.MUEVE_EJE_OBJETIVO:

        ld      a,c
        cp      b
        ret     z
        jr      c,.EJE_MAS_RAPIDO
        sub     b
        cp      10
        jr      c,.EJE_MENOS_1
        ld      a,c
        sub     7
        jr      nc,.EJE_MENOS_LIMITA
        xor     a

.EJE_MENOS_LIMITA:

        cp      b
        ret     nc
        ld      a,b
        ret

.EJE_MENOS_1:

        ld      a,c
        dec     a
        ret

.EJE_MAS_RAPIDO:

        ld      a,b
        sub     c
        cp      10
        jr      c,.EJE_MAS_1
        ld      a,c
        add     7
        cp      b
        ret     c
        ld      a,b
        ret

.EJE_MAS_1:

        ld      a,c
        inc     a
        ret

.ERRATICO:

.APLICA_VECTOR:

        ld      a,(ix+10)
        inc     a
        cp      5
        jr      nc,.MUEVE_ERRATICO
        ld      (ix+10),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.MUEVE_ERRATICO:

        xor     a
        ld      (ix+10),a
        call    .CORRIGE_Y_SET_ADJUST
        ld      b,(ix+9)
        call    .APLICA_X
        jp      c,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION
        ld      b,(ix+11)
        call    .APLICA_Y
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.CORRIGE_Y_SET_ADJUST:

        ld      a,(FUEGO_AVISO_RAILES_LINEA_ANT)
        ld      c,a
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        cp      c
        ret     z
        ld      (FUEGO_AVISO_RAILES_LINEA_ANT),a
        sub     c
        ld      b,a
        ld      a,(ix+1)
        add     b
        ld      (ix+1),a
        ret

.APLICA_X:

        ld      a,(ix)
        add     b
        cp      236
        jr      c,.X_OK
        bit     7,b
        jr      z,.X_MAX
        xor     a
        jr      .INVIERTE_X

.X_MAX:

        ld      a,235

.INVIERTE_X:

        ld      (ix),a
        ld      a,b
        cpl
        inc     a
        ld      (ix+9),a
        scf
        ret

.X_OK:

        ld      (ix),a
        or      a
        ret

.APLICA_Y:

        ld      a,(ix+1)
        add     b
        ld      c,a
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        ld      e,a
        ld      a,c
        sub     e
        ld      d,a
        ld      a,d
        cp      64
        jr      c,.Y_MIN
        cp      241
        jr      c,.Y_OK

.Y_MAX:

        ld      a,e
        sub     16
        jr      .INVIERTE_Y

.Y_MIN:

        ld      a,e
        add     64
        jr      .INVIERTE_Y

.INVIERTE_Y:

        call    .EVITA_LINEA_OCULTA_FUEGO
        ld      (ix+1),a
        ld      a,b
        cpl
        inc     a
        ld      (ix+11),a
        ret

.Y_OK:

        ld      a,c
        call    .EVITA_LINEA_OCULTA_FUEGO
        ld      (ix+1),a
        ret

.EVITA_LINEA_OCULTA_FUEGO:

        cp      216
        jr      z,.RECTIFICA_LINEA_OCULTA_FUEGO
        cp      200
        ret     nz

.RECTIFICA_LINEA_OCULTA_FUEGO:

        bit     7,b
        jr      z,.RECTIFICA_LINEA_OCULTA_FUEGO_DOWN
        dec     a
        ret

.RECTIFICA_LINEA_OCULTA_FUEGO_DOWN:

        add     2
        ret

.ANIMA_FUEGO_AVISO_RAILES:

        ld      a,(ix+7)
        inc     a
        and     1
        ld      (ix+7),a
        jp      nz,.PINTA_ATRIBUTOS_FUEGO_AVISO
        ld      a,(ix+13)
        inc     a
        and     1
        ld      (ix+13),a
        or      a
        jr      z,.FOTOGRAMA_0_FUEGO_AVISO
        ld      a,116
        ld      (ix+8),a
        ld      a,120
        jr      .PINTA_SPRITES_FUEGO_AVISO

.FOTOGRAMA_0_FUEGO_AVISO:

        ld      a,108
        ld      (ix+8),a
        ld      a,112

.PINTA_SPRITES_FUEGO_AVISO:

        ld      (ix+14),a
        call    .PINTA_ATRIBUTOS_FUEGO_AVISO
        ret

.PINTA_ATRIBUTOS_FUEGO_AVISO:

        push    af
        push    bc
        push    de
        push    hl
        push    iy
        ld      iy,PROPIEDADES_PATRON_SPRITE
        ld      a,(ix+1)
        ld      (iy),a
        ld      a,(ix)
        ld      (iy+1),a
        ld      a,(ix+8)
        ld      (iy+2),a
        ld      e,(ix+12)
        ld      d,0
        ld      hl,#4A00
        add     hl,de
        ex      de,hl
        ld      hl,PROPIEDADES_PATRON_SPRITE
        ld      bc,3
        call    PON_COLOR_2.sin_bc_impuesta
        ld      a,(ix+1)
        ld      (iy),a
        ld      a,(ix)
        ld      (iy+1),a
        ld      a,(ix+14)
        ld      (iy+2),a
        ld      e,(ix+15)
        ld      d,0
        ld      hl,#4A00
        add     hl,de
        ex      de,hl
        ld      hl,PROPIEDADES_PATRON_SPRITE
        ld      bc,3
        call    PON_COLOR_2.sin_bc_impuesta
        pop     iy
        pop     hl
        pop     de
        pop     bc
        pop     af
        ret

.PINTA_COLOR_NORMAL_FUEGO_AVISO:

        ld      d,#0f
        jr      .PINTA_COLOR_DOS_SPRITES_FUEGO_AVISO

.PINTA_COLOR_AVISO_FUEGO_AVISO:

        ld      d,#09

.PINTA_COLOR_DOS_SPRITES_FUEGO_AVISO:

        push    de
        ld      a,(ix+12)
        ld      c,#01
        call    .PINTA_COLOR_UN_SPRITE_FUEGO_AVISO
        pop     de
        ld      a,(ix+15)
        ld      c,d

.PINTA_COLOR_UN_SPRITE_FUEGO_AVISO:

        call    PON_COLOR_1
        ex      de,hl
        ld      a,c
        ld      bc,16
        jp      FILVRM_RAM

.LIBERA_SPRITES_FUEGO_AVISO:

        ld      a,(ix+15)
        call    DEJA_LIBRE_SPRITE_EN_RAM
        call    STANDARD_DEJA_LIBRE_EL_SPRITE
        xor     a
        ld      (ix+15),a
        ret

PREMIO_EXTRA:

.DEFINE_PREMIO_EXTRA:

        call    .HAY_PREMIO_EXTRA_ACTIVO
        jp      nz,.NOS_VAMOS_PREMIO_EXTRA_SIN_CREAR
        call    .HAY_SPRITE_LIBRE_PREMIO_EXTRA
        jp      nz,.NOS_VAMOS_PREMIO_EXTRA_SIN_CREAR

        ld      a,b
        ld      hl,VALORES_BASICOS_PREMIO_EXTRA
        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
        call    TROZOS_COMUNES_1

        call    .ESCOGE_PREMIO_EXTRA
        ld      (ix+9),a
        call    .CARGA_PREMIO_EXTRA

        xor     a
        ld      (ix+10),a
        ld      (ix+7),a
        ld      a,(ix+1)
        ld      (ix+11),a
        ld      a,(ix)
        ld      (ix+13),a

        xor     a
        ld      (ix+3),a
        ld      a,(ix+12)
        call    PON_COLOR_1
        ld      hl,COLOR_SPRITE_EXTRA
        call    TROZOS_COMUNES_7
        jp      UN_NUEVO_ENEMIGO.RESOLUCION

.NOS_VAMOS_PREMIO_EXTRA_SIN_CREAR:

        xor     a
        ld      (DATOS_A_SACAR),a
        jp      UN_NUEVO_ENEMIGO.NOS_VAMOS

.HAY_PREMIO_EXTRA_ACTIVO:

        push    bc
        push    de
        push    ix
        ld      ix,ENEMIGOS
        ld      b,10

.BUSCA_PREMIO_EXTRA_ACTIVO:

        ld      a,(ix+2)
        cp      $FF
        jr      z,.SIGUIENTE_PREMIO_EXTRA_ACTIVO
        ld      a,(ix+6)
        cp      34
        jr      z,.PREMIO_EXTRA_YA_ACTIVO

.SIGUIENTE_PREMIO_EXTRA_ACTIVO:

        ld      de,16
        add     ix,de
        djnz    .BUSCA_PREMIO_EXTRA_ACTIVO
        pop     ix
        pop     de
        pop     bc
        xor     a
        ret

.PREMIO_EXTRA_YA_ACTIVO:

        pop     ix
        pop     de
        pop     bc
        or      1
        ret

.HAY_SITIO_PREMIO_EXTRA:

        push    bc
        push    de
        push    ix
        ld      ix,ENEMIGOS
        ld      b,10
        ld      c,0

.BUSCA_SITIO_PREMIO_EXTRA:

        ld      a,(ix+2)
        cp      $FF
        jr      z,.MARCA_HUECO_PREMIO_EXTRA
        ld      a,(ix+6)
        cp      34
        jr      z,.NO_HAY_SITIO_PREMIO_EXTRA

.SIGUIENTE_SITIO_PREMIO_EXTRA:

        ld      de,16
        add     ix,de
        djnz    .BUSCA_SITIO_PREMIO_EXTRA
        ld      a,c
        or      a
        jr      z,.NO_HAY_SITIO_PREMIO_EXTRA
        ld      ix,SPRITES_ACTIVOS
        ld      b,20

.BUSCA_SPRITE_SITIO_PREMIO_EXTRA:

        ld      a,(ix)
        or      a
        jr      z,.SI_HAY_SITIO_PREMIO_EXTRA
        inc     ix
        djnz    .BUSCA_SPRITE_SITIO_PREMIO_EXTRA
        jr      .NO_HAY_SITIO_PREMIO_EXTRA

.MARCA_HUECO_PREMIO_EXTRA:

        ld      c,1
        jr      .SIGUIENTE_SITIO_PREMIO_EXTRA

.SI_HAY_SITIO_PREMIO_EXTRA:

        pop     ix
        pop     de
        pop     bc
        xor     a
        ret

.NO_HAY_SITIO_PREMIO_EXTRA:

        pop     ix
        pop     de
        pop     bc
        or      1
        ret

.HAY_SPRITE_LIBRE_PREMIO_EXTRA:

        push    bc
        push    ix
        ld      ix,SPRITES_ACTIVOS
        ld      b,20

.BUSCA_SPRITE_LIBRE_PREMIO_EXTRA:

        ld      a,(ix)
        or      a
        jr      z,.SPRITE_LIBRE_PREMIO_EXTRA
        inc     ix
        djnz    .BUSCA_SPRITE_LIBRE_PREMIO_EXTRA
        pop     ix
        pop     bc
        or      1
        ret

.SPRITE_LIBRE_PREMIO_EXTRA:

        pop     ix
        pop     bc
        xor     a
        ret

.ESCOGE_PREMIO_EXTRA:

        ld      a,r
        and     00111111b
        cp      34
        jr      c,.PREMIO_EXTRA_RANDOM_OK
        sub     34

.PREMIO_EXTRA_RANDOM_OK:

        cp      10
        jr      c,.PREMIO_EXTRA_500
        cp      19
        jr      c,.PREMIO_EXTRA_1000
        cp      28
        jr      c,.PREMIO_EXTRA_2000
        cp      32
        jr      c,.PREMIO_EXTRA_MAGIA
        ld      a,4
        ret

.PREMIO_EXTRA_500:

        xor     a
        ret

.PREMIO_EXTRA_1000:

        ld      a,1
        ret

.PREMIO_EXTRA_2000:

        ld      a,2
        ret

.PREMIO_EXTRA_MAGIA:

        ld      a,3
        ret

.CARGA_PREMIO_EXTRA:

        ld      e,a
        ld      d,0
        ld      hl,.TABLA_OFFSETS_SPRITE_EXTRA
        add     hl,de
        ld      e,(hl)
        ld      d,0
        ld      hl,SPRITE_EXTRA
        add     hl,de
        ld      de,#4000+35*8*4
        ld      bc,1*8*4
        jp      TROZOS_COMUNES_15

.TABLA_OFFSETS_SPRITE_EXTRA:

        db      0,32,64,96,128

.RECUPERA_FLECHA_PREMIO:

        ld      hl,FLECHA_PREMIO
        ld      de,#4000+43*8*4
        ld      bc,1*8*4
        jp      TROZOS_COMUNES_15

.MATA_PREMIO_EXTRA_SI_ACTIVO:

        push    bc
        push    de
        push    ix
        ld      ix,ENEMIGOS
        ld      b,10

.BUSCA_PREMIO_EXTRA_PARA_MATAR:

        ld      a,(ix+2)
        cp      $FF
        jr      z,.SIGUIENTE_PREMIO_EXTRA_PARA_MATAR
        ld      a,(ix+6)
        cp      34
        jr      z,.MATA_PREMIO_EXTRA_ACTIVO

.SIGUIENTE_PREMIO_EXTRA_PARA_MATAR:

        ld      de,16
        add     ix,de
        djnz    .BUSCA_PREMIO_EXTRA_PARA_MATAR
        pop     ix
        pop     de
        pop     bc
        ret

.MATA_PREMIO_EXTRA_ACTIVO:

        ld      a,5
        ld      c,1
        call    A_31_DESDE_10
        xor     a
        ld      (ix+2),a
        ld      (ix+10),a
        ld      a,23*4
        ld      (ix+8),a
        ld      a,10
        ld      (ix+6),a
        pop     ix
        pop     de
        pop     bc
        ret

.SECUENCIA_PREMIO_EXTRA:

        ld      a,(ix+10)
        cp      32
        jr      c,.FASE_PREMIO_EXTRA_OK
        xor     a
        ld      (ix+10),a
        ld      a,(ix+7)
        xor     1
        and     1
        ld      (ix+7),a
        xor     a

.FASE_PREMIO_EXTRA_OK:

        ld      e,a
        ld      d,0
        ld      hl,TABLA_PREMIO_EXTRA_X
        add     hl,de
        ld      c,(hl)
        ld      a,(ix+7)
        or      a
        jr      z,.PREMIO_EXTRA_X_A_DERECHA
        ld      a,64
        sub     c
        ld      c,a

.PREMIO_EXTRA_X_A_DERECHA:

        ld      a,(ix+13)
        add     c
        ld      (ix),a

        ld      hl,TABLA_PREMIO_EXTRA_Y
        add     hl,de
        ld      c,(hl)

        ld      a,(ix+11)
        add     c
        ld      (ix+1),a

        ld      a,(ix+10)
        inc     a
        ld      (ix+10),a
        call    .ALTERNA_COLOR_PREMIO_EXTRA
        jr      .FIN_PREMIO_EXTRA

.ALTERNA_COLOR_PREMIO_EXTRA:

        and     1
        ld      a,#09
        jr      z,.COLOR_PREMIO_EXTRA_OK
        ld      a,#0f

.COLOR_PREMIO_EXTRA_OK:

        push    af
        ld      a,(ix+12)
        call    PON_COLOR_1
        ex      de,hl
        ld      bc,16
        pop     af
        jp      FILVRM_RAM

.FIN_PREMIO_EXTRA:

        call    TROZOS_COMUNES_31
        jp      nc,.PREMIO_EXTRA_PARTIDO

.PREMIO_EXTRA_ENTERO:

        cp      c
        jp      nc,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

        ld      a,b
        cp      c
        jp      nc,.MUERE_PREMIO_EXTRA
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.PREMIO_EXTRA_PARTIDO:

        cp      c
        jp      c,.MUERE_PREMIO_EXTRA
        ld      a,b
        cp      c
        jp      c,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.MUERE_PREMIO_EXTRA:

        call    .RECUPERA_FLECHA_PREMIO
        jp      TROZOS_COMUNES_29

TABLA_PREMIO_EXTRA_X:

        db      0,0,1,2,3,5,7,10
        db      13,17,21,25,29,33,37,41
        db      45,49,53,56,59,61,63,64
        db      64,64,64,64,64,64,64,64

TABLA_PREMIO_EXTRA_Y:

        db      0,0,0,0,2,2,2,2,4,4,4,4,6,6,6,6,8,8,8,8,6,6,6,6,4,4,4,4,2,2,2,2

LLAMA_PAUSE_VAGON_FASE_3:

			push	af

.ESPERA_SUELTA_F1:

			ld		a,6
			call	SNSMAT_RAM
			bit		5,a
			jp		z,.ESPERA_SUELTA_F1

.ESPERA_PULSA_F1:

			ld		a,6
			call	SNSMAT_RAM
			bit		5,a
			jp		nz,.ESPERA_PULSA_F1

			pop		af
			ret

CORRIGE_Y_DEPH_SOLO_FASE3_VAGON:

			ld		a,(FASE)
			cp		3
			ret		nz
			ld		a,(SUMA_CAMINO)
			cp		1
			jr		z,.ES_VAGONETA_PARA_CORREGIR_Y
			cp		2
			ret		nz

.ES_VAGONETA_PARA_CORREGIR_Y:

			ld		a,(SPRITE_CAIDO)
			or		a
			ret		nz

			ld		a,(FASE3_VAGON_SALTO_PENDIENTE)
			cp		255
			ret		z

			call	.HAY_DESPLAZAMIENTO_X_VAGON_ESTE_CICLO
			ret		c

			ld		a,(Y_DEPH)
			ld		b,a
			ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
			ld		c,a
			ld		a,b
			sub		c
			cp		185
			ret		nc

.SUMA_Y_DEPH_VAGON:

			call	.GUARDA_INDICE_16_PRE_CORRIGE_Y

			ld		a,(CONTROL_Y)
			inc		a
			ld		(CONTROL_Y),a
			call	.AJUSTA_CONTROL_Y_LIM_MUERTE_VAGON
			ret		c
			ld		a,(Y_DEPH)
			inc		a
			ld		(Y_DEPH),a
			cp		216
			jr		z,.RECTIFICA_DOWN_Y_DEPH_VAGON
			cp		200
			ret		nz

.RECTIFICA_DOWN_Y_DEPH_VAGON:

			ld		a,(CONTROL_Y)
			add		2
			ld		(CONTROL_Y),a
			call	.AJUSTA_CONTROL_Y_LIM_MUERTE_VAGON
			ret		c
			ld		a,(Y_DEPH)
			add		2
			ld		(Y_DEPH),a
			ret

.AJUSTA_CONTROL_Y_LIM_MUERTE_VAGON:

			ld		a,(LIM_MUERTE)
			ld		b,a
			ld		a,(CONTROL_Y)
			cp		b
			jr		c,.MIRA_LIM_Y_INF_VAGON
			ld		a,b
			dec		a
			ld		(CONTROL_Y),a
			scf
			ret

.MIRA_LIM_Y_INF_VAGON:

			ld		a,(LIM_Y_INF)
			ld		b,a
			ld		a,(CONTROL_Y)
			cp		b
			jr		c,.CONTROL_Y_VAGON_SIN_AJUSTE
			ld		a,b
			dec		a
			ld		(CONTROL_Y),a
			scf
			ret

.CONTROL_Y_VAGON_SIN_AJUSTE:

			or		a
			ret

.GUARDA_INDICE_16_PRE_CORRIGE_Y:

			ld		a,(Y_DEPH)
			add		26
			ld		b,a
			ld		a,(Y_PINTA_SCROLL)
			ld		c,a
			ld		a,b
			sub		c
			and		00001111b
			ld		(FASE3_VAGON_INDICE_16_PRE_Y),a
			ret

.HAY_DESPLAZAMIENTO_X_VAGON_ESTE_CICLO:

			ld		a,(FASE3_VAGON_ARRASTRE_X)
			cp		1
			jr		z,.MIRA_TABLA_X_MAS_CORRIGE_Y
			cp		2
			jr		z,.MIRA_TABLA_X_MENOS_CORRIGE_Y

			call	.CALCULA_INDICE_16_VAGON_CORRIGE_Y

.MIRA_TILE_TABLA_X_CORRIGE_Y:

			ld		a,(TILE_FASE3_VAGON)
			cp		52
			jr		c,.NO_HAY_DESPLAZAMIENTO_X_VAGON_ESTE_CICLO
			cp		57
			jr		c,.MIRA_TABLA_X_MAS_CORRIGE_Y
			cp		68
			jr		c,.MIRA_TILES_ALTOS_X_CORRIGE_Y
			cp		74
			jr		c,.MIRA_TABLA_X_MENOS_CORRIGE_Y

.MIRA_TILES_ALTOS_X_CORRIGE_Y:

			cp		149
			jr		z,.MIRA_TABLA_X_MAS_CORRIGE_Y
			cp		150
			jr		z,.MIRA_TABLA_X_MAS_CORRIGE_Y
			cp		165
			jr		z,.MIRA_TABLA_X_MAS_CORRIGE_Y
			cp		166
			jr		z,.MIRA_TABLA_X_MAS_CORRIGE_Y

			cp		153
			jr		z,.MIRA_TABLA_X_MENOS_CORRIGE_Y
			cp		154
			jr		z,.MIRA_TABLA_X_MENOS_CORRIGE_Y
			cp		169
			jr		z,.MIRA_TABLA_X_MENOS_CORRIGE_Y
			cp		170
			jr		z,.MIRA_TABLA_X_MENOS_CORRIGE_Y
			jr		.NO_HAY_DESPLAZAMIENTO_X_VAGON_ESTE_CICLO

.MIRA_TABLA_X_MAS_CORRIGE_Y:

			ld		hl,TABLA_FASE3_VAGON_X_MAS_CADA_2
			jr		.MIRA_ACCION_X_CORRIGE_Y

.MIRA_TABLA_X_MENOS_CORRIGE_Y:

			ld		hl,TABLA_FASE3_VAGON_X_MENOS_CADA_2

.MIRA_ACCION_X_CORRIGE_Y:

			call	.CALCULA_INDICE_16_VAGON_CORRIGE_Y
			ld		e,b
			ld		d,0
			add		hl,de
			ld		a,(hl)
			or		a
			jr		nz,.SI_HAY_DESPLAZAMIENTO_X_VAGON_ESTE_CICLO

.NO_HAY_DESPLAZAMIENTO_X_VAGON_ESTE_CICLO:

			or		a
			ret

.SI_HAY_DESPLAZAMIENTO_X_VAGON_ESTE_CICLO:

			scf
			ret

.CALCULA_INDICE_16_VAGON_CORRIGE_Y:

			ld		a,(Y_DEPH)
			add		26
			ld		b,a
			ld		a,(Y_PINTA_SCROLL)
			ld		c,a
			ld		a,b
			sub		c
			and		00001111b
			ld		b,a
			ret

COVIDS:

.DEFINE_COVID_CORTO_DERECHA:

        ld      a,b
        ld      d,135
        ld      e,9
        ld      c,135
        ld      l,0
        jp      .comun_covids_variante

.DEFINE_COVID_ABAJO_IZQUIERDA:

        ld      a,b
        ld      d,30
        ld      e,28
        ld      c,1
        ld      l,62*4
        jp      .comun_covids_variante

.DEFINE_COVID_CORTO_IZQUIERDA:

        ld      a,b
        ld      d,10
        ld      e,9
        ld      c,10
        ld      l,0
        jp      .comun_covids_variante

.DEFINE_COVID_CORTO_CENTRO:

        ld      a,b
        ld      d,86
        ld      e,9
        ld      c,70
        ld      l,62*4
        jp      .comun_covids_variante


.DEFINE_COVID:

        ld      a,b
        ld		hl,VALORES_BASICOS_COVID

.comun_covids:

        call    STANDAR_LDIR_ENEMIGOS

.comun_covids_sin_carga:
 
        ld      (ix+11),a
        cp      000100000B
        jp      z,.comun_covids_seguimos

        ld      a,12
        ld      (ix+14),a

.comun_covids_seguimos:

        call    TROZOS_COMUNES_1
		ld		hl,COLOR_COVID_1_1						; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.comun_covids_variante:

        push    af
        push    de
        push    bc
        push    hl
        ld		hl,VALORES_BASICOS_COVID
        call    STANDAR_LDIR_ENEMIGOS
        pop     hl
        pop     bc
        pop     de
        pop     af
        ld      (ix),d
        ld      (ix+6),e
        ld      (ix+9),c
        ld      (ix+15),l
        jp      .comun_covids_sin_carga

.SECUENCIA_COVID_ABAJO:

		ld		a,(ix+9)
		cp		2
		jp		nz,.SECUENCIA_COVID_CORTO

		ld		a,(ix+13)
		or		a
		jp		z,.SECUENCIA_COVID_ABAJO_1

		dec		a
		ld		(ix+13),a

.SECUENCIA_COVID_ABAJO_1:

		ld		a,(ix+1)
		sub		2
		ld		(ix+1),a
		
		ld		a,00000100B
		ld		(ix+11),a
		
		ld		a,(ix+5)
		cp		01100000b
		jp		nc,.miramos_mas_datos
		ld		a,01100000b
		ld		(ix+5),a

		jp		.miramos_mas_datos

.SECUENCIA_COVID_CORTO:
		
		ld		a,(ix+9)
		cp		1
		jp		z,.realizamos_la_secuencia

        ld      a,(ix+10)
        and     00000001B
        or      a
        jp      nz,.miramos_mas_datos

.realizamos_la_secuencia:

        push    iy
        ld      iy,TABLA_MOVIMIENTO_COVID_CORTO
        ld      a,(ix+7)
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(iy)
        ld      b,a
        ld      a,(ix+9)
        add     b        
        ld      (ix),a
        pop     iy
        ld      a,(ix+7)
        inc     a
        ld      (ix+7),a
        cp      100
        jp      c,.miramos_mas_datos

        xor     a
        ld      (ix+7),a
        jp      .miramos_mas_datos

.SECUENCIA_COVID:

        ld      a,(ix+10)
        and     00000001B
        or      a
        jp      nz,.miramos_mas_datos
        
        push    iy
        ld      iy,TABLA_MOVIMIENTO_COVID
        ld      a,(ix+7)
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(iy)
        ld      (ix),a
        pop     iy
        ld      a,(ix+7)
        inc     a
        ld      (ix+7),a
        cp      134
        jp      c,.miramos_mas_datos

        xor     a
        ld      (ix+7),a
        
.miramos_mas_datos:

        ld      a,(ix+11)
        cp      00010000B
        jp      z,.velocidad_lenta

.velocidad_rapida:

        ld      b,a
        
        ld      a,(ix+5)
        inc     a
        and     01111111B
        ld      (ix+5),a

        cp      01111111b
        
        call    nc,NUEVO_PROYECTIL_NORMAL_SI_NO_BLINDADO
        
        ld      a,(ix+10)
        and     00000111B
        jp      .comun

.velocidad_lenta:

        ld      b,a
        ld      a,(ix+10)

.comun:
        
        cp      b
        jp      c,.SECUENCIA_COVID_2

.SECUENCIA_COVID_1:

        ld      a,62*4
        ld      (ix+8),a
        jp      .SECUENCIA_COVID_CONTINUA

.SECUENCIA_COVID_2:

		ld		a,(ix+13)
		or		a
		jp		nz,.SECUENCIA_COVID_1

        ld      a,9
        ld      c,3
        call    A_31_DESDE_10       

        ld      a,63*4
        ld      (ix+8),a

.SECUENCIA_COVID_CONTINUA:

        ld      a,(ix+4)
        inc     a
        and     00000111B
        ld      (ix+4),a
        or      a
        jp      nz,.seguimos_la_secuencia_covid

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a

.seguimos_la_secuencia_covid:

        ld      a,(ix+10)
        and     00001111B
        or      a
        jp      nz,.FIN_SECUENCIA_COVID

.suma_posicion:

        ld      a,(ix+1)
        dec     a
        ld      (ix+1),a
        
.FIN_SECUENCIA_COVID:

        ld      a,(ix+10)
        inc     a
        and     00011111B
        ld      (ix+10),a

		ld		a,(ix+9)
		cp		1
        jp      nz,TROZOS_COMUNES_28

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		sub		20
		ld		b,a
		ld		a,(ix+1)
		cp		b
		jp		z,.COVID_ABAJO_CAMBIA_SECUENCIA
		inc		a
		cp		b
		jp		z,.COVID_ABAJO_CAMBIA_SECUENCIA
		inc		a
		cp		b
		jp		z,.COVID_ABAJO_CAMBIA_SECUENCIA
		inc		a
		cp		b
		jp		nz,TROZOS_COMUNES_28

.COVID_ABAJO_CAMBIA_SECUENCIA:

		ld		a,2
		ld		(ix+9),a
		ld		a,30
		ld		(ix+13),a
		jp		TROZOS_COMUNES_28

SLIMES:

.DEFINE_SLIME_AZUL_BAJANDO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_BAJANDO
        jp      .comun_slimes

.DEFINE_SLIME_BLANCO:
        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_BLANCO
        jp      .comun_slimes

.DEFINE_SLIME_AZUL_QUIETO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_QUIETO
        jp      .comun_slimes

.DEFINE_SLIME_AZUL_HACIA_DERECHA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_HACIA_DERECHA
        jp      .comun_slimes

.DEFINE_SLIME_AZUL_HACIA_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_HACIA_IZQUIERDA
        jp      .comun_slimes

.DEFINE_SLIME_VERDE_BAJANDO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_VERDE_BAJANDO        
        jp      .comun_slimes

.DEFINE_SLIME_VERDE_HACIA_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_VERDE_HACIA_IZQUIERDA  
        jp      .comun_slimes

.DEFINE_SLIME_FUEGO_HACIA_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_FUEGO_HACIA_IZQUIERDA  
        jp      .comun_slimes

.DEFINE_SLIME_FUEGO_QUIETO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_FUEGO_QUIETO
        jp      .comun_slimes

.DEFINE_SLIME_FUEGO_RONDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_FUEGO_RONDA
        jp      .comun_slimes

.comun_slimes:

        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a

		xor		a
		ld		(ECTOPALLERS_ACTIVO),a

        call    TROZOS_COMUNES_1

        ld      a,(ix+2)
        cp      12
        jp      z,.verde1
        cp      16
        jp      z,.blanco1
        cp      18
        jp      z,.fuego1

.azul1:

		ld		hl,COLOR_SLIME_AZUL_1_1	
        jp      .tras_color_slime_1

.blanco1:

        ld      hl,COLOR_SLIME_BLANCO_1
        jp      .tras_color_slime_1

.fuego1:

        ld      hl,COLOR_SLIME_FUEGO_1
        jp      .tras_color_slime_1

.verde1:
		ld		hl,COLOR_SLIME_VERDE_1_1	

.tras_color_slime_1:

        call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 		ld		a,(SPRITE_QUE_TOCA)	
 [2]	rlc		a
		ld		(ix+3),a

        call    TROZOS_COMUNES_3
        ld      a,(ix+2)
        cp      12
        jp      z,.verde2
        cp      16
        jp      z,.blanco2
        cp      18
        jp      z,.fuego2
.azul2:

		ld		hl,COLOR_SLIME_AZUL_1_2	
        jp      .tras_color_slime_2

.blanco2:

        ld      hl,COLOR_SLIME_BLANCO_2
        jp      .tras_color_slime_2


.verde2:
		ld		hl,COLOR_SLIME_VERDE_1_2	
        jp      .tras_color_slime_2

.fuego2:
		ld		hl,COLOR_SLIME_FUEGO_2

.tras_color_slime_2:

        call    TROZOS_COMUNES_7

        jp      UN_NUEVO_ENEMIGO.RESOLUCION

.SECUENCIA_SLIME_BLANCO_HACIA_DEPH:

        ld      a,(ix+11)
        inc     a
        and     00000001B
        or      a
        jp      nz,.correccion_del_limite_dos

        ld      a,(X_DEPH)
        ld      b,a
        ld      a,(ix)
        cp      b
        jp      c,.hacia_derecha

.hacia_izquierda:

        dec     a
        jp      .correccion_del_limite

.hacia_derecha:

        inc     a

.correccion_del_limite:

        ld      (ix),a

.correccion_del_limite_dos:

        ld      a,(ix+11)
        inc     a
        and     00000111B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME
        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_ABAJO:

        ld      a,(ix+11)
        inc     a
        and     00000111B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a
        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_DERECHA:

        ld      a,(ix+11)
        inc     a
        and     00000011B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME

        ld      a,(ix)
        inc     a
        ld      (ix),a
        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_IZQUIERDA:

        ld      a,(ix+11)
        inc     a
        and     00000011B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME

        ld      a,(ix)
        dec     a
        ld      (ix),a

        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_RONDA:

        ld      a,(ix+7)
        or     a
        jp      nz,.RONDA_FASE_2

.RONDA_FASE_1:

        ld      a,(ix)
        add     1
        ld      (ix),a
        jp      .RONDA_FINAL

.RONDA_FASE_2:

        ld      a,(ix)
        sub     1
        ld      (ix),a

.RONDA_FINAL:

        ld      a,(ix+13)
        inc     a
        and     00011111b
        ld      (ix+13),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME
        ld      a,(ix+7)
        inc     a
        and     00000001b
        ld      (ix+7),a

.SECUENCIA_SLIME_QUIETO:

        ;       NO HACE NADA DE MOVIMIENTO
        
.FIN_SECUENCIA_SLIME:

        ld      a,(ix+10)
        inc     a
        and     00111111B
        ld      (ix+10),a

        cp      00011111B
        jp      c,.fotograma_dos_slime

.fotograma_uno_slime:

        call    TROZOS_COMUNES_16
        jp      .saliendo

.fotograma_dos_slime:

        call   	TROZOS_COMUNES_17

.saliendo:

        ld      a,(ix+9)
        cp      2
        jp      z,.nivel3
        cp      1
        jp      z,.nivel2

.nivel1:
        
        ld      a,(ix+5)
        inc     a
        and     01111111B
        ld      (ix+5),a

        cp      01111111b
        jp      .seguimos_slime

.nivel2:
        
        ld      a,(ix+5)
        inc     a
        and     00111111B
        ld      (ix+5),a

        cp      00111111b
        jp      .seguimos_slime

.nivel3:
        
        ld      a,(ix+5)
        inc     a
        and     00011111B
        ld      (ix+5),a

        cp      00011111b
        jp      .seguimos_slime

.seguimos_slime:

        call    z,NUEVO_PROYECTIL_NORMAL_SI_NO_BLINDADO
        jp      TROZOS_COMUNES_23
ECTO_PALLERS:

.DEFINE_ECTO_PALLERS_TOCA_HUEVOS:

		ld		a,2
		ld		(ECTOPALLERS_ACTIVO),a
		xor		a
		ld		(ECTO_HUEVOS_GOLPES),a
		ld		(ECTO_HUEVOS_EXPLOSION),a
		ld		(ECTO_HUEVOS_RESPAWN),a
		ld		(ECTO_HUEVOS_SCROLL_ANT),a
		ld		(ECTO_HUEVOS_X),a

		ld		a,b		
        ld		hl,VALORES_BASICOS_ECTO_PALLER_TOCA_HUEVOS
        call    STANDAR_LDIR_ENEMIGOS
        call    TROZOS_COMUNES_1

		ld		a,(ix+1)
		add		68
		ld		(ix+14),a
		ld		a,2
		ld		(ix+10),a
		ld		a,24
		ld		(ix+11),a
		ld		hl,COLORES_ECTO_PALLERS_1
        call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 		ld		a,(SPRITE_QUE_TOCA)	
 [2]	rlc		a
		ld		(ix+3),a

        call    TROZOS_COMUNES_3
		ld		hl,COLORES_ECTO_PALLERS_2	
        jp	    TROZOS_COMUNES_9

.DEFINE_ECTO_PALLERS_CIRCLE:

		push	bc

		ld		a,1
		ld		(ECTOPALLERS_ACTIVO),a

		ld		a,b
		
        ld		hl,VALORES_BASICOS_ECTO_PALLER_CIRCLE


        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
		ld		(ix+13),a
		pop		bc
		ld		(ix+10),c
		ld		a,c
 [4]	rrca
		and		00000111b
		ld		b,a
		ld		a,(ECTOPALLER_ROMPE_HORIZONTAL)
		cp		b
		jr		z,.ECTO_ROMPE_HORIZONTAL
		ld		a,(ECTOPALLER_ROMPE_VERTICAL)
		cp		b
		jr		z,.ECTO_ROMPE_VERTICAL
		xor		a
		jr		.GUARDA_MODO_ECTO_CIRCLE

.ECTO_ROMPE_HORIZONTAL:

		ld		a,1
		jr		.GUARDA_MODO_ECTO_CIRCLE

.ECTO_ROMPE_VERTICAL:

		ld		a,2

.GUARDA_MODO_ECTO_CIRCLE:

		ld		(ix+9),a
		xor		a
		ld		(ix+11),a
        call    TROZOS_COMUNES_1

		ld		hl,COLORES_ECTO_PALLERS_1
        call    TROZOS_COMUNES_7

		ld		a,(ix+1)
		ld		(ix+14),a
        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 		ld		a,(SPRITE_QUE_TOCA)	
 [2]	rlc		a
		ld		(ix+3),a

        call    TROZOS_COMUNES_3
		ld		hl,COLORES_ECTO_PALLERS_2	
        jp	    TROZOS_COMUNES_9

.SECUENCIA_ECTO_PALLER_CIRCLE:

		ld		a,(ix+10)
		or		a
		jp		nz,.REDUCE_VALOR_ARRANQUE_ECTO_PALLER

		ld		a,(ix+9)
		cp		3
		jp		z,.CRUZA_ECTO_HORIZONTAL
		cp		4
		jp		z,.CRUZA_ECTO_VERTICAL
		cp		1
		jr		nz,.MIRA_ROMPE_VERTICAL_ECTO

		ld		a,(ix+7)
		cp		32
		jr		nz,.SIGUE_CIRCULO_ECTO
		ld		a,3
		ld		(ix+9),a
		xor		a
		ld		(ix+11),a
		call    TROZOS_COMUNES_17
		jp		.CRUZA_ECTO_HORIZONTAL

.MIRA_ROMPE_VERTICAL_ECTO:

		cp		2
		jr		nz,.SIGUE_CIRCULO_ECTO

		ld		a,(ix+7)
		cp		64
		jr		nz,.SIGUE_CIRCULO_ECTO
		ld		a,4
		ld		(ix+9),a
		xor		a
		ld		(ix+11),a
		jp		.CRUZA_ECTO_VERTICAL

.SIGUE_CIRCULO_ECTO:

		push	iy
		ld		iy,TABLA_MOVIMIENTO_ECTO
		ld      a,(ix+7) ;el contador
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(iy)
		ld		b,a
		ld		a,(ix+13) ;x fija
		add		b
		ld		(ix),a
		ld		a,(iy+1)
		ld		b,a
		ld		a,(ix+14) ; y fija
		add		b
		ld		(ix+1),a
		pop		iy

		ld		a,(ix+5)
		inc		a
		and		00000001b
		ld		(ix+5),a
		or		a
		jp		nz,TROZOS_COMUNES_23

		ld		a,(ix+7)
		add		2
		and		01111111B
		ld		(ix+7),a

		cp		30
		jp		z,.MIRA_DERECHA
		cp		94
		jp		z,.MIRA_IZQUIERDA
		jp		TROZOS_COMUNES_23

.MIRA_DERECHA:

        call    TROZOS_COMUNES_17
		jp		TROZOS_COMUNES_23

.MIRA_IZQUIERDA:
        call    TROZOS_COMUNES_16
		jp		TROZOS_COMUNES_23

.REDUCE_VALOR_ARRANQUE_ECTO_PALLER:

		dec		a
		ld		(ix+10),a
		ld		a,255
		ld		(ix),a
		jp		TROZOS_COMUNES_23

.CRUZA_ECTO_HORIZONTAL:

		ld		a,(ix+11)
		cp		128
		jr		z,.FIN_CRUCE_ECTO_HORIZONTAL
		ld		b,a
		ld		a,(ix+13)
		add		b
		ld		(ix),a
		ld		a,(ix+14)
		add		64
		ld		(ix+1),a
		ld		a,(ix+11)
		add		2
		ld		(ix+11),a
		jp		TROZOS_COMUNES_23

.FIN_CRUCE_ECTO_HORIZONTAL:

		ld		a,5
		ld		(ix+9),a
		xor		a
		ld		(ix+11),a
		ld		(ix+5),a
		ld		a,96
		ld		(ix+7),a
		jp		TROZOS_COMUNES_23

.CRUZA_ECTO_VERTICAL:

		ld		a,(ix+11)
		cp		128
		jr		z,.FIN_CRUCE_ECTO_VERTICAL
		ld		b,a
		ld		a,(ix+13)
		add		64
		ld		(ix),a
		ld		a,127
		sub		b
		ld		b,a
		ld		a,(ix+14)
		add		b
		ld		(ix+1),a
		ld		a,(ix+11)
		add		2
		ld		(ix+11),a
		jp		TROZOS_COMUNES_23

.FIN_CRUCE_ECTO_VERTICAL:

		ld		a,5
		ld		(ix+9),a
		xor		a
		ld		(ix+11),a
		ld		(ix+5),a
		ld		(ix+7),a
		jp		TROZOS_COMUNES_23

.SECUENCIA_ECTO_PALLERS_TOCA_HUEVOS:

		ld		a,(ECTO_HUEVOS_EXPLOSION)
		or		a
		jp		nz,.ECTO_HUEVOS_EXPLOTANDO
		ld		a,(ECTO_HUEVOS_RESPAWN)
		or		a
		jp		nz,.ECTO_HUEVOS_OCULTO

		ld		a,(ix+4)
		inc		a
		and		00000001b
		ld		(ix+4),a
		or		a
		jp		nz,.SALIENDO_ECTO_HUEVOS

		ld		a,(ECTO_PARALIZADO)
		or		a
		jp		z,.EMPIEZA_SECUENCIA
		cp		1
		jp		nz,.PARALIZAHUEVOS

		call	CARGA_ECTO_PALLER

.PARALIZAHUEVOS:

		ld		a,(ECTO_PARALIZADO)
		dec		a
		and		01111111b
		ld		(ECTO_PARALIZADO),a

		ld		a,24
		ld		c,2
        call    A_31_DESDE_10  

		ld		a,(ix+13)
		inc		a
		and		00000001B
		ld		(ix+13),a

		or		a
		jp		z,.mueve_derecha

.mueve_izquierda:

		ld		a,(ix)
		sub		2
		ld		(ix),a
		jp		.PARALIZAHUEVOS_2

.mueve_derecha:

		ld		a,(ix)
		add		2
		ld		(ix),a

.PARALIZAHUEVOS_2:

; Crear secuencia para que se quede en el sitio

		ld		a,(PUNTO_DEL_SCROLL)
		ld		b,a
		ld		a,(ix+5)
		add		b
		ld		(ix+1),a

; Hasta aquí, sustituyend el código anterior

		jp		.SALIENDO_ECTO_HUEVOS

.EMPIEZA_SECUENCIA:

; PASEANDO

		call	.ACTUALIZA_VELOCIDAD_ECTO_HUEVOS
		ld		a,(ix+5)
		or		a
		jp		z,.A_LA_DERECHA

.A_LA_IZQUIERDA:

		ld		b,(ix+10)
		ld		a,(ix)
		sub		b
		ld		(ix),a
		cp		16
		jp		nc,.DIBUJAMOS_IZ

		xor		a
		ld		(ix+5),a

.DIBUJAMOS_IZ:

        call    TROZOS_COMUNES_16
		jp		.MANTIENE_EN_LINEA

.A_LA_DERECHA:

		ld		b,(ix+10)
		ld		a,(ix)
		add		b
		ld		(ix),a
		cp		14*16
		jp		c,.DIBUJAMOS_DE

		xor		1
		ld		(ix+5),a

.DIBUJAMOS_DE:

        call    TROZOS_COMUNES_17
		jp		.MANTIENE_EN_LINEA

.ACTUALIZA_VELOCIDAD_ECTO_HUEVOS:

		ld		a,(ix+11)
		dec		a
		ld		(ix+11),a
		ret		nz

		ld		a,r
		and		00000011b
		inc		a
		ld		(ix+10),a

		ld		a,r
		and		00011111b
		add		16
		ld		(ix+11),a
		ret

.MANTIENE_EN_LINEA:

		ld		a,(ix+9)
		or		a
		jp		z,.paseo_superior
		cp		1
		jp		z,.paseo_la_u

.paseo_la_u:

		ld		a,(ix+14)
		push	ix
		ld		ix,TABLA_ECTO_HUEVOS_U
		jp		.paseo_continua

.paseo_superior:

		ld		a,(ix+14)
		push	ix
		ld		ix,TABLA_ECTO_HUEVOS_Y

.paseo_continua:

		ld		d,0
		ld		e,a
		cp		1
		call	z,.FX_ECTO_PUNTO_1
		add		ix,de
		ld		a,(ix)
		pop		ix
		ld		b,a
		ld		a,(PUNTO_DEL_SCROLL)
		add		b
		ld		(ix+1),a

		ld		a,(ix+14)
		inc		a
		ld		b,01111111b
		ld		c,a
		ld		a,(ix+9)
		or		a
		jp		z,.aplica_mascara_ecto_huevos
		ld		b,00111111b

.aplica_mascara_ecto_huevos:

		ld		a,c
		and		b
		ld		(ix+14),a
			
.ECTO_HUEVOS_CONTINUA:

		ld		a,(ix+7)
		inc		a
		and		01111111b
		ld		(ix+7),a
		or		a
		jp      nz,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

		ld		a,(ix+9)
		inc		a
		and		00000001b
		ld		(ix+9),a
		xor		a
		ld		(ix+14),a

.SALIENDO_ECTO_HUEVOS:

		jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.ECTO_HUEVOS_EXPLOTANDO:

		call	.OCULTA_SEGUNDO_SPRITE_ECTO_HUEVOS
		ld		a,(ECTO_HUEVOS_EXPLOSION)
		dec		a
		ld		(ECTO_HUEVOS_EXPLOSION),a
		jp		z,.ECTO_HUEVOS_EMPIEZA_RESPAWN
		cp		10
		ld		a,23*4
		jr		nc,.ECTO_HUEVOS_GUARDA_FRAME_EXPLOSION
		ld		a,24*4

.ECTO_HUEVOS_GUARDA_FRAME_EXPLOSION:

		ld		(ix+8),a
		jp		.SALIENDO_ECTO_HUEVOS

.ECTO_HUEVOS_EMPIEZA_RESPAWN:

		ld		a,250
		ld		(ECTO_HUEVOS_RESPAWN),a
		xor		a
		ld		(ix+8),a
		call	.OCULTA_SEGUNDO_SPRITE_ECTO_HUEVOS
		jp		.SALIENDO_ECTO_HUEVOS

.ECTO_HUEVOS_OCULTO:

		dec		a
		ld		(ECTO_HUEVOS_RESPAWN),a
		jp		nz,.SALIENDO_ECTO_HUEVOS

		ld		a,(ECTO_HUEVOS_X)
		ld		(ix),a
		call	STANDAR_Y_FUERA_PANTALLA
		ld		a,8
		ld		(ix+2),a
		ld		a,255
		ld		(ix+4),a
		xor		a
		ld		(ix+5),a
		ld		(ix+7),a
		ld		(ix+9),a
		ld		(ix+13),a
		ld		a,(ix+1)
		add		68
		ld		(ix+14),a
		ld		a,18
		ld		(ix+6),a
		ld		a,2
		ld		(ix+10),a
		ld		a,24
		ld		(ix+11),a
		ld		a,50*4
		ld		(ix+8),a
		ld		(ix+15),a
		xor		a
		ld		(ECTO_HUEVOS_GOLPES),a
		ld		(ECTO_PARALIZADO),a
		call	CARGA_ECTO_PALLER
		call	.RESTAURA_COLORES_ECTO_HUEVOS
		jp		.EMPIEZA_SECUENCIA

.OCULTA_SEGUNDO_SPRITE_ECTO_HUEVOS:

		ld		iy,PROPIEDADES_PATRON_SPRITE
		ld		a,217
		ld		(iy),a
		ld		a,255
		ld		(iy+1),a
		xor		a
		ld		(iy+2),a
		jp		PATRONES_SPRITE_SECUNDARIO

.RESTAURA_COLORES_ECTO_HUEVOS:

		ld		a,(ix+12)
		call	TROZOS_COMUNES_3
		ld		hl,COLORES_ECTO_PALLERS_1
		call	TROZOS_COMUNES_7
		
		ld		a,(ix+3)
		call	TROZOS_COMUNES_3
		ld		hl,COLORES_ECTO_PALLERS_2
		jp		TROZOS_COMUNES_7

.FX_ECTO_PUNTO_1:

		push	de
		ld		a,33
		ld		c,2
		call	A_31_DESDE_10
		pop		de
		ret
FIREWORKS:

.DEFINE_FIREWORKS:

        ld      a,b
        ld		hl,VALORES_BASICOS_FIREWORKS

       	call    STANDAR_LDIR_ENEMIGOS


        call    TROZOS_COMUNES_1
		ld		a,r
		ld		b,a
		ld		a,i
		add		b
		rla
		ld		(ix+1),a
		ld		a,r
		ld		b,a
		ld		a,i
		add		b
		rla		
		ld		(ix),a

		ld		hl,COLOR_FIREWORKS						; Damos color al sprite en la posición de sprite que le toca	
		call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE
        call    STANDAR_DA_EL_VALOR_SPRITE_QUE_TOCA_IX3
        call    TROZOS_COMUNES_3
		ld		hl,COLOR_FIREWORKS
		jp      TROZOS_COMUNES_9

.SECUENCIA_FIREWORKS:

		ld		a,(ix+13)
		inc		a
		and		00000111b
		ld		(ix+13),a
		or		a
		jp		nz,TROZOS_COMUNES_28
		ld		a,(ix+8)
		add		8
		ld		(ix+8),a
		cp		156
		jp		nc,TROZOS_COMUNES_29
        jp      TROZOS_COMUNES_28

CORVELLINIS:

.DEFINE_CORVELLINI_DERECHA:

        ld      a,b
		push	bc
        ld      hl,VALORES_BASICOS_CORVELLINI_4_DERECHA
        jp      .UNION_CORV

.DEFINE_CORVELLINI_IZQUIERDA:

        ld      a,b
		push	bc
        ld      hl,VALORES_BASICOS_CORVELLINI_4_IZQUIERDA
        jp      .UNION_CORV

.UNION_CORV:

		push	af
		xor		a
		ld		(MEGADEATH_ACTIVO),a
		pop		af

        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
		call	STANDAR_Y_FUERA_PANTALLA
		pop		bc
		ld		a,(ix+1)
		add		c
		ld		(ix+1),a

.COMUN_CORVELLINI:

        xor     a
        call    TROZOS_COMUNES_2

		push	af
		ld		a,(FASE)
		cp		4
		jp		nz,.COLOR_CORVELLINI_GENERAL

.COLOR_CORVELLINI_EN_STAGE_4:

		pop		af
		ld		hl,COLOR_CORVELLINI_S4    				; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.COLOR_CORVELLINI_GENERAL:

		pop		af
		ld		hl,COLOR_CORVELLINI     				; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.SECUENCIA_CORVELLINI:

;MIRAMOS_SU_FASE:

		ld		a,(ix+3)
		or		a
		jp		nz,.FASE_TRES

.CAMBIAMOS_LA_FASE_SI_ES_MENESTER:

		ld		a,(Y_DEPH)
		ld		b,a
		ld		a,(ix+1)
		cp		b
		jp		z,.FASE_DOS
		inc		a
		cp		b
		jp		z,.FASE_DOS
		sub		2
		cp		b
		jp		z,.FASE_DOS

.FASE_UNO:

        ld      a,(ix+10)
        inc     a
        and     00111111B
        ld      (ix+10),a

        cp      00000011B
        jp      c,.FOTOGRAMA_DOS

.FOTOGRAMA_UNO:

        ld      a,(ix+15)
        jp      .SALIENDO_CORVELLINI

.FOTOGRAMA_DOS:

        ld      a,(ix+15)
        add     8

.SALIENDO_CORVELLINI:

        ld      (ix+8),a

		ld		a,(ix)
		cp		250
		jp		nc,TROZOS_COMUNES_29
        jp      TROZOS_COMUNES_28

.FASE_DOS:

		ld		a,(X_DEPH)
		ld		b,a
		ld		a,(ix)
		cp		b
		jp		nc,.HACIA_IZQUIERDA

.HACIA_DERECHA:

		ld		a,1
		ld		(ix+3),a
		jp		.FASE_TRES

.HACIA_IZQUIERDA:

		ld		a,2
		ld		(ix+3),a

.FASE_TRES:

        ld      a,11
        ld      c,3
        call    A_31_DESDE_10

		ld		a,(ix+3)
		cp		1
		jp		nz,.REDUCE_X

.AUMENTA_X:

		ld		a,(ix)
		inc		a
		ld		(ix),a
		jp		.ULTIMO_FOTOGRAMA

.REDUCE_X:

		ld		a,(ix)
		dec		a
		ld		(ix),a

.ULTIMO_FOTOGRAMA:

		ld		a,(ix+3)
		cp		1
		jp		nz,.MIRA_IZQUIERDA

.MIRA_DERECHA:

       	ld      a,(ix+10)
        inc     a
        and     00000111B
        ld      (ix+10),a

        cp      00000011B
        jp      c,.FOTOGRAMA_D_CUATRO

.FOTOGRAMA_D_TRES:

        ld      a,58*4
		jp		.SALIENDO_CORVELLINI

.FOTOGRAMA_D_CUATRO:

        ld      a,60*4 
		jp		.SALIENDO_CORVELLINI

.MIRA_IZQUIERDA:

       	ld      a,(ix+10)
        inc     a
        and     00000111B
        ld      (ix+10),a

        cp      00000011B
        jp      c,.FOTOGRAMA_I_CUATRO

.FOTOGRAMA_I_TRES:

        ld      a,59*4
		jp		.SALIENDO_CORVELLINI

.FOTOGRAMA_I_CUATRO:

        ld      a,61*4 
		jp		.SALIENDO_CORVELLINI

GARGOLAS:

.DEFINE_GARGOLA:

        ld      a,b
        ld		hl,VALORES_BASICOS_GARGOLA

        call    STANDAR_LDIR_ENEMIGOS
		add		8
        ld      (ix),a
		ld		a,(ix+1)
		add		10
		ld		(ix+1),a

        call    TROZOS_COMUNES_1
		ld		hl,COLOR_COVID_1_1						; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.SECUENCIA_GARGOLA:

; MIRAMOS_SI_DISPARA

		ld		a,(ix+5)
		dec		a
		and		00111111b
		ld		(ix+5),a
		or		a
		jp		nz,.NO_DISPARA

.DISPARA:

		call	NUEVO_PROYECTIL_NORMAL_SI_NO_BLINDADO

.NO_DISPARA:

		jp		TROZOS_COMUNES_28	

CARGA_SPRITES_1_A_45_STANDARD:

			ld		a,(SUMA_CAMINO)
			or		a
			jp		nz,MARCA_REAPLICA_VAGON_RET

			ld		hl,TODOS_LOS_SPRITES										; Depositamos los sprites en vram	
			call	CARGA_COMUN_45
			call	MARCA_REAPLICA_VAGON_RET
			ld		a,(ARMA_USANDO)
			cp		2
			jp		z,CARGA_FLECHA_DOBLE
			ret

ACTIVAMOS_INTERRUPCIONES_DE_LINEA_REAL:

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

REVISA_LETRAS_DE_LA_FASE_REAL:

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

REVISA_LETRAS_DE_TODAS_LAS_FASES_REAL:

		ld		a,(LETRAS_FASES_BITS)
		cp		#ff
		jr		nz,.SALTAMOS_EXTRA
		ld		a,(LETRAS_FASES_BITS+1)
		cp		#ff
		jr		nz,.SALTAMOS_EXTRA
		ld		a,(LETRAS_FASES_BITS+2)
		and		#0f
		cp		#0f
		ret		z

.SALTAMOS_EXTRA:

		push	hl
		ld		hl,16
		ld		(LINEA_A_LEER),hl
		pop		hl
		ret

CONTROL_BUCLES_INICIO_BUCLE_REAL:

		xor		a
		ld		(SUMA_BUCLE),a
		ld		hl,(LINEA_A_LEER)
		inc		hl
		ld		(LINEA_DE_REGRESO_BUCLE),hl
		ret

CONTROL_BUCLES_CONTROL_IZQUIERDA_REAL:

		ld		a,(X_DEPH)
		cp		5*16
		ret		nc
		ld		a,(SUMA_BUCLE)
		inc		a
		ld		(SUMA_BUCLE),a
		ret

CONTROL_BUCLES_CONTROL_CENTRO_REAL:

		ld		a,(X_DEPH)
		cp		5*16
		ret		c
		cp		11*16
		ret		nc
		ld		a,(SUMA_BUCLE)
		inc		a
		ld		(SUMA_BUCLE),a
		ret

CONTROL_BUCLES_CONTROL_DERECHA_REAL:

		ld		a,(X_DEPH)
		cp		11*16
		ret		c
		ld		a,(SUMA_BUCLE)
		inc		a
		ld		(SUMA_BUCLE),a
		ret

CARGA_1_A_45_REAL:

			call    PAGE_10_A_SEGMENT_2
			call	CARGA_SPRITES_1_A_45_STANDARD
			ld		a,(FASE)
			cp		3
			ret		nz
			jp		PRECARGA_SOLO_VAGONETA_EN_PATRONES_ALTOS

CARGA_1_A_45_FASE_3_REAL:

			call    PAGE_10_A_SEGMENT_2
			call    CARGA_SPRITES_1_A_45_STANDARD
			jp		PRECARGA_SOLO_VAGONETA_EN_PATRONES_ALTOS

CARGA_PIES_EN_LODO_REAL:

			ld		hl,SPRITES_BARRO_DEPH
			ld		de,#4000+5*8*4
			ld		bc,18*8*4
			jp		TROZOS_COMUNES_15

SPRITES_VAGONETA_APLASTADA:
	;
	; --- APLASTADO SUP IZQ
	; mask 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$05,$00,$00,$00
	DB $00,$07,$02,$06,$0E,$0E,$3E,$2E
	DB $3E,$2E,$27,$08,$F7,$78,$1F,$0F

	; mask 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $01,$00,$00,$05,$0F,$05,$00,$00
	DB $00,$00,$07,$0D,$3B,$39,$53,$F3
	DB $FF,$FB,$7F,$FF,$FF,$87,$E1,$1F

	;
	; --- APLASTADO SUP DER
	; mask 0
	DB $80,$80,$B0,$BC,$BC,$BC,$BC,$B8
	DB $BC,$38,$F4,$08,$F7,$0F,$FC,$F8
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$D0,$00,$00,$00

	; mask 1
	DB $00,$70,$5C,$6E,$6E,$E2,$66,$F7
	DB $FE,$EC,$FE,$FF,$FD,$F2,$0F,$FC
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$D0,$F8,$D0,$80,$00

	;
	; --- APLASTADO INF IZQ
	; mask 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $1F,$3F,$5E,$C0,$60,$40,$80,$80
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; mask 1
	DB $00,$00,$00,$01,$00,$00,$01,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $3F,$7F,$F9,$BE,$D0,$E0,$C0,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	;
	; --- APLASTADO INV DER
	; mask 0
	DB $F8,$FF,$7F,$7F,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$E0,$80,$80,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; mask 1
	DB $F7,$F8,$FF,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $F8,$10,$60,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

SPRITES_CAIDA_1:
	;
	; --- CAIDA 1 SUP IZQ
	; mask 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$01,$01,$07,$07,$03
	DB $0F,$0B,$0F,$0B,$09,$02,$7D,$1E

	; mask 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$07,$0F,$0E,$0E
	DB $14,$3C,$7F,$3E,$1F,$7F,$FF,$61

	;
	; --- CAIDA 1 SUP DER
	; mask 0
	DB $00,$00,$00,$C0,$C0,$F0,$F0,$F0
	DB $F8,$E8,$F8,$E8,$D8,$20,$DF,$3C
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; mask 1
	DB $00,$00,$00,$00,$70,$B8,$B8,$88
	DB $94,$DE,$FF,$BE,$FC,$FF,$F7,$CB
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$80,$00

	;
	; --- CAIDA 1 INF IZQ
	; mask 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $7F,$38,$38,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; mask 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $FE,$77,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	;
	; --- CAIDA 1 INF DER
	; mask 0
	DB $FE,$1C,$1C,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; mask 1
	DB $FD,$FE,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

SPRITES_CAIDA_2:

	;
	; --- CAIDA 2 SUP IZQ
	; mask 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$01,$03,$07,$03
	; mask 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	;
	; --- CAIDA 2 SUP DER
	; mask 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$80,$80,$80,$80,$80,$80
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; mask 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$40,$E0,$F0,$E0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	;
	; --- CAIDA 2 INF IZQ
	; mask 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $0E,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	; mask 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	;
	; --- CAIDA 2 INF DER
	; mask 0
	DB $70,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	; mask 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00	
COLOR_SPRITES_VAGONETA_APLASTADO:
	;
	; --- APLASTADO SUP IZQ
	; attr 0
	DB $00,$01,$04,$04,$04,$04,$04,$04
	DB $04,$04,$04,$04,$04,$04,$04,$04

	; attr 1
	DB $00,$00,$41,$41,$41,$41,$41,$41
	DB $41,$41,$41,$41,$41,$41,$41,$41
	;
	; --- APLASTADO SUP DER

	; attr 0
	DB $01,$04,$04,$04,$04,$04,$04,$04
	DB $04,$04,$04,$04,$04,$04,$04,$04

	; attr 1
	DB $00,$41,$41,$41,$41,$41,$41,$41
	DB $41,$41,$41,$41,$41,$41,$41,$41
	;
	; --- APLASTADO INF IZQ

	; attr 0
	DB $04,$04,$04,$04,$04,$04,$04,$01
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; attr 1
	DB $41,$41,$41,$41,$41,$41,$41,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	;
	; --- APLASTADO INV DER

	; attr 0
	DB $04,$04,$04,$01,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; attr 1
	DB $41,$41,$41,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

COLOR_SPRITES_VAGONETA_CAIDA_1:
	;
	; --- CAIDA 1 SUP IZQ

	; attr 0
	DB $00,$00,$00,$01,$04,$04,$04,$04
	DB $04,$04,$04,$04,$04,$04,$04,$04

	; attr 1
	DB $00,$00,$00,$00,$41,$41,$41,$41
	DB $41,$41,$41,$41,$41,$41,$41,$41
	;
	; --- CAIDA 1 SUP DER

	; attr 0
	DB $00,$00,$00,$01,$04,$04,$04,$04
	DB $04,$04,$04,$04,$04,$04,$04,$04

	; attr 1
	DB $00,$00,$00,$00,$41,$41,$41,$41
	DB $41,$41,$41,$41,$41,$41,$41,$41
	;
	; --- CAIDA 1 INF IZQ

	; attr 0
	DB $04,$04,$01,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; attr 1
	DB $41,$41,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	;
	; --- CAIDA 1 INF DER

	; attr 0
	DB $04,$04,$01,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00

	; attr 1
	DB $41,$41,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00


COLOR_SPRITES_VAGONETA_CAIDA_:
	;
	; --- CAIDA 2 SUP IZQ

	; attr 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$01,$01,$01,$01
	; attr 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	;
	; --- CAIDA 2 SUP DER

	; attr 0
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$01,$01,$04,$04,$04,$04

	; attr 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$41,$41,$41,$41
	;
	; --- CAIDA 2 INF IZQ

	; attr 0
	DB $01,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	; attr 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	;
	; --- CAIDA 2 INF DER

	; attr 0
	DB $01,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	; attr 1
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
