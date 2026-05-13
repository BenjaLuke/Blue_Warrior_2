CONTROL_TILES_PUPA:

			ld		a,(FASE)
			cp		1
			jp		z,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			cp		4
			jp		z,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS			
			cp		5
			jp		nz,.CONTROL_TILES_PUPA_1

			ld		a,(TILE_CENTRO)
			cp		80
			jp		nc,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			ld		a,(TILE_CENTRO_2)
			cp		80
			jp		nc,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.CONTROL_TILES_PUPA_1:

			ld		a,(DESACTIVA_PUPA)
			or		a
			jp		nz,CONTROL

			ld		a,(TILE_CENTRO)
			cp		48
			jp		c,.CONTROL_TILES_PUPA_2
			cp		80
			jp		nc,.CONTROL_TILES_PUPA_2
			cp		59
			jp		c,.HACEMOS_PUPA
			cp		63
			jp		c,.CONTROL_TILES_PUPA_2

.CONTROL_TILES_PUPA_2:

			ld		a,(TILE_CENTRO_2)
			cp		48
			jp		c,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			cp		96
			jp		nc,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS
			cp		59
			jp		c,.HACEMOS_PUPA
			cp		63
			jp		c,DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.HACEMOS_PUPA:			

			push	af
			call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH.DANO_DE_PUPA
			pop		af

.QUE_CORRIGE:

       		cp		54
			jp		z,.X_LEFT
			cp		55
			jp		z,.Y_DOWN
			cp		56
			jp		z,.X_RIGHT
			cp		57
			jp		z,.Y_UP
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.Y_DOWN:

			ld		a,(Y_DEPH)
			add		2
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			add		2
			ld		(CONTROL_Y),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.Y_UP:

			ld		a,(Y_DEPH)
			sub		2
			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			sub		2
			ld		(CONTROL_Y),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.X_RIGHT:

			ld		a,(X_DEPH)
			add		2
			ld		(X_DEPH),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS


.X_LEFT:

			ld		a,(X_DEPH)
			sub		2
			ld		(X_DEPH),a
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

MIRAMOS_SI_HAY_AGUJERO:


PRIMERO_MIRAMOS_SI_ES_FASE_4_Y_RELENTIZA_EL_SUELO:

			ld		a,(FASE)
			cp		4
			jp		nz,ESTADO_NORMAL

			ld		a,(TILE_CENTRO)
			cp		48
			jp		c,ESTADO_NORMAL
			cp		68
			jp		nc,ESTADO_NORMAL

			ld		a,(VARIABLE_CARGA_AGUA)
			or		a
			jp		nz,.SOLO_RALENTIZAR

			ld		a,1
			ld		(VARIABLE_CARGA_AGUA),a

			call	CARGA_PIES_EN_LODO



.SOLO_RALENTIZAR:
			
			ld		a,(LENTO)
			inc		a
			and		00000001b
			ld		(LENTO),a
			jp		AHORA_SI_EL_AGUJERO

ESTADO_NORMAL:

			xor		a
			ld		(LENTO),a
			ld		a,(VARIABLE_CARGA_AGUA)
			or		a
			jp		z,AHORA_SI_EL_AGUJERO
			xor		a
			ld		(VARIABLE_CARGA_AGUA),a
			halt
			call	CARGA_1_A_45
AHORA_SI_EL_AGUJERO:

			ld		hl,(TIME_PARALIZA)
			ld		de,0
			call	DCOMPR_RAM
			jp		nz,DEPH_PARALIZADO_2.CONTROL_TIME_PARALIZA_1

.tile_agujero_1:

			ld		a,(TILE_CENTRO)
			cp		61
			jp		nz,.tile_agujero_2
			
			call	.control_de_y_a_menos
			
			call	.x_divide_16

			add		8	
	 		jp		.paralizamos_a_deph

.tile_agujero_2:

			ld		a,(TILE_CENTRO)
			cp		62
			jp		nz,.tile_agujero_3
			
			call	.control_de_y_a_menos
			
			call	.x_divide_16

			sub		8	
	 		jp		.paralizamos_a_deph

.tile_agujero_3:

			ld		a,(TILE_CENTRO)
			cp		59
			jp		nz,.tile_agujero_4
			
			call	.control_de_y_a_mas
			
			call	.x_divide_16

			add		8	
	 		jp		.paralizamos_a_deph

