
.SEGUIMOS:

		di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a
		ei
		call	PARA_MUSICA_MENU_PRESENTACION_MAPA

		call	FADE_OUT_PRESENTACION_MAPA
		call	LIMPIA_VRAM_SALIDA_MENU_MAPA

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


PARA_MUSICA_MENU_PRESENTACION_MAPA:

		call	stpmus

		xor		a
		ld		(MUSICA_BEST_ON),a

		call	PAGE_10_A_SEGMENT_2
		ret


FADE_OUT_PRESENTACION_MAPA:

		ret


LIMPIA_VRAM_SALIDA_MENU_MAPA:

		ret

MUESTRA_MAPA_TRAS_BOSS:

		call	CONTROL_PREVIO_GRAN_DIAMANTE
		ld		a,(FASE)
		cp		6
		jr		nz,.NO_VA_A_CINEMATICAS_FINALES
		call	PAGE_10_A_SEGMENT_2
		jp		HACIA_CINEMATICAS_FINALES

.NO_VA_A_CINEMATICAS_FINALES:

		call	MAPA_DE_SITUACION
		ld		a,8
		ld      (DIRPA2),a										    ; Banco 1, pagina 3 del MEGAROM
		jp		CARGA_SLOT_JUEGO

CONTROL_PREVIO_GRAN_DIAMANTE:

		ld		a,(FASE)
		dec		a
		jp		z,CONTROL_DEL_GRAN_DIAMANTE
		dec		a
		jr		z,.MIRA_FASE_1
		dec		a
		jr		z,.MIRA_FASE_2
		dec		a
		jr		z,.MIRA_FASE_3
		dec		a
		jr		z,.MIRA_FASE_4
		dec		a
		ret		nz

.MIRA_FASE_5:

		ld		a,(LETRAS_FASES_BITS+2)
		and		#0f
		ret		z
		jp		CONTROL_DEL_GRAN_DIAMANTE

.MIRA_FASE_4:

		ld		a,(LETRAS_FASES_BITS+1)
		and		#f0
		ret		z
		jp		CONTROL_DEL_GRAN_DIAMANTE

.MIRA_FASE_1:

		ld		a,(LETRAS_FASES_BITS)
		and		#0f
		ret		z
		jp		CONTROL_DEL_GRAN_DIAMANTE

.MIRA_FASE_2:

		ld		a,(LETRAS_FASES_BITS)
		and		#f0
		ret		z
		jp		CONTROL_DEL_GRAN_DIAMANTE

.MIRA_FASE_3:

		ld		a,(LETRAS_FASES_BITS+1)
		and		#0f
		ret		z
		jp		CONTROL_DEL_GRAN_DIAMANTE

MAPA_DE_SITUACION:

		call	DISSCR_RAM
		ld		a,5
		call	CHGMOD
		call	DISSCR_RAM
		call	ACTIVA_SPRITES_MAPA_DE_SITUACION

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
		call	PON_COLOR_2_MAPA_SIN_INTERRUPCIONES

		ld		a,70
		ld		(DIRPA2),a
		ld		hl,GRAFICOS_MAPA_2
		ld		de,#C000
		ld		bc,#4000
		call	PON_COLOR_2_MAPA_SIN_INTERRUPCIONES
		ei

		ld		hl,DATOS_COPIS_MAPA
		call	DOCOPY
		jp		VDPREADY


DESACTIVA_SPRITES_MAPA_DE_SITUACION:

		di
		call	DESACTIVA_SPRITES_MAPA_DE_SITUACION_SIN_EI
		ei
		ret

