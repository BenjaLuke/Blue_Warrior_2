COMIENZA_JUEGO:

		ld		a,(FASE)
		dec		a
		jr		z,.limpia_letras_fases
		ld		a,(TRUCO_FASES_ACTIVO)
		or		a
		jr		z,.limpia_solo_sprites
		xor		a

.limpia_letras_fases:

		ld		(LETRAS_FASES_BITS),a
		ld		(LETRAS_FASES_BITS+1),a
		ld		(LETRAS_FASES_BITS+2),a
		ld		(TRUCO_FASES_ACTIVO),a

        xor	    a							                            ; a     = el valor que vamos a poner
        ld	    bc,#ffff						                        ; bc	= longitud del area a rellenar con el dato A
        ld	    hl,#0000						                        ; hl	= dirección en la que empieza a pintar
        call	FILVRM_RAM						                        ; Limpiamos toda esta zona de la VRAM 

.limpia_solo_sprites:

        xor	    a							                            ; a     = el valor que vamos a poner
        ld	    bc,#1980						                        ; bc	= longitud del area a rellenar con el dato A
        ld	    hl,#3B00						                        ; hl	= dirección en la que empieza a pintar
        call	FILVRM_RAM						                        ; Limpiamos toda esta zona de la VRAM 
		
.carga_graficos:

		call	PAGE_10_A_SEGMENT_2

		ld		a,(FASE)
		cp		3
		jr		nz,.INICIO_NO_ES_FASE_3
		xor		a
		jr		.INICIO_TRAMO_FASE_3

.INICIO_NO_ES_FASE_3:

		ld		a,2

.INICIO_TRAMO_FASE_3:

		ld		(TRAMO_FASE_3),a
		ld		(TRAMO_FASE_3_SALVADO),a

		ld		a,(FASE)
		add		32
		ld		(PAGE_DATOS_FASE),a
		ld		(PAGE_DATOS_FASE_SALVADA),a

		ld		a,(FASE)
		add		a
		ld		ix,TABLA_DE_TAMANO_DE_FASE
		ld		e,a
		ld		d,0
		add		ix,de
		ld		l,(ix)
		ld		h,(ix+1)
		ld		(LINEA_SALVADA),hl
		xor		a
		ld		(TILE_ESPECIAL_DEPH_COOLDOWN),a
		ld		(TILE_ESPECIAL_DEPH_BLOQUEOS),a
		call	LIMPIA_BLINDAJE_NACIMIENTO_ENEMIGOS

RECARGAMOS_GRAFICOS_JUEGO_TRAS_MUERTE:
		
		; PAUSA PARA CARGAR LAS LETRAS DEL PREMIO DE LETRAS
		xor		a
		ld		(TENEMOS_D),a
		ld		(TENEMOS_E),a
		ld		(TENEMOS_P),a
		ld		(TENEMOS_H),a
		ld		(CORAZON_CONTENEDOR_COGIDO),a
		; FIN DE LA PAUSA
		
        ld      a,(FASE)
		add		10
        call	CHANGE_BANK_2
                                                                            ; Cargamos el mapa fase
        ld		hl,#8000												; Carga gráficos fase
        ld		de,#8000
        ld		bc,16384
        call	PON_COLOR_2.sin_bc_impuesta

        ld      a,(FASE)
		add		15
        call	CHANGE_BANK_2

        ld		hl,#8000
        ld		de,#c000

		ld		a,(FASE)
		dec		a
		jr		nz,.fin_de_carga

		ld		a,(ESTADO_COLOR_PERM)
		cp		11
		jr		z,.fin_de_carga

		push	hl
		ld		hl,0
		ld		(SCORE_REAL),hl
		pop		hl
		
.fin_de_carga:		

        ld		bc,16384

        call	PON_COLOR_2.sin_bc_impuesta

REENTRA_JUEGO_TRAS_CARGA_GRAFICOS:

		call	DISSCR_RAM

        di

        ld		a,2														; Página 2 a vista
        call	SETPAGE

        ei	
		xor		a
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
        call    PAGE_10_A_SEGMENT_2
		ld		hl,POSICION_COPIA_MARCADOR_1
		call	DOCOPY
		ld		hl,POSICION_COPIA_MARCADOR_2
		call	DOCOPY
			
PREPARACION_SPRITES:
		
		di
			
		ld 		a,(RG1SAV)												; Los hacemos de 16 por 16
		or		00000010B
		ld 		(RG1SAV),a				
		ld		b,a
		ld		c,1
		call	WRTVDP_EN_RAM
			
		ld 		a,(RG8SAV)												; Los activamos
		and		11111101B
		ld 		(RG8SAV),a			
		ld		b,a
		ld		c,8
		call	WRTVDP_EN_RAM		
				
		ld 		a,10010111b												; Colocamos los punteros de atributos en #4A00 (los colores serán #800 antes que este)
		ld 		(RG5SAV),a			
		ld		b,a
		ld		c,5
		call	WRTVDP_EN_RAM		
	
		ld 		a,(RG11SAV)												
		and		11111100B
		ld 		(RG11SAV),a			
		ld		b,a
		ld		c,11
		call	WRTVDP_EN_RAM	
				
		ld 		a,00001000b										; Colocamos el puntero de patrones en #4000
		ld 		(RG6SAV),a			
		ld		b,a
		ld		c,6
		call	WRTVDP_EN_RAM     
		di		
		ld		hl,POSICION_PARTIDA_DEPH	
		ld		de,ATRIBUTOS_DEPH_VARIABLES								; Pinta al prota
		ld		bc,40
		ldir		
		ei

