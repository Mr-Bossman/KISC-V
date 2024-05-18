#include <ctype.h>
#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>

#include "simple_lib.h"

void delay(uint32_t i) {
	while(i--)
		__asm__ volatile("nop");
}

void printC(char c){
	// Wait for UART to be ready TEMT in LSR register
	while(!(UART_BASE[5] & (1 << 6)));
	UART_BASE[0] = c;
}

uint8_t hasChar() {
	return (UART_BASE[5] & 1) == 1;
}

char getChar() {
	return UART_BASE[0];
}

char wait4Char() {
	while(!hasChar());
	return getChar();
}

void printS(const char* s) {
	while(*s)
		printC(*s++);
}

void flush_input(void) {
	while(hasChar())
		getChar();
}

void prompt(const char* s){
	while(!hasChar()){
		printS(s);
		delay(0x8000);
	}
	getChar();
}

uint32_t wait4N(uint8_t n) {
	uint32_t k = 0;
	for(uint8_t j = 0; j < n; j++) {
		char c = wait4Char();
		k |= c << (j * 8);
	}
	return k;
}

void printH(uint8_t i) {
	const char hex[16]  = "0123456789abcdef";
	printC(hex[i >> 4]);
	printC(hex[i & 0xf]);
}

void printH_32(uint32_t i) {
	printH(i >> 24);
	printH(i >> 16);
	printH(i >> 8);
	printH(i);
}

uint32_t hex2int(const char* s) {
	uint32_t i = 0;
	while(isxdigit(*s)) {
		char c = *s-'0';
		if(c > 9)
			c -= 7;
		if(c > 15)
			c -= 32;
		i = (i << 4) |  c;
		s++;
	}
	return i;
}

int isxdigit(int c) {
	if(c >= '0' && c <= '9')
		return 1;
	if(c >= 'a' && c <= 'f')
		return 1;
	if(c >= 'A' && c <= 'F')
		return 1;
	return 0;
}

int isdigit(int c) {
	if(c >= '0' && c <= '9')
		return 1;
	return 0;
}

int isupper(int c) {
	if(c >= 'A' && c <= 'Z')
		return 1;
	return 0;
}

int islower(int c) {
	if(c >= 'a' && c <= 'z')
		return 1;
	return 0;
}

int isalpha(int c) {
	return islower(c) || isupper(c);
}

int isalnum(int c) {
	return isalpha(c) || isdigit(c);
}
