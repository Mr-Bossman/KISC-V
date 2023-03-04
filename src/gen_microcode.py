#!/usr/bin/python3
import enum


class Micro_ops(enum.IntEnum):
    NOP = 0,
    APB_PSEL = 0x1,
    APB_PEN = 0x2,
    ALU_STORE = 0x4,
    LOAD_ISR = 0x8,
    MEM_ACCESS = 0x10,
    ALU_FLAGS = 0x20,
    LOAD_PC = 0x40,
    SYS_LOAD = 0x80,
    APB_WRITE = 0x100,
    RESERVED = 0x200,
    RESERVED2 = 0x400,
    RESERVED3 = 0x800


LOADINS = [Micro_ops.APB_PSEL,
	   Micro_ops.APB_PSEL | Micro_ops.APB_PEN | Micro_ops.LOAD_ISR,
       	   Micro_ops.RESERVED3]

STORE = [Micro_ops.MEM_ACCESS,
	 Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
         Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE | Micro_ops.APB_PEN,
     	 Micro_ops.RESERVED3]

LOAD = [Micro_ops.MEM_ACCESS,
	Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS,
	Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_PEN, Micro_ops.RESERVED3]

SYSTEM = [Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_PEN,
	  Micro_ops.NOP,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_WRITE,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_PEN | Micro_ops.APB_WRITE,
	  Micro_ops.RESERVED3]

ALU = [Micro_ops.ALU_STORE,Micro_ops.RESERVED3]
JALR = [Micro_ops.LOAD_PC, Micro_ops.RESERVED3]
BRANCH = [Micro_ops.ALU_FLAGS, Micro_ops.RESERVED3]
LUI = [Micro_ops.RESERVED3]
JAL = [Micro_ops.RESERVED3]

def gen_opcodes(index, microcode):
	if(len(microcode) > 8):
		print("Too many microcode instructions")
		return
	for i in range(8):
		if(i >= len(microcode)):
			code = 0
		else:
			code = microcode[i] 
		print("{:06x}".format(code))

def gen_microcode():
	gen_opcodes(0, LOADINS)
	gen_opcodes(1, STORE)
	gen_opcodes(2, LOAD)
	gen_opcodes(3, SYSTEM)
	gen_opcodes(4, ALU)
	gen_opcodes(5, JALR)
	gen_opcodes(6, BRANCH)
	gen_opcodes(7, LUI)
	gen_opcodes(8, JAL)

	#for i in range(9):
	#	print(i*8)


gen_microcode()
