COMIENZA_MENU:

        ld	    a,0							                            ; Página 1 a vista
        call	SETPAGE 

        ld      a,4
        call	CHANGE_BANK_2
                                                                            ; Cargamos graficos menu
        ld		hl,#8000													; Cargamos graficos menu
        ld		de,#8000
        ld		bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,6
        call	CHANGE_BANK_2
                                                                            ; Cargamos graficos menu
        ld		hl,#8000											
        ld		de,#0000
        ld		bc,#1000
        call	PON_COLOR_2.sin_bc_impuesta

        ld		hl,MONTANAS													; Cargamos graficos menu
        ld		de,#1000
        ld		bc,#2000
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,5
        call	CHANGE_BANK_2

        ld		hl,#8000													; Cargamos graficos menu
        ld		de,#c000
        ld		bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

DESCONECTAMOS_LA_PANTALLA_EN_MENU:		

		call	DISSCR_RAM
CREAMOS_ISR_DE_MENU:

		di																; Desconectamos las interrupciones																
		ld		a,#C3													; #c3 es el código binario de jump (jp)
		ld		[HKEYI],a												; Metemos en HTIMI ese jp
		ld		hl,NUESTRAS_INT_MENU									; Con el jp anterior, construimos jp NUESTRA_ISR
		ld		[HKEYI+1],hl											; La ponemos a continuación del jp
		ei																; Conectamos las interrupciones	

CREAMOS_INTERRUPCION_DE_LINEA_DE_MENU:

		ld 		a,124													; Ponemos la primera interrupcion de linea
		ld		(VARIABLE_UN_USO),a										; La salvamos para incrementarla después
		ld		b,a
		ld		c,19
		call	WRTVDP_EN_RAM

		di
		ld 		a,(RG0SAV)												; Enable Line Interrupt: Set R#0 bit 4
		or		00010000B
		ld		(RG0SAV),a				
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM	
		ei

COPIA_PAGE_1_A_PAGE_2:

		ld		hl,PAGE_1_A_2
		call	DOCOPY

COPIA_TROZO_RELEVANTE_A_PAGE_0:

		ld		hl,PAGE_1_A_0_RELEVANTE
		call	DOCOPY

COPIAMOS_VALORES_DEL_SCROLL:

		ld		hl,COPIA_FONDO
		ld		de,DOBLE_DE_COPIA_FONDO
		ld		bc,60
		ldir

CONECTAMOS_LA_PANTALLA_EN_MENU:

        di

        ld		a,1														; Página 2 a vista
        call	SETPAGE

		call	ENASCR_RAM

ANIMACION_DE_FONDO:

.CAMBIO_EN_BUFFER:
		
		ld		a,(DOBLE_BUFFER_MENU)
		inc		a
		and		00000001B
		ld		(DOBLE_BUFFER_MENU),a
		inc		a
		call	SETPAGE



.ASEGURAMOS_EL_FONDO:

		ld		hl,DOBLE_DE_COPIA_FONDO
		ld		ix,DOBLE_DE_COPIA_FONDO

		call	CAMBIA_EL_BUFFER

.ASEGURAMOS_MONTANA_1:

		ld		a,(LARGO_A_COPIAR_MONTANA_1)
		inc		a
		or		a
		jp		nz,.SEGUIMOS

		ld		a,255
		ld		(POSICION_DE_LAS_MONTANAS),a
		ld		a,1

.SEGUIMOS:

		ld		(LARGO_A_COPIAR_MONTANA_1),a

		ld		a,(POSICION_DE_LAS_MONTANAS)
		dec		a
		ld		(POSICION_DE_LAS_MONTANAS),a
		or		a
		jp		z,.ASEGURAMOS_MONTANA_2_ENTERO

		ld		hl,DOBLE_DE_COPIA_MONTANAS_1
		ld		ix,DOBLE_DE_COPIA_MONTANAS_1

		ld		(ix+8),a
		ld		a,(LARGO_A_COPIAR_MONTANA_1)
		ld		(ix),a

		call	CAMBIA_EL_BUFFER

.ASEGURAMOS_MONTANA_2:

		ld		hl,DOBLE_DE_COPIA_MONTANAS_2
		ld		ix,DOBLE_DE_COPIA_MONTANAS_2

		ld		a,(LARGO_A_COPIAR_MONTANA_1)
		ld		(ix+8),a
		ld		a,(POSICION_DE_LAS_MONTANAS)
		ld		(ix+4),a
		jp		.MONTANAS_2_BUFFER
		
