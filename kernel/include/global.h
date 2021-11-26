#ifndef _GLOBAL_H
#define _GLOBAL_H

#define INSTR_OFFSET        0x00000000 
#define DATA_OFFSET         0x00100000
#define VGA_INFO_OFFSET     0x00200000
#define VGA_CHAR_OFFSET     0x00300000
#define VGA_COLOR_OFFSET    0x00400000
#define KB_INFO_OFFSET      0x00500000
#define IDT_OFFSET          0x00600000

#define VGA_WIDTH 640
#define VGA_HEIGHT 480

#define ROW_CNT 30
#define COL_CNT 64
#define TOTAL_CHAR (ROW_CNT * COL_CNT)
#define VGA_BUFFER_ROW 64

#define CHAR_WIDTH 9
#define CHAR_HEIGHT 16

#define KB_FIFO_SIZE 32

typedef unsigned char uint8_t;      /* Unsigned 8 bit quantity  */
typedef signed char int8_t;         /* Signed 8 bit quantity    */
typedef unsigned short uint16_t;    /* Unsigned 16 bit quantity */
typedef signed short int16_t;       /* Signed 16 bit quantity   */
typedef unsigned int uint32_t;      /* Unsigned 32 bit quantity */
typedef signed int int32_t;         /* Signed 32 bit quantity   */

#define bool uint8_t
#define true 1
#define false 0
#define NULL 0

enum{COLOR_RED, COLOR_GREEN, COLOR_BLUE, COLOR_BLACK, COLOR_WHITE};

extern uint32_t * const idt_mem;
extern uint8_t * const ch_mem;
extern uint8_t * const color_mem;
extern volatile uint32_t sys_time;

#endif