CUADRADO_SEPARADOR:

		ld		hl,CUADRADO_NEGRO_SEPARADOR
		ld		de,DATOS_DEL_CUADRADO_NEGRO							
		ld		bc,15
		ldir				
				
PREPARACION_INTERRUPCIONES:

		call	ACTIVAMOS_INTERRUPCIONES_DE_LINEA

		di																; Desconectamos las interrupciones																	
		ld		a,#C3													; #c3 es el código binario de jump (jp)
		ld		[HKEYI],a												; Metemos en HTIMI ese jp
		ld		hl,NUESTRAS_INT											; Con el jp anterior, construimos jp NUESTRA_ISR
		ld		[HKEYI+1],hl											; La ponemos a continuación del jp
		ei																; Conectamos las interrupciones	

		jp		VARIABLES_PARA_EMPEZAR_LA_PARTIDA		

ACTIVAMOS_INTERRUPCIONES_DE_LINEA:

		call		PAGE_10_A_SEGMENT_2
		jp			ACTIVAMOS_INTERRUPCIONES_DE_LINEA_REAL

VARIABLES_PARA_EMPEZAR_LA_PARTIDA:	
																			; Cuando empieza el juego pero que luego no hay que recuperar si muere.
		ld		hl,(MAX_SCORE)
		ld		a,h
		or		l
		jp		z,VARIABLES_PARA_EMPEZAR_LA_PARTIDA_1
		ld		(SCORE_A_SUMAR),hl
		dec		hl
		ld		(MAX_SCORE),hl

		call	SUMA_SCORE
		ld		hl,0
		ld		(SCORE_A_SUMAR),hl
		call	SUMA_SCORE

		ld      hl,COPIA_SOLO_SCORE
		call    DOCOPY

VARIABLES_PARA_EMPEZAR_LA_PARTIDA_1:


		xor		a

		ld		(INMUNE),a
		ld		(SEMAFORO_CHECK_POINT),a
		ld		(CAMINO_NUEVA_INT),a
		ld		(HAY_CORAZONES),a
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
		ld		(MARCADOR_ANULADO),a
		ld		(FASE3_VAGON_JUMP_ACTIVO),a
		ld		(TILE_ESPECIAL_DEPH_COOLDOWN),a
		ld		(TILE_ESPECIAL_DEPH_BLOQUEOS),a
		ld		(HACIA_DONDE_INTERRUPT),a

		inc		a

		ld		(ESTADO_MARCADOR),a
		ld		(MUSICA_ON_OFF),a
		ld		(FX_ON_OFF),a
		ld		(SEMAFORO_VIDA_EXTRA),a

		inc		a
		ld		(SET_PAGE),a
		
		ld		a,159
		ld		(LIM_Y_INF),a	
			
		ld		a,186
		ld		(LIM_MUERTE),a

		ld		a,255
		ld		(FASE3_VAGON_INDICE_16_PRE_Y),a

		ld		a,195
		ld		(Y_LINEA_INT),a

INICIA_SCROLL:

        ld 	    sp,0xE500						                        ; Re Colocamos la pila en esta posicion.

.SPRITES:


		call	CARGA_1_A_45
		call	CARGA_SKRULLEX_SLIME
		call	CARGA_CORVELLINI_COVID

		ld		a,(FASE)
		cp		1
		jr		z,.VARIABLES_INAMOVIBLES
		cp		2
		jr		z,.SPRITES_STAGE_2
		cp		4
		jr		z,.SPRITES_STAGE_4
		cp		5
		jr		z,.SPRITES_STAGE_5

.SPRITES_STAGE_2:

		call	CARGA_ALFONSERRYX
		jr		.VARIABLES_INAMOVIBLES

.SPRITES_STAGE_4:

		call	CARGA_ECTO_PALLER
		jr		.VARIABLES_INAMOVIBLES

.SPRITES_STAGE_5:

		call	CARGA_MEGADEATH

