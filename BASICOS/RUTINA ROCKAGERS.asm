        ld      a,(SECUENCIA_DE_ROCKAGER)
        cp      1
        jp      z,.MUERE_PRIMER_ROCKAGER
        cp      2
        jp      z,.SECUENCIA_2
        cp      3
        jp      z,.MUERE_PRIMER_ROCKAGER
        cp      4
        jp      z,.RECARGAMOS_GRAFICOS_STAGE_2

.SECUENCIA_1:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        ld      e,a
        ld      d,0
        push    de
        pop     hl
        or      a
[5]     adc     hl,de
        ex      de,hl
        ld      ix,.DATA_SECUENCIA_1_ROCKAGER
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER
        
        push    de
        call    .PINTAMOS_FOTOGRAMA
        pop     de
        ld      ix,.DATA_SECUENCIA_1_ROCKAGER_DOBLE
        call    .RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)

.REVISION_TEMBLEQUES:

        or      a
        call    z,.TEMBLEQUE
        cp      36
        call    z,.TEMBLEQUE
        cp      72
        call    z,.TEMBLEQUE

.ACTIVA_ROCAS_FASE_1:

        ex      af,af'
        ld      a,(PAUSA_EN_ANIMACION_ROCKAGER)
        cp      2
        jp      nz,.REVISION_PAUSAS

        ld      ix,VALORES_SPRITES_PIEDRAS

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        cp      13
        jp      z,.ACTIVANDO_COMUN
        cp      13+36
        jp      z,.ACTIVANDO_2
        cp      13+36+36
        jp      z,.ACTIVANDO_3
     
        jp      .REVISION_PAUSAS

.ACTIVANDO_2:

        ld      de,8
        jp      .ACTIVANDO_COMUN_PRE

.ACTIVANDO_3:

        ld      de,16

.ACTIVANDO_COMUN_PRE:

        add     ix,de

.ACTIVANDO_COMUN:

        xor     a
        ld      (ix+3),a
        ld      (ix+7),a

.REVISION_PAUSAS:

        ex      af,af'
        ld      b,9
        ld      ix,.VALORES_DE_PAUSA

.BUCLE_REVISION_PAUSAS:

        ld      c,(ix)
        cp      c
        jp      z,.PAUSA_DE_ANIMACION_1
        inc     ix
        djnz    .BUCLE_REVISION_PAUSAS

        inc     a
        cp      108
        jp      nz,.SALVAMOS_FOTOGRAMA_1
        ld      a,4

.SALVAMOS_FOTOGRAMA_1:

        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_1),a
        
        jp      .PINTAMOS_FOTOGRAMA

.PAUSA_DE_ANIMACION_1:

        ld      a,(PAUSA_EN_ANIMACION_ROCKAGER)
        inc     a
        and     00000111b
        ld      (PAUSA_EN_ANIMACION_ROCKAGER),a
        or      a
        jp      nz,.PINTAMOS_FOTOGRAMA
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        inc     a
        jp      .SALVAMOS_FOTOGRAMA_1

.MUERE_PRIMER_ROCKAGER:

        xor     a
        ld      (TIEMPO_DE_ADJUST),a

        ld      a,26
        ld      c,1
        call    TIRA_FX

        ld	de,#4A00+15*4
        call    .BORRA_POSIBLE_SPRITE_MAREO
        ld	de,#4A00+16*4
        call    .BORRA_POSIBLE_SPRITE_MAREO
        jp      .MUERE_PRIMER_ROCKAGER_CONT

.BORRA_POSIBLE_SPRITE_MAREO:

        ld    	a,255
        ld      c,0
        ld      iy,VALORES_SPRITE_MAREO
        ld      (iy),c
        ld      (iy+1),a
        ld      a,(iy+2)
        add     a,4
        ld      (iy+2),a
        ld      hl,VALORES_SPRITE_MAREO
	ld      bc,3
	jp  	PON_COLOR_2.sin_bc_impuesta
        
.MUERE_PRIMER_ROCKAGER_CONT:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_2)
        ld      b,a
[2]     sla     a
[2]     add     b
        ld      l,a
        ld      h,0     ;52ck


        ld      a,(POSICION_DERRUMBE_ROCKAGER)
        ld      e,a
        ld      d,0
        or      a
