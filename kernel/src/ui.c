#include "ui.h"
#include "syscall.h"
#include "stdfuncs.h"

void ui_mainloop()
{
    while (true)
    {
        print("$ ", COLOR_WHITE);
        lock_output_front();

        char line[64];
        getline(line);
        lock_output_front();

        char *cmd = strtok(line, " ");
        if (strcmp(cmd, "hello") == 0)
            hello();
        else if (strcmp(cmd, "time") == 0)
            time();
        else if (strcmp(cmd, "fib") == 0)
            fib();
        else if (strcmp(cmd, "calc") == 0)
            calc();
        else if (strcmp(cmd, "marquee") == 0)
            marquee();
        else if (strcmp(cmd, "chardance") == 0)
            chardance();
        else if (strcmp(cmd, "") == 0)
            continue;
        // else if (strcmp(cmd, "help") == 0)
        // {
        //     print("Commands:\n", COLOR_WHITE);
        //     print("\thello\toutput \"hello world\"\n", COLOR_WHITE);
        //     print("\ttime\toutput current time\n", COLOR_WHITE);
        //     print("\tfib <n>\toutput fib(n)\n", COLOR_WHITE);
        //     print("\tcalc <expr>\tcalculate the expression, white space required between each symbol\n", COLOR_WHITE);
        //     print("\tmarquee\trun marquee on the DE10 hardware\n", COLOR_WHITE);
        // }
        else
        {
            error("Command not found: ");
            print(cmd, COLOR_WHITE);
            print("\n", COLOR_WHITE);
        }
    }
}

void hello()
{
    print("hello world\n", COLOR_WHITE);
}

void time()
{
    while (!is_ctrl_c())
    {
        print("\b\b\b\b\b\b\b\b\b", COLOR_WHITE);
        printint(sys_time, COLOR_WHITE);
        wait_ms(1);
    }
    putc('\n', COLOR_WHITE);
}

void fib()
{
    char *param = strtok(NULL, " ");

    int n = atoi(param);

    if (n < 0)
        error("expect positive number: [n]\n");
    else
    {
        int res = 1;
        while (n)
            res = __mulsi3(res, n--);
        print("Result: ", COLOR_WHITE);
        printint(res, COLOR_WHITE);
        putc('\n', COLOR_WHITE);
    }
}

void calc()
{
    char *expr = strtok(NULL, "");
    bool *success;
    int res = calc_expr(expr, success);
    if (*success)
    {
        print("Result: ", COLOR_WHITE);
        printint(res, COLOR_WHITE);
        putc('\n', COLOR_WHITE);
    }
    else
        error("Invalid expression\n");
}

void marquee()
{
    int hex = 0;
    int ledr = 0;
    const int hex_max = 0xF;
    const int ledr_max = 0x9;
    while (!is_ctrl_c())
    {
        for (int i = 0; i < 6; ++i)
            set_hex(hex, i);
        if (++hex == hex_max)
            hex = 0;
        set_ledr_all(1 << (ledr++));
        if (ledr == ledr_max)
            ledr = 0;
        wait_ms(500);
    }
    for (int i = 0; i < 6; ++i)
        set_hex(0, i);
    set_ledr_all(0);
}

char type2char[] = {'.',':','+','*','?','%','#','@'};
uint32_t ms_per_frame = 33;
typedef struct
{
    uint8_t type : 3;
    uint8_t num : 5;
} VideoChar;

void chardance()
{
    switch_mode(VIDEO_MODE);
    VideoChar *p = (VideoChar *)VIDEO_OFFSET;
    volatile uint32_t cnt_out = 0;
    char c;

    while (!is_ctrl_c())
    {
        uint32_t frame_start = sys_time;
        cnt_out = 0;
        while(cnt_out < 30*64)
        {
            // prepare next frame
            volatile VideoChar vc = *p;
            const uint8_t num = vc.num;
            c = type2char[vc.type];
            const char c_check = c;
            ++p;
            cnt_out += vc.num;
            for(int i = 0; i < vc.num; ++i)
            {
                if(c != c_check)
                {
                    error("char changed");
                    putc(c, COLOR_WHITE);
                    putc(' ', COLOR_WHITE);
                    putc(c_check, COLOR_WHITE);
                    putc('\n', COLOR_WHITE);
                    wait_ms(5000);
                }
                if(num != vc.num)
                {
                    error("num changed");
                    printint(num, COLOR_WHITE);
                    putc(' ', COLOR_WHITE);
                    printint(vc.num, COLOR_WHITE);
                    putc('\n', COLOR_WHITE);
                    wait_ms(5000);
                }
                putc_buffer(c, COLOR_WHITE);
            }
        }
        wait_ms(ms_per_frame - (sys_time - frame_start));
        switch_screen();
    }

    switch_mode(CMD_MODE);
}