REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES:

        push    ix
        push    iy
        
        ld      iy,PROYECTILES
        ld      b,6

.BUCLE_6_PROYECTILES:

        ld      a,(iy+2)
        cp      #FF
        jp      z,.PASAMOS_AL_SIGUIENTE_PROYECTIL
        
        ld      ix,ENEMIGOS   

        push    bc
        ld      b,10

.BUCLE_10_ENEMIGOS:

        ld      a,(ix+2)
        cp      #FF
        jp      z,.NO_HAY_COLISION
             
        ld      a,(ix)
        ld      c,a
        ld      a,(iy)
        add     14
        sub     c
        cp      30
        jp      nc,.NO_HAY_COLISION

        ld      a,(ix+1)                                                    ; Y enemigo
        ld      c,a
        ld      a,(iy+1)                                                    ; Y prota
        add     30                                                          ; Corrección para que ajusten
        sub     c                                                           ; Se restan
        cp      36                                                          ; El margen para que colapsen en este caso es 36
        jp      nc,.NO_HAY_COLISION

.SI_QUE_HAY_COLISION:

        jp      .sobre_el_proyectil

.NO_HAY_COLISION:

        ld      de,16
        add     ix,de
        djnz    .BUCLE_10_ENEMIGOS
        pop     bc

.PASAMOS_AL_SIGUIENTE_PROYECTIL:

        ld      de,16
        add     iy,de
        djnz    .BUCLE_6_PROYECTILES

.SALIMOS:

        pop     iy
        pop     ix

        ret

.sobre_el_proyectil:

        ld      a,(iy+5)
        or      a
        jp      nz,.miramos_todo_antes_de_ser_enemigo
        ld      a,(ix+8)
        cp      46*4
        jp      c,.miramos_todo_antes_de_ser_enemigo

        xor     a
        ld      (iy+8),a
	ld	a,(iy+12)
	call	DEJA_LIBRE_SPRITE_EN_RAM
        
.miramos_todo_antes_de_ser_enemigo:

        
; VEMOS_SI_ES_UN_PREMIO

        ld      a,(ALPHONSERRYX_ACTIVO)
        or      a
        jp      nz,.miramos_todo_antes_de_ser_enemigo_1

        ld      a,(ix+8)
        cp      46*4
        jp      z,.GENERAMOS_PREMIO
        cp      48*4
        JP      Z,.GENERAMOS_PREMIO

; VEMOS_SI_ES_INFERIOR_A_46
.miramos_todo_antes_de_ser_enemigo_1:

        ld      a,(ix+8)
        cp      46*4
        jp      c,.NO_HAY_COLISION

; VEMOS_SI_ES_MEGA_DEATH

        cp      54*4
        jp      z,.PUEDE_SER_MEGA
        cp      56*4
        jp      z,.PUEDE_SER_MEGA
        cp      58*4
        jp      z,.PUEDE_SER_MEGA

; VEMOS_SI_ES_ECTO_PALLER

        cp      50*4
        jp      z,.PUEDE_SER_ECTO
        cp      52*4
        jp      z,.PUEDE_SER_ECTO

.sobre_el_enemigo:

        ld      a,(iy+4)
        ld      c,a
        ld      a,(ix+4)
        cp      c
        
        jp      nz,.restamos_poco

.restamos_mucho:

        ld      a,(iy+3)
        jp      .restamos_vida_al_enemigo

.restamos_poco:

        ld      a,(iy+2)

.restamos_vida_al_enemigo:

        ld      c,a
        ld      a,(ix+2)
        sub     c
        ld      (ix+2),a
        cp      220
        jp      nc,.eliminamos_enemigo

        push    af
        ld      a,4
        ld      c,0
        call    A_31_DESDE_10       
        pop     af
       
        or      a
        jp      nz,.NO_HAY_COLISION

.eliminamos_enemigo:

        ld      a,5
        ld      c,1
        call    A_31_DESDE_10       
    

        ld      a,(ix+14)
        ld      l,a
        ld      h,0
        ld      (SCORE_A_SUMAR),hl
      
        call    SUMA_SCORE

.lo_eliminamos_de_facto:
 
        xor     a
        ld      (ix+2),a

        call    UN_NUEVO_ENEMIGO.DEFINE_EXPLOSION
        
.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION:

        pop     bc
        jp      .PASAMOS_AL_SIGUIENTE_PROYECTIL

.GENERAMOS_PREMIO:

        ld      a,(ix+2)
        ld      b,a
        ld      a,(iy+2)
        cp      b
        jp      c,.sobre_el_enemigo

        call    UN_NUEVO_ENEMIGO.DEFINE_PREMIO_1              
        jp      .FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION

.PUEDE_SER_MEGA:

        ld      a,(MEGADEATH_ACTIVO)
        or      a
        jp      z,.sobre_el_enemigo

        ld      a,(ix+8)
        cp      54*4
        jp      z,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        
        call    UN_NUEVO_ENEMIGO.DEFINE_INMUNIDAD
        jp      .sobre_el_enemigo

.PUEDE_SER_ECTO:

        ld      a,(ECTOPALLERS_ACTIVO)
        or      a
        jp      z,.sobre_el_enemigo
        cp      1
        jp      z,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION

        ld      a,(ARMA_USANDO)
        cp      3
        jp      c,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        cp      6
        jp      nc,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        ld      a,(ECTO_PARALIZADO)
        or      a
        jp      nz,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        
        ld      a,50
        ld      (ECTO_PARALIZADO),a

        ld      a,(PUNTO_DEL_SCROLL)
        ld      b,a
        ld      a,(ix+1)
        sub     b
        ld      (ix+5),a
         
        call    CARGA_ECTO_PALLER_MUERTO       
        jp      .FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION