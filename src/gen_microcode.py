#!/usr/bin/python3
import enum
import sys

class Micro_ops(enum.IntEnum):
	NOP = 0,
	APB_PSEL = 0x1,
	APB_WRITE = 0x2,
	LOAD_ISR = 0x4,
	MEM_ACCESS = 0x8,
	ALU_FLAGS = 0x10,
	LOAD_PC = 0x20,
	SYS_LOAD = 0x40,
	ALU_STORE= 0x80,


LOADINS = [Micro_ops.APB_PSEL,
	   Micro_ops.APB_PSEL | Micro_ops.LOAD_ISR,
	   Micro_ops.NOP]

STORE = [Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
	 Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
         Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
	 Micro_ops.NOP]

LOAD = [Micro_ops.MEM_ACCESS,
	Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS,
	Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS,
	Micro_ops.NOP]

SYSTEM = [Micro_ops.SYS_LOAD,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD,
	  Micro_ops.NOP,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_WRITE,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_WRITE,
	  Micro_ops.NOP]

LOADINS_NO_EN = [Micro_ops.APB_PSEL | Micro_ops.LOAD_ISR,
		 Micro_ops.NOP]

STORE_NO_EN = [Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
	       Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
	       Micro_ops.NOP]

LOAD_NO_EN = [Micro_ops.MEM_ACCESS,
	      Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS,
	      Micro_ops.NOP]

SYSTEM_NO_EN = [Micro_ops.SYS_LOAD,
		Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD,
		Micro_ops.NOP,
		Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_WRITE,
		Micro_ops.NOP]

ALU = [Micro_ops.ALU_STORE,
       Micro_ops.NOP]

JALR = [Micro_ops.LOAD_PC,
	Micro_ops.NOP]

BRANCH = [Micro_ops.ALU_FLAGS | Micro_ops.LOAD_PC,
	  Micro_ops.NOP]

def gen_opcodes(index, microcode,loadins):
	if(len(microcode) > 16-len(loadins)):
		print("Too many microcode instructions")
		return
	ofs = 1 if index == 0 else len(loadins)
	for i in range(16):
		if(i >= len(microcode)):
			code = 0
		else:
			#top 4 bits are the opcode index next 4 bits are the microcode index
			#last 8 bits are the microcode
			code = microcode[i] | (((i+ofs)*0x100) + (index*0x1000))
			# end jump to start
			if(i == len(microcode)-1):
				code = microcode[i]
		print("{:04x}".format(code))
	if index == 0:
		for _ in range(len(loadins)-1):
			print("0"*4)
def gen_microcode():
	gen_opcodes(0, LOADINS, LOADINS)
	gen_opcodes(1, STORE, LOADINS)
	gen_opcodes(2, LOAD, LOADINS)
	gen_opcodes(3, SYSTEM, LOADINS)
	gen_opcodes(4, ALU, LOADINS)
	gen_opcodes(5, JALR, LOADINS)
	gen_opcodes(6, BRANCH, LOADINS)
	# pad out the rest of the microcode
	# this allows for 7 opcodes
	# the last opcode is a jump to the start
	for _ in range(16-(len(LOADINS)-1)):
		print("0"*4)
	#for i in range(9):
	#	print(i*8)

def gen_microcode_no_en():
	gen_opcodes(0, LOADINS_NO_EN, LOADINS_NO_EN)
	gen_opcodes(1, STORE_NO_EN, LOADINS_NO_EN)
	gen_opcodes(2, LOAD_NO_EN, LOADINS_NO_EN)
	gen_opcodes(3, SYSTEM_NO_EN, LOADINS_NO_EN)
	gen_opcodes(4, ALU, LOADINS_NO_EN)
	gen_opcodes(5, JALR, LOADINS_NO_EN)
	gen_opcodes(6, BRANCH, LOADINS_NO_EN)
	# pad out the rest of the microcode
	# this allows for 7 opcodes
	# the last opcode is a jump to the start
	for _ in range(16-(len(LOADINS)-1)):
		print("0"*4)
	#for i in range(9):
	#	print(i*8)

def print_err(*args, **kwargs):
	print(*args, file=sys.stderr, **kwargs)

def help():
	print_err("Usage: ", sys.argv[0], "[-n] > microcode.hex")
	print_err("Options:")
	print_err("-n: Generate microcode without the enable signal")

def main():
	if len(sys.argv) == 2:
		if sys.argv[1] == "-n":
			gen_microcode_no_en()
		else:
			help()
	elif len(sys.argv) == 1:
		gen_microcode()
	else:
		help()

if __name__ == "__main__":
	main()
