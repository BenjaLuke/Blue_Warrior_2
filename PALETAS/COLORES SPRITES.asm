COLOR_SPRITE_INTERRUPCION:

		; --- TAPA INTERRUPCION

		; attr 0
		DB $04,$00,$00,$00,$00,$00,$00,$00
;		DB $00,$00,$00,$00,$00,$00,$00,$00
		
COLORES_SPRITES_DEPH:

		; --- DEPH BACK 0 0

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $01,$04,$04,$04,$04,$04,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$41,$41,$41,$41,$41,$41
		; 
		; --- DEPH BACK 0 1

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$01,$01,$01,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$41,$41
		; 

COLOR_POSE_0_Y_2:

		; --- DEPH BACK 0 2

		; attr 0
		DB $09,$04,$04,$04,$04,$04,$04,$04
COLOR_POSE_0_Y_2_CUT:

		DB $04,$09,$04,$01
		db $04,$04,$01,$01

		; attr 1
		DB $44,$41,$41,$41,$41,$41,$41,$41
		DB $41,$44,$41,$00
		db $41,$41,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$00,$00
		db $00,$00,$00,$00
		; 
		; --- DEPH BACK 0 3

		; attr 0
		DB $09,$04,$04,$01,$01,$04,$04,$01
		DB $01,$08,$01,$00
		db $00,$01,$01,$01

		; attr 1
		DB $44,$41,$41,$00,$00,$41,$41,$00
		DB $00,$41,$00,$00
		db $00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00
		db $00,$00,$00,$00
		; 

COLOR_POSE_1:

		; --- DEPH BACK 1 2

		; attr 0
		DB $09,$04,$04,$04,$04,$04,$04,$04
COLOR_POSE_1_CUT:

		DB $09,$09,$09,$04
		db $04,$04,$01,$01

		; attr 1
		DB $44,$41,$41,$41,$41,$41,$41,$41
		DB $44,$44,$44,$41
		db $41,$41,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $41,$41,$41,$00
		db $00,$00,$00,$00
		; 
		; --- DEPH BACK 1 3

		; attr 0
		DB $09,$04,$04,$01,$01,$04,$04,$01
		DB $04,$01,$00,$00
		db $01,$01,$01,$01

		; attr 1
		DB $44,$41,$41,$00,$00,$41,$41,$00
		DB $41,$00,$00,$00
		db $00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00
		db $00,$00,$00,$00
		; 

COLOR_POSE_3:

		; --- DEPH BACK 2 2

		; attr 0
		DB $09,$04,$04,$04,$04,$04,$04,$04
COLOR_POSE_3_CUT:

		DB $04,$09,$04,$04
		db $04,$04,$01,$01

		; attr 1
		DB $44,$41,$41,$41,$41,$41,$41,$41
		DB $41,$44,$41,$41
		db $41,$41,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$00,$00
		db $00,$00,$00,$00
		; 
		; --- DEPH BACK 2 3

		; attr 0
		DB $09,$04,$04,$01,$04,$04,$01,$01
		DB $08,$08,$08,$01
		db $00,$01,$01,$01

		; attr 1
		DB $44,$41,$41,$00,$41,$41,$00,$00
		DB $41,$41,$41,$00
		db $00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
;		DB $00,$00,$00,$00,$00,$00,$00,$00

COLOR_FRONT_DEPH:

		; 
		; --- DEPH FRONT 0 0
		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $01,$04,$04,$04,$04,$04,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$41,$41,$41,$41,$41,$41
		; 
		; --- DEPH FRONT 0 1

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$01,$01,$01,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$41,$41
		; 
		; --- DEPH FRONT 0 2
		; attr 0
		DB $09,$04,$09,$08,$08,$04,$04,$04
		DB $04,$09,$04,$04,$04,$04,$01,$01
		; attr 1
		DB $44,$41,$44,$41,$41,$41,$41,$41
		DB $41,$44,$41,$41,$41,$41,$00,$00

		; attr 2
		DB $41,$00,$41,$00,$00,$00,$00,$00
		DB $00,$41,$00,$00,$00,$00,$00,$00
		; 
		; --- DEPH FRONT 0 3
		; attr 0
		DB $09,$04,$04,$01,$01,$04,$04,$01
		DB $01,$08,$01,$00,$00,$01,$01,$01
		; attr 1
		DB $44,$41,$41,$00,$00,$41,$41,$00
		DB $00,$41,$00,$00,$00,$00,$00,$00
		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
COLOR_FLECHA:
		; attr 0
		DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		DB $0F,$0F,$0F,$05,$05,$04,$04,$00
