.DAMOS_NUEVOS_SPRITES:

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
			
        call    PAGE_32_A_SEGMENT_2

		ld		hl,DEPH_DE_FRENTE
		ld		de,#4000+23*8*4
		ld		bc,26*8*4
		call	PON_COLOR_2.sin_bc_impuesta
		
		ld		hl,COLOR_FRONT_DEPH
		call	VUELCA_DATOS_COLORES_DEPH_A_VRAM_SIN_HL
        
		ld		b,8
		ld		ix,ATRIBUTOS_DEPH_VARIABLES
		
.bucle_pinta_saludo:

		ld		a,33*4
		call	.pinta_sprite	
		ld		a,10
		call	.rutina_de_pausa	
		ld		a,36*4
		call	.pinta_sprite		
		ld		a,10
		call	.rutina_de_pausa
		djnz	.bucle_pinta_saludo

		pop		ix

        call    PAGE_10_A_SEGMENT_2
		jp		.SALIMOS_DEL_SALUDO

.rutina_de_pausa:

		push	bc
		
		ld		b,a

.bucle_halt:

		ei
		halt
		djnz	.bucle_halt
		pop		bc
		ret
		
.pinta_sprite:

		push	bc
		ld		(ix+18),a
		add		4
		ld		(ix+22),a
		add		4
		ld		(ix+26),a

		call	VUELCA_DATOS_DEPH_A_VRAM

		pop		bc
		
		ret

.SALIMOS_DEL_SALUDO:
