.section .asm, "ax"
.global start

.align 4
start:
	la x10, 0x10000000
	la x6, .texts
	li x5,0x80
	sb x5, 3(x10)
	li x5, 8
	sb x5,0(x10)
	li x5,3
	sb x5, 3(x10)
1:
	lb x5, 0(x6)
	sb x5, 0(x10)
	li x4,0xffff
2:
	addi x4,x4,-1
	bnez x4, 2b
	addi x6,x6,1
	bnez x5,1b
	j start

.texts:
	.ascii "test\n\r";
	.byte 0x00;
	.balign 4, 0;
