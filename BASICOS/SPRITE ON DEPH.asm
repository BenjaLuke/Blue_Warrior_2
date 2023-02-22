REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH:

        ld      a,(BLOQUE_DE_SPRITES_VARIABLE)
        cp      5
        ret     z

        push    ix
        push    iy
        
        ld      b,10
        ld      ix,ENEMIGOS

.BUCLE_10_ENEMIGOS:

        ld      a,(ix+2)
        cp      #FF
        jp      z,.NO_HAY_COLISION

        ld      a,(ix)
        ld      c,a
        ld      a,(X_DEPH)
        add     14
        sub     c
        cp      24
        jp      nc,.NO_HAY_COLISION

        ld      a,(ix+1)                                                    ; Y enemigo
        ld      c,a
        ld      a,(Y_DEPH)                                                 ; Y prota
        add     30                                                          ; Corrección para que ajusten
        sub     c                                                           ; Se restan
        cp      36                                                          ; El margen para que colapsen en este caso es 36
        jp      nc,.NO_HAY_COLISION

        jp      .EXCEPCIONES_1

.SI_QUE_HAY_COLISION:
; ¿ES INMUNE?

        ld      a,(INMUNE)
        or      a
        jp      nz,.SALIMOS

; ¿NO TIENE CORAZONES?

        ld      a,(CORAZONES)
        or      a
        jp      z,MUERTE_POR_TOQUES
           
        dec     a
        ld      (CORAZONES),a
        call    PINTA_CORAZONES

        ld      a,3
        ld      c,1
        call    A_31_DESDE_10       

        ld      a,150
        ld      (INMUNE),a
        ld      a,30
        ld      (TIEMPO_DE_ADJUST),a
        jp      .SALIMOS

.NO_HAY_COLISION:

        ld      de,16
        add     ix,de
        djnz    .BUCLE_10_ENEMIGOS
        jp      .SALIMOS

.EXCEPCIONES_1:

; ¿ES CORAZON?

        ld      a,(ix+8)

        cp      35*4
        jp      nz,.EXCEPCIONES_2

; ¿ES AMPLIADO?

        ld      a,(CORAZON_ACTIVO)
        or      a
        jp      z,.DAMOS_UN_CORAZON_AMPLIADO
        jp      .DAMOS_UN_CORAZON

.EXCEPCIONES_2:

; ¿ES LETRA?

        cp      27*4
        jp      z,.CARGA_LA_D
        cp      28*4
        jp      z,.CARGA_LA_E
        cp      29*4
        jp      z,.CARGA_LA_P
        cp      30*4
        jp      z,.CARGA_LA_H

; ¿ES UN PROYECTIL?

        cp      40*4
        jp      z,.SI_QUE_HAY_COLISION

; ¿ES > 43*4?

        cp      43*4
        jp      c,.NO_HAY_COLISION

; ¿ES UN PREMIO?

        cp      43*4
        jp      z,.ES_FLECHA
        cp      44*4
        jp      z,.ES_FUEGO
        cp      45*4
        jp      z,.ES_HACHA

; ESTA MEGADEATH ACTIVO Y ES CABEZA?

        cp      54*4
        jp      nz,.SI_QUE_HAY_COLISION

        ld      a,(MEGADEATH_ACTIVO)
        or      a
        jp      z,.SI_QUE_HAY_COLISION
        jp      .NO_HAY_COLISION

.CARGA_LA_D:

        ld     a,1
        ld     (TENEMOS_D),a
        jp      .COMUN_CARGA_LETRAS


.CARGA_LA_E:

        ld     a,1
        ld      (TENEMOS_E),a
        jp      .COMUN_CARGA_LETRAS

.CARGA_LA_P:

        ld     a,1
        ld      (TENEMOS_P),a
        jp      .COMUN_CARGA_LETRAS

.CARGA_LA_H:

        ld     a,1
        ld      (TENEMOS_H),a

.COMUN_CARGA_LETRAS:

        call    STANDARD_DEJA_LIBRE_EL_SPRITE
        ld      a,15
        ld      c,0
        call    A_31_DESDE_10
        call    NUEVAS_LETRAS_AVISO_PREMIO         
        jp      .SALIMOS

