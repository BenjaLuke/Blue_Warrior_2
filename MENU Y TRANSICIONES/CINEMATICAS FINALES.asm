CINEMATICA_FINAL_FUENTE_Y_ORIGEN              equ     #0300+213
CINEMATICA_FINAL_LETRA_ANCHO                 equ     6
CINEMATICA_FINAL_LETRA_ALTO                  equ     6
CINEMATICA_FINAL_LETRA_ESPECIAL_BASE         equ     26
CINEMATICA_FINAL_LETRA_ESPECIALES_CANT       equ     16
CINEMATICA_FINAL_LETRA_ESPACIO               equ     CINEMATICA_FINAL_LETRA_ESPECIAL_BASE+CINEMATICA_FINAL_LETRA_ESPECIALES_CANT
CINEMATICA_FINAL_FUENTE_CARACTERES           equ     CINEMATICA_FINAL_LETRA_ESPACIO+1
CINEMATICA_FINAL_TEXTO_X                     equ     12
CINEMATICA_FINAL_TEXTO_Y_1                   equ     154
CINEMATICA_FINAL_TEXTO_Y_2                   equ     164
CINEMATICA_FINAL_TEXTO_Y_3                   equ     174
CINEMATICA_FINAL_TEXTO_Y_4                   equ     184
CINEMATICA_FINAL_PAUSA_LETRA                 equ     4
CINEMATICA_FINAL_PAUSA_FINAL                 equ     250


COMIENZA_CINEMATICA_FINAL:	

    	di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a

		ld		sp,0xE500
		ld 		a,(RG0SAV)
		and		11101111B
		ld		(RG0SAV),a
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM

		call	PAGE_10_A_SEGMENT_2

PRIMEROS_PASOS:

		call	DISSCR_RAM

		ld		a,5
		call	CHGMOD

		call	DISSCR_RAM

		; Limpiamos VRAM completa para no arrastrar restos de otras fases.

		xor		a
		ld		hl,#0000
		ld		bc,#ffff
		call	FILVRM_RAM

		; Pagina visible = 0.

		xor		a
		call	SETPAGE

		; Cargamos fuente en page 3 y las cuatro fotos finales:
		; page 1 = fotos 5/6
		; page 2 = fotos 7/8
		; page 3 = fuente del menu para escribir textos

		call	CARGA_GRAFICOS_CINEMATICA_FINAL
        call    INICIA_MUSICA_CINEMATICA_FINAL
        jp      CINEMATICA_FINAL


INICIA_MUSICA_CINEMATICA_FINAL:

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
		; Para esta cinematica necesitamos envolverla para forzar page 39.

		call	INSTALA_INTERRUPCION_MUSICA_CINEMATICA_FINAL
		ei

		call	PAGE_10_A_SEGMENT_2

		ret


INSTALA_INTERRUPCION_MUSICA_CINEMATICA_FINAL:

		ld		a,#C3
		ld		(HTIMI),a
		ld		hl,INTERRUPCION_MUSICA_CINEMATICA_FINAL
		ld		(HTIMI+1),hl
		ret


INTERRUPCION_MUSICA_CINEMATICA_FINAL:

		ld		a,(DIRPA2)
		push	af
		ld		a,39
		ld		(DIRPA2),a

		call	musint

		pop		af
		ld		(DIRPA2),a

		ret


CINEMATICA_FINAL:

		xor		a
		call	SETPAGE

		ld		hl,DATOS_COPY_CINEMATICA_FINAL_5
		ld		ix,TEXTO_CINEMATICA_FINAL_1
		call	EJECUTA_BLOQUE_CINEMATICA_FINAL_5_6

		ld		hl,DATOS_COPY_CINEMATICA_FINAL_6
		ld		ix,TEXTO_CINEMATICA_FINAL_2
		call	EJECUTA_BLOQUE_CINEMATICA_FINAL_5_6

		ld		hl,DATOS_COPY_CINEMATICA_FINAL_7
		ld		ix,TEXTO_CINEMATICA_FINAL_3
		call	EJECUTA_BLOQUE_CINEMATICA_FINAL_7_8

		ld		hl,DATOS_COPY_CINEMATICA_FINAL_8
		ld		ix,TEXTO_CINEMATICA_FINAL_4
		call	EJECUTA_BLOQUE_CINEMATICA_FINAL_7_8

		jp		NOS_VAMOS_AL_INICIO_DEL_TODO


