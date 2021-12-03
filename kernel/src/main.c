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
    // print("Hello, world!\n", COLOR_WHITE);
    // print("ABCDEFGHIJKLMNOPQRSTUVWXYZ\n", COLOR_WHITE);
    // print("abcdefghijklmnopqrstuvwxyz\n", COLOR_WHITE);
    uint32_t *p_dbg_data = (uint32_t *)DEBUG_OFFSET;
    char str[100];
    uint32_t t = sys_time;
    itoa(sys_time, str);
    print(str, COLOR_WHITE);
    putc('\n', COLOR_WHITE);

    while(1)
    {
        while (sys_time < t+1000)
            *p_dbg_data = sys_time;
        t = sys_time;
        itoa(sys_time, str);
        print(str, COLOR_WHITE);
        putc('\n', COLOR_WHITE);
    }
    return 0;
}