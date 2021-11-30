#include "global.h"
#include "ui.h"
#include "irq.h"

int main();
void entry()
{
    asm("lui sp, 0x00120");
    asm("addi sp, sp, -4");
    main();
}

int main()
{
    init_CSR();
    ui_mainloop();
    return 0;
}