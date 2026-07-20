	ld		ix,PROYECTILES

.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO:
		
	ld		a,(ix+2)
	cp		$FF
	jp		z,.PASAMOS_A_LA_SIGUIENTE_POSICION
		
	ld		a,(ix+6)
	call	PUNTERO_EN_TABLA_SIN_DE
	
	dw		.FLECHA_FRENTE_FUEGO_FRENTE	; 0
	dw		.FUEGO_IZQUIERDA_1			; 1
	dw		.FUEGO_DERECHA_1			; 2
	dw		.HACHA_1					; 3

.FLECHA_FRENTE_FUEGO_FRENTE:

	call	.COMUN_TRES_FUEGOS
	jp		.TROZOS_COMUNES_28

.FUEGO_IZQUIERDA_1:

	call	.COMUN_TRES_FUEGOS

	ld		a,(ix)
	dec		a
	ld		(ix),a

	cp		10
	jp		c,.TROZOS_COMUNES_29

	jp		.TROZOS_COMUNES_28

.FUEGO_DERECHA_1:

	call	.COMUN_TRES_FUEGOS

	ld		a,(ix)
	inc		a
	ld		(ix),a

	cp		240
	jp		nc,.TROZOS_COMUNES_29

	jp		.TROZOS_COMUNES_28

.COMUN_TRES_FUEGOS:

	ld		a,(ix+11)
	ld		b,a
	ld		a,(ix+1)
	sub		b
	ld		(ix+1),a
	ret

.HACHA_1:

	push	ix

	ld		a,1
	ld		c,3
	call	PAGE_31_A_SEGMENT_2
	call	ayFX_INIT
	call	PAGE_10_A_SEGMENT_2

	ld		a,(ARMA_USANDO)
	cp		7
	jr		z,.carga_parabola_2
	cp		8
	jr      z,.carga_parabola_3

.carga_parabola_1:

	ld		a,(ix+10)
	ld		ix,TABLA_PARABOLA_HACHA_1
	jr		.seguimos_cargando

.carga_parabola_2:

	ld		a,(ix+10)
	ld		ix,TABLA_PARABOLA_HACHA_2
	jr		.seguimos_cargando

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
	jr		z,.rectifica_x_hacha_3

.rectifica_x_hacha_1:

	ld		a,(X_DEPH)
	sub		30
	jr		.termina_rectificacion_x

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
	jr		nc,.rectifica_y_hacha_3

.rectifica_y_hacha_1:

	ld		a,(Y_DEPH)
	sub		34
	jr		.termina_rectificacion_y

.rectifica_y_hacha_3:

	ld		a,(Y_DEPH)
	sub		68

.termina_rectificacion_y:

	ld	b,a
	ld	a,l
	add	b
	ld	(ix+1),a		
	ld	a,(ix+10)
	inc	a
	ld	(ix+10),a

	LD	a,(ix+9)
	cp	8
	jr	nc,.SEGUNDO_FOTOGRAMA
		
.PRIMER_FOTOGRAMA:

	ld	a,164
	ld	(ix+8),a
	jr	.MIRAMOS_SI_ESTA_FUERA_DE_LIMITES
				
.SEGUNDO_FOTOGRAMA:

	ld	a,168
	ld	(ix+8),a

.MIRAMOS_SI_ESTA_FUERA_DE_LIMITES:

	ld	a,(ix+10)
	cp	45
	jr	c,.cuidado_con_la_derecha

.cuidado_con_la_izquierda:

	ld	a,(ix)
	cp	250
	jp	c,.MIRAMOS_SI_DESAPARECE_EL_HACHA

	jr	.DESAPARECE

.cuidado_con_la_derecha:

	ld	a,(ix)
	cp	2
	jr	c,.DESAPARECE
				
.MIRAMOS_SI_DESAPARECE_EL_HACHA:

	ld	a,(ix+9)
	inc	a
	and	00001111B
	ld	(ix+9),a
	ld	a,(ix+10)
	cp	90
	jr	nz,.PASAMOS_A_LA_SIGUIENTE_POSICION

