#include "verilated.h"
#define CONCAT(A, B) A##B
#define CAT(A, B) CONCAT(A, B)
#define SUFF(x) CONCAT(x,_)
#define PREFIX(x) CAT(SUFF(VPREFIX),x)

#include <iostream>
#include <signal.h>
#include <unistd.h>
#include <sys/ioctl.h>

static uint64_t instruction_count = 0;
static uint64_t clock_count = 0;
static VPREFIX* sim = NULL;

static void dump(){
	FILE *fp = fopen("dump.bin","w+");
	printf("Dumping memory to dump.bin of size 0x%04x\n",sizeof(sim->rootp->soc_top__DOT__ram__DOT__mem));
	fwrite(&sim->rootp->soc_top__DOT__ram__DOT__mem[0],1,sizeof(sim->rootp->soc_top__DOT__ram__DOT__mem),fp);
	fclose(fp);
}
static void exit_now(int signo){
	puts("\n\n");
	for(int i = 0; i < 32;i++){
		printf("regs %d: 0x%0x\n",i,sim->rootp->soc_top__DOT__riscv_cpu__DOT__regfile[i]);
	}
	for(int i = 0; i < 32;i++){
		printf("mem 0x%02x: 0x%08lx\n",i*4,sim->rootp->soc_top__DOT__ram__DOT__mem[i]);
	}
	for(int i = 0; i < 10;i++){
		printf("sys_mem 0x%02x: 0x%08lx\n",i*4,sim->rootp->soc_top__DOT__system__DOT__mem[i]);
	}
	//dump();
	sim->final();
	delete sim;
	printf("IPC: %lf instructions/clock\nCPI: %lf clock/instructions, count %d\n",(double)instruction_count/clock_count,(double)clock_count/instruction_count, instruction_count);
	exit(signo);
}


char get_console() {
	int byteswaiting, rread;
	char rxchar = 0;
	/* Are there pending bytes */
	ioctl(0, FIONREAD, &byteswaiting);
	if(byteswaiting){
		rread = read(0, &rxchar, 1);
		return (rread > 0)?rxchar:-1;
	}
	return 0;
}

int main(int argc, char **argv, char **env) {
	signal(SIGINT, exit_now);
	Verilated::commandArgs(argc, argv);
	sim = new VPREFIX;
	sim->APB_PRESETn = 1;
	sim->eval();
	sim->APB_PRESETn = 0;
	sim->eval();
	sim->APB_PRESETn = 1;
	uint32_t oldpc = sim->oldpc;
	char char_in = 0;
	bool read = false;
	while(!sim->halted){
		//printf("microop_pc 0x%0x pc: 0x%0x\n",sim->odat,sim->oldpc);
		//usleep(50000);
		sim->char_in = char_in;
		sim->clk = 0;
		sim->eval();
		sim->char_in = char_in;
		sim->clk = 1;
		sim->eval();
		if(sim->read)
			read = true;
		if(sim->oldpc != oldpc){
			if(read || char_in == 0){
				char_in = get_console();
				read = false;
			}
			//printf("pc: 0x%0x\n",sim->oldpc);
			oldpc = sim->oldpc;
			instruction_count++;
			//printf("IPC: %lf instructions/clock,\tCPI: %lf clock/instructions\n",(double)instruction_count/clock_count,(double)clock_count/instruction_count);
		}
		clock_count++;
	}
	printf("PC 0x%0x\n",sim->oldpc);
	//dump();
	exit_now(0);
	return 0;
}