.VARIABLES_INAMOVIBLES:

		ld		hl,(LINEA_SALVADA)
		ld		(LINEA_A_LEER),hl
		ld		a,(PAGE_DATOS_FASE_SALVADA)
		ld		(PAGE_DATOS_FASE),a
		ld		a,(TRAMO_FASE_3_SALVADO)
		ld		(TRAMO_FASE_3),a

		ld		hl,0
		ld		(CUANDO_RALENTIZAMOS),hl
		ld		(CONTROL_DE_C_R),hl
		ld		(CUANDO_PINTAMOS_UN_TILE),hl
		ld		(CONTROL_DE_C_P_U_T),hl	
		ld		(TIME_PARALIZA),hl
		ld		hl,DATOS_COPY_TILE_SCROLL_16X16
		ld		de,DATOS_DEL_TILE_PARA_COPY_IL
		ld		bc,15
		ldir
		xor		a
		ld		(X_PINTA_SCROLL),a										; La posición X del pintado empieza en 0
		ld		(NUMERO_DE_TILE_EN_LINEA),a								; Irá de 0 a 15 y volverá a empezar reduciendo en 1 LINEA_A_LEER
		ld		(PUNTO_DEL_SCROLL),a									; Dónde comienza situada la pantalla	
		ld		(TIEMPO_DE_ADJUST),a
		ld		(PAUSA_BLOQUEADA),a
		ld		(PARALIZAMOS),a
		ld		(NO_SE_MUEVE),a
		ld		(ECTOPALLERS_NUEVO_NECESARIO),a
		ld		(SEMAFORO_PUENTE),a
		LD		(SEMAFORO_LABERINTO),a
		ld		(MUSICA_BEST_ON),a
		ld		(SUMA_CAMINO),a
		ld		(ECTO_HUEVOS_GOLPES),a
		ld		(ECTO_HUEVOS_EXPLOSION),a
		ld		(ECTO_HUEVOS_RESPAWN),a
		ld		(ECTO_HUEVOS_SCROLL_ANT),a
		ld		(ECTO_HUEVOS_X),a
		ld		(FUEGO_AVISO_RAILES_TIMER),a
		ld		(FUEGO_AVISO_RAILES_RECOLOCA_Y),a
		ld		(FUEGO_AVISO_RAILES_OBJETIVO_X),a
		ld		(FUEGO_AVISO_RAILES_OBJETIVO_Y),a
		ld		(FUEGO_AVISO_RAILES_LINEA_ANT),a
		inc		a
		ld		(FINAL_DEL_SCROLL),a									; Activamos el scroll
		ld		(AVANCE_BLOQUEADO),a
		ld		(AGU_ACTIVO),a
		ld		(SPRITE_CAIDO),a
		call	RECUPERA_SPRITES
		
		ld		a,6
		ld		(CAMBIO_POSE),a

		ld		a,10
		ld		(ESTADO_COLOR_PERM),a

		ld		a,10
		ld		(SPRITE_QUE_TOCA),a

		ld		a,20													; El numero de fotograma siempre es el primero de la izquierda abajo, ya que los de arriba son los mismos siempre
		ld		(FOTOGRAMA_DEPH),a

		ld		a,40
		ld		(CADENCIA_DEL_DISPARO),a

		ld		a,100
		ld		(Y_DEPH),a
		ld		(CONTROL_Y),a

		ld		a,120
		ld		(X_DEPH),a


		ld		a,187
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
			
		ld		a,224
		ld		(Y_PINTA_SCROLL),a										; La posición Y del pintado empieza en 200

		call	PINTA_VIDAS
		call	PINTA_CORAZONES																				
		call	PINTA_ARMA
		call	PINTAMOS_LOS_PUNTOS_DE_MAGIA
		ld		hl,INICIA_SCROLL.posible_rectificacion_posicion_int_linea
[2]		push	hl
		call	PINTA_SCORE

.posible_rectificacion_posicion_int_linea:

		ld		a,(ESTADO_MARCADOR)
		or		a
		jp		nz,.entorno_a_1

		ld		a,(DONDE_VA_LA_INTERRUPCION_LINEAL)
		add		14
		ld		(DONDE_VA_LA_INTERRUPCION_LINEAL),a
			
.entorno_a_1:

		ld		a,1
		ld		(TILE_N),a
		ld		(TILE_N+1),a
		ld		(TILE_N+2),a
		ld		(TILE_N+3),a
					
		call	BORRA_SPRITES_ACTIVOS

.pinta_proyectiles_y_enemigos:

		ld		b,16
		ld		hl,ENEMIGOS+6
		ld		de,14
		xor		a
		
.bucle_para_pintar_proyectiles_y_enemigos:
		
		ld		(hl),a												; #FF Significa que no debe seguir buscnado porque no hay más proyectiles
		inc		hl
		inc		hl
		ld		(hl),a
		add		hl,de
		djnz	.bucle_para_pintar_proyectiles_y_enemigos
						
		ld		hl,PALETA_FASE_1_1_FADE_IN								; Primera paleta de colores
		call	SETPALETE
					
FASE1_PONEMOS_DECORADO_EN_SU_SITIO:

		ld		b,250
		call	COLOCA_IX_EN_EL_LUGAR_ADECUADO_PARA_LEER_TILES
		xor		a
		ld		(ACTIVA_SUCESOS),a	

.bucle_para_decorado:

		push	bc
			
		ld		a,(Y_DEPH)
		dec		a
		ld		(Y_DEPH),a
			
		call	BUCLE_PINTA_TILES
			
		pop		bc
		djnz	.bucle_para_decorado
			
		ld		a,1
		ld		(ACTIVA_SUCESOS),a

		call	SHOW_STATUS_COMP

		ld		hl,M_FANFARE_1
		ld		(MUSIC_ON),hl
        ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2
		call	INICIAMOS_MUSICA
        call    PAGE_10_A_SEGMENT_2
		call	PREPARAMOS_LOS_FX
        ld      a,(FASE)
        add     20
        call    CHANGE_BANK_2

		di
		call	strmus
		ei

        call    PAGE_10_A_SEGMENT_2


		ld		a,(MUSICA_ON_OFF)
		or		a
		jr		nz,.SEGUIMOS

		call	stpmus

.SEGUIMOS:

			call	RECUPERA_SPRITES_SALUDO									; A veces los pierde por el camino. Aquí garantizamos que los tiene cuando los necesita
			ld		a,(MUSICA_ON_OFF)
			or		a
			jr		nz,PRE_CONTROL

			call	CARGA_DEPH_MUSIC_OFF

PRE_CONTROL:

			call	ENASCR_RAM

CONTROL:
		
		ei
		
		call	BUCLE_PINTA_TILES
						
		call	INTRODUCIMOS_LINEA_DE_INTERRUPCION_NUEVA

		ld		a,(CORAZONES)
		or		a
		jr		nz,.control_adjust

		ld		a,(PARPADEO_CORAZONES)
		dec		a
		and		00111111B
		ld		(PARPADEO_CORAZONES),a
		or		a
		jr		z,.corazones_visibles
		cp		00010000B
		jr		nz,.control_adjust

