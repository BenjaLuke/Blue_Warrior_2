	ld	a,(CONTROL_Y)
	cp	192
        jp      c,.si_que_puede

        inc     a
        ld      (CONTROL_Y),a
        ld      a,(Y_DEPH)
        inc     a
        ld      (Y_DEPH),a

.si_que_puede:

	xor	a												; Comprobando si ha tocado los cursores
	call	GTSTCK_RAM		
	or	a
	jp	z,.pad1
			
	ld	b,a
	ld	a,(GUARDA_STRIG)
	ld	(GUARDA_STRIG_2),a
	ld	a,b
	ld	(GUARDA_STRIG),a
				
.comprobamos1:

       	ld      de,.TABLA_TECLADO
        jp      SITUAMOS_PUNTERO_EN_TABLA

.pad1:

	ld	a,1												; Comprobando si ha tocado el pad1
	call	GTSTCK_RAM
	or	a
	jp	z,.comprobamos2	

	ld	b,a
	ld	a,(GUARDA_STRIG)
	ld	(GUARDA_STRIG_2),a
	ld	a,b
	ld	(GUARDA_STRIG),a
		
.comprobamos2:
		
       	ld      de,.TABLA_PAD_1
        jp      SITUAMOS_PUNTERO_EN_TABLA
						
.upright:

	call	.suma_comun_x
	jp	.resta_comun_y

		
.right:

	call	.suma_comun_x
	jp	.pre_sigue_comun
		
.rightdown:

	call	.suma_comun_x
	jp	.suma_comun_y
		
.downleft:

	call	.resta_comun_x
	jp	.suma_comun_y
		
.left:

	call	.resta_comun_x		
	jp	.pre_sigue_comun
		
.leftup:

	call	.resta_comun_x
		
.resta_comun_y:

	ld	a,(CONTROL_Y)
	cp	#22
	jp	nc,.hay_que_restar
        jp      .pre_sigue_comun                        

.hay_que_restar:
		
	ld	a,(CONTROL_Y)
	dec	a
	ld	(CONTROL_Y),a
			
	ld	a,(Y_DEPH)
	dec	a
	ld	(Y_DEPH),a
					
	jp	.pre_sigue_comun

.suma_comun_y:

	ld	a,(CONTROL_Y)
	cp	188
	jp	nc,.pre_sigue_comun

.hay_que_sumar:
						
	ld	a,(Y_DEPH)
	inc	a
	ld	(Y_DEPH),a
	ld	a,(CONTROL_Y)
	inc	a
	ld	(CONTROL_Y),a
		
.pre_sigue_comun:

	ld	a,(PARALIZAMOS)
	or	a
	jp	z,.cambio_de_pose
						
.cambio_de_pose:

	ld	a,(CAMBIO_POSE)
	sub	1
        and     00000111b
	ld	(CAMBIO_POSE),a
	or	a
	jp	nz,.sigue

.CAMBIO_POSE:

	ld	a,(FOTOGRAMA_DEPH_EN_ORDEN)
	cp	1
	jp	z,.POSE1
	cp	3
	jp	z,.POSE3

.POSE0Y2:

	ld	a,20
	jp	.FINAL_FOTOGRAMA
		
.POSE1:

	ld	a,44
	jp	.FINAL_FOTOGRAMA

.POSE3:

	ld	a,68
			
.FINAL_FOTOGRAMA:
				
	ld	(FOTOGRAMA_DEPH),a
	ld	a,(FOTOGRAMA_DEPH_EN_ORDEN)
	inc	a
	and	00000011B
	ld	(FOTOGRAMA_DEPH_EN_ORDEN),a

.sigue:

	ld	a,(CADENCIA_DEL_DISPARO)
	or	a
	jp	z,.PULSA_ESPACIO
		
	dec	a
	ld	(CADENCIA_DEL_DISPARO),a
	jp	.FIN_RUTINA_GLOBAL

.resta_comun_x:

	ld	a,(X_DEPH)
	cp	4
	ret	c
					
	ld	a,(X_DEPH)
	dec	a
	ld	(X_DEPH),a
			
	ret

.suma_comun_x:

	ld	a,(X_DEPH)
	cp	235
	ret	z
	ld	a,(X_DEPH)
	inc	a
	ld	(X_DEPH),a
			
	ret

.PULSA_ESPACIO:

	ld		a,(BLOQUE_DE_SPRITES_VARIABLE)
	cp		5
	jp		z,.FIN_RUTINA_GLOBAL

	ld		hl,(TIME_PARALIZA)
	ld		de,0
	call	DCOMPR_RAM
	jp		nz,.FIN_RUTINA_GLOBAL
	xor		a
	call	GTTRIG_RAM   
	or		a
	jp		z,.PULSA_BOTON
			
	ld	a,(TRIG_PULSADO)
	or	a
	jp	nz,.PULSA_M
			
	call	.NUEVO_PROYECTIL
		
	jp	.PULSA_M
		
.PULSA_BOTON:

	ld		a,1
	call	GTTRIG_RAM
	or		a
	jp		z,.LIBERAMOS_TRIG
	ld		a,(TRIG_PULSADO)
	or		a
	jp		nz,.PULSA_M
			
	call	.NUEVO_PROYECTIL	

.LIBERAMOS_TRIG:

	xor	a
	ld	(TRIG_PULSADO),a

.PULSA_M:

	ld	a,4														; Si pulsa M usamos magia
	call	SNSMAT_RAM 
	bit	2,a
	jp	nz,.PULSA_BOTON_2
					
	call	PAGE_44_A_SEGMENT_1_MAGIA
			
	jp	.FIN_RUTINA_GLOBAL
		
.PULSA_BOTON_2:

	ld	a,3
	call	GTTRIG_RAM  
	or	a
	jp	z,.FIN_RUTINA_GLOBAL
			
	call	PAGE_44_A_SEGMENT_1_MAGIA

.FIN_RUTINA_GLOBAL:

	call	PINTA_SPRITE_DEPH
        ret

.TABLA_PAD_1:

	dw	.sigue
	dw	.resta_comun_y												; Se salta el punto intermedio de up porque no hay nada relevante allí
	dw	.upright
	dw	.right
	dw	.rightdown
	dw	.suma_comun_y												; Se salta el punto intermedio de down porque no hay nada relevante allí
	dw	.downleft
	dw	.left
	dw	.leftup

.TABLA_TECLADO:

	dw	.pad1
	dw	.resta_comun_y												; Se salta el punto intermedio de up porque no hay nada relevante allí
	dw	.upright
	dw	.right
	dw	.rightdown
	dw	.suma_comun_y												; Se salta el punto intermedio de down porque no hay nada relevante allí
	dw	.downleft
	dw	.left
	dw	.leftup

.NUEVO_PROYECTIL:

	include	"NUEVO PROYECTIL PROPIO EN BOSS.asm"