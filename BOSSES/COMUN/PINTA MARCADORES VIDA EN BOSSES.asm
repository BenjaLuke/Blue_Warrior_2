        ld      a,(VIDA_ROCKAGER_1)
        ld      c,a
        ld      a,(VIDA_ROCKAGER_2)
        add     c
        call    .CONVIERTE_VIDA_ROCKAGER_A_BARRA_SEMIBOSS_2

        ; Si es el ancho total, lo dejamos tal cual
        ; para que al morir borre la barra completa.
        cp      99
        jr      z,.ANCHO_BARRA_ROCKAGER_SEMIBOSS_2_OK

        ; Redondeamos hacia abajo a múltiplos de 6
        ; 1-5   -> 0
        ; 6-11  -> 6
        ; 12-17 -> 12
        ; 18-23 -> 18
        ; etc.
        ld      b,0

.REDONDEA_BARRA_A_6_ROCKAGER_SEMIBOSS_2:

        cp      6
        jr      c,.FIN_REDONDEA_BARRA_A_6_ROCKAGER_SEMIBOSS_2

        sub     6
        ld      c,a
        ld      a,b
        add     a,6
        ld      b,a
        ld      a,c

        jr      .REDONDEA_BARRA_A_6_ROCKAGER_SEMIBOSS_2

.FIN_REDONDEA_BARRA_A_6_ROCKAGER_SEMIBOSS_2:

        ld      a,b

.ANCHO_BARRA_ROCKAGER_SEMIBOSS_2_OK:

        or      a
        ret     z

        ld      b,a
        ld      a,99
        sub     b
        ld      c,151
        add     c

        ld      ix,DATAS_COR_EMPT_MALO
        ld      (ix+4),a
        ld      a,b
        ld      (ix+8),a
        xor     a
        ld      (ix+9),a

 	    ld	    hl,DATAS_COR_EMPT_MALO
	    jp	    DOCOPY


.CONVIERTE_VIDA_ROCKAGER_A_BARRA_SEMIBOSS_2:

        ld      c,a
        ld      a,VIDA_INICIAL_ROCKAGER_SEMIBOSS_2*2
        sub     c
        ld      b,a
        xor     a
        ld      d,a
        ld      l,a

.BUCLE_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2:

        ld      a,b
        or      a
        jr      z,.FIN_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2

        dec     b

        ld      a,l
        add     a,99

.AJUSTA_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2:

        cp      VIDA_INICIAL_ROCKAGER_SEMIBOSS_2*2
        jr      c,.GUARDA_RESTO_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2

        sub     VIDA_INICIAL_ROCKAGER_SEMIBOSS_2*2
        inc     d
        jr      .AJUSTA_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2

.GUARDA_RESTO_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2:

        ld      l,a
        jr      .BUCLE_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2

.FIN_ESCALA_VIDA_ROCKAGER_SEMIBOSS_2:

        ld      a,d
        ld      h,a
        ld      a,l
        or      a
        ld      a,h
        ret     z
        inc     a
        ret