.section .asm, "ax"
.global start

.align 4
start:
  lw a5, (a6)
	li a5,10
1:
  addi a5,a5,-1
  bnez a5,1b