.DANO_DE_PUPA:

        push    ix
        push    iy
        jp      .SI_QUE_HAY_COLISION
        
.SALIMOS:

        pop     iy
        pop     ix

        ret

.AUDIO_PREMIO:

        push    af
        ld      a,7
        ld      c,1
        call    A_31_DESDE_10       
        pop     af
        ret

.ES_FLECHA:

        call    .AUDIO_PREMIO
        ld      a,(ARMA_USANDO)
        cp      2
        jp      c,.AUMENTA_ARMA

        ld      hl,100
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

        ld      a,(ARMA_USANDO)
        cp      2
        jp      z,.FINAL_DE_ENTREGA_DE_PREMIO

        ld      a,0
        ld      (ARMA_USANDO),a

        ld     hl,10
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE
       
        jp      .FINAL_DE_ENTREGA_DE_PREMIO

.ES_FUEGO:

        call    .AUDIO_PREMIO
        ld      a,(ARMA_USANDO)
        cp      3
        jp      z,.AUMENTA_ARMA
        cp      4
        jp      z,.AUMENTA_ARMA
        cp      5
        jp      nz,.inicia_fuego
        
        ld      hl,100
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

        jp      .FINAL_DE_ENTREGA_DE_PREMIO

.inicia_fuego:

        ld      a,3
        ld      (ARMA_USANDO),a
        ld      hl,10
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE
        
        jp      .FINAL_DE_ENTREGA_DE_PREMIO

.ES_HACHA:

        call    .AUDIO_PREMIO
        ld      a,(ARMA_USANDO)
        cp      6
        jp      z,.AUMENTA_ARMA
        cp      7
        jp      z,.AUMENTA_ARMA
        cp      8
        jp      nz,.inicia_hacha
        
        ld      hl,100
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

        jp      .FINAL_DE_ENTREGA_DE_PREMIO

.inicia_hacha:

        ld      a,6
        ld      (ARMA_USANDO),a

        ld      hl,10
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

        jp      .FINAL_DE_ENTREGA_DE_PREMIO

.AUMENTA_ARMA:

        inc     a
        ld      (ARMA_USANDO),a

        ld      hl,20
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

        ld      a,(ARMA_USANDO)
        cp      2
        jp      nz,.CARGAMOS_FLECHA_SIMPLE

.CARGAMOS_FLECHA_DOBLE:

        call    CARGA_FLECHA_DOBLE
        jp      .FINAL_DE_ENTREGA_DE_PREMIO

.CARGAMOS_FLECHA_SIMPLE:

        call    CARGA_FLECHA_SIMPLE

.FINAL_DE_ENTREGA_DE_PREMIO:

        call    PINTA_ARMA

        call    STANDARD_DEJA_LIBRE_EL_SPRITE

        jp      .SALIMOS

.DAMOS_UN_CORAZON_AMPLIADO:

        ld      a,1
        ld      (CORAZON_CONTENEDOR_COGIDO),a
        ld      a,(CORAZONES_MAXIMOS)
        cp      5
        jp      nc,.DAMOS_UN_CORAZON_AMPLIADO_2

        inc     a

.DAMOS_UN_CORAZON_AMPLIADO_2:

        ld      (CORAZONES_MAXIMOS),a
        ld      (CORAZONES),a
        jp      .lo_pintamos

.DAMOS_UN_CORAZON:
  
        ld      a,(CORAZONES_MAXIMOS)
        ld      b,a
        ld      a,(CORAZONES)
        cp      b
        jp      nc,.no_puede_entregarlo

.lo_entregamos:

        inc     a
        ld      (CORAZONES),a

.lo_pintamos:

        call    PINTA_CORAZONES

        ld      a,15
        ld      c,0
        call    A_31_DESDE_10       
       

        jp      .salimos_de_la_entrega_del_corazon

.no_puede_entregarlo:

        ld      a,16
        ld      c,0
        call    A_31_DESDE_10       
     

.salimos_de_la_entrega_del_corazon:

        call    LIBERA_DOS_SPRITES
        jp      .SALIMOS