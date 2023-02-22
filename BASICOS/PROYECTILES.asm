NUEVO_PROYECTIL:

		ld		a,(ARMA_USANDO)
		cp		3
		jp		c,.NUEVO_PROYECTIL_2
		cp		6
		jp		nc,.NUEVO_PROYECTIL_2

		ld		a,(FUEGO_QUE_TOCA)
		cp		1
		jp		nz,.NUEVO_PROYECTIL_3


.NUEVO_PROYECTIL_2:

		ld		a,(CADENCIA_DEL_DISPARO)			; Si no ha pasado el tiempo adecuado, no dispara
		or		a
		ret		nz

		ld		a,(ARMA_USANDO)						; En base al arma creamos la nueva cadencia

.NUEVO_PROYECTIL_3:

		ld		ix,TABLA_CADENCIA_DISPARO
		ld		e,a
		ld		d,0
		add		ix,de
		ld		a,(ix)
		ld		(CADENCIA_DEL_DISPARO),a
		
		push	ix

		ld		a,1									; Hasta que no soltemos el space, no volverá a disparar gracias a esto 
		ld		(TRIG_PULSADO),a

		ld		ix,PROYECTILES

.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO:

		ld		a,(ix+15)
		or		a
		jp		z,.seguimos_con_comparacion

		dec		a
		ld		(ix+15),a
		
.seguimos_con_comparacion:

		ld		a,(ix+2)
		cp		$FF
		jp		nz,.PASAMOS_A_LA_SIGUIENTE_POSICION
		
		ld		a,(ARMA_USANDO)
		ld		de,TABLA_DE_ARMA_O_ENEMIGO_A_DEFINIR								; DE hacer referencia a la tabla en sí
		jp		SITUAMOS_PUNTERO_EN_TABLA								; Con todos los datos definidos, nos vamos a la rutina que nos llevará al sitio adecuado		

.CAMBIA_VALORES_PUPA:

		ld		a,(ARMA_USANDO)
		sla		a
		ld		iy,TABLA_VARIACION_PUPA_ARMAS
		ld		e,a
		ld		d,0
		add		iy,de
		ld		a,(iy)
		ld		(ix+2),a
		ld		a,(iy+1)
		ld		(ix+3),a
		ret

.FX_ARMA:

		ld		c,2
        call    PAGE_31_A_SEGMENT_2
		call	ayFX_INIT
        jp    	PAGE_10_A_SEGMENT_2

.FLECHA:

		ld		hl,VALORES_BASICOS_FLECHA
		call	STANDAR_LDIR_ENEMIGOS
		call	.CAMBIA_VALORES_PUPA

		ld		a,(X_DEPH)
		add		2
		ld		(ix),a
		
		ld		a,(Y_DEPH)
		ld		(ix+1),a

        call	TROZOS_COMUNES_13
		ld		hl,COLOR_FLECHA											; Damos color al sprite en la posición de sprite que le toca	
		call	TROZOS_COMUNES_11
		xor		a
		call	.FX_ARMA
		jp		.NOS_VAMOS

.FUEGO:

		ld		a,(FUEGO_QUE_TOCA)
		inc		a
		and		00000011b
		or		a
		jp		nz,.FUEGO_2
		inc		a

.FUEGO_2:

		ld		(FUEGO_QUE_TOCA),a
		cp		2
		jp		z,.TOCA_FUEGO_2
		cp		3
		jp		z,.TOCA_FUEGO_3

.TOCA_FUEGO_1:

		xor		a
		ld		(TRIG_PULSADO),a
		ld		(CADENCIA_DEL_DISPARO),a

		ld		a,(X_DEPH)
		cp		225
		jp		nc,.NOS_VAMOS

		ld		hl,VALORES_BASICOS_FUEGO_DERECHA
		jp		.FUEGO_3

.TOCA_FUEGO_2:

		xor		a
		ld		(TRIG_PULSADO),a
		ld		(CADENCIA_DEL_DISPARO),a

		ld		hl,VALORES_BASICOS_FUEGO
		jp		.FUEGO_3

.TOCA_FUEGO_3:

		ld		a,(ARMA_USANDO)
		cp		3
		jp		nz,.TOCA_FUEGO_3_2

.TOCA_FUEGO_3_1:

		ld		a,40

.TOCA_FUEGO_3_2

		ld		(CADENCIA_DEL_DISPARO),a

		ld		hl,VALORES_BASICOS_FUEGO_IZQUIERDA

		ld		a,(X_DEPH)
		cp		10
		jp		c,.NOS_VAMOS

.FUEGO_3:

		ld		a,2
		call	.FX_ARMA

		call	STANDAR_LDIR_ENEMIGOS
		call	.CAMBIA_VALORES_PUPA

		ld		b,(ix)
		ld		a,(X_DEPH)
		add		b
		ld		(ix),a

		ld		b,(ix+1)
		ld		a,(Y_DEPH)
		add		b
		ld		(ix+1),a

        call	TROZOS_COMUNES_13
		ld		hl,COLOR_BOLA_FUEGO										; Damos color al sprite en la posición de sprite que le toca	
		call	TROZOS_COMUNES_11
		ld		de,16
		add		ix,de
		call	PAGE_10_A_SEGMENT_2

		jp		.NOS_VAMOS
		