.corazones_invisibles:

		ld		a,12
		ld		c,1
        call    A_31_DESDE_10       

			
		ld		hl,COPIA_CORZONES_VACIOS
		call	DOCOPY
		ld      hl,COPIA_MARCADOR_0_A_MARCADOR_3
		call    DOCOPY
		jr		.control_adjust

.corazones_visibles:

			call	PINTA_CORAZONES

.control_adjust:

			ld		a,(TIEMPO_DE_ADJUST)
			or		a
			jr		z,.control_inmune
			dec		a
			ld		(TIEMPO_DE_ADJUST),a

.control_inmune:

			call	CONTROL_RESPAWN_ECTO_HUEVOS

			ld		a,(INMUNE)
			or		a
			jr		z,.primeras_rutinas
			dec		a
			ld		(INMUNE),a

.primeras_rutinas:		
		
			call	RESCATA_ENTORNO
			call	FUERA_DE_PANTALLA
			
			ld		a,(MARCADOR_PULSADO)
			or		a
			jp		z,.teclas
				
.teclas:

.miramos_si_puede_moverse:

			jp	SE_PUEDE_MOVER_Y_EFES_VARIOS
	
.teclado:

			ld		a,(SUMA_CAMINO)
			cp		2
			call	z,APLICA_SPRITES_DEPH_VAGON

			ld		a,(NO_SE_MUEVE)
			or		a
			jp		z,.pre_sigue_comun

			ld		a,(LENTO)
			or		a
			jp		nz,.pre_sigue_comun

			ld		a,(AVANCE_BLOQUEADO)
			or		a
			jp		z,.si_que_puede
			ld		a,(CONTROL_Y)
			cp		65
			jp		c,.hay_que_sumar
						
.si_que_puede:

			xor		a												; Comprobando si ha tocado los cursores
			call	GTSTCK_RAM		
			or		a
			jp		z,.pad1
			
			call	RECUPERA_SPRITES

			ld		b,a
			ld		a,(GUARDA_STRIG)
			ld		(GUARDA_STRIG_2),a
			ld		a,b
			ld		(GUARDA_STRIG),a
				
.comprobamos1:

       		ld      de,TABLA_TECLADO
        	jp      SITUAMOS_PUNTERO_EN_TABLA

.pad1:

			ld		a,1												; Comprobando si ha tocado el pad1
			call	GTSTCK_RAM
			or		a
			jp		z,.comprobamos2	

			call	RECUPERA_SPRITES

			ld		b,a
			ld		a,(GUARDA_STRIG)
			ld		(GUARDA_STRIG_2),a
			ld		a,b
			ld		(GUARDA_STRIG),a
		
.comprobamos2:
		
       		ld      de,TABLA_PAD_1
        	jp      SITUAMOS_PUNTERO_EN_TABLA
						
.upright:

			call	DEPH_PARALIZADO_2.suma_comun_x
			jp		.resta_comun_y

		
.right:

			call	DEPH_PARALIZADO_2.suma_comun_x
			jp		.pre_sigue_comun
		
.rightdown:

			call	DEPH_PARALIZADO_2.suma_comun_x
			jp		.suma_comun_y
		
.downleft:

			call	DEPH_PARALIZADO_2.resta_comun_x
			jp		.suma_comun_y
		
.left:

			call	DEPH_PARALIZADO_2.resta_comun_x		
			jp		.pre_sigue_comun
		
.leftup:

			call	DEPH_PARALIZADO_2.resta_comun_x
		
.resta_comun_y:
		
			ld		c,6
			ld		d,0
			ld		a,(TILE_N)
			call	CONTROL_FASE3_TILE_145
			jp		nc,.pre_sigue_comun

			ld		c,14
			ld		d,0
			ld		a,(TILE_N2)
			call	CONTROL_FASE3_TILE_145
			jp		nc,.pre_sigue_comun

			ld		a,(AVANCE_BLOQUEADO)
			or		a
			jp		nz,.avance_con_reservas

			ld		a,(CONTROL_Y)
			cp		220
			jp		c,.hay_que_restar
			cp		250
			jp		c,.pre_sigue_comun
			jp		.hay_que_restar

.avance_con_reservas:

			ld		a,(CONTROL_Y)
			cp		65
			jp		c,.hay_que_sumar
			cp		220
			jp		c,.hay_que_restar


.hay_que_restar:

			call    CONTROL_RETENCION_Y_DEPH_POST_RECTIFICA_UP
			jp      c,.pre_sigue_comun
			
			ld      a,(CONTROL_Y)
			dec     a
			ld      (CONTROL_Y),a
				
			ld      a,(Y_DEPH)
			dec     a
		
.pre_sigue_up:

			ld		(Y_DEPH),a
			cp		216
			jp		z,.rectifica_up
			cp		200
			jp		nz,.pre_sigue_comun
				
.rectifica_up:
	
			dec     a
			ld      (Y_DEPH),a

			ld      a,(CONTROL_Y)
			dec     a
			ld      (CONTROL_Y),a

			call    SUMA_RETENCION_Y_DEPH_POST_RECTIFICA_UP
					
        jp      .pre_sigue_comun

.suma_comun_y:

			ld		c,6
			ld		d,16
			ld		a,(TILE_S)
			call	CONTROL_FASE3_TILE_145
			jp		nc,.pre_sigue_comun

			ld		c,14
			ld		d,16
			ld		a,(TILE_S2)
			call	CONTROL_FASE3_TILE_145
			jp		nc,.pre_sigue_comun

			ld		a,(LIM_Y_INF)
			ld		b,a
			ld		a,(CONTROL_Y)
			cp		b
			jp		c,.hay_que_sumar
			cp		210
			jp		c,.pre_sigue_comun

