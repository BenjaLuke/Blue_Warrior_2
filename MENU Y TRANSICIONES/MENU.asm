ACPAGE		equ		#FAF6

MENU_FUENTE_Y_ORIGEN			equ		#0200+213
MENU_LETRA_ANCHO				equ		6
MENU_LETRA_ALTO					equ		6
MENU_LETRA_ESPECIAL_BASE		equ		26
MENU_LETRA_ESPECIALES_CANT		equ		16
MENU_LETRA_ESPACIO				equ		MENU_LETRA_ESPECIAL_BASE+MENU_LETRA_ESPECIALES_CANT
MENU_FUENTE_CARACTERES			equ		MENU_LETRA_ESPACIO+1
MENU_FUENTE_ANCHO				equ		MENU_LETRA_ANCHO*MENU_FUENTE_CARACTERES
PUSH_SPACE_KEY_X				equ		86
PUSH_SPACE_KEY_Y				equ		181

COMIENZA_MENU:

		; La música viene arrancada desde el logo.
		; Reinstalamos aquí la interrupción musical del menú,
		; porque la rutina anterior vivía en la página del logo.

		di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a
		ei

		call	PAGE_10_A_SEGMENT_2

		call	MUESTRA_PRESENTACION_PROVISIONAL
		jp		PULSA_UNA_TECLA_PARA_EMPEZAR


MUESTRA_PRESENTACION_PROVISIONAL:

		call	DISSCR_RAM

		ld		a,5
		call	CHGMOD

		call	DISSCR_RAM

		; La segunda parte de la imagen de menu solo ocupa #2A00 bytes.
		; Limpiamos VRAM para que no queden restos de la pantalla SC7 del logo.

		xor		a
		ld		hl,#0000
		ld		bc,#ffff
		call	FILVRM_RAM

		; Página visible = 0

		xor		a
		call	SETPAGE

		; 1 - Cargamos los gráficos de presentación en page 1, no visible.

		call	CARGA_GRAFICOS_PRESENTACION_EN_PAGE_1
		call	PREPARA_FUENTE_MENU_EN_PAGE_2

		; 2 - Ponemos la primera paleta del fade in.

		call	PONE_PRIMERA_PALETA_PRESENTACION

		; 3 - Copiamos la imagen de page 1 a page visible 0.

		ld		hl,DATOS_COPY_PRESENTACION_PAGE_1_A_PAGE_0
		call	DOCOPY
		call	VDPREADY

		; 4 - Mostramos pantalla y hacemos fade in.

		call	ENASCR_RAM
		call	FADE_IN_PRESENTACION

		di
		call	INSTALA_INTERRUPCION_MUSICA_MENU
		ei

		; 5 - Pintamos texto de aviso.

		call	PINTA_TEXTO_PUSH_SPACE_KEY_EN_DOS_PAGES

		; 7 - Preparamos rotativo inferior.

		call	INICIALIZA_ROTATIVO_PRESENTACION

		ret

PINTA_TEXTO_PUSH_SPACE_KEY:

		call	OBTIENE_DESTINO_Y_PUSH_SPACE_KEY
		ld		hl,PUSH_SPACE_KEY_X
		ld		ix,TEXTO_PUSH_SPACE_KEY
		jp		BUCLE_PINTA_TEXTO_PUSH_SPACE_KEY


PINTA_TEXTO_PUSH_SPACE_KEY_EN_DOS_PAGES:

		xor		a
		ld		(ACPAGE),a
		call	PINTA_TEXTO_PUSH_SPACE_KEY

		ld		a,1
		ld		(ACPAGE),a
		call	PINTA_TEXTO_PUSH_SPACE_KEY

		xor		a
		ld		(ACPAGE),a
		ret

BUCLE_PINTA_TEXTO_PUSH_SPACE_KEY:

		ld		a,(ix+0)
		or		a
		ret		z

		push	de
		push	hl
		push	ix
		call	PINTA_LETRA_MENU_EN_DESTINO
		pop		ix
		pop		hl
		pop		de

		ld		bc,MENU_LETRA_ANCHO
		add		hl,bc
		inc		ix
		jp		BUCLE_PINTA_TEXTO_PUSH_SPACE_KEY