.tile_agujero_4:

			ld		a,(TILE_CENTRO)
			cp		60
			jp		nz,CONTROL_TILES_PUPA
			
			call	.control_de_y_a_mas
			
			call	.x_divide_16

			sub		8	
	 		jp		.paralizamos_a_deph

.y_divide_16:

			ld		a,(Y_DEPH)
			
			jp		.B11110000

.x_divide_16:

			ld		a,(X_DEPH)

.B11110000:

			and		11110000b
			ret

.control_de_y_a_menos:

			call	.y_divide_16
			call	.control_comun_de_y
			ld		(CONTROL_Y),a
			ret

.control_de_y_a_mas:

			call	.y_divide_16
			add		16
			call	.control_comun_de_y
			add		16
			ld		(CONTROL_Y),a
			ret

.control_comun_de_y:

			ld		(Y_DEPH),a
			ld		a,(CONTROL_Y)
			and		11110000b
			ret

.paralizamos_a_deph:

			ld		(X_DEPH),a
			ld		hl,220
			ld		(TIME_PARALIZA),hl
			xor		a
			ld		(AGU_ACTIVO),a
			inc		a
			ld		(PARALIZAMOS),a
			ld		(SPRITE_CAIDO),a

			jp		CONTROL.RECUPERANDO_SPRITES_DEPH

DEPH_PARALIZADO_2:

			call	PINTA_SPRITE_DEPH

			jp		CONTROL_TILES_PUPA

.CONTROL_TIME_PARALIZA_1:

			ld		de,1
			or		a
			sbc		hl,de
			ld		(TIME_PARALIZA),hl
			ld		de,30
			call	DCOMPR_RAM
			jp		c,.CONTROL_TIME_PARALIZA_2
			
			jp		DEPH_PARALIZADO_2.CONTROL_DE_BLOQUEOS

.CONTROL_TIME_PARALIZA_2:

			ld		de,0
			call	DCOMPR_RAM
			jp		z,CONTROL_TILES_PUPA

			xor		a
			ld		(PARALIZAMOS),a
			inc		a
			ld		(AGU_ACTIVO),a

			jp		CONTROL_TILES_PUPA

.CONTROL_DE_BLOQUEOS:

			ld		a,(PAUSA_BLOQUEADA)
			cp		5
			jp		z,.CONTROL_Y_BLOQUEOS
			or		a
			jp		z,CONTROL
			dec		a
			ld		(PAUSA_BLOQUEADA),a			
			jp		CONTROL

.CONTROL_Y_BLOQUEOS:

			dec		a
			ld		(PAUSA_BLOQUEADA),a
			xor		a
			ld		(AVANCE_BLOQUEADO),a
			jp		CONTROL

.resta_comun_x:

			ld		a,(TILE_O)
			cp		79
			ret		nc

			ld		a,(X_DEPH)
			cp		0
			ret		z
					
			ld		a,(X_DEPH)
			dec		a
			ld		(X_DEPH),a
			
			ret

.suma_comun_x:

			ld		a,(TILE_E)
			cp		79
			ret		nc

			ld		a,(X_DEPH)
			cp		235
			ret		z
			
			ld		a,(X_DEPH)
			inc		a
			ld		(X_DEPH),a
			
			ret

SE_PUEDE_MOVER_Y_EFES_VARIOS:

			ld		a,(PARALIZAMOS)
			or		a
			jp		nz,CONTROL.pre_sigue_comun	

			ld		a,6	
			call	SNSMAT_RAM  
			bit		6,a												; Si pulsa f2 quitamos o ponemos el marcador
			jp		z,HIDE_STATUS
			bit		5,a												; Si pulsa f1 pausamos
			jp		z,PAUSE	
			bit		7,a												; Si pulsa f3 paramos la música
			jp		z,MUSIC_ON_OFF	
			ld		a,7
			call	SNSMAT_RAM
			bit		0,a
			jp		z,EFECTOS_ON_OFF								; Si pulsa f4 paramos FX
			bit		1,a	
			jp		z,AGILIZA_MAPA									; Si pulsa f5 avanza 20 lineas en el mapa			
			xor		a
			ld		(MARCADOR_PULSADO),a
			jp		CONTROL.teclado

