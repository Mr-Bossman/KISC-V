#include <stdint.h>
#define DEBUG_UART

extern void _exit_(void) __attribute__((noreturn));

struct cpu_regs {
	uint32_t* pc;
	uint32_t reson_code;
	uint32_t* sys;
	uint32_t regs[32];
};

static struct cpu_regs* const CPUregs = (struct cpu_regs* const)4;

enum {
	csr_mstatus,
	csr_cyclel,
	csr_mscratch,
	csr_mtvec,
	csr_mie,
	csr_mip,
	csr_mepc,
	csr_mtval,
	csr_mcause,
	csr_mvendorid,
	csr_misa,
	csr_pc,
	csr_extraflags,
	csr_cycleh,
	csr_timerl,
	csr_timerh,
	csr_timermatchl,
	csr_timermatchh,
};

static const uint32_t csrnums[18] = {0x300,0xC00,0x340,0x305,0x304,0x344,0x341,0x343,0x342,0xf11,0x301};
volatile uint32_t CSRs[sizeof(csrnums)]  = {0};

static int xRET(uint32_t instr);
static int FENCE(uint32_t instr);
static int CSRx(uint32_t instr);
static int ECALL(uint32_t instr);
static int AMOx(uint32_t instr);
static int bad_instruction(uint32_t instr);

static int csr_num(uint32_t csr);
static void csr_wr(uint32_t csr, uint32_t val);
static uint32_t csr_rd(uint32_t csr);
static inline uint32_t get_cause(void);

static int do_timer_int(void);
static int do_apb_bus_error(void);
static int do_unknown_int(void);

static inline void printC(uint8_t c);
static void printS(const char* s);
static void printI(int i);
static void printH(uint32_t i);

void entry(void) {
	uint32_t instr = *(CPUregs->pc-1);
	uint32_t opcode = instr & 0x0000007f;
	int ret = 0;
	int cause;
	(void)ret; //TODO: use ret for error checking
	/* Check for unimplemented instructions FENCE/FENCE.I ECALL/EBREAK CSRx and xMRET*/
	if((cause = get_cause())) {
		for(int i = 0;cause;i++) {
			if(cause&1) {
				switch(i) {
					case 0: // APB bus error
						ret = do_apb_bus_error();
						break;
					case 1: // Timer interrupt
						ret = do_timer_int();
						break;
					default:
						ret = do_unknown_int();
						break;
				}
			}
			cause>>=1;
		}
		return;
	}
	switch(opcode) {
		case 0x0F: // FENCE/FENCE.I
			ret = FENCE(instr);
			//printS("FENCE\n\r");
			break;
		case 0x73: { // ECALL/EBREAK // CSRRW/CSRRS/CSRRC/CSRRWI/CSRRSI/CSRRCI
			uint32_t checkA = (instr&(~0x0010007F));
			uint32_t checkB = (instr&(~0xFFF0007F));
			uint32_t checkC = (instr>>12)&3;
			if(checkA == 0x0) { // ECALL/EBREAK
				ret = ECALL(instr);
				//printS("ECALL\n\r");
				break;
			} else if(checkB == 0x0) { // xRET
				ret = xRET(instr);
				//printS("xRET\n\r");
				break;
			} else if (checkC != 4) {  // CSRRW/CSRRS/CSRRC/CSRRWI/CSRRSI/CSRRCI
				ret = CSRx(instr);
				//printS("CSRx\n\r");
				break;
			}
			ret = -1;
			//printS("Unimplemented\n\r");
			break;
		}
		case 0x2F: // AMO
			ret = AMOx(instr);
			//printS("AMOx\n\r");
			break;
		default:
			ret = bad_instruction(instr);
			//printS("Bad_instruction\n\r");
			break;
	}
	{
		uint32_t MIE = (CSRs[csr_mstatus]&0x8) != 0;
		uint32_t MTIE = (CSRs[csr_mie] & (1 << 7)) != 0;
		if(MIE && MTIE){
			static volatile uint32_t* const timer = (volatile uint32_t* const)0x11110000;
			timer[0] = 0x1;
		}
	}
}

