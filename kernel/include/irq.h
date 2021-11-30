#ifndef _IRQ_H
#define _IRQ_H
#include "global.h"
void init_CSR();
void irq_handler(uint32_t irq);

#endif  