[36]    adc     hl,de

        ex      de,hl
        ld      ix,.DATA_MUERE_ROCKAGER
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_2)
        inc     a
        cp      5
        jp      nz,.SALVAMOS_FOTOGRAMA_MUERTE
        ld      a,(SECUENCIA_DE_ROCKAGER)
        inc     a
        ld      (SECUENCIA_DE_ROCKAGER),a
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_1),a
        xor      a

.SALVAMOS_FOTOGRAMA_MUERTE:

        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_2),a
        jp      .PINTAMOS_FOTOGRAMA

.SECUENCIA_2:

.SECUENCIA_2_CONT:

        xor     a
        ld      (VELOCIDAD_ROCKAGER),a

.ACTIVA_ROCAS_FASE_2:

        ld      ix,VALORES_SPRITES_PIEDRAS
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        cp      13
        jp      z,.ACTIVANDO_COMUN_2
        cp      13+36
        jp      z,.ACTIVANDO_2_2
        cp      13+36+36
        jp      z,.ACTIVANDO_3_2
        cp      13+36+36+36
        jp      z,.ACTIVANDO_4_2
        cp      13+36+36+36+36
        jp      z,.ACTIVANDO_5_2
        cp      13+36+36+36+36+36
        jp      z,.ACTIVANDO_6_2
     
        jp      .SECUENCIA_2_CONT_2

.ACTIVANDO_2_2:

        ld      de,4
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_3_2:

        ld      de,8
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_4_2:

        ld      de,12
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_5_2:

        ld      de,16
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_6_2:

        ld      de,20

.ACTIVANDO_COMUN_PRE_2:

        add     ix,de

.ACTIVANDO_COMUN_2:

        xor     a
        ld      (ix+3),a

.SECUENCIA_2_CONT_2:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)

.MIRAMOS_SI_SALTA_AGUJERO:

        ld      c,a
        ld      a,(AGUJERO_INTOCABLE)
        cp      c
        ld      a,c
        jp      nz,.SEGUIMOS_CON_EL_FOTOGRAMA
        cp      37+37+37+37+37-5
        jp      z,.CAMBIO_DE_FOTOGRAMA_A_CERO
        add     37
        jp      .CAMBIO_DE_FOTOGRAMA

.CAMBIO_DE_FOTOGRAMA_A_CERO:

        ld     a,4

.CAMBIO_DE_FOTOGRAMA:

        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a

.SEGUIMOS_CON_EL_FOTOGRAMA:

        ld      e,a
        ld      d,0
        push    de
        pop     hl
        or      a
[5]     adc     hl,de
        ex      de,hl
        ld      ix,.DATA_SECUENCIA_2_ROCKAGER
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        inc     a
        cp      216
        jp      nz,.SALVAMOS_FOTOGRAMA_2
        ld      a,4

.SALVAMOS_FOTOGRAMA_2:

        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        
        jp      .PINTAMOS_FOTOGRAMA

.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER:

        add     ix,de
        ld      a,(ix)
        ld      (iy),a
        ld      a,(ix+1)
        ld      (iy+2),a
        ld      a,(ix+2)
        ld      (iy+4),a
        ld      a,(ix+3)
        ld      (iy+6),a
        ld      a,(ix+4)
        ld      (iy+8),a
        ld      a,(ix+5)
        ld      (iy+10),a

        ret
.PAUSA_DE_ANIMACION_2:

        ld      a,(PAUSA_EN_ANIMACION_ROCKAGER)
        inc     a
        and     00000111b
        ld      (PAUSA_EN_ANIMACION_ROCKAGER),a
        or      a
        jp      nz,.PINTAMOS_FOTOGRAMA
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        inc     a
        jp      .SALVAMOS_FOTOGRAMA_2

.PINTAMOS_FOTOGRAMA:

 	ld	hl,DATAS_COPY_RECUP_SCROLL
	call	DOCOPY
        ret

.RECARGAMOS_GRAFICOS_STAGE_2:

        pop     ix

        ld      a,12
        call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
        ld	hl,#8000												; Carga gráficos fase
        ld	de,#8000
        ld	bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,17
        call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
        ld	hl,#8000												; Carga gráficos fase
        ld	de,#C000
        ld	bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,10
        call	CHANGE_BANK_2