COLOR_BOLA_FUEGO:
		
		; attr 0
		DB $00,$00,$00,$00,$00,$00,$0f,$0f
		DB $04,$05,$00,$00,$00,$00,$00,$00
/*
		DB $00,$00,$00,$00,$00,$00,$0f,$04
		DB $05,$0f,$00,$00,$00,$00,$00,$00

		DB $00,$00,$00,$00,$00,$00,$04,$05
		DB $04,$05,$00,$00,$00,$00,$00,$00*/
COLOR_HACHA_1:
		; attr 0		
		DB $00,$00,$0F,$0F,$0F,$0F,$0F,$01
		DB $01,$01,$01,$01,$01,$01,$00,$00		
COLOR_HACHA_2:
		; attr 0
		DB $00,$00,$01,$01,$01,$01,$01,$01
		DB $01,$0F,$0F,$0F,$0F,$0F,$00,$00

COLOR_SKRULLEX_QUE_DA_COSAS_1_1:
COLOR_SKRULLEX_QUE_DA_COSAS_2_1:
		; attr 0
		DB $01,$08,$08,$08,$08,$08,$08,$08
		DB $08,$08,$08,$08,$08,$08,$08,$01
COLOR_SKRULLEX_QUE_DA_COSAS_1_2:
COLOR_SKRULLEX_QUE_DA_COSAS_2_2:		
		; attr 1
		DB $41,$41,$41,$41,$41,$41,$41,$41
		DB $41,$41,$41,$41,$41,$41,$41,$41
COLOR_COVID_1_1:
COLOR_COVID_2_1:
		; 
		; --- COVID 1
		; attr 0
		DB $01,$01,$01,$01,$01,$01,$01,$01
		DB $01,$01,$01,$01,$01,$01,$01,$01

COLOR_SLIME_AZUL_1_1:
		; 
		; --- SLIME 1-1

		; attr 0
		DB $00,$00,$00,$00,$00,$0E,$0E,$0E
		DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
COLOR_SLIME_AZUL_1_2:

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$45,$45
		DB $45,$45,$45,$45,$45,$45,$45;,$00

COLOR_SLIME_VERDE_1_1:
		; attr 0
		DB $00,$00,$00,$00,$00,$0D,$0D,$0D
		DB $0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D
COLOR_SLIME_VERDE_1_2:

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$4A,$4A
		DB $4A,$4A,$4A,$4A,$4A,$4A,$4A,$00
COLOR_EXPLOSION:
		; 
		; --- EXPLOSION 1
		; attr 0
		DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		DB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
COLOR_CORVELLINI:		
		; 
		; --- CORVELLINI

		; attr 0
		DB $00,$01,$01,$01,$01,$01,$01,$01
		DB $01,$01,$01,$01,$01,$01,$01,$01
COLOR_CORVELLINI_S4:		
		; 
		; --- CORVELLINI

		; attr 0
		DB $00,$05,$05,$05,$05,$05,$05,$05
		DB $05,$05,$05,$05,$05,$05,$05,$05
COLOR_MUERTE:

		; 
		; --- CAE 1 1

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$01,$04,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$41,$41,$41
		; 
		; --- CAE 1 2

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$01

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		; 
		; --- CAE 1 3

		; attr 0
		DB $04,$04,$04,$09,$04,$04,$04,$04
		DB $04,$04,$04,$04,$09,$04,$09,$01

		; attr 1
		DB $41,$41,$41,$44,$41,$41,$41,$41
		DB $41,$41,$41,$41,$44,$41,$44,$00

		; attr 2
		DB $00,$00,$00,$41,$00,$00,$00,$00
		DB $00,$00,$00,$00,$41,$00,$41,$00
		; 
		; --- CAE 1 4

		; attr 0
		DB $01,$04,$04,$09,$04,$04,$01,$01
		DB $04,$04,$04,$01,$01,$01,$08,$01

		; attr 1
		DB $00,$41,$41,$44,$41,$41,$00,$00
		DB $41,$41,$41,$00,$00,$00,$41,$00

		; attr 2
		DB $00,$00,$00,$41,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00;,$00,$00,$00
	
COLOR_MUERTE_2:
		; 
		; --- CAE 2 3

		; attr 0
		DB $00,$00,$00,$01,$04,$04,$04,$04
		DB $04,$09,$04,$04,$04,$04,$04,$01

		; attr 1
		DB $00,$00,$00,$00,$41,$41,$41,$41
		DB $41,$44,$41,$41,$41,$41,$41,$00

		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$00,$00,$00,$00,$00,$00
		; 
		; --- CAE 2 4

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$01,$04
		DB $01,$04,$01,$08,$01,$00,$00,$00

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$41
		DB $00,$41,$00,$41;,$00,$00,$00,$00