COVIDS:

.DEFINE_COVID_CORTO_DERECHA:

        ld      a,b
        ld		hl,VALORES_BASICOS_COVID_CORTO_DERECHA
        jp      .comun_covids

.DEFINE_COVID_ABAJO_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_COVID_ABAJO_IZQUIERDA
        jp      .comun_covids

.DEFINE_COVID_CORTO_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_COVID_CORTO_IZQUIERDA
        jp      .comun_covids

.DEFINE_COVID_CORTO_CENTRO:

        ld      a,b
        ld		hl,VALORES_BASICOS_COVID_CORTO_CENTRO
        jp      .comun_covids


.DEFINE_COVID:

        ld      a,b
        ld		hl,VALORES_BASICOS_COVID

.comun_covids:

        call    STANDAR_LDIR_ENEMIGOS

 
        ld      (ix+11),a
        cp      000100000B
        jp      z,.comun_covids_seguimos

        ld      a,12
        ld      (ix+14),a

.comun_covids_seguimos:

        call    TROZOS_COMUNES_1
		ld		hl,COLOR_COVID_1_1						; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.SECUENCIA_COVID_ABAJO:

		ld		a,(ix+9)
		cp		2
		jp		nz,.SECUENCIA_COVID_CORTO

		ld		a,(ix+13)
		or		a
		jp		z,.SECUENCIA_COVID_ABAJO_1

		dec		a
		ld		(ix+13),a

.SECUENCIA_COVID_ABAJO_1:

		ld		a,(ix+1)
		sub		2
		ld		(ix+1),a
		
		ld		a,00000100B
		ld		(ix+11),a
		
		ld		a,(ix+5)
		cp		01100000b
		jp		nc,.miramos_mas_datos
		ld		a,01100000b
		ld		(ix+5),a

		jp		.miramos_mas_datos

.SECUENCIA_COVID_CORTO:
		
		ld		a,(ix+9)
		cp		1
		jp		z,.realizamos_la_secuencia

        ld      a,(ix+10)
        and     00000001B
        or      a
        jp      nz,.miramos_mas_datos

.realizamos_la_secuencia:

        push    iy
        ld      iy,TABLA_MOVIMIENTO_COVID_CORTO
        ld      a,(ix+7)
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(iy)
        ld      b,a
        ld      a,(ix+9)
        add     b        
        ld      (ix),a
        pop     iy
        ld      a,(ix+7)
        inc     a
        ld      (ix+7),a
        cp      100
        jp      c,.miramos_mas_datos

        xor     a
        ld      (ix+7),a
        jp      .miramos_mas_datos

.SECUENCIA_COVID:

        ld      a,(ix+10)
        and     00000001B
        or      a
        jp      nz,.miramos_mas_datos
        
        push    iy
        ld      iy,TABLA_MOVIMIENTO_COVID
        ld      a,(ix+7)
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(iy)
        ld      (ix),a
        pop     iy
        ld      a,(ix+7)
        inc     a
        ld      (ix+7),a
        cp      134
        jp      c,.miramos_mas_datos

        xor     a
        ld      (ix+7),a
        
.miramos_mas_datos:

        ld      a,(ix+11)
        cp      00010000B
        jp      z,.velocidad_lenta

.velocidad_rapida:

        ld      b,a
        
        ld      a,(ix+5)
        inc     a
        and     01111111B
        ld      (ix+5),a

        cp      01111111b
        
        call    nc,NUEVO_PROYECTIL_NORMAL
        
        ld      a,(ix+10)
        and     00000111B
        jp      .comun

.velocidad_lenta:

        ld      b,a
        ld      a,(ix+10)

.comun:
        
        cp      b
        jp      c,.SECUENCIA_COVID_2

.SECUENCIA_COVID_1:

        ld      a,62*4
        ld      (ix+8),a
        jp      .SECUENCIA_COVID_CONTINUA

.SECUENCIA_COVID_2:

		ld		a,(ix+13)
		or		a
		jp		nz,.SECUENCIA_COVID_1

        ld      a,9
        ld      c,3
        call    A_31_DESDE_10       

        ld      a,63*4
        ld      (ix+8),a

