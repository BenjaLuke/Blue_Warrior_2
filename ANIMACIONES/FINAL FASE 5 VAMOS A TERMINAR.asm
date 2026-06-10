; -----------------------------------------------------------------------------
; FINAL FASE 5 VAMOS A TERMINAR.asm
;
; Include ejecutado desde BOSS 5.asm en la etiqueta FINAL_b5.
;
; Objetivo:
;   - Borrar visualmente la page 2 visible.
;   - Pintar bloques negros en orden pseudoaleatorio.
;   - No repetir nunca el mismo bloque.
;   - Al terminar, NO hacer ret ni jp: el flujo cae al codigo siguiente
;     del include, es decir, VOLVEMOS_b5.
;
; Nota:
;   La pantalla se divide en bloques de 4x4.
;   64 columnas x 53 filas = 3392 bloques.
;   Cada bloque se pinta una sola vez mediante HMMV.
; -----------------------------------------------------------------------------

		jp		FINAL_FASE_5_VAMOS_A_TERMINAR_INICIO

; Buffer de comando VDP.
; Formato DOCOPY:
;   0-1   SX
;   2-3   SY
;   4-5   DX
;   6-7   DY
;   8-9   NX
;   10-11 NY
;   12    color
;   13    argumento
;   14    comando
;
; HMMV (#C0) rellena un rectangulo con un color.
; DY alto = 2 para pintar en la page 2.
FINAL_FASE_5_VAMOS_A_TERMINAR_PLANTILLA_HMMV:

		db		0,0,0,0
		db		0,0
		db		0,PAGE_2_VRAM_Y_BOSS_5/256
		db		4,0
		db		2,0
		db		#00
		db		#00
		db		COPY_LOGICA_RELLENO_BOSS_5

; Filas en orden pseudoaleatorio.
; Son las 53 filas de bloques de 4 pixeles: 0,4,8,...,208,
; pero mezcladas. No hay repeticiones.

FINAL_FASE_5_VAMOS_A_TERMINAR_TABLA_Y:

		db		46,120,194,56,130,204,66,140,2,76,150,12,86,160,22,96
		db		170,32,106,180,42,116,190,52,126,200,62,136,210,72,146,8
		db		82,156,18,92,166,28,102,176,38,112,186,48,122,196,58,132
		db		206,68,142,4,78,152,14,88,162,24,98,172,34,108,182,44
		db		118,192,54,128,202,64,138,0,74,148,10,84,158,20,94,168
		db		30,104,178,40,114,188,50,124,198,60,134,208,70,144,6,80
		db		154,16,90,164,26,100,174,36,110,184

FINAL_FASE_5_VAMOS_A_TERMINAR_INICIO:

		; Lanzamos FX 34 al empezar la secuencia final.
		ld		a,34
		ld		c,1
		call	TIRA_FX_BOSS_5

		; Aseguramos que la page visible es la 2, que es donde vamos a pintar.
		ld		a,2
		ld		(SET_PAGE),a

		; Copiamos la plantilla ROM al buffer real en RAM.
		ld		hl,FINAL_FASE_5_VAMOS_A_TERMINAR_PLANTILLA_HMMV
		ld		de,FINAL_FASE_5_VAMOS_A_TERMINAR_DATAS_HMMV
		ld		bc,15
		ldir
        
		ld		b,106
		ld		iy,FINAL_FASE_5_VAMOS_A_TERMINAR_TABLA_Y

.BUCLE_FILAS_FINAL_FASE_5:

		push	bc

		; DY = fila actual en page 2.
		ld		a,(iy)
		inc		iy
		ld		(FINAL_FASE_5_VAMOS_A_TERMINAR_DATAS_HMMV+6),a

		; Semilla X distinta para cada fila.
		; Como la tabla Y ya esta mezclada, esto evita que todas las filas
		; se borren con el mismo orden horizontal.
		srl		a
		srl		a
		add		a,7
		and		00111111b
		ld		(FINAL_FASE_5_VAMOS_A_TERMINAR_X_SEED),a

		ld		b,64

.BUCLE_COLUMNAS_FINAL_FASE_5:

		push	bc
		push	iy

		; DX = (semilla X modulo 64) * 4.
		ld		a,(FINAL_FASE_5_VAMOS_A_TERMINAR_X_SEED)
		and		00111111b
		add		a,a
		add		a,a
		ld		(FINAL_FASE_5_VAMOS_A_TERMINAR_DATAS_HMMV+4),a

		; Pintamos bloque negro 4x4 en page 2.
		ld		hl,FINAL_FASE_5_VAMOS_A_TERMINAR_DATAS_HMMV
		call	DOCOPY
		call	VDPREADY

		; Siguiente X pseudoaleatoria.
		; 21 es coprimo con 64, asi que recorre las 64 columnas
		; sin repetir ninguna dentro de la misma fila.
		ld		a,(FINAL_FASE_5_VAMOS_A_TERMINAR_X_SEED)
		add		a,21
		and		00111111b
		ld		(FINAL_FASE_5_VAMOS_A_TERMINAR_X_SEED),a

		pop		iy
		pop		bc
		djnz	.BUCLE_COLUMNAS_FINAL_FASE_5

		pop		bc

		; Pausa corta entre filas para que el borrado respire.
		push	bc
		ld		bc,#0400

.PAUSA_ENTRE_FILAS_FINAL_FASE_5:

		dec		bc
		ld		a,b
		or		c
		jr		nz,.PAUSA_ENTRE_FILAS_FINAL_FASE_5

		pop		bc

		djnz	.BUCLE_FILAS_FINAL_FASE_5

; Fin del include.
; No hay ret.
; El ensamblador continua con la siguiente linea de BOSS 5.asm:
; VOLVEMOS_b5 -> jp CARGA_SLOT_REGRESO_A_JUEGO