TEXTO_PUSH_SPACE_KEY:

		db		"PUSH SPACE KEY",0

OBTIENE_DESTINO_Y_PUSH_SPACE_KEY:

		ld		a,(ACPAGE)
		or		a
		ld		de,PUSH_SPACE_KEY_Y
		ret		z
		ld		de,#0100+PUSH_SPACE_KEY_Y
		ret

OBTIENE_DESTINO_Y_ROTATIVO_DESDE_A:

		or		a
		ld		de,ROTATIVO_Y_PRESENTACION
		ret		z
		ld		de,#0100+ROTATIVO_Y_PRESENTACION
		ret

PINTA_LETRA_MENU_EN_DESTINO:

		push	hl
		push	de
		call	CALCULA_ORIGEN_X_LETRA_MENU
		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),l
		ld		(ix+1),h
		ld		hl,MENU_FUENTE_Y_ORIGEN
		ld		(ix+2),l
		ld		(ix+3),h
		pop		hl
		ld		(ix+6),l
		ld		(ix+7),h
		pop		hl
		ld		(ix+4),l
		ld		(ix+5),h
		ld		(ix+8),MENU_LETRA_ANCHO
		ld		(ix+9),0
		ld		(ix+10),MENU_LETRA_ALTO
		ld		(ix+11),0
		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),11010000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY

CALCULA_ORIGEN_X_LETRA_MENU:

		cp		97
		jr		c,.MIRA_MAYUSCULAS
		cp		123
		jr		nc,.MIRA_MAYUSCULAS
		sub		32

.MIRA_MAYUSCULAS:

		cp		65
		jr		c,.MIRA_ESPECIALES
		cp		91
		jr		nc,.MIRA_ESPECIALES
		sub		65
		jr		.MULTIPLICA

.MIRA_ESPECIALES:

		ld		hl,TABLA_ESPECIALES_MENU
		ld		b,MENU_FUENTE_CARACTERES-MENU_LETRA_ESPECIAL_BASE
		ld		c,MENU_LETRA_ESPECIAL_BASE

.BUCLE_ESPECIALES:

		cp		(hl)
		jr		z,.ES_ESPECIAL
		inc		hl
		inc		c
		djnz	.BUCLE_ESPECIALES
		jr		.ES_ESPACIO

.ES_ESPECIAL:

		ld		a,c
		jr		.MULTIPLICA

.ES_ESPACIO:

		ld		a,MENU_LETRA_ESPACIO

.MULTIPLICA:

		ld		e,a
		ld		d,0
		ld		h,d
		ld		l,e
		add		hl,hl
		add		hl,de
		add		hl,hl
		ret

TABLA_ESPECIALES_MENU:

		db		"-/()1234567890%."

PINTA_TEXTO_MENU_FORMA_3:

		ret

PREPARA_FUENTE_MENU_EN_PAGE_2:

		ld		hl,DATOS_COPY_FUENTE_MENU_A_PAGE_2
		call	DOCOPY
		jp		VDPREADY

CARGA_GRAFICOS_PRESENTACION_EN_PAGE_1:

		; Página 4 ROM -> primera mitad de VRAM page 1

		di
		ld		a,4
		ld		(DIRPA2),a

		ld		hl,PANTALLA_DE_PRESENTACION_1
		ld		de,#8000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta


		; Página 5 ROM -> segunda mitad de VRAM page 1
		; Copiamos sólo hasta donde empiezan las paletas.

		ld		a,5
		ld		(DIRPA2),a

		ld		hl,PANTALLA_DE_PRESENTACION_2
		ld		de,#C000
		ld		bc,PALETA_PRESENTACION_FIJA-PANTALLA_DE_PRESENTACION_2
		call	PON_COLOR_2.sin_bc_impuesta

		ei
		ret


PONE_PRIMERA_PALETA_PRESENTACION:

		ld		a,5
		call	CHANGE_BANK_2

		ld		hl,PALETA_PRESENTACION_FADE_IN
		jp		SETPALETE

