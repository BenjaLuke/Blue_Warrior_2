RUTINA_BOSS_2:

		call	stpmus

.VARIABLES:

		ld		a,27
		ld		(PAGINA_DE_REGRESO),a

        ; Variables a reiniciar


        push    ix
        push    iy
        push    bc
        push    de

.COPIA_A_1_PARTE_ALTA:

        ld      ix,.PAGE_2_A_PAGE_1_COMPLETA
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .BUCLE_PINTA_DATAS

        ld      iy,DATAS_COPY_RECUP_SCROLL
        ld      a,(PUNTO_DEL_SCROLL)

        ld      (iy+2),a
        ld      b,a
        ld      a,0
        sub     b
        ld      (iy+10),a
        push    af
        xor     a
        ld      (iy+11),a
        ld      hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		call	VDPREADY

.COPIA_A_1_PARTE_BAJA:
        
        ld      ix,.PAGE_2_A_PAGE_1_COMPLETA
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .BUCLE_PINTA_DATAS

        ld      iy,DATAS_COPY_RECUP_SCROLL
        ld      a,(PUNTO_DEL_SCROLL)
        ld      b,a
        ld      a,0
        sub     b
        ld      (iy+6),a
        pop     af
        dec     a
        ld      b,a
        ld      a,#FF
        sub     b
        ld      (iy+10),a
        xor     a
        ld      (iy+11),a
        ld      hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY 
        call    VDPREADY

.GUARDA_DATOS_VIDAS_ROCKAGER:

        ld      ix,.COPI_MARCADOR_BOSSES_CORAZONES_VACIOS
        ld      iy,DATAS_COR_EMPT_MALO
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_CORAZONES_EMPTY_DEPH:

        ld      ix,.COPY_CORAZONES_EMPTY_DEPH
        ld      iy,CORAZONES_DEPH_EN_BOSSES
        call    .BUCLE_PINTA_DATAS

.GUARDA_DATOS_COPY_PUNTOS_MAGIA:

        ld      ix,.COPY_PUNTOS_MAGIA
        ld      iy,PUNTOS_MAGIA_EN_BOSSES
        call    .BUCLE_PINTA_DATAS

.VARIABLES_DE_DEPH_RETOCADAS:

        ld      a,(PUNTO_DEL_SCROLL)
        ld      b,a
        ld      a,(Y_DEPH)
        sub     b
        ld      (Y_DEPH),a
        sub     b
        add     32
        ld      (Y_FALSA_PARA_DEPH),a

.PUNTO_DE_SCROLL_RETOCADO:

        ld      a,0
        ld      (PUNTO_DEL_SCROLL),a

.COLOCA_SPRITES_DEPH_EN_SU_SITIO:
        
        call    PINTA_SPRITE_DEPH

.CAMBIA_PAGE_PARA_OCULTAR:

        ld      a,1
        ld      (SET_PAGE),a

.COPIA_ESCENARIO_RECOLOCADO_A_PAGE_2:

 		ld	hl,.PAGE_1_A_PAGE_2_COMPLETA
		call	DOCOPY
        call    VDPREADY

.DEVUELVE_LA_PAGE_2:

        ld      a,2
        ld      (SET_PAGE),a

.CAMBIAMOS_MAS_VARIABLES_PARA_EL_CAMBIO_DE_SCROLL:

		ld	a,202
		ld	(DONDE_VA_LA_INTERRUPCION_LINEAL),a 

		ld	a,240
		ld	(Y_PINTA_SCROLL),a

 		ld	a,159
		ld	(LIM_Y_INF),a	
			
		ld	a,190
		ld	(LIM_MUERTE),a

		ld	a,195
		ld	(Y_LINEA_INT),a

.CARGA_ROCAGER_1:

        ld      a,42
        ld		b,43
        call	.CARGA_PANTALLA_COMPLETA

.CARGA_STATUS_BOSS:

        ld      a,45
        call	CHANGE_BANK_2

        ld		hl,#8000												; Carga gráficos fase
        ld		de,#0000+(256*200)/2
        ld		bc,(256*54)/2
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,10
        call	CHANGE_BANK_2  

.PINTA_STATUS:

        ld      b,15
        ld      hl,.COPIA_PARTE_PAGE_2_DE_STATUS
		call	DOCOPY 

        ld      b,15
        ld      hl,.COPIA_STATUS_BOSS_A_PAGE_2
		call	DOCOPY 

.BORRA_CORAZONES_QUE_SOBRAN:

        ld      a,(CORAZONES)
        ld      b,4
        
.BUCLE_BORRA_CORAZONES_DE_MAS:

        ex      af,af'
        ld      a,b
        ld      (CORAZONES),a
        call    .PINTA_CORAZONES_VIDA_DEPH_ADECUADOS
        ex      af,af'
        cp      b
        jp      z,.FINAL_BUCLE_CORAZONES
        djnz    .BUCLE_BORRA_CORAZONES_DE_MAS

.FINAL_BUCLE_CORAZONES:

        ld      (CORAZONES),a

.PINTA_MAGIAS_REALES

	ld		ix,PUNTOS_MAGIA_EN_BOSSES
	ld		a,(MAGIAS)
[3]	add		a
	ld		c,25
	add		c
	ld		(ix),a
	ld		hl,PUNTOS_MAGIA_EN_BOSSES
	call	DOCOPY

