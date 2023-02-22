; VARIABLES

	MAP 0xc001

VDP:         					#28										; control de VDP para el cambio de page	

LINEA_PSG_QUE_TOCA:				#1										; En qué linea del psg metemos el fx
LINEA_A_LEER:					#2										; Nos indica la linea horizontal del mapa que debemos copiar
LINEA_SALVADA:					#2										; Linea de comienzo o check point
X_PINTA_SCROLL:					#1										; La posición de la pantalla donde se tiene que pintar el tile en su posición X
Y_PINTA_SCROLL:					#1										; La posición de la pantalla donde se tiene que pintar el tile en su posición Y
NUMERO_DE_TILE_EN_LINEA:		#1										; El tile que se está pintando de la linea horizontal entre 0 y 15
DATOS_DEL_TILE_PARA_COPY:		#15										; Aquí se copian y se leen los datos para hacer el copy adecuado
DATOS_DEL_TILE_PARA_COPY_IL:	#15
DATOS_DEL_CUADRADO_NEGRO:		#15
PUNTO_DEL_SCROLL:				#1										; Posición del scroll para pintar la pantalla
CUANDO_RALENTIZAMOS:			#2										; Los ciclos que espera para adelantar el scroll
CONTROL_DE_C_R:					#2										; Esta es la que cambia y deberá volver o alcanzar CUANTO_RALENTIZAMOS
CUANDO_PINTAMOS_UN_TILE:		#2										; Esto reparte el pintado de tiles en el tiempo que tarda en adelantar 16 veces el scroll
SET_PAGE 						#1										; Para el vblank. Siempre será 2 pero a veces ha de ser 1																		; Por lo que será 16/CUANTO_RALENTIZAMOS
FMPAC_DESCONECTADO:				#1										; 0 No está 1 sí
CONTROL_DE_C_P_U_T:				#2										; Esta es la que cambia y deberá volver o alcanzar CUANDO_PINTAMOS_UN_TILE
FINAL_DEL_SCROLL				#1										; Nos indica por 0/1 FALSE/TRUE si hemos llegado al final del scroll
DONDE_VA_LA_INTERRUPCION_LINEAL:#1										; Linea en la que interrumpiremos para poner el marcador
Y_LINEA_INT:					#1										; Donde se coloca la linea de sprites en su Y para tapar el salto de la linea de interrupción
Y_FALSA_PARA_PROYECTILES		#1										; Esta Y calcula el salto del scroll y lo evita
Y_FALSA_PARA_DEPH				#1
X_FALSA_PARA_PROYECTILES		#1										; Esta Y calcula el salto del scroll y lo evita
X_FALSA_PARA_DEPH				#1
X_DEPH:							#1										; Información importante para pintar al prota en el lugar adecuado
Y_DEPH:							#1
CONTROL_Y:						#1										; La posición real de Y a vista del jugador y no dentro del scroll
LIM_Y_INF:						#1										; Límite inferior de Y según si hay contador o no
LIM_MUERTE:						#1
FOTOGRAMA_DEPH:					#1
ATRIBUTOS_DEPH_VARIABLES:		#40
SEMAFORO_CHECK_POINT:			#1										; Nos indica si ya podemos mostrar el check-pint
SEMAFORO_VIDA_EXTRA:			#1										; Nos indica si ya hemos dado una vida extra por pasar de 50000 puntos
ATRIBUTOS_NUMERO_DE_VIDAS_O_PUNTOS:		#15								; Los datos para el copy de las vidas que tiene
CAMBIO_POSE:					#1										; Controla cada cuantos ciclos del scroll se pasa al siguiente fotograma
FOTOGRAMA_DEPH_EN_ORDEN:		#1										; Controla la sucesión de poses del 0 al 4
TRIG_PULSADO:					#1										; Domina si el trig está pulsado o no
MUSICA_ON_OFF:					#1										; 0 Off 1 on
FX_ON_OFF:						#1										; 0 off 1 on
SPRITE_QUE_TOCA:				#1										; Nos indica los atributos de sprite que toca usar
VARIABLE_CARGA_AGUA:			#1										; 0 es normal, 1 es de lodo
FASE:							#1										; Fase en la que está jugando
MUSICA_BEST_ON:					#1										; 0 - Pagína de musicas de la fase 1 - página de the best
DESACTIVA_PUPA:					#1										; Se desactiva para alguna zona concreta que usa los tiles de pupa
PAGE_A_GUARDAR:					#1
HAY_CORAZONES:					#1										; Nos dice si los spries de SKRULLEX son ahora de corazones
CHECKPOINT_ACTIVO:				#1										; Hay check point en pantalla
CORAZON_ACTIVO:					#1										; Hay corazón en pantalla
FIREWORKS_ACTIVO:				#1										; Hay fuegos artificiales en pantalla
MEGADEATH_ACTIVO:				#1										; Hay megadeath en pantalla
ECTOPALLERS_ACTIVO:				#1										; Hay ectopallers en pantalla
ECTOPALLERS_NUEVO_NECESARIO:	#1										; controla si no está en pantalla
ALPHONSERRYX_ACTIVO:			#1										; Hay alphonserryx de stage 4 en pantalla
DEJA_EL_SPRITE:					#1										; Va sumadno 16 para dejar el siguietne sprite en una nueva posicion
ESTADO_COLOR_PERM:				#1										; Nos dice el estado en el que deben estrar los colores
																		; 0 estáticos - PRIMERA_PALETA
																		; 1 Permutación del agua del rio FASE 1 - SEGUNDA PALETA (ROTATIVA DE HASTA 3 COLORES)
																		; 2 TERCERA PALETA
																		; 3 FADE IN 1
																		; 4 FADE OUT 1
																		; 5 FADE IN 2
																		; 6 FADE OUT 2
																		; 7 FADE IN 3
																		; 8 FADE OUT 3
																		; 9 GRIS
																		; 10 GRIS FADE
																		; 11 MARCADOR
																		; 12 NEGRO
