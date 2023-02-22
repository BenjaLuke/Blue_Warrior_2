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

		ld		a,(ix+12)
		ld		e,a
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