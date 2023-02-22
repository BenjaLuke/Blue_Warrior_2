ROCKAGER:

        xor     a
        ld      (SECUENCIA_DE_ROCKAGER),a
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_1),a
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_2),a
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_4),a
        ld      (PRIMERA_APERTURA_SUELO),a
        ld      a,40
        ld      (VIDA_ROCKAGER_1),a
        ld      (VIDA_ROCKAGER_2),a
        ld      a,38
        ld      (PAGINA_DE_REGRESO),a

        push    ix
        push    iy
        push    bc
        push    de
        
        ld      ix,VALORES_SPRITE_MAREO
        ld      a,57*4
        ld      (ix+2),a

        call    PAGE44_A_SEGMENT_1_PREPARACION_ROCKAGER

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

.CARGA_ROCAGER:

        ld      a,42
        call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
        ld	hl,#8000												; Carga gráficos fase
        ld	de,#8000
        ld	bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,43
        call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
        ld	hl,#8000												; Carga gráficos fase
        ld	de,#C000
        ld	bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,10
        call	CHANGE_BANK_2

.CARGA_STATUS_BOSS:

        ld      a,45
        call	CHANGE_BANK_2

        ld	hl,#8000												; Carga gráficos fase
        ld	de,#0000+(256*200)/2
        ld	bc,(256*54)/2
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
        call    PAGE44_A_SEGMENT_1_PINTA_CORAZONES_VIDA_DEPH_ADECUADOS
        ex      af,af'
        cp      b
        jp      z,.FINAL_BUCLE_CORAZONES
        djnz    .BUCLE_BORRA_CORAZONES_DE_MAS

.FINAL_BUCLE_CORAZONES:

        ld      (CORAZONES),a

.PINTA_MAGIAS_REALES

        call    PAGE44_A_SEGMENT_1_PINTA_MAGIAS_ROCK

