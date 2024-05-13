.section .asm, "ax"
.global _start
.global _exit_
.global _reset_

.align 4
_start:
	la x11, 0x10000000
	li x1, 0x80
	sb x1, 3(x11)
	li x1, 2
	sb x1, 0(x11)
	li x1, 3
	sb x1, 3(x11)
	la	sp, _sstack
	addi	sp,sp,-16
	jal ra, entry

_exit_:
	.word 0x00

_reset_:
	jalr x0, x0, 0