TOCA_PERMUTACION:				#1										; Contador para saber si coincide con la variable anterior
QUE_PERMUTACION:				#1										; Cual de la sucesion toca
ACTIVA_SUCESOS:					#1										; 0 Desactivado, 1 activado
REDUCE_POS_C_P:					#1										; Define la posicion final del check point
TILE_N:							#1										; Estas variables rescatan el valor de tile que hay en torno al prota
TILE_N2:						#1
TILE_O:							#1
TILE_E:							#1
TILE_S:							#1
TILE_S2:						#1
TILE_CENTRO:					#1
TILE_CENTRO_2:					#1
GUARDA_STRIG:					#1										; Guarda el valor de strig para ver si luego resta una pos
GUARDA_STRIG_2:					#1
PAUSA_BLOQUEADA:				#1										; Sólo podremos pulsar pause si está a 0
AVANCE_BLOQUEADO:				#1										; 0 Puede avanzar 1 No puede
HACIA_DONDE_INTERRUPT:			#1										; 0 En la LT. 1 Hay que subir 30 pixeles. 2 Hay que bajar 30 pixeles
CAMINO_NUEVA_INT:				#1										; Contador para mover la interrupción
ESTADO_MARCADOR:				#1										; 1 a vista, 0 escondido
MARCADOR_PULSADO:				#1										; Controla si se pulsó la vez anterior para no crear un bucle
MARCADOR_ANULADO:				#1										; Controla si el ordenador decide que no hay MARCADOR
PALETA_A_FADEAR:				#2										; Aquí ponemos la dirección de memoria que hay que leer en cuestión de paletas
ACTIVAMOS_FADE:					#1										; Es el contador para activar fade o no
ESPERA_PALETA:					#1										; Un semaforo de espera para relentizar el fade
COTEJA_ESPERA_PALETA:			#1
PARPADEO_CORAZONES:				#1										; Controla el parpadeo de corazones cuando sólo te queda una vida
TIEMPO_DE_ADJUST:				#1										; Ciclos cambiando el set adjust
CADENCIA_DEL_DISPARO:			#1										; Cada cuanto puede disparar
VIDAS:							#1										; Las vidas del prota aun vigentes
CORAZONES:						#1										; Los powers que le quedan
CORAZONES_MAXIMOS:				#1										; El máximo de powers de los que disfruta
MAGIAS:							#1										; La cantidad de puntos de magia que tiene
SCORE_A_SUMAR:					#2										; Los puntos que suma el score tras hacer algo
SCORE_REAL:						#2										; Score del juego
MAX_SCORE:						#2										; La máxima puntuación
V_DECEN_MIL:					#1
V_UNIDA_MIL:					#1
V_CENTENAS:						#1
V_DECENAS:						#1
V_UNIDADES:						#1
INMUNE:							#1										; Define X ciclos inmune al personaje
SUMA_BUCLE:						#1										; Controla si ha hecho bien la secuencia de un bucle
NO_SE_MUEVE:					#1										; 0 No se puede mover 1 Si
LENTO:							#1										; Si esta en fase 4 y pisa arenas servirá para relentizar al personaje
LINEA_DE_REGRESO_BUCLE:			#2										; Contiene la linea a la que hay que volver si no se cumple el bucle
ARMA_USANDO:					#1										; 0 1 2 Flecha 3 4 5 fuego 6 7 8 hacha
ESTADO_EJERCICIO				#1										; 0 y 2 es neutro. 1 es arriba y 3 es abajo 
BLOQUE_DE_SPRITES_VARIABLE:		#1										; Nos dice los sprites que están descargados
ECTO_PARALIZADO:				#1										; 0 No. 1 Si
LETRA_EXPUESTA:					#1										; Nos dice los sprites que están descargados EN RELACION A LAS LETRAS
																		; 0 Slime
