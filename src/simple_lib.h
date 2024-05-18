#ifndef _SIMPLE_LIB_H
#define _SIMPLE_LIB_H

#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>

extern void _exit_(void) __attribute__((noreturn));
extern void _reset_(void) __attribute__((noreturn));

#define UART_BASE ((volatile uint8_t*)0x10000000)
#define RAM_BASE ((volatile uint8_t*)0x80000000)
#define RAM_BASE_U32 ((volatile uint32_t*)RAM_BASE)

void delay(uint32_t i);
void printC(char c);
uint8_t hasChar();
char getChar();
char wait4Char();
void printS(const char* s);

#ifdef isxdigit
#undef isxdigit
#endif
#ifdef isdigit
#undef isdigit
#endif
#ifdef isupper
#undef isupper
#endif
#ifdef islower
#undef islower
#endif
#ifdef isalpha
#undef isalpha
#endif
#ifdef isalnum
#undef isalnum
#endif

int isxdigit(int c);
int isdigit(int c);
int isupper(int c);
int islower(int c);
int isalpha(int c);
int isalnum(int c);


void prompt(const char* s);
uint32_t wait4N(uint8_t n);
void printH(uint8_t i);
void printH_32(uint32_t i);
uint32_t hex2int(const char* s);
void flush_input(void);

#endif /* _SIMPLE_LIB_H */