INICIA_MUSICA_MENU_PRESENTACION:

		call	stpmus

		ld		a,1
		ld		(MUSICA_BEST_ON),a
		
        ld      a,39
        call    CHANGE_BANK_2

		ld		hl,M_MENU
		ld		(MUSIC_ON),hl

		call	INICIAMOS_MUSICA

		di
		call	strmus

		; strmus instala musint directamente en HTIMI.
		; Para el menú necesitamos envolverla para forzar page 39.

		call	INSTALA_INTERRUPCION_MUSICA_MENU
		ei

		call	PAGE_10_A_SEGMENT_2

		ret

INSTALA_INTERRUPCION_MUSICA_MENU:

		ld		a,#C3
		ld		(HTIMI),a
		ld		hl,INTERRUPCION_MUSICA_MENU
		ld		(HTIMI+1),hl
		ret


INTERRUPCION_MUSICA_MENU:

		ld		a,(DIRPA2)
		push	af
		ld		a,39
		ld		(DIRPA2),a

		call	musint

		pop		af
		ld		(DIRPA2),a

		ret

PARA_MUSICA_MENU_PRESENTACION:

		call	stpmus

		xor		a
		ld		(MUSICA_BEST_ON),a

		call	PAGE_10_A_SEGMENT_2

		ret

FADE_IN_PRESENTACION:

		ld		a,5
		call	CHANGE_BANK_2

		; La primera paleta ya se ha puesto antes.
		; Empezamos en la segunda.

		ld		hl,PALETA_PRESENTACION_FADE_IN+32
		ld		e,7

.BUCLE_FADE_IN_PRESENTACION:

		call	SETPALETE

		ld		a,6
		call	BUCLE_PINTA_TILES.rutina_de_pausa

		dec		e
		jp		nz,.BUCLE_FADE_IN_PRESENTACION

		; Dejamos la paleta final fija por seguridad.

		ld		a,5
		call	CHANGE_BANK_2
		ld		hl,PALETA_PRESENTACION_FIJA
		jp		SETPALETE

FADE_OUT_PRESENTACION:

		ld		a,5
		call	CHANGE_BANK_2

		ld		hl,PALETA_PRESENTACION_FADE_OUT
		ld		e,8

.BUCLE_FADE_OUT_PRESENTACION:

		call	SETPALETE

		ld		a,6
		call	BUCLE_PINTA_TILES.rutina_de_pausa

		dec		e
		jp		nz,.BUCLE_FADE_OUT_PRESENTACION

		ret

DATOS_COPY_PRESENTACION_PAGE_1_A_PAGE_0:

		dw		#0000,#0100		; origen  x=0, y=page 1
		dw		#0000,#0000		; destino x=0, y=page 0 visible
		dw		#0100,#0100		; ancho 256, alto 256
		db		#00,#00,10010000b

DATOS_COPY_FUENTE_MENU_A_PAGE_2:

		dw		#0000,#0100+213
		dw		#0000,#0200+213
		dw		MENU_FUENTE_ANCHO,MENU_LETRA_ALTO
		db		#00,#00,10010000b

ROTATIVO_X_PRESENTACION				equ		VARIABLE_UN_USO
ROTATIVO_CONTADOR_PRESENTACION		equ		VARIABLE_UN_USO2
ROTATIVO_PAGINA_VISIBLE_PRESENTACION	equ		VARIABLE_UN_USO3

ROTATIVO_Y_PRESENTACION				equ		195

; Cada cuántos frames se actualiza el rotativo.
; 1 = cada frame, 2 = cada dos frames, etc.
ROTATIVO_VELOCIDAD_PRESENTACION		equ		1

; Cuántos píxeles avanza cada actualización.
; 1 = suave, 2 = más rápido, 3 = más rápido pero menos fino.
ROTATIVO_PIXELES_POR_PASO_PRESENTACION	equ		3

ROTATIVO_LIMITE_PRESENTACION		equ		65536-((TEXTO_ROTATIVO_PRESENTACION_FIN-TEXTO_ROTATIVO_PRESENTACION-1)*MENU_LETRA_ANCHO)


INICIALIZA_ROTATIVO_PRESENTACION:

		ld		hl,255
		ld		(ROTATIVO_X_PRESENTACION),hl

		xor		a
		ld		(ROTATIVO_CONTADOR_PRESENTACION),a

		; Ahora mismo la visible es page 0.

		ld		(ROTATIVO_PAGINA_VISIBLE_PRESENTACION),a

		call	PREPARA_ROTATIVO_EN_PAGE_OCULTA
		call	PINTA_ROTATIVO_PRESENTACION_EN_PAGE_OCULTA
		call	TAPA_BORDES_ROTATIVO_EN_PAGE_OCULTA
		call	MUESTRA_PAGE_OCULTA_ROTATIVO
		ret


ACTUALIZA_ROTATIVO_PRESENTACION:

		ld		a,(ROTATIVO_CONTADOR_PRESENTACION)
		inc		a
		cp		ROTATIVO_VELOCIDAD_PRESENTACION
		jr		nc,.MUEVE_ROTATIVO_PRESENTACION

		ld		(ROTATIVO_CONTADOR_PRESENTACION),a
		ret


.MUEVE_ROTATIVO_PRESENTACION:

		xor		a
		ld		(ROTATIVO_CONTADOR_PRESENTACION),a

		call	PREPARA_ROTATIVO_EN_PAGE_OCULTA
		call	PINTA_ROTATIVO_PRESENTACION_EN_PAGE_OCULTA
		call	TAPA_BORDES_ROTATIVO_EN_PAGE_OCULTA
		call	MUESTRA_PAGE_OCULTA_ROTATIVO

		ld		hl,(ROTATIVO_X_PRESENTACION)
		ld		de,ROTATIVO_PIXELES_POR_PASO_PRESENTACION
		or		a
		sbc		hl,de
		ld		(ROTATIVO_X_PRESENTACION),hl

		; Si sigue en zona positiva, continuamos.
		ld		a,h
		or		a
		ret		z

		; Si ya ha pasado el límite negativo, reiniciamos.
		ld		de,ROTATIVO_LIMITE_PRESENTACION
		or		a
		sbc		hl,de
		ret		nc

		ld		hl,255
		ld		(ROTATIVO_X_PRESENTACION),hl
		ret

		ld		hl,255
		ld		(ROTATIVO_X_PRESENTACION),hl
		ret


OBTIENE_PAGE_OCULTA_ROTATIVO:

		ld		a,(ROTATIVO_PAGINA_VISIBLE_PRESENTACION)
		xor		1
		ret


PREPARA_ROTATIVO_EN_PAGE_OCULTA:

		call	OBTIENE_PAGE_OCULTA_ROTATIVO
		or		a
		jr		z,.PREPARA_ROTATIVO_EN_PAGE_0

		ld		hl,DATOS_NEGRO_ROTATIVO_EN_PAGE_1
		call	DOCOPY
		jp		VDPREADY


.PREPARA_ROTATIVO_EN_PAGE_0:

		ld		hl,DATOS_NEGRO_ROTATIVO_EN_PAGE_0
		call	DOCOPY
		jp		VDPREADY


MUESTRA_PAGE_OCULTA_ROTATIVO:

		call	OBTIENE_PAGE_OCULTA_ROTATIVO

		push	af
		call	SETPAGE
		pop		af

		ld		(ROTATIVO_PAGINA_VISIBLE_PRESENTACION),a
		ld		(ACPAGE),a

		ret


PINTA_ROTATIVO_PRESENTACION_EN_PAGE_OCULTA:

		call	OBTIENE_PAGE_OCULTA_ROTATIVO
		ld		(ACPAGE),a
		call	OBTIENE_DESTINO_Y_ROTATIVO_DESDE_A

		ld		ix,TEXTO_ROTATIVO_PRESENTACION
		ld		hl,(ROTATIVO_X_PRESENTACION)


