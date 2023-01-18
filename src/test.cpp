#include "verilated.h"
#define CONCAT(A, B) A##B
#define CAT(A, B) CONCAT(A, B)
#define SUFF(x) CONCAT(x,_)
#define PREFIX(x) CAT(SUFF(VPREFIX),x)

#include <iostream>

int main(int argc, char **argv, char **env) {
	Verilated::commandArgs(argc, argv);
	VPREFIX* sim = new VPREFIX;
	size_t totram = sizeof(sim->prog_counter__DOT__ram__DOT__mem)/sizeof(sim->prog_counter__DOT__ram__DOT__mem[0]);
	uint32_t tmp = 15*4;
	sim->prog_counter__DOT__ram__DOT__mem[0] = 3 | ((10*4)<< 20) | (0<<15) | (1 << 7) | (2<<12);
	sim->prog_counter__DOT__ram__DOT__mem[1] = 3 | ((11*4)<< 20) | (0<<15) | (2 << 7) | (2<<12);
	sim->prog_counter__DOT__ram__DOT__mem[2] = 35 |(2 << 20)| (0<<15) | ((tmp&0x1f) << 7) | (2<<12) | ((tmp>>5) << 25);
	sim->prog_counter__DOT__ram__DOT__mem[3] = 35 |(1 << 20)| (0<<15) | ((tmp&0x1f) << 7) | (0<<12) | ((tmp>>5) << 25);
	sim->prog_counter__DOT__ram__DOT__mem[4] = 0b0010111 | (4<< 7) | (0x2644<<16);
	sim->prog_counter__DOT__ram__DOT__mem[5] = 0b1101111 | (5<< 7);
	sim->prog_counter__DOT__ram__DOT__mem[10] = 0x44444444;
	sim->prog_counter__DOT__ram__DOT__mem[11] = 0x11111111;


	sim->rts = 1;
	sim->eval();
	sim->rts = 0;
	for(int i = 0; i < 20;i++){
		printf("addr: 0x%0x, data: %0x,%0x\n",sim->prc,sim->odat,sim->prog_counter__DOT__addr);
		sim->clk = 0;
		sim->eval();
		sim->clk = 1;
		sim->eval();
	}

	for(int i = 0; i < 20;i++){
		printf("ram %d: 0x%0x\n",i,sim->prog_counter__DOT__ram__DOT__mem[i]);
	}
	for(int i = 0; i < 32;i++){
		printf("reg %d: 0x%0x\n",i,sim->prog_counter__DOT__regs[i]);
	}

	sim->final();
	delete sim;
	return 0;
}