#ifndef _SYSCALL_H
#define _SYSCALL_H

#include "global.h"
#include "io_mm.h"


extern uint32_t monitor_write_cursor;
extern uint32_t output_front_cursor; //can't backspace when monitor_write_cursor <= output_front_cursor

/* std IO */
void lock_output_front();
void _setc(const char c, const uint8_t color, const uint32_t addr);
void _erasec(const uint32_t addr);
void _update_cursor();
void putc(const char c, const uint8_t color);
void print(const char* str, const uint8_t color);

char getc();
void getline(char* buf);
/* std IO end */

void scroll_screen();
void clear_screen();

// /* video support */
// void clear_screen_buffer();
// void putc_buffer(char c, uint8_t color);
// void switch_screen();
// /* video support end */

void error(const char* msg);


#endif