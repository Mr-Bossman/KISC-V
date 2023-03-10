.section .asm, "ax"
.global _start
.global _exit_

#define STORE_REGS(reg) sw x##reg, ((reg*4)+0x10)(x0)
#define LOAD_REGS(reg) lw x##reg, ((reg*4)+0x10)(x0)

.align 4
	j _init
interrupt:
	.word _start
reason_code:
	.word 0x00
reg_store:
	.fill 32, 4
_exit_:
	.word 0x00
back:
	.word 1
_start:
	STORE_REGS(1)
	STORE_REGS(2)
	STORE_REGS(3)
	STORE_REGS(4)
	STORE_REGS(5)
	STORE_REGS(6)
	STORE_REGS(7)
	STORE_REGS(8)
	STORE_REGS(9)
	STORE_REGS(10)
	STORE_REGS(11)
	STORE_REGS(12)
	STORE_REGS(13)
	STORE_REGS(14)
	STORE_REGS(15)
	STORE_REGS(16)
	STORE_REGS(17)
	STORE_REGS(18)
	STORE_REGS(19)
	STORE_REGS(20)
	STORE_REGS(21)
	STORE_REGS(22)
	STORE_REGS(23)
	STORE_REGS(24)
	STORE_REGS(25)
	STORE_REGS(26)
	STORE_REGS(27)
	STORE_REGS(28)
	STORE_REGS(29)
	STORE_REGS(30)
	STORE_REGS(31)
	la	sp, _sstack
	addi	sp,sp,-16
	jal ra, entry
	LOAD_REGS(1)
	LOAD_REGS(2)
	LOAD_REGS(3)
	LOAD_REGS(4)
	LOAD_REGS(5)
	LOAD_REGS(6)
	LOAD_REGS(7)
	LOAD_REGS(8)
	LOAD_REGS(9)
	LOAD_REGS(10)
	LOAD_REGS(11)
	LOAD_REGS(12)
	LOAD_REGS(13)
	LOAD_REGS(14)
	LOAD_REGS(15)
	LOAD_REGS(16)
	LOAD_REGS(17)
	LOAD_REGS(18)
	LOAD_REGS(19)
	LOAD_REGS(20)
	LOAD_REGS(21)
	LOAD_REGS(22)
	LOAD_REGS(23)
	LOAD_REGS(24)
	LOAD_REGS(25)
	LOAD_REGS(26)
	LOAD_REGS(27)
	LOAD_REGS(28)
	LOAD_REGS(29)
	LOAD_REGS(30)
	LOAD_REGS(31)
	j back
_init:
	li x1, 0x1800
	csrrw x0, mstatus, x1
	la x11, 0x10000000
	li x1, 0x80
	sb x1, 3(x11)
	li x1, 8
	sb x1, 0(x11)
	li x1, 3
	sb x1, 3(x11)
	la x11, 0x81000000
	la x1, 0x80000000
	sw x1, 0x4(x0)
	mv x1, x0
	j back
