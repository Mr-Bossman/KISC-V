#include <stdint.h>
#include <stddef.h>

#define UART_BASE ((volatile uint8_t*)0x10000000)
#define RAM_BASE ((volatile uint32_t*)0x80000000)
#define CTRL_BASE ((volatile uint32_t*)0x80800004)

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
static void bootprompt(void);

void boot(void) {
	printS("Enter Size in 32bit hex or press b to bofort\n\r");
	static char s[9];
	uint32_t size;
	uint32_t i = 0;
	while(1) {
		if(hasChar()) {
			s[i++] = getChar();
			printC(s[i-1]);
			if(s[i-1] == 'b'){
				bootprompt();
				return;
			}
		}
		if(i == 8)
			break;
	}
	wait4Char();
	size = hex2int(s);
	printS("\n\rSize: ");
	printH(size);
	printS("\n\r");
	// clear uart buffer
	while(hasChar())
		getChar();
	printS("Start\n\r\1");
	CTRL_BASE[0] = 0x66;
	CTRL_BASE[0] = 0x99;
	uint32_t sum = 0;
	// cache data in 64word blocks
	static uint32_t cache[64];
	if(size != 0)
	for(i = 0; i <= size/(64*4); i++) {
		for(uint32_t j = 0; j < 64; j++){
			uint32_t k = wait4N(4);
			cache[j] = k;
			sum += k;
		}
		// 64 byte offset
		uint32_t o = i*64;
		for(uint32_t j = 0; j < 64; j++) {
			RAM_BASE[o + j] = cache[j];
		}
		printC(sum&0xff);
		if(wait4Char() != (sum&0xff))
			i -= 1;
		sum = 0;
	}
	i *= 64;
	sum = 0;
	for(; i < size/4; i++) {
		uint32_t j = wait4N(4);
		RAM_BASE[i] = j;
		sum += j;
	}

	uint32_t mod_size = size % 4;
	if(mod_size) {
		uint32_t j = wait4N(mod_size);
		RAM_BASE[i] = j;
	}
	printC(sum&0xff);
	printS("Done\n\r");
	while(1);
}

static void bootprompt(void){
	while(!hasChar()){
		printS("\rWaiting for confirmation to start...");
		delay(10000);
	}
	getChar();
	printS("\n\rStarting\n\r");
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