.hay_que_sumar:
		
			ld		a,(CONTROL_Y)
			inc		a
			ld		(CONTROL_Y),a
									
			ld		a,(Y_DEPH)
			inc		a

.pre_sigue_down:

			ld		(Y_DEPH),a
			cp		216
			jp		z,.rectifica_down

			cp		200
			jp		nz,.pre_sigue_comun

.rectifica_down:
		
			add		2
			ld		(Y_DEPH),a

			ld		a,(CONTROL_Y)
			add		2
			ld		(CONTROL_Y),a
		
.pre_sigue_comun:

			ld		a,(PARALIZAMOS)
			or		a
			jp		z,.cambio_de_pose
						
.cambio_de_pose:

			ld		a,(CAMBIO_POSE)
			sub		2
			ld		(CAMBIO_POSE),a
			jp		z,.corrige_y_sigue
			cp		255
			jp		nz,.sigue

.corrige_y_sigue:
		
			ld		a,1
			ld		(CAMBIO_POSE),a
														
.sigue:

			ld		a,(CADENCIA_DEL_DISPARO)
			or		a
			jp		z,.PULSA_ESPACIO
			
			dec		a
			ld		(CADENCIA_DEL_DISPARO),a
			jp		.FIN_RUTINA_GLOBAL
		
.PULSA_ESPACIO:

			ld		a,(SUMA_CAMINO)
			or		a
			jp		nz,CONTROL_ACCIONES_VAGON_FASE3

			ld		a,(BLOQUE_DE_SPRITES_VARIABLE)
			cp		5
			jp		z,.FIN_RUTINA_GLOBAL

			ld		hl,(TIME_PARALIZA)
			ld		a,h
			or		l
			jp		nz,.FIN_RUTINA_GLOBAL

			xor		a
			call	GTTRIG_RAM   
			or		a
			jp		z,.PULSA_BOTON
			
			ld		a,(TRIG_PULSADO)
			or		a
			jp		nz,.PULSA_M
			
			call	NUEVO_PROYECTIL
			
			jp		.PULSA_M
		
.PULSA_BOTON:

			ld		a,1
			call	GTTRIG_RAM
			or		a
			jp		z,.LIBERAMOS_TRIG

			ld		a,(TRIG_PULSADO)
			or		a
			jp		nz,.PULSA_M
			
			call	NUEVO_PROYECTIL	

.LIBERAMOS_TRIG:

			xor		a
			ld		(TRIG_PULSADO),a

.PULSA_M:

			ld		a,4														; Si pulsa M usamos magia
			call	SNSMAT_RAM 
			bit		2,a
			jp		nz,.PULSA_BOTON_2
					
			call	MAGIA
			
			jp		.FIN_RUTINA_GLOBAL
		
.PULSA_BOTON_2:

			ld		a,3
			call	GTTRIG_RAM  
			or		a
			jp		z,.FIN_RUTINA_GLOBAL
			
			call	MAGIA	

.FIN_RUTINA_GLOBAL:
		
			ld		a,(HACIA_DONDE_INTERRUPT)
			or		a
			call	nz,CAMBIAMOS_LA_INTERRUPCION_DE_LINEA_PARA_DESAPARECER

			halt
			call	PINTA_SPRITE_DEPH_VAGON_AJUSTADO

.MIRA_SI_CAMBIA_VELOCIDAD:
			call	SECUENCIA_PROYECTILES_Y_ENEMIGOS		
			call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_PROYECTILES
			call	REVISAMOS_COLISION_CON_ENEMIGOS_DE_DEPH

			call	PINTA_PROYECTILES_ENEMIGOS

.miramos_si_hay_cambio_de_velocidad:
			ld		a,(TILE_O)

			cp		1
			jp		z,.MIRAMOS_FASE_5			; TILE_O = 1

			sub		8						; ahora:
										; 8  -> 0
										; 9  -> 1
										; 23 -> 15
										; 43 -> 35

			cp		2
			jr		c,.MIRAMOS_FASE_1			; TILE_O era 8 o 9

			cp		15
			jr		z,.MIRAMOS_FASE_1			; TILE_O era 23

			cp		35
			jp		nz,.MIRAMOS_SI_HAY_AGUJERO		; si no era 43, fuera

			; si era 43, cae directamente aquí

.MIRAMOS_FASE_1:
			ld		a,(FASE)
			dec		a						; equivale a comprobar FASE = 1
			jp		nz,.MIRAMOS_SI_HAY_AGUJERO
			
			ld		hl,SEMAFORO_PUENTE
			ld		a,(hl)
			or		a
			jp		nz,.MIRAMOS_SI_HAY_AGUJERO

			inc		(hl)						; SEMAforo pasa de 0 a 1
			
			ld		a,39
			ld		hl,M_PUENTE
			call    INICIA_MUSICA_EXTRA
			; include "AUDIOS/INICIA MUSICA_PUENTE.asm"  

			call    BUCLE_PINTA_TILES.VELOCIDAD_DE_FASE_GALOPE
			jp		.MIRAMOS_SI_HAY_AGUJERO


.MIRAMOS_FASE_5:
			ld		a,(FASE)
			cp		5
			jr		nz,.MIRAMOS_SI_HAY_AGUJERO

			ld		hl,SEMAFORO_LABERINTO
			ld		a,(hl)
			or		a
			jr		nz,.MIRAMOS_SI_HAY_AGUJERO

			inc		(hl)	

			ld		a,73
			ld		hl,M_LABERINT
			call    INICIA_MUSICA_EXTRA
			; include "AUDIOS/INICIA MUSICA_LABERINTO.asm"

			call    BUCLE_PINTA_TILES.VELOCIDAD_DE_FASE_GALOPE


