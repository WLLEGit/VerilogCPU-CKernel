#ifndef _SYSCALL_H
#define _SYSCALL_H

#include "global.h"
#include "io_mm.h"


extern uint32_t monitor_write_cursor;
extern uint32_t output_front_cursor; //can't backspace when monitor_write_cursor <= output_front_cursor

/* std IO */
inline void lock_output_front();
inline void _setc(char c, uint8_t color, uint32_t addr);
inline void _erasec(uint32_t addr);
void _update_cursor();
void putc(char c, uint8_t color);
void print(char* str, uint8_t color);

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

inline void error(char* msg);


#endif