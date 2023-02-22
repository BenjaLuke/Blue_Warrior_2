NUEVO_F37D:
                
                call    PONEMOS_ANTIGUA_INT
                
DIR_F37D_ORIGINAL:      
                
                call    00000             
                call    PONEMOS_NUEVA_INT             
                ret
;----------------------------------------------------------
PONEMOS_ANTIGUA_INT:

                di
                push    af
                push    hl
                push    bc
LLAMADA_INT_ORIGINAL:                
                
            ld      hl,0                                                ; Cuidado que se reescribe
            ld      (39h),hl
               
            xor     a                                                   ; Set status register 0 VDP
            out     (99h),a
            ld      a,080h+15
            out     (99h),a
                
            pop     bc
            pop     hl
            pop     af
            ret        

PONEMOS_NUEVA_INT:

            di
                
            push    af
            push    hl
            push    bc
                
            
            ld      a,2                                                 ; Set status register 2 VDP
            out     (99h),a
            ld      a,080h+15
            out     (99h),a
                
                
            ld      hl,INT
            ld      (39h),hl
                
            pop     bc
            pop     hl
            pop     af
                
                
            ei
            ret

INT:

            push   af
            push   hl         
            push   de         
            push   bc         
            exx               
            ex     af,af'     
            push   hl         
            push   de         
            push   bc         
            push   af         
            push   iy         
            push   ix 

            call    NUESTRAS_INT
               	    
            ld      a,2                                                 ; Set s2
            out     (99h),a
            ld      a,080h+15
            out     (99h),a

            pop    ix         
            pop    iy         
            pop    af         
            pop    bc         
            pop    de         
            pop    hl         
            ex     af,af'     
            exx               
            pop    bc         
            pop    de         
            pop    hl         
            pop	af
            ei
            ret
;---------------------------------------------------

GUARDA_VALORES_INT_y_F37D:	


            di		                                                    ; Guardamos INT original

            ld      hl,(038h+1)
            ld      (LLAMADA_INT_ORIGINAL+1),hl
            
            ld      hl,(0F37Dh+1)                                       ; Cambia salto acceso rutinas DOS
            ld      (DIR_F37D_ORIGINAL+1),hl

            ld      hl,NUEVO_F37D
            ld      (0F37Dh+1),hl
            ret