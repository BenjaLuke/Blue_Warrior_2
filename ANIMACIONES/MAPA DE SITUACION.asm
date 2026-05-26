
.SEGUIMOS:

		di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a
		ei
		call	PARA_MUSICA_MENU_PRESENTACION

		call	FADE_OUT_PRESENTACION
		call	LIMPIA_VRAM_SALIDA_MENU

		call	DISSCR_RAM
		ld		a,5
		call	CHGMOD
		call	DISSCR_RAM

		ld		hl,0
		xor		a
		ld		(ARMA_USANDO),a										; 0 1 2 para flecha 3 4 5 para fuego 6 7 8 para hacha
		ld		(V_DECEN_MIL),a
		ld		(V_UNIDA_MIL),a
		ld		(V_CENTENAS),a
		ld		(V_DECENAS),a
		ld		(V_UNIDADES),a
		ld		(SCORE_REAL),hl
		add		2
		ld		(MAGIAS),a
		ld		(VIDAS),a
		ld		(CORAZONES),a
		inc		a
		ld		(CORAZONES_MAXIMOS),a

		call	DISSCR_RAM

.RECUPERAMOS_INTERRUPCIONES_LIMPIAS:

		di
		ld		a,#C9													; A tiene el valor de ret
		ld		(HTIMI),a												; Colocamos ese ret en el gancho H.Timi POR SI EL ORDENADOR TUVIERA ALGO (ALGUN MSX 2 CONTROL DE DISQUETERA)
		ld		(HKEYI),a												; Colocamos ese ret en el gancho H.Key POR SI EL ORDENADOR TUVIERA ALGO
		ei

.DESACTIVAMOS_INTERRUPCIONES_DE_LINEA_TRAS_EL_MENU:

		di
		ld 		a,(RG0SAV)												; Disable Line Interrupt: Reset R#0 bit 4
		and		11101111B
		ld		(RG0SAV),a
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM
		ei

		call	MAPA_DE_SITUACION

.NOS_VAMOS_AL_JUEGO:

		ld		a,8
		ld      (DIRPA2),a										    ; Banco 1, pagina 3 del MEGAROM
		jp		CARGA_SLOT_JUEGO


MAPA_DE_SITUACION:

		call	DISSCR_RAM
		ld		a,5
		call	CHGMOD
		call	DISSCR_RAM
		call	DESACTIVA_SPRITES_MAPA_DE_SITUACION

		call	CARGA_GRAFICOS_MAPA_DE_SITUACION
		call	PONE_PRIMERA_PALETA_MAPA_DE_SITUACION
		call	LIMPIA_BUFFERS_MAPA_DE_SITUACION

		ld		a,1
		call	SETPAGE

		ld		hl,DATOS_MAPA_INICIAL_IZQUIERDA_PAGE_1
		call	DOCOPY
		call	VDPREADY
		ld		hl,DATOS_MAPA_INICIAL_DERECHA_PAGE_1
		call	DOCOPY
		call	VDPREADY

		call	ENASCR_RAM
		call	INICIA_MUSICA_MAPA_DE_SITUACION
		call	FADE_IN_MAPA_DE_SITUACION
		call	PONE_PALETA_FINAL_MAPA_DE_SITUACION

		ld		hl,DATOS_MAPA_INICIAL_IZQUIERDA_PAGE_3
		call	DOCOPY
		call	VDPREADY
		ld		hl,DATOS_MAPA_INICIAL_DERECHA_PAGE_3
		call	DOCOPY
		call	VDPREADY

		ld		a,107
		ld		(MAPA_SITUACION_LEFT_X),a
		ld		(MAPA_SITUACION_LEFT_X_PAGE_0),a
		ld		(MAPA_SITUACION_LEFT_X_PAGE_1),a
		ld		a,128
		ld		(MAPA_SITUACION_RIGHT_X),a
		ld		(MAPA_SITUACION_RIGHT_X_PAGE_0),a
		ld		(MAPA_SITUACION_RIGHT_X_PAGE_1),a
		ld		a,3
		ld		(MAPA_SITUACION_BUFFER_PAGE),a

.BUCLE_ABRE_MAPA:

		call	AVANZA_POSICION_MAPA_DE_SITUACION
		ld		a,(MAPA_SITUACION_LEFT_X)
		ld		b,a
		ld		a,(MAPA_SITUACION_RIGHT_X)
		call	PINTA_FRAME_MAPA_DE_SITUACION

		ld		a,(MAPA_SITUACION_LEFT_X)
		or		a
		jr		z,.FIN_ABRE_MAPA

		ld		a,(MAPA_SITUACION_RIGHT_X)
		cp		233
		jr		z,.FIN_ABRE_MAPA

		jr		.BUCLE_ABRE_MAPA

.FIN_ABRE_MAPA:

		call	PREPARA_SPRITES_DEPH_MAPA_DE_SITUACION
		call	PAUSA_CON_DEPH_MAPA_DE_SITUACION
		call	OCULTA_DEPH_MAPA_DE_SITUACION

		call	FADE_OUT_MAPA_DE_SITUACION
		call	STOP_MUSICA_MAPA_DE_SITUACION
		call	LIMPIA_4_PAGES_MAPA_DE_SITUACION
		ret


CARGA_GRAFICOS_MAPA_DE_SITUACION:

		di
		ld		a,69
		ld		(DIRPA2),a
		ld		hl,GRAFICOS_MAPA_1
		ld		de,#8000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,70
		ld		(DIRPA2),a
		ld		hl,GRAFICOS_MAPA_2
		ld		de,#C000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta
		ei

		ld		hl,DATOS_MAPA_PAGE_1_A_PAGE_2
		call	DOCOPY
		jp		VDPREADY


DESACTIVA_SPRITES_MAPA_DE_SITUACION:

		di
		ld 		a,(RG8SAV)
		or		00000010B
		ld 		(RG8SAV),a
		ld		b,a
		ld		c,8
		call	WRTVDP_EN_RAM
		ei
		ret


PREPARA_SPRITES_DEPH_MAPA_DE_SITUACION:

		di
		ld 		a,(RG1SAV)
		or		00000010B
		ld 		(RG1SAV),a
		ld		b,a
		ld		c,1
		call	WRTVDP_EN_RAM

		ld 		a,(RG8SAV)
		and		11111101B
		ld 		(RG8SAV),a
		ld		b,a
		ld		c,8
		call	WRTVDP_EN_RAM

		ld 		a,10010111b
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

		ld 		a,00001000b
		ld 		(RG6SAV),a
		ld		b,a
		ld		c,6
		call	WRTVDP_EN_RAM
		ei

		call	CARGA_DEPH_MUSIC_ON

		xor		a
		ld		(INMUNE),a
		ld		(VARIABLE_CARGA_AGUA),a
		ld		(SPRITE_CAIDO),a
		inc		a
		ld		(MUSICA_ON_OFF),a
		call	INICIALIZA_PATRONES_CABEZA_DEPH_MAPA_DE_SITUACION
		ret


INICIA_MUSICA_MAPA_DE_SITUACION:

		call	stpmus

		ld		a,1
		ld		(MUSICA_BEST_ON),a

		ld		a,39
		call	CHANGE_BANK_2

		ld		hl,M_MAP
		ld		(MUSIC_ON),hl

		call	INICIAMOS_MUSICA

		di
		call	strmus
		call	INSTALA_INTERRUPCION_MUSICA_MAPA_DE_SITUACION
		ei

		call	PAGE_10_A_SEGMENT_2
		ret


INSTALA_INTERRUPCION_MUSICA_MAPA_DE_SITUACION:

		ld		a,#C3
		ld		(HTIMI),a
		ld		hl,INTERRUPCION_MUSICA_MAPA_DE_SITUACION
		ld		(HTIMI+1),hl
		ret


INTERRUPCION_MUSICA_MAPA_DE_SITUACION:

		ld		a,(DIRPA2)
		push	af
		ld		a,39
		ld		(DIRPA2),a

		call	musint

		pop		af
		ld		(DIRPA2),a
		ret


STOP_MUSICA_MAPA_DE_SITUACION:

		call	stpmus

		xor		a
		ld		(MUSICA_BEST_ON),a

		call	PAGE_10_A_SEGMENT_2
		ret


