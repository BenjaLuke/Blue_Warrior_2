MOSTRAMOS_GAME_OVER:

.CARGA_MUSICA:

        xor     a
        ld      (MUSICA_BEST_ON),a
		ld		hl,M_GAME_OVER_1
		ld		(MUSIC_ON),hl

        call    INICIAMOS_MUSICA
		ld		a,(FASE)
		add		20
		call	CHANGE_BANK_2
		di
		call	strmus
		ei		
        call    PAGE_10_A_SEGMENT_2

	ld		a,100
	call	BUCLE_PINTA_TILES.rutina_de_pausa

.CARGA_SPRITES:


		ld		hl,SPRITES_STAGE_DESDE_A
        call    PAGE_32_A_SEGMENT_2
		ld		de,#42E0
		ld		bc,96
		call	PON_COLOR_2.sin_bc_impuesta

		ld		hl,SPRITES_GAME_OVER_RESTANTE
		ld		de,#4340
		ld		bc,128
		call	PON_COLOR_2.sin_bc_impuesta

        ld      de,#4800
        ld	    hl,COLOR_TITULO_GAME_OVER						; Damos color al sprite en la posición de sprite que le toca	
        ld      bc,16*8
        call    PON_COLOR_2.sin_bc_impuesta

		call	PAGE_10_A_SEGMENT_2

.DEFINE_SPRITES:

        ld      de,ENEMIGOS
        ld      hl,DATAS_SPRITES_GAMEOVER
        ld      bc,88
        ldir

.ARREGLA_LA_Y:

        ld      b,8
        ld      ix,ENEMIGOS
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        add     80
        ld      c,a

.BUCLE_DE_REPARACION:

        ld      a,(ix+1)
        add     c
        ld      (ix+1),a
        ld      a,(ix+3)
        add     c
        ld      (ix+3),a
        ld      de,11
        add     ix,de
        djnz    .BUCLE_DE_REPARACION

.COMIENZA_BUCLE:

    ld      b,200                   ; Los fotogramas antes de marchar
    ld      iy,PROYECTILES

.RUTINA_MOVIMIENTO_SPRITES:

    ld      ix,ENEMIGOS
    ld      hl,0
    ld      (VARIABLE_UN_USO),hl

    push    bc
    ld      b,8
[8]    halt
    jp      .BUCLE_8_SPRITES

.FIN_BUCLE_8_SPRITES:

    pop     bc
    djnz    .BUCLE_8_SPRITES

.TERMINA_BUCLE:

    pop     bc
    djnz    .RUTINA_MOVIMIENTO_SPRITES
    jp      .VOLVEMOS_A_MISMO_PUNTO_ANTES_DE_GAME_OVER

.BUCLE_8_SPRITES:

    push    bc

.movimiento_x:

    ld      a,(ix+2)
    ld      b,a
    ld      a,(ix)
    cp      b
    jp      c,.x_es_menor

.x_es_mayor:

    ld      a,(ix+4)
    or      a
    jp      z,.reduciendo_sumatorio_x_cuando_es_mayor
    jp      .aumentando_sumatorio_x_cuando_es_mayor

.x_es_menor:

    ld      a,(ix+4)
    or      a
    jp      nz,.reduciendo_sumatorio_x_cuando_es_menor
    jp      .aumentando_sumatorio_x_cuando_es_menor

.reduciendo_sumatorio_x_cuando_es_mayor:

    ld      a,(ix+5)
    dec     a
    ld      (ix+5),a
    or      a
    jp      nz,.x_suma

    ld      a,1
    ld      a,(ix+4)

    ld      a,(ix+9)
    dec     a
    ld      (ix+9),a

    cp      255
    jp      nz,.x_suma
    xor     a
    ld      (ix+9),a
    jp      .x_suma

.aumentando_sumatorio_x_cuando_es_mayor:

    ld      a,(ix+5)
    inc     a
    ld      (ix+5),a

    ld      b,a
    ld      a,(ix+9)
    cp      b
    jp      nc,.x_resta

    ld      (ix+5),a

    jp      .x_resta

.reduciendo_sumatorio_x_cuando_es_menor:

    ld      a,(ix+5)
    dec     a
    ld      (ix+5),a
    or      a
    jp      nz,.x_resta

    ld      a,0
    ld      a,(ix+4)

    ld      a,(ix+9)
    dec     a
    ld      (ix+9),a
    cp      255
    jp      nz,.x_suma
    xor     a
    ld      (ix+9),a
    jp      .x_resta

.aumentando_sumatorio_x_cuando_es_menor:

    ld      a,(ix+5)
    inc     a
    ld      (ix+5),a

    ld      b,a
    ld      a,(ix+9)
    cp      b
    jp      nc,.x_resta

    ld      (ix+5),a

    jp      .x_suma

