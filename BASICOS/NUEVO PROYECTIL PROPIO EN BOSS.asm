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
		ld		de,.TABLA_DE_ARMA_O_ENEMIGO_A_DEFINIR								; DE hacer referencia a la tabla en sí
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

	ld	c,2
        call    PAGE_31_A_SEGMENT_2
	call	ayFX_INIT
        jp      TIRA_FX


.FLECHA:

	ld		hl,VALORES_BASICOS_FLECHA
	call	.STANDAR_LDIR_ENEMIGOS
	call	.CAMBIA_VALORES_PUPA

	ld		a,(X_DEPH)
	add		2
	ld		(ix),a
		
	ld		a,(Y_DEPH)
	ld		(ix+1),a

        call	.TROZOS_COMUNES_13
	ld		hl,COLOR_FLECHA											; Damos color al sprite en la posición de sprite que le toca	
	call	.TROZOS_COMUNES_11
	xor		a
	call	.FX_ARMA
	jp		.NOS_VAMOS

.FUEGO:

	ld	a,(FUEGO_QUE_TOCA)
	inc	a
	and	00000011b
	or	a
	jp	nz,.FUEGO_2
	inc	a

.FUEGO_2:

	ld	(FUEGO_QUE_TOCA),a
	cp	2
	jp	z,.TOCA_FUEGO_2
	cp	3
	jp	z,.TOCA_FUEGO_3

.TOCA_FUEGO_1:

	xor	a
	ld	(TRIG_PULSADO),a
	ld	(CADENCIA_DEL_DISPARO),a

	ld	a,(X_DEPH)
	cp	225
	jp	nc,.NOS_VAMOS

	ld	hl,VALORES_BASICOS_FUEGO_DERECHA
	jp	.FUEGO_3

.TOCA_FUEGO_2:

	xor	a
	ld	(TRIG_PULSADO),a
	ld	(CADENCIA_DEL_DISPARO),a

	ld	hl,VALORES_BASICOS_FUEGO
	jp	.FUEGO_3

.TOCA_FUEGO_3:

	ld	a,(ARMA_USANDO)
	cp	3
	jp	nz,.TOCA_FUEGO_3_2

.TOCA_FUEGO_3_1:

	ld	a,40

.TOCA_FUEGO_3_2

	ld	(CADENCIA_DEL_DISPARO),a

	ld	hl,VALORES_BASICOS_FUEGO_IZQUIERDA

	ld	a,(X_DEPH)
	cp	10
	jp	c,.NOS_VAMOS

.FUEGO_3:

	ld	a,2
	call	.FX_ARMA

	call	.STANDAR_LDIR_ENEMIGOS
	call	.CAMBIA_VALORES_PUPA

	ld	b,(ix)
	ld	a,(X_DEPH)
	add	b
	ld	(ix),a

	ld	b,(ix+1)
	ld	a,(Y_DEPH)
	add	b
	ld	(ix+1),a

        call	.TROZOS_COMUNES_13
	ld	hl,COLOR_BOLA_FUEGO										; Damos color al sprite en la posición de sprite que le toca	
	call	.TROZOS_COMUNES_11
	ld	de,16
	add	ix,de
	call	PAGE_10_A_SEGMENT_2

	jp	.NOS_VAMOS
		
.HACHA:

	ld	hl,VALORES_BASICOS_HACHA
	call	.STANDAR_LDIR_ENEMIGOS	
	call	.CAMBIA_VALORES_PUPA

	ld	a,(X_DEPH)
	add	8
	ld	(ix),a
		
	ld	a,(Y_DEPH)
	sub	4
	ld	(ix+1),a

        call	.TROZOS_COMUNES_13
	ld	hl,COLOR_HACHA_1										; Damos color al sprite en la posición de sprite que le toca	
	call	PON_COLOR_2
	jp	.NOS_VAMOS

.NOS_VAMOS:

	pop	ix
		
	ret

.PASAMOS_A_LA_SIGUIENTE_POSICION:

	ld	de,16
	add	ix,de
	ld	hl,VARIABLE_UN_USO
	push	ix
	pop	de
	call	XOR_Z_RAM
	jp	z,.NOS_VAMOS
	jp	.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO

.STANDAR_LDIR_ENEMIGOS:

        push	ix	
        pop	de										; Pasa atributos principales
        ld	bc,16
        ldir
        ret

.MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE:

	push	ix
	ld	a,10
	ld	(SPRITE_QUE_TOCA),a	

.MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE_BUCLE:

	ld	ix,SPRITES_ACTIVOS
	ld	a,(SPRITE_QUE_TOCA)
	sub	10
	ld	e,a
	ld	d,0
	add	ix,de
	ld	a,(ix)
	or	a
	jp	z,.OCUPAMOS_EL_SPRITE
	ld	a,(SPRITE_QUE_TOCA)
	inc	a
	ld	(SPRITE_QUE_TOCA),a
	cp	32
	jp	c,.MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE_BUCLE
	pop	ix	
	pop	af
	ld	a,(MIRAMOS_SEGUNDO_SPRITE)
	or	a
	jp	z,.NOS_VAMOS

        ld      a,(ix+12)
        call    .DEJA_LIBRE_SPRITE_EN_RAM
	xor	a
	ld	(ix+12),a
	jp	.NOS_VAMOS

.OCUPAMOS_EL_SPRITE:

	ld	a,1
	ld	(ix),a
	pop	ix
	ret	

.DEJA_LIBRE_SPRITE_EN_RAM:

	or	a
[2]	rrc	a
	sub	10
	push	ix
	ld	ix,SPRITES_ACTIVOS
	ld	e,a
	ld	d,0
	add	ix,de
	xor	a
	ld      (ix),a
	pop	ix
		
	ret

.TROZOS_COMUNES_11:

        call    PAGE_32_A_SEGMENT_2
	call    PON_COLOR_2
        jp      PAGE_31_A_SEGMENT_2

.TROZOS_COMUNES_13:

        xor     a
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
	call	.MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE
	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a


	ld	(ix+12),a

.TROZOS_COMUNES_14:

        call    PAGE_32_A_SEGMENT_2

	jp	.PON_COLOR_1

.PON_COLOR_1:
		
	ld	e,a
	ld	d,0
        push    de
        pop     hl
        or      a
    [3] adc     hl,de
        ex      de,hl
	ld	hl,#4800
	or	a
	adc	hl,de
	ex	de,hl

        ret

.TABLA_DE_ARMA_O_ENEMIGO_A_DEFINIR:

	dw	.FLECHA									; 0
	dw	.FLECHA									; 1
	dw	.FLECHA									; 2
	dw	.FUEGO									; 3
	dw	.FUEGO									; 4
	dw	.FUEGO									; 5
	dw	.HACHA									; 6
	dw	.HACHA									; 7
	dw	.HACHA