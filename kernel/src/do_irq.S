.global int_handler_entrance
.extern irq_handler
int_handler_entrance: 
    csrrw a1, mscratch, a1
    sw a0, 0(a1)
    sw a2, 4(a1)
    sw a3, 8(a1)
    sw a4, 12(a1)
    sw a5, 16(a1)
    sw a6, 20(a1)
    sw a7, 24(a1)
    
    csrr a0, mcause //load parameter
    call irq_handler

    lw a0, 0(a1)
    lw a2, 4(a1)
    lw a3, 8(a1)
    lw a4, 12(a1)
    lw a5, 16(a1)
    lw a6, 20(a1)
    lw a7, 24(a1)
    csrrw a1, mscratch, a1
    mret
    