EJECUTA_BLOQUE_CINEMATICA_FINAL_5_6:

		push	hl
		push	ix

		call	PONE_PRIMERA_PALETA_CINEMATICA_FINAL_5_6
		call	LIMPIA_PAGE_0_CINEMATICA_FINAL

		pop		ix
		pop		hl

		push	ix
		call	DOCOPY
		call	VDPREADY
		call	ENASCR_RAM

		call	FADE_IN_CINEMATICA_FINAL_5_6
		call	PONE_PALETA_FINAL_CINEMATICA_FINAL_5_6

		pop		ix
		push	ix
		call	PINTA_CUATRO_FRASES_CINEMATICA_FINAL

		ld		b,CINEMATICA_FINAL_PAUSA_FINAL
		call	ESPERA_CINEMATICA_FINAL_B

		call	FADE_OUT_CINEMATICA_FINAL_5_6

		pop		ix
		ret


EJECUTA_BLOQUE_CINEMATICA_FINAL_7_8:

		push	hl
		push	ix

		call	PONE_PRIMERA_PALETA_CINEMATICA_FINAL_7_8
		call	LIMPIA_PAGE_0_CINEMATICA_FINAL

		pop		ix
		pop		hl

		push	ix
		call	DOCOPY
		call	VDPREADY
		call	ENASCR_RAM

		call	FADE_IN_CINEMATICA_FINAL_7_8
		call	PONE_PALETA_FINAL_CINEMATICA_FINAL_7_8

		pop		ix
		push	ix
		call	PINTA_CUATRO_FRASES_CINEMATICA_FINAL

		ld		b,CINEMATICA_FINAL_PAUSA_FINAL
		call	ESPERA_CINEMATICA_FINAL_B

		call	FADE_OUT_CINEMATICA_FINAL_7_8

		pop		ix
		ret


PONE_PRIMERA_PALETA_CINEMATICA_FINAL_5_6:

		ld		hl,FADE_IN_DATOS_CINEMATICA_FINAL_5_6
		jp		SETPALETE_CINEMATICA_FINAL


PONE_PRIMERA_PALETA_CINEMATICA_FINAL_7_8:

		ld		hl,FADE_IN_DATOS_CINEMATICA_FINAL_7_8
		jp		SETPALETE_CINEMATICA_FINAL


PONE_PALETA_FINAL_CINEMATICA_FINAL_5_6:

		ld		hl,PALETA_DATOS_CINEMATICA_FINAL_5_6
		jp		SETPALETE_CINEMATICA_FINAL


PONE_PALETA_FINAL_CINEMATICA_FINAL_7_8:

		ld		hl,PALETA_DATOS_CINEMATICA_FINAL_7_8
		jp		SETPALETE_CINEMATICA_FINAL


FADE_IN_CINEMATICA_FINAL_5_6:

		ld		hl,FADE_IN_DATOS_CINEMATICA_FINAL_5_6+32
		ld		e,6
		jp		BUCLE_FADE_CINEMATICA_FINAL


FADE_IN_CINEMATICA_FINAL_7_8:

		ld		hl,FADE_IN_DATOS_CINEMATICA_FINAL_7_8+32
		ld		e,6
		jp		BUCLE_FADE_CINEMATICA_FINAL


FADE_OUT_CINEMATICA_FINAL_5_6:

		ld		hl,FADE_OUT_DATOS_CINEMATICA_FINAL_5_6
		ld		e,7
		jp		BUCLE_FADE_CINEMATICA_FINAL


FADE_OUT_CINEMATICA_FINAL_7_8:

		ld		hl,FADE_OUT_DATOS_CINEMATICA_FINAL_7_8
		ld		e,7
		jp		BUCLE_FADE_CINEMATICA_FINAL


BUCLE_FADE_CINEMATICA_FINAL:

		call	SETPALETE_CINEMATICA_FINAL
		push	hl
		push	de
		ld		b,6
		call	ESPERA_CINEMATICA_FINAL_B
		pop		de
		pop		hl

		dec		e
		jp		nz,BUCLE_FADE_CINEMATICA_FINAL
		or		a
		ret


