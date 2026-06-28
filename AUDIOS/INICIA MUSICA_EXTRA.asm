; ------------------------------------------------------------
; INICIA_MUSICA_COMUN
;
; Entrada:
;   A  = banco donde está la música
;   HL = dirección de la música
;
; Ejemplo:
;   ld  a,39
;   ld  hl,M_PUENTE
;   call INICIA_MUSICA_COMUN
;
; IMPORTANTE:
;   Esta rutina NO debe estar en el segmento que cambia
;   CHANGE_BANK_2, porque si cambia el banco donde está
;   ejecutándose, el MSX se pega el castañazo padre.
; ------------------------------------------------------------

		push	af
		push	hl

		call	stpmus

		pop		hl
		pop		af
		ld		(MUSICA_BEST_ON),a

		call	CHANGE_BANK_2

		ld		(MUSIC_ON),hl
		call	INICIAMOS_MUSICA

		di
		call	strmus
		ei

		jp		PAGE_10_A_SEGMENT_2
