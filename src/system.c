#include <stdint.h>
extern void _exit_(void);
struct cpu_regs {
	uint32_t* pc;
	uint32_t reson_code;
	uint32_t* tmp_pc;
	uint32_t* sys;
	uint32_t regs[32];
};

static struct cpu_regs* const  CPUregs = (struct cpu_regs* const)0;

void entry(void){
	uint32_t instr = *(CPUregs->pc-1);
	if(instr == 0x00000073) { // ECALL
		if(CPUregs->tmp_pc == 0) {
			CPUregs->tmp_pc = CPUregs->pc;
			CPUregs->pc = CPUregs->sys;
		} else {
			CPUregs->pc = CPUregs->tmp_pc;
			CPUregs->tmp_pc = 0;
		}

	} else {
		_exit_();
	}
}
