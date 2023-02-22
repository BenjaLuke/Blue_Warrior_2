UN_NUEVO_ENEMIGO:

                push    ix
                ld      ix,ENEMIGOS
                ex      af,af'
        

.MIRAMOS_SI_ESTA_OCUPADO:

                ld      a,(ix+2)
                cp      $FF
                jp      nz,.PASAMOS_A_LA_SIGUIENTE_POSICION

                ex      af,af'
                ld      de,TABLA_DE_ARMA_O_ENEMIGO_A_DEFINIR
                JP      SITUAMOS_PUNTERO_EN_TABLA

.DEFINE_EXPLOSION:
 
        ld      a,(ix+8)
        cp      46*4
        ret     c

        ld      a,(FASE)
        cp      2
        jp      z,.LIMITES_2_5
        cp      5
        jp      z,.LIMITES_2_5

.LIMITES_1_4:

        ld      a,(ix+8)
        cp      54*4
        jp      c,.un_solo_sprite
        jp      .seguimos_definiendo_la_explosion

.LIMITES_2_5:

        ld      a,(ix+8)
        cp      60*4
        jp      c,.un_solo_sprite
        jp      .seguimos_definiendo_la_explosion

.un_solo_sprite:

        call    SOLO_EL_SEGUNDO                                                                 ; Aquí se libera el espacio del sprite
                                                                                                ; Aquí se borra el segundo srpite
        ld      e,(ix+3)
	ld	d,0
        ld	hl,#4A00		                                                        ; Depositamos los sprites en vram	
	or	a
	adc	hl,de
	ex	de,hl
	ld	hl,PROPIEDADES_PATRON_SPRITE
        push    ix
        ld      ix,PROPIEDADES_PATRON_SPRITE
        ld      a,255
        ld      (ix+1),a
        pop     ix
	ld	bc,3
	call	PON_COLOR_2.sin_bc_impuesta

.seguimos_definiendo_la_explosion

        push    ix
        ld      ix,PROPIEDADES_PATRON_SPRITE
        xor     a
        ld      (ix+2),a
        pop     ix
        ld      (ix+10),a
        call    TROZOS_COMUNES_5
	ld	hl,COLOR_EXPLOSION					                        ; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_7

        ld      a,23*4
        ld      (ix+8),a                                                                        ; Ponemos el número de sprite que le corresponde
        ld      a,10
        ld      (ix+6),a                                                                        ; Otorgamos el tipo de comportamiento
       
        ret

.DEFINE_S:

        push    bc
        ld      a,250
        ld      (PAUSA_BLOQUEADA),a
        ld      a,b
        ld	hl,VALORES_BASICOS_S
        jp      .COMUN_LETRAS

.DEFINE_T:

        push    bc
        ld      a,b
        ld	hl,VALORES_BASICOS_T
        jp      .COMUN_LETRAS

.DEFINE_A:

        push    bc
        ld      a,b
        ld	hl,VALORES_BASICOS_A
        jp      .COMUN_LETRAS

.DEFINE_G:

        push    bc
        ld      a,b
        ld	hl,VALORES_BASICOS_G
        jp      .COMUN_LETRAS

.DEFINE_E:

        push    bc
        ld      a,b
        ld	hl,VALORES_BASICOS_E
        jp      .COMUN_LETRAS

.DEFINE_1_FINAL:

        push    bc
        ld      a,b
        ld	hl,VALORES_BASICOS_1

.COMUN_LETRAS:

        call    STANDAR_LDIR_ENEMIGOS
        pop     bc

        ld      a,(FASE)
        cp      5
        jp      nz,.COMUN_LETRAS_SIGUE

        ld      a,(ix+3)
        add     c
        ld      (ix+3),a

.COMUN_LETRAS_SIGUE:

        call    TROZOS_COMUNES_1
	ld	hl,COLOR_TITULO_STAGE						; Damos color al sprite en la posición de sprite que le toca	
	jp      TROZOS_COMUNES_9

.DEFINE_D_PREMIO:

        ld      hl,VALORES_BASICOS_LETRAS_PREMIO_D
        jp      .COMUN_LETRAS_PREMIO

.DEFINE_E_PREMIO:

        ld      hl,VALORES_BASICOS_LETRAS_PREMIO_E
        jp      .COMUN_LETRAS_PREMIO

.DEFINE_P_PREMIO:

        ld      hl,VALORES_BASICOS_LETRAS_PREMIO_P
        jp      .COMUN_LETRAS_PREMIO

.DEFINE_H_PREMIO:

        ld      hl,VALORES_BASICOS_LETRAS_PREMIO_H
        jp      .COMUN_LETRAS_PREMIO

.COMUN_LETRAS_PREMIO:

        push    bc
        pop     af

.COMPARTIDO_CON_LETRAS_AVISO:

        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
        call    TROZOS_COMUNES_1
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        add     72
        ld      (ix+7),a
        ld      a,(ix+1)
	ld	hl,COLOR_LETRAS_PREMIO	
	call    TROZOS_COMUNES_7

        jp      .RESOLUCION