.MIRAMOS_SI_HAY_AGUJERO:


			call	BLOQUEA_LECTURA_TILES_CAMBIO_PAGE_FASE3
			jr		nc,.LEE_TILES_MIRAMOS_SI_HAY_AGUJERO
			xor		a
			ld		(TILE_CENTRO),a
			ld		(TILE_CENTRO_2),a
			ld		(TILE_FASE3_VAGON),a
			ld		(TILE_FASE3_VAGON_X16),a
			jp		MIRAMOS_SI_HAY_AGUJERO

.LEE_TILES_MIRAMOS_SI_HAY_AGUJERO:

			push	ix
			ld		a,(PAGE_DATOS_FASE)
			call	CHANGE_BANK_2
			call	SITUA_LA_X_E_Y
			call	SITUA_LA_X_E_Y_2
			ld		a,(ix)
			ld		(TILE_CENTRO),a
			ld		a,(ix+1)
			ld		(TILE_CENTRO_2),a

			ld		hl,Y_DEPH
			ld		a,(hl)
			push	af
			add		20
			ld		(hl),a
			call	SITUA_LA_X_E_Y
			add		6
			call	SITUA_LA_X_E_Y_2
			ld		a,(ix)
			ld		(TILE_FASE3_VAGON),a
			ld		a,20
			ld		(TILE_FASE3_VAGON_X16),a

			ld		a,(VARIABLE_UN_USO3)
			cp		255
			jr		nz,.RESTAURA_Y_TRAS_TILE_FASE3_VAGON
			ld		a,(TILE_FASE3_VAGON)
			cp		16
			jr		c,.MIRA_MARGEN_Y_SALTO_FASE3_VAGON
			cp		22
			jr		c,.RESTAURA_Y_TRAS_TILE_FASE3_VAGON

.MIRA_MARGEN_Y_SALTO_FASE3_VAGON:

			pop		af
			push	af
			add		4
			ld		(hl),a
			call	SITUA_LA_X_E_Y
			add		6
			call	SITUA_LA_X_E_Y_2
			ld		a,(ix)
			cp		16
			jr		c,.RESTAURA_Y_TRAS_TILE_FASE3_VAGON
			cp		22
			jr		nc,.RESTAURA_Y_TRAS_TILE_FASE3_VAGON
			ld		(TILE_FASE3_VAGON),a
			ld		a,4
			ld		(TILE_FASE3_VAGON_X16),a

.RESTAURA_Y_TRAS_TILE_FASE3_VAGON:

			pop		af
			ld		(hl),a

			call	PAGE_10_A_SEGMENT_2
			pop		ix
			call	CONTROL_TILES_ESPECIALES_DEPH

			jp		MIRAMOS_SI_HAY_AGUJERO

.RECUPERANDO_SPRITES_DEPH:

			ld		hl,SPRITE_DEPH_AGUJERO_1
			ld		de,#4020
			ld		bc,704
			call	PAGE_32_A_SEGMENT_2
			call	PON_COLOR_2.sin_bc_impuesta
			
			ld		hl,COLOR_DEPH_AGUJERO_2
			ld		de,#4820
			ld		bc,64
        	call   	PAGE_32_A_SEGMENT_2
			call	PON_COLOR_2.sin_bc_impuesta

        	ld      a,19
        	ld      c,0
        	CALL   	A_31_DESDE_10

			jp		DEPH_PARALIZADO_2


CARGA_1_A_45:

			call    PAGE_10_A_SEGMENT_2
			jp		CARGA_1_A_45_REAL

CARGA_1_A_45_FASE_3:

			call    PAGE_10_A_SEGMENT_2
			jp		CARGA_1_A_45_FASE_3_REAL
			
CARGA_PIES_EN_LODO:

			call	PAGE_10_A_SEGMENT_2
			jp		CARGA_PIES_EN_LODO_REAL
			
CARGA_FLECHA_SIMPLE:

			ld		hl,SPRITE_FLECHA_SIMPLE
			jp		CARGA_COMUN_1_FLECHA
CARGA_FLECHA_DOBLE:
			ld		hl,SPRITE_FLECHA_DOBLE
			jp		CARGA_COMUN_1_FLECHA
CARGA_FRENTE:

			ld		hl,DEPH_DE_FRENTE
			jp		CARGA_COMUN_26
CARGA_FIREWORKS:

			ld		a,1
			ld		(FIREWORKS_ACTIVO),a
			ld		hl,SPRITES_FIREWORK
			jp		CARGA_COMUN_24

CARGA_SKRULLEX:

			xor		a
			ld		(ALPHONSERRYX_ACTIVO),a
			ld		hl,SPRITES_SKRULLEX
			ld		de,#4000+46*8*4
			jp		CARGA_COMUN_4
			
CARGA_SKRULLEX_SLIME:

			ld		hl,SPRITES_SKRULLEX
			ld		de,#4000+46*8*4
			jp		CARGA_COMUN_8

CARGA_SLIME_FUEGO:

			ld		hl,SPRITES_SLIMES_FUEGO
			ld		de,#4000+50*8*4
			jp		CARGA_COMUN_4

CARGA_CORVELLINI_COVID:

			ld		hl,SPRITES_CORVELLINI
			ld		de,#4000+54*8*4
			jp		CARGA_COMUN_10