.HACHA:

		ld		hl,VALORES_BASICOS_HACHA
		call	STANDAR_LDIR_ENEMIGOS	
		call	.CAMBIA_VALORES_PUPA

		ld		a,(X_DEPH)
		add		8
		ld		(ix),a
		
		ld		a,(Y_DEPH)
		sub		4
		ld		(ix+1),a

        call	TROZOS_COMUNES_13
		ld		hl,COLOR_HACHA_1										; Damos color al sprite en la posición de sprite que le toca	
		call	PON_COLOR_2
		jp		.NOS_VAMOS

.NOS_VAMOS:

		pop		ix
		
		ret

.PASAMOS_A_LA_SIGUIENTE_POSICION:

		ld		de,16
		add		ix,de
		ld		hl,VARIABLE_UN_USO
		push	ix
		pop		de
		call	XOR_Z_RAM
		jp		z,.NOS_VAMOS
		jp		.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO
		
SECUENCIA_PROYECTILES_Y_ENEMIGOS:
		
		push	ix
		
		ld		ix,ENEMIGOS

.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO:
		
		ld		a,(ix+2)
		cp		$FF
		jp		z,.PASAMOS_A_LA_SIGUIENTE_POSICION
		
		ld		a,(ix+6)
		call	PUNTERO_EN_TABLA_SIN_DE
		
		dw		SECUENCIA_PROYECTILES_Y_ENEMIGOS.FLECHA_FRENTE_FUEGO_FRENTE		; 0
		dw		SECUENCIA_PROYECTILES_Y_ENEMIGOS.FUEGO_IZQUIERDA_1				; 1
		dw		SECUENCIA_PROYECTILES_Y_ENEMIGOS.FUEGO_DERECHA_1				; 2
		dw		SECUENCIA_PROYECTILES_Y_ENEMIGOS.HACHA_1						; 3
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_SKRULLEX					; 4
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_PREMIO						; 5	
		dw		SECUENCIA_PROYECTILES_Y_ENEMIGOS.HACHA_2						; 6							
		dw		SECUENCIA_PROYECTILES_Y_ENEMIGOS.HACHA_3						; 7
		dw		COVIDS.SECUENCIA_COVID											; 8
		dw		COVIDS.SECUENCIA_COVID_CORTO									; 9	
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_EXPLOSION					; 10
		dw		SLIMES.SECUENCIA_SLIME_ABAJO									; 11
		dw		SLIMES.SECUENCIA_SLIME_DERECHA									; 12
		dw		SLIMES.SECUENCIA_SLIME_QUIETO									; 13
		dw		SLIMES.SECUENCIA_SLIME_IZQUIERDA								; 14								
		dw		SLIMES.SECUENCIA_SLIME_BLANCO_HACIA_DEPH						; 15
		dw		CORVELLINIS.SECUENCIA_CORVELLINI 								; 16
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_PROYECTIL_NORMAL			; 17
		dw		ECTO_PALLERS.SECUENCIA_ECTO_PALLERS_TOCA_HUEVOS					; 33
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_CHECK_POINT				; 19
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_LETRA						; 20
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_CORAZON					; 21
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_ALFONSERRYX_NE				; 22
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_ALFONSERRYX_NO				; 23
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_ALFONSERRYX_SE				; 24
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_ALFONSERRYX_SO				; 25
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_MEGADEATH					; 26
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.SECUENCIA_MEGADEATH_CABEZA			; 27
		dw		COVIDS.SECUENCIA_COVID_ABAJO									; 28
		dw		SECUENCIAS_DE_LOS_ENEMIGOS.LETRAS_DE_AVISO						; 29
		dw		ECTO_PALLERS.SECUENCIA_ECTO_PALLER_CIRCLE						; 30		
		dw		SLIMES.SECUENCIA_SLIME_RONDA									; 31	
		dw		FIREWORKS.SECUENCIA_FIREWORKS									; 32
		dw		GARGOLAS.SECUENCIA_GARGOLA										; 33

.FLECHA_FRENTE_FUEGO_FRENTE:

		call	.COMUN_TRES_FUEGOS
		jp		TROZOS_COMUNES_28

.FUEGO_IZQUIERDA_1:

		call	.COMUN_TRES_FUEGOS

		ld		a,(ix)
		dec		a
		ld		(ix),a

		cp		10
		jp		c,TROZOS_COMUNES_29

		jp		TROZOS_COMUNES_28

.FUEGO_DERECHA_1:

		call	.COMUN_TRES_FUEGOS

		ld		a,(ix)
		inc		a
		ld		(ix),a

		cp		240
		jp		nc,TROZOS_COMUNES_29

		jp		TROZOS_COMUNES_28

.COMUN_TRES_FUEGOS:

		ld		a,(ix+11)
		ld		b,a
		ld		a,(ix+1)
		sub		b
		ld		(ix+1),a
		ret