.COPIA_A_VARIABLES_ROCKAGER_DATAS:

        ld      ix,.DATAS_ROCKAGER
        ld      iy,DATAS_COPY_RECUP_SCROLL
        call    .BUCLE_PINTA_DATAS

        jp      .BUCLE

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
.BUCLE:

        call    MOVIMIENTO_DEPH_EN_ROCKAGER
        call    PAGE_44_A_SEGMENT_1_ON_SPRITE_ENEMIGO_DEPH
        call    PINTA_MARCADORES_VIDA_ROCK
        call    PAGE_44_A_SEGMENT_1_ON_SPRITE_CON_ROCAS
        call    REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES_ROCK
        call    REVISAMOS_SI_MUERE_UN_ROCKAGER
        call    SECUENCIA_PROYECTILES_PROPIOS_EN_ROCKAGER
        call    PAGE_44_A_SEGMENT_1_PINTA_MAREO
	call	PINTA_PROYECTILES_DE_DEPH_EN_ROCKAGER

        ld      a,(VELOCIDAD_ROCKAGER)                  ;  [ Esta secuencia pone una pausa a la velocidad de los rockagers
        inc     a                                       ;  [
        and     00000011B                               ;  [
        ld      (VELOCIDAD_ROCKAGER),a                  ;  [
        or      a                                       ;  [
        jp      nz,.CONTROL_POST_BUCLE_1                ;  [

        call    RUTINA_ROCKAGER
        call    PAGE_44_A_SEGMENT_1_RUTINA_ROCAS
        call    PINTA_EXPLOSION

.CONTROL_POST_BUCLE_1:

        ld      a,(TIEMPO_DE_ADJUST)
        or      a
        jp      nz,.CONTROL_POST_BUCLE_2
        dec     a
        ld      (TIEMPO_DE_ADJUST),a        
/*        xor     a
        ld      (COLOR_ALEATORIO),a
*/
.CONTROL_POST_BUCLE_2:

        ld      a,(PAUSA_TOQUE_ROCA_HACHA)
        or      a
        jp      z,.BUCLE

        dec     a
        ld      (PAUSA_TOQUE_ROCA_HACHA),a

        jp      .BUCLE

.PAGE_2_A_PAGE_1_COMPLETA:

	dw      #0000,#0200,#0000,#0100,#0100,#0100
	db      #00,#00,10010000b

.COPIA_PARTE_PAGE_2_DE_STATUS:

        dw      #0000,#0200,#0000,#00B4,256,20
       	db      #00,#00,10010000b

.COPI_MARCADOR_BOSSES_CORAZONES_VACIOS:

	dw	#0000+151,#0000+220,#0000+151,#0201,#0000+19,#0000+16
	db      #00,#00,10010000b

.COPY_CORAZONES_EMPTY_DEPH:

        dw      #0000,#0000+29+200,#0000,#0200+6,#0000+10,#0000+8
       	db      #00,#00,10010000b

.COPY_PUNTOS_MAGIA:

        dw      #0000+25,#0000+45+200,#0000+123,#0200+6,#0000+8,#0000+8
       	db      #00,#00,10010000b

.PAGE_1_A_PAGE_2_COMPLETA:

	dw	#0000,#0100,#0000,#0200,#0100,#0100
	db      #00,#00,10010000b

.COPIA_STATUS_BOSS_A_PAGE_2:

        dw      #0000,#00C8,#0000,#0200,256,20
       	db      #00,#00,10010000b

.DATAS_ROCKAGER:

        dw	#0090,#01D0,#0000,#0200,#0041,#0010
	db	#00,#00,10010000b

MOVIMIENTO_DEPH_EN_ROCKAGER:

        include "MOVIMIENTO EN BOSSES.asm"
        
RUTINA_ROCKAGER:

        include "RUTINA ROCKAGERS.asm"

SECUENCIA_PROYECTILES_PROPIOS_EN_ROCKAGER:

        include "SECUENCIA PROYECTILES PROPIOS EN BOSSES.asm"        		

PINTA_PROYECTILES_DE_DEPH_EN_ROCKAGER:

        include "PINTADO PROYECTILES PROPIOS EN BOSSES.asm"

REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES_ROCK:
        
        ld      iy,PROYECTILES
        ld      b,6

.BUCLE_6_PROYECTILES:

        push    bc
        ld      a,(iy+2)
        cp      #FF
        jp      z,.PASAMOS_AL_SIGUIENTE_PROYECTIL

        jp      .revision_1 ; Revisamos arma con cabeza

.REVISION_CHOQUE_CON_ROCAS:

        jp      .revision_4 ; Revisamos arma con piedra

.PASAMOS_AL_SIGUIENTE_PROYECTIL:

        ld      de,16
        add     iy,de
        pop     bc
        djnz    .BUCLE_6_PROYECTILES

.SALIMOS:

        ret

.revision_1:

        ld      ix,.DATAS_REVISIONES
        ld      a,8
        ld      e,a
        ld      d,0
        ld      b,6

.revision_2:

        jp    .revision_bloque_1

.revision_3:

        add     ix,de
        djnz    .revision_2

.revision_rocas:

        jp      .REVISION_CHOQUE_CON_ROCAS

.revision_4:

        ld      a,(ARMA_USANDO)                 ; Nos aseguramos de que es un hacha
        cp      6
        jp      c,.PASAMOS_AL_SIGUIENTE_PROYECTIL
	push    bc
        ld      b,6

        xor     a
        ld      (VARIABLE_UN_USO3),a

.BUCLE_REVISION_6_PIEDRAS:

        ex      af,af'
        ld      a,(PAUSA_TOQUE_ROCA_HACHA)
        or      a
        jp      nz,.SIGUIENTE_EN_EL_BUCLE
        ex      af,af'        

	ld	ix,VALORES_SPRITES_PIEDRAS
[2]	add	a
	ld	e,a
	ld	d,0
	add	ix,de

	ld	a,(ix)
	sub	8
	ld	c,a
	ld	a,(iy)
	add	20
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix)
	add	8
	ld	c,a
	ld	a,(iy)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	sub	8
	ld	c,a
	ld	a,(iy+1)
	add	20
	cp	c
	jp	c,.SIGUIENTE_EN_EL_BUCLE

	ld	a,(ix+1)
	add	8
	ld	c,a
	ld	a,(iy+1)
	cp	c
	jp	nc,.SIGUIENTE_EN_EL_BUCLE
	
        ld      a,27
        ld      (ix+3),a

	ld	hl,5
        ld      (SCORE_A_SUMAR),hl
        push    bc
        call    SUMA_SCORE

	call    PAGE_31_A_SEGMENT_2
	ld	a,30
	ld	c,0
	call	ayFX_INIT
        call    PAGE_10_A_SEGMENT_2

        ld      a,30
        ld      (PAUSA_TOQUE_ROCA_HACHA),a

        pop     bc

.SIGUIENTE_EN_EL_BUCLE:

        ld      a,(VARIABLE_UN_USO3)
        inc     a
        ld      (VARIABLE_UN_USO3),a
        djnz    .BUCLE_REVISION_6_PIEDRAS
	pop	bc

        jp      .PASAMOS_AL_SIGUIENTE_PROYECTIL

.sobre_el_proyectil:

        ld      a,5
        ld      c,0
        call    TIRA_FX

        xor     a
        ld      (iy+8),a
	ld	a,(iy+12)
	call	MOVIMIENTO_DEPH_EN_ROCKAGER.DEJA_LIBRE_SPRITE_EN_RAM
        pop     af

        ld      ix,VALORES_EXPLOSION_CON_ROCK

        ld      a,(iy)
        ld      (ix+1),a
        ld      a,(iy+1)
        sub     8
        ld      (ix),a
        ld      a,23*4
        ld      (ix+2),a
        
        jp      .SALIMOS

.revision_bloque_1:

        ld      c,(ix)
        ld      a,(iy)
        cp      c
        jp     c,.revision_3
        sub     11
        cp      c
        jp     nc,.revision_3
        ld      c,(ix+2)
        ld      a,(iy+1)
        cp      c
        jp     c,.revision_3
        sub     8
        cp      c
        jp     nc,.revision_3

        ld      a,(SECUENCIA_DE_ROCKAGER)
        cp      2
        jp      z,.revision_bloque_3
 
.revision_bloque_2:
        
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        cp      (ix+4)
        jp     c,.revision_3
        cp      (ix+5)
        jp     nc,.revision_3

        ld      a,(iy)
        cp      105
        jp      nc,.descuenta_2

.descuenta_1:

        ld      a,(VIDA_ROCKAGER_1)
        dec     a
        ld      (VIDA_ROCKAGER_1),a

        jp      .sobre_el_proyectil

.descuenta_2:

        ld      a,(VIDA_ROCKAGER_2)
        dec     a
        ld      (VIDA_ROCKAGER_2),a

        jp      .sobre_el_proyectil

.revision_bloque_3:

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        cp      (ix+6)
        jp     c,.revision_3
        cp      (ix+7)
        jp     nc,.revision_3

        ld      a,(VIDA_ROCKAGER_1)
        or      a
        jp      z,.revision_bloque_4

        dec     a
        ld      (VIDA_ROCKAGER_1),a

        cp      40
        jp      c,.sobre_el_proyectil
        xor     a
        ld      (VIDA_ROCKAGER_1),a
        
        jp      .sobre_el_proyectil

.revision_bloque_4:

        ld      a,(VIDA_ROCKAGER_2)
        dec     a
        ld      (VIDA_ROCKAGER_2),a

        cp      40
        jp      c,.sobre_el_proyectil
        xor     a
        ld      (VIDA_ROCKAGER_2),a
        
        jp      .sobre_el_proyectil

.DATAS_REVISIONES:

        db      50,61,82,90,13,26,13,26
        db      178,199,162,170,13,26,49,61
        db      34,45,127,134,49,61,85,97
        db      226,237,127,134,49,61,121,133
        db      82,93,162,170,85,97,157,169
        db      178,189,82,90,85,97,193,205

REVISAMOS_SI_MUERE_UN_ROCKAGER:

        ld      a,(SECUENCIA_DE_ROCKAGER)
        cp      2
        jp      z,.DOS
        or      a
        ret     nz

.UNO:

.UNO_PRIMERO:

        ld      a,(VIDA_ROCKAGER_1)
        or      a
        jp      nz,.UNO_SEGUNDO

        ld      a,(SECUENCIA_DE_ROCKAGER)
        inc     a
        ld      (SECUENCIA_DE_ROCKAGER),a

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        cp      85
        jp      nc,.UNO_PRIMERO_3
        cp      49
        jp      nc,.UNO_PRIMERO_2

.UNO_PRIMERO_1:

        ld      a,4
        ld      (AGUJERO_INTOCABLE),a
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        add     37
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        xor     a
        jp      .UNO_COMUN

.UNO_PRIMERO_2:

        ld      a,37+37-2
        ld      (AGUJERO_INTOCABLE),a
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        add     74
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        ld      a,1
        jp      .UNO_COMUN

.UNO_PRIMERO_3:

        ld      a,37+37+37+37-4
        ld      (AGUJERO_INTOCABLE),a
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        add     111
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        ld      a,2
        jp      .UNO_COMUN

.UNO_COMUN:

        ld      (POSICION_DERRUMBE_ROCKAGER),a

	ld	hl,30
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

        ret

.UNO_SEGUNDO:

        ld      a,(VIDA_ROCKAGER_2)
        or      a
        ret     nz

        ld      a,(SECUENCIA_DE_ROCKAGER)
        inc     a
        ld      (SECUENCIA_DE_ROCKAGER),a

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        cp      85
        jp      nc,.UNO_SEGUNDO_3
        cp      49
        jp      nc,.UNO_SEGUNDO_2

.UNO_SEGUNDO_1:

        ld      a,37-1
        ld      (AGUJERO_INTOCABLE),a
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        ld      a,3
        jp      .UNO_COMUN

.UNO_SEGUNDO_2:

        ld      a,37+37+37-3
        ld      (AGUJERO_INTOCABLE),a
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        add     37
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        ld      a,4
        jp      .UNO_COMUN

.UNO_SEGUNDO_3:

        ld      a,37+37+37+37+37-5
        ld      (AGUJERO_INTOCABLE),a
        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_1)
        add     37+37
        ld      (FOTOGRAMA_SECUENCIA_ROCKAGER_3),a
        ld      a,5
        jp      .UNO_COMUN

.DOS:

.DOS_PRIMERO:

        ld      a,(VIDA_ROCKAGER_1)
        or      a
        ret     nz

        ld      a,(VIDA_ROCKAGER_2)
        or      a
        ret     nz

        ld      a,(SECUENCIA_DE_ROCKAGER)
        inc     a
        ld      (SECUENCIA_DE_ROCKAGER),a

        ld      a,(FOTOGRAMA_SECUENCIA_ROCKAGER_3)
        cp      183
        jp      nc,.DOS_PRIMERO_6
        cp      147
        jp      nc,.DOS_PRIMERO_5
        cp      111
        jp      nc,.DOS_PRIMERO_4
        cp      85
        jp      nc,.DOS_PRIMERO_3
        cp      49
        jp      nc,.DOS_PRIMERO_2

.DOS_PRIMERO_1:

        xor     a
        jp      .UNO_COMUN

.DOS_PRIMERO_2:

        ld      a,3
        jp      .UNO_COMUN

.DOS_PRIMERO_3:

        ld      a,1
        jp      .UNO_COMUN

.DOS_PRIMERO_4:

        ld      a,4
        jp      .UNO_COMUN

.DOS_PRIMERO_5:

        ld      a,2
        jp      .UNO_COMUN

.DOS_PRIMERO_6:

        ld      a,5
        jp      .UNO_COMUN

PINTA_MARCADORES_VIDA_ROCK:

        include "PINTA MARCADORES VIDA EN BOSSES.asm"

PINTA_EXPLOSION:

        ld      ix,VALORES_EXPLOSION_CON_ROCK
        ld      a,(ix+2)
        or      a
        ret     z
        cp      25*4
        jp      nz,.PINTAMOS

        xor     a
        ld      (ix+2),a

.PINTAMOS:        

        ld	de,#4A00+17*4
        ld      hl,VALORES_EXPLOSION_CON_ROCK
        ld      bc,3
	call	PON_COLOR_2.sin_bc_impuesta
	
        ld	de,#4800+17*16
        ld      hl,.COLOR_EXPLOSION
        ld      bc,16
	call	PON_COLOR_2.sin_bc_impuesta

        ld      a,(ix+2)
        or      a
        ret     z
        add     4
        ld      (ix+2),a
        ret 

.COLOR_EXPLOSION:

	DB      $03,$03,$03,$03,$03,$03,$03,$03
	DB      $03,$03,$03,$03,$03,$03,$03,$03

PINTADO_DE_VRAM:

        call    PAGE_32_A_SEGMENT_2
	call	PON_COLOR_2.sin_bc_impuesta
        jp      PAGE_10_A_SEGMENT_2

TIRA_FX:

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        jp      PAGE_10_A_SEGMENT_2 

                