DESACTIVA_SPRITES_MAPA_DE_SITUACION_SIN_EI:

		ld 		a,(RG8SAV)
		or		00000010B
		ld 		(RG8SAV),a
		out		(#99),a
		ld		a,8+128
		out		(#99),a
		ret

ACTIVA_SPRITES_MAPA_DE_SITUACION:

		di
		ld 		a,(RG8SAV)
		and		11111101B
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

		call	PAGE_32_A_SEGMENT_2

		ld		hl,COLORES_SPRITES_DEPH
		ld		de,#4800
		ld		bc,64
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		cp		2
		jr		z,.POSE_1
		cp		0
		jr		z,.POSE_3

		ld		hl,COLOR_POSE_0_Y_2
		jr		.VUELCA_CUERPO

.POSE_1:

		ld		hl,COLOR_POSE_1
		jr		.VUELCA_CUERPO

.POSE_3:

		ld		hl,COLOR_POSE_3

.VUELCA_CUERPO:

		ld		de,#4840
		ld		bc,96
		call	PON_COLOR_2.sin_bc_impuesta
		jp		PAGE_10_A_SEGMENT_2


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
		call	REPRODUCE_FX_MAPA_SI_ACTIVO
		djnz	ESPERA_MAPA_DE_SITUACION_B
		ret


REPRODUCE_FX_MAPA_SI_ACTIVO:

		ld		a,(ayFX_C1)
		cp		255
		jr		nz,.HAY_FX
		ld		a,(ayFX_C2)
		cp		255
		jr		nz,.HAY_FX
		ld		a,(ayFX_C3)
		cp		255
		jr		z,.NO_HAY_FX

.HAY_FX:

		push	af
		push	bc
		push	de
		push	hl
		ld		a,(DIRPA2)
		push	af
		ld		a,31
		ld		(DIRPA2),a
		call	AYfx_ROUT
		call	ayFX_PLAY
		pop		af
		ld		(DIRPA2),a
		pop		hl
		pop		de
		pop		bc
		pop		af
		ret

.NO_HAY_FX:

		ld		a,(FX_ON_OFF)
		or		a
		ret		z
		call	SILENCIA_FX_DIAMANTES
		xor		a
		ld		(FX_ON_OFF),a
		ret


LANZA_FX_DIAMANTES:

		push	bc
		push	de
		push	hl
		ld		b,a
		ld		a,1
		ld		(FX_ON_OFF),a
		ld		a,(DIRPA2)
		push	af
		ld		a,31
		ld		(DIRPA2),a
		ld		a,b
		ld		c,0
		call	ayFX_INIT
		call	AYfx_ROUT
		call	ayFX_PLAY
		pop		af
		ld		(DIRPA2),a
		pop		hl
		pop		de
		pop		bc
		ret


SILENCIA_FX_DIAMANTES:

		push	af
		push	bc
		push	de
		push	hl
		ld		a,(DIRPA2)
		push	af
		ld		a,31
		ld		(DIRPA2),a
		call	ayFX_STOP
		call	ayFX_PLAY
		call	AYfx_ROUT
		pop		af
		ld		(DIRPA2),a
		pop		hl
		pop		de
		pop		bc
		pop		af
		ret


PON_COLOR_2_MAPA_SIN_INTERRUPCIONES:

		xor		a
		call	LDIRVM2_MAPA_SIN_INTERRUPCIONES
		xor		a
		ld 		(RG14SAV),a
		out		(#99),a
		ld		a,14+128
		out		(#99),a
		ret


LDIRVM2_MAPA_SIN_INTERRUPCIONES:

		ex		de,hl
		call	SetVdp_Write_MAPA_SIN_INTERRUPCIONES
		ex		de,hl
		ld		a,c
		or		a
		ld		a,b
		ld		b,c
		jr		z,.BLK_VRAM_0
		inc		a

.BLK_VRAM_0:

		ld		c,#98

.BLK_VRAM_LOOP:

		otir
		dec		a
		jr		nz,.BLK_VRAM_LOOP
		ex		de,hl
		ret


SetVdp_Write_MAPA_SIN_INTERRUPCIONES:

		push	af
		push	hl
		xor		a
		and		a
		rlc		h
		rla
		rlc		h
		rla
		srl		h
		srl		h
		di
		out		(#99),a
		ld		a,14+128
		out		(#99),a
		ld		a,l
		nop
		out		(#99),a
		ld		a,h
		or		64
		out		(#99),a
		pop		hl
		pop		af
		ret

DOCOPY_MAPA_SIN_INTERRUPCIONES:

		ld		a,32
		out		(#99),a
		ld		a,17+128
		out		(#99),a
		ld		c,#9B
		call	VDPREADY_MAPA_SIN_INTERRUPCIONES

		dw		#A3ED,#A3ED,#A3ED,#A3ED	  				; 15x OUTI
		dw		#A3ED,#A3ED,#A3ED,#A3ED
		dw		#A3ED,#A3ED,#A3ED,#A3ED
		dw		#A3ED,#A3ED,#A3ED

		ret

VDPREADY_MAPA_SIN_INTERRUPCIONES:

		ld		a,2
		out		(#99),a
		ld		a,15+128
		out		(#99),a
		in		a,(#99)
		rra
		xor		a
		out		(#99),a
		ld		a,15+128
		out		(#99),a
		jp		c,VDPREADY_MAPA_SIN_INTERRUPCIONES
		ret


CONTROL_DEL_GRAN_DIAMANTE:

		di
		call	DESACTIVA_SPRITES_MAPA_DE_SITUACION_SIN_EI
		ld		a,74
		ld		(DIRPA2),a
		ld		hl,GRAFICOS_GRAN_DIAMANTE_1
		ld		de,#8000
		ld		bc,#4000
		call	PON_COLOR_2_MAPA_SIN_INTERRUPCIONES

		ld		a,75
		ld		(DIRPA2),a
		ld		hl,GRAFICOS_GRAN_DIAMANTE_2
		ld		de,#C000
		ld		bc,#4000
		call	PON_COLOR_2_MAPA_SIN_INTERRUPCIONES
		ld		a,10
		ld		(DIRPA2),a

		ld		hl,DATOS_COPIA_GRAN_DIAMANTE_PAGE_1_A_3
		call	DOCOPY_MAPA_SIN_INTERRUPCIONES
		ei

		call	LIMPIA_BUFFERS_GRAN_DIAMANTE
		call	PINTA_DIAMANTES_CONSEGUIDOS
		call	PONE_PRIMERA_PALETA_DIAMANTES
		ld		a,1
		call	SETPAGE
		ld		(MAPA_SITUACION_BUFFER_PAGE),a
		call	FADE_IN_DIAMANTES
		call	PONE_PALETA_FINAL_DIAMANTES

		ld		b,50
		call	ESPERA_MAPA_DE_SITUACION_B
		call	ANIMA_LETRAS_GRAN_DIAMANTE
		jp		COMPRUEBA_PORCION_GRAN_DIAMANTE


LIMPIA_BUFFERS_GRAN_DIAMANTE:

		ld		hl,DATOS_LIMPIA_MAPA_PAGE_1
		call	DOCOPY
		call	VDPREADY
		ld		hl,DATOS_LIMPIA_MAPA_PAGE_2
		call	DOCOPY
		jp		VDPREADY


PINTA_DIAMANTES_CONSEGUIDOS:

		ld		a,(FASE)
		cp		3
		jr		c,.MIRA_DIAMANTE_2
		ld		a,(LETRAS_FASES_BITS)
		and		#0f
		cp		#0f
		ld		hl,DATOS_DIAMANTE_1_PAGE_1
		call	z,PINTA_DIAMANTE_EN_BUFFERS

.MIRA_DIAMANTE_2:

		ld		a,(FASE)
		cp		4
		jr		c,.MIRA_DIAMANTE_3
		ld		a,(LETRAS_FASES_BITS)
		and		#f0
		cp		#f0
		ld		hl,DATOS_DIAMANTE_2_PAGE_1
		call	z,PINTA_DIAMANTE_EN_BUFFERS

.MIRA_DIAMANTE_3:

		ld		a,(FASE)
		cp		5
		jr		c,.MIRA_DIAMANTE_4
		ld		a,(LETRAS_FASES_BITS+1)
		and		#0f
		cp		#0f
		ld		hl,DATOS_DIAMANTE_3_PAGE_1
		call	z,PINTA_DIAMANTE_EN_BUFFERS

.MIRA_DIAMANTE_4:

		ld		a,(FASE)
		cp		6
		jr		c,.MIRA_DIAMANTE_5
		ld		a,(LETRAS_FASES_BITS+1)
		and		#f0
		cp		#f0
		ld		hl,DATOS_DIAMANTE_4_PAGE_1
		call	z,PINTA_DIAMANTE_EN_BUFFERS

.MIRA_DIAMANTE_5:

		ld		a,(FASE)
		cp		7
		ret		c
		ld		a,(LETRAS_FASES_BITS+2)
		and		#0f
		cp		#0f
		ret		nz
		ld		hl,DATOS_DIAMANTE_5_PAGE_1


PINTA_DIAMANTE_EN_BUFFERS:

		push	hl
		call	DOCOPY
		call	VDPREADY
		pop		hl
		ld		de,DATOS_DIAMANTES_PAGE_2-DATOS_DIAMANTE_1_PAGE_1
		add		hl,de
		call	DOCOPY
		jp		VDPREADY


PONE_PRIMERA_PALETA_DIAMANTES:

		ld		hl,PALETA_DIAMANTES_FADE_IN
		jp		SETPALETE


PONE_PALETA_FINAL_DIAMANTES:

		ld		hl,PALETA_DIAMANTES_FIJA
		jp		SETPALETE


FADE_IN_DIAMANTES:

		ld		hl,PALETA_DIAMANTES_FADE_IN+32
		ld		e,6
		jp		BUCLE_FADE_MAPA_DE_SITUACION


FADE_OUT_DIAMANTES:

		ld		hl,PALETA_DIAMANTES_FADE_OUT
		ld		e,7
		jp		BUCLE_FADE_MAPA_DE_SITUACION


ANIMA_LETRAS_GRAN_DIAMANTE:

		call	OBTIENE_LETRAS_FASE_ANTERIOR_GRAN_DIAMANTE
		or		a
		ret		z
		push	af
		bit		0,a
		call	nz,ANIMA_LETRA_D_GRAN_DIAMANTE
		pop		af
		push	af
		bit		1,a
		call	nz,ANIMA_LETRA_E_GRAN_DIAMANTE
		pop		af
		push	af
		bit		2,a
		call	nz,ANIMA_LETRA_P_GRAN_DIAMANTE
		pop		af
		bit		3,a
		call	nz,ANIMA_LETRA_H_GRAN_DIAMANTE
		ret


COMPRUEBA_PORCION_GRAN_DIAMANTE:

		call	OBTIENE_LETRAS_FASE_ANTERIOR_GRAN_DIAMANTE
		cp		#0f
		jp		z,CONSEGUIMOS_PORCION
		jp		NO_CONSEGUIMOS_PORCION


CONSEGUIMOS_PORCION:

		call	PONE_BUFFER_VISIBLE_PAGE_1_GRAN_DIAMANTE
		call	OBTIENE_DATOS_PORCION_GRAN_DIAMANTE
		call	COPIA_PORCION_GRAN_DIAMANTE_PAGE_3_A_0
		call	COPIA_FONDO_PORCION_GRAN_DIAMANTE_A_PAGE_0
		call	COPIA_MEZCLA_PORCION_GRAN_DIAMANTE_A_PAGE_2
		ld		d,11
		ld		a,2

.BUCLE_PARPADEO:

		push	af
		call	SETPAGE
		pop		af
		ld		(MAPA_SITUACION_BUFFER_PAGE),a
		push	af
		ld		b,6
		call	ESPERA_MAPA_DE_SITUACION_B
		pop		af
		cp		1
		ld		a,1
		jr		nz,.SIGUIENTE_PAGE_DECIDIDA
		ld		a,2

.SIGUIENTE_PAGE_DECIDIDA:

		dec		d
		jr		nz,.BUCLE_PARPADEO
		jp		SALIENDO_DE_DIAMANTES


PONE_BUFFER_VISIBLE_PAGE_1_GRAN_DIAMANTE:

		ld		a,1
		call	SETPAGE
		ld		(MAPA_SITUACION_BUFFER_PAGE),a
		ret


NO_CONSEGUIMOS_PORCION:

		call	OBTIENE_LETRAS_FASE_ANTERIOR_GRAN_DIAMANTE
		or		a
		jp		z,SALIENDO_DE_DIAMANTES
		push	af
		bit		0,a
		call	nz,NO_PORCION_LETRA_D
		pop		af
		push	af
		bit		1,a
		call	nz,NO_PORCION_LETRA_E
		pop		af
		push	af
		bit		2,a
		call	nz,NO_PORCION_LETRA_P
		pop		af
		bit		3,a
		call	nz,NO_PORCION_LETRA_H
		jp		SALIENDO_DE_DIAMANTES


NO_PORCION_LETRA_D:

		ld		d,0
		ld		e,0
		ld		l,166
		jr		NO_PORCION_ANIMA_LETRA


NO_PORCION_LETRA_E:

		ld		d,64
		ld		e,40
		ld		l,166
		jr		NO_PORCION_ANIMA_LETRA


NO_PORCION_LETRA_P:

		ld		d,128
		ld		e,80
		ld		l,166
		jr		NO_PORCION_ANIMA_LETRA


NO_PORCION_LETRA_H:

		ld		d,192
		ld		e,144
		ld		l,130


NO_PORCION_ANIMA_LETRA:

		ld		a,d
		ld		(VARIABLE_UN_USO2),a
		push	de
		push	hl
		call	COPIA_LETRA_PAGE_0_A_0_GRAN_DIAMANTE
		pop		hl
		pop		de
		push	de
		push	hl
		call	COPIA_NO_PORCION_40_A_PAGE_0
		pop		hl
		pop		de
		push	de
		call	COPIA_LETRA_A_BUFFER_OCULTO_GRAN_DIAMANTE
		pop		de
		call	CAMBIA_BUFFER_GRAN_DIAMANTE
		ld		a,37
		call	LANZA_FX_DIAMANTES
		ld		b,6
		call	ESPERA_MAPA_DE_SITUACION_B

		ld		e,192
		ld		l,0
		call	NO_PORCION_FRAME_64
		ld		e,192
		ld		l,63
		call	NO_PORCION_FRAME_64
		ld		e,192
		ld		l,127
		call	NO_PORCION_FRAME_64
		ld		e,192
		ld		l,190
		call	NO_PORCION_FRAME_64
		ld		e,130
		ld		l,190
		call	NO_PORCION_FRAME_64

		ld		a,(VARIABLE_UN_USO2)
		ld		d,a
		call	COPIA_LETRA_ORIGINAL_A_BUFFER_OCULTO_GRAN_DIAMANTE
		call	CAMBIA_BUFFER_GRAN_DIAMANTE
		ld		b,6
		call	ESPERA_MAPA_DE_SITUACION_B
		ld		a,(VARIABLE_UN_USO2)
		ld		d,a
		jp		COPIA_LETRA_ORIGINAL_A_BUFFER_OCULTO_GRAN_DIAMANTE


NO_PORCION_FRAME_64:

		push	de
		push	hl
		call	COPIA_LETRA_PAGE_0_A_0_GRAN_DIAMANTE
		pop		hl
		pop		de
		push	de
		push	hl
		call	COPIA_NO_PORCION_64_A_PAGE_0
		pop		hl
		pop		de
		push	de
		call	COPIA_LETRA_A_BUFFER_OCULTO_GRAN_DIAMANTE
		pop		de
		call	CAMBIA_BUFFER_GRAN_DIAMANTE
		ld		b,6
		jp		ESPERA_MAPA_DE_SITUACION_B


SALIENDO_DE_DIAMANTES:

		call	SILENCIA_FX_DIAMANTES
		xor		a
		ld		(FX_ON_OFF),a
		call	FADE_OUT_DIAMANTES
		ret


OBTIENE_DATOS_PORCION_GRAN_DIAMANTE:

		ld		a,(FASE)
		sub		2
		jr		nc,.INDICE_VALIDO
		xor		a

.INDICE_VALIDO:

		cp		5
		jr		c,.INDICE_EN_RANGO
		ld		a,4

.INDICE_EN_RANGO:

		ld		e,a
		add		a,a
		add		a,e
		add		a,a
		ld		e,a
		ld		d,0
		ld		iy,TABLA_DATOS_PORCIONES_GRAN_DIAMANTE
		add		iy,de
		ret


COPIA_PORCION_GRAN_DIAMANTE_PAGE_3_A_0:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		a,(iy)
		ld		(ix),a
		ld		(ix+1),0
		ld		a,(iy+1)
		ld		(ix+2),a
		ld		(ix+3),3
		xor		a
		ld		(ix+4),a
		ld		(ix+5),a
		ld		(ix+6),a
		ld		(ix+7),a
		ld		a,(iy+2)
		ld		(ix+8),a
		xor		a
		ld		(ix+9),a
		ld		a,(iy+3)
		ld		(ix+10),a
		xor		a
		ld		(ix+11),a
		ld		(ix+12),a
		ld		(ix+13),a
		ld		a,10010000b
		ld		(ix+14),a
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


COPIA_FONDO_PORCION_GRAN_DIAMANTE_A_PAGE_0:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		a,(iy+4)
		ld		(ix),a
		ld		(ix+1),0
		ld		a,(iy+5)
		ld		(ix+2),a
		ld		(ix+3),1
		xor		a
		ld		(ix+4),a
		ld		(ix+5),a
		ld		(ix+6),a
		ld		(ix+7),a
		ld		a,(iy+2)
		ld		(ix+8),a
		xor		a
		ld		(ix+9),a
		ld		a,(iy+3)
		ld		(ix+10),a
		xor		a
		ld		(ix+11),a
		ld		(ix+12),a
		ld		(ix+13),a
		ld		a,10011000b
		ld		(ix+14),a
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


COPIA_MEZCLA_PORCION_GRAN_DIAMANTE_A_PAGE_2:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		xor		a
		ld		(ix),a
		ld		(ix+1),a
		ld		(ix+2),a
		ld		(ix+3),a
		ld		a,(iy+4)
		ld		(ix+4),a
		xor		a
		ld		(ix+5),a
		ld		a,(iy+5)
		ld		(ix+6),a
		ld		(ix+7),2
		ld		a,(iy+2)
		ld		(ix+8),a
		xor		a
		ld		(ix+9),a
		ld		a,(iy+3)
		ld		(ix+10),a
		xor		a
		ld		(ix+11),a
		ld		(ix+12),a
		ld		(ix+13),a
		ld		a,10010000b
		ld		(ix+14),a
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


OBTIENE_LETRAS_FASE_ANTERIOR_GRAN_DIAMANTE:

		ld		a,(FASE)
		dec		a
		ret		z
		dec		a
		jr		z,.FASE_1
		dec		a
		jr		z,.FASE_2
		dec		a
		jr		z,.FASE_3
		dec		a
		jr		z,.FASE_4
		dec		a
		jr		z,.FASE_5
		xor		a
		ret

.FASE_1:

		ld		a,(LETRAS_FASES_BITS)
		and		#0f
		ret

.FASE_2:

		ld		a,(LETRAS_FASES_BITS)
		rrca
		rrca
		rrca
		rrca
		and		#0f
		ret

.FASE_3:

		ld		a,(LETRAS_FASES_BITS+1)
		and		#0f
		ret

.FASE_4:

		ld		a,(LETRAS_FASES_BITS+1)
		rrca
		rrca
		rrca
		rrca
		and		#0f
		ret

.FASE_5:

		ld		a,(LETRAS_FASES_BITS+2)
		and		#0f
		ret


ANIMA_LETRA_D_GRAN_DIAMANTE:

		ld		d,0
		ld		e,0
		jr		ANIMA_LETRA_GRAN_DIAMANTE


ANIMA_LETRA_E_GRAN_DIAMANTE:

		ld		d,64
		ld		e,36
		jr		ANIMA_LETRA_GRAN_DIAMANTE


ANIMA_LETRA_P_GRAN_DIAMANTE:

		ld		d,128
		ld		e,72
		jr		ANIMA_LETRA_GRAN_DIAMANTE


ANIMA_LETRA_H_GRAN_DIAMANTE:

		ld		d,192
		ld		e,108


ANIMA_LETRA_GRAN_DIAMANTE:

		push	de
		call	COPIA_LETRA_PAGE_1_A_0_GRAN_DIAMANTE
		pop		de
		push	de
		call	COPIA_LETRA_PAGE_0_A_0_GRAN_DIAMANTE
		pop		de
		push	de
		call	COPIA_ICONO_LETRA_PAGE_3_A_0_GRAN_DIAMANTE
		pop		de
		push	de
		call	COPIA_LETRA_A_PAGE_2_GRAN_DIAMANTE
		pop		de
		ld		a,2
		call	SETPAGE
		ld		(MAPA_SITUACION_BUFFER_PAGE),a
		ld		a,36
		call	LANZA_FX_DIAMANTES
		push	de
		ld		b,6
		call	ESPERA_MAPA_DE_SITUACION_B
		pop		de
		push	de
		call	COPIA_LETRA_A_PAGE_1_GRAN_DIAMANTE
		pop		de
		ld		b,25
		jp		ESPERA_MAPA_DE_SITUACION_B


COPIA_LETRA_PAGE_1_A_0_GRAN_DIAMANTE:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),d
		ld		(ix+1),0
		ld		(ix+2),76
		ld		(ix+3),1
		ld		(ix+4),d
		ld		(ix+5),0
		ld		(ix+6),0
		ld		(ix+7),0
		jp		COPIA_LETRA_64_TAMANO_GRAN_DIAMANTE


COPIA_LETRA_PAGE_0_A_0_GRAN_DIAMANTE:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),d
		ld		(ix+1),0
		ld		(ix+2),0
		ld		(ix+3),0
		ld		(ix+4),d
		ld		(ix+5),0
		ld		(ix+6),64
		ld		(ix+7),0
		jp		COPIA_LETRA_64_TAMANO_GRAN_DIAMANTE


COPIA_ICONO_LETRA_PAGE_3_A_0_GRAN_DIAMANTE:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),e
		ld		(ix+1),0
		ld		(ix+2),130
		ld		(ix+3),3
		ld		a,d
		add		14
		ld		(ix+4),a
		ld		(ix+5),0
		ld		(ix+6),78
		ld		(ix+7),0
		ld		(ix+8),36
		ld		(ix+9),0
		ld		(ix+10),36
		ld		(ix+11),0
		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),10011000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


COPIA_NO_PORCION_40_A_PAGE_0:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),e
		ld		(ix+1),0
		ld		(ix+2),l
		ld		(ix+3),3
		ld		a,d
		add		12
		ld		(ix+4),a
		ld		(ix+5),0
		ld		(ix+6),77
		ld		(ix+7),0
		ld		(ix+8),40
		ld		(ix+9),0
		ld		(ix+10),38
		ld		(ix+11),0
		jr		COPIA_TRANSPARENTE_GRAN_DIAMANTE


COPIA_NO_PORCION_64_A_PAGE_0:

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),e
		ld		(ix+1),0
		ld		(ix+2),l
		ld		(ix+3),3
		ld		(ix+4),d
		ld		(ix+5),0
		ld		(ix+6),64
		ld		(ix+7),0
		ld		(ix+8),64
		ld		(ix+9),0
		ld		(ix+10),64
		ld		(ix+11),0
		jr		COPIA_TRANSPARENTE_GRAN_DIAMANTE


COPIA_TRANSPARENTE_GRAN_DIAMANTE:

		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),10011000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


COPIA_LETRA_A_BUFFER_OCULTO_GRAN_DIAMANTE:

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		cp		1
		ld		a,2
		jr		z,COPIA_LETRA_A_PAGE_A_GRAN_DIAMANTE
		ld		a,1
		jr		COPIA_LETRA_A_PAGE_A_GRAN_DIAMANTE


COPIA_LETRA_ORIGINAL_A_BUFFER_OCULTO_GRAN_DIAMANTE:

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		cp		1
		ld		a,2
		jr		z,COPIA_LETRA_ORIGINAL_A_PAGE_A_GRAN_DIAMANTE
		ld		a,1
		jr		COPIA_LETRA_ORIGINAL_A_PAGE_A_GRAN_DIAMANTE


COPIA_LETRA_A_PAGE_2_GRAN_DIAMANTE:

		ld		a,2
		jr		COPIA_LETRA_A_PAGE_A_GRAN_DIAMANTE


COPIA_LETRA_A_PAGE_1_GRAN_DIAMANTE:

		ld		a,1


COPIA_LETRA_A_PAGE_A_GRAN_DIAMANTE:

		ld		c,a
		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),d
		ld		(ix+1),0
		ld		(ix+2),64
		ld		(ix+3),0
		ld		(ix+4),d
		ld		(ix+5),0
		ld		(ix+6),76
		ld		(ix+7),c
		jr		COPIA_LETRA_64_TAMANO_GRAN_DIAMANTE


COPIA_LETRA_ORIGINAL_A_PAGE_A_GRAN_DIAMANTE:

		ld		c,a
		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),d
		ld		(ix+1),0
		ld		(ix+2),0
		ld		(ix+3),0
		ld		(ix+4),d
		ld		(ix+5),0
		ld		(ix+6),76
		ld		(ix+7),c
		jr		COPIA_LETRA_64_TAMANO_GRAN_DIAMANTE


CAMBIA_BUFFER_GRAN_DIAMANTE:

		ld		a,(MAPA_SITUACION_BUFFER_PAGE)
		cp		1
		jr		z,.A_PAGE_2
		ld		a,1
		jr		.GUARDA

.A_PAGE_2:

		ld		a,2

.GUARDA:

		call	SETPAGE
		ld		(MAPA_SITUACION_BUFFER_PAGE),a
		ret


COPIA_LETRA_64_TAMANO_GRAN_DIAMANTE:

		ld		(ix+8),64
		ld		(ix+9),0
		ld		(ix+10),64
		ld		(ix+11),0
		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),10010000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


DATOS_COPIS_MAPA: ;datos_de_mapa_page_1_a_page_2

		dw		#0000,#0100
		dw		#0000,#0200
		dw		#0100,#0100
		db		#00,#00,10010000b


;DATOS_MAPA_INICIAL_IZQUIERDA:

		dw		#0000,#0200
		dw		#006B,#0000
		dw		#0016,#00D4
		db		#00,#00,10010000b


;DATOS_MAPA_INICIAL_DERECHA:

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


TABLA_POSICIONES_DEPH_MAPA_DE_SITUACION:

		db		27,83
		db		117,67
		db		199,18
		db		45,162
		db		149,167


PALETA_DIAMANTES_FIJA:
		incbin	"../PALETAS/DIAMANTE/DIAMANTE.palete"
PALETA_DIAMANTES_FADE_IN:
		incbin	"../PALETAS/DIAMANTE/DIAMANTE.fadein"
PALETA_DIAMANTES_FADE_OUT:
		incbin	"../PALETAS/DIAMANTE/DIAMANTE.fadeout"
PALETA_MAPA_FIJA:
		incbin	"../PALETAS/PRESENTACION/MAPA.palete"
PALETA_MAPA_FADE_IN:
		incbin	"../PALETAS/PRESENTACION/MAPA.fadein"
PALETA_MAPA_FADE_OUT:
		incbin	"../PALETAS/PRESENTACION/MAPA.fadeout"

DATOS_COPIA_GRAN_DIAMANTE_PAGE_1_A_3:

		dw		#0000,#0100
		dw		#0000,#0300
		dw		#0100,#0100
		db		#00,#00,10010000b


DATOS_DIAMANTE_1_PAGE_1:

		dw		#0000,#0300
		dw		#002d,#0129
		dw		#0053,#002b
		db		#00,#00,10010000b

DATOS_DIAMANTE_2_PAGE_1:

		dw		#0053,#0300
		dw		#0080,#0129
		dw		#0053,#002b
		db		#00,#00,10010000b

DATOS_DIAMANTE_3_PAGE_1:

		dw		#0000,#032b
		dw		#002d,#0154
		dw		#0053,#002b
		db		#00,#00,10010000b

DATOS_DIAMANTE_4_PAGE_1:

		dw		#0053,#032b
		dw		#0080,#0154
		dw		#0053,#002b
		db		#00,#00,10010000b

DATOS_DIAMANTE_5_PAGE_1:

		dw		#0000,#0356
		dw		#002d,#017f
		dw		#00a6,#002c
		db		#00,#00,10010000b


DATOS_DIAMANTES_PAGE_2:
;DATOS_DIAMANTE_1_PAGE_2
		dw		#0000,#0300
		dw		#002d,#0229
		dw		#0053,#002b
		db		#00,#00,10010000b

;DATOS_DIAMANTE_2_PAGE_2

		dw		#0053,#0300
		dw		#0080,#0229
		dw		#0053,#002b
		db		#00,#00,10010000b

;DATOS_DIAMANTE_3_PAGE_2

		dw		#0000,#032b
		dw		#002d,#0254
		dw		#0053,#002b
		db		#00,#00,10010000b

;DATOS_DIAMANTE_4_PAGE_2

		dw		#0053,#032b
		dw		#0080,#0254
		dw		#0053,#002b
		db		#00,#00,10010000b

;DATOS_DIAMANTE_5_PAGE_2

		dw		#0000,#0356
		dw		#002d,#027f
		dw		#00a6,#002c
		db		#00,#00,10010000b


TABLA_DATOS_PORCIONES_GRAN_DIAMANTE:

		db		0,0,83,43,45,41
		db		83,0,83,43,128,41
		db		0,43,83,43,45,84
		db		83,43,83,43,128,84
		db		0,86,166,44,45,127
