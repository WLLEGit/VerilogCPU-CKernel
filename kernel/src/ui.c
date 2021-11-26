#include "ui.h"
#include "syscall.h"
#include "stdfuncs.h"

void ui_mainloop()
{
    while (true)
    {
        print("$", COLOR_WHITE);
        lock_output_front();

        char line[32];
        getline(line);

        char *cmd = strtok(line, " ");
        if (strcmp(cmd, "hello") == 0)
            hello();
        else if (strcmp(cmd, "time") == 0)
            time();
        else if (strcmp(cmd, "fib") == 0)
            fib();
        else
            error("Command not found\n");
            
    }
}

void hello()
{
    print("hello world\n", COLOR_WHITE);
}

void time()
{
    char s[10];
    itoa(sys_time, s);
    print(s, COLOR_WHITE);
    print("\n", COLOR_WHITE);
}

void fib()
{
    char* param = strtok(NULL, " ");

    int n = atoi(param);
    if(n < 0)
        error("n can't be less than zero\n");
    else
    {
        int res = 1;
        while(n)
        {
            res *= n;
            --n;
        }
        print("Result: ", COLOR_WHITE);
        char res_str[10];
        itoa(res, res_str);
        print(res_str, COLOR_WHITE);
    }
}