.section .asm, "ax"
.global start

.align 4
start:
  lw x4, (x0)
  sw x4, 8(x0)
	li x5,10
1:
  addi x5,x5,-1
  bnez x5,1b
