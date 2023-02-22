		call	stpmus

		xor		a
		ld		(MUSICA_BEST_ON),a
		
		ld		hl,M_BOSS_1
		ld		(MUSIC_ON),hl
        ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2
		call	INICIAMOS_MUSICA

		di
		call	strmus
		ei

        ld		a,10
		call	CHANGE_BANK_2