.HACHA_1:
.HACHA_2:
.HACHA_3:

		push	ix

        call    PAGE_31_A_SEGMENT_2
		ld		a,1
		ld		c,3
		call	ayFX_INIT
        call    PAGE_10_A_SEGMENT_2

		ld		a,(ARMA_USANDO)
		cp		7
		jp		z,.carga_parabola_2
		cp		8
		jp		z,.carga_parabola_3

.carga_parabola_1:

		ld		a,(ix+10)
		ld		ix,TABLA_PARABOLA_HACHA_1
		jp		.seguimos_cargando

.carga_parabola_2:

		ld		a,(ix+10)
		ld		ix,TABLA_PARABOLA_HACHA_2
		jp		.seguimos_cargando

.carga_parabola_3:

		ld		a,(ix+10)
		ld		ix,TABLA_PARABOLA_HACHA_3

.seguimos_cargando:

		add		a,a
		ld		e,a
		ld		d,0
		add		ix,de
		ld		a,(ix)
		ld		h,a
		ld		a,(ix+1)
		ld		l,a
		pop		ix

		ld		a,(ARMA_USANDO)
		cp		8
		jp		z,.rectifica_x_hacha_3

.rectifica_x_hacha_1:

		ld		a,(X_DEPH)
		sub		30
		jp		.termina_rectificacion_x

.rectifica_x_hacha_3:

		ld		a,(X_DEPH)
		sub		60

.termina_rectificacion_x:

		ld		b,a
		ld		a,h
		add		b
		ld		(ix),a
		ld		a,(ARMA_USANDO)
		cp		7
		jp		nc,.rectifica_y_hacha_3

.rectifica_y_hacha_1:

		ld		a,(Y_DEPH)
		sub		34
		jp		.termina_rectificacion_y

.rectifica_y_hacha_3:

		ld		a,(Y_DEPH)
		sub		68

.termina_rectificacion_y:

		ld		b,a
		ld		a,l
		add		b
		ld		(ix+1),a		
		ld		a,(ix+10)
		inc		a
		ld		(ix+10),a

		LD		a,(ix+9)
		cp		8
		jp		nc,.SEGUNDO_FOTOGRAMA
		
.PRIMER_FOTOGRAMA:

		ld		a,164
		ld		(ix+8),a
		jp		.MIRAMOS_SI_ESTA_FUERA_DE_LIMITES
				
.SEGUNDO_FOTOGRAMA:

		ld		a,168
		ld		(ix+8),a

.MIRAMOS_SI_ESTA_FUERA_DE_LIMITES:

		ld		a,(ix+10)
		cp		45
		jp		c,.cuidado_con_la_derecha

.cuidado_con_la_izquierda:

		ld		a,(ix)
		cp		250
		jp		c,.MIRAMOS_SI_DESAPARECE_EL_HACHA

		jp		.DESAPARECE

.cuidado_con_la_derecha:

		ld		a,(ix)
		cp		2
		jp		c,.DESAPARECE
				
.MIRAMOS_SI_DESAPARECE_EL_HACHA:

		ld		a,(ix+9)
		inc		a
		and		00001111B
		ld		(ix+9),a
		ld		a,(ix+10)
		cp		90
		jp		nz,.PASAMOS_A_LA_SIGUIENTE_POSICION

.DESAPARECE:
		
        call    STANDARD_DEJA_LIBRE_EL_SPRITE
						
.PASAMOS_A_LA_SIGUIENTE_POSICION:

		ld		de,16
		add		ix,de
		ld		hl,VARIABLE_UN_USO
		push	ix
		pop		de
		call	XOR_Z_RAM
		jp		z,.NOS_VAMOS
		jp		.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO
		
.NOS_VAMOS:

		pop		ix
		
		ret
		
PINTA_PROYECTILES_ENEMIGOS:

		push	ix
		
		ld		ix,ENEMIGOS

.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO:
		
		ld		a,(ix+2)								; Si su byte 3 es 255 significa que no hay que pintarlo
		cp		$FF
		jp		z,.PASAMOS_A_LA_SIGUIENTE_POSICION

		ld		a,(ix+1)								; Si está en la linea 216, lo pasaremos a la 217 para que no se oculte él y los siguientes
		cp		216
		jp		nz,.pintando_1

		ld		a,217
		ld		(ix+1),a

.pintando_1:

		call	.PINTADO_DE_SPRITE

		ld		a,(ix+8)
		or		a
		jp		z,.VAMOS_TERMINANDO_EL_CICLO

		cp		25*4
		jp		z,.pintando_2
		cp		37*4
		jp		nz,.pintando_3

.pintando_2:

		ld		a,(CHECKPOINT_ACTIVO)
		or		a
		jp		nz,.DOBLETE

.pintando_3:

		cp		35*4
		jp		nz,.pintando_4

		ld		a,(CORAZON_ACTIVO)
		or		a
		jp		nz,.DOBLETE

.pintando_4:

		ld		a,(ix+8)
		cp		46*4
		jp		c,.PASAMOS_A_LA_SIGUIENTE_POSICION
		
		ld		a,(FASE)
		cp		2
		jp		z,.medidas_2_5
		cp		5
		jp		z,.medidas_2_5