.BORRAMOS_PIEDRAS_EXPLOSIONES_Y_MAREOS

	ld	de,#4A00+16*4
        ld	hl,.VACIO
        ld	bc,24
        call	PON_COLOR_2.sin_bc_impuesta

.CARGAMOS_SPRITES_PERDIDOS:

	ld	hl,SPRITES_ALPHONSERRYX
	ld	de,#4000+54*8*4
        ld      bc,4*8*4
        call    PINTADO_DE_VRAM

	ld	hl,SPRITES_COVID
	ld	de,#4000+62*8*4
	ld	bc,2*8*4
        call    PINTADO_DE_VRAM

.RECUPERAMOS_SECCION_DE_PANTALLA_DEL_STATUS:

        ld      hl,.COPIA_PARTE_PAGE_0_DE_STATUS
	call	DOCOPY 

.BORRAMOS_ESA_PARTE_DE_PAGE_0:

        ld      hl,.BORRA_PARTE_DE_STATUS_PAGE_0
	call	DOCOPY 

.REGRESAMOS:

        ld      hl,0
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE
	call	PINTAMOS_LOS_PUNTOS_DE_MAGIA
        call    PINTA_CORAZONES

        pop     de
        pop     bc
        pop     iy
        pop     ix
        jp      VOLVEMOS_TRAS_ROCKAGER