TENEMOS_D:						#1										; Se ha cogido la letra D
TENEMOS_E:						#1										; Se ha cogido la letra E
TENEMOS_P:						#1										; Se ha cogido la letra P
TENEMOS_H:						#1										; Se ha cogido la letra H
TENEMOS_TODAS:					#1

VELOCIDAD_ROCKAGER:				#1										; Velocidad variable de la animación del rockager
FOTOGRAMA_SECUENCIA_ROCKAGER_1:	#1										; Fotograma en el que está de la primera secuencia
FOTOGRAMA_SECUENCIA_ROCKAGER_2:	#1										; Fotograma en el que está de la primera secuencia muerte
FOTOGRAMA_SECUENCIA_ROCKAGER_3:	#1										; Fotograma en el que está de la segunda secuencia
FOTOGRAMA_SECUENCIA_ROCKAGER_4:	#1										; Fotograma en el que está de la segunda secuencia muerte
SECUENCIA_DE_ROCKAGER:			#1										; 0 o 2 según si quedan 2 vivos o 1
PAUSA_EN_ANIMACION_ROCKAGER:	#1										; Controla las pausas de la animación para darle sentido al rockager
PRIMERA_APERTURA_SUELO:			#1										; Controla que tiemble el suelo al aparecer por primera vez
VIDA_ROCKAGER_1:				#1										; Vida de rockager 1
VIDA_ROCKAGER_2:				#1										; Vida de rockager 2
ROCKAGER_MUERTO:				#1										; Nos dice el rockager que ha muerto
AGUJERO_INTOCABLE:				#1										; El fotograma que debe saltar 37 porque está ocupado
POSICION_DERRUMBE_ROCKAGER:		#1										; Nos indica la animación que hay que poner en el derrumbe
DATAS_COR_EMPT_MALO:			#16										; Los datos del malo maloso
CORAZONES_DEPH_EN_BOSSES:		#16										; Datos de los corazones a pintar en blanco de deph durante un boss
PUNTOS_MAGIA_EN_BOSSES:		#16										; Datos de los puntos de magia a pintar durante pelea con boss
VALORES_SPRITE_MAREO:			#4										; Valores del mareo. El primero empieza en 57*4
VALORES_SPRITES_PIEDRAS:		#24										; 0 x
																		; 1 y
																		; Patron
																		; fotograma
VALORES_EXPLOSION_CON_ROCK:		#4										; Valores para colocar la explosión tras tocar a rockager
PAUSA_TOQUE_ROCA_HACHA:			#1										; Si es mayor a 0 no puedes tocar las rocas	
COLOR_ALEATORIO:				#1										; 0 Cambia el color en set adjust. 1 no				
FOTOGRAMA_SECUENCIA_DAV:		#1										; Control fotograma animación boss 2
PAGINA_DE_REGRESO:				#1										; En los bosses, indica la página a la que hay que regresar
RECORRIDO_ROCA:					#1										; Qué recorrido hace la roca de los 3 posibles

