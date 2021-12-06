#ifndef _STDFUNCS_H
#define _STDFUNCS_H

#include "global.h"

bool isdigit(const char c);
int strcmp(const char* src, const char* dst);
int strlen(const char* str);
void itoa(int, char*);
int atoi(char*);

uint32_t __mulsi3(uint32_t, uint32_t);
void _udiv_mod(uint32_t, uint32_t, uint32_t*, uint32_t*);
uint32_t __udivsi3(uint32_t, uint32_t);


#endif