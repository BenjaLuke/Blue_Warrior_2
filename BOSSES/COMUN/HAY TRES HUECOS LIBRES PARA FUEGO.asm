		ld		a,(FUEGO_QUE_TOCA)
		dec		a
		and		00000010b
		ret		z                                                       ; La rafaga ya esta iniciada: terminamos las tres bolas

		ld		hl,PROYECTILES+2
		ld		de,16
		ld		bc,#0603                                                ; B = seis entradas; C = tres huecos necesarios

.BUSCA_HUECOS_FUEGO:

		ld		a,(hl)
		inc		a
		jr		nz,.SIGUIENTE_HUECO_FUEGO
		dec		c
		ret		z                                                       ; Hay tres huecos: CY sigue limpio

.SIGUIENTE_HUECO_FUEGO:

		add		hl,de
		djnz	.BUSCA_HUECOS_FUEGO
		scf                                                             ; Hay menos de tres huecos: anulamos toda la rafaga
		ret