.medidas_1_4:

		ld		a,(ix+8)
		cp		54*4
		jp		c,.DOBLETE
		jp		.PASAMOS_A_LA_SIGUIENTE_POSICION

.medidas_2_5:

		ld		a,(ix+8)
		cp		60*4
		jp		c,.DOBLETE
		jp		.PASAMOS_A_LA_SIGUIENTE_POSICION

.DOBLETE:

		ld		a,(ix+8)
		add		4
		ld		(iy+2),a

		call	PATRONES_SPRITE_SECUNDARIO

		jp		.PASAMOS_A_LA_SIGUIENTE_POSICION

.PINTADO_DE_SPRITE:

		ld		iy,PROPIEDADES_PATRON_SPRITE
		ld		a,(ix+1)
		ld		(iy),a
		ld		a,(ix)
		ld		(iy+1),a
		ld		a,(ix+8)
		ld		(iy+2),a

		ld		e,(ix+12)
		ld		d,0
		ld		hl,#4A00												; Depositamos los sprites en vram	
		or		a
		adc		hl,de
		ex		de,hl
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		bc,3
		jp		PON_COLOR_2.sin_bc_impuesta

.VAMOS_TERMINANDO_EL_CICLO:

		ld		a,$FF
		ld		(ix+2),a
		ld		(ix),a
		ld		a,(DEJA_EL_SPRITE)
		add		16
		ld		(DEJA_EL_SPRITE),a
		ld		(ix+1),a

		call	.PINTADO_DE_SPRITE

		ld		a,(ix+3)
		cp		7
		jp		c,.PASAMOS_A_LA_SIGUIENTE_POSICION

		ld		iy,PROPIEDADES_PATRON_SPRITE
		xor		a
		ld		(iy+2),a

		call	PATRONES_SPRITE_SECUNDARIO

.PASAMOS_A_LA_SIGUIENTE_POSICION:

		ld		de,16
		add		ix,de
		ld		hl,VARIABLE_UN_USO
		push	ix
		pop		de
		call	XOR_Z_RAM
		jp		z,.NOS_VAMOS
		jp		.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO
		
.NOS_VAMOS:

		pop		ix
		
		ret
		
MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE:

		push	ix
		ld		a,10
		ld		(SPRITE_QUE_TOCA),a	

MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE_BUCLE:

		ld		ix,SPRITES_ACTIVOS
		ld		a,(SPRITE_QUE_TOCA)
		sub		10
		ld		e,a
		ld		d,0
		add		ix,de
		ld		a,(ix)
		or		a
		jp		z,.OCUPAMOS_EL_SPRITE
		ld		a,(SPRITE_QUE_TOCA)
		inc		a
		ld		(SPRITE_QUE_TOCA),a
		cp		32
		jp		c,MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE_BUCLE
		pop		ix	
		pop		af
		ld		a,(MIRAMOS_SEGUNDO_SPRITE)
		or		a
		jp		z,NUEVO_PROYECTIL.NOS_VAMOS

        ld      a,(ix+12)
        call    DEJA_LIBRE_SPRITE_EN_RAM
		xor		a
		ld		(ix+12),a
		jp		NUEVO_PROYECTIL.NOS_VAMOS

.OCUPAMOS_EL_SPRITE:

		ld		a,1
		ld		(ix),a
		pop		ix
		ret	

DEJA_LIBRE_SPRITE_EN_RAM:

		or		a
	[2]	rrc		a
		sub		10
		push	ix
		ld		ix,SPRITES_ACTIVOS
		ld		e,a
		ld		d,0
		add		ix,de
		xor		a
		ld		(ix),a
		pop		ix
		
		ret

APARTAMOS_SPRITES_QUE_MOLESTAN:

		push	ix
		push	iy
		
		ld		b,19

.bucle_molestias:

		ld		iy,SPRITES_ACTIVOS
		ld		a,b
		dec		a
		ld		e,a
		ld		d,0
		add		iy,de
		call	.quitamos_de_en_medio
		djnz	.bucle_molestias

.saliendo_de_la_rutina:

		pop		iy
		pop		ix
		ret

.quitamos_de_en_medio:

		ld		hl,#4A00+(4*10)
		or		a
	[4]	adc		hl,de
		ex		de,hl
		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		add		50
		cp		216
		jp		nz,.quitamos_de_en_medio_2

		ld		a,217

.quitamos_de_en_medio_2:

		ld		(PROPIEDADES_PATRON_SPRITE),a
		ld		hl,PROPIEDADES_PATRON_SPRITE
		push	bc
		ld		bc,1
		call	PON_COLOR_2.sin_bc_impuesta
		pop		bc
		
		ret

CALCULAMOS_PROYECTILES_ENEMIGOS:

.calcula_la_y_falsa:

		ld		a,(PUNTO_DEL_SCROLL)
		ld		b,a
		ld		a,(Y_DEPH)
		sub		b
		add		16
		ld		(Y_FALSA_PARA_DEPH),a
		ld		a,(ix+1)
		sub		b
		add		8
		ld		(Y_FALSA_PARA_PROYECTILES),a
		ld		a,(X_DEPH)
		add		10
		ld		(X_FALSA_PARA_DEPH),a
		ld		a,(ix)
		add		8
		ld		(X_FALSA_PARA_PROYECTILES),a

.primer_calculo:

		ld		a,(X_FALSA_PARA_PROYECTILES)
		ld		b,a
		ld		a,(X_FALSA_PARA_DEPH)
		add		3
		cp		b
		jp		c,.p3
		sub		5
		cp		b		
		jp		nc,.p2

.p1:

		call	.rutina_de_comparacion_ys
		jp		c,.p1_1
		jp		nc,.p1_2

.p1_1:

		xor		a
		ret

.p1_2:

		ld		a,36
		ret

.p2:

		ld		a,(Y_FALSA_PARA_PROYECTILES)
		ld		b,a
		ld		a,(Y_FALSA_PARA_DEPH)
		add		11
		cp		b
		jp		c,.p2_3
		sub		21
		cp		b		
		jp		nc,.p2_2

.p2_1:

		ld		a,18
		ret

.p2_2:

		call	.rutina_de_comparacion_xb_menos_xa_yb_menos_ya
		jp		z,.p2_2_1
		jp		nc,.p2_2_2
		jp		c,.p2_2_3

.p2_2_1:

		ld		a,27
		ret

.p2_2_2:

		call	.rutina_de_comparacion_yb_menos_ya_xb_menos_xa_entre_dos
		jp		c,.p2_2_2_1
		jp		nc,.p2_2_2_2

.p2_2_2_1:

		ld		a,21
		ret


.p2_2_2_2:

		ld		a,24
		ret

.p2_2_3:

		call	.rutina_de_comparacion_yb_menos_ya_xb_menos_xa_entre_dos
		jp		c,.p2_2_3_1
		jp		nc,.p2_2_3_2

.p2_2_3_1:

		ld		a,30
		ret

.p2_2_3_2:

		ld		a,33
		ret

.p2_3:

		call	.rutina_de_comparacion_xb_menos_xa_ya_menos_yb
		jp		z,.p2_3_1
		jp		nc,.p2_3_2
		jp		c,.p2_3_3

.p2_3_1:

		ld		a,9
		ret

.p2_3_2:

		call	.rutina_de_comparacion_ya_menos_yb_xb_menos_xa_entre_dos
		jp		c,.p2_3_2_1
		jp		nc,.p2_3_2_2

.p2_3_2_1:

		ld		a,15
		ret

.p2_3_2_2:

		ld		a,12
		ret

.p2_3_3:

		call	.rutina_de_comparacion_ya_menos_yb_xb_menos_xa_entre_dos
		jp		c,.p2_3_3_1
		jp		nc,.p2_3_3_2

.p2_3_3_1:

		ld		a,6
		ret

.p2_3_3_2:

		ld		a,3
		ret

.p3:

		ld		a,(Y_FALSA_PARA_PROYECTILES)
		ld		b,a
		ld		a,(Y_FALSA_PARA_DEPH)
		add		11
		cp		b
		jp		c,.p3_3
		sub		21
		cp		b		
		jp		nc,.p3_2

.p3_1:

		ld		a,54
		ret

.p3_2:

		call	.rutina_de_comparacion_xa_menos_xb_yb_menos_ya
		jp		z,.p3_2_1
		jp		nc,.p3_2_2
		jp		c,.p3_2_3

.p3_2_1:

		ld		a,45
		ret

.p3_2_2:

		call	.rutina_de_comparacion_yb_menos_ya_xa_menos_xb_entre_dos
		jp		c,.p3_2_2_1
		jp		nc,.p3_2_2_2

.p3_2_2_1:

		ld		a,51
		ret

.p3_2_2_2:

		ld		a,48
		ret

.p3_2_3:

		call	.rutina_de_comparacion_yb_menos_ya_xb_menos_xa_entre_dos
		jp		c,.p3_2_3_1
		jp		nc,.p3_2_3_2

.p3_2_3_1:

		ld		a,42
		ret

.p3_2_3_2:

		ld		a,39
		ret

.p3_3:

		call	.rutina_de_comparacion_xa_menos_xb_ya_menos_yb
		jp		z,.p3_3_1
		jp		nc,.p3_3_2
		jp		c,.p3_3_3

.p3_3_1:

		ld		a,63
		ret

.p3_3_2:

		call	.rutina_de_comparacion_ya_menos_yb_xa_menos_xb_entre_dos
		jp		c,.p3_3_2_1
		jp		nc,.p3_3_2_2

.p3_3_2_1:

		ld		a,57
		ret

.p3_3_2_2:

		ld		a,60
		ret

.p3_3_3:

		call	.rutina_de_comparacion_ya_menos_yb_xb_menos_xa_entre_dos
		jp		c,.p3_3_3_1
		jp		nc,.p3_3_3_2

.p3_3_3_1:

		ld		a,66
		ret

.p3_3_3_2:

		ld		a,69
		ret

.rutina_de_comparacion_ys:

		ld		a,(Y_FALSA_PARA_PROYECTILES)
		ld		b,a
		ld		a,(Y_FALSA_PARA_DEPH)
		cp		b
		ret

.rutina_de_comparacion_yb_menos_ya_xb_menos_xa_entre_dos:

		call	.rutina_xb_menos_xa
		srl		a	
		push	af
		call	.rutina_yb_menos_ya
		pop		bc
		cp		b
		ret

.rutina_de_comparacion_ya_menos_yb_xb_menos_xa_entre_dos:

		call	.rutina_xb_menos_xa
		srl		a	
		push	af
		call	.rutina_ya_menos_yb
		pop		bc
		cp		b
		ret

.rutina_de_comparacion_yb_menos_ya_xa_menos_xb_entre_dos:

		call	.rutina_xa_menos_xb
		srl		a	
		push	af
		call	.rutina_yb_menos_ya
		pop		bc
		cp		b
		ret

.rutina_de_comparacion_ya_menos_yb_xa_menos_xb_entre_dos:

		call	.rutina_xa_menos_xb
		srl		a	
		push	af
		call	.rutina_ya_menos_yb
		pop		bc
		cp		b
		ret

.rutina_de_comparacion_xb_menos_xa_yb_menos_ya:

		call	.rutina_yb_menos_ya
		push	af
		call	.rutina_xb_menos_xa
		pop		bc
		cp		b
		
		ret

.rutina_de_comparacion_xb_menos_xa_ya_menos_yb:

		call	.rutina_ya_menos_yb
		push	af
		call	.rutina_xb_menos_xa
		pop		bc
		cp		b
		
		ret

.rutina_de_comparacion_xa_menos_xb_yb_menos_ya:

		call	.rutina_yb_menos_ya
		push	af
		call	.rutina_xa_menos_xb
		pop		bc
		cp		b
		
		ret

.rutina_de_comparacion_xa_menos_xb_ya_menos_yb:

		call	.rutina_ya_menos_yb
		push	af
		call	.rutina_xa_menos_xb
		pop		bc
		cp		b
		
		ret

.rutina_xb_menos_xa:

		ld		a,(X_FALSA_PARA_PROYECTILES)
		ld		b,a
		ld		a,(X_FALSA_PARA_DEPH)
		sub		b
		ret

.rutina_xa_menos_xb:

		ld		a,(X_FALSA_PARA_DEPH)
		ld		b,a
		ld		a,(X_FALSA_PARA_PROYECTILES)
		sub		b
		ret

.rutina_yb_menos_ya:

		ld		a,(Y_FALSA_PARA_PROYECTILES)
		ld		b,a
		ld		a,(Y_FALSA_PARA_DEPH)
		sub		b
		ret

.rutina_ya_menos_yb:

		ld		a,(Y_FALSA_PARA_DEPH)
		ld		b,a
		ld		a,(Y_FALSA_PARA_PROYECTILES)
		sub		b
		ret

MAGIA:

.MIRAMOS_SI_PUEDE_HACER_MAGIA:

		ld		a,(PUNTO_DEL_SCROLL)
		cp		#b7
		ret		z
		cp		#a3
		ret		z		
		or		a
		ret		z
		cp		255
		ret		z
		cp		#8f
		ret		z
		
		ld		a,(MAGIAS)
		or		a
		ret		z

		dec		a
		ld		(MAGIAS),a ;recuperar para que no tenga infinita magia

		di															; Paramos la música
		call	hltmus
		ei

        call    PAGE_31_A_SEGMENT_2
		ld		a,13
		ld		c,0
		call	ayFX_INIT
        call    PAGE_10_A_SEGMENT_2

.ANIMACION:

		ld		a,(ESTADO_MARCADOR)
		ld		(VARIABLE_UN_USO3),a
		
		xor		a
		ld		(ESTADO_MARCADOR),a
		
        ld      a,1
        ld      (TIEMPO_DE_ADJUST),a

		push	iy
		push	ix
		
.PALETA_A_GRISES:

		ld		a,(ESTADO_COLOR_PERM)
		push	af
		call	BUCLE_PINTA_TILES.PINTA_PALETA_GRIS

.VUELCA_TROZOS_DE_DOS_1:

        ld      hl,COPIA_PARTE_1_DE_DOS_A_TRES_PARA_RAYO
 		call	.BUCLE_PARA_INICAR_DATOS_A_COPIAR
		or		a
		jp		z,.TROZO_1_EN_DOS_PIEZAS
		cp		255-112
		jp		c,.TROZO_1_EN_UNA_PIEZA
		JP		.TROZO_1_EN_DOS_PIEZAS

.BUCLE_PARA_CORREGIR_LA_Y_DE_2:

		ld		e,a
		ld		d,0
		ld		l,(ix+2)
		ld		h,(ix+3)
		or		a
		adc		hl,de
		ld		(ix+2),l
		ld		(ix+3),h

		ret

.BUCLE_DE_COPIA_DE_DATOS_SALVADOS:
        ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
		call	NOP_50
		jp    	DOCOPY

.BUCLE_PARA_INICAR_DATOS_A_COPIAR:

 		ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS	       
		ld		bc,15
		ldir

        ld      ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS

		ld		a,(PUNTO_DEL_SCROLL)

		ret

