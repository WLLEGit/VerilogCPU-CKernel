#include "io_mm.h"

KBInfo * const p_kb_info = (KBInfo*)KB_INFO_OFFSET;
KBInfo volatile kb_info;

VGAInfo* const p_vga_info = (VGAInfo*)VGA_INFO_OFFSET;
VGAInfo vga_info;


void init_io_mm()
{
    vga_info.cursor_x = 1;
    vga_info.cursor_y = 1;
    vga_info.extra_line_cnt = 0;
    *p_vga_info = vga_info;
}