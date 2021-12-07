#include "stdfuncs.h"
#ifdef DEBUG
#include "syscall.h"
#endif

inline bool isdigit(const char c){return c >= '0' && c <= '9';}

int strcmp(const char* src, const char* dst)
{
    int ret = 0;
    while( !(ret = *(unsigned char*)src - *(unsigned char*)dst) && *dst)
    {
        src ++;
        dst ++;
    }
    if( ret < 0) ret = -1;
    else if(ret > 0) ret = 1;
    return ret;
}

int strlen(const char* str)
{
	int len = 0;
	while(*str++) len++;
	return len;
}

inline int get_pos(uint8_t x) {
	return (x & 0x1f);
}
char* strtok(char* src, const char* delimiters) {
	char* sbegin, * send;
	static char* ssave = NULL;
	sbegin = src ? src : ssave;           
	uint8_t cset[32] = { 0 };                 
	while ((*delimiters) != '\0') {       
		uint8_t t = (uint8_t)*delimiters++;
		cset[get_pos(t)] |= 1 << (t / 32);
	}

	while (*sbegin != '\0' && (cset[get_pos(*sbegin)] & (1 << (((uint8_t)*sbegin) / 32)))) {
		++sbegin;
	}
	if (*sbegin == '\0') {
		ssave = NULL;
		return NULL;
	}
	int idx = 0;

	while (sbegin[idx] != '\0' && !(cset[get_pos(sbegin[idx])] & (1 << ((uint8_t)sbegin[idx] / 32)))) {
		++idx;
	}
	send = sbegin + idx;
	if (*send != '\0')
		*send++ = '\0';                   
	ssave = send;                         
	return sbegin;
}

void itoa(int n,char str[])
{
    int i,j,len,sign;

    if((sign=n)<0)    
        n=-n;         
    i=0;
	uint32_t d=n, m;
    do{
		n = d;
		_udiv_mod(n, 10, &d, &m);
        str[i++]=(uint8_t)(m)+'0';    
    }while(d>0);      

    if(sign<0)
        str[i++]='-';
    str[i]='\0';
    len = i;
    for(j=len-1,i=0;j>i;j--,i++)        
    {
        str[j] ^= str[i];
        str[i] ^= str[j];
        str[j] ^= str[i];
    }
}

int atoi(char s[])
{
    uint32_t i=0,n;
	int sign;

    sign=(s[i]=='-')?-1:1;
    if(s[i]=='+'||s[i]=='-')   
        i++;
    for(n=0;isdigit(s[i]);i++)
        n=__mulsi3(n, 10)+(s[i]-'0');    
    return __mulsi3(sign, n);
}

uint32_t __mulsi3(uint32_t a, uint32_t b)
{
	uint32_t result = 0;
	while(b != 0)
	{
		if(b & 1)
			result += a;
		a <<= 1;
		b >>= 1;
	}
	return result;
}

void _udiv_mod(uint32_t a, uint32_t b, uint32_t *res, uint32_t *remain)
{
	unsigned int bit = 1;
	unsigned int result = 0;

	while(b < a && bit && !(b & (1UL << 31)))
	{
		b <<= 1;
		bit <<= 1;
	}
	while(bit)
	{
		if(a >= b)
		{
			a -= b;
			result |= bit;
		}
		b >>= 1;
		bit >>= 1;
	}
	if(res)
		*res = result;
	if(remain)
		*remain = a;
}

uint32_t __udivsi3(uint32_t a, uint32_t b)
{
	uint32_t result;
	_udiv_mod(a, b, &result, NULL);
	return result;
}