.COMUN_DE_TROZOS_1:

		ld		(VARIABLE_UN_USO2),a
		ld		e,a
		ld		d,0
		ld		hl,#0200
		or		a
		adc		hl,de

		ld		(ix+2),l
		ld		(ix+3),h

		ld		a,(VARIABLE_UN_USO2)
		ld		b,a
		ld		a,255
		sub		b
		ld		(VARIABLE_UN_USO2),a
		ld		c,0
		ld		(ix+10),a
		ld		(ix+11),c
		
		call	.BUCLE_DE_COPIA_DE_DATOS_SALVADOS
		ld		hl,#200

		ld		(ix+2),l
		ld		(ix+3),h

		ld		a,(VARIABLE_UN_USO2)
		ld		b,a
		ld		a,(VARIABLE_UN_USO)
		sub		b
		ld		c,0
		ld		(ix+10),a
		ld		(ix+11),c
		ld		e,b
		ld		d,0
		ld		hl,#300
		or		a
		adc		hl,de
		ld		(ix+6),l
		ld		(ix+7),h

		ret

.TROZO_1_EN_DOS_PIEZAS:

		push	af
		ld		a,112
		ld		(VARIABLE_UN_USO),a
		pop		af
		call	.COMUN_DE_TROZOS_1
		jp		.COPIA_FINAL_PRIMERA_COPIA

.TROZO_1_EN_UNA_PIEZA:

		call	.BUCLE_PARA_CORREGIR_LA_Y_DE_2

.COPIA_FINAL_PRIMERA_COPIA:

		call    .BUCLE_DE_COPIA_DE_DATOS_SALVADOS

.VUELCA_TROZOS_DE_DOS_2:

        ld      hl,COPIA_PARTE_2_DE_DOS_A_TRES_PARA_RAYO
 		call	.BUCLE_PARA_INICAR_DATOS_A_COPIAR
		or		a
		jp		z,.TROZO_2_EN_DOS_PIEZAS
		cp		255-72
		jp		c,.TROZO_2_EN_UNA_PIEZA

.TROZO_2_EN_DOS_PIEZAS:

		push	af
		ld		a,72
		ld		(VARIABLE_UN_USO),a
		pop		af
		call	.COMUN_DE_TROZOS_1
		jp		.COPIA_FINAL_SEGUNDA_COPIA

.TROZO_2_EN_UNA_PIEZA:

		call	.BUCLE_PARA_CORREGIR_LA_Y_DE_2

.COPIA_FINAL_SEGUNDA_COPIA:

		call    .BUCLE_DE_COPIA_DE_DATOS_SALVADOS

.VUELCA_TROZOS_DE_DOS_3:

        ld      hl,COPIA_PARTE_3_DE_DOS_A_TRES_PARA_RAYO
 		call	.BUCLE_PARA_INICAR_DATOS_A_COPIAR
		or		a
		jp		z,.TROZO_1_EN_DOS_PIEZAS
		cp		255-92
		jp		c,.TROZO_3_EN_UNA_PIEZA
		JP		.TROZO_3_EN_DOS_PIEZAS

.TROZO_3_EN_DOS_PIEZAS:

		push	af
		ld		a,92
		ld		(VARIABLE_UN_USO),a
		pop		af
		call	.COMUN_DE_TROZOS_1
		jp		.COPIA_FINAL_TERCERA_COPIA

.TROZO_3_EN_UNA_PIEZA:

		call	.BUCLE_PARA_CORREGIR_LA_Y_DE_2

.COPIA_FINAL_TERCERA_COPIA:

		call    .BUCLE_DE_COPIA_DE_DATOS_SALVADOS

.RESTO_DE_COPIAS:

		ld		hl,COPIA_1_A_2

		ld		b,9
		
.bucle_de_copys_1:

		push	bc
		call	NOP_50
		call	DOCOPY
		pop		bc
		djnz	.bucle_de_copys_1

.VUELCA_RAYOS_EN_TRES:

		ld		hl,COPIA_RAYOS_A_VRAM
		ld		de,RAYOS_EN_PACK
		call	PAGE_32_A_SEGMENT_2
		call	HMMC
		call	PAGE_10_A_SEGMENT_2

.COPIA_RAYOS_EN_FOTOGRAMAS_ADECUADOS_Y_ANIMACION:

		ld		hl,COPIA_RAYOS_A_1
		call	NOP_50
		call	DOCOPY
		call	NOP_50
		call	DOCOPY
		call	NOP_50
		call	DOCOPY

        xor      a
        ld      (TIEMPO_DE_ADJUST),a

		ld		b,2

.bucle_de_copys_3:

		push	bc
		ld		hl,COPIA_RAYO_1_1
		ld		ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
		ld		b,15

.bucle_de_copys_2:

		push	bc
		push	hl
		ld		de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
		ld		bc,15
		ldir

		pop		hl
		push	ix
		push	hl
		pop		ix
		ld		a,(ix+10)
		ld		b,a
		ld		a,255
		sub		b
		ld		b,a
		ld		a,(PUNTO_DEL_SCROLL)
		cp		b
		pop		ix
		push	hl
		jp		nc,.RAYOS_EN_DOS

.RAYOS_EN_UNO:

		call	.standard_destino_y
		ld		hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
		call	NOP_50
		call	DOCOPY
		
.regreso_de_bucle:

		pop		hl
		ld		de,15
		or		a
		adc		hl,de

		ld		a,5
		call	BUCLE_PINTA_TILES.rutina_de_pausa

		pop		bc

		ld		a,b
		cp		7
		jp		nz,.sin_cambio_en_Adjust

        ld      a,1
        ld      (TIEMPO_DE_ADJUST),a		

.sin_cambio_en_Adjust:

		djnz	.bucle_de_copys_2

		pop		bc
		djnz	.bucle_de_copys_3

		jp		.LOS_ANULAMOS

.RAYOS_EN_DOS:

; corrije destino y
		call	.standard_destino_y
; corrige alto y
		ld		b,a
		ld		a,255
		sub		b
		ld		l,a
		ld		h,0
		call	.marca_alto_y
		push	hl
; copia
		ld		hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
		call	NOP_50
		call	DOCOPY

; corrige alto y 2
		pop		de
		pop		iy
		push	iy
		push	de
		ld		a,(iy+10)
		ld		l,a
		ld		h,0
		or		a
		sbc		hl,de
		call	.marca_alto_y
; corrige destino y 2
		ld		hl,#200
		call	.marca_destino_y
;corrige origen y 2
		pop		de
		ld		hl,#300
		or		a
		adc		hl,de
		call	.marca_origen_y	
; copia

		call	NOP_50

		ld		hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
		call	DOCOPY

		jp		.regreso_de_bucle

.standard_destino_y:

		ld		a,(PUNTO_DEL_SCROLL)
		ld		e,a
		ld		d,0
		ld		hl,#200
		or		a
		adc		hl,de
		jp		.marca_destino_y

.marca_origen_y:

		ld		(ix+2),l
		ld		(ix+3),h	
		ret

.marca_destino_y:
		
		ld		(ix+6),l
		ld		(ix+7),h
		ret

.marca_alto_y:

		ld		(ix+10),l
		ld		(ix+11),h
		ret

.LOS_ANULAMOS:

		ld		ix,ENEMIGOS
		ld		b,10

.bucle_anulacion_magia:

		push	bc
		ld		a,(ix+8)

; ¿Se convierte en premio?

		cp		46*4
		jp		z,.es_premio
		cp		48*4
		jp		nz,.mas_miramientos_1

.es_premio:

        call    UN_NUEVO_ENEMIGO.DEFINE_PREMIO_1
		jp		.avanzamos

.mas_miramientos_1:

; ¿Es inmortal?

		jp		c,.avanzamos

; ¿Es ecto?

		cp		50*4
		jp		z,.es_ecto_o_no
		cp		52*4
		jp		nz,.eliminando

.es_ecto_o_no:

		ld		a,(ECTOPALLERS_ACTIVO)
		or		a
		jp		nz,.avanzamos		

.eliminando:

		xor		a
		ld		(ix+2),a
		call	UN_NUEVO_ENEMIGO.DEFINE_EXPLOSION

.avanzamos:

		ld		de,16
		add		ix,de
		pop		bc   
		djnz	.bucle_anulacion_magia

.repintamos_puntos_de_magia:

		call	PINTAMOS_LOS_PUNTOS_DE_MAGIA
       	ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2
		di
		call	cntmus
		ei

        ld		a,10
		call	CHANGE_BANK_2

.VUELVE_A_PINTAR_TRES_EN_NEGRO:

		call	NOP_50

        ld      hl,COPIA_NEGRO_EN_3
    [2] call    DOCOPY

		ld		a,(VARIABLE_UN_USO3)
		or		a
		jp		z,.final
		
		ld		a,1
		ld		(ESTADO_MARCADOR),a
		
.final:

		pop		af
		ld		(ESTADO_COLOR_PERM),a

		ld		hl,50
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

		pop		ix
		pop		iy
		ret

PATRONES_SPRITE_SECUNDARIO:

        ld      a,(ix+3)
		ld		e,a
		ld		d,0
        ld		hl,#4A00		                                                        ; Depositamos los sprites en vram	
		or		a
		adc		hl,de
		ex		de,hl
		ld		hl,PROPIEDADES_PATRON_SPRITE
		ld		bc,3
		jp		PON_COLOR_2.sin_bc_impuesta

DIRECCIONES_DE_PROYECTIL:

        ld      a,(ix+3)
        push    iy
        ld      iy,TABLA_DE_DIRECCIONES_DE_PROYECTILES
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(ix+5)
        ld      e,a
        ld      d,0
        add     iy,de
        ld      a,(iy)
        pop     iy
		ret

LIBERA_DOS_SPRITES:

        call    STANDARD_DEJA_LIBRE_EL_SPRITE
SOLO_EL_SEGUNDO:

        ld      a,(ix+3)
        jp    	DEJA_LIBRE_SPRITE_EN_RAM

NOP_50;

		push	bc
		ld		b,200
.bucle:

		nop
		djnz	.bucle
		pop		bc
		ret