.COMUN_DOS_CORAZONES_1:

        call    STANDAR_LDIR_ENEMIGOS
        ld      (ix),a
        jp      TROZOS_COMUNES_1

.COMUN_DOS_CORAZONES_2:

	call    TROZOS_COMUNES_7
   
        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a
	ld	(ix+3),a
        jp      TROZOS_COMUNES_3

.DEFINE_CORAZON_CONTENEDOR:

        ld      a,(CORAZON_CONTENEDOR_COGIDO)
        or      a
        jp      nz,.DEFINE_CORAZON

        xor     a
        ld      (CORAZON_ACTIVO),a

        ld      a,b
        ld      hl,VALORES_BASICOS_CORAZON_CONTENEDOR
        call    .COMUN_DOS_CORAZONES_1
	ld	hl,COLOR_CORAZON_4	
        call    .COMUN_DOS_CORAZONES_2
	ld	hl,COLOR_CORAZON_3
	call    TROZOS_COMUNES_7

        jp      .RESOLUCION

.DEFINE_CORAZON:

        ld      a,1
        ld      (CORAZON_ACTIVO),a
        
        ld      a,b
        ld      hl,VALORES_BASICOS_CORAZON
        call    .COMUN_DOS_CORAZONES_1


	ld	hl,COLOR_CORAZON_1	


        call    .COMUN_DOS_CORAZONES_2

        push    af
        ld      a,(FASE)
        cp      4
        jp      nz,.DEFINE_CORAZON_TODO_STAGE
        ld      hl,COLOR_CORAZON_5
        jp      .UNIMOS_COLORES_CORAZON

.DEFINE_CORAZON_TODO_STAGE:

	ld	hl,COLOR_CORAZON_2

.UNIMOS_COLORES_CORAZON:

        pop     af
	call    TROZOS_COMUNES_7

        jp      .RESOLUCION

.DEFINE_LETRAS_AVISO_PREMIO_D:

        ld      a,b
        ld	hl,VALORES_BASICOS_LETRA_AVISO_D
        jp      .COMPARTIDO_CON_LETRAS_AVISO


.DEFINE_LETRAS_AVISO_PREMIO_E:

        ld      a,b
        ld	hl,VALORES_BASICOS_LETRA_AVISO_E
        jp      .COMPARTIDO_CON_LETRAS_AVISO

.DEFINE_LETRAS_AVISO_PREMIO_P:

        ld      a,b
        ld	hl,VALORES_BASICOS_LETRA_AVISO_P
        jp      .COMPARTIDO_CON_LETRAS_AVISO

.DEFINE_LETRAS_AVISO_PREMIO_H:

        ld      a,b
        ld	hl,VALORES_BASICOS_LETRA_AVISO_H
        jp      .COMPARTIDO_CON_LETRAS_AVISO

.COMUN_CHECK_CORRECTO_INCORRECTO_1:

        ld      a,17
        ld      c,0
        call    A_31_DESDE_10

        ld      a,1
        ld      (CHECKPOINT_ACTIVO),a

        ld      a,b
        ret

.DEFINE_CAMINO_CORRECTO_O_INCORRECTO:

        call    .COMUN_CHECK_CORRECTO_INCORRECTO_1
        ld	hl,VALORES_BASICOS_INCORRECTO_CORRECTO
        jp      .COMUN_CHECK_CORRECTO_INCORRECTO_2
       
.DEFINE_CHECK_POINT:

        call    .COMUN_CHECK_CORRECTO_INCORRECTO_1
        ld	hl,VALORES_BASICOS_CHECK_POINT

.COMUN_CHECK_CORRECTO_INCORRECTO_2:

        call    STANDAR_LDIR_ENEMIGOS

        
        ld      (ix+11),a
        
        ld      a,(PUNTO_DEL_SCROLL)
        add     10
        ld      (ix+1),a

        call    TROZOS_COMUNES_4
	ld	hl,COLOR_CHECK_POINT_1	
	call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a
	ld	(ix+3),a
        call    TROZOS_COMUNES_3
	ld	hl,COLOR_CHECK_POINT_2
	call    TROZOS_COMUNES_11

        call    A_31_DESDE_10
        
        jp      .RESOLUCION

.DEFINE_SKRULLEX:

        push    bc
        ld      a,b                                                                             ; Aquí estamos salvando el valor de la X que dejamos anteriormente en B
        ld	hl,VALORES_BASICOS_SKRULLEX1
        call    STANDAR_LDIR_ENEMIGOS
        pop     bc
        ld      (ix),a
        ld      (ix+4),c
        call    TROZOS_COMUNES_1
	ld	hl,COLOR_SKRULLEX_QUE_DA_COSAS_1_1						; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a
	ld	(ix+3),a
        call    TROZOS_COMUNES_3
	ld	hl,COLOR_SKRULLEX_QUE_DA_COSAS_1_2						; Damos color al sprite en la posición de sprite que le toca	
	jp      TROZOS_COMUNES_9

.DEFINE_INMUNIDAD:

        ld      a,22
        ld      c,1
        call    A_31_DESDE_10 

        ld      a,(INMUNE)
        or      a
        jp      nz,.define_inmunidad_continua

.define_inmunidad_continua:

        ld      a,255
        ld      (INMUNE),a
        ret

.DEFINE_PREMIO_1:                                                       ; Aleatoriamente sale un premio al azar

        ld      a,6
        ld      c,1
        call    A_31_DESDE_10       


        call    SOLO_EL_SEGUNDO
        push    ix
        ld      ix,PROPIEDADES_PATRON_SPRITE
        xor     a
        ld      (ix+2),a
        ld      a,255
        ld      (ix+1),a
        pop     ix
        call    PATRONES_SPRITE_SECUNDARIO
       
        ld      a,(ix)
        cp      180
        jp      z,.principio_de_secuencia
        cp      50
        jp      z,.mitad_de_secuencia

.cuarto_de_secuencia:

        ld      a,16
        jp      .premio_aleatorio

.principio_de_secuencia:   

        xor     a
        jp      .premio_aleatorio

.mitad_de_secuencia:

        ld      a,30

.premio_aleatorio:

        ld      (ix+10),a
        
        ld      a,(ix+4)
        cp      4
        jp      z,.SERA_FLECHA
        cp      5
        jp      z,.SERA_FUEGO
        cp      6
        jp      z,.SERA_HACHA

.SERA_RANDOM:


.SERA_HACHA:
        call    TROZOS_COMUNES_5
	ld	hl,COLOR_COGE_HACHA					; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_7

        ld      a,180
        jp      .OTORGAMOS_ARMA

.SERA_FUEGO:

        call    TROZOS_COMUNES_5
	ld	hl,COLOR_COGE_FUEGO				        ; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_7

        ld       a,176
        jp      .OTORGAMOS_ARMA

.SERA_FLECHA:

        call    TROZOS_COMUNES_5
	ld	hl,COLOR_COGE_FLECHA                 			; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_7
     
        ld      a,172

.OTORGAMOS_ARMA:

        ld      (ix+8),a                                                ; Ponemos el número de sprite que le corresponde
        ld      a,5
        ld      (ix+6),a                                                ; Otorgamos el tipo de comportamiento
       
        ret

.DEFINE_PROYECTIL_NORMAL:

        ld      a,b
        ld      hl,VALORES_BASICOS_PROYECTIL_NORMAL
        call    STANDAR_LDIR_ENEMIGOS

        pop     hl
        pop     af
        ld      (ix+1),a
        pop     af
        ld      (ix),a
        push    hl
        xor     a
        call    TROZOS_COMUNES_2
	ld	hl,COLOR_PROYECTIL_NORMAL     				; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_11

        ld      a,10
        ld      c,3
        call    A_31_DESDE_10       


        call    CALCULAMOS_PROYECTILES_ENEMIGOS
        ld      (ix+3),a

        pop     hl
        pop     bc
        push    hl
        jp      .RESOLUCION

.DEFINE_MEGADEATH_E:

        push    bc
        ld      a,b                                                                             ; Aquí estamos salvando el valor de la X que dejamos anteriormente en B
        ld	hl,VALORES_BASICOS_MEGA_DEATH
        call    STANDAR_LDIR_ENEMIGOS
        pop     bc
        ld      (ix),a
        ld      (ix+4),c
        call    TROZOS_COMUNES_1
        ld      a,(ix+1)
        add     20
        ld      (ix+1),a        
	ld	hl,COLOR_MEGADEATH_BODY_1						; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a
	ld	(ix+3),a
        call    TROZOS_COMUNES_3
	ld	hl,COLOR_MEGADEATH_BODY_2						; Damos color al sprite en la posición de sprite que le toca	
	JP      TROZOS_COMUNES_9

.DEFINE_MEGADEATH_CABEZA_E:

        push    bc
        
        ld      a,1
        ld      (MEGADEATH_ACTIVO),a
        
        ld      a,b                                                                             ; Aquí estamos salvando el valor de la X que dejamos anteriormente en B
        ld	hl,VALORES_BASICOS_MEGA_DEATH_CABEZA
        call    STANDAR_LDIR_ENEMIGOS
        pop     bc
        ld      (ix),a
        ld      (ix+4),c
        call    TROZOS_COMUNES_1
        ld      a,(ix+1)
        sub     22
        ld      (ix+1),a
        
	ld	hl,COLOR_MEGADEATH_HEAT_1						; Damos color al sprite en la posición de sprite que le toca	
	call    TROZOS_COMUNES_7

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a
	ld	(ix+3),a
        call    TROZOS_COMUNES_3
	ld	hl,COLOR_MEGADEATH_HEAT_2						; Damos color al sprite en la posición de sprite que le toca	
	jp      TROZOS_COMUNES_9
  

.DEFINE_ALFONSERRIX_NE:
.DEFINE_ALFONSERRIX_NO:

        call    .DEFINE_ALFONSERRIX_COMUN_1
        ld      a,(ix+1)                                                                        ; resituamos la salida del gusano
        add     30
        ld      (ix+1),a
        jp      .DEFINE_ALFONSERRIX_COMUN_2

.DEFINE_ALFONSERRIX_SE_S4:
.DEFINE_ALFONSERRIX_SO_S4:

        push    bc

        xor     a
        ld      (MEGADEATH_ACTIVO),a 

        ld      a,b                                                                             ; Aquí estamos salvando el valor de la X que dejamos anteriormente en B
        ld	hl,VALORES_BASICOS_ALFONSERRYX_S4
        call    STANDAR_LDIR_ENEMIGOS
        pop     bc
        call    .DEFINE_ALFONSERRIX_COMUN_1_1
        ld      a,(ix+1)                                                                        ; resituamos la salida del gusano
        add     150
        ld      (ix+1),a       
        jp      .DEFINE_ALFONSERRIX_COMUN_2

.DEFINE_ALFONSERRIX_SE:
.DEFINE_ALFONSERRIX_SO:

        call    .DEFINE_ALFONSERRIX_COMUN_1

.COMUN_DE_COMUNES_ALFONSERRYX:

        ld      a,(ix+1)                                                                        ; resituamos la salida del gusano
        add     150
        ld      (ix+1),a
        jp      .DEFINE_ALFONSERRIX_COMUN_2

.DEFINE_ALFONSERRIX_COMUN_1:

        push    bc

        xor     a
        ld      (MEGADEATH_ACTIVO),a 

        ld      a,b                                                                             ; Aquí estamos salvando el valor de la X que dejamos anteriormente en B
        ld	hl,VALORES_BASICOS_ALFONSERRYX


        call    STANDAR_LDIR_ENEMIGOS
        pop     bc
.DEFINE_ALFONSERRIX_COMUN_1_1:
        ld      (ix),a
        ld      (ix+6),c
        call    TROZOS_COMUNES_1
	ld	hl,COLOR_GUSANO_1_1						; Damos color al sprite en la posición de sprite que le toca	
	jp      TROZOS_COMUNES_7

.DEFINE_ALFONSERRIX_COMUN_2:

        ld      a,1
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE

 	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a
	ld	(ix+3),a
        call    TROZOS_COMUNES_3
	ld	hl,COLOR_GUSANO_1_2						; Damos color al sprite en la posición de sprite que le toca	
	jp      TROZOS_COMUNES_9

.PASAMOS_A_LA_SIGUIENTE_POSICION:

	ld	de,16
	add	ix,de
	ld	hl,PROYECTILES
	push	ix
	pop	de
	call    DCOMPR_RAM     
	jp	z,.NOS_VAMOS_EXTRA
	jp	.MIRAMOS_SI_ESTA_OCUPADO

.RESOLUCION:

	ld	a,(SPRITE_QUE_TOCA)	
	inc	a
		
	cp	33
	jp	nz,.AUMENTAMOS
	ld	a,10

.AUMENTAMOS:
		
	ld	(SPRITE_QUE_TOCA),a

.NOS_VAMOS:

        pop     ix
        
        ret

.NOS_VAMOS_EXTRA:

        ld      a,(DATOS_A_SACAR)
        ld      de,TABLA_DE_SALIDA_SIN_CREAR_ENEMIGOS
        call    SITUAMOS_PUNTERO_EN_TABLA

.TRAS_DECISION_DE_NOS_VAMOS:

        xor     a
        ld      (DATOS_A_SACAR),a
        
        pop     ix
        ret       
SACA_4:

        pop     hl
        ex      af,af'
  [5]   pop     bc
        jp      hl

PRIMA_AF:

        pop     hl
        ex      af,af'
        jp      hl

SECUENCIAS_DE_LOS_ENEMIGOS:

.SECUENCIA_PROYECTIL_NORMAL:

        call    DIRECCIONES_DE_PROYECTIL

	ld	de,TABLA_MOVIMIENTO_PROYECTIL_ENEMIGO
	call	SITUAMOS_PUNTERO_EN_TABLA					; Con todos los datos definidos, nos vamos a la rutina que nos llevará al sitio adecuado	
        
        ld      a,(ix+5)
        inc     a
        cp      3
        jp      nz,.seguimos_proyectil_normal

        xor     a

.seguimos_proyectil_normal:

        ld      (ix+5),a

        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        add     20
        ld      b,a
        ld      a,(ix+1)
        cp      b
        jp      c,.seguimos_proyectil_normal1
        push    af
        ld      a,b
        add     40
        ld      b,a
        pop     af
        cp      b
        jp      c,TROZOS_COMUNES_29

.seguimos_proyectil_normal1:

        ld      a,(ix)
        cp      250
        jp      nc,TROZOS_COMUNES_29

.seguimos_proyectil_normal2:

        jp      TROZOS_COMUNES_28

.PROYECTIL_2:

        ld      a,(ix)
        inc     a
        ld      (ix),a

.PROYECTIL_1:

        ld      a,(ix+1)
        sub     2
        ld      (ix+1),a
        ret

.PROYECTIL_4:

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a

.PROYECTIL_3:

        ld      a,(ix)
        inc     a
        ld      (ix),a
        ret

.PROYECTIL_6:

        ld      a,(ix)
        dec     a
        ld      (ix),a

.PROYECTIL_5:

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a

        ret

.PROYECTIL_8:

        ld      a,(ix+1)
        sub     2
        ld      (ix+1),a

.PROYECTIL_7:

        ld      a,(ix)
        dec     a
        ld      (ix),a
        ret

.SECUENCIA_CORAZON:

        jp      TROZOS_COMUNES_23

.SECUENCIA_LETRA:

        ld      a,(CONTROL_Y)
        add     32
        ld      b,a
        ld      a,(Y_DEPH)
        sub     b
        ld      (ix+1),a

        push    iy
        ld      iy,TABLA_DE_POSICIONES_DE_LETRAS

        ld      e,(ix+10)
        ld      d,0
        add     iy,de
        ld      a,(iy)
        srl     a
        ld      b,a
        ld      a,(ix+3)
        add     b
        ld      (ix),a

        ld      a,(iy+1)
        sla     a
        ld      b,a
        ld      a,(ix+1)
        add     b
        ld      (ix+1),a
        pop     iy

        ld      a,(ix+10)
        add     2
        cp      212
        jp      nz,.seguimos_con_la_letra
        sub     84

.seguimos_con_la_letra:
        
        ld      (ix+10),a
        
.seguimos_con_la_letra_3:

        ld      a,(ix+2)
        dec     a
        ld      (ix+2),a
        or      a
        jp      nz,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.seguimos_con_la_letra_2:

        jp      TROZOS_COMUNES_29

.LETRAS_DE_AVISO:

        ld      a,(ix+13)
        cp      100
        jp      z,.LETRAS_DE_AVISO_FASE_3
        ld      a,(ix+7)
        ld      b,a
        ld      a,(ix+1)
        cp      b
        jp      z,.LETRAS_DE_AVISO_FASE_2
        dec     a
        cp      b
        jp      z,.LETRAS_DE_AVISO_FASE_2

.LETRAS_DE_AVISO_FASE_1:

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a
        jp      .COMUN_LETRAS_AVISO_1

.LETRAS_DE_AVISO_FASE_2:

        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        add     72
        ld      (ix+7),a
        ld      (ix+1),a
        ld      a,(ix+13)
        inc     a
        ld      (ix+13),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.LETRAS_DE_AVISO_FASE_3:

        ld      a,(ix+1)
        sub     3
        ld      (ix+1),a
        jp      TROZOS_COMUNES_29

.COMUN_LETRAS_AVISO_1:


        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        add     72        
        ld      (ix+7),a
        jp      TROZOS_COMUNES_28

.SECUENCIA_CHECK_POINT:


        ld      a,(ix+2)
        inc     a
        and     00011111B
        ld      (ix+2),a
        or      a
        cp      00001111B
        jp      c,.desaparece_check

.aparece_check:

        ld      a,(REDUCE_POS_C_P)
        inc     a
        call    .comun_de_check
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.desaparece_check:

        ld      a,(REDUCE_POS_C_P)
        dec     a
        call    .comun_de_check
        jp      .desaparece_check_2

.comun_de_check:

        ld      (REDUCE_POS_C_P),a
        ld      b,a
        ld      a,(PUNTO_DEL_SCROLL)
        add     b
        ld      (ix+1),a
        ret

.desaparece_check_2:

        ld      a,(ix+4)
        inc     a
        and     01111111B
        ld      (ix+4),a
        or      a
        jp      z,.muere_check

.check_point_continua:

        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.muere_check:

        xor     a
        ld      (CHECKPOINT_ACTIVO),a
        
        ld      a,(ix+13)
        jp      TROZOS_COMUNES_25

.SECUENCIA_SKRULLEX:

        ld      a,(ix+10)
        cp      20
        jp      c,.SECUENCIA_SKRULLEX_2

.SECUENCIA_SKRULLEX_1:

        CALL    TROZOS_COMUNES_16
        jp      .SECUENCIA_SKRULLEX_CONTINUA

.SECUENCIA_SKRULLEX_2:

        call    TROZOS_COMUNES_17

.SECUENCIA_SKRULLEX_CONTINUA:

        ld      a,(ix+10)
        and     00000011B
        or      a
        jp      nz,.FIN_SECUENCIA_SKRULLEX

.SECUENCIA_SKRULLEX_3

        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a
        
.FIN_SECUENCIA_SKRULLEX:

        ld      a,(ix+10)
        inc     a
        and     00011111B
        ld      (ix+10),a
        jp      TROZOS_COMUNES_23

.SECUENCIA_PREMIO:

        ld      a,(CUANDO_RALENTIZAMOS)
        cp      1
        jp      z,.SUMAMOS

        ld      a,(CONTROL_DE_C_R)
        cp      2
        jp      nz,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.SUMAMOS:

        push    iy
        ld      iy,TABLA_MOVIMIENTO_PREMIOS
        ld      e,(ix+10)
        ld      d,0
        add     iy,de
        ld      a,(iy)
        ld      (ix),a
        pop     iy

        ld      a,(ix+10)
        inc     a
        cp      62
        jp      c,.redefine_ix10
        xor     a