INICIALIZA_PATRONES_CABEZA_DEPH_MAPA_DE_SITUACION:

		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		ld		a,4
		ld		(ix+2),a
		add		4
		ld		(ix+6),a
		add		4
		ld		(ix+10),a
		add		4
		ld		(ix+14),a
		ret


PINTA_FRAME_MAPA_DE_SITUACION:

		call	PINTA_FRANJAS_NUEVAS_MAPA_DE_SITUACION
		call	PINTA_IZQUIERDA_MAPA_DE_SITUACION
		call	PINTA_DERECHA_MAPA_DE_SITUACION
		call	GUARDA_POSICION_BUFFER_MAPA_DE_SITUACION

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		call	SETPAGE
		halt

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		cp		1
		jr		z,.CAMBIA_A_PAGE_3

		ld		a,1
		jr		.GUARDA_SIGUIENTE_BUFFER

.CAMBIA_A_PAGE_3:

		ld		a,3

.GUARDA_SIGUIENTE_BUFFER:

		ld		(MAPA_SITUACION_BUFFER_PAGE),a
		ret


AVANZA_POSICION_MAPA_DE_SITUACION:

		ld		a,(MAPA_SITUACION_LEFT_X)
		cp		4
		jr		c,.LEFT_A_CERO
		sub		4
		jr		.GUARDA_LEFT

.LEFT_A_CERO:

		xor		a

.GUARDA_LEFT:

		ld		(MAPA_SITUACION_LEFT_X),a

		ld		a,(MAPA_SITUACION_RIGHT_X)
		cp		230
		jr		nc,.RIGHT_A_FINAL
		add		4
		jr		.GUARDA_RIGHT

.RIGHT_A_FINAL:

		ld		a,233

.GUARDA_RIGHT:

		ld		(MAPA_SITUACION_RIGHT_X),a
		ret


PINTA_FRANJAS_NUEVAS_MAPA_DE_SITUACION:

		call	OBTIENE_POSICION_ANTERIOR_BUFFER_MAPA_DE_SITUACION
		push	bc
		push	de

		ld		a,(MAPA_SITUACION_LEFT_X)
		add		22
		ld		d,a
		ld		a,b
		add		22
		sub		d
		call	nz,PINTA_FRANJA_MAPA_DE_SITUACION

		pop		de
		pop		bc

		ld		a,e
		ld		d,a
		ld		a,(MAPA_SITUACION_RIGHT_X)
		sub		d
		call	nz,PINTA_FRANJA_MAPA_DE_SITUACION
		ret


PINTA_FRANJA_MAPA_DE_SITUACION:

		ld		c,a
		ld		a,d
		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),a
		ld		(ix+1),0
		ld		(ix+2),0
		ld		(ix+3),2
		ld		(ix+4),a
		ld		(ix+5),0
		call	PONE_Y_DESTINO_BUFFER_MAPA_DE_SITUACION
		ld		(ix+8),c
		ld		(ix+9),0
		ld		(ix+10),212
		ld		(ix+11),0
		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),10010000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


OBTIENE_POSICION_ANTERIOR_BUFFER_MAPA_DE_SITUACION:

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		cp		3
		jr		z,.PAGE_3

		ld		a,(MAPA_SITUACION_LEFT_X_PAGE_0)
		ld		b,a
		ld		a,(MAPA_SITUACION_RIGHT_X_PAGE_0)
		ld		e,a
		ret

.PAGE_3:

		ld		a,(MAPA_SITUACION_LEFT_X_PAGE_1)
		ld		b,a
		ld		a,(MAPA_SITUACION_RIGHT_X_PAGE_1)
		ld		e,a
		ret


GUARDA_POSICION_BUFFER_MAPA_DE_SITUACION:

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		cp		3
		jr		z,.PAGE_3

		ld		a,(MAPA_SITUACION_LEFT_X)
		ld		(MAPA_SITUACION_LEFT_X_PAGE_0),a
		ld		a,(MAPA_SITUACION_RIGHT_X)
		ld		(MAPA_SITUACION_RIGHT_X_PAGE_0),a
		ret

.PAGE_3:

		ld		a,(MAPA_SITUACION_LEFT_X)
		ld		(MAPA_SITUACION_LEFT_X_PAGE_1),a
		ld		a,(MAPA_SITUACION_RIGHT_X)
		ld		(MAPA_SITUACION_RIGHT_X_PAGE_1),a
		ret


