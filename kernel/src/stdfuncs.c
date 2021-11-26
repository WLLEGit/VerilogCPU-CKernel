#include "stdfuncs.h"


char * strtok ( char * str, const char * delimiters ){
	if( delimiters == NULL) return NULL;
	static char * s_mem = NULL;
	if( str == NULL && s_mem == NULL) return NULL;
	
	char *s;
	if(str != NULL) s=str;
	else s=s_mem;
	char const * delim;
	

	int stat=1;
	while(stat){
		delim = delimiters;
		while( *delim && *s != *delim){
			delim++;
		}
		if(*delim){
			s++;
		}
		else stat=0; 
	}
	s_mem = s;
	
	while( *s){
		delim = delimiters;
		while( *delim && *s != *delim){
			delim++;
		}

		if(*delim){
			*s = '\0';
			char *t = s_mem;
			s_mem = s+1;
			return t;
		}
		s++;
	}

	char *t = s_mem;
	s_mem = NULL; 
	return t;
}

void itoa(int n,char str[])
{
    int i,j,len,sign;

    if((sign=n)<0)    
        n=-n;         
    i=0;
    do{
        str[i++]=n%10+'0';    
    }while((n/=10)>0);      

    if(sign<0)
        str[i++]='-';
    str[i]='\0';
    len = i;//
    for(j=len-1,i=0;j>i;j--,i++)        
    {
        str[j] ^= str[i];
        str[i] ^= str[j];
        str[j] ^= str[i];
    }
}

int atoi(char s[])
{
    int i=0,n,sign;

    sign=(s[i]=='-')?1:1;
    if(s[i]=='+'||s[i]=='-')   
        i++;
    for(n=0;isdigit(s[i]);i++)
        n=10*n+(s[i]-'0');    
    return sign*n;
}