REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES:

        push    ix
        push    iy
        
        ld      iy,PROYECTILES
        ld      b,6

.BUCLE_6_PROYECTILES:

        ld      a,(iy+2)
        inc     a
        jr      z,.PASAMOS_AL_SIGUIENTE_PROYECTIL
        
        ld      ix,ENEMIGOS   

        push    bc
        ld      b,10

.BUCLE_10_ENEMIGOS:

        ld      a,(ix+2)
        inc     a
        jp      z,.NO_HAY_COLISION

        ld      a,(ix+6)
        cp      17
        jr      z,.NO_HAY_COLISION
        cp      35
        jr      c,.COMPRUEBA_DISTANCIA_COLISION
        cp      38
        jr      c,.NO_HAY_COLISION

.COMPRUEBA_DISTANCIA_COLISION:

        ld      a,(ix+0)
        ld      e,(iy+0)
        sub     e
        jr      nc,.DISTANCIA_X_LISTA
        cpl
        inc     a

.DISTANCIA_X_LISTA:

        cp      16
        jp      nc,.NO_HAY_COLISION

        ld      c,(ix+1)                                                    ; Y enemigo
        ld      a,(iy+1)                                                    ; Y prota
        add     30                                                          ; Corrección para que ajusten
        sub     c                                                           ; Se restan
        cp      36                                                          ; El margen para que colapsen en este caso es 36
        jp      nc,.NO_HAY_COLISION

.SI_QUE_HAY_COLISION:

        ld      a,(ix+6)
        cp      34
        jp      z,.NO_HAY_COLISION
        jr      .sobre_el_proyectil

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
        jr      nz,.miramos_todo_antes_de_ser_enemigo
        ld      a,(ix+8)
        cp      46*4
        jr      c,.miramos_todo_antes_de_ser_enemigo

        xor     a
        ld      (iy+8),a
	ld	a,(iy+12)
	call	DEJA_LIBRE_SPRITE_EN_RAM
        
.miramos_todo_antes_de_ser_enemigo:

        call    ENEMIGO_EN_BLINDAJE_NACIMIENTO
        jr      c,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        
        
; VEMOS_SI_ES_UN_PREMIO

        ld      a,(ALPHONSERRYX_ACTIVO)
        or      a
        jr      nz,.miramos_todo_antes_de_ser_enemigo_1

        ld      a,(ix+8)
        cp      46*4
        jr      z,.GENERAMOS_PREMIO
        cp      48*4
        jr      z,.GENERAMOS_PREMIO

; VEMOS_SI_ES_INFERIOR_A_46
.miramos_todo_antes_de_ser_enemigo_1:

        ld      a,(ix+8)
        cp      46*4
        jp      c,.NO_HAY_COLISION

; VEMOS_SI_ES_MEGA_DEATH

        cp      54*4
        jr      z,.PUEDE_SER_MEGA
        cp      56*4
        jr      z,.PUEDE_SER_MEGA
        cp      58*4
        jr      z,.PUEDE_SER_MEGA

; VEMOS_SI_ES_ECTO_PALLER

        cp      50*4
        jr      z,.PUEDE_SER_ECTO
        cp      52*4
        jr      z,.PUEDE_SER_ECTO

.sobre_el_enemigo:

        ld      c,(iy+4)
        ld      a,(ix+4)
        cp      c
        
        jr      nz,.restamos_poco

.restamos_mucho:

        ld      c,(iy+3)
        jr      .restamos_vida_al_enemigo

.restamos_poco:

        ld      c,(iy+2)

.restamos_vida_al_enemigo:

        ld      a,(ix+2)
        sub     c
        ld      (ix+2),a
        cp      220
        jr      nc,.eliminamos_enemigo

        push    af
        ld      a,4
        ld      c,0
        push    ix
        call    A_31_DESDE_10       
        pop     ix
        pop     af
       
        or      a
        jp      nz,.NO_HAY_COLISION

.eliminamos_enemigo:

        ld      a,5
        ld      c,1
        push    ix
        call    A_31_DESDE_10       
        pop     ix
    

        ld      l,(ix+14)
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

        ld      b,(ix+2)
        ld      a,(iy+2)
        cp      b
        jr      c,.sobre_el_enemigo

        call    UN_NUEVO_ENEMIGO.DEFINE_PREMIO_1              
        jp      .FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION

.PUEDE_SER_MEGA:

        ld      a,(MEGADEATH_ACTIVO)
        or      a
        jr      z,.sobre_el_enemigo

        ld      a,(ix+8)
        cp      54*4
        jr      z,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        
        jr      .sobre_el_enemigo

.PUEDE_SER_ECTO:

        ld      a,(ECTOPALLERS_ACTIVO)
        or      a
        jr      z,.sobre_el_enemigo
        dec     a
        jr      z,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION

        ld      a,(ARMA_USANDO)
        cp      3
        jr      c,.GOLPE_ECTO_HUEVOS_FLECHA
        cp      6
        jr      c,.GOLPE_ECTO_HUEVOS_FUEGO

.GOLPE_ECTO_HUEVOS_HACHA:

        ld      b,10000000b
        ld      c,10000110b
        jr      .CONTROLA_ARMA_GOLPE_ECTO_HUEVOS

.GOLPE_ECTO_HUEVOS_FUEGO:

        ld      b,01000000b
        ld      c,01000011b
        jr      .CONTROLA_ARMA_GOLPE_ECTO_HUEVOS

.GOLPE_ECTO_HUEVOS_FLECHA:

        ld      b,00000000b
        ld      c,00000110b

.CONTROLA_ARMA_GOLPE_ECTO_HUEVOS:

        ld      a,(ECTO_PARALIZADO)
        or      a
        jr      nz,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        ld      a,(ECTO_HUEVOS_EXPLOSION)
        or      a
        jr      nz,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        ld      a,(ECTO_HUEVOS_RESPAWN)
        or      a
        jr      nz,.FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION
        ld      a,(ECTO_HUEVOS_GOLPES)
        and     11000000b
        cp      b
        ld      a,b
        jr      nz,.MISMA_ARMA_GOLPE_ECTO_HUEVOS
        ld      a,(ECTO_HUEVOS_GOLPES)

.MISMA_ARMA_GOLPE_ECTO_HUEVOS:

        inc     a
        ld      (ECTO_HUEVOS_GOLPES),a
        cp      c
        jr      z,.MUERE_ECTO_HUEVOS_VISUALMENTE
        
        ld      a,50
        ld      (ECTO_PARALIZADO),a

        ld      a,(PUNTO_DEL_SCROLL)
        ld      b,a
        ld      a,(ix+1)
        sub     b
        ld      (ix+5),a
         
        call    CARGA_ECTO_PALLER_MUERTO       
        jp      .FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION

.MUERE_ECTO_HUEVOS_VISUALMENTE:

        call    PREPARA_MUERTE_ECTO_HUEVOS
        ld      a,5
        ld      c,1
        call    A_31_DESDE_10
        call    UN_NUEVO_ENEMIGO.DEFINE_EXPLOSION
        jp      .FIN_DE_LAS_REPERCUSIONES_DE_LA_COLISION

PREPARA_MUERTE_ECTO_HUEVOS:

        xor     a
        ld      (ECTO_PARALIZADO),a
        ld      (ECTO_HUEVOS_GOLPES),a
        ld      (ECTO_HUEVOS_EXPLOSION),a
        ld      (ECTOPALLERS_ACTIVO),a
        ld      a,250
        ld      (ECTO_HUEVOS_RESPAWN),a
        ret
