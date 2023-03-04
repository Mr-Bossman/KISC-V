BUILD_DIR = build
PREFIX_NAME = RV32emu
TARGET_CC = $(CROSS_COMPILE)gcc
CC = gcc
TARGET_LD = $(CROSS_COMPILE)ld
CXX = g++
CPPFLAGS = -DVPREFIX=$(PREFIX_NAME) -Og
LDFLAGS =
CPP_SOURCES = src/test.cpp
V_SOURCES = hdl/sram.v hdl/cpu.v hdl/alu.v hdl/APB.v hdl/uart.v hdl/soc_top.v
INCV_SOURCES =
INCLUDES = $(addprefix --include $(PREFIX_NAME)_,$(notdir $(INCV_SOURCES:.v=.h))) -include $(PREFIX_NAME).h -include $(PREFIX_NAME)___024root.h
CPPFLAGS += $(INCLUDES)
CROSS_COMPILE=riscv32-linux-

.PHONY: tests

all: $(PREFIX_NAME)

$(PREFIX_NAME) : $(V_SOURCES) $(CPP_SOURCES)
	verilator -Wall --Mdir $(BUILD_DIR) -cc $(V_SOURCES) -prefix $(PREFIX_NAME) -CFLAGS "$(CPPFLAGS)" $(CPP_SOURCES) --exe --top-module soc_top
	$(MAKE) -C $(BUILD_DIR) -f $(PREFIX_NAME).mk $(PREFIX_NAME)
	cp $(BUILD_DIR)/$(PREFIX_NAME) .

run: $(PREFIX_NAME)
	./$(PREFIX_NAME)

tests:
	rm test.vh || true
	$(MAKE) -C tests CROSS_COMPILE=$(CROSS_COMPILE)

run_tests: all tests
	./$(PREFIX_NAME)

rv32asm: src/rv32.s src/rv32.lds
	$(TARGET_CC) -march=rv32izicsr -mabi=ilp32 -c src/rv32.s -o $(BUILD_DIR)/example.o
	$(TARGET_LD) --gc-sections -T src/rv32.lds $(BUILD_DIR)/example.o -o $(BUILD_DIR)/example.elf
	$(CROSS_COMPILE)objcopy -O verilog --gap-fill 0 --verilog-data-width=4 $(BUILD_DIR)/example.elf test.vh
	sed -i s/@.*//g test.vh

system: src/system.S src/system.lds rv32asm
	$(TARGET_CC) -march=rv32izicsr -mabi=ilp32 -c src/system.S -o $(BUILD_DIR)/system_start.o
	$(TARGET_CC) -march=rv32izicsr -O2 -mabi=ilp32 -Wall -c src/system.c -o $(BUILD_DIR)/system.o
	$(TARGET_LD) --gc-sections -T src/system.lds $(BUILD_DIR)/system_start.o $(BUILD_DIR)/system.o -o $(BUILD_DIR)/system.elf
	$(CROSS_COMPILE)objcopy -O verilog --gap-fill 0 --verilog-data-width=4 $(BUILD_DIR)/system.elf system.vh
	sed -i s/@.*//g system.vh

clean_exe:
	rm -rf $(PREFIX_NAME)

clean :
	rm -rf $(PREFIX_NAME) $(BUILD_DIR)/

#riscv32-unknown-elf-objcopy -O verilog --verilog-data-width=4 --gap-fill 0 -g -R .riscv.attributes ~/linux/rv32/linux/vmlinux test.vh