SETPALETE_CINEMATICA_FINAL:

		xor		a
		di
		out		(#99),a
		ld		a,16+128
		out		(#99),a
		ld		c,#9A
[32]	outi
		ei
		ret


PINTA_CUATRO_FRASES_CINEMATICA_FINAL:

		push	ix
		pop		hl

		ld		de,CINEMATICA_FINAL_TEXTO_Y_1
		call	PINTA_FRASE_CINEMATICA_FINAL_DESDE_TABLA

		ld		de,CINEMATICA_FINAL_TEXTO_Y_2
		call	PINTA_FRASE_CINEMATICA_FINAL_DESDE_TABLA

		ld		de,CINEMATICA_FINAL_TEXTO_Y_3
		call	PINTA_FRASE_CINEMATICA_FINAL_DESDE_TABLA

		ld		de,CINEMATICA_FINAL_TEXTO_Y_4
		jp		PINTA_FRASE_CINEMATICA_FINAL_DESDE_TABLA


PINTA_FRASE_CINEMATICA_FINAL_DESDE_TABLA:

		ld		c,(hl)
		inc		hl
		ld		b,(hl)
		inc		hl
		push	hl
		push	bc
		pop		ix
		ld		hl,CINEMATICA_FINAL_TEXTO_X
		call	PINTA_TEXTO_CINEMATICA_FINAL_FORMA_3
		pop		hl
		ret


PINTA_TEXTO_CINEMATICA_FINAL_FORMA_3:

		ld		a,(ix+0)
		or		a
		ret		z

		push	de
		push	hl
		push	ix
		call	PINTA_LETRA_CINEMATICA_FINAL_EN_DESTINO
		pop		ix
		pop		hl
		pop		de

		call	ESPERA_LETRA_CINEMATICA_FINAL

		ld		bc,CINEMATICA_FINAL_LETRA_ANCHO
		add		hl,bc
		inc		ix
		jp		PINTA_TEXTO_CINEMATICA_FINAL_FORMA_3


PINTA_LETRA_CINEMATICA_FINAL_EN_DESTINO:

		push	hl
		push	de
		call	CALCULA_ORIGEN_X_LETRA_CINEMATICA_FINAL
		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		(ix),l
		ld		(ix+1),h
		ld		hl,CINEMATICA_FINAL_FUENTE_Y_ORIGEN
		ld		(ix+2),l
		ld		(ix+3),h
		pop		hl
		ld		(ix+6),l
		ld		(ix+7),h
		pop		hl
		ld		(ix+4),l
		ld		(ix+5),h
		ld		(ix+8),CINEMATICA_FINAL_LETRA_ANCHO
		ld		(ix+9),0
		ld		(ix+10),CINEMATICA_FINAL_LETRA_ALTO
		ld		(ix+11),0
		ld		(ix+12),#00
		ld		(ix+13),#00
		ld		(ix+14),11010000b
		call	HL_DATOS_DEL_COPY
		jp		VDPREADY


CALCULA_ORIGEN_X_LETRA_CINEMATICA_FINAL:

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

		ld		hl,TABLA_ESPECIALES_CINEMATICA_FINAL
		ld		b,CINEMATICA_FINAL_FUENTE_CARACTERES-CINEMATICA_FINAL_LETRA_ESPECIAL_BASE
		ld		c,CINEMATICA_FINAL_LETRA_ESPECIAL_BASE

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

		ld		a,CINEMATICA_FINAL_LETRA_ESPACIO

.MULTIPLICA:

		ld		e,a
		ld		d,0
		ld		h,d
		ld		l,e
		add		hl,hl
		add		hl,de
		add		hl,hl
		ret


ESPERA_LETRA_CINEMATICA_FINAL:

		ld		b,CINEMATICA_FINAL_PAUSA_LETRA


ESPERA_CINEMATICA_FINAL_B:

		halt
		djnz	ESPERA_CINEMATICA_FINAL_B
		or		a
		ret


LIMPIA_PAGE_0_CINEMATICA_FINAL:

		ld		hl,DATOS_NEGRO_PAGE_0_CINEMATICA_FINAL
		call	DOCOPY
		jp		VDPREADY


CARGA_GRAFICOS_CINEMATICA_FINAL:

		; Primero cargamos la imagen del menu en page 1 y la copiamos a page 3.
		; La necesitamos solo como banco oculto de fuente para escribir texto.

		call	CARGA_FUENTE_CINEMATICA_FINAL_EN_PAGE_1
		ld		hl,DATOS_COPY_CINEMATICA_FINAL_PAGE_1_A_PAGE_3
		call	DOCOPY
		call	VDPREADY

		; Despues cargamos las fotos 7/8 en page 1 y las preservamos en page 2.

		call	CARGA_GRAFICOS_CINEMATICA_7_8_EN_PAGE_1
		ld		hl,DATOS_COPY_CINEMATICA_FINAL_PAGE_1_A_PAGE_2
		call	DOCOPY
		call	VDPREADY

		; Finalmente cargamos las fotos 5/6 en page 1.

		jp		CARGA_GRAFICOS_CINEMATICA_5_6_EN_PAGE_1


CARGA_FUENTE_CINEMATICA_FINAL_EN_PAGE_1:

		di
		ld		a,4
		ld		(DIRPA2),a

		ld		hl,PANTALLA_DE_PRESENTACION_1
		ld		de,#8000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,5
		ld		(DIRPA2),a

		ld		hl,PANTALLA_DE_PRESENTACION_2
		ld		de,#C000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta

		ei
		ret


CARGA_GRAFICOS_CINEMATICA_7_8_EN_PAGE_1:

		di
		ld		a,6
		ld		(DIRPA2),a

		ld		hl,CINEMATICA_7_8_1
		ld		de,#8000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,66
		ld		(DIRPA2),a

		ld		hl,CINEMATICA_7_8_2
		ld		de,#C000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta

		ei
		ret


CARGA_GRAFICOS_CINEMATICA_5_6_EN_PAGE_1:

		di
		ld		a,7
		ld		(DIRPA2),a

		ld		hl,CINEMATICA_5_6_1
		ld		de,#8000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,8
		ld		(DIRPA2),a

		ld		hl,CINEMATICA_5_6_2
		ld		de,#C000
		ld		bc,#4000
		call	PON_COLOR_2.sin_bc_impuesta

		ei
		ret


NOS_VAMOS_AL_INICIO_DEL_TODO:

     	di
		ld		a,#C9
		ld		(HTIMI),a
		ld		(HKEYI),a
        ei

		ld		sp,0xE500
		ld 		a,(RG0SAV)
		and		11101111B
		ld		(RG0SAV),a
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM

		ld		a,0
		ld      (DIRPA1),a

        jp		MARCA


DATOS_COPY_CINEMATICA_FINAL_PAGE_1_A_PAGE_2:

		dw		#0000,#0100
		dw		#0000,#0200
		dw		#0100,#0100
		db		#00,#00,10010000b


DATOS_COPY_CINEMATICA_FINAL_PAGE_1_A_PAGE_3:

		dw		#0000,#0100
		dw		#0000,#0300
		dw		#0100,#0100
		db		#00,#00,10010000b


DATOS_NEGRO_PAGE_0_CINEMATICA_FINAL:

		; Borra solo la zona visible util de page 0.
		; No baja hasta Y=232/#7400 ni Y=240/#7800.

		dw		#0000,#0000
		dw		#0000,#0000
		dw		#0100,#00D5
		db		#00,#00,11000000b

DATOS_COPY_CINEMATICA_FINAL_5:

		; Foto 1: page 1, desde 0,0 hasta 255,99.
		; Destino: page 0, 0,0.

		dw		#0000,#0100
		dw		#0000,#0000
		dw		#0100,#0064
		db		#00,#00,10010000b


DATOS_COPY_CINEMATICA_FINAL_6:

		; Foto 2: page 1, desde 0,100 hasta 255,199.
		; Destino: page 0, 0,0.

		dw		#0000,#0100+100
		dw		#0000,#0000
		dw		#0100,#0064
		db		#00,#00,10010000b


DATOS_COPY_CINEMATICA_FINAL_7:

		; Foto 3: page 2, desde 0,0 hasta 255,99.
		; Destino: page 0, 0,0.

		dw		#0000,#0200
		dw		#0000,#0000
		dw		#0100,#0064
		db		#00,#00,10010000b


DATOS_COPY_CINEMATICA_FINAL_8:

		; Foto 4: page 2, desde 0,100 hasta 255,199.
		; Destino: page 0, 0,0.

		dw		#0000,#0200+100
		dw		#0000,#0000
		dw		#0100,#0064
		db		#00,#00,10010000b


TEXTO_CINEMATICA_FINAL_1:

		dw		TEXTO_CINEMATICA_FINAL_1_1
		dw		TEXTO_CINEMATICA_FINAL_1_2
		dw		TEXTO_CINEMATICA_FINAL_1_3
		dw		TEXTO_CINEMATICA_FINAL_1_4


TEXTO_CINEMATICA_FINAL_2:

		dw		TEXTO_CINEMATICA_FINAL_2_1
		dw		TEXTO_CINEMATICA_FINAL_2_2
		dw		TEXTO_CINEMATICA_FINAL_2_3
		dw		TEXTO_CINEMATICA_FINAL_2_4


TEXTO_CINEMATICA_FINAL_3:

		dw		TEXTO_CINEMATICA_FINAL_3_1
		dw		TEXTO_CINEMATICA_FINAL_3_2
		dw		TEXTO_CINEMATICA_FINAL_3_3
		dw		TEXTO_CINEMATICA_FINAL_3_4


TEXTO_CINEMATICA_FINAL_4:

		dw		TEXTO_CINEMATICA_FINAL_4_1
		dw		TEXTO_CINEMATICA_FINAL_4_2
		dw		TEXTO_CINEMATICA_FINAL_4_3
		dw		TEXTO_CINEMATICA_FINAL_4_4


TEXTO_CINEMATICA_FINAL_1_1:
		db		"dEPH se lanzo a hacer pooldance.",0
TEXTO_CINEMATICA_FINAL_1_2:
		db		"era su ilusion desde pequeño y",0
TEXTO_CINEMATICA_FINAL_1_3:
		db		"ahora que ya no tenia obligaciones",0
TEXTO_CINEMATICA_FINAL_1_4:
		db		"podia cumplir su verdadero sueño.",0


TEXTO_CINEMATICA_FINAL_2_1:
		db		"Alli conocio a alguien que le ",0
TEXTO_CINEMATICA_FINAL_2_2:
		db		"marco profundamente.",0
TEXTO_CINEMATICA_FINAL_2_3:
		db		"sobretodo la garganta",0
TEXTO_CINEMATICA_FINAL_2_4:
		db		"y los dientes.",0


TEXTO_CINEMATICA_FINAL_3_1:
		db		"construyo una vida con ese ",0
TEXTO_CINEMATICA_FINAL_3_2:
		db		"desconocido. se convirtio",0
TEXTO_CINEMATICA_FINAL_3_3:
		db		"en el perfecto amo de casa",0
TEXTO_CINEMATICA_FINAL_3_4:
		db		"hasta que .....",0


TEXTO_CINEMATICA_FINAL_4_1:
		db		"Se quedo embarazado del",0
TEXTO_CINEMATICA_FINAL_4_2:
		db		"desconocido.",0
TEXTO_CINEMATICA_FINAL_4_3:
		db		"Ese hombre no era otro que",0
TEXTO_CINEMATICA_FINAL_4_4:
		db		"su creador: Manuel dopico.",0


TABLA_ESPECIALES_CINEMATICA_FINAL:

		db		"-/()1234567890%."

PALETA_DATOS_CINEMATICA_FINAL_5_6:
       	incbin  "../PALETAS/PRESENTACION/CINEMATICA56.palete"
FADE_IN_DATOS_CINEMATICA_FINAL_5_6:
		incbin  "../PALETAS/PRESENTACION/CINEMATICA56.fadein"
FADE_OUT_DATOS_CINEMATICA_FINAL_5_6:
		incbin  "../PALETAS/PRESENTACION/CINEMATICA56.fadeout"

PALETA_DATOS_CINEMATICA_FINAL_7_8:
        incbin  "../PALETAS/PRESENTACION/CINEMATICA78.palete"
FADE_IN_DATOS_CINEMATICA_FINAL_7_8:
        incbin  "../PALETAS/PRESENTACION/CINEMATICA78.fadein"
FADE_OUT_DATOS_CINEMATICA_FINAL_7_8:
        incbin  "../PALETAS/PRESENTACION/CINEMATICA78.fadeout"
