
        jp      CARGA_LOGO_EN_VRAM
TRAS_GAME_OVER_JUEGO_AQUI:

        ld	    a,2
        call    CHANGE_BANK_2

        ld 	    a,10101000B
        ld 	    (RG5SAV),a			
        ld	    b,a
        ld	    c,5
        call	WRTVDP_EN_RAM	

        ld	    a,0							                            ; a     = el valor que vamos a poner
        ld	    bc,#ffff						                        ; bc	= longitud del area a rellenar con el dato A
        ld	    hl,#4A00						                        ; hl	= dirección en la que empieza a pintar
        call	FILVRM_RAM						                        ; Limpiamos toda esta zona de la VRAM 

        jp      CARGA_SLOT_MENU
CARGA_LOGO_EN_VRAM:

        ld      a,7                                                     ; Modo gráfico G6
        call    CHGMOD

        call    DISSCR_RAM

        ld	    hl,GRAFICOS_MOAI_1					                    ; Carga gráficos Moai
        ld	    de,#0000
        ld	    bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

	    ld  	a,40
	    ld      (DIRPA2),a								    ; Banco 2, pagina 2 del MEGAROM        

        ld	    hl,GRAFICOS_MOAI_2					                    ; Carga gráficos Moai
        ld	    de,#4000
        ld	    bc,16384
        call	PON_COLOR_2.sin_bc_impuesta 

	    ld  	a,41
	    ld      (DIRPA2),a								    ; Banco 2, pagina 2 del MEGAROM        

        ld	    hl,GRAFICOS_MOAI_3					                    ; Carga gráficos Moai
        ld	    de,#8000
        ld	    bc,16384
        call	PON_COLOR_2.sin_bc_impuesta    

	    ld  	a,2
	    ld      (DIRPA2),a								    ; Banco 2, pagina 2 del MEGAROM        

        ld	    hl,GRAFICOS_MOAI_4					                    ; Carga gráficos Moai
        ld	    de,#C000
        ld	    bc,6912
        call	PON_COLOR_2.sin_bc_impuesta 

RECOLOCAMOS_GRAFICOS_Y_LIMPIEZA:

        ld	    hl,COPIA_PAGE_0_A_PAGE_1
        call	DOCOPY
        ld	    hl,LIMPIA_PANTALLA_0
        call	DOCOPY
        ld      b,28
        call    BLOQUE_PAUSA
        call    ENASCR_RAM                                              ; Conectamos la pantalla

CARGAMOS_PALETA:

	    ld	    hl,PALETA_MOAI						                    ; Primera paleta de colores
	    call	SETPALETE

ANIMACION_TITULO:

    ld      b,22
    ld      hl,FOTOGRAMAS

.BUCLE_COPYS_1:

    push    bc
    push    hl
    call    DOCOPY

    pop     hl
    ld      de,15
    or      a
    adc     hl,de
    pop     bc
    djnz    .BUCLE_COPYS_1

PEQUENA_PAUSA_1:

    ld      B,150
    call    BLOQUE_PAUSA    
SCROLL_HACIA_ABAJO:


SPRITES_RECORREN_MOAI:

SCROLL_HACIA_ARRIBA:

PEUQUENA_PAUSA_2:

    ld      B,150
    call    BLOQUE_PAUSA    

SALIMOS_DE_LA_ANIMACION:

        call    DISSCR_RAM

        ld      a,5                                                     ; Modo gráfico G4
        call    CHGMOD  

        ld	    hl,LIMPIA_PANTALLA_3_sc5
        halt
        call	DOCOPY

        call    DISSCR_RAM

        jp      CARGA_SLOT_MENU

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

        incbin  "PALETAS/SOLOTITULO.PAL"
FADE_IN_MOAI:

        incbin  "PALETAS/DIGITAL_MOAI.FADEIN"

FADE_OUT_MOAI:

        incbin  "PALETAS/DIGITAL_MOAI.FADEOUT"
        
DATAS:

COPIA_PAGE_0_A_PAGE_1:

	dw      #0000,#0000,#0200,#0100,#0000,#0000
	db      #00,#00,11100000b

LIMPIA_PANTALLA_0:

	dw      #0000,#0000,#0000,#0000,#0200,#0100
	db      #00,#00,10000000b

LIMPIA_PANTALLA_3_sc5:

	dw      #0000,#0000,#0000,#0300,#0100,#0100
	db      #00,#00,10000000b

FOTOGRAMAS:

        dw      256,#1B4,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#1A3,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#191,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#17f,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#16d,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#15b,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#149,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#137,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#125,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#113,128,096,254,018
	    db      #00,#00,10010000b

        dw      256,#100,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#1B4,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#1A3,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#191,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#17f,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#16d,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#15b,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#149,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#137,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#125,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#113,128,096,254,018
	    db      #00,#00,10010000b

        dw      2,#100,128,096,254,018
	    db      #00,#00,10010000b