SUMA_CAMINO:					#1										; Controla si se han cumplido ciertas condiciones para avanzar en el mapa
DATOS_A_SACAR:					#1										; Nos indica la cantidad de datos a sacar de la pila si no se puede definir el sprite
PROPIEDADES_PATRON_SPRITE:		#3
SPRITES_ACTIVOS:				#20										; Guarda si están ocupados los sprites del 10 al 31
MIRAMOS_SEGUNDO_SPRITE:			#1										; Se activa si estamos mirando el segundo sprite, para poder borrar el primero si no hay sitio para el segundo
ENEMIGOS:						#16*10									; 16 Bytes de información * 10 posibles proyectiles (incluye bases de armas y proyectiles enemigos)
																		; 0 X
																		; 1 Y
																		; 2 vida que tiene
																		; 3 Conjunto de patrones que le toca 2
																		; 4 Identificador de afin (las SKRULLEXs indican el premio en que se convierten 4-random 5-flecha 2-fuego 3-hacha)
																		; 5 Muere o se convierte
																		; 6 Tipo de comportamiento
																		; 7 Fase del tipo de comportamiento
																		; 8 Número de sprite
																		; 9 Límite Y en control (COVID CONTROL DE SI ES PARA ABAJO)
																		; 10 En qué estado de la animación está
																		; 11 Velocidad del enemigo
																		; 12 Conjunto de patrones que le toca 1
																		; 13 Libre
																		; 14 Puntos que vale
																		; 15 Replica del sprite para controlar la animación
PROYECTILES:					#16*6									; 14 Bytes de información * 6 posibles proyectiles (proyectiles son lo que lanza el prota)
																		; 0 X
																		; 1 Y
																		; 2 Daño que inflige (si es FF es que no hay nada aquí)
																		; 3 Daño que inflige a enemigo afín
																		; 4 Identificador de afin
																		; 5 Muere al colisionar o indestructible hasta salir de pantalla
																		; 6 Tipo de comportamiento
																		; 7 Fase del tipo de comportamiento
																		; 8 Número de sprite
																		; 9 Cantidad de sprites que componen la animación
																		; 10 En qué estado de la animación está
																		; 11 Velocidad del proyectil
																		; 12 Conjunto de patrones que le toca
																		; 13 Recorrido posible
																		; 14 Libre
																		; 15 Libre
																		
VARIABLE_UN_USO:				#2										; Cuando se necesita usar un registro pero sólo una vez y luego su valor se perderá
VARIABLE_UN_USO2:				#1										; Cuando se necesita usar un registro pero sólo una vez y luego su valor se perderá
VARIABLE_UN_USO3:				#1										; Cuando se necesita usar un registro pero sólo una vez y luego su valor se perderá
FUEGO_QUE_TOCA:					#1
DATAS_COPY_RECUP_SCROLL:		#15										; Aquí recuperamos los datos necesarios para recolocar los copys
MUSIC_ON:						#2										; Dirección de memoria donde está la música a tocar

; Variables_del_menu
DOBLE_BUFFER_MENU:				#1										; controla pantalla a mostrar
DOBLE_DE_COPIA_FONDO:			#15
DOBLE_DE_COPIA_TITULO:			#15
DOBLE_DE_COPIA_MONTANAS_1:		#15
DOBLE_DE_COPIA_MONTANAS_2:		#15
ROTACION_PALETA:				#1
POSICION_DE_LAS_MONTANAS:		#1
LARGO_A_COPIAR_MONTANA_1:		#1

; Variables de caída en el agujero

AGU_ACTIVO:						#1										; Controla si caemos en el agujero al detectarlo o no
PARALIZAMOS:					#1										; Impide que se mueva el personaje
TIME_PARALIZA:					#2										; El tiempo que estará sin poder moverse
SPRITE_CAIDO:					#1										; Indica si ya puede pintar el nuevo sprite o no tras la caída
CORAZON_CONTENEDOR_COGIDO:		#1										; Nos dice si en esa fase ha cogido el corazon contenedor
; --- ayFX REPLAYER v2.0M ---
; --- THIS FILE MUST BE COMPILED IN RAM ---

