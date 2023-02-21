.section .asm, "ax"
.global start

.align 4
start:
  lw x4, (x0)
  sw x4, 0x60(x0)
  li x6, 32
	li x5,126
1:
  sw x5, 0x400(x0)
  addi x5,x5,-1
  bne x5,x6,1b
