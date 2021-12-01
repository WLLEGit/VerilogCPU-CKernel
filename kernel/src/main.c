#include "global.h"
#include "ui.h"
#include "irq.h"

int main();
void entry()
{
    asm("lui sp, 0x00120");
    asm("addi sp, sp, -4");
    init_io_mm();
    init_CSR();
    main();
}

int main()
{
    ui_mainloop();
    return 0;
}