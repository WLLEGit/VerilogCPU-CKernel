.global int_handler_entrance
.extern irq_handler
int_handler_entrance: 
    csrrw t6, mscratch, t6
    nop
    nop
    sw a0, 0(t6)
    sw a1, 4(t6)
    sw a2, 8(t6)
    sw a3, 12(t6)
    sw a4, 16(t6)
    sw a5, 20(t6)
    sw a6, 24(t6)
    sw a7, 28(t6)
    sw x1, 32(t6)
    sw s0, 36(t6)
    sw s1, 40(t6)
    
    csrr a0, mcause //load parameter
    call irq_handler

    lw a0, 0(t6)
    lw a1, 4(t6)
    lw a2, 8(t6)
    lw a3, 12(t6)
    lw a4, 16(t6)
    lw a5, 20(t6)
    lw a6, 24(t6)
    lw a7, 28(t6)
    lw x1, 32(t6)
    lw s0, 36(t6)
    lw s1, 40(t6)
    csrrw t6, mscratch, t6
    mret
    