COLOR_SLIME_BLANCO_1:
		; attr 0
		DB $00,$00,$00,$00,$00,$0E,$0E,$0E
		DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E

COLOR_SLIME_BLANCO_2
		; attr 1
		DB $00,$00,$00,$00,$00,$00,$47,$47
		DB $47,$47,$47,$47,$47,$47,$47;,$00

COLOR_EJERCICIO_1:
		; 
		; --- PAUSA 1 1

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $01,$04,$04,$04,$04,$04,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$41,$41,$41,$41,$41,$41
		; 
		; --- PAUSA 1 2

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$01,$01,$01,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$41,$41
		; 
		; --- PAUSA 1 3

		; attr 0
		DB $09,$09,$04,$04,$04,$04,$04,$04
		DB $04,$04,$04,$01,$04,$04,$01,$01

		; attr 1
		DB $44,$44,$41,$41,$41,$41,$41,$41
		DB $41,$41,$41,$00,$41,$41,$00,$00

		; attr 2
		DB $41,$41,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		; 
		; --- PAUSA 1 4

		; attr 0
		DB $09,$09,$04,$04,$01,$04,$04,$01
		DB $00,$00,$00,$00,$00,$01,$01,$01

		; attr 1
		DB $44,$44,$41,$41,$00,$41,$41,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$41,$00,$00,$00,$00,$00,$00
		DB $00,$00;,$00,$00,$00,$00,$00,$00

COLOR_EJERCICIO_2:
		; 
		; --- PAUSA 2 3

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$01,$04
		DB $04,$04,$04,$04,$04,$09,$01,$01

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$41
		DB $41,$41,$41,$41,$41,$44,$00,$00

		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$41,$00,$00
		; 
		; --- PAUSA 2 4

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$01,$04,$01,$08,$01,$01

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$41,$00,$41;,$00,$00

COLOR_PROYECTIL_NORMAL:

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$07,$0F
		DB $0E,$0E,$00,$00,$00,$00,$00,$00

COLOR_CHECK_POINT_1:
		; attr 0
		DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
		DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
COLOR_CHECK_POINT_2:
		; attr 1
		DB $41,$41,$41,$41,$41,$41,$41,$41
		DB $41,$41,$41,$41,$41,$41,$41;,$00
COLOR_CORAZON_1:
		; 
		; --- CORAZÓN
		; attr 0
		DB $00,$0D,$0D,$0D,$0D,$0D,$0D,$0D
		DB $0D,$0D,$0D,$0D,$0D,$0D,$0D,$00


COLOR_CORAZON_2:		
		; attr 1
		DB $00,$00,$43,$43,$43,$43,$43,$43
		DB $43,$43,$43,$43,$43,$43,$00,$00
COLOR_CORAZON_5:
		; 
		; --- CORAZÓN
		; attr 0
		DB $00,$00,$4B,$4B,$4B,$4B,$4B,$4B
		DB $4B,$4B,$4B,$4B,$4B,$4B,$00,$00
COLOR_CORAZON_4:
		DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
		DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
COLOR_LETRAS_PREMIO:
COLOR_TITULO_STAGE:
COLOR_COGE_FLECHA:
		; attr 0
;		DB $03,$0D,$03,$0D,$03,$0D,$03,$0D
;		DB $03,$0D,$03,$0D,$03,$0D,$03,$0D
COLOR_COGE_FUEGO:
		; attr 0
;		DB $00,$03,$0D,$03,$0D,$03,$0D,$03
;		DB $0D,$03,$0D,$03,$0D,$03,$0D,$03
COLOR_COGE_HACHA:
		; attr 0
;		DB $00,$0D,$03,$0D,$03,$0D,$03,$0D
;		DB $03,$0D,$03,$0D,$03,$0D,$03,$0D		; 
		; --- STAGE 1,2,3,4,5
		; attr 0
		DB $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
		DB $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f

COLOR_DEPH_CASCOS:
		; 
		; --- DEPH 1 1 NON MUSIC

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $01,$04,$04,$04,$04,$04,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$41,$41,$41,$41,$41,$41
		; 
		; --- DEPH 1 2 NON MUSIC

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$01,$01,$01,$01,$01

COLOR_CORAZON_3:

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
COLORES_DEPH_CASCOS_POSE_0_Y_2:
		; 
		; --- DEPH 1 3 NON MUSIC

		; attr 0
		DB $04,$04,$04,$04,$04,$04,$04,$04