.DESAPARECE:
		
       call     .OCULTA_Y_MATA_SPRITE
						
.PASAMOS_A_LA_SIGUIENTE_POSICION:

	ld	de,16
	add	ix,de
	push	ix
	pop		hl
	ld		de,PROYECTILES+16*6
	call	DCOMPR_RAM
	jp		z,.NOS_VAMOS
	jp		.COMPARAMOS_EL_PROYECTIL_O_ENEMIGO_MIRADO
		
.NOS_VAMOS:
		
	ret

.NOS_VAMOS_EXTRA:

        ld      a,(DATOS_A_SACAR)
        ld      de,.TABLA_DE_SALIDA_SIN_CREAR_ENEMIGOS
        call    SITUAMOS_PUNTERO_EN_TABLA

.TRAS_DECISION_DE_NOS_VAMOS:

        xor     a
        ld      (DATOS_A_SACAR),a
        
        pop     ix
        ret       

.TROZOS_COMUNES_28:

        call    .TROZOS_COMUNES_31
        jr      nc,.partido

.entero:

        cp      c
        jr      nc,.PASAMOS_A_LA_SIGUIENTE_POSICION

        ld      a,b
        cp      c
        jr      nc,.TROZOS_COMUNES_29
        jr      .PASAMOS_A_LA_SIGUIENTE_POSICION

.partido:

        cp      c
        jr      c,.TROZOS_COMUNES_29
        ld      a,b
        cp      c
        jr      c,.PASAMOS_A_LA_SIGUIENTE_POSICION

.TROZOS_COMUNES_29:

        call    .STANDARD_DEJA_LIBRE_EL_SPRITE
        xor     a
        ld      (ix+3),a  

.TROZOS_COMUNES_30:

        xor     a
        ld      (ix+8),a
        ld      a,255
        ld      (ix),a
        jr      .PASAMOS_A_LA_SIGUIENTE_POSICION

.TROZOS_COMUNES_31:

        ld      a,(ix+1)                                ; a = límite superior
        ld      c,a                                     ; b = límite inferior
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)     ; c = posición y del enemigo
        push    af
        add     26
        ld      b,a
        pop     af

        cp      b
        ret

.DEJA_LIBRE_SPRITE_EN_RAM:

	or	a
	cp	8*4
	ret	c
	cp	28*4
	ret	nc
[2]	rrc	a
	sub	8
	push	ix
	ld	ix,SPRITES_ACTIVOS
	ld	e,a
	ld	d,0
	add	ix,de
	xor	a
	ld	(ix),a
	pop	ix
	
	ret

.OCULTA_Y_MATA_SPRITE:

        xor     a
        ld      e,(ix+12)
        ld      d,a
        ld      hl,#4A00
        add     hl,de
        ld      bc,3
        call    FILVRM_RAM
        ld      a,(ix+12)
        call    .DEJA_LIBRE_SPRITE_EN_RAM
        ld      a,$FF
        ld      (ix+2),a
        ret

.STANDARD_DEJA_LIBRE_EL_SPRITE:

        xor     a
        ld      (ix+8),a
        ld      a,255
        ld      (ix),a

        ld      a,(ix+12)
        jp      .DEJA_LIBRE_SPRITE_EN_RAM

.MIRAMOS_SI_ESTA_OCUPADO:

        ld      a,(ix+2)
        cp      $FF
        jp      nz,.PASAMOS_A_LA_SIGUIENTE_POSICION

        ex      af,af'
        ld      de,TABLA_DE_ARMA_O_ENEMIGO_A_DEFINIR
        JP      SITUAMOS_PUNTERO_EN_TABLA

.TABLA_DE_SALIDA_SIN_CREAR_ENEMIGOS:


	dw	RETORNO
	dw	SACA_4
	dw	PRIMA_AF