ayFX_BANK:						#2										; Current ayFX Bank
ayFX_C1:						#3										; Priority & Pointer to the ayFX being played on channel 1
ayFX_C2:						#3										; Priority & Pointer to the ayFX being played on channel 2
ayFX_C3:						#3										; Priority & Pointer to the ayFX being played on channel 3

ayFX_TONE:						#2										; Current tone of the ayFX stream
ayFX_NOISE:						#1										; Current noise of the ayFX stream
ayFX_VOLUME:					#1										; Current volume of the ayFX stream
ayFX_CHANNEL:					#1										; PSG channel to play the ayFX stream

ayFX_REGS:						#14										; Ram copy of PSG registers
;struc	AR

AR_TonA		equ 0														;RESW 1
AR_TonB		equ 2														;RESW 1
AR_TonC		equ 4														;RESW 1
AR_Noise	equ 6														;RESB 1
AR_Mixer	equ 7														;RESB 1
AR_AmplA	equ 8														;RESB 1
AR_AmplB	equ 9														;RESB 1
AR_AmplC	equ 10														;RESB 1
AR_Env		equ 11														;RESW 1
AR_EnvTp	equ 13														;RESB 1

; fmpac y music module

CLIKSW:	#2	
chips:	#1 																;db  0 			;soundchip: 	0 = 	msx-audio
																		;							   	1 = 	msx-music
																		;	   							2 = 	stereo
busply:	#1 																;db  0 			;status:  		0 = 	no se reproduce
																		;       						255 = 	se reproduce
muspge:	#1 																;db  3 			;banco mapeador con datos de música
musadr:	#2 																;dw  08000h		;dirección de los datos de música
pos:	#1 																;db  0 			;Contador de posición actual
step:	#1 																;db  0 			;Paso actual
status:	#3 																;db  0,0,0	;3 	;Statusbytes

chnwc1: #10  															;dw  0,0,0,0,0
modval: #20 															;dw  1,2,2,-2,-2,-1,-2,-2,2,2
mmfrqs: #1  															;db  0
speed:  #1  															;db  0
spdcnt: #1  															;db  0
rtel:   #1 																;db  0
patadr: #2  															;dw  0
patpnt: #2  															;dw  0
tpval:  #1  															;db  0
xpos:   #2  															;dw  0
laspl1: #22*9 															;db  0,0,0,0,0,0,0,0a0h,10h,0,0,0,030h,043h,0,0,0,0,0,0,0,0
																		;db  0,0,0,0,0,0,0,0a1h,11h,0,0,0,031h,044h,0,0,0,0,0,0,0,0
																		;db  0,0,0,0,0,0,0,0a2h,12h,0,0,0,032h,045h,0,0,0,0,0,0,0,0
																		;db  0,0,0,0,0,0,0,0a4h,14h,0,0,0,034h,04ch,0,0,0,0,0,0,0,0
																		;db  0,0,0,0,0,0,0,0a5h,15h,0,0,0,035h,04dh,0,0,0,0,0,0,0,0
																		;db  0,0,0,0,0,0,0,0a6h,16h,0,0,0,036h,053h,0,0,0,0,0,0,0,0
																		;db  0,0,0,0,0,0,0,0a7h,17h,0,0,0,037h,054h,0,0,0,0,0,0,0,0
																		;db  0,0,0,0,0,0,0,0a8h,18h,0,0,0,038h,055h,0,0,0,0,0,0,0,0

stepbf:	#13  															;ds  13			;datos de paso en SIGUIENTE interrupción
																		;				;se ejecuta (o ya ha sido ejecutado antes)
xleng   #3     															;ds  3
xmmvoc  #16*9 															;ds  16*9
xmmsti  #16   	 														;ds  16
xpasti  #32    															;ds  32
xstpr   #10    															;ds  10
xtempo  #1     															;ds  1
xsust   #1     															;ds  1
xbegvm  #9    															;ds  9
xbegvp  #9     															;ds  9
xorgp1  #6*8   															;ds  6*8
xorgnr  #6     															;ds  6
xsmpkt  #8     															;ds  8
xdrblk  #15    															;ds  15
xdrvol  #3     															;ds  3
xdrfrq  #20    															;ds  20
xrever  #9     															;ds  9
xloop   #1     															;ds  1
psgcnt:	#1    	 														;db	 0
psgvol:	#1     															;db	 0