.SECUENCIA_COVID_CONTINUA:

        ld      a,(ix+4)
        inc     a
        and     00000111B
        ld      (ix+4),a
        or      a
        jp      nz,.seguimos_la_secuencia_covid

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a

.seguimos_la_secuencia_covid:

        ld      a,(ix+10)
        and     00001111B
        or      a
        jp      nz,.FIN_SECUENCIA_COVID

.suma_posicion:

        ld      a,(ix+1)
        dec     a
        ld      (ix+1),a
        
.FIN_SECUENCIA_COVID:

        ld      a,(ix+10)
        inc     a
        and     00011111B
        ld      (ix+10),a

		ld		a,(ix+9)
		cp		1
        jp      nz,TROZOS_COMUNES_28

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		sub		20
		ld		b,a
		ld		a,(ix+1)
		cp		b
		jp		z,.COVID_ABAJO_CAMBIA_SECUENCIA
		inc		a
		cp		b
		jp		z,.COVID_ABAJO_CAMBIA_SECUENCIA
		inc		a
		cp		b
		jp		z,.COVID_ABAJO_CAMBIA_SECUENCIA
		inc		a
		cp		b
		jp		nz,TROZOS_COMUNES_28

.COVID_ABAJO_CAMBIA_SECUENCIA:

		ld		a,2
		ld		(ix+9),a
		ld		a,30
		ld		(ix+13),a
		jp		TROZOS_COMUNES_28

SLIMES:

.DEFINE_SLIME_AZUL_BAJANDO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_BAJANDO
        jp      .comun_slimes

.DEFINE_SLIME_BLANCO:
        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_BLANCO
        jp      .comun_slimes

.DEFINE_SLIME_AZUL_QUIETO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_QUIETO
        jp      .comun_slimes

.DEFINE_SLIME_AZUL_HACIA_DERECHA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_HACIA_DERECHA
        jp      .comun_slimes

.DEFINE_SLIME_AZUL_HACIA_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_AZUL_HACIA_IZQUIERDA
        jp      .comun_slimes

.DEFINE_SLIME_VERDE_BAJANDO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_VERDE_BAJANDO        
        jp      .comun_slimes

.DEFINE_SLIME_VERDE_HACIA_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_VERDE_HACIA_IZQUIERDA  
        jp      .comun_slimes

.DEFINE_SLIME_FUEGO_HACIA_IZQUIERDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_FUEGO_HACIA_IZQUIERDA  
        jp      .comun_slimes

.DEFINE_SLIME_FUEGO_QUIETO:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_FUEGO_QUIETO
        jp      .comun_slimes

.DEFINE_SLIME_FUEGO_RONDA:

        ld      a,b
        ld		hl,VALORES_BASICOS_SLIME_FUEGO_RONDA
        jp      .comun_slimes

.comun_slimes:

        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a

		xor		a
		ld		(ECTOPALLERS_ACTIVO),a

        call    TROZOS_COMUNES_1

        ld      a,(ix+2)
        cp      12
        jp      z,.verde1
        cp      16
        jp      z,.blanco1
        cp      18
        jp      z,.fuego1

.azul1:

		ld		hl,COLOR_SLIME_AZUL_1_1	
        jp      .tras_color_slime_1

.blanco1:

        ld      hl,COLOR_SLIME_BLANCO_1
        jp      .tras_color_slime_1

.fuego1:

        ld      hl,COLOR_SLIME_FUEGO_1
        jp      .tras_color_slime_1

.verde1:
		ld		hl,COLOR_SLIME_VERDE_1_1	

.tras_color_slime_1:

        call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 		ld		a,(SPRITE_QUE_TOCA)	
 [2]	rlc		a
		ld		(ix+3),a

        call    TROZOS_COMUNES_3
        ld      a,(ix+2)
        cp      12
        jp      z,.verde2
        cp      16
        jp      z,.blanco2
        cp      18
        jp      z,.fuego2
.azul2:

		ld		hl,COLOR_SLIME_AZUL_1_2	
        jp      .tras_color_slime_2

.blanco2:

        ld      hl,COLOR_SLIME_BLANCO_2
        jp      .tras_color_slime_2


.verde2:
		ld		hl,COLOR_SLIME_VERDE_1_2	
        jp      .tras_color_slime_2

