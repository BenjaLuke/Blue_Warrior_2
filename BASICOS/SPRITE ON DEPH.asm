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
        inc     a
        jp      z,.NO_HAY_COLISION

        ld      c,(ix+0)
        ld      a,(X_DEPH)
        add     16
        sub     c
        cp      20
        jp      nc,.NO_HAY_COLISION

        ld      c,(ix+1)                                                    ; Y enemigo
        ld      a,(Y_DEPH)                                                 ; Y prota
        add     32                                                          ; Correcci�n para que ajusten
        sub     c                                                           ; Se restan
        cp      32                                                          ; El margen para que colapsen en este caso es 32
        jp      nc,.NO_HAY_COLISION

        jp      .EXCEPCIONES_1

.NO_HAY_COLISION:

        ld      de,16
        add     ix,de
        djnz    .BUCLE_10_ENEMIGOS

.SALIMOS:

        pop     iy
        pop     ix

        ret

.EXCEPCIONES_1:

; �ES CORAZON?

        ld      a,(ix+8)

        cp      35*4
        jp      nz,.EXCEPCIONES_2

; �ES AMPLIADO?

        ld      a,(CORAZON_ACTIVO)
        or      a
        jp      z,.DAMOS_UN_CORAZON_AMPLIADO
        jp      .DAMOS_UN_CORAZON

.EXCEPCIONES_2:

; �ES LETRA?

        cp      27*4
        jp      z,.CARGA_LA_D
        cp      28*4
        jp      z,.CARGA_LA_E
        cp      29*4
        jp      z,.CARGA_LA_P
        cp      30*4
        jp      z,.CARGA_LA_H

; �ES UN PROYECTIL?

        cp      40*4
        jp      z,.SI_QUE_HAY_COLISION

; �ES > 43*4?

        cp      43*4
        jp      c,.NO_HAY_COLISION

; �ES UN PREMIO?

        ld      b,a
        ld      a,(ix+6)
        cp      34
        jp      z,.ES_PREMIO_EXTRA
        ld      a,b
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

.SI_QUE_HAY_COLISION:
; �ES INMUNE?

        ld      a,(INMUNE)
        or      a
        jp      nz,.SALIMOS

; �NO TIENE CORAZONES?

        ld      a,(CORAZONES)
        or      a
        jp      z,MUERTE_POR_TOQUES
           
        ld      a,(TRUCO_CORAZONES_ACTIVO)
        or      a
        jp      nz,.NO_RESTA_CORAZON_POR_TRUCO

        ; ld      a,(CORAZONES)      ; XXXXXX
        ; dec     a                  ; XXXXXX  truco
        ; ld      (CORAZONES),a      ; XXXXXX  truco
        ;jp      z,MUERTE_POR_TOQUES ; XXXXXX  truco
        ;call    PINTA_CORAZONES     ; XXXXXX

.NO_RESTA_CORAZON_POR_TRUCO:

        ld      a,3
        ld      c,1
        call    A_31_DESDE_10       

        ld      a,150
        ld      (INMUNE),a
        ld      a,30
        ld      (TIEMPO_DE_ADJUST),a
        jp      .SALIMOS

.CARGA_LA_D:

        ld      hl,TENEMOS_D
        jp      .MARCA_LETRA_RECOGIDA

.CARGA_LA_E:

        ld      hl,TENEMOS_E
        jp      .MARCA_LETRA_RECOGIDA

.CARGA_LA_P:

        ld      hl,TENEMOS_P
        jp      .MARCA_LETRA_RECOGIDA

.CARGA_LA_H:

        ld      hl,TENEMOS_H

.MARCA_LETRA_RECOGIDA:

        ld      (hl),1

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
        

.AUDIO_PREMIO:

        ld      a,7
        ld      c,1
        jp      A_31_DESDE_10       

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

        xor     a
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

.ES_PREMIO_EXTRA:

        call    .AUDIO_PREMIO
        ld      a,(ix+9)
        or      a
        jp      z,.PREMIO_EXTRA_500
        cp      1
        jp      z,.PREMIO_EXTRA_1000
        cp      2
        jp      z,.PREMIO_EXTRA_2000
        cp      3
        jp      z,.PREMIO_EXTRA_MAGIA

.PREMIO_EXTRA_VIDA:

        ld      a,(VIDAS)
        cp      9
        jp      nc,.FINAL_DE_ENTREGA_DE_PREMIO_EXTRA
        inc     a
        ld      (VIDAS),a
        call    PINTA_VIDAS
        jp      .FINAL_DE_ENTREGA_DE_PREMIO_EXTRA

.PREMIO_EXTRA_MAGIA:

        ld      a,(MAGIAS)
        inc     a
        cp      6
        jr      c,.GUARDA_PREMIO_EXTRA_MAGIA
        ld      a,5

.GUARDA_PREMIO_EXTRA_MAGIA:

        ld      (MAGIAS),a
        call    PINTAMOS_LOS_PUNTOS_DE_MAGIA
        jp      .FINAL_DE_ENTREGA_DE_PREMIO_EXTRA

.PREMIO_EXTRA_500:

        ld      hl,50
        jp      .SUMA_SCORE_PREMIO_EXTRA

.PREMIO_EXTRA_1000:

        ld      hl,100
        jp      .SUMA_SCORE_PREMIO_EXTRA

.PREMIO_EXTRA_2000:

        ld      hl,200

.SUMA_SCORE_PREMIO_EXTRA:

        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

.FINAL_DE_ENTREGA_DE_PREMIO_EXTRA:

        call    PREMIO_EXTRA.RECUPERA_FLECHA_PREMIO
        call    STANDARD_DEJA_LIBRE_EL_SPRITE
        jp      .SALIMOS

.AUMENTA_ARMA:

        inc     a
        ld      (ARMA_USANDO),a

        ld      hl,20
        ld      (SCORE_A_SUMAR),hl
        call    SUMA_SCORE

        ld      a,(ARMA_USANDO)
        cp      3
        jp      nc,.FINAL_DE_ENTREGA_DE_PREMIO

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