.ASEGURAMOS_MONTANA_2_ENTERO:

		ld		hl,DOBLE_DE_COPIA_MONTANAS_2
		ld		ix,DOBLE_DE_COPIA_MONTANAS_2
		ld		a,255
		ld		(ix+8),a
		xor		a
		ld		(ix+4),a

.MONTANAS_2_BUFFER:

		call	CAMBIA_EL_BUFFER

.ASEGURAMOS_TITULO:

		ld		hl,DOBLE_DE_COPIA_TITULO
		ld		ix,DOBLE_DE_COPIA_TITULO

		call	CAMBIA_EL_BUFFER

PULSA_UNA_TECLA_PARA_EMPEZAR:

		xor		a
		call	GTTRIG_RAM
		or		a
		jp		nz,INICIA_EN_FASE_1

		ld		a,0	
		call	SNSMAT_RAM  
		bit		1,a												
		jp		z,INICIA_EN_FASE_1

		ld		a,0	
		call	SNSMAT_RAM  
		bit		2,a												
		jp		z,INICIA_EN_FASE_2

		ld		a,0	
		call	SNSMAT_RAM  
		bit		3,a												
		jp		z,INICIA_EN_FASE_3

		ld		a,0	
		call	SNSMAT_RAM  
		bit		4,a												
		jp		z,INICIA_EN_FASE_4

		ld		a,0	
		call	SNSMAT_RAM  
		bit		5,a												
		jp		z,INICIA_EN_FASE_5

        jp      ANIMACION_DE_FONDO
INICIA_EN_FASE_1:
		
        ld      a,1
        ld      (FASE),a
        jp      SEGUIMOS
INICIA_EN_FASE_2:

        ld      a,2
        ld      (FASE),a
        jp      SEGUIMOS

INICIA_EN_FASE_3:

        ld      a,3
        ld      (FASE),a
        jp      SEGUIMOS

INICIA_EN_FASE_4:

        ld      a,4
        ld      (FASE),a
        jp      SEGUIMOS

INICIA_EN_FASE_5:

        ld      a,5
        ld      (FASE),a

SEGUIMOS:

		ld		hl,0
		xor		a
		ld		(ARMA_USANDO),a											; 0 1 2 para flecha 3 4 5 para fuego 6 7 8 para hacha
		ld		(V_DECEN_MIL),a
		ld		(V_UNIDA_MIL),a
		ld		(V_CENTENAS),a
		ld		(V_DECENAS),a
		ld		(V_UNIDADES),a
		ld		(SCORE_REAL),hl		
		add		2
		ld		(MAGIAS),a
		ld		(VIDAS),a
		ld		(CORAZONES),a
		inc		a
		ld		(CORAZONES_MAXIMOS),a

		call	DISSCR_RAM
RECUPERAMOS_INTERRUPCIONES_LIMPIAS:

		di
		ld		a,#C9													; A tiene el valor de ret
		ld		(HTIMI),a												; Colocamos ese ret en el gancho H.Timi POR SI EL ORDENADOR TUVIERA ALGO (ALGUN MSX 2 CONTROL DE DISQUETERA)
		ld		(HKEYI),a												; Colocamos ese ret en el gancho H.Key POR SI EL ORDENADOR TUVIERA ALGO
        ei                                                              ; Conecta interrupciones

DESACTIVAMOS_INTERRUPCIONES_DE_LINEA_TRAS_EL_MENU:

		di
		ld 		a,(RG0SAV)												; Disable Line Interrupt: Reset R#0 bit 4
		and		11101111B
		ld		(RG0SAV),a				
		ld		b,a
		ld		c,0
		call	WRTVDP_EN_RAM	
		ei

NOS_VAMOS_AL_JUEGO:

		ld		hl,LIMPIA_PAGE_0
		call	DOCOPY

		ld		a,8
		ld      (DIRPA2),a											    ; Banco 1, pagina 3 del MEGAROM
        jp      CARGA_SLOT_JUEGO

CAMBIA_EL_BUFFER:

		ld		a,(DOBLE_BUFFER_MENU)
		or		a
		jp		z,.COPIAMOS_EN_2

.COPIAMOS_EN_1:

		ld		a,1
		jp		.COPIAMOS

.COPIAMOS_EN_2:

		ld		a,2

