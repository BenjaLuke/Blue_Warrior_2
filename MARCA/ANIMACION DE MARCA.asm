
        jp      CARGA_LOGO_EN_VRAM
TRAS_GAME_OVER_JUEGO_AQUI:

	ld	a,2
	call    CHANGE_BANK_2

	ld 	a,10101000B
	ld 	(RG5SAV),a			
	ld	b,a
	ld	c,5
	call	WRTVDP_EN_RAM	

        ld	a,0							                            ; a     = el valor que vamos a poner
        ld	bc,#ffff						                        ; bc	= longitud del area a rellenar con el dato A
        ld	hl,#4A00						                        ; hl	= dirección en la que empieza a pintar
        call	FILVRM_RAM						                        ; Limpiamos toda esta zona de la VRAM 

        jp      CARGA_SLOT_MENU
CARGA_LOGO_EN_VRAM:

        ld	hl,GRAFICOS_MOAI_1					                    ; Carga gráficos Moai
        ld	de,#8000
        ld	bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

	ld	a,2
	ld      (DIRPA2),a								    ; Banco 2, pagina 2 del MEGAROM        

        ld	hl,GRAFICOS_MOAI_2					                    ; Carga gráficos Moai
        ld	de,#C000
        ld	bc,6912
        call	PON_COLOR_2.sin_bc_impuesta           
RECOLOCAMOS_GRAFICOS_Y_LIMPIEZA:

        ld      hl,COPIA_PAGE1_A_PAGE2
        call    DOCOPY

        ld	hl,LIMPIA_PANTALLA_3_M
        call	DOCOPY

        ld	hl,LIMPIA_PANTALLA_1
        call	DOCOPY		

        call    ENASCR_RAM                                              ; Conectamos la pantalla

CARGAMOS_PALETA:

	ld	hl,PALETA_MOAI						                    ; Primera paleta de colores
	call	SETPALETE

EMPIEZA_EL_DOBLE_BUFFER:

        ld      hl,FOTOGRAMA_1
        ld      b,5

BUCLE_COPIS:                                                            ; Marca borrosa se enfoca

        push    bc                                                      
        call    BLOQUE_COPY_HALT
        ld      a,1
        call    SETPAGE

        call    BLOQUE_COPY_HALT
        xor     a
        call    SETPAGE
                
        pop     bc
        djnz    BUCLE_COPIS

        call    DOCOPY

        ld      b,40                                                    ; Mini pausa
        call    BLOQUE_PAUSA

        ld      b,8                                                     ; Fade in del Moai
        ld      hl,FADE_IN_MOAI
        call    FADE

        ld      b,100                                                   ; Maxi pausa
        call    BLOQUE_PAUSA

        ld      b,8                                                     ; Fade out global
        ld      hl,FADE_OUT_MOAI
        call    FADE

        ld	hl,LIMPIA_PANTALLA_0                                    ; Limpiamos la pantalla
        call	DOCOPY		

        jp      CARGA_SLOT_MENU
FADE:

    [5] halt
        call    SETPALETE
        djnz    FADE
        ret
BLOQUE_PAUSA:

        halt
        djnz    BLOQUE_PAUSA
        ret
BLOQUE_COPY_HALT:

        call    DOCOPY
    [3] halt
        ret

PALETAS:
PALETA_MOAI:

        incbin  "PALETAS/DIGITAL_MOAI.PAL"
FADE_IN_MOAI:

        incbin  "PALETAS/DIGITAL_MOAI.FADEIN"

FADE_OUT_MOAI:

        incbin  "PALETAS/DIGITAL_MOAI.FADEOUT"
        
DATAS:

LIMPIA_PANTALLA_0:

	dw      #0000,#0300,#0000,#0000,#0000,#0100
	db      #00,#00,11100000b

LIMPIA_PANTALLA_1:

	dw      #0000,#0000,#0000,#0100,#0000,#0100
	db      #00,#00,11100000b

LIMPIA_PANTALLA_3_M:

	dw      #0000,#0000,#0000,#0300,#0000,#0100
	db      #00,#00,11100000b

COPIA_PAGE1_A_PAGE2:

	dw      #0000,#0100,#0000,#0200,#0000,#0100
	db      #00,#00,11100000b

FOTOGRAMA_1:

        dw      0,#200,64,#100+96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_2:

        dw      0,#200+27,64,96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_3:

        dw      0,#200+54,64,#100+96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_4:

        dw      0,#200+81,64,96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_5:

        dw      129,#200,64,#100+96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_6:

        dw      129,#200+27,64,96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_7:

        dw      129,#200+54,64,#100+96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_8:

        dw      129,#200+81,64,96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_9:

        dw      129,#200+108,64,#100+96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_10:

        dw      129,#200+153,64,96,128,18
	db      #00,#00,10010000b
FOTOGRAMA_11:

        dw      129,#200+130,64,73,128,52
	db      #00,#00,10010000b