; terremoto pequeño
.TERREMOTO_MINI:

		ld		a,10
		ld		(TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

		ld		a,25
		ld		c,0
        call    PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
        call   	PAGE_10_A_SEGMENT_2

; caen rocas
		ld		a,100
		call	BUCLE_PINTA_TILES.rutina_de_pausa

; Pintamos los sprites adecuados para este enemigo

.PIEDRAS_A_INICIO:

    ld		ix,VALORES_SPRITES_PIEDRAS
    ld      a,25
    ld      de,4        
    ld      b,6

.BUCLE_TRANQUILIZA_PIEDRAS:

    ld      (ix+3),a
    add     ix,de
    djnz    .BUCLE_TRANQUILIZA_PIEDRAS

.VOLCAMOS_LOS_NUEVOS_SPRITES_DE_PIEDRA:

	ld		hl,SPRITE_OJOS_ROCKAGER
	ld		de,#4000+56*8*4
	ld		bc,8*8*4
    call    PAGE_32_A_SEGMENT_2
	call	PON_COLOR_2.sin_bc_impuesta
    call    PAGE_10_A_SEGMENT_2

.COLOR_PIEDRAS:

	ld		de,#4800+16*14
	ld  	b,6

.BUCLE_PINTA_PIEDRAS:

	push    bc
	ld      hl,.COLOR_PIEDRA_1
	ld		bc,16*2
	push    de
	call  	PON_COLOR_2.sin_bc_impuesta
	pop     hl
	ld      de,32
	or      a
	adc     hl,de
	ex		de,hl
	pop     bc
	djnz    .BUCLE_PINTA_PIEDRAS

; se abren los 4 agujeros del suelo para rockager
.ANIMACION_AGUJEROS_SUELO:

		call	.ANIMACION_COMUN_1
        ld      ix,.DATA_APARECEN_AGUJEROS
        ld      iy,DATAS_COPY_RECUP_SCROLL

		call	.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV

		call	.ANIMACION_COMUN_2
		cp		16
		ld		(FOTOGRAMA_SECUENCIA_DAV),a
		jp		nz,.ANIMACION_AGUJEROS_SUELO

.CARGA_DAV_1:

        ld      a,46
        ld		b,47
        call	.CARGA_PANTALLA_COMPLETA

		ld		a,9
		call	.CARGA_DAV_COMUN

.BUCLE_DAV_1:

		call	.ANIMACION_COMUN_1
        ld      ix,.DATAS_APARECE_DAVAENIX_1
        ld      iy,DATAS_COPY_RECUP_SCROLL

		call	.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV

		call	.ANIMACION_COMUN_2
		cp		9
		ld		(FOTOGRAMA_SECUENCIA_DAV),a
		jp		nz,.BUCLE_DAV_1

; Se abre pared y ... 
.CARGA_DAV_2:

        ld      a,48
        ld		b,49
        call	.CARGA_PANTALLA_COMPLETA

		ld		a,12
		call	.CARGA_DAV_COMUN

.BUCLE_DAV_2:

		call	.ANIMACION_COMUN_1
        ld      ix,.DATAS_APARECE_DAVAENIX_2
        ld      iy,DATAS_COPY_RECUP_SCROLL

		call	.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV

		call	.ANIMACION_COMUN_2
		cp		12
		ld		(FOTOGRAMA_SECUENCIA_DAV),a
		jp		nz,.BUCLE_DAV_2

; ...aparece Daveatnyx con gran terremoto
.EMPIEZA_LA_MUSICA:

		include	"AUDIOS/INICIA MUSICA_BOSS.asm"

.CARGA_ROCAGER_2:

		xor		a
		ld		(FOTOGRAMA_SECUENCIA_ROCKAGER_3),a

        ld      a,42
        ld		b,43
        call	.CARGA_PANTALLA_COMPLETA

; todo el codigo de enfrentamiento

		jp	BUCLE_PELEA_BOSS_2

.ANIMACION_COMUN_1:

		ld		a,(FOTOGRAMA_SECUENCIA_DAV)
        ld      e,a
        ld      d,0
        push    de
        pop     hl
        or      a
[5]     adc     hl,de
        ex      de,hl
		ret

.ANIMACION_COMUN_2:

		ld		a,(TIEMPO_DE_ADJUST)
		dec		a
		ld		(TIEMPO_DE_ADJUST),a

		ld		a,25
		ld		c,0
        call    PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
        call   	PAGE_10_A_SEGMENT_2

		push    de
        call    .PINTAMOS_FOTOGRAMA
        pop     de
        ld      a,(FOTOGRAMA_SECUENCIA_DAV)
		inc		a
		ret

.CARGA_DAV_COMUN:

		ld		(TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

		xor		a
		ld      (FOTOGRAMA_SECUENCIA_DAV),a
		ret

.PINTAMOS_FOTOGRAMA:

 		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
		jp		VDPREADY

.RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER_DAV:

		ld		a,8
		call	BUCLE_PINTA_TILES.rutina_de_pausa

        add     ix,de
        ld      a,(ix+1)
        ld      (iy),a
        ld      a,(ix)
        ld      (iy+2),a
		ld		a,1
		ld		(iy+3),a
        ld      a,(ix+3)
        ld      (iy+4),a
        ld      a,(ix+2)
        ld      (iy+6),a
		ld		a,2
		ld		(iy+7),a
        ld      a,(ix+5)
        ld      (iy+8),a
		xor		a
		ld		(iy+9),a
        ld      a,(ix+4)
        ld      (iy+10),a

        ret

.COLOR_PIEDRA_1:

	; attr 0
	DB 		$01,$02,$02,$02,$02,$02,$02,$02
	DB 		$02,$02,$02,$02,$02,$02,$02,$01
	; attr 1
	DB 		$00,$41,$41,$41,$41,$41,$41,$41
	DB 		$41,$41,$41,$41,$41,$41,$41,$00

.DATA_APARECEN_AGUJEROS:

		db	208,144,144,064,016,048 ; 1-1
		db	192,144,144,064,016,048 ; 1-2
		db	208,144,176,208,016,048 ; 2-1
		db	192,144,176,208,016,048 ; 2-2
		db 	208,144,144,144,016,048 ; 3-1
		db	192,144,144,144,016,048 ; 3-2
		db	208,096,176,208,016,048	; 2-3
		db	208,096,144,064,016,048	; 1-3
		db	192,096,176,208,016,048	; 2-4
		db 	208,144,176,000,016,048 ; 4-1
		db	192,144,176,000,016,048 ; 4-2
		db	208,096,144,144,016,048	; 3-3
		db	192,096,144,144,016,048	; 3-4
		db	208,096,176,000,016,048	; 4-3
		db	192,096,176,000,016,048	; 4-4
		db	192,096,144,064,016,048	; 1-4
		
.DATAS_APARECE_DAVAENIX_1:

		db	000,000,96-34,112,32,32
		db	032,000,96-34,112,32,32
		db	064,000,96-34,112,48,32
		db	112,000,96-34,112,48,32
		db	000,032,80-34,096,64,64
		db	064,032,80-34,096,64,64
		db	128,032,80-34,096,64,80
		db	000,112,64-34,080,80,96
		db	080,112,64-34,080,80,96

.DATAS_APARECE_DAVAENIX_2:

		db	000,000,96-18,096,32,64
		db	032,000,96-18,096,32,64
		db	064,000,80-18,096,48,64
		db	112,000,80-18,096,48,64
		db	000,064,80-18,096,48,64
		db	048,064,64-18,096,64,64
		db	112,064,64-18,096,64,64
		db	000,128,64-18,096,64,64
		db	064,128,64-18,096,64,64
		db	128,128,64-18,096,64,64
		db	000,192,64-18,096,64,64
		db	064,192,64-18,096,64,64

.CARGA_PANTALLA_COMPLETA:

		push	bc
        call	CHANGE_BANK_2
                                                                       
        ld		hl,#8000							; Posición de lectura			
        ld		de,#8000							; Posición de escritura
        ld		bc,16384							; Bits a leer
        call	PON_COLOR_2.sin_bc_impuesta

		pop		af
        call	CHANGE_BANK_2
                                                                        
        ld		hl,#8000									
        ld		de,#C000
        ld		bc,16384
        call	PON_COLOR_2.sin_bc_impuesta
		call	VDPREADY

		ld		a,10
        jp		CHANGE_BANK_2

.PINTA_CORAZONES_VIDA_DEPH_ADECUADOS:

	ld		ix,CORAZONES_DEPH_EN_BOSSES
	ld		a,(CORAZONES)
	ld		c,a
[9]	add		c
	ld		c,43
	add		c
	ld		(ix),a
	ld		(ix+4),a
    ld      hl,CORAZONES_DEPH_EN_BOSSES
	push	bc
	call   	DOCOPY
	pop		bc
	ret

.BUCLE_PINTA_DATAS:

        ld      b,15

.BUCLE_PINTA_DATAS_1:

        ld      a,(ix)
        ld      (iy),a
        ld      de,1
        add     ix,de
        add     iy,de
        djnz    .BUCLE_PINTA_DATAS_1
        ret

.PAGE_2_A_PAGE_1_COMPLETA:

		dw      #0000,#0200,#0000,#0100,#0100,#0100
		db      #00,#00,10010000b

.COPY_CORAZONES_EMPTY_DEPH:

        dw      #0000,#0000+29+200,#0000,#0200+6,#0000+10,#0000+8
       	db      #00,#00,10010000b

.COPI_MARCADOR_BOSSES_CORAZONES_VACIOS:

		dw	#0000+151,#0000+220,#0000+151,#0201,#0000+19,#0000+16
		db      #00,#00,10010000b

.COPY_PUNTOS_MAGIA:

        dw      #0000+25,#0000+45+200,#0000+123,#0200+6,#0000+8,#0000+8
       	db      #00,#00,10010000b

.PAGE_1_A_PAGE_2_COMPLETA:

		dw	#0000,#0100,#0000,#0200,#0100,#0100
		db      #00,#00,10010000b

.COPIA_PARTE_PAGE_2_DE_STATUS:

        dw      #0000,#0200,#0000,#00B4,256,20
       	db      #00,#00,10010000b

.COPIA_STATUS_BOSS_A_PAGE_2:

        dw      #0000,#00C8,#0000,#0200,256,20
       	db      #00,#00,10010000b

.DATAS_ROCKAGER:

        dw		#0090,#01D0,#0000,#0200,#0041,#0010
		db		#00,#00,10010000b

BUCLE_PELEA_BOSS_2:

		HALT
		
		call	MOVIMIENTO_DEPH_EN_BOSS_2
		call	SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_2
		call	PINTA_PROYECTILES_DE_DEPH_EN_BOSS_2
        call    REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH_ROCK_BOSS_2
		call	ON_SPRITE_CON_ROCAS_EN_BOSS_2

        ld      a,(VELOCIDAD_ROCKAGER)                  ;  [ Esta secuencia pone una pausa a la velocidad de los rockagers
        inc     a                                       ;  [
        and     00000011B                               ;  [
        ld      (VELOCIDAD_ROCKAGER),a                  ;  [
        or      a                                       ;  [
        jp      nz,.CONTROL_POST_BUCLE_1                ;  [

		call	ANIMA_ROCKAGERS_EN_BOSS_2
		call	RUTINA_ROCAS_EN_BOSS_2

.CONTROL_POST_BUCLE_1:

        ld      a,(TIEMPO_DE_ADJUST)
        or      a
        jp      z,.CONTROL_POST_BUCLE_2
        dec     a
        ld      (TIEMPO_DE_ADJUST),a        

.CONTROL_POST_BUCLE_2:

		jp	BUCLE_PELEA_BOSS_2

MOVIMIENTO_DEPH_EN_BOSS_2:

		include	"BASICOS/MOVIMIENTO EN BOSSES.asm"

SECUENCIA_PROYECTILES_PROPIOS_EN_BOSS_2:

		include	"BASICOS/SECUENCIA PROYECTILES PROPIOS EN BOSSES.asm"

PINTA_PROYECTILES_DE_DEPH_EN_BOSS_2:

		include	"BASICOS/PINTADO PROYECTILES PROPIOS EN BOSSES.asm"

ON_SPRITE_CON_ROCAS_EN_BOSS_2:

	ld	b,4
	xor	a
	ld	(VARIABLE_UN_USO3),a

.BUCLE_REVISION_4_PIEDRAS:

	push bc
	ld	ix,VALORES_SPRITES_PIEDRAS
[2]	add	a
	ld	e,a
	ld	d,0
	add	ix,de
	
	ld	a,(ix)
	sub	8
	ld	c,a
	ld	a,(X_DEPH)
	add	20
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix)
	add	8
	ld	c,a
	ld	a,(X_DEPH)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	sub	8
	ld	c,a
	ld	a,(Y_DEPH)
	add	20
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	add	8
	ld	c,a
	ld	a,(Y_DEPH)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE
	
	call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH.DANO_DE_PUPA

	call	PINTA_CORAZONES_VIDA_DEPH_ADECUADOS

	call    PAGE_31_A_SEGMENT_2
	ld		a,3
	ld		c,0
	call	ayFX_INIT
    call    PAGE_10_A_SEGMENT_2
	pop		bc
	ret

.SIGUIENTE_EN_EL_BUCLE:

	pop 	bc
	ld		a,(VARIABLE_UN_USO3)
	inc		a
	ld		(VARIABLE_UN_USO3),a
	djnz 	.BUCLE_REVISION_4_PIEDRAS

.FIN_DE_ON_SPRITE_CON_ROCAS:

	ret

REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH_ROCK_BOSS_2:

		ld	a,(INMUNE)
		or	a
		jp	z,.adelante
		dec	a
		ld	(INMUNE),a

.adelante:

		ld	ix,.LIMITES_ROCKAGERS
		ld	iy,.LIMITE_VARIABLE_Y_SUPERIOR
		ld	b,4

.control_x:

		ld	a,(ix)					; 19
		ld	de,(X_DEPH)				; 20
		cp	e					; 4
		jp	nc,.fin_bucle				; 10
		add	a,37					; 7
		cp	e					; 4
		jp	c,.fin_bucle				; 10
								; Total 74 20,43% + rápido
		jp	.control_y_2

.fin_bucle:

		ld	de,5
		add	ix,de
		djnz	.control_x

		ret

.control_y_2:

		ld	c,(ix+3)        ; 0 - X INFERIOR
                                        ; 1 - Y SUPERIOR
                                        ; 2 - FOTOGRAMA INFERIOR
                                        ; 3 - FOTOGRAMA SUPERIOR
                                        ; 4 - Y INFERIOR
		ld	a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
		cp	c
		jp	nc,.fin_bucle
		ld	c,(ix+2)

.control_y_1_2:

		cp	c
		jp	c,.fin_bucle
		sub	c
		ld	e,a
		ld	d,0
		add	iy,de
		ld	c,(iy)
		ld	a,(ix+4)
		add	c
		push	af
		pop	de
		ld	a,(Y_DEPH)
		cp	d
		ld	iy,.LIMITE_VARIABLE_Y_SUPERIOR
		jp	c,.fin_bucle

		ld	c,(ix+1)
		cp	c
		jp	nc,.fin_bucle

		jp	.recibe_un_toque

.LIMITES_ROCKAGERS:

		db	58,129,00,30
		db	81

		db	201,162,32,62
		db	113

		db	138,129,96,126
		db	81

		db	0,162,64,94
		db	113

.LIMITE_VARIABLE_Y_SUPERIOR:

		db	43
		db	39,34,30,27,23
		db	19,15,12,08
		db	05,06,05,02,01
		db	06
		db	01,02,05,06,05
		db	08,12,15,19
		db	23,27,30,34,39
		db	43

.recibe_un_toque:

	call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH.DANO_DE_PUPA

	call	PINTA_CORAZONES_VIDA_DEPH_ADECUADOS

	call    PAGE_31_A_SEGMENT_2
	ld	a,3
	ld	c,0
	call	ayFX_INIT
        call    PAGE_10_A_SEGMENT_2

	ld	a,(X_DEPH)
	cp	128
	jp	nc,.RETROCEDE

.ADELANTA:

	add	10
	ld	(X_DEPH),a
	ret

.RETROCEDE:

	sub	10
	ld	(X_DEPH),a
	ret

ANIMA_ROCKAGERS_EN_BOSS_2:

.ACTIVA_ROCAS_FASE_2:

        ld      ix,VALORES_SPRITES_PIEDRAS
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        cp      6
        jp      z,.ACTIVANDO_COMUN_2
        cp      6+32
        jp      z,.ACTIVANDO_2_2
        cp      6+32+32
        jp      z,.ACTIVANDO_3_2
        cp      6+32+32+32
        jp      z,.ACTIVANDO_4_2
     
        jp      .SECUENCIA_2_CONT_2

.ACTIVANDO_2_2:

        ld      de,4
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_3_2:

        ld      de,8
        jp      .ACTIVANDO_COMUN_PRE_2

.ACTIVANDO_4_2:

        ld      de,12

.ACTIVANDO_COMUN_PRE_2:

        add     ix,de

.ACTIVANDO_COMUN_2:

        xor     a
        ld      (ix+3),a

		srl		a
		ld		a,r
		and		00000011B
		ld		(RECORRIDO_ROCA),a

.SECUENCIA_2_CONT_2:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)

.MIRAMOS_SI_SALTA_AGUJERO:

        cp      32+32+32+32
        jp      z,.CAMBIO_DE_FOTOGRAMA_A_CERO
        jp      .CAMBIO_DE_FOTOGRAMA

.CAMBIO_DE_FOTOGRAMA_A_CERO:

        xor     a

.CAMBIO_DE_FOTOGRAMA:

        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a

.SEGUIMOS_CON_EL_FOTOGRAMA:

        ld      e,a
        ld      d,0
        push    de
        pop     hl
        or      a
 [5]    adc     hl,de
        ex      de,hl
        ld      ix,.DATA_SECUENCIA_2_ROCKAGER
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .RUTINA_STANDAR_PASA_DATOS_COPY_ROCKAGER

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        inc     a
        cp      128
        jp      c,.SALVAMOS_FOTOGRAMA_2
        xor     a

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

 		ld		hl,DATAS_COPY_RECUP_SCROLL
		call	DOCOPY
        ret
               
.DATA_SECUENCIA_2_ROCKAGER:


                db  192,192,64,144,48,16
                db  192,96,64,112,48,48
                db  144,96,64,112,48,48
                db  96,96,64,112,48,48
                db  48,96,64,112,48,48
                db  0,96,64,112,48,48
                db  192,48,64,112,48,48
                db  144,48,64,112,48,48
                db  96,48,64,112,48,48
                db  48,48,64,112,48,48
                db  0,144,64,112,48,48
                db  48,144,64,112,48,48
                db  96,144,64,112,48,48
                db  144,144,64,112,48,48
                db  192,144,64,112,48,48
                db  0,192,64,112,48,48
                db  192,144,64,112,48,48
                db  144,144,64,112,48,48
                db  96,144,64,112,48,48
                db  48,144,64,112,48,48
                db  0,144,64,112,48,48
                db  48,48,64,112,48,48
                db  96,48,64,112,48,48
                db  144,48,64,112,48,48
                db  192,48,64,112,48,48
                db  0,96,64,112,48,48
                db  48,96,64,112,48,48
                db  96,96,64,112,48,48
                db  144,96,64,112,48,48
                db  192,96,64,112,48,48
                db  192,192,64,144,48,16
                db  96,192,64,144,48,16

                db  192,192,208,176,48,16
                db  192,96,208,144,48,48
                db  144,96,208,144,48,48
                db  96,96,208,144,48,48
                db  48,96,208,144,48,48
                db  0,96,208,144,48,48
                db  192,48,208,144,48,48
                db  144,48,208,144,48,48
                db  96,48,208,144,48,48
                db  48,48,208,144,48,48
                db  0,144,208,144,48,48
                db  48,144,208,144,48,48
                db  96,144,208,144,48,48
                db  144,144,208,144,48,48
                db  192,144,208,144,48,48
                db  48,192,208,144,48,48
                db  192,144,208,144,48,48
                db  144,144,208,144,48,48
                db  96,144,208,144,48,48
                db  48,144,208,144,48,48
                db  0,144,208,144,48,48
                db  48,48,208,144,48,48
                db  96,48,208,144,48,48
                db  144,48,208,144,48,48
                db  192,48,208,144,48,48
                db  0,96,208,144,48,48
                db  48,96,208,144,48,48
                db  96,96,208,144,48,48
                db  144,96,208,144,48,48
                db  192,96,208,144,48,48
                db  192,192,208,176,48,16
                db  96,192,208,176,48,16

                db  192,192,0,176,48,16
                db  192,96,0,144,48,48
                db  144,96,0,144,48,48
                db  96,96,0,144,48,48
                db  48,96,0,144,48,48
                db  0,96,0,144,48,48
                db  192,48,0,144,48,48
                db  144,48,0,144,48,48
                db  96,48,0,144,48,48
                db  48,48,0,144,48,48
                db  0,144,0,144,48,48
                db  48,144,0,144,48,48
                db  96,144,0,144,48,48
                db  144,144,0,144,48,48
                db  192,144,0,144,48,48
                db  0,192,0,144,48,48
                db  192,144,0,144,48,48
                db  144,144,0,144,48,48
                db  96,144,0,144,48,48
                db  48,144,0,144,48,48
                db  0,144,0,144,48,48
                db  48,48,0,144,48,48
                db  96,48,0,144,48,48
                db  144,48,0,144,48,48
                db  192,48,0,144,48,48
                db  0,96,0,144,48,48
                db  48,96,0,144,48,48
                db  96,96,0,144,48,48
                db  144,96,0,144,48,48
                db  192,96,0,144,48,48
                db  192,192,0,176,48,16
                db  96,192,0,176,48,16

                db  192,192,144,144,48,16
                db  192,96,144,112,48,48
                db  144,96,144,112,48,48
                db  96,96,144,112,48,48
                db  48,96,144,112,48,48
                db  0,96,144,112,48,48
                db  192,48,144,112,48,48
                db  144,48,144,112,48,48
                db  96,48,144,112,48,48
                db  48,48,144,112,48,48
                db  0,144,144,112,48,48
                db  48,144,144,112,48,48
                db  96,144,144,112,48,48
                db  144,144,144,112,48,48
                db  192,144,144,112,48,48
                db  48,192,144,112,48,48
                db  192,144,144,112,48,48
                db  144,144,144,112,48,48
                db  96,144,144,112,48,48
                db  48,144,144,112,48,48
                db  0,144,144,112,48,48
                db  48,48,144,112,48,48
                db  96,48,144,112,48,48
                db  144,48,144,112,48,48
                db  192,48,144,112,48,48
                db  0,96,144,112,48,48
                db  48,96,144,112,48,48
                db  96,96,144,112,48,48
                db  144,96,144,112,48,48
                db  192,96,144,112,48,48
                db  192,192,144,144,48,16
                db  96,192,144,144,48,16

.DATA_MUERE_ROCKAGER:

                db  0,0,39,75,48,48             ; ARRIBA IZQUIERDA
                db  48,0,39,75,48,48
                db  96,0,39,75,48,48
                db  144,0,39,75,48,48
                db  192,0,39,75,48,48
                db  0,48,39,75,48,48

                db  0,0,144,112,48,48            ; CENTRO IZQUIERDA
                db  48,0,144,112,48,48
                db  96,0,144,112,48,48
                db  144,0,144,112,48,48
                db  192,0,144,112,48,48
                db  0,48,144,112,48,48

                db  0,0,71,155,48,48            ; ABAJO IZQUIERDA
                db  48,0,71,155,48,48
                db  96,0,71,155,48,48
                db  144,0,71,155,48,48
                db  192,0,71,155,48,48
                db  0,48,71,155,48,48

               	db  0,0,208,144,48,48            ; ABAJO DERECHA
                db  48,0,208,144,48,48
                db  96,0,208,144,48,48
                db  144,0,208,144,48,48
                db  192,0,208,144,48,48
                db  0,48,208,144,48,48

                db  0,0,0,144,48,48           ; CENTRO DERECHA
                db  48,0,0,144,48,48
                db  96,0,0,144,48,48
                db  144,0,0,144,48,48
                db  192,0,0,144,48,48
                db  0,48,0,144,48,48
                
                db  0,0,167,75,48,48           ; ARRIBA DERECHA
                db  48,0,167,75,48,48
                db  96,0,167,75,48,48
                db  144,0,167,75,48,48
                db  192,0,167,75,48,48
                db  0,48,167,75,48,48

RUTINA_ROCAS_EN_BOSS_2:

.PREPARAMOS_ENTRADA:

	push	ix
	push	iy

	ld		b,4
	xor		a
	ld		(VARIABLE_UN_USO3),a

.BUCLE_4_PIEDRAS:

	jp		.BUCLE_4_PIEDRAS_EXT

.DESAPARECE:

	ld		iy,VARIABLE_UN_USO
	xor		a
	ld		(iy),a
	ld		(iy+1),a
	ld		(iy+2),a
	call	.MAS_DE_UN_USO_1	
	call	.MAS_DE_UN_USO_2
	jp		.COMUN_PINTA_Y_DESAPARECE

.FIN_DEL_BUCLE:

	ld		a,(VARIABLE_UN_USO3)
	inc		a
	ld		(VARIABLE_UN_USO3),a

	djnz	.BUCLE_4_PIEDRAS

.VOLVEMOS:

	pop		iy
	pop		ix
	ret

.SALE_DISPARADA:

	ld		a,26
	ld		(ix+3),a

	ld		iy,VARIABLE_UN_USO
	ld		a,(ix+2)
[2]	add		a
	add		60*4
	ld		(ix+2),a
	
	ld		a,(ix)
	sub		10
	ld		(ix),a
	cp		245
	jp		nc,.SALE_DISPARADA_1

	ld		a,(ix+1)
	sub		10
	ld		(ix+1),a
	cp		211
	jp		c,.SALTO_DESDE_REBOTA

.SALE_DISPARADA_1:

	ld		a,24
	ld		(ix+3),a
	JP		.SALTO_DESDE_REBOTA

.BUCLE_4_PIEDRAS_EXT:

.SEGUIMOS_SIN_PARON:

	ld		a,(VARIABLE_UN_USO3)
	ld		ix,VALORES_SPRITES_PIEDRAS
	ld		iy,.DATA_RECORRIDO_ROCA_1_1
[2]	add		a
	ld		d,0
	ld		e,a
	add		ix,de
	push	de
	pop		hl
	xor		a
[12]    adc	hl,de	
	push	hl
	pop		de
	add		iy,de

	ld		a,(RECORRIDO_ROCA)
	or		a
	jp		z,.SEGUIMOS_TRAS_AZAR
	cp		2
	jp		z,.SEGUNDA_OPCION

.TERCERA_OPCION:

	ld		de,26*4*2
	add		iy,de
	jp		.SEGUIMOS_TRAS_AZAR

.SEGUNDA_OPCION:

	ld		de,26*4*2*2
	add		iy,de	

.SEGUIMOS_TRAS_AZAR:

	ld		a,(ix+3)
	or		a
	call	z,.SALE
	cp		8
	call	Z,.COGE
	cp		16
	call	z,.TOCA_SUELO
	cp		25
	jp		z,.DESAPARECE
	cp		26
	jp		z,.FIN_DEL_BUCLE
	cp		27
	jp		z,.SALE_DISPARADA

	add		a
	ld		e,a
	ld		d,0
	add		iy,de

	ld		a,(iy)
	ld		(ix),a
	ld		a,(iy+1)
	ld		(ix+1),a

	ld		a,(ix+2)
	inc		a
	and		00000001b
	ld		(ix+2),a

.SALTO_DESDE_REBOTA:

	ld		iy,VARIABLE_UN_USO
	ld		a,(ix)
	sub		8
	ld		(iy+1),a
	ld		a,(ix+1)
	sub		8
	ld		(iy),a
	ld		a,(ix+2)
[2]	add		a
	add		60*4
	ld		(iy+2),a

	call	.MAS_DE_UN_USO_1
	call	.MAS_DE_UN_USO_2
	ld		a,(iy+2)
	add		8
	ld		(iy+2),a

.COMUN_PINTA_Y_DESAPARECE:
	
	call	.MAS_DE_UN_USO_1
	ld		de,4
	or		a
	adc		hl,de
	call	.MAS_DE_UN_USO_2

	ld		a,(ix+3)
	inc		a
	ld		(ix+3),a

	jp		.FIN_DEL_BUCLE

.MAS_DE_UN_USO_1:

	ld		a,(VARIABLE_UN_USO3)
	and		00000001b
[3]	add		a
	ld		e,a
	ld		d,0
	ld		hl,#4A00+18*4
	or		a
	adc		hl,de

	ret

.MAS_DE_UN_USO_2:

	ex		de,hl
	ld		hl,VARIABLE_UN_USO
	push	bc
	ld		bc,3
	call	PON_COLOR_2.sin_bc_impuesta
	pop		bc

	ret

.TOCA_SUELO:

		push	af
        ld      a,5
        ld      (TIEMPO_DE_ADJUST),a
        ld      a,1
        ld      (COLOR_ALEATORIO),a

        ld      a,29
        ld      c,0

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.SALE:

		push	af
        ld      a,27
        ld      c,0

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.COGE:

		push	af
        ld      a,28
        ld      c,0

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        call    PAGE_10_A_SEGMENT_2 
		pop		af

		ret

.DATA_RECORRIDO_ROCA_1_1:

	db	0,99
	db	10,97
	db	22,97
	db	33,96
	db	46,96
	db	60,98
	db	71,103
	db	80,108
	db	88,111
	
	db	94,83
	db	114,64
	db	146,59
	db	173,67
	db	191,80
	db	203,89
	db	217,99
	db	230,116

	db	233,115
	db	236,113
	db	239,113
	db	243,113
	db	247,115
	db	250,117
	db	253,119
	db	255,120

	db	0,0

.DATA_RECORRIDO_ROCA_2_1:

	db	255,120
	db	251,120
	db	246,120
	db	241,123
	db	238,126
	db	234,131
	db	232,136
	db	231,139
	db	231,143
	
	db	214,118
	db	190,101
	db	167,93
	db	137,85
	db	107,85
	db	75,94
	db	54,104
	db	37,124
	
	db	32,120
	db	29,118
	db	24,116
	db	19,114
	db	14,116
	db	9,118
	db	4,120
	db	0,125

	db	0,0

.DATA_RECORRIDO_ROCA_3_1:

	db	0,125
	db	4,126
	db	10,127
	db	13,127
	db	17,128
	db	21,131
	db	23,135
	db	24,138
	db	25,143
	
	db	35,129
	db	45,120
	db	52,111
	db	64,100
	db	76,93
	db	92,88
	db	109,95
	db	120,111
	
	db	129,103
	db	147,94
	db	165,91
	db	181,91
	db	199,87
	db	222,87
	db	238,91
	db	255,96

	db	0,0

.DATA_RECORRIDO_ROCA_4_1:

	db	255,96
	db	245,89
	db	233,82
	db	219,81
	db	208,83
	db	193,89
	db	184,95
	db	173,106
	db	167,112
	
	db	167,86
	db	157,96
	db	155,107
	db	152,122
	db	149,139
	db	145,157
	db	142,172
	db	140,193
	
	db	134,173
	db	121,157
	db	109,145
	db	91,131
	db	76,118
	db	52,102
	db	31,96
	db	0,99

	db	0,0

.DATA_RECORRIDO_ROCA_1_2:

	db	0,99
	db	10,97
	db	22,97
	db	33,96
	db	46,96
	db	60,98
	db	71,103
	db	80,108
	db	88,111

	db	95,95
	db	106,79
	db	127,79
	db	137,93
	db	141,109
	db	144,124
	db	143,143
	db	141,160

	db	153,153
	db	168,144
	db	180,139
	db	193,134
	db	206,128
	db	223,123
	db	237,121
	db	255,120

	db	0,0

.DATA_RECORRIDO_ROCA_2_2:

	db	255,120
	db	251,120
	db	246,120
	db	241,123
	db	238,126
	db	234,131
	db	232,136
	db	231,139
	db	231,143	
	
	db	215,132
	db	203,128
	db	190,125
	db	175,125
	db	156,124
	db	144,127
	db	131,132
	db	118,142
	
	db	106,133
	db	93,127
	db	79,123
	db	61,120
	db	51,118
	db	35,120
	db	16,120
	db	0,125

	db	0,0

.DATA_RECORRIDO_ROCA_3_2:

	db	0,125
	db	4,126
	db	10,127
	db	13,127
	db	17,128
	db	21,131
	db	23,135
	db	24,138
	db	25,143
	
	db	56,130
	db	78,127
	db	97,128
	db	122,137
	db	139,147
	db	156,157
	db	172,168
	db	191,181
	
	db	196,168
	db	201,155
	db	206,147
	db	213,134
	db	221,121
	db	232,110
	db	243,103
	db	255,96

	db	0,0

.DATA_RECORRIDO_ROCA_4_2:

	db	255,96
	db	245,89
	db	233,82
	db	219,81
	db	208,83
	db	193,89
	db	184,95
	db	173,106
	db	167,112
	
	db	164,103
	db	163,97
	db	157,90
	db	151,92
	db	146,98
	db	142,107
	db	140,120
	db	140,128
	
	db	131,115
	db	118,104
	db	99,93
	db	80,87
	db	60,83
	db	39,84
	db	17,87
	db	0,99

	db	0,0

.DATA_RECORRIDO_ROCA_1_3:
	
	db	0,99
	db	10,97
	db	22,97
	db	33,96
	db	46,96
	db	60,98
	db	71,103
	db	80,108
	db	88,111

	db	104,115
	db	112,128
	db	117,140
	db	118,150
	db	118,162
	db	119,175
	db	117,189
	db	120,205

	db	128,185
	db	141,168
	db	157,155
	db	176,146
	db	190,141
	db	207,135
	db	229,127
	db	255,120

	db	0,0

.DATA_RECORRIDO_ROCA_2_3:
	
	db	255,120
	db	251,120
	db	246,120
	db	241,123
	db	238,126
	db	234,131
	db	232,136
	db	231,139
	db	231,143
	
	db	221,139
	db	208,137
	db	196,137
	db	181,136
	db	167,142
	db	157,147
	db	148,155
	db	139,163
	
	db	127,154
	db	111,146
	db	96,141
	db	76,136
	db	61,133
	db	43,131
	db	25,127
	db	0,125

	db	0,0

.DATA_RECORRIDO_ROCA_3_3:
	
	db	0,125
	db	4,126
	db	10,127
	db	13,127
	db	17,128
	db	21,131
	db	23,135
	db	24,138
	db	25,143
	
	db	53,139
	db	73,139
	db	88,147
	db	102,158
	db	112,170
	db	120,181
	db	131,196
	db	140,208
	
	db	150,188
	db	163,170
	db	174,157
	db	186,142
	db	200,129
	db	213,118
	db	231,104
	db	255,96

	db	0,0

.DATA_RECORRIDO_ROCA_4_3:
	
	db	255,96
	db	245,89
	db	233,82
	db	219,81
	db	208,83
	db	193,89
	db	184,95
	db	173,106
	db	167,112
	
	db	156,112
	db	143,116
	db	128,121
	db	116,128
	db	100,142
	db	91,152
	db	84,166
	db	78,190
	
	db	74,171
	db	68,159
	db	60,146
	db	50,128
	db	42,118
	db	29,107
	db	17,101
	db	0,99

	db	0,0

PULSA_UNA_TECLA_PARA_SEGUIR_b2:

		xor		a
		call	GTTRIG_RAM
		or		a
		jp		z,PULSA_UNA_TECLA_PARA_SEGUIR_b2
		
TERMINANDO_LA_BATALLA_b2:

		include	"AUDIOS/INICIA MUSICA_WIN.asm"

CAMINITO_A_PUERTA_b2:

		include	"VARIOS USOS/PASEITO HASTA PUERTA.asm"		
SALUDO_b2:

		include	"VARIOS USOS/SALUDO_GANA_FASE.asm"		

FADE_DEPH_b2:

;		ld		hl,FADE_DEPH_A_NEGRO_b2
;		include	"VARIOS USOS/FADE DEPH SALIENDO DE ESCENA.asm"

ULTIMO_DESPLAZAMIENTO_b2:

		include	"VARIOS USOS/PASEITO DENTRO DE PUERTA.asm"	

VOLVEMOS_b2:

        push    de
        push    bc
        push    iy
        push    ix
		jp		CARGA_SLOT_REGRESO_A_JUEGO

FADE_DEPH_A_NEGRO_b2:

		incbin	"PALETAS/BOSS2 DEPH.FADEOUT"

FADE_FASE_1_3_A_NEGRO_b2:

		incbin	"PALETAS/BOSS2.fadeout"