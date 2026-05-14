GRPPRT		equ		#008D
GRPACX		equ		#FCB7
GRPACY		equ		#FCB9
ACPAGE		equ		#FAF6

COMIENZA_MENU:

		; Presentación provisional.
		; Música quitada de momento.

		call	stpmus
		xor		a
		ld		(MUSICA_BEST_ON),a

		call	PAGE_10_A_SEGMENT_2

		call	MUESTRA_PRESENTACION_PROVISIONAL
		jp		PULSA_UNA_TECLA_PARA_EMPEZAR


MUESTRA_PRESENTACION_PROVISIONAL:

		call	DISSCR_RAM

		ld		a,5
		call	CHGMOD

		call	DISSCR_RAM

		; Página visible = 0

		xor		a
		call	SETPAGE

		; 1 - Cargamos los gráficos de presentación en page 1, no visible.

		call	CARGA_GRAFICOS_PRESENTACION_EN_PAGE_1

		; 2 - Ponemos la primera paleta del fade in.

		call	PONE_PRIMERA_PALETA_PRESENTACION

		; 3 - Copiamos la imagen de page 1 a page visible 0.

		ld		hl,DATOS_COPY_PRESENTACION_PAGE_1_A_PAGE_0
		call	DOCOPY
		call	VDPREADY

		; 4 - Arrancamos música antes del fade in.

		call	INICIA_MUSICA_MENU_PRESENTACION

		; 5 - Mostramos pantalla y hacemos fade in.

		call	ENASCR_RAM
		call	FADE_IN_PRESENTACION

		; 6 - Pintamos texto de aviso.

		call	PINTA_TEXTO_PUSH_SPACE_KEY

		; 7 - Preparamos rotativo inferior.

		call	INICIALIZA_ROTATIVO_PRESENTACION

		ret

PINTA_TEXTO_PUSH_SPACE_KEY:

		; SCREEN 5: texto gráfico.
		; "PUSH SPACE KEY" = 14 letras.
		; 14 * 8 = 112 px.
		; (256 - 112) / 2 = 72.
		; Y = 160 deja margen inferior.

		ld		a,15
		ld		(FORCLR),a

		ld		hl,72
		ld		(GRPACX),hl

		ld		hl,181
		ld		(GRPACY),hl

		ld		hl,TEXTO_PUSH_SPACE_KEY

.BUCLE_PINTA_TEXTO_PUSH_SPACE_KEY:

		ld		a,(hl)
		or		a
		ret		z

		push	hl
		call	GRPPRT
		pop		hl

		inc		hl
		jp		.BUCLE_PINTA_TEXTO_PUSH_SPACE_KEY


TEXTO_PUSH_SPACE_KEY:

		db		"PUSH SPACE KEY",0

CARGA_GRAFICOS_PRESENTACION_EN_PAGE_1:

		; Página 4 ROM -> primera mitad de VRAM page 1

		ld		a,4
		call	CHANGE_BANK_2

		ld		hl,PANTALLA_DE_PRESENTACION_1
		ld		de,#8000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta


		; Página 5 ROM -> segunda mitad de VRAM page 1
		; Copiamos sólo hasta donde empiezan las paletas.

		ld		a,5
		call	CHANGE_BANK_2

		ld		hl,PANTALLA_DE_PRESENTACION_2
		ld		de,#C000
		ld		bc,PALETA_PRESENTACION_FIJA-PANTALLA_DE_PRESENTACION_2
		call	PON_COLOR_2.sin_bc_impuesta

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

		ld		a,39
		ld		(DIRPA2),a

		call	musint

		ld		a,10
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

ROTATIVO_X_PRESENTACION				equ		VARIABLE_UN_USO
ROTATIVO_CONTADOR_PRESENTACION		equ		VARIABLE_UN_USO2

ROTATIVO_Y_PRESENTACION				equ		195
ROTATIVO_VELOCIDAD_PRESENTACION		equ		1
ROTATIVO_LIMITE_PRESENTACION		equ		65536-((TEXTO_ROTATIVO_PRESENTACION_FIN-TEXTO_ROTATIVO_PRESENTACION-1)*8)


