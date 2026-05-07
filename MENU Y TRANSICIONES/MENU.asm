COMIENZA_MENU:

		call	MUESTRA_CARTELA_DE_VERSION
		jp		PULSA_UNA_TECLA_PARA_EMPEZAR

MUESTRA_CARTELA_DE_VERSION:

		call	DISSCR_RAM
		call	INITXT

		ld		a,15
		ld		(FORCLR),a
		xor		a
		ld		(BAKCLR),a
		ld		(BDRCLR),a
		call	CHGCOLOR_RAM
		call	ERAFNK
		ld		a,40
		ld		(#F3AF),a
		ld		(#F3B0),a
		call	CLS

		ld		hl,TEXTO_MENU_1
		ld		de,#0D07
		call	IMPRIME_TEXTO_EN

		ld		hl,TEXTO_MENU_2
		ld		de,#0B08
		call	IMPRIME_TEXTO_EN

		ld		hl,TEXTO_MENU_3
		ld		de,#0F09
		call	IMPRIME_TEXTO_EN

		ld		hl,TEXTO_MENU_4
		ld		de,#120A
		call	IMPRIME_TEXTO_EN

		ld		hl,TEXTO_MENU_5
		ld		de,#0C0B
		call	IMPRIME_TEXTO_EN

		ld		hl,TEXTO_MENU_6
		ld		de,#0A0D
		call	IMPRIME_TEXTO_EN

		ld		hl,TEXTO_MENU_7
		ld		de,#040E
		call	IMPRIME_TEXTO_EN

		jp		ENASCR_RAM

IMPRIME_TEXTO_EN:

		push	hl
		ld		h,d
		ld		l,e
		call	POSIT
		pop		hl

.bucle:

		ld		a,(hl)
		or		a
		ret		z
		call	CHPUT
		inc		hl
		jp		.bucle

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

; Editar estas lineas al sacar una version nueva.
; Regla del porcentaje: cada fase vale 2, cada enemigo y bloque auxiliar vale 1.
; EN TOTAL HAY 
; 5 PUNTOS DE 2(FASES) 4 HECHOS
; 6 PUNTOS DE 2(ENEMIGOS) 2 HECHOS
; 4 PUNTOS DE 1(LOGO, MENU, ANIMACION PRESENTACION Y ANIMACION CIERRE) 1 HECHO
; PUNTOS ACTUALES = (4+2)*2 + 1*1 = 13, PORCENTAJE ACTUAL = 13/16 = 81% APROXIMADAMENTE
TEXTO_MENU_1:
		db		"Blue Warrior 2",0

TEXTO_MENU_2:
		db		"Beta version 4.0.13",0

TEXTO_MENU_3:
		db		"07/05/2026",0

TEXTO_MENU_4:
		db		"81%",0

TEXTO_MENU_5:
		db		"(c) Digital Moai",0

TEXTO_MENU_6:
		db		"ESPACIO PARA EMPEZAR",0

TEXTO_MENU_7:
		db		"TECLAS 1 - 5 PARA IR DIRECTO A FASE",0