static int FENCE(uint32_t instr) {
	// Fence is not implemented do nothing
	uint32_t checkA = (instr&(~0x0000107F));
	uint32_t checkB = (instr&(~0x0FF0007F));
	if(checkA == 0x0 || checkB == 0x0)
		return 0;
	else
		return -1;
}

static int ECALL(uint32_t instr) {
	if(instr == 0x00000073) {
		int mstatus = CSRs[csr_mstatus] ;
		CSRs[csr_mepc] = ((uint32_t)CPUregs->pc)-4;
		CSRs[csr_mcause] = (mstatus & (3<<11))?11:8; // ECALL?
		CSRs[csr_mtval] = 0x0; // ECALL?
		CPUregs->pc = (uint32_t*)CSRs[csr_mtvec];
		mstatus = ((mstatus & 0x8) << 4) | (mstatus & ~0x8); // set move mie to mpie
		CSRs[csr_mstatus] = mstatus;
	}
	return 0;
}

static int bad_instruction(uint32_t instr) {
	int mstatus = CSRs[csr_mstatus] ;
	CSRs[csr_mepc] = ((uint32_t)CPUregs->pc)-4;
	CSRs[csr_mcause] = 2; // Bad instruction
	CSRs[csr_mtval] = ((uint32_t)CPUregs->pc)-4; // ECALL?
	CPUregs->pc = (uint32_t*)CSRs[csr_mtvec];
	mstatus = ((mstatus & 0x8) << 4) | (mstatus & ~( 0x8 | (3 <<11))); // set move mie to mpie
	CSRs[csr_mstatus] = mstatus;
	return 0;
}

static int csr_num(uint32_t csr) {
	int csrno = -1;
	for (int i = 0; i < 18; i++)
		if (csr == csrnums[i]) {
			csrno = i;
			break;
		}
	return csrno;
}

static void csr_wr(uint32_t csr, uint32_t val) {
	int csr_no = csr_num(csr);
	if(csr_no == -1)
		return;
	CSRs[csr_no] = val;
}

static uint32_t csr_rd(uint32_t csr) {
	int csr_no = csr_num(csr);
	if(csr_no == -1)
		return 0;
	return CSRs[csr_no];
}

static int CSRx(uint32_t instr) {
	uint32_t csrval;
	uint32_t csr = (instr >> 20) & 0xfff;
	uint32_t microop = (instr >> 12) & 0x7;
	uint32_t rs1imm = (instr >> 15) & 0x1f;
	uint32_t* rsd = &CPUregs->regs[(instr >> 7) & 0x1f];
	if(!(microop>>2))
		rs1imm = CPUregs->regs[rs1imm];
	csrval = csr_rd(csr);
	if((instr >> 7) & 0x1f)
		*rsd = csrval;
	switch( microop & 0x3){
		case 0b01: csrval = rs1imm; break; //CSRW
		case 0b10: csrval |= rs1imm; break; //CSRRS
		case 0b11: csrval &= ~rs1imm; break; //CSRRC
	}
	csr_wr(csr,csrval);
	return 0;
}

static int xRET(uint32_t instr) {
	uint32_t imm_i = (instr >> 20) & 0xfff;
	int mstatus = CSRs[csr_mstatus] ;
	switch(imm_i) {
		case 0x002: // URET
			// move mie to mpie and set mpie
			mstatus = ((mstatus & 0x10) >> 4) | 0x10 | (mstatus & ~(3 << 11));
			break;
		case 0x302: // MRET
			// move mie to mpie and set mpie
			mstatus |= ((mstatus & 0x80) >> 4) | 0x80 | (mstatus & ~(3 << 11));
			break;
		case 0x105: // WFI
			break;
		case 0x102: // SRET
		case 0x202: // HRET
		default:
			return -1;
	}
	if(imm_i != 0x105) {
		CSRs[csr_mstatus] = mstatus;
		CPUregs->pc = (uint32_t*)CSRs[csr_mepc];
	}
	return 0;
}

