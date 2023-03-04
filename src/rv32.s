.section .asm, "ax"
.global start

.align 4
start:
	la x10, 0x10000000
	li x1, 1
	li x2, 2
	li x3, 3
	li x4, 4
	li x6, 6
	li x7, 7
	la x5, test
	csrrw x0, 0x305, x5
2:
	la x6, .texts
	ecall
1:
	lw x5, 0(x6)
	sb x5, 0(x10)
	addi x6,x6,1
	bne x5,x8,1b
	.word 0x00;

test:
	li x5, 'a'
	sb x5, 0(x10)
	csrrs x5, 0x341, x0
	addi x5,x5,4
	csrrw x0, 0x341, x5
	mret

.texts:
	.ascii "test\n";
	.byte 0x00;
	.balign 4, 0;
