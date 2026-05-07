        ld      a,(VIDA_ROCKAGER_1)
        ld      c,a
        ld      a,(VIDA_ROCKAGER_2)
        add     c

        ld      c,151
        add     c

        ld      ix,DATAS_COR_EMPT_MALO

        ld      (ix),a
        ld      (ix+4),a

 	    ld	    hl,DATAS_COR_EMPT_MALO
	    call	DOCOPY

        ret