.redefine_ix10:

        ld      (ix+10),a

        ld      a,(ix+4)
        cp      3
        jp      nz,.ultima_vuelta_al_premio

        ld      a,(ix+8)

        cp      172
        jp      z,.cambio_a_fuego
        cp      176
        jp      z,.cambio_a_hacha

.cambio_a_flecha:

        call    .AUDIO_RULETA

        ld      a,172
        ld      (ix+8),a
        jp      .ultima_vuelta_al_premio

.cambio_a_fuego:

        call    .AUDIO_RULETA

        ld      a,176
        ld      (ix+8),a
        jp      .ultima_vuelta_al_premio

.cambio_a_hacha:

        call    .AUDIO_RULETA

        ld      a,180
        ld      (ix+8),a
        
.ultima_vuelta_al_premio:

        jp      TROZOS_COMUNES_28

.AUDIO_RULETA:

        ld      a,18
        ld      c,0
        jp    A_31_DESDE_10

.SECUENCIA_ALFONSERRYX_NE:
.SECUENCIA_ALFONSERRYX_NO:
.SECUENCIA_ALFONSERRYX_SE:
.SECUENCIA_ALFONSERRYX_SO:

        ld      a,(ix+10)
        cp      5
        jp      c,.SECUENCIA_ALFONSERRYX_2
        cp      10
        jp      c,.SECUENCIA_ALFONSERRYX_1
        cp      15
        jp      c,.SECUENCIA_ALFONSERRYX_2
        cp      20
        jp      c,.SECUENCIA_ALFONSERRYX_1
                
        jp      .FIN_SECUENCIA_ALFONSERRYX

.SECUENCIA_ALFONSERRYX_1:

        call    TROZOS_COMUNES_16

        jp      .SECUENCIA_ALFONSERRYX_CONTINUA

.SECUENCIA_ALFONSERRYX_2:

        call    TROZOS_COMUNES_17

.SECUENCIA_ALFONSERRYX_CONTINUA:

        ld      a,(ix+10)
        and     00000001B
        or      a
        jp      nz,.FIN_SECUENCIA_ALFONSERRYX

.SECUENCIA_ALFONSERRYX_3

        ld      a,(ix+6)                                        ; cogemos el valor de la secuencia
        sub     22                                              ; como mínimo será 22 lo convertimos en 0, 1, 2 o 3
        
        ld      de,TABLA_MOVIMIENTO_ALFONSERRYX
        jp      SITUAMOS_PUNTERO_EN_TABLA
        
.ALFONS_IZ_AB:

        call    .alf_y_down
        jp      .alf_x_left

.ALFONS_DE_AB:

        call    .alf_y_down
        jp      .alf_x_right

.ALFONS_IZ_AR:

        call    .alf_y_up
        jp      .alf_x_left

.ALFONS_DE_AR:

        call    .alf_y_up
        jp      .alf_x_right

.alf_y_down:

        ld      a,(ix+1)
        add     2
        ld      (ix+1),a


        ret

.alf_x_left:

        ld      a,(ix)
        sub     2
        ld      (ix),a
        cp      2
        jp      c,.HACEMOS_DESAPARECER
        jp      .FIN_SECUENCIA_ALFONSERRYX

.alf_y_up:

        ld      a,(ix+1)
        sub     2
        ld      (ix+1),a
        ret

.alf_x_right:

        ld      a,(ix)
        add     2
        ld      (ix),a
        cp      254
        jp      nc,.HACEMOS_DESAPARECER
        jp      .FIN_SECUENCIA_ALFONSERRYX

.HACEMOS_DESAPARECER:

        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
        add     2
        ld      (ix+1),a

.FIN_SECUENCIA_ALFONSERRYX:

        ld      a,(ix+10)
        inc     a
        and     00011111B
        ld      (ix+10),a
        jp      TROZOS_COMUNES_23

.SECUENCIA_MEGADEATH:

        call    TROZOS_COMUNES_18
        jp      z,.SECUENCIA_MEGADEATH_4
        
        call    TROZOS_COMUNES_19
        jp      c,.SECUENCIA_MEGADEATH_2

.SECUENCIA_MEGADEATH_1:

        call    TROZOS_COMUNES_16
        jp      .SECUENCIA_MEGADEATH_CONTINUA

.SECUENCIA_MEGADEATH_2:

        call    TROZOS_COMUNES_17

.SECUENCIA_MEGADEATH_CONTINUA:

        call    TROZOS_COMUNES_20
        jp      nz,.FIN_SECUENCIA_MEGADEATH

.SECUENCIA_MEGADEATH_3

        call    TROZOS_COMUNES_21
       
.FIN_SECUENCIA_MEGADEATH:

        call    TROZOS_COMUNES_22

.FINAL_MEGADEATH:

        jp      TROZOS_COMUNES_23

.SECUENCIA_MEGADEATH_4:

        call    TROZOS_COMUNES_24
        jp      nz,.FINAL_MEGADEATH
        xor     a
        ld      (ix+7),a
        jp      .FINAL_MEGADEATH

.SECUENCIA_MEGADEATH_CABEZA:

        call    TROZOS_COMUNES_18
        jp      nc,.SECUENCIA_MEGADEATH_4_CABEZA

        call    TROZOS_COMUNES_19
        jp      z,.SECUENCIA_MEGADEATH_2_CABEZA
        cp      30
        jp      nz,.SECUENCIA_MEGADEATH_CONTINUA_CABEZA

.SECUENCIA_MEGADEATH_1_CABEZA:

        ld      a,(ix)
        inc     a
        ld      (ix),a
        jp      .SECUENCIA_MEGADEATH_CONTINUA_CABEZA

.SECUENCIA_MEGADEATH_2_CABEZA:

        ld      a,(ix)
        dec     a
        ld      (ix),a

.SECUENCIA_MEGADEATH_CONTINUA_CABEZA:

        call    TROZOS_COMUNES_20
        jp      nz,.FIN_SECUENCIA_MEGADEATH_CABEZA

.SECUENCIA_MEGADEATH_3_CABEZA:

        call    TROZOS_COMUNES_21
        
.FIN_SECUENCIA_MEGADEATH_CABEZA:

        call    TROZOS_COMUNES_22

.FINAL_MEGADEATH_CABEZA:

        jp      TROZOS_COMUNES_23

.SECUENCIA_MEGADEATH_4_CABEZA:

        cp      200
        jp      c,.FIN_SECUENCIA_MEGADEATH_CABEZA

.SECUENCIA_MEGADEATH_5_CABEZA

        cp      210
        jp      nc,.SECUENCIA_MEGADEATH_6_CABEZA

        ld      a,21
        ld      c,1
        call    A_31_DESDE_10 

        ld      a,(ix+1)
        sub     3
        ld      (ix+1),a
        jp      .FIN_SECUENCIA_MEGADEATH_CABEZA

.SECUENCIA_MEGADEATH_6_CABEZA:

        cp      255
        jp      nz,.FIN_SECUENCIA_MEGADEATH_CABEZA
        ld      a,(ix+10)
        and     00000001b
        or      a
        jp      z,.SECUENCIA_MEGADEATH_7_CABEZA
        ld      a,(ix+13)
        or      a
        jp      z,.SECUENCIA_MEGADEATH_7_CABEZA
        dec     a
        ld      (ix+13),a
        call    NUEVO_PROYECTIL_NORMAL

.SECUENCIA_MEGADEATH_7_CABEZA:

        ld      a,210
        ld      (ix+7),a
        jp      .FIN_SECUENCIA_MEGADEATH_CABEZA

.SECUENCIA_EXPLOSION:

        ld      a,(ix+10)
        cp      10
        jp      c,.termina_la_secuencia_explosion
        cp      20
        jp      c,.segundo_fotograma_de_la_explosion
        
        call    STANDARD_DEJA_LIBRE_EL_SPRITE
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION   

.segundo_fotograma_de_la_explosion:       

        ld      a,24*4
        ld      (ix+8),a                                                ; Ponemos el número de sprite que le corresponde
        ld      a,(ix+10)

.termina_la_secuencia_explosion:

        inc     a
        ld      (ix+10),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

        include "NUEVOS.asm"
PON_COLOR_1:
		
	ld	e,a
	ld	d,0
        push    de
        pop     hl
        or      a
    [3] adc     hl,de
        ex      de,hl
	ld	hl,#4800
	or	a
	adc	hl,de
	ex	de,hl

        ret

STANDARD_DEJA_LIBRE_EL_SPRITE:

        xor     a
        ld      (ix+8),a
        ld      a,255
        ld      (ix),a

        ld      a,(ix+12)
        jp      DEJA_LIBRE_SPRITE_EN_RAM
        
STANDAR_LDIR_ENEMIGOS:

        push	ix	
        pop	de										; Pasa atributos principales
        ld	bc,16
        ldir
        ret

STANDAR_Y_FUERA_PANTALLA:

        ld      a,(CONTROL_Y)
        add     32
        ld      b,a
        ld      a,(Y_DEPH)
        sub     b
        ld      (ix+1),a

        ret

STANDAR_DA_EL_VALOR_SPRITE_QUE_TOCA:

        ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a
	ld	(ix+12),a

        ret

TROZOS_COMUNES_1:

        call    STANDAR_Y_FUERA_PANTALLA

TROZOS_COMUNES_4:

        xor     a
        ld      (MIRAMOS_SEGUNDO_SPRITE),a

TROZOS_COMUNES_2:

        call    MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE
 	call    STANDAR_DA_EL_VALOR_SPRITE_QUE_TOCA
TROZOS_COMUNES_3:

        call    PAGE_32_A_SEGMENT_2

        call    PON_COLOR_1
        jp      PAGE_10_A_SEGMENT_2

TROZOS_COMUNES_6:

        ld      (ix+8),a