.TEMBLEQUE:

        ex      af,af'

        ld      a,(PRIMERA_APERTURA_SUELO)
        cp      3
        jp      z,.SALIMOS_TEMBLEQUE_SIN_TEMBLEQUE
        inc     a
        ld      (PRIMERA_APERTURA_SUELO),a

        ld      a,25
        ld      c,0
        call    TIRA_FX

        ld      a,80
        ld      (TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

.SALIMOS_TEMBLEQUE_SIN_TEMBLEQUE:

        ex      af,af'
        ret

.VACIO:

        db      0,0,0,0,0,0,0,0
        db      0,0,0,0,0,0,0,0
        db      0,0,0,0,0,0,0,0

.COPIA_PARTE_PAGE_0_DE_STATUS:

        dw      #0000,#00B4,#0000,#0200,256,20
       	db      #00,#00,10010000b

.BORRA_PARTE_DE_STATUS_PAGE_0

        dw      #0000,#0000,#0000,#00B4,255,76
	db	#00,#00,10000000b	
               
.DATA_BARRAS: 

        db      211-32,225,62*4,0,211-16,225,63*4,0
        db      211-32,235,62*4,0,211-16,235,63*4,0

.DATA_SECUENCIA_1_ROCKAGER:

                db  144,208,39,107,48,16
                db  144,192,39,107,48,16
                db  96,208,39,107,48,16
                db  96,192,39,107,48,16
                db  192,192,39,107,48,16
                db  192,96,39,75,48,48
                db  144,96,39,75,48,48
                db  96,96,39,75,48,48
                db  48,96,39,75,48,48
                db  0,96,39,75,48,48
                db  192,48,39,75,48,48
                db  144,48,39,75,48,48
                db  96,48,39,75,48,48
                db  48,48,39,75,48,48
                db  0,144,39,75,48,48
                db  48,144,39,75,48,48
                db  96,144,39,75,48,48
                db  144,144,39,75,48,48
                db  192,144,39,75,48,48
                db  0,192,39,75,48,48
                db  192,144,39,75,48,48
                db  144,144,39,75,48,48
                db  96,144,39,75,48,48
                db  48,144,39,75,48,48
                db  0,144,39,75,48,48
                db  48,48,39,75,48,48
                db  96,48,39,75,48,48
                db  144,48,39,75,48,48
                db  192,48,39,75,48,48
                db  0,96,39,75,48,48
                db  48,96,39,75,48,48
                db  96,96,39,75,48,48
                db  144,96,39,75,48,48
                db  192,96,39,75,48,48
                db  192,192,39,107,48,16
                db  96,192,39,107,48,16
                
                db  144,208,23,155,48,16
                db  144,192,23,155,48,16
                db  96,208,23,155,48,16
                db  96,192,23,155,48,16
                db  192,192,23,155,48,16
                db  192,96,23,123,48,48
                db  144,96,23,123,48,48
                db  96,96,23,123,48,48
                db  48,96,23,123,48,48
                db  0,96,23,123,48,48
                db  192,48,23,123,48,48
                db  144,48,23,123,48,48
                db  96,48,23,123,48,48
                db  48,48,23,123,48,48
                db  0,144,23,123,48,48
                db  48,144,23,123,48,48
                db  96,144,23,123,48,48
                db  144,144,23,123,48,48
                db  192,144,23,123,48,48
                db  0,192,23,123,48,48
                db  192,144,23,123,48,48
                db  144,144,23,123,48,48
                db  96,144,23,123,48,48
                db  48,144,23,123,48,48
                db  0,144,23,123,48,48
                db  48,48,23,123,48,48
                db  96,48,23,123,48,48
                db  144,48,23,123,48,48
                db  192,48,23,123,48,48
                db  0,96,23,123,48,48
                db  48,96,23,123,48,48
                db  96,96,23,123,48,48
                db  144,96,23,123,48,48
                db  192,96,23,123,48,48
                db  192,192,23,155,48,16
                db  96,192,23,155,48,16

                db  144,208,71,187,48,16
                db  144,192,71,187,48,16
                db  96,208,71,187,48,16
                db  96,192,71,187,48,16
                db  192,192,71,187,48,16
                db  192,96,71,155,48,48
                db  144,96,71,155,48,48
                db  96,96,71,155,48,48
                db  48,96,71,155,48,48
                db  0,96,71,155,48,48
                db  192,48,71,155,48,48
                db  144,48,71,155,48,48
                db  96,48,71,155,48,48
                db  48,48,71,155,48,48
                db  0,144,71,155,48,48
                db  48,144,71,155,48,48
                db  96,144,71,155,48,48
                db  144,144,71,155,48,48
                db  192,144,71,155,48,48
                db  0,192,71,155,48,48
                db  192,144,71,155,48,48
                db  144,144,71,155,48,48
                db  96,144,71,155,48,48
                db  48,144,71,155,48,48
                db  0,144,71,155,48,48
                db  48,48,71,155,48,48
                db  96,48,71,155,48,48
                db  144,48,71,155,48,48
                db  192,48,71,155,48,48
                db  0,96,71,155,48,48
                db  48,96,71,155,48,48
                db  96,96,71,155,48,48
                db  144,96,71,155,48,48
                db  192,96,71,155,48,48
                db  192,192,71,187,48,16
                db  96,192,71,187,48,16

.DATA_SECUENCIA_1_ROCKAGER_DOBLE:

                db  144,208,167,187,48,16
                db  144,192,167,187,48,16
                db  96,208,167,187,48,16
                db  96,192,167,187,48,16
                db  192,192,167,187,48,16
                db  192,96,167,155,48,48
                db  144,96,167,155,48,48
                db  96,96,167,155,48,48
                db  48,96,167,155,48,48
                db  0,96,167,155,48,48
                db  192,48,167,155,48,48
                db  144,48,167,155,48,48
                db  96,48,167,155,48,48
                db  48,48,167,155,48,48
                db  0,144,167,155,48,48
                db  48,144,167,155,48,48
                db  96,144,167,155,48,48
                db  144,144,167,155,48,48
                db  192,144,167,155,48,48
                db  48,192,167,155,48,48
                db  192,144,167,155,48,48
                db  144,144,167,155,48,48
                db  96,144,167,155,48,48
                db  48,144,167,155,48,48
                db  0,144,167,155,48,48
                db  48,48,167,155,48,48
                db  96,48,167,155,48,48
                db  144,48,167,155,48,48
                db  192,48,167,155,48,48
                db  0,96,167,155,48,48
                db  48,96,167,155,48,48
                db  96,96,167,155,48,48
                db  144,96,167,155,48,48
                db  192,96,167,155,48,48
                db  192,192,167,187,48,16
                db  96,192,167,187,48,16

                db  144,208,215,155,48,16
                db  144,192,215,155,48,16
                db  96,208,215,155,48,16
                db  96,192,215,155,48,16
                db  192,192,215,155,48,16
                db  192,96,215,123,48,48
                db  144,96,215,123,48,48
                db  96,96,215,123,48,48
                db  48,96,215,123,48,48
                db  0,96,215,123,48,48
                db  192,48,215,123,48,48
                db  144,48,215,123,48,48
                db  96,48,215,123,48,48
                db  48,48,215,123,48,48
                db  0,144,215,123,48,48
                db  48,144,215,123,48,48
                db  96,144,215,123,48,48
                db  144,144,215,123,48,48
                db  192,144,215,123,48,48
                db  48,192,215,123,48,48
                db  192,144,215,123,48,48
                db  144,144,215,123,48,48
                db  96,144,215,123,48,48
                db  48,144,215,123,48,48
                db  0,144,215,123,48,48
                db  48,48,215,123,48,48
                db  96,48,215,123,48,48
                db  144,48,215,123,48,48
                db  192,48,215,123,48,48
                db  0,96,215,123,48,48
                db  48,96,215,123,48,48
                db  96,96,215,123,48,48
                db  144,96,215,123,48,48
                db  192,96,215,123,48,48
                db  192,192,215,155,48,16
                db  96,192,215,155,48,16

                db  144,208,167,107,48,16
                db  144,192,167,107,48,16
                db  96,208,167,107,48,16
                db  96,192,167,107,48,16
                db  192,192,167,107,48,16
                db  192,96,167,75,48,48
                db  144,96,167,75,48,48
                db  96,96,167,75,48,48
                db  48,96,167,75,48,48
                db  0,96,167,75,48,48
                db  192,48,167,75,48,48
                db  144,48,167,75,48,48
                db  96,48,167,75,48,48
                db  48,48,167,75,48,48
                db  0,144,167,75,48,48
                db  48,144,167,75,48,48
                db  96,144,167,75,48,48
                db  144,144,167,75,48,48
                db  192,144,167,75,48,48
                db  48,192,167,75,48,48
                db  192,144,167,75,48,48
                db  144,144,167,75,48,48
                db  96,144,167,75,48,48
                db  48,144,167,75,48,48
                db  0,144,167,75,48,48
                db  48,48,167,75,48,48
                db  96,48,167,75,48,48
                db  144,48,167,75,48,48
                db  192,48,167,75,48,48
                db  0,96,167,75,48,48
                db  48,96,167,75,48,48
                db  96,96,167,75,48,48
                db  144,96,167,75,48,48
                db  192,96,167,75,48,48
                db  192,192,167,107,48,16
                db  96,192,167,107,48,16

.DATA_SECUENCIA_2_ROCKAGER:

                db  144,208,39,107,48,16
                db  144,192,39,107,48,16
                db  96,208,39,107,48,16
                db  96,192,39,107,48,16
                db  192,192,39,107,48,16
                db  192,96,39,75,48,48
                db  144,96,39,75,48,48
                db  96,96,39,75,48,48
                db  48,96,39,75,48,48
                db  0,96,39,75,48,48
                db  192,48,39,75,48,48
                db  144,48,39,75,48,48
                db  96,48,39,75,48,48
                db  48,48,39,75,48,48
                db  0,144,39,75,48,48
                db  48,144,39,75,48,48
                db  96,144,39,75,48,48
                db  144,144,39,75,48,48
                db  192,144,39,75,48,48
                db  0,192,39,75,48,48
                db  192,144,39,75,48,48
                db  144,144,39,75,48,48
                db  96,144,39,75,48,48
                db  48,144,39,75,48,48
                db  0,144,39,75,48,48
                db  48,48,39,75,48,48
                db  96,48,39,75,48,48
                db  144,48,39,75,48,48
                db  192,48,39,75,48,48
                db  0,96,39,75,48,48
                db  48,96,39,75,48,48
                db  96,96,39,75,48,48
                db  144,96,39,75,48,48
                db  192,96,39,75,48,48
                db  192,192,39,107,48,16
                db  96,192,39,107,48,16

                db  144,208,167,187,48,16
                db  144,192,167,187,48,16
                db  96,208,167,187,48,16
                db  96,192,167,187,48,16
                db  192,192,167,187,48,16
                db  192,96,167,155,48,48
                db  144,96,167,155,48,48
                db  96,96,167,155,48,48
                db  48,96,167,155,48,48
                db  0,96,167,155,48,48
                db  192,48,167,155,48,48
                db  144,48,167,155,48,48
                db  96,48,167,155,48,48
                db  48,48,167,155,48,48
                db  0,144,167,155,48,48
                db  48,144,167,155,48,48
                db  96,144,167,155,48,48
                db  144,144,167,155,48,48
                db  192,144,167,155,48,48
                db  48,192,167,155,48,48
                db  192,144,167,155,48,48
                db  144,144,167,155,48,48
                db  96,144,167,155,48,48
                db  48,144,167,155,48,48
                db  0,144,167,155,48,48
                db  48,48,167,155,48,48
                db  96,48,167,155,48,48
                db  144,48,167,155,48,48
                db  192,48,167,155,48,48
                db  0,96,167,155,48,48
                db  48,96,167,155,48,48
                db  96,96,167,155,48,48
                db  144,96,167,155,48,48
                db  192,96,167,155,48,48
                db  192,192,167,187,48,16
                db  96,192,167,187,48,16


                db  144,208,23,155,48,16
                db  144,192,23,155,48,16
                db  96,208,23,155,48,16
                db  96,192,23,155,48,16
                db  192,192,23,155,48,16
                db  192,96,23,123,48,48
                db  144,96,23,123,48,48
                db  96,96,23,123,48,48
                db  48,96,23,123,48,48
                db  0,96,23,123,48,48
                db  192,48,23,123,48,48
                db  144,48,23,123,48,48
                db  96,48,23,123,48,48
                db  48,48,23,123,48,48
                db  0,144,23,123,48,48
                db  48,144,23,123,48,48
                db  96,144,23,123,48,48
                db  144,144,23,123,48,48
                db  192,144,23,123,48,48
                db  0,192,23,123,48,48
                db  192,144,23,123,48,48
                db  144,144,23,123,48,48
                db  96,144,23,123,48,48
                db  48,144,23,123,48,48
                db  0,144,23,123,48,48
                db  48,48,23,123,48,48
                db  96,48,23,123,48,48
                db  144,48,23,123,48,48
                db  192,48,23,123,48,48
                db  0,96,23,123,48,48
                db  48,96,23,123,48,48
                db  96,96,23,123,48,48
                db  144,96,23,123,48,48
                db  192,96,23,123,48,48
                db  192,192,23,155,48,16
                db  96,192,23,155,48,16

                db  144,208,215,155,48,16
                db  144,192,215,155,48,16
                db  96,208,215,155,48,16
                db  96,192,215,155,48,16
                db  192,192,215,155,48,16
                db  192,96,215,123,48,48
                db  144,96,215,123,48,48
                db  96,96,215,123,48,48
                db  48,96,215,123,48,48
                db  0,96,215,123,48,48
                db  192,48,215,123,48,48
                db  144,48,215,123,48,48
                db  96,48,215,123,48,48
                db  48,48,215,123,48,48
                db  0,144,215,123,48,48
                db  48,144,215,123,48,48
                db  96,144,215,123,48,48
                db  144,144,215,123,48,48
                db  192,144,215,123,48,48
                db  48,192,215,123,48,48
                db  192,144,215,123,48,48
                db  144,144,215,123,48,48
                db  96,144,215,123,48,48
                db  48,144,215,123,48,48
                db  0,144,215,123,48,48
                db  48,48,215,123,48,48
                db  96,48,215,123,48,48
                db  144,48,215,123,48,48
                db  192,48,215,123,48,48
                db  0,96,215,123,48,48
                db  48,96,215,123,48,48
                db  96,96,215,123,48,48
                db  144,96,215,123,48,48
                db  192,96,215,123,48,48
                db  192,192,215,155,48,16
                db  96,192,215,155,48,16

                db  144,208,71,187,48,16
                db  144,192,71,187,48,16
                db  96,208,71,187,48,16
                db  96,192,71,187,48,16
                db  192,192,71,187,48,16
                db  192,96,71,155,48,48
                db  144,96,71,155,48,48
                db  96,96,71,155,48,48
                db  48,96,71,155,48,48
                db  0,96,71,155,48,48
                db  192,48,71,155,48,48
                db  144,48,71,155,48,48
                db  96,48,71,155,48,48
                db  48,48,71,155,48,48
                db  0,144,71,155,48,48
                db  48,144,71,155,48,48
                db  96,144,71,155,48,48
                db  144,144,71,155,48,48
                db  192,144,71,155,48,48
                db  0,192,71,155,48,48
                db  192,144,71,155,48,48
                db  144,144,71,155,48,48
                db  96,144,71,155,48,48
                db  48,144,71,155,48,48
                db  0,144,71,155,48,48
                db  48,48,71,155,48,48
                db  96,48,71,155,48,48
                db  144,48,71,155,48,48
                db  192,48,71,155,48,48
                db  0,96,71,155,48,48
                db  48,96,71,155,48,48
                db  96,96,71,155,48,48
                db  144,96,71,155,48,48
                db  192,96,71,155,48,48
                db  192,192,71,187,48,16
                db  96,192,71,187,48,16

                db  144,208,167,107,48,16
                db  144,192,167,107,48,16
                db  96,208,167,107,48,16
                db  96,192,167,107,48,16
                db  192,192,167,107,48,16
                db  192,96,167,75,48,48
                db  144,96,167,75,48,48
                db  96,96,167,75,48,48
                db  48,96,167,75,48,48
                db  0,96,167,75,48,48
                db  192,48,167,75,48,48
                db  144,48,167,75,48,48
                db  96,48,167,75,48,48
                db  48,48,167,75,48,48
                db  0,144,167,75,48,48
                db  48,144,167,75,48,48
                db  96,144,167,75,48,48
                db  144,144,167,75,48,48
                db  192,144,167,75,48,48
                db  48,192,167,75,48,48
                db  192,144,167,75,48,48
                db  144,144,167,75,48,48
                db  96,144,167,75,48,48
                db  48,144,167,75,48,48
                db  0,144,167,75,48,48
                db  48,48,167,75,48,48
                db  96,48,167,75,48,48
                db  144,48,167,75,48,48
                db  192,48,167,75,48,48
                db  0,96,167,75,48,48
                db  48,96,167,75,48,48
                db  96,96,167,75,48,48
                db  144,96,167,75,48,48
                db  192,96,167,75,48,48
                db  192,192,167,107,48,16
                db  96,192,167,107,48,16

.DATA_MUERE_ROCKAGER:

                db  0,0,39,75,48,48             ; ARRIBA IZQUIERDA
                db  48,0,39,75,48,48
                db  96,0,39,75,48,48
                db  144,0,39,75,48,48
                db  192,0,39,75,48,48
                db  0,48,39,75,48,48

                db  0,0,23,123,48,48            ; CENTRO IZQUIERDA
                db  48,0,23,123,48,48
                db  96,0,23,123,48,48
                db  144,0,23,123,48,48
                db  192,0,23,123,48,48
                db  0,48,23,123,48,48

                db  0,0,71,155,48,48            ; ABAJO IZQUIERDA
                db  48,0,71,155,48,48
                db  96,0,71,155,48,48
                db  144,0,71,155,48,48
                db  192,0,71,155,48,48
                db  0,48,71,155,48,48

               db  0,0,167,155,48,48            ; ABAJO DERECHA
                db  48,0,167,155,48,48
                db  96,0,167,155,48,48
                db  144,0,167,155,48,48
                db  192,0,167,155,48,48
                db  0,48,167,155,48,48

                db  0,0,215,123,48,48           ; CENTRO DERECHA
                db  48,0,215,123,48,48
                db  96,0,215,123,48,48
                db  144,0,215,123,48,48
                db  192,0,215,123,48,48
                db  0,48,215,123,48,48
                
                db  0,0,167,75,48,48           ; ARRIBA DERECHA
                db  48,0,167,75,48,48
                db  96,0,167,75,48,48
                db  144,0,167,75,48,48
                db  192,0,167,75,48,48
                db  0,48,167,75,48,48

.VALORES_DE_PAUSA:
                
                db      13,18,19,49,54,55,85,90,91