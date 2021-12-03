#include "global.h"
#include "ui.h"
#include "stdfuncs.h"
#include "irq.h"
#include "syscall.h"

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
    print("Hello, world!\n", COLOR_WHITE);
    ui_mainloop();
    return 0;
}