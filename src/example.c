#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>

extern void _exit_(void) __attribute__((noreturn));
extern void _reset_(void) __attribute__((noreturn));

#define UART_BASE ((volatile uint8_t*)0x10000000)
#define RAM_BASE ((volatile uint32_t*)0x80000000)

#define TEST_RAM_BASE (RAM_BASE + 0x1000)

static inline uint8_t hasChar();
static inline char getChar();
static inline char wait4Char();
static inline uint32_t wait4N(uint8_t n);
static inline void printC(char c);
static void printS(const char* s);
static void printH(uint32_t i);
static void delay(uint32_t i);
static uint32_t hex2int(const char* s);
static void sendback(size_t i);
static void prompt(const char* s);
static void test_ram(size_t size);
static void rand_memset(volatile void *ptr, size_t num);
static void test_rand_memset(volatile void *ptr, size_t num);


void entry(void) {
	prompt("Test ram?..\r");

	test_ram(0x100000);

	printS("Done!\r\n");
	_reset_();
}

static void rand_memset(volatile void *ptr, size_t num) {
	for(size_t i = 0; i < num; i++) {
		if(i % (num/64) == 0)
			printS(".");
		((uint8_t*)ptr)[i] = (uint8_t)(rand() & 0xff);
	}

}

static void test_rand_memset(volatile void *ptr, size_t num) {
	for(size_t i = 0; i < num; i++) {
		if(i % (num/64) == 0)
			printS(".");
		uint8_t data = ((uint8_t*)ptr)[i];
		uint8_t rand_val = (uint8_t)(rand() & 0xff);
		if (data != rand_val) {
			printS("Error: @");
			printH(i);
			printS(" ");
			printH(data);
			printS(" != ");
			printH(rand_val);
			printS("\n\r");
		}
	}
}

static void test_ram(size_t size) {
	srand(0);
	rand_memset(TEST_RAM_BASE, size);
	printS("Done writing!\r\n");
	srand(0);
	test_rand_memset(TEST_RAM_BASE, size);
}

static void prompt(const char* s){
	while(!hasChar()){
		printS(s);
		delay(0x8000);
	}
	getChar();
}

static inline uint32_t wait4N(uint8_t n) {
	uint32_t k = 0;
	for(uint8_t j = 0; j < n; j++) {
		char c = wait4Char();
		k |= c << (j * 8);
	}
	return k;
}

static void sendback(size_t i) {
	uint32_t k = RAM_BASE[i];
	printC(k & 0xff);
	printC((k >> 8) & 0xff);
	printC((k >> 16) & 0xff);
	printC((k >> 24) & 0xff);
}

static void delay(uint32_t i) {
	while(i--)
		__asm__ volatile("nop");
}

static inline void printC(char c){
	// Wait for UART to be ready TEMT in LSR register
	while(!(UART_BASE[5] & (1 << 6)));
	UART_BASE[0] = c;
}

static inline uint8_t hasChar() {
	return (UART_BASE[5] & 1) == 1;
}

static inline char getChar() {
	return UART_BASE[0];
}

static inline char wait4Char() {
	while(!hasChar());
	return getChar();
}

static void printS(const char* s) {
	while(*s)
		printC(*s++);
}

static void printH(uint32_t i) {
	static const char hex[16]  = "0123456789abcdef";
	static char s[9];
	int j = 0;
	do {
		s[j++] = hex[i & 0xf];
		i >>= 4;
	} while(i);
	while(j)
		printC(s[--j]);
}

static uint32_t hex2int(const char* s) {
	uint32_t i = 0;
	while(*s) {
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

static u_long next = 1;

int rand() {
	return ((next = next * 1103515245 + 12345) % ((u_long)RAND_MAX + 1));
}

void srand(u_int seed) {
	next = seed;
}