INICIALIZA_ROTATIVO_PRESENTACION:

		ld		hl,255
		ld		(ROTATIVO_X_PRESENTACION),hl

		xor		a
		ld		(ROTATIVO_CONTADOR_PRESENTACION),a

		call	PREPARA_ROTATIVO_EN_PAGE_1
		call	PINTA_ROTATIVO_PRESENTACION_EN_PAGE_1
		call	COPIA_ROTATIVO_PAGE_1_A_VISIBLE
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

		call	PREPARA_ROTATIVO_EN_PAGE_1
		call	PINTA_ROTATIVO_PRESENTACION_EN_PAGE_1
		call	COPIA_ROTATIVO_PAGE_1_A_VISIBLE

		ld		hl,(ROTATIVO_X_PRESENTACION)
		dec		hl
		ld		(ROTATIVO_X_PRESENTACION),hl

		ld		de,ROTATIVO_LIMITE_PRESENTACION
		or		a
		sbc		hl,de
		ret		nz

		ld		hl,255
		ld		(ROTATIVO_X_PRESENTACION),hl
		ret


PREPARA_ROTATIVO_EN_PAGE_1:

		; Pintamos un rectángulo negro en page 1,
		; sólo en la ventana central X=8..247.

		ld		hl,DATOS_NEGRO_ROTATIVO_EN_PAGE_1
		call	DOCOPY
		jp		VDPREADY


COPIA_ROTATIVO_PAGE_1_A_VISIBLE:

		; Copiamos de page 1 a page 0 visible,
		; sólo X=8..247 para evitar bordes feos.

		ld		hl,DATOS_COPY_ROTATIVO_PAGE_1_A_VISIBLE
		call	DOCOPY
		jp		VDPREADY


PINTA_ROTATIVO_PRESENTACION_EN_PAGE_1:

		; GRPPRT dibuja en la página activa.
		; Ponemos page 1 como activa, pero NO como visible.

		ld		a,1
		ld		(ACPAGE),a

		ld		a,15
		ld		(FORCLR),a

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
		cp		248
		jr		nc,.SALTA_CARACTER_ROTATIVO_PRESENTACION

		push	hl
		push	ix

		ld		(GRPACX),hl

		ld		hl,ROTATIVO_Y_PRESENTACION
		ld		(GRPACY),hl

		ld		a,(ix+0)
		call	GRPPRT

		pop		ix
		pop		hl


.SALTA_CARACTER_ROTATIVO_PRESENTACION:

		ld		de,8
		add		hl,de

		inc		ix
		jp		.BUCLE_PINTA_ROTATIVO_PRESENTACION


.FIN_PINTA_ROTATIVO_PRESENTACION:

		; Devolvemos page 0 como activa para no dejar el sistema raro.

		xor		a
		ld		(ACPAGE),a
		ret


DATOS_NEGRO_ROTATIVO_EN_PAGE_1:

		; Rectángulo negro en page 1.
		; X=8, Y=ROTATIVO_Y_PRESENTACION
		; ancho 240, alto 8.

		dw		#0000,#0000
		dw		#0008,#0100+ROTATIVO_Y_PRESENTACION
		dw		#00F0,#0008
		db		#00,#00,11000000b


DATOS_COPY_ROTATIVO_PAGE_1_A_VISIBLE:

		; Page 1 -> page 0 visible.
		; Sólo ventana central X=8..247.

		dw		#0008,#0100+ROTATIVO_Y_PRESENTACION
		dw		#0008,#0000+ROTATIVO_Y_PRESENTACION
		dw		#00F0,#0008
		db		#00,#00,10010000b

; Editar estas lineas al sacar una version nueva.
; Regla del porcentaje: cada fase vale 2, cada enemigo y bloque auxiliar vale 1.
; EN TOTAL HAY 
; 5 PUNTOS DE 2(FASES) 4 HECHOS
; 6 PUNTOS DE 2(ENEMIGOS) 3 HECHOS
; 4 PUNTOS DE 1(LOGO, MENU, ANIMACION PRESENTACION Y ANIMACION CIERRE) 1 HECHO
; PUNTOS ACTUALES = (4+3)*2 + 1*1 = 15, PORCENTAJE ACTUAL = 15/16 = 93% APROXIMADAMENTE

TEXTO_ROTATIVO_PRESENTACION:

		db		"BLUE WARRIOR II - Beta version 4.3.3 - 14/5/2026 - 93% - (C) Digital Moai - TECLAS 1 - 5 PARA IR DIRECTO A FASE",0

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

		call	FADE_OUT_PRESENTACION
		call	PARA_MUSICA_MENU_PRESENTACION

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