PINTA_IZQUIERDA_MAPA_DE_SITUACION:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),0
		ld		(ix+1),0
		ld		(ix+2),0
		ld		(ix+3),2
		ld		a,(MAPA_SITUACION_LEFT_X)
		ld		(ix+4),a
		ld		(ix+5),0
		call	PONE_Y_DESTINO_BUFFER_MAPA_DE_SITUACION
		ld		(ix+8),22
		ld		(ix+9),0
		ld		(ix+10),212
		ld		(ix+11),0
		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),10010000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


PINTA_DERECHA_MAPA_DE_SITUACION:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),233
		ld		(ix+1),0
		ld		(ix+2),0
		ld		(ix+3),2
		ld		a,(MAPA_SITUACION_RIGHT_X)
		ld		(ix+4),a
		ld		(ix+5),0
		call	PONE_Y_DESTINO_BUFFER_MAPA_DE_SITUACION
		ld		(ix+8),23
		ld		(ix+9),0
		ld		(ix+10),212
		ld		(ix+11),0
		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),10010000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


PONE_Y_DESTINO_BUFFER_MAPA_DE_SITUACION:

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		ld		(ix+6),0
		ld		(ix+7),a
		ret


LIMPIA_BUFFER_MAPA_DE_SITUACION:

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		cp		3
		jr		z,.PAGE_3

		ld		hl,DATOS_LIMPIA_MAPA_PAGE_1
		jp		DOCOPY

.PAGE_3:

		ld		hl,DATOS_LIMPIA_MAPA_PAGE_3
		jp		DOCOPY


LIMPIA_4_PAGES_MAPA_DE_SITUACION:

		ld		hl,DATOS_LIMPIA_MAPA_PAGE_0
		call	DOCOPY
		call	VDPREADY
		ld		hl,DATOS_LIMPIA_MAPA_PAGE_1
		call	DOCOPY
		call	VDPREADY
		ld		hl,DATOS_LIMPIA_MAPA_PAGE_2
		call	DOCOPY
		call	VDPREADY
		ld		hl,DATOS_LIMPIA_MAPA_PAGE_3
		call	DOCOPY
		jp		VDPREADY


LIMPIA_BUFFERS_MAPA_DE_SITUACION:

		ld		hl,DATOS_LIMPIA_MAPA_PAGE_1
		call	DOCOPY
		call	VDPREADY
		ld		hl,DATOS_LIMPIA_MAPA_PAGE_3
		call	DOCOPY
		jp		VDPREADY


PONE_PRIMERA_PALETA_MAPA_DE_SITUACION:

		ld		hl,PALETA_MAPA_FADE_IN
		jp		SETPALETE


PONE_PALETA_FINAL_MAPA_DE_SITUACION:

		ld		hl,PALETA_MAPA_FIJA
		jp		SETPALETE


FADE_IN_MAPA_DE_SITUACION:

		ld		hl,PALETA_MAPA_FADE_IN+32
		ld		e,6
		jr		BUCLE_FADE_MAPA_DE_SITUACION


FADE_OUT_MAPA_DE_SITUACION:

		ld		hl,PALETA_MAPA_FADE_OUT
		ld		e,7


BUCLE_FADE_MAPA_DE_SITUACION:

		call	SETPALETE
		push	hl
		push	de
		ld		b,6
		call	ESPERA_MAPA_DE_SITUACION_B
		pop		de
		pop		hl
		dec		e
		jr		nz,BUCLE_FADE_MAPA_DE_SITUACION
		ret


PAUSA_CON_DEPH_MAPA_DE_SITUACION:

		call	COLOCA_DEPH_MAPA_DE_SITUACION

		ld		d,25

.BUCLE:

		ld		a,20
		push	de
		call	PINTA_DEPH_MAPA_DE_SITUACION
		pop		de
		ld		b,6
		call	ESPERA_MAPA_DE_SITUACION_B

		ld		a,44
		push	de
		call	PINTA_DEPH_MAPA_DE_SITUACION
		pop		de
		ld		b,6
		call	ESPERA_MAPA_DE_SITUACION_B

		dec		d
		jr		nz,.BUCLE
		ret


