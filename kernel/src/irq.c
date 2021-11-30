#include "irq.h"
#include "global.h"
#include "io_mm.h"

CSRS csrs;

void add_all_irq_handlers()
{
    idt_mem[1] = (uint32_t)irq_clock;
    idt_mem[2] = (uint32_t)irq_keyboard;
    idt_mem[0] = 0xFFFFFFFF; //enable irqs
}

void irq_clock()
{
    sys_time++;
}

void irq_keyboard()
{
    kb_info = *p_kb_info;
}