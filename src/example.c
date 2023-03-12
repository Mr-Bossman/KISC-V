#include <stdint.h>
#include <stddef.h>

#define UART_BASE ((volatile uint8_t*)0x10000000)
#define RAM_BASE ((volatile uint32_t*)0x80000000)
#define CTRL_BASE ((volatile uint32_t*)0x80000100)

static inline uint8_t hasChar();
static inline char getChar();
static inline char wait4Char();
static inline void printC(char c);
static void printS(const char* s);
static void printH(uint32_t i);
static void delay(uint32_t i);
static uint32_t hex2int(const char* s);

void entry(void) {
	printS("Enter Size in 32bit hex\n\r");
	/* FCR set RX FIFO bufer to 4*/
	CTRL_BASE[0] = 0x66;
	CTRL_BASE[0] = 0x99;
	static char s[9];
	uint32_t size;
	uint32_t i = 0;
	while(1) {
		if(hasChar()) {
			s[i++] = getChar();
			printC(s[i-1]);
		}
		if(i == 8)
			break;
	}
	printS("Size: ");
	printS(s);
	printS("\n\r");
	size = hex2int(s);
	printS("Size: ");
	printH(size);
	printS("\n\r");
	for(i = 0; i < size/4; i++) {
		uint32_t k = 0;
		for(uint8_t j = 0; j < 4; j++) {
			char c = wait4Char();
			printH(c);
			printS(" ");
			k |= c << (j * 8);
		}
		RAM_BASE[i] = k;
	}
	uint32_t mod_size = size % 4;
	if(mod_size) {
		uint32_t k = 0;
		for(uint8_t j = 0; j < mod_size; j++) {
			char c = wait4Char();
			printH(c);
			printS(" ");
			k |= c << (j * 8);
		}
		RAM_BASE[i] = k;
	}
	printS("Done\n\r");
	printS("RAM: ");
	for(i = 0; i < size; i++) {
		printH(((uint8_t*)RAM_BASE)[i]);
		printS(" ");
	}
	goto *RAM_BASE;
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