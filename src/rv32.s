.section .asm, "ax"
.global start

.align 4
start:
	la x10, 0x1000000
	la x5, test
	sw x5, 0xC(x0)
2:
	la x6, .texts
1:
	ecall
	lw x5, 0(x6)
	sb x5, 0(x10)
	addi x6,x6,1
	bne x5,x8,1b
	.word 0x00;

test:
	li x5, 'a'
	sb x5, 0(x10)
	ecall

.texts:
	.ascii "test\n";
	.byte 0x00;
	.balign 4, 0;
