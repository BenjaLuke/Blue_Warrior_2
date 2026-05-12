		call	stpmus

		ld		a,1
		ld		(MUSICA_BEST_ON),a
		
        ld      a,39
        call    CHANGE_BANK_2
		ld		hl,M_PUENTE
		ld		(MUSIC_ON),hl
		call	INICIAMOS_MUSICA

		di
		call	strmus
		ei

    	call    PAGE_10_A_SEGMENT_2