COLOCA_DEPH_MAPA_DE_SITUACION:

		ld		a,(FASE)
		dec		a
		add		a,a
		ld		e,a
		ld		d,0
		ld		hl,TABLA_POSICIONES_DEPH_MAPA_DE_SITUACION
		add		hl,de

		ld		a,(hl)
		ld		(X_DEPH),a
		inc		hl
		ld		a,(hl)
		ld		(Y_DEPH),a
		ret


PINTA_DEPH_MAPA_DE_SITUACION:

		ld		(FOTOGRAMA_DEPH),a
		cp		44
		jr		z,.POSE_1

		xor		a
		ld		(FOTOGRAMA_DEPH_EN_ORDEN),a
		call	PINTA_SPRITE_DEPH
		jp		AJUSTA_COLORES_DEPH_MAPA_DE_SITUACION

.POSE_1:

		ld		a,1
		ld		(FOTOGRAMA_DEPH_EN_ORDEN),a
		call	PINTA_SPRITE_DEPH
		jp		AJUSTA_COLORES_DEPH_MAPA_DE_SITUACION


AJUSTA_COLORES_DEPH_MAPA_DE_SITUACION:

		ld		hl,COLORES_SPRITES_DEPH_MAPA
		ld		de,#4800
		ld		bc,64
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		cp		2
		jr		z,.POSE_1
		cp		0
		jr		z,.POSE_3

		ld		hl,COLOR_POSE_0_Y_2_MAPA
		jr		.VUELCA_CUERPO

.POSE_1:

		ld		hl,COLOR_POSE_1_MAPA
		jr		.VUELCA_CUERPO

.POSE_3:

		ld		hl,COLOR_POSE_3_MAPA

.VUELCA_CUERPO:

		ld		de,#4840
		ld		bc,96
		jp		PON_COLOR_2.sin_bc_impuesta


OCULTA_DEPH_MAPA_DE_SITUACION:

		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		ld		(ix),#D8
		ld		(ix+4),#D8
		ld		(ix+8),#D8
		ld		(ix+12),#D8
		ld		(ix+16),#D8
		ld		(ix+20),#D8
		ld		(ix+24),#D8
		ld		(ix+28),#D8
		ld		(ix+32),#D8
		ld		(ix+36),#D8

		ld		hl,ATRIBUTOS_DEPH_VARIABLES
		ld		de,#4A00
		ld		bc,40
		jp		PON_COLOR_2.sin_bc_impuesta


ESPERA_MAPA_DE_SITUACION_B:

		halt
		djnz	ESPERA_MAPA_DE_SITUACION_B
		ret


DATOS_MAPA_PAGE_1_A_PAGE_2:

		dw		#0000,#0100
		dw		#0000,#0200
		dw		#0100,#0100
		db		#00,#00,10010000b


DATOS_MAPA_INICIAL_IZQUIERDA:

		dw		#0000,#0200
		dw		#006B,#0000
		dw		#0016,#00D4
		db		#00,#00,10010000b


DATOS_MAPA_INICIAL_DERECHA:

		dw		#00E9,#0200
		dw		#0080,#0000
		dw		#0017,#00D4
		db		#00,#00,10010000b


DATOS_MAPA_INICIAL_IZQUIERDA_PAGE_1:

		dw		#0000,#0200
		dw		#006B,#0100
		dw		#0016,#00D4
		db		#00,#00,10010000b


DATOS_MAPA_INICIAL_DERECHA_PAGE_1:

		dw		#00E9,#0200
		dw		#0080,#0100
		dw		#0017,#00D4
		db		#00,#00,10010000b


DATOS_MAPA_INICIAL_IZQUIERDA_PAGE_3:

		dw		#0000,#0200
		dw		#006B,#0300
		dw		#0016,#00D4
		db		#00,#00,10010000b


DATOS_MAPA_INICIAL_DERECHA_PAGE_3:

		dw		#00E9,#0200
		dw		#0080,#0300
		dw		#0017,#00D4
		db		#00,#00,10010000b


DATOS_LIMPIA_MAPA_PAGE_0:

		dw		#0000,#0000
		dw		#0000,#0000
		dw		#0100,#0100
		db		#00,#00,11000000b


DATOS_LIMPIA_MAPA_PAGE_1:

		dw		#0000,#0100
		dw		#0000,#0100
		dw		#0100,#0100
		db		#00,#00,11000000b


DATOS_LIMPIA_MAPA_PAGE_2:

		dw		#0000,#0200
		dw		#0000,#0200
		dw		#0100,#0100
		db		#00,#00,11000000b


DATOS_LIMPIA_MAPA_PAGE_3:

		dw		#0000,#0300
		dw		#0000,#0300
		dw		#0100,#0100
		db		#00,#00,11000000b


COLORES_SPRITES_DEPH_MAPA:

		db		$00,$00,$00,$00,$00,$00,$00,$00
		db		$02,$05,$05,$05,$05,$05,$05,$05
		db		$00,$00,$00,$00,$00,$00,$00,$00
		db		$00,$42,$42,$42,$42,$42,$42,$42
		db		$00,$00,$00,$00,$00,$00,$00,$00
		db		$00,$00,$00,$02,$02,$02,$05,$05
		db		$00,$00,$00,$00,$00,$00,$00,$00
		db		$00,$00,$00,$00,$00,$00,$42,$42


COLOR_POSE_0_Y_2_MAPA:

		db		$08,$05,$05,$05,$05,$05,$05,$05
		db		$05,$08,$05,$02,$05,$05,$02,$02
		db		$45,$42,$42,$42,$42,$42,$42,$42
		db		$42,$45,$42,$00,$42,$42,$00,$00
		db		$42,$00,$00,$00,$00,$00,$00,$00
		db		$00,$42,$00,$00,$00,$00,$00,$00
		db		$08,$05,$05,$02,$02,$05,$05,$02
		db		$02,$08,$02,$00,$00,$02,$02,$02
		db		$45,$42,$42,$00,$00,$42,$42,$00
		db		$00,$42,$00,$00,$00,$00,$00,$00
		db		$42,$00,$00,$00,$00,$00,$00,$00
		db		$00,$00,$00,$00,$00,$00,$00,$00


COLOR_POSE_1_MAPA:

		db		$08,$05,$05,$05,$05,$05,$05,$05
		db		$08,$08,$08,$05,$05,$05,$02,$02
		db		$45,$42,$42,$42,$42,$42,$42,$42
		db		$45,$45,$45,$42,$42,$42,$00,$00
		db		$42,$00,$00,$00,$00,$00,$00,$00
		db		$42,$42,$42,$00,$00,$00,$00,$00
		db		$08,$05,$05,$02,$02,$05,$05,$02
		db		$05,$02,$00,$00,$02,$02,$02,$02
		db		$45,$42,$42,$00,$00,$42,$42,$00
		db		$42,$00,$00,$00,$00,$00,$00,$00
		db		$42,$00,$00,$00,$00,$00,$00,$00
		db		$00,$00,$00,$00,$00,$00,$00,$00


COLOR_POSE_3_MAPA:

		db		$08,$05,$05,$05,$05,$05,$05,$05
		db		$05,$08,$05,$05,$05,$05,$02,$02
		db		$45,$42,$42,$42,$42,$42,$42,$42
		db		$42,$45,$42,$42,$42,$42,$00,$00
		db		$42,$00,$00,$00,$00,$00,$00,$00
		db		$00,$42,$00,$00,$00,$00,$00,$00
		db		$08,$05,$05,$02,$05,$05,$02,$02
		db		$08,$08,$08,$02,$00,$02,$02,$02
		db		$45,$42,$42,$00,$42,$42,$00,$00
		db		$42,$42,$42,$00,$00,$00,$00,$00
		db		$42,$00,$00,$00,$00,$00,$00,$00
		db		$00,$00,$00,$00,$00,$00,$00,$00


TABLA_POSICIONES_DEPH_MAPA_DE_SITUACION:

		db		27,83
		db		117,67
		db		199,18
		db		45,162
		db		149,167


PALETA_MAPA_FIJA:
		incbin	"../PALETAS/PRESENTACION/MAPA.palete"
PALETA_MAPA_FADE_IN:
		incbin	"../PALETAS/PRESENTACION/MAPA.fadein"
PALETA_MAPA_FADE_OUT:
		incbin	"../PALETAS/PRESENTACION/MAPA.fadeout"
