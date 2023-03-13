#include <stdint.h>
#include <stddef.h>

#define UART_BASE ((volatile uint8_t*)0x10000000)
#define RAM_BASE ((volatile uint32_t*)0x80000000)
#define BRAM_BASE ((volatile uint32_t*)0x0)

static inline uint8_t hasChar();
static inline char getChar();
static inline char wait4Char();
static inline void printC(char c);
static void printS(const char* s);
static void printH(uint32_t i);
static void delay(uint32_t i);
static uint32_t hex2int(const char* s);
extern uint32_t _sstack;

#ifndef BINARY_SIZE
#error "BINARY_SIZE not defined"
#endif
#ifndef BINARY_OFFSET
#error "BINARY_OFFSET not defined"
#endif

void entry(void) {
	// wait to confirm
	printS("Press any key to start\n\r");
	wait4Char();
	printS("Copying binary to ram\n\r");
	const uint8_t* start_data = (uint8_t*)RAM_BASE + BINARY_OFFSET;
	for(uint32_t i = 0; i < BINARY_SIZE; i++)
		BRAM_BASE[i] = ((uint32_t*)start_data)[i];
	printS("Done press any key to boot\n\r");
	wait4Char();
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
	} while(j < 8);
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