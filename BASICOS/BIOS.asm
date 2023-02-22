; BIOS
BDOS        equ     #f37D
CALSLT      equ     #001C
RDSLT       equ     #000C                                               ; lee el valor de una dirección en otro slot
WRSLT       equ     #0014                                               ; Escribe un valor en la dirección de otro slot
                                                                        ; Input:
                                                                        ; A  - Slot ID, ver RDSLT
                                                                        ; HL - Dirección
                                                                        ; E  - Valor
GICINI      equ     #0090                                               ; Reinicia PSG poniendo todos sus valores a 0                                                                     
EXPTBL      equ     #FCC0
RG0SAV		equ		#F3DF												; COPIA DE vdp DEL REGISTRO 0 (BASIC:VDP(0))
RG1SAV		equ		#F3E0												; COPIA DE vdp DEL REGISTRO 1 (BASIC:VDP(1))
RG2SAV		equ		#F3E1												; COPIA DE vdp DEL REGISTRO 2 (BASIC:VDP(2))
RG3SAV		equ		#F3E2												; COPIA DE vdp DEL REGISTRO 3 (BASIC:VDP(3))
RG4SAV		equ		#F3E3												; COPIA DE vdp DEL REGISTRO 4 (BASIC:VDP(4))
RG5SAV		equ		#F3E4												; COPIA DE vdp DEL REGISTRO 5 (BASIC:VDP(5))
RG6SAV		equ		#F3E5												; COPIA DE vdp DEL REGISTRO 6 (BASIC:VDP(6))
RG7SAV		equ		#F3E6												; COPIA DE vdp DEL REGISTRO 7 (BASIC:VDP(7))
RG8SAV		equ		#FfE7												; COPIA DE vdp DEL REGISTRO 8 (BASIC:VDP(8))
RG9SAV		equ		#FfE8												; COPIA DE vdp DEL REGISTRO 9 (BASIC:VDP(9))
RG11SAV		equ		#FFEA												; COPIA DE vdp DEL REGISTRO 11 (BASIC:VDP(11))
RG14SAV		equ		#FFED

VDP_0		equ		#F3DF												; Para direccionarse a los registros (entre 0 y 7) hay que sumarle el número de registro
VDP_8		equ		#FFDF												; Para direccionarse a los registros (entre 8 y 23) hay que sumarle el número de registro	
VDP_25		equ		#FFE1												; Para direccionarse a los registros (entre 25 y 27) hay que sumarle el número de registro

HTIMI		equ		#FD9F												; Lugar al que se va cada vez que hay una interrupción de video (60 veces por segundo)
HKEYI		equ		#FD9A												; Lugar al que se va cada vez que hay una interrupción de cualquier tipo

DIRPA1		equ		#6000												; Para cambiar el contenido de bloque 1
DIRPA2		equ		#7000												; Para cambiar el contenido de bloque 2
ENASLT		equ		#0024												; Para ampliar la rom
RSLREG  	equ		#0138												; Lee el registro del slot primario
SLOTVAR		equ		#C000												; Se usa para control del cambio de slot. Dejar libre esta dirección al escribir variables
CHGMOD		equ		#005F												; Elige el modo gráfico
FORCLR		equ		#F3E9												; Define el color de letras para CHGCLR
BAKCLR		equ		#F3EA												; Define el color de fondo para CHGCLR
BDRCLR		equ		#F3EB												; Defeine el color de bordes para CHGCLR
CLICKSW		equ		#f3DB												; Quita el sonido del toque de teclas

CHGCPU		equ		#0180                                               ; Conecta el R800