.fuego2:
		ld		hl,COLOR_SLIME_FUEGO_2

.tras_color_slime_2:

        call    TROZOS_COMUNES_7

        jp      UN_NUEVO_ENEMIGO.RESOLUCION

.SECUENCIA_SLIME_BLANCO_HACIA_DEPH:

        ld      a,(ix+11)
        inc     a
        and     00000001B
        or      a
        jp      nz,.correccion_del_limite_dos

        ld      a,(X_DEPH)
        ld      b,a
        ld      a,(ix)
        cp      b
        jp      c,.hacia_derecha

.hacia_izquierda:

        dec     a
        jp      .correccion_del_limite

.hacia_derecha:

        inc     a

.correccion_del_limite:

        ld      (ix),a

.correccion_del_limite_dos:

        ld      a,(ix+11)
        inc     a
        and     00000111B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME
        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_ABAJO:

        ld      a,(ix+11)
        inc     a
        and     00000111B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a
        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_DERECHA:

        ld      a,(ix+11)
        inc     a
        and     00000011B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME

        ld      a,(ix)
        inc     a
        ld      (ix),a
        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_IZQUIERDA:

        ld      a,(ix+11)
        inc     a
        and     00000011B
        ld      (ix+11),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME

        ld      a,(ix)
        dec     a
        ld      (ix),a

        jp      .FIN_SECUENCIA_SLIME

.SECUENCIA_SLIME_RONDA:

        ld      a,(ix+7)
        or     a
        jp      nz,.RONDA_FASE_2

.RONDA_FASE_1:

        ld      a,(ix)
        add     1
        ld      (ix),a
        jp      .RONDA_FINAL

.RONDA_FASE_2:

        ld      a,(ix)
        sub     1
        ld      (ix),a

.RONDA_FINAL:

        ld      a,(ix+13)
        inc     a
        and     00011111b
        ld      (ix+13),a
        or      a
        jp      nz,.FIN_SECUENCIA_SLIME
        ld      a,(ix+7)
        inc     a
        and     00000001b
        ld      (ix+7),a

.SECUENCIA_SLIME_QUIETO:

        ;       NO HACE NADA DE MOVIMIENTO
        
.FIN_SECUENCIA_SLIME:

        ld      a,(ix+10)
        inc     a
        and     00111111B
        ld      (ix+10),a

        cp      00011111B
        jp      c,.fotograma_dos_slime

.fotograma_uno_slime:

        call    TROZOS_COMUNES_16
        jp      .saliendo

.fotograma_dos_slime:

        call   	TROZOS_COMUNES_17

.saliendo:

        ld      a,(ix+9)
        cp      2
        jp      z,.nivel3
        cp      1
        jp      z,.nivel2

.nivel1:
        
        ld      a,(ix+5)
        inc     a
        and     01111111B
        ld      (ix+5),a

        cp      01111111b
        jp      .seguimos_slime

.nivel2:
        
        ld      a,(ix+5)
        inc     a
        and     00111111B
        ld      (ix+5),a

        cp      00111111b
        jp      .seguimos_slime

.nivel3:
        
        ld      a,(ix+5)
        inc     a
        and     00011111B
        ld      (ix+5),a

        cp      00011111b
        jp      .seguimos_slime

.seguimos_slime:

        call    z,NUEVO_PROYECTIL_NORMAL
        jp      TROZOS_COMUNES_23
ECTO_PALLERS:

.DEFINE_ECTO_PALLERS_TOCA_HUEVOS:

		ld		a,2
		ld		(ECTOPALLERS_ACTIVO),a

		ld		a,b		
        ld		hl,VALORES_BASICOS_ECTO_PALLER_TOCA_HUEVOS
        call    STANDAR_LDIR_ENEMIGOS
        call    TROZOS_COMUNES_1

		ld		a,(ix+1)
		add		68
		ld		(ix+14),a
		ld		hl,COLORES_ECTO_PALLERS_1
        call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 		ld		a,(SPRITE_QUE_TOCA)	
 [2]	rlc		a
		ld		(ix+3),a

        call    TROZOS_COMUNES_3
		ld		hl,COLORES_ECTO_PALLERS_2	
        jp	    TROZOS_COMUNES_9