CARGA_ALFONSERRYX:

			ld		hl,SPRITES_ALPHONSERRYX
			ld		de,#4000+54*8*4
			jp		CARGA_COMUN_4

CARGA_ALFONSERRYX_STAGE_4:

			ld		a,1
			ld		(ALPHONSERRYX_ACTIVO),a
			ld		hl,SPRITES_ALPHONSERRYX
			ld		de,#4000+46*8*4
			jp		CARGA_COMUN_4

CARGA_MEGADEATH:

			ld		hl,SPRITES_MEGADEATH
			ld		de,#4000+54*8*4
			jp		CARGA_COMUN_6
CARGA_ECTO_PALLER:

			ld		hl,SPRITES_ECTO_PALLERS
			ld		de,#4000+50*8*4
			jp		CARGA_COMUN_4
CARGA_ECTO_PALLER_MUERTO:

			ld		hl,SPRITES_ECTO_MUERTO
			ld		de,#4000+50*8*4
			jp		CARGA_COMUN_4
CARGA_INCORRECTO:

			ld		hl,SPRITE_CAMINO_INCORRECTO
			ld		de,#4000+37*8*4
			jp		CARGA_COMUN_2

CARGA_CORRECTO:

			ld		hl,SPRITE_CAMINO_CORRECTO
			ld		de,#4000+37*8*4
			jp		CARGA_COMUN_2

CARGA_COMUN_1_FLECHA:

			ld		de,#4000+39*8*4
			ld		bc,1*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_2:

			ld		bc,2*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_4:

			ld		bc,4*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_6:

			ld		bc,6*8*4
			jp		TROZOS_COMUNES_15			
CARGA_COMUN_8:
			ld		bc,8*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_10:
			ld		bc,10*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_24:

			ld		de,#4000+25*8*4
			ld		bc,24*8*4
			jp		TROZOS_COMUNES_15
CARGA_COMUN_26:

			ld		de,#4000+23*8*4
			ld		bc,26*8*4
			jp		TROZOS_COMUNES_15

CARGA_1_A_25_TRAS_PAUSA:

			call    PAGE_10_A_SEGMENT_2
			ld		hl,TODOS_LOS_SPRITES
			call	CARGA_COMUN_25_TRAS_PAUSA

		ld		hl,COLORES_DEPH_CASCOS_POSE_3

        call    PAGE_32_A_SEGMENT_2

		ld		de,#4840
		ld		bc,96
		call	PON_COLOR_2.sin_bc_impuesta
        jp    	PAGE_10_A_SEGMENT_2

CARGA_COMUN_25_TRAS_PAUSA:

			halt
			ld		de,#4000+1*8*4
			ld		bc,25*8*4
			jp		TROZOS_COMUNES_15

CARGA_COMUN_45:

			halt
			ld		de,#4000+1*8*4
			ld		bc,45*8*4
			call	TROZOS_COMUNES_15

		ld		hl,COLORES_DEPH_CASCOS_POSE_3

        call    PAGE_32_A_SEGMENT_2

		ld		de,#4840
		ld		bc,96
		call	PON_COLOR_2.sin_bc_impuesta
        jp    	PAGE_10_A_SEGMENT_2

CARGA_MUSICA_THE_BEST:

		call	stpmus

		ld		a,1
		ld		(MUSICA_BEST_ON),a
			
		ld		a,39
		call	CHANGE_BANK_2

		ld		hl,M_THE_BEST
		ld		(MUSIC_ON),hl
		call	INICIAMOS_MUSICA
		di
		call	strmus
		ei	
		jp		PAGE_10_A_SEGMENT_2

CARGA_MUSICA_VAGONETA:

		call	stpmus

		ld		a,1
		ld		(MUSICA_BEST_ON),a
			
		ld		a,39
		call	CHANGE_BANK_2

		ld		hl,M_VAGONETA
		ld		(MUSIC_ON),hl
		call	INICIAMOS_MUSICA
		di
		call	strmus
		ei	
		call	PAGE_10_A_SEGMENT_2
		ret

REVISA_LETRAS_DE_LA_FASE:

		call	PAGE_10_A_SEGMENT_2
		jp		REVISA_LETRAS_DE_LA_FASE_REAL

REVISA_LETRAS_DE_TODAS_LAS_FASES:

		call	PAGE_10_A_SEGMENT_2
		jp		REVISA_LETRAS_DE_TODAS_LAS_FASES_REAL
DESCONECTA_PUPA:

		ld		a,1
		ld		(DESACTIVA_PUPA),a
		ret

CONTROL_FASE3_TILE_145:

		jp		CONTROL_FASE3_TILE_145_SECTOR_10

CONTROL_VELOCIDAD_FASE_VAGON:

		call	CARGA_MUSICA_VAGONETA
		ld		a,2
		ld		(SUMA_CAMINO),a
		call	BUCLE_PINTA_TILES.VELOCIDAD_DE_FASE_GALOPE
		jp		APLICA_SPRITES_DEPH_VAGON

PINTA_SPRITE_DEPH_VAGON_AJUSTADO:

		call	ES_FASE3_VAGON_ACTIVO
		jp		nc,PINTA_SPRITE_DEPH
		call	PINTA_SPRITE_VAGONETA_TOTAL_SECTOR_10
		ld		a,(MUSICA_ON_OFF)
		or		a
		jp		z,PINTA_COLORES_SPRITE_VAGON_CASCOS
		jp		PINTA_COLORES_SPRITE_VAGON

