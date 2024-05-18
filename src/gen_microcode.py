#!/usr/bin/python3
import enum
import sys

class Micro_ops(enum.IntEnum):
	NOP		= 0x0000,
	APB_PSEL	= 0x0001,
	APB_PEN		= 0x0002,
	APB_WRITE	= 0x0004,
	LOAD_ISR	= 0x0008,
	MEM_ACCESS	= 0x0010,
	ALU_FLAGS	= 0x0020,
	LOAD_PC		= 0x0040,
	SYS_LOAD	= 0x0080,
	ALU_STORE	= 0x0100,


LOADINS = [Micro_ops.APB_PSEL,
	   Micro_ops.APB_PSEL | Micro_ops.APB_PEN | Micro_ops.LOAD_ISR,
	   Micro_ops.NOP]

STORE = [Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
	 Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE,
	 Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_WRITE | Micro_ops.APB_PEN,
	 Micro_ops.NOP]

LOAD = [Micro_ops.MEM_ACCESS,
	Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS,
	Micro_ops.APB_PSEL | Micro_ops.MEM_ACCESS | Micro_ops.APB_PEN,
	Micro_ops.NOP]

SYSTEM = [Micro_ops.SYS_LOAD,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_PEN,
	  Micro_ops.NOP,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_WRITE,
	  Micro_ops.APB_PSEL | Micro_ops.SYS_LOAD | Micro_ops.APB_WRITE | Micro_ops.APB_PEN,
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

def print_err(*args, **kwargs):
	print(*args, file=sys.stderr, **kwargs)

def help():
	print_err("Usage: ", sys.argv[0], "[-n] [-h] [output file]]")
	print_err("Options:")
	print_err("-h: Prints this help message")
	print_err("-n: Generate microcode without the enable signal")
	print_err("default output file: microcode.hex")
	print_err("default output file with [-n]: microcode_no_en.hex")

def gen_opcodes(index, microcode,loadins):
	ret = ""
	if(len(microcode) > 16-len(loadins)):
		print_err("Too many microcode instructions")
		return
	ofs = 1 if index == 0 else len(loadins)
	for i in range(16):
		if(i >= len(microcode)):
			code = 0
		else:
			#top 4 bits are the opcode index next 4 bits are the microcode index
			#last 8 bits are the microcode
			code = microcode[i] | (((i+ofs)*0x200) + (index*0x2000))
			# end jump to start
			if(i == len(microcode)-1):
				code = 0
		ret += "{:04x}\n".format(code)
	if index == 0:
		for _ in range(len(loadins)-1):
			ret += "0"*4 + "\n"
	return ret

def gen_microcode(file_name="microop.hex"):
	hex_str = ""
	file = open(file_name, "w")
	hex_str += gen_opcodes(0, LOADINS, LOADINS)
	hex_str += gen_opcodes(1, STORE, LOADINS)
	hex_str += gen_opcodes(2, LOAD, LOADINS)
	hex_str += gen_opcodes(3, SYSTEM, LOADINS)
	hex_str += gen_opcodes(4, ALU, LOADINS)
	hex_str += gen_opcodes(5, JALR, LOADINS)
	hex_str += gen_opcodes(6, BRANCH, LOADINS)
	# pad out the rest of the microcode
	# this allows for 7 opcodes
	# the last opcode is a jump to the start
	for _ in range(16-(len(LOADINS)-1)):
		hex_str += "0"*4 + "\n"

	file.write(hex_str)
	file.close()


def gen_microcode_no_en(file_name="microop_no_en.hex"):
	hex_str = ""
	file = open(file_name, "w")
	hex_str += gen_opcodes(0, LOADINS_NO_EN, LOADINS_NO_EN)
	hex_str += gen_opcodes(1, STORE_NO_EN, LOADINS_NO_EN)
	hex_str += gen_opcodes(2, LOAD_NO_EN, LOADINS_NO_EN)
	hex_str += gen_opcodes(3, SYSTEM_NO_EN, LOADINS_NO_EN)
	hex_str += gen_opcodes(4, ALU, LOADINS_NO_EN)
	hex_str += gen_opcodes(5, JALR, LOADINS_NO_EN)
	hex_str += gen_opcodes(6, BRANCH, LOADINS_NO_EN)
	# pad out the rest of the microcode
	# this allows for 7 opcodes
	# the last opcode is a jump to the start
	for _ in range(16-(len(LOADINS_NO_EN)-1)):
		hex_str += ("0"*4) + "\n"

	file.write(hex_str)
	file.close()


def main():
	if len(sys.argv) == 3:
		if sys.argv[1] == "-n":
			gen_microcode_no_en(sys.argv[2])
		elif sys.argv[2] == "-n":
			gen_microcode_no_en(sys.argv[1])
		else:
			help()
	elif len(sys.argv) == 2:
		if sys.argv[1] == "-n":
			gen_microcode_no_en()
		elif sys.argv[1][0] == "-":
			help()
		else:
			gen_microcode(sys.argv[1])
	elif len(sys.argv) == 1:
		gen_microcode()
	else:
		help()

if __name__ == "__main__":
	main()
