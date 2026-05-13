.CAMINITO_A_PUERTA:

		halt

.CONTROLA_X:

		ld		a,(X_DEPH)
		cp		115
		jp		z,.CONTROLA_Y
		jp		nc,.X_RESTA

.X_SUMA:

		inc		a
		ld		(X_DEPH),a
		jp		.CONTROLA_Y

.X_RESTA:

		dec		a
		ld		(X_DEPH),a

.CONTROLA_Y:

		ld		a,(PUNTO_DEL_SCROLL)
		add		85
		ld		b,a
		ld		a,(Y_DEPH)
		cp		b
		jp		z,.CONTROLA_FINAL

.Y_RESTA:

		dec		a
		ld		(Y_DEPH),a		

.CONTROLA_FINAL:

		cp		b
		jp		nz,.CAMBIO_DE_PIE
		ld		a,(X_DEPH)
		cp		115
		jp		z,.SALIENDO_DE_CAMINITO

.CAMBIO_DE_PIE:
		
		ld	 	a,(CAMBIO_POSE)
		dec		a
		ld		(CAMBIO_POSE),a
		or		a
		jp		nz,.PINTAMOS_DEPH
		
		ld		a,6
		ld		(CAMBIO_POSE),a
		
		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		cp		1
		jp		z,.POSE1
		cp		3
		jp		z,.POSE3

.POSE0Y2:

		ld		a,20
		jp		.FINAL_FOTOGRAMA
		
.POSE1:

		ld		a,44
		jp		.FINAL_FOTOGRAMA

.POSE3:

		ld		a,68
			
.FINAL_FOTOGRAMA:
				
		ld		(FOTOGRAMA_DEPH),a
		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		inc		a
		and		00000011B
		LD		(FOTOGRAMA_DEPH_EN_ORDEN),a

.PINTAMOS_DEPH:

		ld		a,32
		call	CHANGE_BANK_2
		call	PINTA_SPRITE_DEPH
		ld		a,10
		call	CHANGE_BANK_2

		jp		.CAMINITO_A_PUERTA

.SALIENDO_DE_CAMINITO: