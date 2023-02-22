PINTA_CORAZONES:
                
                ld      a,(CORAZONES)
                call    PUNTERO_EN_TABLA_SIN_DE

		dw	PINTA_CORAZONES.CERO
		dw	PINTA_CORAZONES.UNO
		dw	PINTA_CORAZONES.DOS
		dw	PINTA_CORAZONES.TRES
		dw	PINTA_CORAZONES.CUATRO
		dw      PINTA_CORAZONES.CINCO

.CERO:

        ld      a,(CORAZONES_MAXIMOS)
        cp      3
        jp      z,.cero_tres
        cp      4
        jp      z,.cero_cuatro
        cp      5
        jp      z,.cero_cinco

.cero_tres:

        ld      hl,COPIA_3_BLANCOS_DE_3
        push    hl
        ld      hl,COPIA_1_ROJO
        jp      .A_COPIAR

.cero_cuatro:

        ld      hl,COPIA_4_BLANCOS_DE_4
        push    hl
        ld      hl,COPIA_0_BLANCOS_DE_3
        jp      .A_COPIAR

.cero_cinco:

        ld      hl,COPIA_5_BLANCOS_DE_5
        push    hl
        ld      hl,COPIA_1_ROJO
        jp      .A_COPIAR

.UNO:

        ld      a,(CORAZONES_MAXIMOS)
        cp      3
        jp      z,.uno_tres
        cp      4
        jp      z,.uno_cuatro
        cp      5
        jp      z,.uno_cinco

.uno_tres:

        ld      hl,COPIA_2_BLANCOS_DE_3
        push    hl
        ld      hl,COPIA_1_ROJO
        jp      .A_COPIAR

.uno_cuatro:

        ld      hl,COPIA_3_BLANCOS_DE_4
        push    hl
        ld      hl,COPIA_1_ROJO
        jp      .A_COPIAR

.uno_cinco:

        ld      hl,COPIA_4_BLANCOS_DE_5
        push    hl
        ld      hl,COPIA_1_ROJO
        jp      .A_COPIAR

.DOS:

        ld      a,(CORAZONES_MAXIMOS)
        cp      3
        jp      z,.dos_tres
        cp      4
        jp      z,.dos_cuatro
        cp      5
        jp      z,.dos_cinco

.dos_tres:

        ld      hl,COPIA_1_BLANCOS_DE_3
        push    hl
        ld      hl,COPIA_2_ROJOS
        jp      .A_COPIAR

.dos_cuatro:

        ld      hl,COPIA_2_BLANCOS_DE_4
        push    hl
        ld      hl,COPIA_2_ROJOS
        jp      .A_COPIAR

.dos_cinco:

        ld      hl,COPIA_3_BLANCOS_DE_5
        push    hl
        ld      hl,COPIA_2_ROJOS
        jp      .A_COPIAR

.TRES:

        ld      a,(CORAZONES_MAXIMOS)
        cp      3
        jp      z,.tres_tres
        cp      4
        jp      z,.tres_cuatro
        cp      5
        jp      z,.tres_cinco

.tres_tres:

        ld      hl,COPIA_0_BLANCOS_DE_3
        push    hl
        ld      hl,COPIA_3_ROJOS
        jp      .A_COPIAR

.tres_cuatro:

        ld      hl,COPIA_1_BLANCOS_DE_4
        push    hl
        ld      hl,COPIA_3_ROJOS
        jp      .A_COPIAR

.tres_cinco:

        ld      hl,COPIA_2_BLANCOS_DE_5
        push    hl
        ld      hl,COPIA_3_ROJOS
        jp      .A_COPIAR

.CUATRO:

        ld      a,(CORAZONES_MAXIMOS)
        cp      4
        jp      z,.cuatro_cuatro
        cp      5
        jp      z,.cuatro_cinco

.cuatro_cuatro:

        ld      hl,COPIA_0_BLANCOS_DE_3
        push    hl
        ld      hl,COPIA_4_ROJOS
        jp      .A_COPIAR

.cuatro_cinco:

        ld      hl,COPIA_1_BLANCOS_DE_5
        push    hl
        ld      hl,COPIA_4_ROJOS
        jp      .A_COPIAR   

.CINCO:

        ld      hl,COPIA_0_BLANCOS_DE_3
        push    hl
        ld      hl,COPIA_5_ROJOS

.A_COPIAR:

        call    DOCOPY
        pop     hl
        call    DOCOPY
        ld      hl,COPIA_MARCADOR_0_A_MARCADOR_3
        jp      DOCOPY
        RET
PINTA_VIDAS:

	ld	hl,COPIA_NUMERO_DE_VIDAS	
	call    STANDAR_LDIR_MARCADOR
        push    ix
        ld      ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
        ld      a,(VIDAS)
    [3] add     a
        ld      l,(ix)
        ld      h,(ix+1)
        ld      e,a
        ld      d,0
        or      a
        adc     hl,de
        ld      (ix),l
        ld      (ix+1),h
        ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
        call    DOCOPY
        pop     ix
        ld      hl,COPIA_MARCADOR_0_A_MARCADOR_3
        jp      DOCOPY
PINTA_ARMA:

                ld      a,(ARMA_USANDO)
                call    PUNTERO_EN_TABLA_SIN_DE

		dw	PINTA_ARMA.FLECHA_1
		dw	PINTA_ARMA.FLECHA_2
		dw	PINTA_ARMA.FLECHA_3
		dw	PINTA_ARMA.FUEGO_1
		dw	PINTA_ARMA.FUEGO_2
		dw	PINTA_ARMA.FUEGO_3
		dw	PINTA_ARMA.HACHA_1
		dw	PINTA_ARMA.HACHA_2
		dw	PINTA_ARMA.HACHA_3
.FLECHA_1:

        ld      hl,COPIA_FLECHA
        call    DOCOPY
        ld      hl,COPIA_NIVEL_1
        jp      .ULTIMOS_COPIS

.FLECHA_2:
        ld      hl,COPIA_FLECHA
        call    DOCOPY
        ld      hl,COPIA_NIVEL_2
        jp      .ULTIMOS_COPIS
        
.FLECHA_3:
        ld      hl,COPIA_FLECHA
        call    DOCOPY
        ld      hl,COPIA_NIVEL_3
        jp      .ULTIMOS_COPIS
        
.FUEGO_1:
        ld      hl,COPIA_FUEGO
        call    DOCOPY
        ld      hl,COPIA_NIVEL_1
        jp      .ULTIMOS_COPIS
        
.FUEGO_2:

        ld      hl,COPIA_FUEGO
        call    DOCOPY
        ld      hl,COPIA_NIVEL_2
        jp      .ULTIMOS_COPIS
   
.FUEGO_3:

        ld      hl,COPIA_FUEGO
        call    DOCOPY
        ld      hl,COPIA_NIVEL_3
        jp      .ULTIMOS_COPIS
   
.HACHA_1:

        ld      hl,COPIA_HACHA
        call    DOCOPY
        ld      hl,COPIA_NIVEL_1
        jp      .ULTIMOS_COPIS
   
.HACHA_2:

        ld      hl,COPIA_HACHA
        call    DOCOPY
        ld      hl,COPIA_NIVEL_2
        jp      .ULTIMOS_COPIS
   
.HACHA_3:

        ld      hl,COPIA_HACHA
        call    DOCOPY
        ld      hl,COPIA_NIVEL_3
   
.ULTIMOS_COPIS:

        call    DOCOPY
        ld      hl,COPIA_MARCADOR_0_A_MARCADOR_3
        jp      DOCOPY        

SUMA_SCORE:

        push    de                                                                      ; Salvamos en la pila los valores de DE y HL
        push    hl
        ld      de,(SCORE_A_SUMAR)                                                      ; Sumamos los puntos que vienen de fuera a nuestro score
        ld      hl,(SCORE_REAL)
        or      a
        adc     hl,de
        ld      (SCORE_REAL),hl

        ld      de,5000                                                                 ; Si nuestro score >= este valor, hay que dar un corazón extra
        call    DCOMPR_RAM
        jp      c,.miramos_si_hay_que_subir_hi_score

        ld      a,(SEMAFORO_VIDA_EXTRA)                                                 ; Si este semaforo está en rojo es que ya se dió
        or      a
        jp      z,.miramos_si_hay_que_subir_hi_score

        xor      a                                                                      ; Ponemos el semáforo en rojo porque ya hemos entrado en la rutina
        ld      (SEMAFORO_VIDA_EXTRA),a
        
        ld      a,(VIDAS)                                                               ; Si ya tenemos tantos corazones como el máximo que podemos, no entregaremos nada
        ld      c,10
        cp      c
        jp      nc,.miramos_si_hay_que_subir_hi_score

        inc     a
        ld      (VIDAS),a
       
        ld      a,15
        ld      c,0
        call    A_31_DESDE_10       
      

        call    PINTA_VIDAS

.miramos_si_hay_que_subir_hi_score:

        ld      de,(MAX_SCORE)
        ld      hl,(SCORE_REAL)
	call    DCOMPR_RAM     
        jp      c,PINTA_SCORE
        ld      (MAX_SCORE),hl
PINTA_SCORE:

.DIVIDIMOS_LA_PUNTUACION:

.decenas_de_millar:

        xor     a
        ld      (V_DECEN_MIL),a

        ld      hl,(SCORE_REAL)
        ld      de,10000
	call    DCOMPR_RAM     
        jp      c,.unidades_de_millar

        ld      de,10000

.bucle_decenas_de_millar:

        ld      a,(V_DECEN_MIL)
        inc     a
        ld      (V_DECEN_MIL),a
        
        or      a
        sbc     hl,de
	call    DCOMPR_RAM     
        jp      c,.bucle_decenas_de_millar

.unidades_de_millar:

        xor     a
        ld      (V_UNIDA_MIL),a
        
        ld      de,1000
	call    DCOMPR_RAM     
        jp      c,.centenas

        ld      de,1000

.bucle_unidades_de_millar:

        ld      a,(V_UNIDA_MIL)
        inc     a
        ld      (V_UNIDA_MIL),a
        
        or      a
        sbc     hl,de
	call    DCOMPR_RAM     
        jp      nc,.bucle_unidades_de_millar

.centenas:

        xor     a
        ld      (V_CENTENAS),a

        ld      de,100
	call    DCOMPR_RAM     
        jp      c,.decenas

        ld      de,100

.bucle_centenas:

        ld      a,(V_CENTENAS)
        inc     a
        ld      (V_CENTENAS),a
        
        or      a
        sbc     hl,de
	call    DCOMPR_RAM     
        jp      nc,.bucle_centenas  

.decenas:

        xor     a
        ld      (V_DECENAS),a

        ld      de,10
	call    DCOMPR_RAM     
        jp      c,.unidades

        ld      de,10

.bucle_decenas:

        ld      a,(V_DECENAS)
        inc     a
        ld      (V_DECENAS),a
        
        or      a
        sbc     hl,de
	call    DCOMPR_RAM     
        jp      nc,.bucle_decenas 

.unidades:

        ld      a,l
        ld      (V_UNIDADES),a
        
.pintamos:
       			
	ld	hl,COPIA_NUMERO_DE_PUNTOS	
	call    STANDAR_LDIR_MARCADOR

        push    ix
        ld      ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
        ld      a,(V_UNIDADES)
        call    .bucle_repetitivo
        ld      a,(V_DECENAS)
        call    .bucle_repetitivo
        ld      a,(V_CENTENAS)
        call    .bucle_repetitivo
        ld      a,(V_UNIDA_MIL)
        call    .bucle_repetitivo
        ld      a,(V_DECEN_MIL)
        call    .bucle_repetitivo

        ld      hl,(MAX_SCORE)
        ld      de,(SCORE_REAL)
	call    DCOMPR_RAM     
        jp      nz,.ultimo_copi

        ld      hl,COPIA_PUNTOS_A_MAX
        call    DOCOPY   

.ultimo_copi:

        pop     ix
        ld      hl,COPIA_MARCADOR_0_A_MARCADOR_3
        call    DOCOPY   
        pop     hl
        pop     de
        ret

.bucle_repetitivo:

    [3] add     a
        ld      l,(ix)
        ld      h,(ix+1)
        ld      e,a
        ld      d,0
        or      a
        adc     hl,de
        ld      (ix),l
        ld      (ix+1),h
        ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
        call    DOCOPY

        ld      l,(ix+4)
        ld      h,(ix+5)
        ld      de,8
        or      a
        sbc     hl,de
        ld      (ix+4),l
        ld      (ix+5),h

        ld      hl,174
        ld      (ix),l
        ld      (ix+1),h
        ret

PINTAMOS_LOS_PUNTOS_DE_MAGIA:
		
	ld	hl,COPIA_NUMERO_DE_MAGIAS	
	call    STANDAR_LDIR_MARCADOR

        push    ix
        ld      ix,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
        ld      a,(MAGIAS)
    [3] add     a
        ld      l,(ix)
        ld      h,(ix+1)
        ld      e,a
        ld      d,0
        or      a
        adc     hl,de
        ld      (ix),l
        ld      (ix+1),h
        ld      a,172

        ld      hl,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS
        call    DOCOPY     

        ld      hl,COPIA_MARCADOR_0_A_MARCADOR_3
        call    DOCOPY

        pop     ix
        ret

STANDAR_LDIR_MARCADOR:

        di
 	ld	de,ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS							; Pinta las vidas
	ld	bc,15
	ldir		
	ei
        ret      
