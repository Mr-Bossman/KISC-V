BUILD_DIR = build
PREFIX_NAME = RV32emu
TARGET_CC = $(CROSS_COMPILE)gcc
CC = gcc
TARGET_LD = $(CROSS_COMPILE)ld
CXX = g++
CPPFLAGS = -DVPREFIX=$(PREFIX_NAME) -O3
LDFLAGS =
CPP_SOURCES = src/test.cpp
V_SOURCES = hdl/sram.v hdl/cpu.v hdl/alu.v hdl/APB.v hdl/uart.v hdl/soc_top.v hdl/intctrl.v hdl/timer.v
INCV_SOURCES =
INCLUDES = $(addprefix --include $(PREFIX_NAME)_,$(notdir $(INCV_SOURCES:.v=.h))) -include $(PREFIX_NAME).h -include $(PREFIX_NAME)___024root.h
CPPFLAGS += $(INCLUDES)
CROSS_COMPILE=riscv32-linux-

.PHONY: tests

all: $(PREFIX_NAME)

$(PREFIX_NAME): $(V_SOURCES) $(CPP_SOURCES) system
	verilator --assert -Wall --Mdir $(BUILD_DIR) -cc $(V_SOURCES) -prefix $(PREFIX_NAME) -CFLAGS "$(CPPFLAGS)" $(CPP_SOURCES) --exe --top-module soc_top
	$(MAKE) -C $(BUILD_DIR) -f $(PREFIX_NAME).mk $(PREFIX_NAME)
	cp $(BUILD_DIR)/$(PREFIX_NAME) .

run: all
	./$(PREFIX_NAME)

tests:
	rm test.mem || true
	$(MAKE) -C tests CROSS_COMPILE=$(CROSS_COMPILE)

run_tests: all tests
	./$(PREFIX_NAME)

example: src/example.s src/example.lds all
	$(TARGET_CC) -march=rv32izicsr -mabi=ilp32 -c src/example.s -o $(BUILD_DIR)/example.o
	$(TARGET_LD) --gc-sections -T src/example.lds $(BUILD_DIR)/example.o -o $(BUILD_DIR)/example.elf
	$(CROSS_COMPILE)objcopy -O verilog --gap-fill 0 --verilog-data-width=4 $(BUILD_DIR)/example.elf system.mem
	sed -i s/@.*//g system.mem

system: src/system.S src/system.c src/system.lds
	$(TARGET_CC) -march=rv32izicsr -mabi=ilp32 -c src/system.S -o $(BUILD_DIR)/system_start.o
	$(TARGET_CC) -march=rv32izicsr -O2 -mabi=ilp32 -Wall -Wno-array-bounds -Wno-unused-function -c src/system.c -o $(BUILD_DIR)/system.o
	$(TARGET_LD) --gc-sections -T src/system.lds $(BUILD_DIR)/system_start.o $(BUILD_DIR)/system.o -o $(BUILD_DIR)/system.elf
	$(CROSS_COMPILE)objcopy -O verilog --gap-fill 0 --verilog-data-width=4 $(BUILD_DIR)/system.elf system.mem
	sed -i s/@.*//g system.mem

testkern: all
	dtc -I dts -O dtb -o $(BUILD_DIR)/test.dtb linux/test.dts
	$(CROSS_COMPILE)objcopy -Obinary linux/vmlinux $(BUILD_DIR)/test.bin
	truncate -s 2048 $(BUILD_DIR)/test.dtb # 0x800 round up to multiple of 4
	truncate -s 16777216 $(BUILD_DIR)/test.bin # 0x1000000
	cat $(BUILD_DIR)/test.dtb >> $(BUILD_DIR)/test.bin
	$(CROSS_COMPILE)objcopy -Ibinary -O verilog --verilog-data-width=4 --reverse-bytes=4 $(BUILD_DIR)/test.bin test.mem

clean_exe:
	rm -rf $(PREFIX_NAME)

clean :
	rm -rf $(PREFIX_NAME) $(BUILD_DIR)/*
