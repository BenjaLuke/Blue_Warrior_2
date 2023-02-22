		call	stpmus

		ld		hl,M_WIN_1
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