.COPIAMOS:

		ld		(ix+7),a
		call	DOCOPY
		jp		VDPREADY

LIMPIA_PAGE_0:

		dw		#0000,#0000,#0000,#0000,#0100,#0100
		db		#00,#00,10000000b

PAGE_1_A_2:		

		dw		#0000,#0100,#0000,#0200,#0100,#0100
		db		#00,#00,10010000b

PAGE_1_A_0_RELEVANTE:

		dw		#0000,#0140,#0000,#0060,#0100,#0040
		db		#00,#00,10010000b

COPIA_FONDO:

		dw		#0000,#0060,#0000,#0140,#0100,#0040
		db		#00,#00,11100000b

COPIA_TROZO_TITULO:

		dw		#0000,#0000,#0000,#0140,#0100,#0020
		db		#00,#00,10011000b

COPIA_TROZO_MONTANA_1:

		dw		#0000,#0021,#0000,#0141,#0000,#003F
		db		#00,#00,10011000b
		dw		#0000,#0021,#0000,#0141,#0100,#003F
		db		#00,#00,10011000b
NUESTRAS_INT_MENU:

		ld		a,1														; ponemos registro de estado 1 
		out 	(099h),a
		ld 		a,128+15
		out 	(099h),a
		in		a,(99h)													; Al leer el registro 0 (obligatorio en cada VBLANK) permitimos que se reinicie el VBLANK
		rrca			
		
		jp		c,INTERRUPCION_DE_LINEA_MENU							; Si hay carry->linea de interrupcion!!
	
		xor		a 														; Ponemos registro de estado 0 
		out 	(099h),a												; Antes de salir o se puede colgar!!
		ld 		a,128+15
		out 	(099h),a

		in		a,(099h)												; Es un VBLANK o otro tipo de interrupcion????
		rlca
		jp		c,INTERRUPCION_DE_VBLANK_MENU
		
		ret

INTERRUPCION_DE_LINEA_MENU:

		ld		a,2   													; Ponemos registro de estado 2 
		out 	(#99),a
		ld 		a,128+15
		out 	(#99),a

Poll_1:																	; Esperas. Depende un poco del juego y demas, hay que hacer 1 o 2

		in		a,(099h)												; Aguanta hasta que empieza HBLANK
		and		%00100000
		jr		nz,Poll_1

Poll_2: 

		in		a,(099h)												; Aguanta hasta que empieza HBLANK
		and		%00100000
		jr		z,Poll_2

		ld		a,(VARIABLE_UN_USO2)
		inc		a
		and		00000111B
		ld		(VARIABLE_UN_USO2),a
		or		a
		jp		z,.CAMBIO_DE_PALETA

		ld		a,(ROTACION_PALETA)

		jp		.SIN_CAMBIO

.CAMBIO_DE_PALETA:

		ld		a,(ROTACION_PALETA)
		inc		a
		and		00001111B
		ld		(ROTACION_PALETA),a

.SIN_CAMBIO:

[5]		add		a,a
		ld		hl,PALETA_BAJA_MENU										; Colores del menu
		ld		e,a
		ld		d,0
		or		a
		adc		hl,de
		call	SETPALETE
/*
POSICION:

		ld		a,(VARIABLE_UN_USO)										; Indicamos la siguiente interrupción de linea
		add		10
		cp		204														; Si se pasara de 256 y volviera a ser 0, la devolvemos a 120
		jp		c,SALVAMOS_LA_NUEVA_LINEA

		ld		a,124
SALVAMOS_LA_NUEVA_LINEA:		

		ld		(VARIABLE_UN_USO),a
		ld		b,a
		ld		c,19
		call	WRTVDP_EN_RAM
*/
		xor		a 														; Ponemos registro de estado 0 
		out 	(099h),a												; Antes de salir o se puede colgar
		ld 		a,128+15
		out 	(099h),a
		in		a,(099h)												; Lo leemos para evitar cuelgues...
		
		ret

INTERRUPCION_DE_VBLANK_MENU:

		ld		hl,PALETA_ALTA_MENU										; Colores del menu
		call	SETPALETE

		xor		a
		ld		b,a
		ld		c,18
		call	WRTVDP_EN_RAM
		
/*		ld		a,124
		ld		(VARIABLE_UN_USO),a
		ld 		b,a
		ld		c,19
		call	WRTVDP_EN_RAM
*/
		ret