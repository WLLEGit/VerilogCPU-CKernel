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
        else if (strcmp(cmd, "calc") == 0)
            calc();
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
        error("expect positive number: [n]\n");
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

void calc()
{
    char* expr = strtok(NULL, "");
    bool* success;
    int res = calc_expr(expr, success);
    if(*success)
    {
        char res_str[10];
        itoa(res, res_str);
        print(res_str, COLOR_WHITE);
    }
    else
        error("Invalid expression\n");
}