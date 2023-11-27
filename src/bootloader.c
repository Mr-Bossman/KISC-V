#include <stdint.h>
#include <stddef.h>

#include "simple_lib.h"

static void bootprompt(void);

void _boot_(void) {
	printS("Enter Size in 32bit hex or press enter to boot\n\r");
	static char s[9] = {0};
	uint32_t size;
	size_t i = 0;
	while(i < 8) {
		while(!hasChar());

		s[i] = getChar();
		if(s[0] == '\r')
			return;
		else if(s[i] == '\r')
			break;

		printC(s[i]);

		if(!isxdigit(s[i])){
			printS("\n\rInvalid character\n\r");
			i = 0;
		} else
			i++;
	}
	size = hex2int(s);
	printS("\n\rSize: ");
	printH_32(size);
	printS("\n\r");
	flush_input();
	printS("Start\n\r");
	uint32_t sum = 0;
	sum = 0;
	for(i = 0; i < size/4; i++) {
		uint32_t j = wait4N(4);
		RAM_BASE_U32[i] = j;
		sum += j;
	}

	uint32_t mod_size = size % 4;
	if(mod_size) {
		uint32_t j = wait4N(mod_size);
		RAM_BASE_U32[i] = j;
	}

	printC(sum&0xff);
	printS("Done\n\r");
	bootprompt();
/*
	for(i = 0; i < size/4; i++){
		if(i%16 == 0)
			printS("\n\r");
		printH_32(RAM_BASE_U32[i]);
		printC(',');
	}
	printS("\n\r");
*/
}

static void bootprompt(void){
	while(!hasChar()){
		printS("\rWaiting for confirmation to start...");
		delay(10000);
	}
	getChar();
	printS("\n\rStarting\n\r");
}
