.section .asm, "ax"
.global _start

_start:
	/* init uart */
	la x10, 0x10000000
	li x5, 0x80
	sb x5, 3(x10)
	li x5, 2
	sb x5, 0(x10)
	li x5, 3
	sb x5, 3(x10)
	mv x10, x0
	mv x5, x0
	la	sp, _sstack
	addi	sp,sp,-16
	jal ra, entry
	jalr x0
