; Datos de BOSS 3. Separado del codigo para mantener limpio BOSS 3.asm.

BOSS_3_PAGE_2_A_PAGE_1_COMPLETA:

        dw      #0000,#0200,#0000,#0100,#0100,#0100
        db      #00,#00,10010000b

BOSS_3_COPY_CORAZONES_EMPTY_DEPH:

        dw      #0000,#0000+29+200,#0000,#0200+6,#0000+10,#0000+8
        db      #00,#00,10010000b

BOSS_3_COPI_MARCADOR_BOSSES_CORAZONES_VACIOS:

        dw      #0000+151,#0000+220,#0000+151,#0203,#0000+VIDA_ANCHO_BARRA_BOSS_3,#000C
        db      #00,#00,11000000b

BOSS_3_COPY_PUNTOS_MAGIA:

        dw      #0000+25,#0000+45+200,#0000+123,#0200+6,#0000+8,#0000+8
        db      #00,#00,10010000b

BOSS_3_PAGE_1_A_PAGE_2_COMPLETA:

        dw      #0000,#0100,#0000,#0200,#0100,#0100
        db      #00,#00,10010000b

BOSS_3_COPIA_PARTE_PAGE_2_DE_STATUS:

        dw      #0000,#0200,#0000,#00B4,256,20
        db      #00,#00,10010000b

BOSS_3_COPIA_STATUS_BOSS_A_PAGE_2:

        dw      #0000,#00C8,#0000,#0200,256,20
        db      #00,#00,10010000b
