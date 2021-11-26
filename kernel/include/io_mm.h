#ifndef _KEYBOARD_H
#define _KEYBOARD_H
#include "global.h"

typedef struct KBInfoStruct
{
    uint8_t c;
    union 
    {
        struct
        {
            uint8_t is_shift : 1;
            uint8_t is_ctrl : 1;
            uint8_t is_alt : 1;
            uint8_t is_caps : 1;
            uint8_t is_special : 1;
            uint8_t is_error : 1;
            uint8_t unused : 2;
        };
        
        uint8_t flags;
    };
} KBInfo;

extern KBInfo * const p_kb_info;
extern volatile KBInfo kb_info;

typedef struct VGAInfoStruct
{
    uint32_t extra_line_cnt;
    uint16_t cursor_x;
    uint16_t cursor_y;
} VGAInfo;

extern VGAInfo* const p_vga_info; 
extern VGAInfo vga_info;

void init_io_mm();

#endif