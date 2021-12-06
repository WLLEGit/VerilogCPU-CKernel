#ifndef _SYSCALL_H
#define _SYSCALL_H

#include "global.h"
#include "io_mm.h"


extern uint32_t monitor_write_cursor;
extern uint32_t output_front_cursor; //forbid backspace when monitor_write_cursor <= output_front_cursor

void wait_ms(uint32_t ms);
/* std IO */
void lock_output_front();
void putc(const char c, const uint8_t color);
void print(const char* str, const uint8_t color);
void printint(const int n, const uint8_t color);

char getc();
void getline(char* buf);
bool is_ctrl_c();
/* std IO end */

void scroll_screen();
void clear_screen();

// /* video support */
// void clear_screen_buffer();
// void putc_buffer(char c, uint8_t color);
// void switch_screen();
// /* video support end */

void error(const char* msg);
static bool _next_key_arrived();
static void _setc(const char c, const uint8_t color, const uint32_t addr);
static void _erasec(const uint32_t addr);
static void _update_cursor();

/* HEX and LEDR support */
uint32_t num2hexout(uint32_t num);
void set_hex(uint32_t hex, uint32_t id);
void set_ledr(uint32_t id, bool is_on);
void set_ledr_all(uint32_t ledr);

#endif