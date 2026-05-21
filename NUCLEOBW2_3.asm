RUTINA_ESPECIAL_FASE_3:
        ret

        ds      LLAMA_RUTINA_ESPECIAL_FASE_3.CONTINUACION_PAGE_66-$

CONTINUACION_RUTINA_ESPECIAL_FASE_3_PAGE_66:

        call    RUTINA_ESPECIAL_FASE_3
        ld      a,10
        ld      (DIRPA2),a
        ei

        ds      LLAMA_PAUSE_VAGON_FASE_3.CONTINUACION_PAGE_66-$

CONTINUACION_PAUSE_VAGON_FASE_3_PAGE_66:

.ESPERA_SUELTA_F1:

        ld      a,6
        call    SNSMAT_RAM
        bit     5,a
        jp      z,.ESPERA_SUELTA_F1

.ESPERA_PULSA_F1:

        ld      a,6
        call    SNSMAT_RAM
        bit     5,a
        jp      nz,.ESPERA_PULSA_F1

        ld      a,10
        ld      (DIRPA2),a
        ei
