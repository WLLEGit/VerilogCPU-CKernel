#ifndef _IRQ_H
#define _IRQ_H

void add_all_irq_handlers();
void irq_clock();
void irq_keyboard();

typedef struct
{
    union
    {
        uint32_t mstatus;
        struct 
        {
            uint32_t unused : 3;
            uint32_t mie : 1;
            uint32_t unused2 : 28;
        };
        
    };
    uint32_t mtvec;
    uint32_t mscratch;
    uint32_t mepc;
    uint32_t mcause;
} CSRS;

extern CSRS csrs;

#endif  