.x_suma:

    ld      a,(ix+5)
    ld      b,a
    ld      a,(ix)
    add     b
    ld      (ix),a
    jp      .movimiento_y

.x_resta:

    ld      a,(ix+5)
    ld      b,a
    ld      a,(ix)
    sub     b
    ld      (ix),a
    jp      .movimiento_y

.movimiento_y:

    ld      a,(ix+3)
    ld      b,a
    ld      a,(ix+1)
    cp      b
    jp      c,.y_es_menor

.y_es_mayor:

    ld      a,(ix+7)
    or      a
    jp      z,.reduciendo_sumatorio_y_cuando_es_mayor
    jp      .aumentando_sumatorio_y_cuando_es_mayor

.y_es_menor:

    ld      a,(ix+7)
    or      a
    jp      nz,.reduciendo_sumatorio_y_cuando_es_menor
    jp      .aumentando_sumatorio_y_cuando_es_menor

.reduciendo_sumatorio_y_cuando_es_mayor:

    ld      a,(ix+6)
    dec     a
    ld      (ix+6),a
    or      a
    jp      nz,.y_suma

    ld      a,1
    ld      a,(ix+7)

    ld      a,(ix+10)
    dec     a
    ld      (ix+10),a

    cp      255
    jp      nz,.y_suma
    xor     a
    ld      (ix+10),a
    jp      .y_suma

.aumentando_sumatorio_y_cuando_es_mayor:

    ld      a,(ix+6)
    inc     a
    ld      (ix+6),a

    ld      b,a
    ld      a,(ix+10)
    cp      b
    jp      nc,.y_resta

    ld      (ix+6),a

    jp      .y_resta

.reduciendo_sumatorio_y_cuando_es_menor:

    ld      a,(ix+6)
    dec     a
    ld      (ix+6),a
    or      a
    jp      nz,.y_resta

    ld      a,0
    ld      a,(ix+7)

    ld      a,(ix+10)
    dec     a
    ld      (ix+10),a
    cp      255
    jp      nz,.y_suma
    xor     a
    ld      (ix+10),a
    jp      .y_resta

.aumentando_sumatorio_y_cuando_es_menor:

    ld      a,(ix+6)
    inc     a
    ld      (ix+6),a

    ld      b,a
    ld      a,(ix+10)
    cp      b
    jp      nc,.y_resta

    ld      (ix+6),a

    jp      .y_suma

.y_suma:

    ld      a,(ix+6)
    ld      b,a
    ld      a,(ix+1)
    add     b
    ld      (ix+1),a
    jp      .PINTA_SPRITES

.y_resta:

    ld      a,(ix+6)
    ld      b,a
    ld      a,(ix+1)
    sub     b
    ld      (ix+1),a

.PINTA_SPRITES:

    ld      a,(ix)
    ld      (iy+1),a
    ld      a,(ix+1)
    ld      (iy),a
    ld      a,(ix+8)
    ld      (iy+2),a

    push    ix    
	ld		hl,PROYECTILES
    ld      ix,#4a00
    ld      de,(VARIABLE_UN_USO)
    add     ix,de
    push    ix
    pop     de
    pop     ix
    
	ld		bc,4
    push    ix
    push    iy
	call	PON_COLOR_2.sin_bc_impuesta

    ld      hl,(VARIABLE_UN_USO)
    ld      de,4
    or      a
    adc     hl,de
    ld      (VARIABLE_UN_USO),hl

    pop     iy
    pop     ix

.AUMENTAMOS_PARA_SIGUIENTE_SPRITE:

    ld      de,11
    add     ix,de

    jp      .FIN_BUCLE_8_SPRITES

.VOLVEMOS_A_MISMO_PUNTO_ANTES_DE_GAME_OVER:

	ld		a,11
	ld		(ESTADO_COLOR_PERM),a      

	ld		a,255
	call	BUCLE_PINTA_TILES.rutina_de_pausa

    call    DISSCR_RAM

	call	stpmus

	jp		CARGA_SLOT_JUEGO_TRAS_GAME_OVER

DATAS_SPRITES_GAMEOVER:

        db  255,0,90,71,1,0,4,0,24*4,10,9
        db  0,255,110,68,1,4,4,0,23*4,8,7
        db  40,0,128,68,1,4,4,0,26*4,9,10
        db  180,255,148,71,0,4,4,0,25*4,7,8
        db  80,255,89,90,0,4,4,1,27*4,8,10
        db  200,0,110,92,0,4,4,1,28*4,7,9
        db  30,0,128,92,1,4,4,1,25*4,10,7
        db  129,255,148,89,1,4,4,1,29*4,9,8
        