.DEFINE_ECTO_PALLERS_CIRCLE:

		push	bc

		ld		a,1
		ld		(ECTOPALLERS_ACTIVO),a

		ld		a,b
		
        ld		hl,VALORES_BASICOS_ECTO_PALLER_CIRCLE


        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
		ld		(ix+13),a
		pop		bc
		ld		(ix+10),c
        call    TROZOS_COMUNES_1

		ld		hl,COLORES_ECTO_PALLERS_1
        call    TROZOS_COMUNES_7

		ld		a,(ix+1)
		ld		(ix+14),a
        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 		ld		a,(SPRITE_QUE_TOCA)	
 [2]	rlc		a
		ld		(ix+3),a

        call    TROZOS_COMUNES_3
		ld		hl,COLORES_ECTO_PALLERS_2	
        jp	    TROZOS_COMUNES_9

.SECUENCIA_ECTO_PALLER_CIRCLE:

		ld		a,(ix+10)
		or		a
		jp		nz,.REDUCE_VALOR_ARRANQUE_ECTO_PALLER

		push	iy
		ld		iy,TABLA_MOVIMIENTO_ECTO
		ld      a,(ix+7) ;el contador
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(iy)
		ld		b,a
		ld		a,(ix+13) ;x fija
		add		b
		ld		(ix),a
		ld		a,(iy+1)
		ld		b,a
		ld		a,(ix+14) ; y fija
		add		b
		ld		(ix+1),a
		pop		iy

		ld		a,(ix+5)
		inc		a
		and		00000011b
		ld		(ix+5),a
		or		a
		jp		nz,TROZOS_COMUNES_23

		ld		a,(ix+7)
		add		2
		and		01111111B
		ld		(ix+7),a

		cp		30
		jp		z,.MIRA_DERECHA
		cp		94
		jp		z,.MIRA_IZQUIERDA
		jp		TROZOS_COMUNES_23

.MIRA_DERECHA:

        call    TROZOS_COMUNES_17
		jp		TROZOS_COMUNES_23

.MIRA_IZQUIERDA:
        call    TROZOS_COMUNES_16
		jp		TROZOS_COMUNES_23

.REDUCE_VALOR_ARRANQUE_ECTO_PALLER:

		dec		a
		ld		(ix+10),a
		ld		a,255
		ld		(ix),a
		jp		TROZOS_COMUNES_23

.SECUENCIA_ECTO_PALLERS_TOCA_HUEVOS:

		ld		a,(ix+4)
		inc		a
		and		00000001b
		ld		(ix+4),a
		or		a
		jp		nz,.SALIENDO_ECTO_HUEVOS

		ld		a,(ECTO_PARALIZADO)
		or		a
		jp		z,.EMPIEZA_SECUENCIA
		cp		1
		jp		nz,.PARALIZAHUEVOS

		call	CARGA_ECTO_PALLER

.PARALIZAHUEVOS:

		ld		a,(ECTO_PARALIZADO)
		dec		a
		and		01111111b
		ld		(ECTO_PARALIZADO),a

		ld		a,24
		ld		c,2
        call    A_31_DESDE_10  

		ld		a,(ix+13)
		inc		a
		and		00000001B
		ld		(ix+13),a

		or		a
		jp		z,.mueve_derecha

.mueve_izquierda:

		ld		a,(ix)
		sub		2
		ld		(ix),a
		jp		.PARALIZAHUEVOS_2

.mueve_derecha:

		ld		a,(ix)
		add		2
		ld		(ix),a

.PARALIZAHUEVOS_2:

; Crear secuencia para que se quede en el sitio

		ld		a,(PUNTO_DEL_SCROLL)
		ld		b,a
		ld		a,(ix+5)
		add		b
		ld		(ix+1),a

; Hasta aquí, sustituyend el código anterior

		jp		.SALIENDO_ECTO_HUEVOS

.EMPIEZA_SECUENCIA:

.PASEANDO:

		ld		a,(ix+5)
		or		a
		jp		z,.A_LA_DERECHA

.A_LA_IZQUIERDA:

		ld		a,(ix)
		sub		2
		ld		(ix),a
		cp		16
		jp		nc,.DIBUJAMOS_IZ

		xor		a
		ld		(ix+5),a

.DIBUJAMOS_IZ:

        call    TROZOS_COMUNES_16
		jp		.MANTIENE_EN_LINEA

