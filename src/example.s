.section .asm, "ax"
.global _start

.align 4
	j _start
interrupt:
	.word _start
_start:
	/* init uart */
	la x10, 0x10000000
	li x5, 0x80
	sb x5, 3(x10)
	li x5, 8
	sb x5, 0(x10)
	li x5, 3
	sb x5, 3(x10)
	/* set int vect */
	la x5, _start
	sw x5, 4(x0)
	mv x10, x0
	mv x5, x0
	la	sp, _sstack
	addi	sp,sp,-16
	jal ra, entry
	.word 0x0
