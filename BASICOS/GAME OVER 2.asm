MOSTRAMOS_GAME_OVER:

		xor		a
		ld		(ESTADO_MARCADOR),a

        ld		a,9
        ld		(ESTADO_COLOR_PERM),a      

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


		ld		hl,SPRITES_STAGE
        call    PAGE_32_A_SEGMENT_2
		ld		de,#4000+23*4*8
		ld		bc,5*4*8
		call	PON_COLOR_2.sin_bc_impuesta

		ld		hl,SPRITES_GAME_OVER_RESTANTE
		ld		de,#4000+29*4*8
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
        add     20
        ld      c,a

.BUCLE_DE_REPARACION:

        ld      a,(ix+3)
        add     c
        ld      (ix+3),a    
        ld      de,11
        add     ix,de
        djnz    .BUCLE_DE_REPARACION

.PREPARA_BUCLE:

        ld      b,200
        ld      iy,PROYECTILES

.BUCLE_2:

        ld      ix,ENEMIGOS
        ld      hl,0
        ld      (VARIABLE_UN_USO),hl

        push    bc

        ld      b,8

.BUCLE_1:

        push    bc

        push    iy
        ld      iy,TABLA_DE_POSICIONES_DE_LETRAS_GAME_OVER
        ld      a,(ix+4)
        ld      e,a
        ld      d,0
        push    de
        pop     hl
        or      a
        adc     hl,de
        push    hl
        pop     de
        add     iy,de

        ld      a,(iy)
        ld      b,a
        ld      a,(ix+2)
        add     b
        ld      (ix),a
       
        ld      a,(iy+1)
        ld      b,a
        ld      a,(ix+3)
        add     b
        ld      (ix+1),a   

        cp      216
        jp      nz,.BUCLE_0

        inc     a
        ld      (ix+1),a

.BUCLE_0:

        pop     iy

        ld      a,(ix+4)
        inc     a
        ld      (ix+4),a

        call    .PINTA_SPRITES

.AUMENTAMOS_PARA_SIGUIENTE_SPRITE:

        ld      de,11
        add     ix,de

        pop     bc
        djnz    .BUCLE_1

        ld      a,4
	    call	BUCLE_PINTA_TILES.rutina_de_pausa

        pop     bc
        djnz    .BUCLE_2



.VOLVEMOS_A_MISMO_PUNTO_ANTES_DE_GAME_OVER:

	ld		a,4
	ld		(ESTADO_COLOR_PERM),a      

	ld		a,255
	call	BUCLE_PINTA_TILES.rutina_de_pausa

	ld		a,100
	call	BUCLE_PINTA_TILES.rutina_de_pausa

    call    DISSCR_RAM

	call	stpmus

	jp		CARGA_SLOT_JUEGO_TRAS_GAME_OVER

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
    ret

DATAS_SPRITES_GAMEOVER:

        db  0,0,30+0,15,26,0,0,0,26*4,0,0
        db  0,0,30+17,10,24,0,0,0,25*4,0,0
        db  0,0,30+34,10,22,0,0,0,29*4,0,0
        db  0,0,30+51,15,20,0,0,0,27*4,0,0
        db  0,0,30+0,35,6,0,0,0,30*4,0,0
        db  0,0,30+17,40,4,0,0,0,31*4,0,0
        db  0,0,30+34,40,2,0,0,0,27*4,0,0
        db  0,0,30+51,35,0,0,0,0,32*4,0,0

TABLA_DE_POSICIONES_DE_LETRAS_GAME_OVER:						; X e Y a sumar al valor inicial dado de su X y su Y

		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0
		db		0,0        
		db		0,6
		db		0,16
		db		1,18
		db		1,24
		db		1,30
		db		1,36
		db		1,42
		db		2,48
		db		2,54
		db		3,60
		db		3,66
		db		4,72
		db		5,78
		db		6,84
		db		8,90
		db		10,96
		db		14,102
		db		18,108
		db		22,114
		db		27,120
		db		32,120
		db		37,126
		db		42,126
		db		47,126
		db		52,132
		db		57,132
		db		62,132
		db		66,132
		db		69,126
		db		71,126
		db		73,126
		db		74,126
		db		75,120
		db		75,120
		db		73,120
		db		71,120
		db		69,114
		db		68,117
		db		64,114
		db		64,117
		db		64,117
		db		64,120
		db		64,120
		db		64,120
		db		64,120
		db		64,123
		db		64,123
		db		64,123
		db		64,123
		db		64,123
		db		64,123
		db		64,123
		db		64,123
		db		64,120
		db		64,120
		db		64,120
		db		64,120
		db		64,117
		db		64,117
		db		64,114
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,111
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,105
		db		64,108
		db		64,108
		db		64,108
		db		64,108
		db		64,108