TROZOS_COMUNES_5:

        call    PAGE_32_A_SEGMENT_2

        ld      a,(ix+12)
        jp      PON_COLOR_1

TROZOS_COMUNES_7:

        call    PAGE_32_A_SEGMENT_2

	call    PON_COLOR_2
        jp      PAGE_10_A_SEGMENT_2

TROZOS_COMUNES_9:

        call    PAGE_32_A_SEGMENT_2
	call    PON_COLOR_2
        call    PAGE_10_A_SEGMENT_2
        jp      UN_NUEVO_ENEMIGO.RESOLUCION

TROZOS_COMUNES_10:

	call    PON_COLOR_2

	ld	a,(ix+3)

        jp      PON_COLOR_1

TROZOS_COMUNES_11:

        call    PAGE_32_A_SEGMENT_2
	call    PON_COLOR_2
        jp      PAGE_31_A_SEGMENT_2

TROZOS_COMUNES_12:

        call    PAGE_32_A_SEGMENT_2

	ld	de,#44E0
	ld	bc,32
	call	PON_COLOR_2.sin_bc_impuesta
        jp      PAGE_10_A_SEGMENT_2

TROZOS_COMUNES_13:

        xor     a
        ld      (MIRAMOS_SEGUNDO_SPRITE),a
	call	MIRAMOS_SI_ESTA_LIBRE_ESE_SPRITE
	ld	a,(SPRITE_QUE_TOCA)	
 [2]	rlc	a


	ld	(ix+12),a
TROZOS_COMUNES_14:

        call    PAGE_32_A_SEGMENT_2

	jp	PON_COLOR_1

TROZOS_COMUNES_15:

        call    PAGE_32_A_SEGMENT_2
	call	PON_COLOR_2.sin_bc_impuesta					
        jp      PAGE_10_A_SEGMENT_2

TROZOS_COMUNES_16:

        ld      a,(ix+15)
        ld      (ix+8),a
        ret
TROZOS_COMUNES_17:

        ld      a,(ix+15)
        add     2*4
        ld      (ix+8),a
        ret        

TROZOS_COMUNES_18:

        ld      a,(ix+7)
        cp      150
        ret

TROZOS_COMUNES_19:

        ld      a,(ix+10)
        cp      15
        ret

TROZOS_COMUNES_20:

        ld      a,(ix+10)
        and     00000011B
        or      a
        ret

TROZOS_COMUNES_21:
      
        ld      a,(ix+1)
        inc     a
        ld      (ix+1),a

        ret

TROZOS_COMUNES_22:

        ld      a,(ix+10)
        inc     a
        and     00011111B
        ld      (ix+10),a
        ld      a,(ix+7)
        inc     a
        ld      (ix+7),a
        ret

TROZOS_COMUNES_23:

        call    TROZOS_COMUNES_31
        jp      nc,.partido

.entero:

        cp      c
        jp      nc,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

        ld      a,b
        cp      c
        jp      nc,TROZOS_COMUNES_25
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.partido:

        cp      c
        jp      c,TROZOS_COMUNES_25
        ld      a,b
        cp      c
        jp      c,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

TROZOS_COMUNES_25:

        call    LIBERA_DOS_SPRITES
        jp      TROZOS_COMUNES_30

TROZOS_COMUNES_24:

        ld      a,(ix+10)
        inc     a
        ld      (ix+10),a
        cp      150
        ret

TROZOS_COMUNES_26:

        ld      a,(ix+11)
        inc     a
        and     00000001b
        or      a
        ret

TROZOS_COMUNES_27:

        ld      a,(CUANDO_RALENTIZAMOS)
        ld      b,a
        ld      a,(ix+13)
        add     b
        ld      (ix+13),a
        ret
TROZOS_COMUNES_28:

        call    TROZOS_COMUNES_31
        jp      nc,.partido

.entero:

        cp      c
        jp      nc,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

        ld      a,b
        cp      c
        jp      nc,TROZOS_COMUNES_29
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

.partido:

        cp      c
        jp      c,TROZOS_COMUNES_29
        ld      a,b
        cp      c
        jp      c,SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

        ld      a,(ix+8)
        cp      35*4
        jp      nz,TROZOS_COMUNES_29

        xor     a
        ld      (CORAZON_ACTIVO),a

TROZOS_COMUNES_29:

        call    STANDARD_DEJA_LIBRE_EL_SPRITE
        xor     a
        ld      (ix+3),a                                ; Nos aseguramos que no va a interpretar este sprite como doble a la hora de borrar

TROZOS_COMUNES_30:

        xor     a
        ld      (ix+8),a
        ld      a,255
        ld      (ix),a
        jp      SECUENCIA_PROYECTILES_Y_ENEMIGOS.PASAMOS_A_LA_SIGUIENTE_POSICION

TROZOS_COMUNES_31:

        ld      a,(ix+1)                                ; a = límite superior
        ld      c,a                                     ; b = límite inferior
        ld      a,(DONDE_VA_LA_INTERRUPCION_LINEAL)     ; c = posición y del enemigo
        push    af
        add     26
        ld      b,a
        pop     af

        cp      b
        ret
