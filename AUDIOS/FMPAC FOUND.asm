BUSCAMOS_FM_PAC:

			;Output: 
			;	A=0 No se encontró el FM
			;	A=1 Sí se encontró el FM

			call	BUSCANDO_LA_CADENA_OPLL
	
FM_ENCONTRADO:

			cp		0FFh
			ret		z 														; No FM!!!
			
			ld		c,a														; Slot
			push	bc														; C ->slot FM
			
			ld		a,1
			ld		(FMPAC_DESCONECTADO),a
		
			ld		a,(chips)												; Cargamos en A el valor de chips
			set		1,a														; Lo convierte en xxxxxx1x para indicar que es estero
			ld		(chips),a												; Lo salva para futuros usos
					
			ld		a,c														; Slot
			ld		hl,#7FF6
			call	RDSLT
			
			or		00000001B		
			ld		e,a														; Valor a escribir

			pop		bc
			ld		a,c
			ld		hl,#7FF6
			call	WRSLT
			
			ret

BUSCANDO_LA_CADENA_OPLL:	
	
			ld		bc,00400h 												; Bucle DJNZ. Metemos 4 en B para mirar los 4 slots
			ld		hl,0fcc1h 												; En RAM ->EXPTBL 

SIGUIENTE_SLOT:
			push	bc
			push	hl
			ld		a,(hl)
			bit		7,a														; Slot expandido?
			jr		nz,EXPANSION_1
			ld		a,c
			call	COTEJA_CARACTERES_FM
			jr		SIGUIENTE_SLOT_3
EXPANSION_1:
			call	EXPANSION

SIGUIENTE_SLOT_3:

			ld		a,c														; Slot
			pop		hl
			pop		bc
			ret		z														; Si es diferente de FFh -> Encontrado!!!
			inc		hl
			inc		c
			djnz	SIGUIENTE_SLOT
			ld		a,0FFh													; El FM no ha sido encontrado, por tanto->A=0FFh
			ret

EXPANSION:

			and		080h
			or		c
			ld		c,a														; Slot más expandido o no
			ld		b,4
SIGUIENTE_SLOT_4:

			push	bc
			call	COTEJA_CARACTERES_FM
			pop		bc
			ret		z														; Si es diferente de FFh -> Encontrado!!!
			ld		a,c
			add		a,04
			ld		c,a
			djnz	SIGUIENTE_SLOT_4

	ret

COTEJA_CARACTERES_FM:

			; Output:
			; z: encontrado
			; nz: no encontrado

			ld		hl,0401Ch
			ld		de,OPLL_TEXT
			ld		c,a
			ld		b,4													; Cantidad de caracteres a revisar en la cadena "OPLL"

SIGUIENTE_CARACTER_FM:

			push	de
			push	bc
			ld		a,c
;			or		080h												;EXPANSION
			call	RDSLT												; Lee el valor de otro slot
			pop		bc
			pop		de
			ex		de,hl
			cp		(hl)
			ex		de,hl
			ret		nz
			inc		hl
			inc		de
			djnz	SIGUIENTE_CARACTER_FM
			xor		a 													; Z set
			ret

OPLL_TEXT:  DB    "OPLL"