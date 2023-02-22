SEARCH_SLOT_SET:														; Ampliar a espacios 1 y 2 los usados en la ram del ordenador
		
		call 	SEARCH_SLOT
		jp 		ENASLT

SEARCH_SLOT:

		call 	RSLREG
		rrca
		rrca
		and 	3
		ld 		c,a
		ld 		b,0
		ld 		hl,0FCC1h
		add 	hl,bc
		ld 		a,(hl)
		and 	080h
		or 		c
		ld 		c,a
		inc 	hl
		inc 	hl
		inc 	hl
		inc	 	hl
		ld 		a,(hl)
		and 	0Ch
		or 		c
		ld 		h,080h
		ld 		(SLOTVAR),a
				
		ret
				
HL_DATOS_DEL_COPY:

		ld		hl,DATOS_DEL_TILE_PARA_COPY
		
DOCOPY:	

		ld		b,32
		ld		c,17
		call	WRTVDP_EN_RAM
		ld		c,#9B

VDPREADY:
	
		ld		a,2
		di
		out		(#99),a									; Selecciona s#2
		ld		a,15+128
		out		(#99),a
		in		a,(#99)
		rra
		ld 		a,0										; Regresa a s#0, activa interrupciones
		out		(#99),a
		ld		a,15+128
		out		(#99),a									; Loop si el VDP no está listo
		ei
		jp		c,VDPREADY
				
		dw		#A3ED,#A3ED,#A3ED,#A3ED	  				; 15x OUTI
		dw		#A3ED,#A3ED,#A3ED,#A3ED	  				; Es más rápido que un OTIR
		dw		#A3ED,#A3ED,#A3ED,#A3ED
		dw		#A3ED,#A3ED,#A3ED;,#A3ED
				
		ret
SETPAGE:     															; Cambiar la página en screen 5 	
	
		add     a,a        			      								; x32
		add     a,a
		add     a,a
		add     a,a
		add     a,a
		add     a,31
		ld      (VDP+2),a
		di
		out     (#99),a
		ld      a,2+128
		ei
		out     (#99),a
				
		ret	

SETPALETE:		

		xor			a             										; Pon el puntero de la paleta a 0
		di
		out			(#99),a
		ld			a,16+128
		ei
		out			(#99),a
		ld			c,#9A
[32]	outi
				
		ret


LDIRVM2:																; Entra con A a 0 para las primeras 128k a escribir
																		; BIOS:	5Ch
																		; IN: HL= Dirección origen RAM
																		; DE = Dirección destino VRAM
																		; BC = Cantidad de bytes a transferir	
		ex		de,hl
		call	SetVdp_Write
		ex		de,hl
		ld		a,c
		or		a
		ld		a,b
		ld		b,c
		jr		z,blk_VRAM_0
		inc		a
				
blk_VRAM_0:

		ld		c,098h
				
blk_VRAM_Loop:

		otir
		dec		a
		jr		nz,blk_VRAM_Loop
		ex		de,hl
				
		ret

;Set VDP address counter to write from address AHL (17-bit)
;Enables the interrupts

SetVdp_Write:
SETWRT_in_RAM:															; BIOS: 53h
	
		push	af
		push	hl
		xor		a														; 16 kbytes
		and		a	
		rlc		h
		rla
		rlc		h
		rla
		srl		h
		srl		h
		di
		out		(#99),a
		ld		a,14+128
		out		(#99),a
		ld		a,l
		nop
		out		(#99),a
		ld		a,h
		or		64
		ei
		out		(#99),a
		pop		hl
		pop		af
				
		ret

WRTVDP_EN_RAM: 															; BIOS 47h

		di

		push	af
		push	hl
		push	bc

				
		ld		a,b
				
OUT_VDP_REG1:	

		out		(099h),a
		ld		a,c
		add		a,128													; For register
		ei
				
OUT_VDP_REG2:	

		out		(099h),a
	
	
		ld		b,0
		
		ld		a,7														; Compare register 7
		cp		c
		ld		hl,RG8SAV-8
		jr		c,save_new_register
		ld		hl,RG0SAV
				
save_new_register:

		and		a														; Quit carry
		adc		hl,bc
		pop		bc
		ld		(hl),b													; Save NEW value in RAM

	
		pop		hl
		ei
		pop		af		
		ret

FILVRM_RAM:																; BIOS: 56h
																		; Function : Fill VRAM with value
																		; Input    : A  - Data byte
																		;            BC - Length of the area to be written
																		;            HL - Start address
																		; Registers: AF, BC

		push	af
        call   	SetVdp_Write
        
more_fill_VRAM:
	
		ld		a,c
		or		a
		jr		z,FILL_VRAM_DAT
		inc		b
		
																		; Put to 0
		
FILL_VRAM_DAT:															; ld	a,0	;self!!
		
		pop		af
		out		(098h),a
		dec		c
		jp		nz,FILL_VRAM_DAT+1										; Fill VRAM 
		djnz	FILL_VRAM_DAT+1
																		; ld	a,(FILL_VRAM_DAT+1)
		ret
		 																	
CHANGE_BANK_2:
		
		ld		(PAGE_A_GUARDAR),a
		di
		ld		[DIRPA2],a												; Cambiamos la página del bloque 2	
		ei		
				
		ret

PON_COLOR_2:

	ld	bc,16

.sin_bc_impuesta:

	xor	a
	di
	call	LDIRVM2
		
	xor	a                                                       ; Registro 14 a 0
	ld 	(RG14SAV),a				
	ld	b,a
	ld	c,14
	jp	WRTVDP_EN_RAM
	
BUCLE_PINTA_TILES:

		ld		a,(FINAL_DEL_SCROLL)									; Si el scroll está desactivado, terminamos la rutina
		or		a
		jp		z,ENEMIGO_FINAL
		
		ld		hl,(CUANDO_PINTAMOS_UN_TILE)							; Vamos a controlar que le toque pintar el tile
		ex		de,hl
		ld		hl,(CONTROL_DE_C_P_U_T)
		call    DCOMPR_RAM     
		jp		c,.SCROLL_DEL_CAMINO
		
		ld		hl,0													; Ponemos el contador a 0 para el siguiente pintado de tiles
		ld		(CONTROL_DE_C_P_U_T),hl
		
		call	COLOCA_IX_EN_EL_LUGAR_ADECUADO_PARA_LEER_TILES
		
		push	ix														; Vamos a pintar el tile adecuado

		ld		ix,DATOS_DEL_TILE_PARA_COPY
		ld		iy,TABLA_RELACION_PARA_COPY
		
		ld		e,a
		ld		d,0
		push	de
		pop		hl
		or		a	
		adc		hl,de
		ex		de,hl
		add		iy,de
		
		ld		a,(iy)													; Damos el valor de origen de X
		ld		(ix),a
		xor		a
		ld		(ix+1),a
		ld		a,(iy+1)												; Damos el valor de origen de Y
		ld		(ix+2),a
		ld		a,01
		ld		(ix+3),a
		ld		a,(X_PINTA_SCROLL)										; Damos el valor de destino de X
		ld		(ix+4),a
		xor		a
		ld		(ix+5),a
		ld		a,(Y_PINTA_SCROLL)										; Damos el valor de destino de Y
		ld		(ix+6),a
		ld		a,2
		ld		(ix+7),a
		ld		a,16													; Tamaño X e Y del trozo a copiar
		ld		(ix+8),a
		ld		(ix+10),a
		xor		a
		ld		(ix+9),a
		ld		(ix+11),a
		ld		(ix+12),a
		ld		(ix+13),a
		ld		a,11010000B												; Indicamos que es un HMMM
		ld		(ix+14),a
		
        call    PAGE_10_A_SEGMENT_2

		
		call	HL_DATOS_DEL_COPY										; Vamos a copiar el tile que estamos mirando
		
		ld		a,(NUMERO_DE_TILE_EN_LINEA)
		inc		a
		ld		(NUMERO_DE_TILE_EN_LINEA),a
		
		ld		a,(X_PINTA_SCROLL)										; Corregimos datos para ver el siguiente tile en horizontal
		add		16
		ld		(X_PINTA_SCROLL),a
				
		pop		ix														; Recuperamos en IX el valor de la linea a pintar
		ld		de,1
		add		ix,de
				
		or		a														; A aun tiene el valor de X, Si fuera 0 es que hemos  pintado toda la linea, nos guardamos esa información
		ld		a,(ix)													; Ahora A vale la linea en la que está
		jp		nz,.SCROLL_DEL_CAMINO									; Si no ha acabado la linea seguiremos pintando tiles
		
		xor		a
		ld		(NUMERO_DE_TILE_EN_LINEA),a
		
		ld		hl,(LINEA_A_LEER)
		ld		de,1
		or		a
		sbc		hl,de
		
		ld		(LINEA_A_LEER),hl										; Comprovaciones sobre la posición del mapa
		ld		a,h														; Paso H a A 
		or		l														; Al hacer el OR con L se quedará a 0 si L y H son 0 y Z será 0
		jp		z,.AVISAMO_FINAL_SCROLL									; Si se ha llegado al final se parará

.SUCESOS:

		ld		a,(ACTIVA_SUCESOS)
		or		a
		jp		z,.RECOLOCAMOS_Y

		ld		de,TABLA_SUCESOS_FASE_1									; DE hacer referencia a la tabla en sí

		push	af
		ld		a,(FASE)
		add		32
		call	CHANGE_BANK_2
		pop		af
		call	SITUAMOS_PUNTERO_EN_TABLA_DESDE_HL_YA_MARCADA			; Vamos a ver el suceso que le toca a esa linea
        call    PAGE_10_A_SEGMENT_2


.RECOLOCAMOS_Y:

		ld		a,(Y_PINTA_SCROLL)
		sub		16
		ld		(Y_PINTA_SCROLL),a
				
.SCROLL_DEL_CAMINO:
				
		ld		hl,(CUANDO_RALENTIZAMOS)								; Vamos a controlar que le toque mover el scroll
		ex		de,hl
		ld		hl,(CONTROL_DE_C_R)
		call    DCOMPR_RAM     
		jp		c,.AVANZAMOS_LOS_CONTROLADORES
		
		ld		hl,0													; Ponemos el contador a 0 para el siguiente pintado de scroll
		ld		(CONTROL_DE_C_R),hl
		
		ld		a,(PUNTO_DEL_SCROLL)									; El valor del scroll se incrementa en 1
		dec		a
		ld		(PUNTO_DEL_SCROLL),a
					
		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		dec		a
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
						
		ld		a,(TILE_N)
		cp		79
		jp		nc,.RECTIFICA_CONTROL_Y
		ld		a,(TILE_N2)
		cp		79
		jp		nc,.RECTIFICA_CONTROL_Y

		ld		a,(Y_PINTA_SCROLL)
		add		16
		ld		b,a
		ld		a,(Y_DEPH)
		cp		b
		jp		z,.RECTIFICA_CONTROL_Y
		
.RECTIFICA_Y_POR_SCROLL:

		ld		a,(SPRITE_CAIDO)
		or		a
		jp		nz,.RECTIFICA_CONTROL_Y
		
		ld		a,(Y_DEPH)												; Rectificamos la posición del sprite para que no se vaya con el decorado
		dec		a
		ld		(Y_DEPH),a

		cp		216
		jp		z,.RECTIFICA_UP

		cp		200
		jp		nz,.SIGUE
		
.RECTIFICA_UP:
		
		dec		a
		ld		(Y_DEPH),a
		
		ld		a,(CONTROL_Y)
		dec		a
		ld		(CONTROL_Y),a

		jp		.SIGUE

.RECTIFICA_CONTROL_Y:

		ld		a,(LIM_MUERTE)
		ld		b,a
		ld		a,(CONTROL_Y)
		inc		a
		ld		(CONTROL_Y),a		

		cp		b
		jp		z,MUERTE_POR_APLASTAMIENTO
		
.SIGUE:
		
		ld	 	a,(CAMBIO_POSE)
		dec		a
		ld		(CAMBIO_POSE),a
		or		a
		jp		nz,.AVANZAMOS_LOS_CONTROLADORES
		
		ld		a,6
		ld		(CAMBIO_POSE),a
		
		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		cp		1
		jp		z,.POSE1
		cp		3
		jp		z,.POSE3

.POSE0Y2:

		ld		a,20
		jp		.FINAL_FOTOGRAMA
		
.POSE1:

		ld		a,44
		jp		.FINAL_FOTOGRAMA

.POSE3:

		ld		a,68
			
.FINAL_FOTOGRAMA:
				
		ld		(FOTOGRAMA_DEPH),a
		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		inc		a
		and		00000011B
		LD		(FOTOGRAMA_DEPH_EN_ORDEN),a
							
.AVANZAMOS_LOS_CONTROLADORES:

		ld		hl,(CONTROL_DE_C_P_U_T)
		ld		de,1
		or		a
		adc		hl,de
		ld		(CONTROL_DE_C_P_U_T),hl
		ld		hl,(CONTROL_DE_C_R)
		or		a
		adc		hl,de
		ld		(CONTROL_DE_C_R),hl
		
		ret
		
.AVISAMO_FINAL_SCROLL:		
		
		call	PAGE_10_A_SEGMENT_2
		xor		a
		ld		(FINAL_DEL_SCROLL),a
		
		pop		af
		jp		VAMOS_A_BOSS_ADECUADO

.PINTA_PALETA_1:

		xor		a
		ld		(ESTADO_COLOR_PERM),a
		ret	
		
.PINTA_PALETA_2:

		ld		a,1
		ld		(ESTADO_COLOR_PERM),a
		ret

.PINTA_PALETA_3:

		ld		a,2
		ld		(ESTADO_COLOR_PERM),a
		ret

.PINTA_FADE_IN_1:

		ld		a,(ESTADO_COLOR_PERM)
		cp		10
		ret		nz

		ld		a,3
		ld		(ESTADO_COLOR_PERM),a
		ret

.PINTA_FADE_IN_2:

		ld		a,(ESTADO_COLOR_PERM)
		cp		10
		ret		nz

		ld		a,5
		ld		(ESTADO_COLOR_PERM),a
		ret

.PINTA_PALETA_GRIS:

		ld		a,9
		ld		(ESTADO_COLOR_PERM),a
		ret



.VELOCIDAD_DE_FASE_GALOPE:

		call	PAGE_10_A_SEGMENT_2
		xor		a
		call	.APLICAMOS_VELOCIDAD
		
		ret

.RECUPERA_PROTA_FRONT:

		call	PAGE_10_A_SEGMENT_2

		ld		hl,DEPH_DE_FRENTE
        call    PAGE_32_A_SEGMENT_2

		ld		de,#42E0
		ld		bc,160
		jp		PON_COLOR_2.sin_bc_impuesta

.AVISO_FASE:

		call	PAGE_10_A_SEGMENT_2

		ld		hl,SPRITES_STAGE
        call    PAGE_32_A_SEGMENT_2

		ld		de,#42E0
		ld		bc,160
		call	PON_COLOR_2.sin_bc_impuesta

		ld		a,(FASE)
		dec		a
		ld		hl,SPRITES_1
		ld		e,a
		ld		d,0
		or		a

		ld		b,32

.bucle_suma:

		adc		hl,de
		djnz	.bucle_suma

		ld		de,#4380
		ld		bc,32
		call	PON_COLOR_2.sin_bc_impuesta
        call    PAGE_10_A_SEGMENT_2

		call	.SACA_S
		call	.SACA_T
		call	.SACA_A
		call	.SACA_G
		call	.SACA_E
		jp		.SACA_NUM_FASE

.SACA_S:

        ld      hl,NUEVA_S_DATA
        jp      COMUN_DATOS_A_SACAR

.SACA_T:

        ld      hl,NUEVA_T_DATA
        jp      COMUN_DATOS_A_SACAR

.SACA_A:

        ld      hl,NUEVA_A_DATA
        jp      COMUN_DATOS_A_SACAR

.SACA_G:

        ld      hl,NUEVA_G_DATA
        jp      COMUN_DATOS_A_SACAR

.SACA_E:

        ld      hl,NUEVA_E_DATA
        jp      COMUN_DATOS_A_SACAR

.SACA_NUM_FASE:

        ld      hl,NUEVA_1_FINAL_DATA
        jp      COMUN_DATOS_A_SACAR

.SI_QUE_SE_MUEVE:

		ld		a,1
		ld		(NO_SE_MUEVE),a
		ret
		
.PRE_VELOCIDAD_DE_FASE_TROTE:

		ld		a,1
		ld		(NO_SE_MUEVE),a

		call	PAGE_10_A_SEGMENT_2
		push	ix
		ld		ix,ATRIBUTOS_DEPH_VARIABLES

		ld		b,10
		ld		de,4
		ld		a,23*4
		
.bucle_pinta_prota_frente:

		ld		(ix+2),a
		add		ix,de
		add		4
		djnz	.bucle_pinta_prota_frente
			
		call	CARGA_FRENTE
			
		ld		hl,COLOR_FRONT_DEPH
        call    PAGE_32_A_SEGMENT_2

		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM_SIN_HL

		ld		a,50
		call	.rutina_de_pausa
		ld		b,8
		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		
.bucle_pinta_saludo:

		ld		a,33*4
		call	.pinta_sprite_3	
		ld		a,20
		call	.rutina_de_pausa	
		ld		a,36*4
		call	.pinta_sprite_3		
		ld		a,20
		call	.rutina_de_pausa
		djnz	.bucle_pinta_saludo

		ld		ix,ATRIBUTOS_DEPH_VARIABLES

		ld		b,10
		ld		de,4
		ld		a,1*4
		
.bucle_pinta_prota_espalda:
		
		ld		(ix+2),a
		add		ix,de
		add		4
		djnz	.bucle_pinta_prota_espalda

		ei
		halt
		call	CARGA_1_A_45
		call	CARGA_SKRULLEX_SLIME
		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM

		ld		a,(ARMA_USANDO)
		cp		2
		call	z,CARGA_FLECHA_DOBLE
		ei
		call	stpmus					
		pop		ix	
		jp		.musica_mas_velocidad

.musica_mas_velocidad_mas_limites_mas_rotacion:

		jp		.musica_mas_velocidad_mas_limites

.musica_mas_velocidad_mas_limites:

		call	PAGE_10_A_SEGMENT_2

		xor		a
		ld		(AVANCE_BLOQUEADO),a

.musica_mas_velocidad:

		xor		a
		ld		(MUSICA_BEST_ON),a
		
		ld		hl,M_STAGE_1
		ld		de,(MUSIC_ON)
		call	XOR_Z_RAM
		jp		z,.VELOCIDAD_DE_FASE_TROTE

		call	stpmus
	
		ld		a,(FASE)
		add		20
		call	CHANGE_BANK_2

		ld		hl,M_STAGE_1
		ld		(MUSIC_ON),hl
		call	INICIAMOS_MUSICA

		call	PAGE_10_A_SEGMENT_2

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		z,.VELOCIDAD_DE_FASE_TROTE	

		ld		a,(FASE)
		add		20
		call	CHANGE_BANK_2
		di
		call	strmus
		ei			
		call	PAGE_10_A_SEGMENT_2
		
		jp		.VELOCIDAD_DE_FASE_TROTE

.rutina_de_pausa:

		push	bc
		
		ld		b,a

.bucle_halt:

		ei
		halt
		djnz	.bucle_halt
		pop		bc
		ret
		
.pinta_sprite_3:

		push	bc
		ld		(ix+18),a
		add		4
		ld		(ix+22),a
		add		4
		ld		(ix+26),a

		call	VUELCA_DATOS_DEPH_A_VRAM

		pop		bc
		
		ret

		
.VELOCIDAD_DE_FASE_TROTE:

		call	PAGE_10_A_SEGMENT_2

		ld		a,3

.APLICAMOS_VELOCIDAD:

		ld		(CUANDO_PINTAMOS_UN_TILE),a
		ld		(CUANDO_RALENTIZAMOS),a
		xor		a
		ld		(CONTROL_DE_C_P_U_T),a
		ld		(CONTROL_DE_C_R),a
		
		ret

CHECK_POINT:

		call	PAGE_10_A_SEGMENT_2
		ld		hl,(LINEA_A_LEER)
		ld		(LINEA_SALVADA),hl

.SALTO_PARA_OTROS_CARTELES:
		ld		a,10
		ld		(REDUCE_POS_C_P),a
		
		ld		a,(SEMAFORO_CHECK_POINT)
		or		a
		jp		z,.salimos_sin_avisos

		ld		hl,CHECK_POINT_DATA
        jp      COMUN_DATOS_A_SACAR

.salimos_sin_avisos:

		ld		a,1
		ld		(SEMAFORO_CHECK_POINT),a
		ret
COLOCA_IX_EN_EL_LUGAR_ADECUADO_PARA_LEER_TILES:
		
		ld		ix,MAPA_CONSTANTE_FASE_1								; Situamos a IX en el valor del mapa a convertir en TILE
		ld		de,(LINEA_A_LEER)
		ld		hl,0
		OR		A
[16]	adc		hl,de
		ld		a,(NUMERO_DE_TILE_EN_LINEA)
		ld		e,a
		ld		d,0
		or		a
		adc		hl,de
		ex		de,hl
		add		ix,de

		push	af
		ld		a,(FASE)
		add		32
		call	CHANGE_BANK_2
		pop		af
		ld		a,(ix)
        call    PAGE_10_A_SEGMENT_2

		ret

PINTA_SPRITE_DEPH:

		push	ix														; Pintamos los datos a la variable ATRIBUTOS_DEPH_VARIABLES para luego hacer un copy directo a vram
		
		ld		ix,ATRIBUTOS_DEPH_VARIABLES

		ld		a,(INMUNE)
	[3]	srl		a
		and		00000001B
		or		a
		jp		z,.pintamos_sprite_normal

.pintamos_sprite_transparente:

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		add		23
		jp		.mismos_datos_para_los_dos

.pintamos_sprite_normal:

		ld		a,(Y_DEPH)

.mismos_datos_para_los_dos:

		push	af
		add		16
		push	af
		ld		a,(X_DEPH)
		push	af
		add		16

.comun_de_pintar:

		ld		(ix+9),a		
		ld		(ix+13),a
		ld		(ix+29),a
		ld		(ix+33),a		
		ld		(ix+37),a
		pop		af
		ld		(ix+1),a
		ld		(ix+5),a
		ld		(ix+17),a
		ld		(ix+21),a
		ld		(ix+25),a
		pop		af
		ld		(ix+16),a
		ld		(ix+20),a		
		ld		(ix+24),a
		ld		(ix+28),a
		ld		(ix+32),a		
		ld		(ix+36),a
		pop		af
		ld		(ix),a
		ld		(ix+4),a
		ld		(ix+8),a
		ld		(ix+12),a
				
		ld		a,(FOTOGRAMA_DEPH)
		ld		de,4
		ld		b,6
		

.PATRONES:

		ld		(ix+18),a
		add		4
		add		ix,de
		djnz	.PATRONES

		ld		a,(VARIABLE_CARGA_AGUA)
		or		a
		jp		z,.MAS_COLORES

		ld		hl,COLOR_PIES_EN_LODO
		jp		.SIGUE_TRAS_COLORES

.MAS_COLORES:

		ld		a,(SPRITE_CAIDO)
		or		a
		jp		z,.COLORES_NORMALES

		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		cp		2
		jp		z,.COLORES_AGUJERO_POSE_1
		cp		0
		jp		z,.COLORES_AGUJERO_POSE_3

.COLORES_AGUJERO_POSE_2:

		ld		hl,COLOR_DEPH_AGUJERO_0
		jp		.SIGUE_TRAS_COLORES_AGUJERO

.COLORES_AGUJERO_POSE_1:

		ld		hl,COLOR_DEPH_AGUJERO_1
		jp		.SIGUE_TRAS_COLORES_AGUJERO

.COLORES_AGUJERO_POSE_3:

		ld		hl,COLOR_DEPH_AGUJERO_2

.SIGUE_TRAS_COLORES_AGUJERO:

		ld		de,#4840
		ld		bc,96
        call  	PAGE_32_A_SEGMENT_2
		call	PON_COLOR_2.sin_bc_impuesta
		
		pop		ix
        call   	PAGE_10_A_SEGMENT_2

		jp		PINTA_SPRITE_DEPH.atributos

.COLORES_NORMALES:

		ld		a,(FOTOGRAMA_DEPH_EN_ORDEN)
		cp		2
		jp		z,.COLORES_POSE_1
		cp		0
		jp		z,.COLORES_POSE_3
		
.COLORES_POSE_0_2:

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		z,.COLORES_POSE_0_2_CON_CASCOS

.COLORES_POSE_0_2_SIN_CASCOS:		
		
		ld		hl,COLOR_POSE_0_Y_2
		jp		.SIGUE_TRAS_COLORES

.COLORES_POSE_0_2_CON_CASCOS:

		ld		hl,COLORES_DEPH_CASCOS_POSE_0_Y_2
		jp		.SIGUE_TRAS_COLORES

.COLORES_POSE_1:

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		z,.COLORES_POSE_1_CON_CASCOS

.COLORES_POSE_1_SIN_CASCOS:		

		ld		hl,COLOR_POSE_1
		jp		.SIGUE_TRAS_COLORES

.COLORES_POSE_1_CON_CASCOS:

		ld		hl,COLORES_DEPH_CASCOS_POSE_1
		jp		.SIGUE_TRAS_COLORES

.COLORES_POSE_3:

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		z,.COLORES_POSE_3_CON_CASCOS

.COLORES_POSE_3_SIN_CASCOS:		

		ld		hl,COLOR_POSE_3
		jp		.SIGUE_TRAS_COLORES

.COLORES_POSE_3_CON_CASCOS:

		ld		hl,COLORES_DEPH_CASCOS_POSE_3

.SIGUE_TRAS_COLORES:

        call    PAGE_32_A_SEGMENT_2

		ld		de,#4840
		ld		bc,96
		call	PON_COLOR_2.sin_bc_impuesta
        call    PAGE_10_A_SEGMENT_2

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		nz,.cabeza_normal


.cabeza_cascos:

		ld		hl,COLOR_DEPH_CASCOS
		jp		.final_color_cabeza

.cabeza_normal:

		ld		hl,COLORES_SPRITES_DEPH

.final_color_cabeza:

        call    PAGE_32_A_SEGMENT_2

		ld		de,#4800
		ld		bc,64
		call	PON_COLOR_2.sin_bc_impuesta
        call    PAGE_10_A_SEGMENT_2


		pop		ix

.atributos:		
		
		ld		hl,ATRIBUTOS_DEPH_VARIABLES	
		ld		de,#4A00												; Pinta al prota
		ld		bc,40
		jp		PON_COLOR_2.sin_bc_impuesta

PUNTERO_EN_TABLA_SIN_DE:

			pop		de
SITUAMOS_PUNTERO_EN_TABLA:
				
		ld 		h,0														; Si son valores de 16 bits se puede dar el valor de numero_en_la_lista a hl directamente
		ld 		l,a		

SITUAMOS_PUNTERO_EN_TABLA_DESDE_HL_YA_MARCADA:

		add 	hl,hl													; se multiplica el valor por 2 ya que cada dirección de memoria son 2 bytes
		
		add 	hl,de													; HL ya está apuntando a la posicion correcta de la tabla
							
		ld 		e,(hl)													; Extraemos la direccion de la etiqueta
		inc 	hl
		ld 		d,(hl)													; HL ya tiene la direccion de salto
		ex 		de,hl
		jp 		(hl)													; Saltamos a HL

LEE_REGISTRO_PARA_HMMC: 
		
		di
		
		out ($99),a														;Name : ReadReg
		ld a,15+128														;Description : Reads VDP
		out ($99),a														;Input : A=n (VDP register)
		in a,($99)														;Output : A=S#n
		
		ei
		
		ret
HMMC: 																	;en hl metemos los datos para los registros hmmc
		
																		;en de metemos la dirección de los bits a copiar LA DIRECCION DE MEMORIA

		ld a,2
		call LEE_REGISTRO_PARA_HMMC
		and 1
		jr nz,HMMC 										;Si el VDP no está libre, no sigue con la acción

		xor a
		call LEE_REGISTRO_PARA_HMMC 									; "resetea" los registros de lectura del VDP

		push	hl
		pop		ix														;Pasamos el material de hl a ix

		ld 		a,[de]													;Nos centramos en los 4 bits bajos de la primera dirección de de
		inc		de														;incrementamos de para luego ya tenerlo apuntando a donde interesa

		ld a,36 														;cargamos el primer registro a escribir
		
		di
		
		out ($99),a
		ld a,17+128 													;sistema automático de autoincremento
		out ($99),a
		ld c,$9B
		
		REPEAT 11
		outi 															;ejecutamos 11 outi uno por cada registro
		ENDREPEAT
		
		ld a,44+128
		out ($99),a
		ld a,17+128 													;establece el registro para escribir datos y establece el autoincrement
		out ($99),a

		ei
		
		ex de,hl 														;intercambiamos de con hl y ahora hl apunta al gráfico

ESPERA_A_QUE_TERMINE_LO_ANTERIOR: 

		ld a,2															;vamos a fijarnos en el registro 2
		call LEE_REGISTRO_PARA_HMMC 									;lee el registro 2

		bit 0,a															;pone en a el valor del bit 0 del registro 2, aquí indica si ha terminado la acción
		jp z,FIN_SENTENCIA_VDP											;si el bit está  a 0 es que ya ha terminado y va a salir del tema
		bit 7,a															;nos fijamos ahora en el bit 7, aquí nos dice si ha terminado de realizar la parte concreta dentro de toda la acción
		jp z,ESPERA_A_QUE_TERMINE_LO_ANTERIOR 							;si es 1, no ha terminado, por lo que vuelve a atrás a esperar.

		ld	a,[hl]														;cargamos en a el valor de los 4 bits de hl (el siguiente pixel a pintar
		
		di
		out	[#9b],a			
		ei											;transferimos el byte al registro 9 para que sepa lo que debe pintar después
		inc	hl															;incrementamos hl para la siguiente lectura


		jp ESPERA_A_QUE_TERMINE_LO_ANTERIOR 							;loop ya que no ha terminado de pintarlo todo

FIN_SENTENCIA_VDP: 

		xor a
		call LEE_REGISTRO_PARA_HMMC 									;Limpia el VDP
		
		ret

ENASCR_RAM:  
		
		ld      a,(RG1SAV)
        or      040H
        jr      A057C
;
DISSCR_RAM:  
		ld      a,(RG1SAV)
        and     0BFH
A057C:	
		ld      b,a
        ld      c,001H
		jp		A057F
		
SNSMAT_RAM:

		ld      c,a
        di
        in      a,(0AAH)
        and     0F0H
        add     a,c
        out     (0AAH),a
        in      a,(0A9H)
        ei
        ret
XOR_NZ_RAM:

		ld		a,l
		xor		e
		ret		nz
		ld		a,h
		xor		d
		ret		
XOR_Z_RAM:

		ld		a,l
		xor		e
		ret		nz
		ld		a,h
		xor		d
		ret
DCOMPR_RAM:

		ld		a,h
		sub		d
		ret		nz
		ld		a,l
		sub		e
		ret
A110C:  
		ld      a,00EH
A110E:  
		out     (0A0H),a
        in      a,(0A2H)
        ret
GTSTCK_RAM:

		dec     a
        jp      m,A1200
        call    A120C
        ld      hl,T1233
A11F8:  
		and     00FH
        ld      e,a
        ld      d,000H
        add     hl,de
        ld      a,(hl)
        ret

A1200:  
		call    A1226
        rrca
        rrca
        rrca
        rrca
        ld      hl,T1243
        jr      A11F8

A120C:  
		ld      b,a
        ld      a,00FH
        di
        call    A110E
        djnz    A121B
        and     0DFH
        or      04CH
        jr      A121F

A121B:  
		and     0AFH
        or      003H
A121F:  
		out     (0A1H),a
        call    A110C
        ei
        ret
A1226:  
		di
        in      a,(0AAH)
        and     0F0H
        add     a,008H
        out     (0AAH),a
        in      a,(0A9H)
        ei
        ret

T1233:  
		db      0,5,1,0,3,4,2,3,7,6,8,7,0,5,1,0

T1243:  
		db      0,3,5,4,1,2,0,3,7,0,6,5,8,1,7,0

GTTRIG_RAM:

		dec     a
        jp      m,A126C
        push    af
        and     001H
        call    A120C
        pop     bc
        dec     b
        dec     b
        ld      b,010H
        jp      m,A1267
        ld      b,020H
A1267:  
		and     b
A1268:  
		sub     001H
        sbc     a,a
        ret
;
A126C:  
		call    A1226
        and     001H
        jr      A1268

A057F:  
		ld      a,b
        di
        out     (099H),a
        ld      a,c
        or      080H
        out     (099H),a
        ei
        push    hl
        ld      a,b
        ld      b,000H
        ld      hl,RG0SAV
        add     hl,bc
        ld      (hl),a
        pop     hl
        ret
A07DF:  
		ld      a,l
        di
        out     (099H),a
        ld      a,h
        and     03FH
        or      040H
        out     (099H),a
        ei
        ret
CHGCOLOR_RAM:

		ld      a,(#FCAF)
        dec     a
        jp      m,A0824
        push    af
        call    A0832
        pop     af
        ret     nz
        ld      a,(FORCLR)
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        ld      hl,BAKCLR
        or      (hl)
        ld      hl,(#F3BF)
        ld      bc,32
A0815:  
		push    af
        call    A07DF
A0819:  
		pop     af
        out     (098H),a
        push    af
        dec     bc
        ld      a,c
        or      b
        jr      nz,A0819
        pop     af
        ret	
A0824:  
		ld      a,(FORCLR)
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        ld      hl,BAKCLR
        or      (hl)
        ld      b,a
        jr      A0835	
A0832:  
		ld      a,(BDRCLR)
A0835:  
		ld      b,a
        ld      c,007H
        jp      A057F

NUESTRAS_INT:

		ld		a,1																; ponemos registro de estado 1 
		out 	(099h),a
		ld 		a,128+15
		out 	(099h),a
		in		a,(99h)													; Al leer el registro 0 (obligatorio en cada VBLANK) permitimos que se reinicie el VBLANK
		rrca			
		
		jp		c,INTERRUPCION_DE_LINEA									; Si hay carry->linea de interrupcion!!
	
		xor		a 														; Ponemos registro de estado 0 
		out 	(099h),a												; Antes de salir o se puede colgar!!
		ld 		a,128+15
		out 	(099h),a

		in		a,(099h)												; Es un VBLANK o otro tipo de interrupcion????
		rlca
		jp		c,INTERRUPCION_DE_VBLANK
		
		ret
			
INTERRUPCION_DE_VBLANK:

		ld		a,(SET_PAGE)
		call	SETPAGE

.activamos_sprites:

		ld 		a,(RG8SAV)												; Los activamos
		and		11111101B

		ld		b,a
		ld		c,8
		call	WRTVDP_EN_RAM	

		ld		a,(TIEMPO_DE_ADJUST)
		or		a
		jp		z,.adjust_adecuado

.adjust_aleatorio:

		ld		a,(COLOR_ALEATORIO)
		or		a
		jp		nz,.adjust_aleatorio_2

		ld		a,r
		and		00001111B
		ld		(BDRCLR),a
		call	CHGCOLOR_RAM		

.adjust_aleatorio_2:

		ld		a,(VARIABLE_UN_USO)
		inc		a
		ld		(VARIABLE_UN_USO),a
		and		00000001b
		or		a
		jp		z,.puntoscroll

		ld		a,r
		and		00000111B		
		jp		.adjust_conjunto

.adjust_adecuado:

		xor		a
		ld		(BDRCLR),a
		call	CHGCOLOR_RAM			
		xor		a

.adjust_conjunto:

		ld		b,a
		ld		c,18
		call	WRTVDP_EN_RAM
.puntoscroll:
		ld		a,(PUNTO_DEL_SCROLL)
		di																; Desconectamos las interrupciones
		out		(#99),a													; Apuntamos el dato a poner en el registro
	
		ld		a,23+128												; Cargamos el valor de registro con el bit 8 establecido (+128)
		ei																; Contectamos las interrupciones que se conectarán después de la siguiente orden
		out		(#99),a													; Apuntamos al registro adecuado (en este caso el 23 para el scroll)

PALETA_ESCOGIDA:

		ld		a,(ESTADO_COLOR_PERM)
        ld      de,.TABLA_DE_PALETA_SEGUN_FASE
        jp    	SITUAMOS_PUNTERO_EN_TABLA

.TABLA_DE_PALETA_SEGUN_FASE:

		dw		PALETA_ESCOGIDA.A_PALETA_1
		dw		PALETA_ESCOGIDA.A_PALETA_2
		dw		PALETA_ESCOGIDA.A_PALETA_3
		dw		PALETA_ESCOGIDA.A_FADE_IN_PALETA_1
		dw		PALETA_ESCOGIDA.A_FADE_GRIS_A_BLANCO
		dw		PALETA_ESCOGIDA.A_FADE_IN_PALETA_2
		dw		PALETA_ESCOGIDA.A_FADE_BLANCO_A_NEGRO
		dw		RETORNO;A_FADE_IN_3
		dw		RETORNO;A_FADE_OUT_3
		dw		PALETA_ESCOGIDA.A_PALETA_GRIS
		dw		PALETA_ESCOGIDA.A_PALETA_NEGRA
		dw		PALETA_ESCOGIDA.A_FADE_OUT_GRIS

.A_PALETA_1:

		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2	
		ld		hl,PALETA_STAGE_1_1
		jp		.COMUN_PALETAS_1

.A_PALETA_2:

		ld		a,(TOCA_PERMUTACION)
		inc		a
		and		00000111B
		ld		(TOCA_PERMUTACION),a
		or		a
		jp		nz,.A_PALETA_2_2

		ld		a,(QUE_PERMUTACION)
		add		32
		ld		(QUE_PERMUTACION),a
		cp		192
		jp		nz,.A_PALETA_2_2

		xor		a
		ld		(QUE_PERMUTACION),a
		
.A_PALETA_2_2:		
		
		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_STAGE_1_2_1
		call	.COMUN_PALETAS_5
		jp		.COMUN_PALETAS_2

.A_PALETA_3:

		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_STAGE_1_3
		jp		.COMUN_PALETAS_2

.A_FADE_IN_PALETA_1:

		call	.COMUN_PALETAS_3
		jp		nz,.A_FADE_IN_PALETA_1_2

		call	.COMUN_PALETAS_4
		jp		nz,.A_FADE_IN_PALETA_1_2

		xor		a
		ld		(QUE_PERMUTACION),a
		ld		(ESTADO_COLOR_PERM),a
		jp		.posibles_fx
		
.A_FADE_IN_PALETA_1_2:		
		
		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_STAGE_1_1_FADE_IN
		call	.COMUN_PALETAS_5
		jp		.COMUN_PALETAS_2

.A_FADE_IN_PALETA_2:

		call	.COMUN_PALETAS_3
		jp		nz,.A_FADE_IN_PALETA_2_2

		call	.COMUN_PALETAS_4
		jp		nz,.A_FADE_IN_PALETA_2_2

		xor		a
		ld		(QUE_PERMUTACION),a
		ld		a,1
		ld		(ESTADO_COLOR_PERM),a
		jp		.posibles_fx
		
.A_FADE_IN_PALETA_2_2:		
		
		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_STAGE_2_2_FADE_IN
		call	.COMUN_PALETAS_5
		jp		.COMUN_PALETAS_2

.A_FADE_OUT_GRIS:

		call	.COMUN_PALETAS_3
		jp		nz,.A_FADE_OUT_GRIS_2

		call	.COMUN_PALETAS_4
		jp		nz,.A_FADE_OUT_GRIS_2

		call	DISSCR_RAM

		ld		a,10
		ld		(ESTADO_COLOR_PERM),a
		jp		.posibles_fx
		
.A_FADE_OUT_GRIS_2:		
		
		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_GRISES_FADE_OUT
		call	.COMUN_PALETAS_5
		jp		.COMUN_PALETAS_2

.A_FADE_GRIS_A_BLANCO:

		call	.COMUN_PALETAS_3
		jp		nz,.A_FADE_OUT_GRIS_A_BLANCO_2

		call	.COMUN_PALETAS_4
		jp		nz,.A_FADE_OUT_GRIS_A_BLANCO_2

		call	DISSCR_RAM

		ld		a,6
		ld		(ESTADO_COLOR_PERM),a
		jp		.posibles_fx
		
.A_FADE_OUT_GRIS_A_BLANCO_2:		
		
		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_GRIS_BLANCO_1
		call	.COMUN_PALETAS_5
		jp		.COMUN_PALETAS_2

.A_FADE_BLANCO_A_NEGRO:

		call	ENASCR_RAM

		call	.COMUN_PALETAS_3
		jp		nz,.A_FADE_OUT_BLANCO_A_NEGRO_2

		call	.COMUN_PALETAS_4
		jp		nz,.A_FADE_OUT_BLANCO_A_NEGRO_2

		call	DISSCR_RAM

		ld		a,10
		ld		(ESTADO_COLOR_PERM),a
		jp		.posibles_fx
		
.A_FADE_OUT_BLANCO_A_NEGRO_2:		
		
		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_BLANCO_NEGRO_1
		call	.COMUN_PALETAS_5
		jp		.COMUN_PALETAS_2
		
.A_PALETA_GRIS:

		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_GRISES
		jp		.COMUN_PALETAS_2

.A_PALETA_NEGRA:

		call	.COMUN_PALETAS_1												; Cambiamos la página del bloque 2													; Cambiamos la página del bloque 2	
		ld		hl,PALETA_OSCURO_STAGE_1
		jp		.COMUN_PALETAS_2

.COMUN_PALETAS_1:

		ld		a,(FASE)
		add		32
		ld		[DIRPA2],a	
		ret

.COMUN_PALETAS_2:

		call	SETPALETE
		jp		.posibles_fx

.COMUN_PALETAS_3:

		ld		a,(TOCA_PERMUTACION)
		inc		a
		and		00000011B
		ld		(TOCA_PERMUTACION),a
		or		a
		ret

.COMUN_PALETAS_4:

		ld		a,(QUE_PERMUTACION)
		add		32
		ld		(QUE_PERMUTACION),a
		or		a
		ret

.COMUN_PALETAS_5:

		ld		de,(QUE_PERMUTACION)
		ld		d,0
		or		a
		adc		hl,de
		ret

.posibles_fx:

		ld		a,(FX_ON_OFF)
		or		a
		jp		z,.ahora_la_musica

		ld		a,31
		ld		(DIRPA2),a

		call	AYfx_ROUT
		call	ayFX_PLAY

.ahora_la_musica:

		ld		a,(MUSICA_BEST_ON)
		or		a
		jp		z,.musica_normal

.musica_inusual:

		ld		a,39
		jp		.resolucion_musica

.musica_normal:

		ld		a,(FASE)
		add		20

.resolucion_musica:

		ld		(DIRPA2),a

		call	musint
		
		ld		a,(PAGE_A_GUARDAR)
		ld		(DIRPA2),a

		ret
INTERRUPCION_DE_LINEA:

		ld		a,2   													; Ponemos registro de estado 2 
		out 	(#99),a
		ld 		a,128+15
		out 	(#99),a

;Poll_1:																; Esperas. Depende un poco del juego y demas, hay que hacer 1 o 2

;		in		a,(099h)												; Aguanta hasta que empieza HBLANK
;		and		%00100000
;		jr		nz,Poll_1

;Poll_2: 

;		in		a,(099h)												; Aguanta hasta que empieza HBLANK
;		and		%00100000
;		jr		z,Poll_2

																		; Aqui ya hemos esperado a que termine de pintar la linea...	
						
;	[10] NOP

;		ld		a,(HAY_QUE_PINTAR_MARC)
;		cp		1
;		call	z,PINTAMOS_EL_MARCADOR_QUE_DESAPARECERA	

		ld		a,(ESTADO_MARCADOR)
		or		a
		ret		z

		ld 		a,(RG8SAV)												; Desactivamos los sprites
		or		00000010B
		ld 		(RG8SAV),a			
		ld		b,a
		ld		c,8
		call	WRTVDP_EN_RAM

.escoge_marcador:

		ld		a,(CAMINO_NUEVA_INT)
		ld		b,a
		ld		a,(PUNTO_DEL_SCROLL)
		add		b
		cp		65
		jp		nc,.segundo_marcador

.primer_marcador:
		xor		a
		ld		b,a
		ld		c,18
		call	WRTVDP_EN_RAM

		ld		a,0
		call	SETPAGE
		ld		a,33
		ld		(DIRPA2),a	
		ld		hl,PALETA_MARCADOR_STAGE_1
		call	SETPALETE
		ld		a,(CAMINO_NUEVA_INT)
		ld		b,a
		ld		a,64
		sub		b
		ld		b,a
		ld		c,23
		call	WRTVDP_EN_RAM	
							
		jp		.fin
		
.segundo_marcador:
		xor		a
		ld		b,a
		ld		c,18
		call	WRTVDP_EN_RAM

		ld		a,3
		call	SETPAGE	
		ld		a,33
		ld		(DIRPA2),a	
		ld		hl,PALETA_MARCADOR_STAGE_1
		call	SETPALETE
		ld		a,(CAMINO_NUEVA_INT)
		ld		b,a
		ld		a,10
		sub		b
		ld		b,a
		ld		c,23
		call	WRTVDP_EN_RAM

.fin:

		ld		a,(PAGE_A_GUARDAR)
		ld		[DIRPA2],a												; Cambiamos la página del bloque 2	

		xor		a 														; Ponemos registro de estado 0 
		out 	(099h),a												; Antes de salir o se puede colgar
		ld 		a,128+15
		out 	(099h),a
		
		in		a,(099h)												; Lo leemos para evitar cuelgues...
													
		ret
INTRODUCIMOS_LINEA_DE_INTERRUPCION_NUEVA:

		ld 		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)													
		ld		b,a
		ld		c,19
		call	WRTVDP_EN_RAM


		ld		a,(ESTADO_MARCADOR)
		or		a
		ret		z

		push	ix

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		add		2
		ld		ix,DATOS_DEL_CUADRADO_NEGRO
		ld		(ix+6),a
		ld		hl,DATOS_DEL_CUADRADO_NEGRO
		call	DOCOPY
		pop		ix
		ret
			
RESCATA_ENTORNO:

		push	ix														; Salvamos IX
		
		push	af
		ld		a,(FASE)
		add		32
		call	CHANGE_BANK_2
		pop		af

		call	SITUA_LA_X_E_Y
		add		6
		call	SITUA_LA_X_E_Y_2

		ld		a,(ix)
		ld		(TILE_N),a												; Empezamos a capturar el valor de los tiles de su alrededor para usarlos después						
		
		ld		de,16
		add		ix,de
		ld		a,(ix)
		ld		(TILE_S),a

		call	SITUA_LA_X_E_Y
		add		14
		call	SITUA_LA_X_E_Y_2

		ld		a,(ix)
		ld		(TILE_N2),a						

		ld		de,16
		add		ix,de
		ld		a,(ix)
		ld		(TILE_S2),a


		call	SITUA_LA_X_E_Y
		add		4
		call	SITUA_LA_X_E_Y_2

		ld		de,16
		add		ix,de
		ld		a,(ix)
		ld		(TILE_O),a

		call	SITUA_LA_X_E_Y
		sub		1
		call	SITUA_LA_X_E_Y_2

		ld		de,17
		add		ix,de
		ld		a,(ix)
		ld		(TILE_E),a

        call    PAGE_10_A_SEGMENT_2


		pop		ix
		
		ret

FUERA_DE_PANTALLA:

		ld		a,(LIM_MUERTE)
		ld		b,a
		ld		a,(CONTROL_Y)

		cp		b
		jp		z,MUERTE_POR_APLASTAMIENTO_MENOS_RET
		
		ret

SITUA_LA_X_E_Y:

		ld		ix,MAPA_CONSTANTE_FASE_1								; Colocamos el puntero de IX en el mapa de constantes
		ld		de,(LINEA_A_LEER)
[16]	add		ix,de													; Le añadimos tantas lineas Y como en la que está empezando a pintar la pantalla multiplicado por 16 tiles cada linea										
		ld		a,(Y_PINTA_SCROLL)
[4]		srl		a		
		ld		b,a
		ld		a,(Y_DEPH)
[4]		srl		a		
		sub		b
[4]		add		a								
		ld		e,a
		ld		d,0
		add		ix,de													; Le añadimos tantas lineas como aquellas que separan el compienzo de pintado del sprite

		ld		de,16
		add		ix,de
		ld		a,(X_DEPH)

		ret

SITUA_LA_X_E_Y_2:

[4]		SRL		a
		ld		e,a
		ld		d,0
		add		ix,de	

		ret
HIDE_STATUS:

		ld		a,(MARCADOR_ANULADO)
		or		a
		jp		nz,CONTROL.teclado	
		
		call	HIDE_STATUS_RET
		jp		CONTROL.teclado	

HIDE_STATUS_COMP:

		ld		a,1
		ld		(MARCADOR_ANULADO),a

		ld		a,(HACIA_DONDE_INTERRUPT)
		or		a
		ret		nz

		jp		HIDE_STATUS_RET_SIN_CONTROL
SHOW_STATUS_COMP:

		xor		a
		ld		(MARCADOR_ANULADO),a

		ld		a,(HACIA_DONDE_INTERRUPT)
		or		a
		ret		z

		jp		HIDE_STATUS_RET_SIN_CONTROL

HIDE_STATUS_RET:

		ld		a,(MARCADOR_PULSADO)
		or		a
		ret		nz

HIDE_STATUS_RET_SIN_CONTROL:

		ld		a,1
		ld		(MARCADOR_PULSADO),a
		
		ld		a,(HACIA_DONDE_INTERRUPT)
		cp		1
		ret		z
		cp		3
		ret		z
		inc		a
		ld		(HACIA_DONDE_INTERRUPT),a

		ret

CARGA_DEPH_MUSIC_ON:

			ld		hl,TODOS_LOS_SPRITES									; Depositamos los sprites en vram	
			jp		COMUN_CARGA_DEPH

CARGA_DEPH_MUSIC_OFF:

			ld		hl,SPRITES_DEPH_CASCOS									; Depositamos los sprites en vram	

COMUN_CARGA_DEPH:

		call	PAGE_32_A_SEGMENT_2
		ld		de,#4020
		ld		bc,704
		call	PON_COLOR_2.sin_bc_impuesta
		jp		PAGE_10_A_SEGMENT_2

EFECTOS_ON_OFF:

		ld		a,(MARCADOR_PULSADO)								; Si ya pulsamos el botón, no sirve hasta que lo sueltes
		or		a
		jp		nz,CONTROL.teclado

		ld		a,1													; Bloqueamos la posibilidad de pulsar el botón para evitar que se pulse dos veces
		ld		(MARCADOR_PULSADO),a

		ld		a,(FX_ON_OFF)
		or		a
		jp		z,.encendemos

.apagamos:

		call	GICINI

		xor		a
		ld		(FX_ON_OFF),a
		jp		CONTROL.teclado

.encendemos:

		ld		a,1
		ld		(FX_ON_OFF),a
		jp		CONTROL.teclado
MUSIC_ON_OFF:

		ld		a,(MARCADOR_PULSADO)								; Si ya pulsamos el botón, no sirve hasta que lo sueltes
		or		a
		jp		nz,CONTROL.teclado

		ld		a,(FMPAC_DESCONECTADO)
		or		a
		jp		z,CONTROL.teclado

		ld		a,1													; Bloqueamos la posibilidad de pulsar el botón para evitar que se pulse dos veces
		ld		(MARCADOR_PULSADO),a

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		z,.encendemos

.apagamos:

		xor		a
		ld		(MUSICA_ON_OFF),a
		call	stpmus
		call	CARGA_DEPH_MUSIC_OFF
		jp		CONTROL.teclado

.encendemos:

		ld		a,1
		ld		(MUSICA_ON_OFF),a
		ld		a,(FASE)
		add		20
		call	CHANGE_BANK_2
		di
		call	strmus
		ei			
		call	PAGE_10_A_SEGMENT_2
		call	CARGA_DEPH_MUSIC_ON
		jp		CONTROL.teclado
PAUSE:

		ld		a,(BLOQUE_DE_SPRITES_VARIABLE)
		push	af
		ld		a,(MARCADOR_PULSADO)								; Si ya pulsamos el botón, no sirve hasta que lo sueltes
		or		a
		jp		nz,CONTROL.teclado

		ld		a,(PAUSA_BLOQUEADA)									; si alguna acción no compatible está sucediendo, no sirve hasta que acabe
		or		a
		jp		nz,CONTROL.teclado

		ld		a,8													; FX en forma de música que anuncia pausa
		ld		c,0
        call    A_31_DESDE_10       


		di															; Paramos la música
		call	hltmus
		ei
		call	GICINI

		ld		a,1													; Bloqueamos la posibilidad de pulsar el botón para evitar que se pulse dos veces
		ld		(MARCADOR_PULSADO),a

		ld		a,(TIEMPO_DE_ADJUST)
		ld		(VARIABLE_UN_USO),a
		xor		a
		ld		(TIEMPO_DE_ADJUST),a
		
		call	PINTA_DEPH_NEUTRO
		ld		hl,SPRITES_EJERCICIO
		call	PAGE_32_A_SEGMENT_2
		ld		de,#4160
		ld		bc,480
		call	PON_COLOR_2.sin_bc_impuesta
		call	PAGE_10_A_SEGMENT_2

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		nz,.bucle1

		ld		hl,SPRITES_DEPH_CASCOS
		call	PAGE_32_A_SEGMENT_2
		ld		de,#4160
		ld		bc,128
		call	PON_COLOR_2.sin_bc_impuesta

		ld		hl,SPRITES_DEPH_CASCOS_EJERCICIO_MANOS_ARRIBA
		ld		de,#41E0
		ld		bc,192
		call	PON_COLOR_2.sin_bc_impuesta
		call	PAGE_10_A_SEGMENT_2

.bucle1:

		ld		a,6														;si aun está pulsado f1 creamos un bucle
	    call	SNSMAT_RAM 
		bit		5,a
		jp		z,.bucle1

.bucle2:

		call	.HACIENDO_EJERCICIO

		ld		a,(ESTADO_EJERCICIO)
		inc		a
		and		00000011B
		ld		(ESTADO_EJERCICIO),a
		ld		b,40

.bucle3:

		ei
		halt
		ld		a,6														;si pulsa f1 volvemos
	    call	SNSMAT_RAM  
		bit		5,a
		jp		z,.bucle4
		djnz	.bucle3
		jp		.bucle2

.bucle4:

		halt
		call	RECUPERA_SPRITES_SALUDO
		call	CARGA_1_A_45
;		call	CARGA_SKRULLEX_SLIME

		ld		a,(FIREWORKS_ACTIVO)
		or		a
		jp		z,.bucle4_1

		call	CARGA_FIREWORKS

.bucle4_1:

		ld		a,(ECTOPALLERS_ACTIVO)
		or		a
		jp		z,.bucle4_2

		call	CARGA_ECTO_PALLER

.bucle4_2:

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		nz,.bucle4_3

		call	CARGA_DEPH_MUSIC_OFF

.bucle4_3:

		ld		a,(ARMA_USANDO)
		cp		2
		jp		nz,PAUSE.bucle4_4

		call	CARGA_FLECHA_DOBLE
.bucle4_4:

		ld		a,(ALPHONSERRYX_ACTIVO)
		cp		1
		jp		nz,PAUSE.bucle5

		call	CARGA_ALFONSERRYX_STAGE_4

.bucle5:

		ld		a,(VARIABLE_UN_USO)
		ld		(TIEMPO_DE_ADJUST),a	

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		z,CONTROL.teclado
		
        ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2
		call	cntmus
		call	PAGE_10_A_SEGMENT_2

		jp		CONTROL.teclado
		
.bucle:

		push	bc
		ld		hl,Y_LINEA_INT
		ld		bc,1
		call	PAGE_32_A_SEGMENT_2		
		call	PON_COLOR_2.sin_bc_impuesta
		call	PAGE_10_A_SEGMENT_2
		push	hl
		pop		de
		ld		de,4
		or		a
		add		hl,de
		ex		de,hl
		pop		bc
		
		djnz	.bucle
		
		ret

.HACIENDO_EJERCICIO:

		push	ix														; Pintamos los datos a la variable ATRIBUTOS_DEPH_VARIABLES para luego hacer un copy directo a vram
		
		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		ld		a,(ESTADO_EJERCICIO)
		cp		1
		jp		z,.arriba
		cp		3
		jp		z,.abajo

.neutro:

		call	PINTA_DEPH_NEUTRO	

		pop		ix
		ret

.arriba:

		ld		a,11*4
		ld		de,4
		ld		b,10

.bucle_de_arriba:

		ld		(ix+2),a
		add		4
		add		ix,de
		djnz	.bucle_de_arriba

		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		nz,.color_arriba_normal

.color_arriba_cascos:

		ld		hl,COLOR_EJERCICIO_1_CASCOS
		jp		.ejecuta_el_color

.color_arriba_normal:

		ld		hl,COLOR_EJERCICIO_1

.ejecuta_el_color:

        call    PAGE_32_A_SEGMENT_2

		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM_SIN_HL

		call	VUELCA_DATOS_DEPH_A_VRAM

		pop		ix
		ret

.abajo:		

		xor		a
		ld		(ix+38),a
		ld		de,4
		ld		b,4

.bucle_de_abajo_ceros:

		ld		(ix+2),a
		add		ix,de		
		djnz	.bucle_de_abajo_ceros
		ld		ix,ATRIBUTOS_DEPH_VARIABLES

		ld		a,84
		ld		b,5

.bucle_de_abajo_cinco:

		ld		(ix+18),a
		add		4
		add		ix,de
		djnz	.bucle_de_abajo_cinco

		ld		hl,COLOR_EJERCICIO_2
        call    PAGE_32_A_SEGMENT_2

		ld		de,#4800+(4*8*2)
		ld		bc,80
		call	PON_COLOR_2.sin_bc_impuesta
        call    PAGE_10_A_SEGMENT_2

		call	VUELCA_DATOS_DEPH_A_VRAM

		pop		ix
		ret

CAMBIAMOS_LA_INTERRUPCION_DE_LINEA_PARA_DESAPARECER:

		ld		a,(HACIA_DONDE_INTERRUPT)
		cp		1
		jp		z,.subiendo
		cp		3
		jp		z,.bajando
		ret

.bajando:

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		dec		a
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a

		ld		a,(Y_LINEA_INT)
		dec		a
		ld		(Y_LINEA_INT),a

		ld		a,(LIM_MUERTE)
		dec		a
		ld		(LIM_MUERTE),a
		
		ld		a,(CONTROL_Y)
		cp		190
		jp		c,.bajando2
		sub		10
		ld		(CONTROL_Y),a
		ld		a,(Y_DEPH)
		sub		10
		ld		(Y_DEPH),a
		
.bajando2:
		
		ld		a,(CAMINO_NUEVA_INT)
		dec		a
		ld		(CAMINO_NUEVA_INT),a

		ld		a,159
		jp		.fin
		
.subiendo:

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		inc		a
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a

		ld		a,(Y_LINEA_INT)
		inc		a
		ld		(Y_LINEA_INT),a

		ld		a,(LIM_MUERTE)
		inc		a
		ld		(LIM_MUERTE),a

		ld		a,(CAMINO_NUEVA_INT)
		inc		a
		ld		(CAMINO_NUEVA_INT),a

		ld		a,189
.fin:
		
		ld		(LIM_Y_INF),a

		ld		a,(HACIA_DONDE_INTERRUPT)
		cp		1
		jp		z,.revisa_si_desaparece

.revisa_si_aparece:

		ld		a,1
		ld		(ESTADO_MARCADOR),a

		ld		a,(CAMINO_NUEVA_INT)
		or		a
		ret		nz

		xor		a
		ld		(HACIA_DONDE_INTERRUPT),a

		ret

.revisa_si_desaparece:

		ld		a,(CAMINO_NUEVA_INT)
		cp		20
		ret		nz
		ld		a,2
		ld		(HACIA_DONDE_INTERRUPT),a
		xor		a
		ld		(ESTADO_MARCADOR),a
		ret
MUERTE_POR_APLASTAMIENTO_MENOS_RET:

		pop		af
		jp		MUERTE_POR_APLASTAMIENTO

MUERTE_POR_TOQUES:

		xor		a
		ld		(TIEMPO_DE_ADJUST),a

			; PARAMOS MÚSICA

		call	stpmus
			
			; QUITAMOS SPRITES QUE NO TOCA

		call	BORRA_SPRITES_ACTIVOS
		call	APARTAMOS_SPRITES_QUE_MOLESTAN			
		call	BUCLE_PINTA_TILES.PINTA_PALETA_GRIS

			; PONEMOS SPRITES NEUTROS
		call	PINTA_DEPH_NEUTRO

		ld		a,100
		call	BUCLE_PINTA_TILES.rutina_de_pausa

			; CARGAMOS SPRITES MUERTE
		
		ld		hl,SPRITES_MUERE
		call	RECUPERA_SPRITES_TRAS_MUERTE_SIN_HL

			; PONEMOS SPRITES MUERTE 1

		push	ix														; Pintamos los datos a la variable ATRIBUTOS_DEPH_VARIABLES para luego hacer un copy directo a vram
		
		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		
		ld		a,11*4

		ld		(ix+2),a
		add		4
		ld		(ix+6),a
		add		4
		ld		(ix+10),a
		xor		a
		ld		(ix+14),a

		ld		a,11*4+4+4+4
		ld		(ix+18),a
		add		4
		ld		(ix+22),a
		add		4
		ld		(ix+26),a
		add		4
		ld		(ix+30),a
		add		4
		ld		(ix+34),a
		add		4
		ld		(ix+38),a

		ld		hl,COLOR_MUERTE
        call    PAGE_32_A_SEGMENT_2

		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM_SIN_HL
        call    PAGE_10_A_SEGMENT_2

		call	VUELCA_DATOS_DEPH_A_VRAM

			; PAUSA CORTA

		ld		a,100
		call	BUCLE_PINTA_TILES.rutina_de_pausa

			; PONEMOS SPRITES MUERTE 2
		
		xor		a
		ld		de,4
		ld		b,4
		ld		(ix+38),a

.bucle_5_ceros:

		ld		(ix+2),a
		
		add		ix,de
		djnz	.bucle_5_ceros
		ld		ix,ATRIBUTOS_DEPH_VARIABLES


		ld		a,20*4
		ld		b,5
		
.bucle_5_datos:

		ld		(ix+18),a
		add		4
		add		ix,de
		djnz	.bucle_5_datos
		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		ld		hl,COLOR_MUERTE_2
        call    PAGE_32_A_SEGMENT_2

		ld		de,#4840
		ld		bc,96
		call	PON_COLOR_2.sin_bc_impuesta
        call    PAGE_10_A_SEGMENT_2

		call	VUELCA_DATOS_DEPH_A_VRAM

			; PAUSA LARGA

		ld		a,200
		call	BUCLE_PINTA_TILES.rutina_de_pausa

		pop		ix
		ld		hl,PALETA_GRISES_FADE_OUT

		jp		SALTO_AL_FADEAR_EN_GRISES
MUERTE_POR_APLASTAMIENTO:

		call	stpmus

SALTO_AL_FADEAR_EN_GRISES:

		xor		a
		ld		(ARMA_USANDO),a											; 0 1 2 para flecha 3 4 5 para fuego 6 7 8 para hacha

		ld		a,(VIDAS)
		dec		a
		ld		(VIDAS),a

		ld		a,(VIDAS)
		cp		255
		jp		z,FIN_DE_LA_PARTIDA

		ld		a,11
		ld		(ESTADO_COLOR_PERM),a

		ld		a,100
		call	BUCLE_PINTA_TILES.rutina_de_pausa
		call	DISSCR_RAM		

		ld		a,2
		ld		(CORAZONES),a
		
		call	RECUPERA_SPRITES_TRAS_MUERTE

		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM
			
		di		
		ld		hl,POSICION_PARTIDA_DEPH	
		ld		de,ATRIBUTOS_DEPH_VARIABLES							; Pinta al prota
		ld		bc,40
		ldir		
		ei

		jp		PAGE9_A_SEGMENT_1

BORRA_SPRITES_ACTIVOS:

		ld		b,20
		ld		ix,SPRITES_ACTIVOS
		xor		a
		ld		de,1

.bucle_para_borrar_sprites_activos:

		ld		(ix),a
		add		ix,de
		djnz	.bucle_para_borrar_sprites_activos

		ret
PINTA_DEPH_NEUTRO:

		push	ix
		ld		ix,ATRIBUTOS_DEPH_VARIABLES

		ld		a,4
		LD		B,10
		ld		de,4

.bucle_de_pintado:

		ld		(ix+2),a
		add		4
		add		ix,de
		djnz	.bucle_de_pintado
		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		call	VUELCA_DATOS_DEPH_A_VRAM

		pop		ix
		jp		VUELCA_DATOS_COLORES_DEPH_A_VRAM

RECUPERA_SPRITES_SALUDO:

		halt
		call	CARGA_1_A_45

		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM
        call    PAGE_10_A_SEGMENT_2

		di		
		ld		hl,POSICION_PARTIDA_DEPH	
		ld		de,ATRIBUTOS_DEPH_VARIABLES							; Pinta al prota
		ld		bc,40
		ldir		
		ei
RETORNO:

		ret														; Cuando una sentencia debe ser enviada de vuelta pero tenemos que dar una dirección por narices
VUELCA_DATOS_DEPH_A_VRAM:

		call	PAGE_32_A_SEGMENT_2
		ld		hl,ATRIBUTOS_DEPH_VARIABLES	
		ld		de,#4A00												; Pinta al prota
		ld		bc,40
		jp		PON_COLOR_2.sin_bc_impuesta
		call	PAGE_10_A_SEGMENT_2

VUELCA_DATOS_COLORES_DEPH_A_VRAM:

        call    PAGE_32_A_SEGMENT_2


		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		nz,.color_normal

.color_cascos:

		ld		hl,COLOR_DEPH_CASCOS
        call    PAGE_32_A_SEGMENT_2

		jp		VUELCA_DATOS_COLORES_DEPH_A_VRAM_SIN_HL

.color_normal:

		ld		hl,COLORES_SPRITES_DEPH								; Damos color a los sprites	

VUELCA_DATOS_COLORES_DEPH_A_VRAM_SIN_HL:

		ld		de,#4800
		ld		bc,160
		di
		jp		COMUN_RECUPERA_SPRITES

RECUPERA_SPRITES_TRAS_MUERTE:

		xor		a
		ld		(BLOQUE_DE_SPRITES_VARIABLE),a
		ld		(HAY_CORAZONES),a

RECUPERA_SPRITES_TRAS_PAUSA:

		ld		hl,TODOS_LOS_SPRITES
        call    PAGE_32_A_SEGMENT_2
		ld		de,#4020
		ld		bc,2176
		jp		COMUN_RECUPERA_SPRITES

RECUPERA_SPRITES_TRAS_MUERTE_SIN_HL:

        call    PAGE_32_A_SEGMENT_2

		ld		de,#4160
		ld		bc,544

COMUN_RECUPERA_SPRITES:

		call	PON_COLOR_2.sin_bc_impuesta

        jp    	PAGE_10_A_SEGMENT_2
		
FIN_DE_LA_PARTIDA:

		call	PAGE_10_A_SEGMENT_2

			push	ix														; Pintamos los datos a la variable ATRIBUTOS_DEPH_VARIABLES para luego hacer un copy directo a vram
			ld		ix,ATRIBUTOS_DEPH_VARIABLES
			ld		a,#D8
			ld		(ix),a

			ld		hl,ATRIBUTOS_DEPH_VARIABLES	
			ld		de,#4A00+8*4												; Pinta al prota
			ld		bc,1
			call	PON_COLOR_2.sin_bc_impuesta
			pop		ix

			call	CARGA_SLOT_PARA_GAME_OVER

			xor		a
			ld		(ESTADO_MARCADOR),a

			ld		hl,LIMPIA_PANTALLA_2
	[2]		call	DOCOPY

			xor		a
			ld		(PUNTO_DEL_SCROLL),a		
fin:

			jp		MENU

A_31_DESDE_10:

        call    PAGE_31_A_SEGMENT_2       
        call    ayFX_INIT
        jp      PAGE_10_A_SEGMENT_2

PAGE_10_A_SEGMENT_2:

        push    af
        ld      a,10
        jp      PAGE_COMUN

PAGE_31_A_SEGMENT_2:

        push    af
        ld      a,31
        jp      PAGE_COMUN

PAGE_32_A_SEGMENT_2:

        push    af
        ld      a,32

PAGE_COMUN:

        call    CHANGE_BANK_2
		ei
        pop     af
        ret

PAGE_44_A_SEGMENT_1_MAGIA:

		push	af
		call	PARTE_A	
        call	MAGIA_ROCK

PARTE_B:

        ld		a,(PAGINA_DE_REGRESO)

		di
		ld		[DIRPA1],a												; Cambiamos la página del bloque 2	
		ei	

		pop		ix
		pop     af
		ret		

PARTE_A:

		ld		a,44

		di
		ld		[DIRPA1],a												; Cambiamos la página del bloque 2	
		ei	
		ret

PAGE_44_A_SEGMENT_1_ON_SPRITE_ENEMIGO_DEPH:

		push	af
		push	ix
		call	PARTE_A	
        call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH_ROCK
		jp		PARTE_B

PAGE_44_A_SEGMENT_1_RUTINA_ROCAS:

		push	af
		push	ix
		call	PARTE_A	
        call	RUTINA_ROCAS
		jp		PARTE_B

PAGE_44_A_SEGMENT_1_ON_SPRITE_CON_ROCAS:

		push	af
		push	ix
		call	PARTE_A	
        call	ON_SPRITE_CON_ROCAS
		jp		PARTE_B

PAGE44_A_SEGMENT_1_PINTA_CORAZONES_VIDA_DEPH_ADECUADOS:

		push	af
		push	ix
		call	PARTE_A	
        call	PINTA_CORAZONES_VIDA_DEPH_ADECUADOS
		jp		PARTE_B

PAGE44_A_SEGMENT_1_PINTA_MAGIAS_ROCK:

		push	af
		push	ix
		call	PARTE_A	
        call	PINTAMOS_LOS_PUNTOS_DE_MAGIA_ROCK
		jp		PARTE_B

PAGE44_A_SEGMENT_1_PREPARACION_ROCKAGER:

		push	af
		push	ix
		call	PARTE_A	
        call	PREPARACION_ROCKAGER
		jp		PARTE_B

PAGE_44_A_SEGMENT_1_PINTA_MAREO:

		push	af
		push	ix
		call	PARTE_A	
        call	PINTA_MAREO
		jp		PARTE_B

PAGE9_A_SEGMENT_1:

		call	RECARGAMOS_GRAFICOS_STAGE_X
		ld		a,9
		di
		ld		[DIRPA1],a												; Cambiamos la página del bloque 2	
		ei			
		jp		INICIA_SCROLL	