MARCA_REAPLICA_VAGON_RET:

		ld		a,(SUMA_CAMINO)
		or		a
		ret		z
		ld		a,2
		ld		(SUMA_CAMINO),a
		ret

APLICA_SPRITES_DEPH_VAGON:

		call	PAGE_32_A_SEGMENT_2
		ld		hl,SPRITES_VAGON_TOTAL
		ld		de,#4000+4*8
		ld		bc,8*32
		call	PON_COLOR_2.sin_bc_impuesta
		ld		a,1
		ld		(SUMA_CAMINO),a
		jp		PINTA_COLORES_SPRITE_VAGON_DESDE_PAGE32

CARGA_SPRITES_VAGONETA_PAUSA:

		call	PAGE_32_A_SEGMENT_2
		ld		hl,SPRITES_VAGONETA_PAUSA
		ld		de,#4000+4*8
		ld		bc,4*32
		call	PON_COLOR_2.sin_bc_impuesta

		ld		hl,COLOR_SPRITES_VAGONETA_PAUSA
		ld		de,#4800
		ld		bc,4*16
		call	PON_COLOR_2.sin_bc_impuesta
		jp		PAGE_10_A_SEGMENT_2

PRECARGA_SOLO_VAGONETA_EN_PATRONES_ALTOS:

		call	PAGE_32_A_SEGMENT_2
		ld		hl,SPRITES_SOLO_VAGONETA
		ld		de,#4000+216*8
		ld		bc,4*32
		call	PON_COLOR_2.sin_bc_impuesta

		ld		hl,COLOR_SPRITE_SOLO_VAGONETA
		ld		de,#4860
		ld		bc,4*16
		call	PON_COLOR_2.sin_bc_impuesta
		jp		PAGE_10_A_SEGMENT_2

PINTA_COLORES_SPRITE_VAGON:

		call	PAGE_32_A_SEGMENT_2

PINTA_COLORES_SPRITE_VAGON_DESDE_PAGE32:

		ld		hl,COLOR_SPRITE_VAGONETA_TOTAL
		ld		de,#4800
		ld		bc,8*16
		call	PON_COLOR_2.sin_bc_impuesta
		jp		PAGE_10_A_SEGMENT_2

PINTA_COLORES_SPRITE_VAGON_CASCOS:

		call	PAGE_32_A_SEGMENT_2
		ld		hl,COLOR_SPRITES_VAGONETA_CASCOS
		ld		de,#4800
		ld		bc,2*16
		call	PON_COLOR_2.sin_bc_impuesta

		ld		hl,COLOR_SPRITES_VAGONETA_CASCOS+3*16
		ld		de,#4820
		ld		bc,2*16
		call	PON_COLOR_2.sin_bc_impuesta

		ld		hl,COLOR_SPRITE_VAGONETA_TOTAL+4*16
		ld		de,#4840
		ld		bc,4*16
		call	PON_COLOR_2.sin_bc_impuesta
		jp		PAGE_10_A_SEGMENT_2

CONTROL_BUCLES:

.INICIO_BUCLE:

		call    PAGE_10_A_SEGMENT_2
		jp		CONTROL_BUCLES_INICIO_BUCLE_REAL

.CONTROL_IZQUIERDA:

		call    PAGE_10_A_SEGMENT_2
		jp		CONTROL_BUCLES_CONTROL_IZQUIERDA_REAL

.CONTROL_CENTRO:

		call    PAGE_10_A_SEGMENT_2
		jp		CONTROL_BUCLES_CONTROL_CENTRO_REAL

.CONTROL_DERECHA:

		call    PAGE_10_A_SEGMENT_2
		jp		CONTROL_BUCLES_CONTROL_DERECHA_REAL

.CONTROL_SUMA_TRES_S5:

		ld		a,(SUMA_BUCLE)
		cp		3
		jp		z,.CONTINUA_S5

.REPITE_S5:

        ld      a,16
        ld      c,0
        call    A_31_DESDE_10   

		push	hl
		ld		hl,(LINEA_DE_REGRESO_BUCLE)
		ld		(LINEA_A_LEER),hl
		pop		hl

		call	CARGA_INCORRECTO
		call	NUEVO_CAMINO_INCORRECTO
		jp		CHECK_POINT.SALTO_PARA_OTROS_CARTELES

.CONTINUA_S5:

        ld      a,15
        ld      c,0
        call    A_31_DESDE_10   

		call	CARGA_CORRECTO
		call	NUEVO_CAMINO_CORRECTO
		jp		CHECK_POINT.SALTO_PARA_OTROS_CARTELES
PREPARAMOS_LOS_FX:

			xor		a
			ld		(LINEA_PSG_QUE_TOCA),a
			

			ld		hl,EFECTOS_DE_SONIDO
			jp		ayFX_SETUP

RECUPERA_SPRITES:
		
		ld		b,a
		ld		a,(SPRITE_CAIDO)
		or		a
		ld		a,b
		ret		z

		push	af

		xor		a
		ld		(SPRITE_CAIDO),a
		
		ld		hl,TODOS_LOS_SPRITES
		ld		de,#4020
		ld		bc,22*8*4
		call	PAGE_32_A_SEGMENT_2
		call	TROZOS_COMUNES_15

        ld      a,20
        ld      c,0
        CALL   	A_31_DESDE_10
		pop		af
		ret

        include "../BASICOS/PROYECTILES.asm"
        include "../BASICOS/ENEMIGOS.asm"
		
ENEMIGO_FINAL:

		pop		af										; Sacamos de la pila el ret anterior

PASAMOS_A_LA_SIGUIENTE_FASE:

		jp		$