COLORES_DEPH_CASCOS_POSE_0_Y_2_CUT:

		DB $04,$09,$04,$01,$04,$04,$01,$01

		; attr 1
		DB $41,$41,$41,$41,$41,$41,$41,$41
		DB $41,$44,$41,$00,$41,$41,$00,$00

		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$00,$00,$00,$00,$00,$00
		; 
		; --- DEPH 1 4 NON MUSIC

		; attr 0
		DB $04,$04,$04,$01,$01,$04,$04,$01
		DB $01,$08,$01,$00,$00,$01,$01,$01

		; attr 1
		DB $41,$41,$41,$00,$00,$41,$41,$00
		DB $00,$41,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00		

COLORES_DEPH_CASCOS_POSE_1:

		; 
		; --- DEPH 2 3 NON MUSIC

		; attr 0
		DB $04,$04,$04,$04,$04,$04,$04,$04
COLORES_DEPH_CASCOS_POSE_1_CUT:
		DB $09,$09,$09,$04,$04,$04,$01,$01

		; attr 1
		DB $41,$41,$41,$41,$41,$41,$41,$41
		DB $44,$44,$44,$41,$41,$41,$00,$00

		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $41,$41,$41,$00,$00,$00,$00,$00
		; 
		; --- DEPH 2 4 NON MUSIC

		; attr 0
		DB $04,$04,$04,$01,$01,$04,$04,$01
		DB $04,$01,$00,$00,$01,$01,$01,$01

		; attr 1
		DB $41,$41,$41,$00,$00,$41,$41,$00
		DB $41,$00,$00,$00,$00,$00,$00,$00
		
		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00		

COLORES_DEPH_CASCOS_POSE_3:

		; 
		; --- DEPH 3 3 NON MUSIC

		; attr 0
		DB $04,$04,$04,$04,$04,$04,$04,$04
COLORES_DEPH_CASCOS_POSE_3_CUT:

		DB $04,$09,$04,$04,$04,$04,$01,$01

		; attr 1
		DB $41,$41,$41,$41,$41,$41,$41,$41
		DB $41,$44,$41,$41,$41,$41,$00,$00

		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$00,$00,$00,$00,$00,$00
		; 
		; --- DEPH 3 4 NON MUSIC

		; attr 0
		DB $04,$04,$04,$01,$04,$04,$01,$01
		DB $08,$08,$08,$01,$00,$01,$01,$01

		; attr 1
		DB $41,$41,$41,$00,$41,$41,$00,$00
		DB $41,$41,$41,$00,$00,$00,$00,$00
		
		; attr 2
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00		

COLOR_EJERCICIO_1_CASCOS:
		; 
		; --- DEPH 1 1 NON MUSIC

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $01,$04,$04,$04,$04,$04,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$41,$41,$41,$41,$41,$41
		; 
		; --- DEPH 1 2 NON MUSIC

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$01,$01,$01,$01,$01
		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		; 
		; --- PAUSE MUSIC 1

		; attr 0
		DB $04,$09,$04,$04,$04,$04,$04,$04
		DB $04,$04,$04,$01,$04,$04,$01,$01

		; attr 1
		DB $41,$44,$41,$41,$41,$41,$41,$41
		DB $41,$41,$41,$00,$41,$41,$00,$00

		; attr 2
		DB $00,$41,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		; 
		; --- PAUSE MUSIC 2

		; attr 0
		DB $04,$09,$04,$04,$01,$04,$04,$01
		DB $01,$01,$00,$00,$00,$01,$01,$01

		; attr 1
		DB $41,$44,$41,$41,$00,$41,$41,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $00,$41,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00		

COLOR_GUSANO_1_1:
COLOR_GUSANO_2_1:
		; 
		; --- GUSANO 1

		; attr 0
		DB $01,$04,$04,$04,$04,$04,$04,$04
		DB $04,$04,$04,$04,$04,$04,$04,$01

COLOR_GUSANO_1_2:
COLOR_GUSANO_2_2:

		; attr 1
		DB $00,$41,$41,$41,$41,$41,$41,$41
		DB $41,$41,$41,$41,$41,$41,$41,$00

COLOR_MEGADEATH_HEAT_1:
		; 
		; --- MEGADEATH HEAT

		; attr 0
		DB $00,$00,$00,$00,$00,$01,$0A,$0A
		DB $0A,$0A,$0A,$0A,$0A,$0A,$0A,$01
COLOR_MEGADEATH_HEAT_2:
		; attr 1
		DB $00,$00,$00,$00,$00,$00,$41,$41
		DB $41,$41,$41,$41,$41,$41,$41,$00

