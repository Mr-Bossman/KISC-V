BUILD_DIR = build
PREFIX_NAME = RV32emu
TARGET_CC = $(CROSS_COMPILE)gcc
CC = gcc
TARGET_LD = $(CROSS_COMPILE)ld
CXX = g++
CPPFLAGS = -DVPREFIX=$(PREFIX_NAME) -O3
VFLAGS =
LDFLAGS =
CPP_SOURCES = src/test.cpp
V_SOURCES = hdl/sram.v hdl/apb_align.v hdl/cpu.v hdl/alu.v hdl/APB.v hdl/uart.v hdl/intctrl.v hdl/timer.v hdl/control_unit.v hdl/datapath.v hdl/regfile.v hdl/programcounter.v hdl/sys.v opencores/gh_uart_16550_AMBA_APB_wrapper.v
VERILATOR_TOP_FILE = hdl/soc_top.v
VERILATOR_TOP = soc_top
ICARUS_TOP_FILE = hdl/soc_top_iverilog.v
INCV_SOURCES =
INCLUDES = $(addprefix --include $(PREFIX_NAME)_,$(notdir $(INCV_SOURCES:.v=.h))) -include $(PREFIX_NAME).h -include $(PREFIX_NAME)___024root.h
CPPFLAGS += $(INCLUDES)
CROSS_COMPILE = riscv32-unknown-elf-
PATH := $(PATH):$(shell pwd)/riscv/bin

.PHONY: tests

all: $(PREFIX_NAME) system

$(PREFIX_NAME): $(V_SOURCES) $(VERILATOR_TOP_FILE) $(CPP_SOURCES)
	verilator $(VFLAGS) -Wall --Mdir $(BUILD_DIR) -Ihdl -DSYSTEM_VERILOG_2012 -cc $(V_SOURCES) $(VERILATOR_TOP_FILE) -prefix $(PREFIX_NAME) -CFLAGS "$(CPPFLAGS)" $(CPP_SOURCES) --exe --top-module $(VERILATOR_TOP)
	$(MAKE) -C $(BUILD_DIR) -f $(PREFIX_NAME).mk $(PREFIX_NAME)
	cp $(BUILD_DIR)/$(PREFIX_NAME) .

icarus: $(V_SOURCES) $(ICARUS_TOP_FILE) system
	iverilog -o $(PREFIX_NAME) -g2012 -DSYSTEM_VERILOG_2012_ICARUS -Ihdl $(V_SOURCES) $(ICARUS_TOP_FILE)

run: all
	./$(PREFIX_NAME)

tests:
	rm test.mem || true
	$(MAKE) -C tests CROSS_COMPILE=$(CROSS_COMPILE)

run_tests: all tests
	./$(PREFIX_NAME)

example: src/example.s src/example.lds
	$(TARGET_CC) -march=rv32izicsr -mabi=ilp32 -c src/example.s -o $(BUILD_DIR)/example.o
	$(TARGET_CC) -march=rv32izicsr -O2 -mabi=ilp32 -Wall -Wno-array-bounds -Wno-unused-function -c src/example.c -o $(BUILD_DIR)/example_c.o
	$(TARGET_LD) --gc-sections -T src/example.lds $(BUILD_DIR)/example.o $(BUILD_DIR)/example_c.o $(LDFLAGS) -o $(BUILD_DIR)/example.elf
	$(CROSS_COMPILE)objcopy -Obinary $(BUILD_DIR)/example.elf $(BUILD_DIR)/example.bin

system: src/system.S src/system.c src/system.lds
	$(TARGET_CC) -march=rv32izicsr -mabi=ilp32 -c src/system.S -o $(BUILD_DIR)/system_start.o
	$(TARGET_CC) -march=rv32izicsr -O2 -mabi=ilp32 -Wall -Wno-array-bounds -Wno-unused-function -c src/system.c -o $(BUILD_DIR)/system.o
	$(TARGET_CC) -march=rv32izicsr -O2 -mabi=ilp32 -Wall -Wno-array-bounds -Wno-unused-function -c src/bootloader.c -o $(BUILD_DIR)/bootloader.o
	$(TARGET_LD) --gc-sections -T src/system.lds $(BUILD_DIR)/system_start.o $(BUILD_DIR)/system.o $(BUILD_DIR)/bootloader.o -o $(BUILD_DIR)/system.elf
	$(CROSS_COMPILE)objcopy -Obinary $(BUILD_DIR)/system.elf $(BUILD_DIR)/system.bin
	truncate -s 65536 $(BUILD_DIR)/system.bin
	$(CROSS_COMPILE)objcopy -Ibinary -O verilog --verilog-data-width=4 --reverse-bytes=4 $(BUILD_DIR)/system.bin system.mem
	sed -i s/@.*//g system.mem

testkern: all
	dtc -I dts -O dtb -o $(BUILD_DIR)/test.dtb linux/test.dts
	$(CROSS_COMPILE)objcopy -Obinary linux/vmlinux $(BUILD_DIR)/test.bin
	truncate -s 2048 $(BUILD_DIR)/test.dtb # 0x800 round up to multiple of 4
	truncate -s 2686912 $(BUILD_DIR)/test.bin # 0x1000000
	cat $(BUILD_DIR)/test.dtb >> $(BUILD_DIR)/test.bin
	$(CROSS_COMPILE)objcopy -Ibinary -O verilog --verilog-data-width=4 --reverse-bytes=4 $(BUILD_DIR)/test.bin test.mem

quartus: system
	unzip -n opencores/opencores.zip -d opencores/
	cp microop.hex KISCV-quartus/microop.hex
	cp microop_no_en.hex KISCV-quartus/microop_no_en.hex
#endianess swap
	hexdump -v -e '1/4 "%08x"' -e '"\n"' $(BUILD_DIR)/system.bin | xxd -r -p > $(BUILD_DIR)/system_le.bin
	srec_cat $(BUILD_DIR)/system_le.bin -Binary -o KISCV-quartus/system.mif -MIF 32

clean_exe:
	rm -rf $(PREFIX_NAME)

clean :
	rm -rf $(PREFIX_NAME) $(BUILD_DIR)/*
