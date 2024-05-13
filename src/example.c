#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>

#include "simple_lib.h"

void entry(void) {
	printS("Hello World!\r\n");
	_exit_();
}