.BUCLE_PINTA_ROTATIVO_PRESENTACION:

		ld		a,(ix+0)
		or		a
		jp		z,.FIN_PINTA_ROTATIVO_PRESENTACION

		; Sólo pintamos caracteres cuyo inicio esté entre 0 y 247.
		; Luego sólo copiaremos X=8..247 a page visible.

		ld		a,h
		or		a
		jr		nz,.SALTA_CARACTER_ROTATIVO_PRESENTACION

		ld		a,l
		cp		251
		jr		nc,.SALTA_CARACTER_ROTATIVO_PRESENTACION

		push	de
		push	hl
		push	ix

		ld		a,(ix+0)
		call	PINTA_LETRA_MENU_EN_DESTINO

		pop		ix
		pop		hl
		pop		de


.SALTA_CARACTER_ROTATIVO_PRESENTACION:

		ld		bc,MENU_LETRA_ANCHO
		add		hl,bc

		inc		ix
		jp		.BUCLE_PINTA_ROTATIVO_PRESENTACION


.FIN_PINTA_ROTATIVO_PRESENTACION:

		ret

TAPA_BORDES_ROTATIVO_EN_PAGE_OCULTA:

		call	OBTIENE_PAGE_OCULTA_ROTATIVO
		or		a
		jr		z,.TAPA_BORDES_ROTATIVO_PAGE_0

		ld		hl,DATOS_TAPA_BORDE_IZQ_ROTATIVO_PAGE_1
		call	DOCOPY
		call	VDPREADY

		ld		hl,DATOS_TAPA_BORDE_DER_ROTATIVO_PAGE_1
		call	DOCOPY
		jp		VDPREADY


.TAPA_BORDES_ROTATIVO_PAGE_0:

		ld		hl,DATOS_TAPA_BORDE_IZQ_ROTATIVO_PAGE_0
		call	DOCOPY
		call	VDPREADY

		ld		hl,DATOS_TAPA_BORDE_DER_ROTATIVO_PAGE_0
		call	DOCOPY
		jp		VDPREADY

DATOS_TAPA_BORDE_IZQ_ROTATIVO_PAGE_0:

		dw		#0000,#0000
		dw		#0000,#0000+ROTATIVO_Y_PRESENTACION
		dw		#0008,#0008
		db		#00,#00,11000000b


DATOS_TAPA_BORDE_DER_ROTATIVO_PAGE_0:

		dw		#0000,#0000
		dw		#00F8,#0000+ROTATIVO_Y_PRESENTACION
		dw		#0008,#0008
		db		#00,#00,11000000b


DATOS_TAPA_BORDE_IZQ_ROTATIVO_PAGE_1:

		dw		#0000,#0000
		dw		#0000,#0100+ROTATIVO_Y_PRESENTACION
		dw		#0008,#0008
		db		#00,#00,11000000b


DATOS_TAPA_BORDE_DER_ROTATIVO_PAGE_1:

		dw		#0000,#0000
		dw		#00F8,#0100+ROTATIVO_Y_PRESENTACION
		dw		#0008,#0008
		db		#00,#00,11000000b

DATOS_NEGRO_ROTATIVO_EN_PAGE_0:

		; Rectángulo negro en page 0.
		; X=8, Y=ROTATIVO_Y_PRESENTACION
		; ancho 240, alto 8.

		dw		#0000,#0000
		dw		#0008,#0000+ROTATIVO_Y_PRESENTACION
		dw		#00F0,#0008
		db		#00,#00,11000000b


DATOS_NEGRO_ROTATIVO_EN_PAGE_1:

		; Rectángulo negro en page 1.
		; X=8, Y=ROTATIVO_Y_PRESENTACION
		; ancho 240, alto 8.

		dw		#0000,#0000
		dw		#0008,#0100+ROTATIVO_Y_PRESENTACION
		dw		#00F0,#0008
		db		#00,#00,11000000b