COLOR_MEGADEATH_BODY_1:
		; 
		; --- MEGADEATH 2 BODY

		; attr 0
		DB $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
		DB $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A

COLOR_MEGADEATH_BODY_2:
		; attr 1
		DB $41,$41,$41,$41,$41,$41,$41,$41
		DB $41,$41,$41,$41,$41,$41,$41,$41

COLOR_DEPH_AGUJERO_CABEZA:

		; 
		; --- DEPH EN AGUJERO 0 1

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $01,$04,$04,$04,$04,$04,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$41,$41,$41,$41,$41,$41
		; 
		; --- DEPH EN AGUJERO 0 2

		; attr 0
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$01,$01,$01,$04,$04

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$41,$41


COLOR_DEPH_AGUJERO_0:
		; 
		; --- DEPH EN AGUJERO NEUTRO 3

		; attr 0
		DB $09,$09,$09,$08,$08,$04,$04,$04
		DB $04,$00,$00,$00,$00,$00,$00,$00

		; attr 1
		DB $44,$44,$44,$41,$41,$41,$41,$41
		DB $41,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$41,$41,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		; 
		; --- DEPH EN AGUJERO NEUTRO 4

		; attr 0
		DB $09,$04,$04,$01,$08,$01,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 1
		DB $44,$41,$41,$00,$41,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

COLOR_DEPH_AGUJERO_1:
		; 
		; --- DEPH EN AGUJERO 0 3

		; attr 0
		DB $09,$09,$09,$09,$09,$09,$04,$04
		DB $04,$00,$00,$00,$00,$00,$00,$00

		; attr 1
		DB $44,$44,$44,$41,$41,$44,$41,$41
		DB $41,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$41,$41,$00,$00,$41,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		; 
		; --- DEPH EN AGUJERO 0 4

		; attr 0
		DB $09,$04,$04,$01,$01,$08,$01,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 1
		DB $44,$41,$41,$00,$00,$41,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

COLOR_DEPH_AGUJERO_2:

		; 
		; --- DEPH EN AGUJERO 1 3

		; attr 0
		DB $09,$09,$09,$09,$09,$09,$04,$04
		DB $04,$00,$00,$00,$00,$00,$00,$00

		; attr 1
		DB $44,$44,$44,$44,$41,$44,$41,$41
		DB $41,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$41,$41,$41,$00,$41,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; 
		; --- DEPH EN AGUJERO 1 4

		; attr 0
		DB $09,$04,$04,$01,$08,$01,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 1
		DB $44,$41,$41,$00,$41,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00		

COLOR_SLIME_FUEGO_1:

		; 
		; --- SLIME DE FUEGO 1

		; attr 0
		DB $00,$00,$00,$00,$00,$01,$02,$02
		DB $02,$02,$02,$02,$02,$02,$02,$01
COLOR_SLIME_FUEGO_2:

		; attr 1
		DB $00,$00,$00,$00,$00,$00,$41,$41
		DB $41,$41,$41,$41,$41,$41,$41,$00
COLORES_ECTO_PALLERS_1:
		; attr 0
		DB $01,$0E,$0E,$0E,$0E,$0E,$0E,$0E
		DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$01
COLORES_ECTO_PALLERS_2:

		; attr 1
		DB $00,$41,$41,$41,$41,$41,$41,$41
		DB $41,$41,$41,$41,$41,$41,$41,$00

COLOR_TITULO_GAME_OVER:

		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
		db	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F

COLOR_FIREWORKS:

		db	$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
		db	$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
COLOR_PIES_EN_LODO:

		; attr 0
		DB $09,$04,$04,$04,$04,$04,$04,$04
		DB $04,$09,$04,$01,$01,$01,$01,$01

		; attr 1
		DB $44,$41,$41,$41,$41,$41,$41,$41
		DB $41,$44,$41,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$41,$00,$00,$00,$00,$00,$00
		; 
		; --- PIES DEPH AGUA 6

		; attr 0
		DB $09,$04,$04,$01,$04,$04,$01,$01
		DB $08,$08,$01,$01,$01,$01,$01,$01

		; attr 1
		DB $44,$41,$41,$00,$41,$41,$00,$00
		DB $41,$41,$00,$00,$00,$00,$00,$00

		; attr 2
		DB $41,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00

COLOR_ROCKAGER_MAREADO:
		; attr 0
		DB $00,$00,$00,$00,$00,$00,$01,$01
		DB $01,$00,$01,$01,$01,$01,$01,$00