static int AMOx(uint32_t instr) {
	uint32_t irmid = (instr>>27)&0x1f;
	uint32_t* rs1 = (uint32_t*)CPUregs->regs[(instr >> 15) & 0x1f];
	uint32_t rs2 = CPUregs->regs[(instr >> 20) & 0x1f];
	uint32_t* rsd = &CPUregs->regs[(instr >> 7) & 0x1f];
	if((instr >> 7) & 0x1f) // If rd is not x0
		*rsd = *rs1;
	switch( irmid ){
		case 0b00010: break; //LR.W
		case 0b00011: {
			if((instr >> 7) & 0x1f) // If rd is not x0
				*rsd = 0;
			*rs1 = rs2;
			break; //SC.W (Lie and always say it's good)
		}
		case 0b00001: *rs1 = rs2; break; //AMOSWAP.W
		case 0b00000: *rs1 += rs2; break; //AMOADD.W
		case 0b00100: *rs1 ^= rs2; break; //AMOXOR.W
		case 0b01100: *rs1 &= rs2; break; //AMOAND.W
		case 0b01000: *rs1 |= rs2; break; //AMOOR.W
		default:
			return -1;
	}
	return 0;
}

static inline uint32_t get_cause(void) {
	static volatile uint32_t* const intc = (volatile uint32_t* const)0x20000000;
	uint32_t cause = *intc;
	*intc = 0;
	return cause;
}

static int do_timer_int(void){
	static volatile uint32_t* const timer = (volatile uint32_t* const)0x11110000;
	*timer = 0x0; // Clear timer interrupt
	get_cause(); // Clear global interrupt
	int mstatus = CSRs[csr_mstatus] ;
	CSRs[csr_mepc] = ((uint32_t)CPUregs->pc) - 4;
	CSRs[csr_mcause] = 0x80000007; // Timer interrupt
	CSRs[csr_mtval] = 0x0;
	CPUregs->pc = (uint32_t*)CSRs[csr_mtvec];
	mstatus = ((mstatus & 0x8) << 4) | (mstatus & ~0x8); // set move mie to mpie
	CSRs[csr_mstatus] = mstatus;
	return 0;
}

static int do_apb_bus_error(void) {
	int mstatus = CSRs[csr_mstatus] ;
	CSRs[csr_mepc] = ((uint32_t)CPUregs->pc) - 4;
	CSRs[csr_mcause] = 5; // Load access fault
	CSRs[csr_mtval] = 0x0;
	CPUregs->pc = (uint32_t*)CSRs[csr_mtvec];
	mstatus = ((mstatus & 0x8) << 4) | (mstatus & ~0x8); // set move mie to mpie
	CSRs[csr_mstatus] = mstatus;
	return 0;
}

static int do_unknown_int(void){
	CPUregs->pc -= 1;
	printS("\n\rUnknown interrupt\n\r");
	printH((uint32_t)CPUregs->pc);
	printS("\n\r");
	return 0;
}

static inline void printC(uint8_t c){
	static volatile uint8_t* const uart = (volatile uint8_t* const)0x10000000;
#ifdef DEBUG_UART
	*uart = c;
#else
	(void)c;
	(void)uart;
#endif
}

static void printS(const char* s) {
	while(*s)
		printC(*s++);
}

static void printI(int i) {
	static char s[12];
	int j = 0;
	if(i < 0) {
		printC('-');
		i = -i;
	}
	do {
		s[j++] = '0' + (i % 10);
		i /= 10;
	} while(i);
	while(j)
		printC(s[--j]);
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