; Editar estas lineas al sacar una version nueva.
; Regla del porcentaje: cada fase vale 2, cada enemigo y bloque auxiliar vale 1.
; EN TOTAL HAY 
; 5 PUNTOS DE 2(FASES) 4 HECHOS
; 6 PUNTOS DE 2(ENEMIGOS) 3 HECHOS
; 4 PUNTOS DE 1(LOGO, MENU, ANIMACION PRESENTACION Y ANIMACION CIERRE) 2 HECHO
; PUNTOS ACTUALES = (4+3)*2 + 2*1 = 16, PORCENTAJE ACTUAL = 16/26 = 61% APROXIMADAMENTE

TEXTO_ROTATIVO_PRESENTACION:

		db		"BLUE WARRIOR II - Beta version 4.4.09 - 17/5/2026 - 61% - (C) Digital Moai - TECLAS 1 - 5 PARA IR DIRECTO A FASE",0
		;db		"A Digital Moai Production - Project Direction, Phase Design, Story, Script, Level Design, Pixel Art and Music Composition: Manuel Dopico - Programming, Sprites, Pixel Art Corrections and Sound Effects: Benjamin Miguel - Graphics: Lucas Sera Piao - Lead Beta Tester and Quality Control: Xavi Sorinas - Packaging: XXX - Cover Illustration: XXX - Digital Moai sincerely thanks the following entities for helping keep the MSX alive: AAMSX (Spain), MSX Boixos Club (Spain), MSX.org (Holland) - (c) Digital Moai 2026",0

TEXTO_ROTATIVO_PRESENTACION_FIN:

PULSA_UNA_TECLA_PARA_EMPEZAR:

		xor		a
		call	GTTRIG_RAM
		or		a
		jp		nz,INICIA_EN_FASE_1

		ld		a,0
		call	SNSMAT_RAM
		bit		1,a
		jp		z,INICIA_EN_FASE_1

		ld		a,0
		call	SNSMAT_RAM
		bit		2,a
		jp		z,INICIA_EN_FASE_2

		ld		a,0
		call	SNSMAT_RAM
		bit		3,a
		jp		z,INICIA_EN_FASE_3

		ld		a,0
		call	SNSMAT_RAM
		bit		4,a
		jp		z,INICIA_EN_FASE_4

		ld		a,0
		call	SNSMAT_RAM
		bit		5,a
		jp		z,INICIA_EN_FASE_5

		halt
		call 	ACTUALIZA_ROTATIVO_PRESENTACION
		jp		PULSA_UNA_TECLA_PARA_EMPEZAR

INICIA_EN_FASE_1:

		ld		a,1
		ld		(FASE),a
		jp		SEGUIMOS

INICIA_EN_FASE_2:

		ld		a,2
		ld		(FASE),a
		jp		SEGUIMOS

INICIA_EN_FASE_3:

		ld		a,3
		ld		(FASE),a
		jp		SEGUIMOS

INICIA_EN_FASE_4:

		ld		a,4
		ld		(FASE),a
		jp		SEGUIMOS

INICIA_EN_FASE_5:

		ld		a,5
		ld		(FASE),a

SEGUIMOS:

		di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a
		ei
		call	PARA_MUSICA_MENU_PRESENTACION

		call	FADE_OUT_PRESENTACION

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

RECUPERAMOS_INTERRUPCIONES_LIMPIAS:

		di
		ld		a,#C9													; A tiene el valor de ret
		ld		(HTIMI),a												; Colocamos ese ret en el gancho H.Timi POR SI EL ORDENADOR TUVIERA ALGO (ALGUN MSX 2 CONTROL DE DISQUETERA)
		ld		(HKEYI),a												; Colocamos ese ret en el gancho H.Key POR SI EL ORDENADOR TUVIERA ALGO
		ei

DESACTIVAMOS_INTERRUPCIONES_DE_LINEA_TRAS_EL_MENU:

		di
		ld 		a,(RG0SAV)												; Disable Line Interrupt: Reset R#0 bit 4
		and		11101111B
		ld		(RG0SAV),a
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM
		ei

NOS_VAMOS_AL_JUEGO:

		ld		a,8
		ld      (DIRPA2),a										    ; Banco 1, pagina 3 del MEGAROM
		jp		CARGA_SLOT_JUEGO