.A_LA_DERECHA:

		ld		a,(ix)
		add		2
		ld		(ix),a
		cp		14*16
		jp		c,.DIBUJAMOS_DE

		xor		1
		ld		(ix+5),a

.DIBUJAMOS_DE:

        call    TROZOS_COMUNES_17

.MANTIENE_EN_LINEA:

		ld		a,(ix+9)
		or		a
		jp		z,.paseo_superior
		cp		1
		jp		z,.paseo_la_u

.paseo_la_u:

		ld		a,(ix+14)
		push	ix
		ld		ix,TABLA_ECTO_HUEVOS_U
		jp		.paseo_continua

.paseo_superior:

		ld		a,(ix+14)
		push	ix
		ld		ix,TABLA_ECTO_HUEVOS_Y

.paseo_continua:

		ld		d,0
		ld		e,a
		add		ix,de
		ld		a,(ix)
		pop		ix
		ld		b,a
		ld		a,(PUNTO_DEL_SCROLL)
		add		b
		ld		(ix+1),a

		ld		a,(ix+14)
		inc		a
		and		00111111b
		ld		(ix+14),a
			
.ECTO_HUEVOS_CONTINUA:

		ld		a,(ix+7)
		inc		a
		and		01111111b
		ld		(ix+7),a
		or		a
		jp      nz,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

		ld		a,(ix+9)
		inc		a
		and		00000001b
		ld		(ix+9),a
		xor		a
		ld		(ix+14),a

.SALIENDO_ECTO_HUEVOS:

		jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION
FIREWORKS:

.DEFINE_FIREWORKS:

        ld      a,b
        ld		hl,VALORES_BASICOS_FIREWORKS

       	call    STANDAR_LDIR_ENEMIGOS


        call    TROZOS_COMUNES_1
		ld		a,r
		ld		b,a
		ld		a,i
		add		b
		rla
		ld		(ix+1),a
		ld		a,r
		ld		b,a
		ld		a,i
		add		b
		rla		
		ld		(ix),a

		ld		hl,COLOR_FIREWORKS						; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.DEFINE_FIREWORKS_1:


        ld      a,b
        ld		hl,VALORES_BASICOS_FIREWORKS

       	call    STANDAR_LDIR_ENEMIGOS


        call    TROZOS_COMUNES_1
		ld		a,r
		ld		b,a
		ld		a,i
		add		b
		rla
		ld		(ix+1),a
		ld		a,r
		ld		b,a
		ld		a,i
		add		b
		rla
		add		32		
		ld		(ix),a
		ld		a,(ix+1)
		add		16
		ld		(ix+1),a
		ld		a,(ix+8)
		add		4
		ld		(ix+8),a

        ld      a,23
        ld      c,1
        call    A_31_DESDE_10 

		ld		hl,COLOR_FIREWORKS						; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.SECUENCIA_FIREWORKS:

		ld		a,(ix+13)
		inc		a
		and		00000111b
		ld		(ix+13),a
		or		a
		jp		nz,TROZOS_COMUNES_28
		ld		a,(ix+8)
		add		8
		ld		(ix+8),a
		cp		55*4
		jp		nc,TROZOS_COMUNES_29
        jp      TROZOS_COMUNES_28

CORVELLINIS:

.DEFINE_CORVELLINI_DERECHA:

        ld      a,b
		push	bc
        ld      hl,VALORES_BASICOS_CORVELLINI_4_DERECHA
        jp      .UNION_CORV

.DEFINE_CORVELLINI_IZQUIERDA:

        ld      a,b
		push	bc
        ld      hl,VALORES_BASICOS_CORVELLINI_4_IZQUIERDA
        jp      .UNION_CORV

.UNION_CORV:

		push	af
		xor		a
		ld		(MEGADEATH_ACTIVO),a
		pop		af

        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
		call	STANDAR_Y_FUERA_PANTALLA
		pop		bc
		ld		a,(ix+1)
		add		c
		ld		(ix+1),a

.COMUN_CORVELLINI:

        xor     a
        call    TROZOS_COMUNES_2

		push	af
		ld		a,(FASE)
		cp		4
		jp		nz,.COLOR_CORVELLINI_GENERAL

