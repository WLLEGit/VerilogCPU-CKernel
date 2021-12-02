#include "syscall.h"

uint8_t * const ch_mem  = (uint8_t*)VGA_CHAR_OFFSET;
uint8_t * const color_mem  = (uint8_t*)VGA_COLOR_OFFSET;
uint32_t * const idt_mem = (uint32_t*)IDT_OFFSET;
volatile uint32_t sys_time = 0;

uint32_t monitor_write_cursor = 0;
uint32_t output_front_cursor = 0;

InputController input_controller;

void putc(const char c, const uint8_t color)
{
    if(c == '\n')
    {
        monitor_write_cursor = (monitor_write_cursor / COL_CNT) * (COL_CNT) + COL_CNT;
        if(monitor_write_cursor == TOTAL_CHAR)
            scroll_screen();
    }
    else if(c == '\t')
        print("    ", COLOR_WHITE);
    else if(c == '\b')
    {
        if(output_front_cursor < monitor_write_cursor)
            _erasec(--monitor_write_cursor);
    }
    else
    {
        _setc(c, color, monitor_write_cursor);
        if(monitor_write_cursor == TOTAL_CHAR)
            scroll_screen();
    }
}

void print(const char* str, const uint8_t color)
{
    char c = *str;
    while(c)
    {
        putc(c, color);
        ++str; c= *str;
    }
}

char getc()
{
    while(!_next_key_arrived());  //wait input
    char c = kb_info.c;
    input_controller.pre_c = c;
    input_controller.pre_time = sys_time;
    putc(c, COLOR_WHITE);
    return c;
}

void getline(char* buf)
{
    char c;
    int i = 0;
    while((c=getc()) != '\n')
        buf[i++] = c;
}

void scroll_screen()
{
    vga_info.extra_line_cnt++;
    if(vga_info.extra_line_cnt == ROW_CNT)
        vga_info.extra_line_cnt = 0;
    monitor_write_cursor -= COL_CNT;
    for(int i = monitor_write_cursor; i < monitor_write_cursor + COL_CNT; ++i)
        _setc(' ', COLOR_WHITE, i);
    _update_cursor();
    *p_vga_info = vga_info;
}

void clear_screen()
{
    int i = vga_info.extra_line_cnt * COL_CNT;
    int end = i + TOTAL_CHAR;
    for(; i < end; ++i)
        _setc(' ', COLOR_WHITE, i);
}

static void _update_cursor()
{
    int r = monitor_write_cursor / COL_CNT;
    int c = monitor_write_cursor % COL_CNT;
    vga_info.cursor_y = CHAR_HEIGHT * r + 1;
    if(c != COL_CNT - 1)
        vga_info.cursor_x = CHAR_WIDTH * c + 1;
    else
        vga_info.cursor_x = 1;
}


inline void lock_output_front() {output_front_cursor = monitor_write_cursor;}
inline static void _setc(const char c, const uint8_t color, const uint32_t addr){ch_mem[addr]=c; color_mem[addr]=color;}
inline static void _erasec(const uint32_t addr){ch_mem[addr]=0; color_mem[addr]=0;}
inline void error(const char* msg) {print("Error: ", COLOR_RED); print(msg, COLOR_WHITE);}

static inline bool _next_key_arrived()
{
    if(kb_info.c)
    {
        if(kb_info.c == input_controller.pre_c)
            return sys_time - input_controller.pre_time > KEY_REPEAT_INTERVAL;
        else
            return true;
    }
    else
        return false;
}