.COLOR_CORVELLINI_EN_STAGE_4:

		pop		af
		ld		hl,COLOR_CORVELLINI_S4    				; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.COLOR_CORVELLINI_GENERAL:

		pop		af
		ld		hl,COLOR_CORVELLINI     				; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.SECUENCIA_CORVELLINI:

.MIRAMOS_SU_FASE:

		ld		a,(ix+3)
		or		a
		jp		nz,.FASE_TRES

.CAMBIAMOS_LA_FASE_SI_ES_MENESTER:

		ld		a,(Y_DEPH)
		ld		b,a
		ld		a,(ix+1)
		cp		b
		jp		z,.FASE_DOS
		inc		a
		cp		b
		jp		z,.FASE_DOS
		sub		2
		cp		b
		jp		z,.FASE_DOS

.FASE_UNO:

        ld      a,(ix+10)
        inc     a
        and     00111111B
        ld      (ix+10),a

        cp      00000011B
        jp      c,.FOTOGRAMA_DOS

.FOTOGRAMA_UNO:

        ld      a,(ix+15)
        jp      .SALIENDO_CORVELLINI

.FOTOGRAMA_DOS:

        ld      a,(ix+15)
        add     8

.SALIENDO_CORVELLINI:

        ld      (ix+8),a

		ld		a,(ix)
		cp		250
		jp		nc,TROZOS_COMUNES_29
        jp      TROZOS_COMUNES_28

.FASE_DOS:

		ld		a,(X_DEPH)
		ld		b,a
		ld		a,(ix)
		cp		b
		jp		nc,.HACIA_IZQUIERDA

.HACIA_DERECHA:

		ld		a,1
		ld		(ix+3),a
		jp		.FASE_TRES

.HACIA_IZQUIERDA:

		ld		a,2
		ld		(ix+3),a

.FASE_TRES:

        ld      a,11
        ld      c,3
        call    A_31_DESDE_10

		ld		a,(ix+3)
		cp		1
		jp		nz,.REDUCE_X

.AUMENTA_X:

		ld		a,(ix)
		inc		a
		ld		(ix),a
		jp		.ULTIMO_FOTOGRAMA

.REDUCE_X:

		ld		a,(ix)
		dec		a
		ld		(ix),a

.ULTIMO_FOTOGRAMA:

		ld		a,(ix+3)
		cp		1
		jp		nz,.MIRA_IZQUIERDA

.MIRA_DERECHA:

       	ld      a,(ix+10)
        inc     a
        and     00000111B
        ld      (ix+10),a

        cp      00000011B
        jp      c,.FOTOGRAMA_D_CUATRO

.FOTOGRAMA_D_TRES:

        ld      a,58*4
		jp		.SALIENDO_CORVELLINI

.FOTOGRAMA_D_CUATRO:

        ld      a,60*4 
		jp		.SALIENDO_CORVELLINI

.MIRA_IZQUIERDA:

       	ld      a,(ix+10)
        inc     a
        and     00000111B
        ld      (ix+10),a

        cp      00000011B
        jp      c,.FOTOGRAMA_I_CUATRO

.FOTOGRAMA_I_TRES:

        ld      a,59*4
		jp		.SALIENDO_CORVELLINI

.FOTOGRAMA_I_CUATRO:

        ld      a,61*4 
		jp		.SALIENDO_CORVELLINI

GARGOLAS:

.DEFINE_GARGOLA:

        ld      a,b
        ld		hl,VALORES_BASICOS_GARGOLA

        call    STANDAR_LDIR_ENEMIGOS
		add		8
        ld      (ix),a
		ld		a,(ix+1)
		add		10
		ld		(ix+1),a

        call    TROZOS_COMUNES_1
		ld		hl,COLOR_COVID_1_1						; Damos color al sprite en la posición de sprite que le toca	
		jp      TROZOS_COMUNES_9

.SECUENCIA_GARGOLA:

.MIRAMOS_SI_DISPARA:

		ld		a,(ix+5)
		dec		a
		and		00111111b
		ld		(ix+5),a
		or		a
		jp		nz,.NO_DISPARA

.DISPARA:

		call	NUEVO_PROYECTIL_NORMAL

.NO_DISPARA:

		jp		TROZOS_COMUNES_28	

