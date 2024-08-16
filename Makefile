BUILD_DIR = build
PREFIX_NAME = RV32emu
QUARTUS_ROOTDIR = /opt/quartus-lite/quartus/
TARGET_CC = $(CROSS_COMPILE)gcc
CC = gcc
TARGET_LD = $(CROSS_COMPILE)ld
TARGET_OBJCOPY = $(CROSS_COMPILE)objcopy
CXX = g++
CPPFLAGS = -DVPREFIX=$(PREFIX_NAME) -O3
VFLAGS =
TARGET_CFLAGS = -march=rv32izicsr -mabi=ilp32 -O2 -Wall -Wextra -Wno-array-bounds -Wno-unused-function -Wno-unused-parameter
TARGET_LDFLAGS = --gc-sections
TARGET_C_SOURCES = src/simple_lib.c src/system.c src/bootloader.c src/example.c
TARGET_S_SOURCES = src/example_start.S src/system_start.S
TARGET_C_INCLUDES = src/simple_lib.h
CPP_SOURCES = src/test.cpp
V_SOURCES = hdl/sram.v hdl/apb_align.v hdl/cpu.v hdl/alu.v hdl/APB.v hdl/uart.v hdl/intctrl.v hdl/timer.v
VERILATOR_TOP_FILE = hdl/soc_top.v
VERILATOR_TOP = soc_top
ICARUS_TOP_FILE = hdl/soc_top_iverilog.v
INCV_SOURCES =
INCLUDES = $(addprefix --include $(PREFIX_NAME)_,$(notdir $(INCV_SOURCES:.v=.h))) -include $(PREFIX_NAME).h -include $(PREFIX_NAME)___024root.h
CPPFLAGS += $(INCLUDES)

TARGET_CFLAGS += $(addprefix -I, $(sort $(dir $(TARGET_C_INCLUDES))))
TARGET_OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(TARGET_C_SOURCES:.c=.o)))
TARGET_OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(TARGET_S_SOURCES:.S=.o)))
TARGET_DEP = $(TARGET_OBJECTS:%.o=%.d)

vpath %.c $(sort $(dir $(TARGET_C_SOURCES)))
vpath %.S $(sort $(dir $(TARGET_S_SOURCES)))
vpath %.lds src
vpath %.o $(BUILD_DIR)
vpath %.elf $(BUILD_DIR)
vpath %.bin $(BUILD_DIR)

CROSS_COMPILE := riscv32-unknown-elf-
PATH := $(PATH):$(shell pwd)/riscv/bin

.PHONY: clean all run run_tests tests icarus verilator system example linux quartus clean_exe clean_mem microcode example_system bootloader

all: $(PREFIX_NAME) system tests microcode

help:
	@echo "make: make all"
	@echo "make all: build verilator, system.mem, tests and microcode"
	@echo "make run: make all and run the emulator"
	@echo "make icarus: build the emulator with iverilog"
	@echo "make run_tests: run the emulator with tests"
	@echo "make tests: build riscv-tests"
	@echo "make system: build system.mem, for emulating CSRs and bootloading system "
	@echo "make example: build \"hello world\" example"
	@echo "make example_system: build \"hello world\" example, but at address 0"
	@echo "make linux: build linux memory image"
	@echo "make microcode: build microcode"
	@echo "make bootloader: build serial bootloader for FPGA"
	@echo "make transfer: build serial transfer tool"
	@echo "make qemu: run linux in qemu"
	@echo "make quartus: build the quartus project"
	@echo "make clean: clean the build directory"
	@echo "make clean_exe: clean the emulator"
	@echo "make clean_mem: clean the memory images"

$(PREFIX_NAME): $(V_SOURCES) $(CPP_SOURCES) | $(BUILD_DIR)
	verilator $(VFLAGS) -Wall --Mdir $(BUILD_DIR) -Ihdl -DSYSTEM_VERILOG_2012_VERILATOR -cc $(V_SOURCES) $(VERILATOR_TOP_FILE) -prefix $(PREFIX_NAME) -CFLAGS "$(CPPFLAGS)" $(CPP_SOURCES) --exe --top-module $(VERILATOR_TOP)
	$(MAKE) -C $(BUILD_DIR) -f $(PREFIX_NAME).mk $(PREFIX_NAME)
	cp $(BUILD_DIR)/$(PREFIX_NAME) .

icarus: $(V_SOURCES) $(ICARUS_TOP_FILE)
	iverilog -o $(PREFIX_NAME) -g2012 -DSYSTEM_VERILOG_2012_ICARUS -Ihdl $(V_SOURCES) $(ICARUS_TOP_FILE)

run: all
	./$(PREFIX_NAME)

run_tests: all tests
	./$(PREFIX_NAME)

riscv:
	./dl_toolchain.sh

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET_OBJECTS): | $(BUILD_DIR) riscv

%.mem: %.bin | riscv
	$(TARGET_OBJCOPY) -Ibinary -O verilog --verilog-data-width=4 --reverse-bytes=4 $< $@
	sed -i s/@.*//g $@

-include $(TARGET_DEP)
$(BUILD_DIR)/%.o: %.c
	$(TARGET_CC) -MMD -c $(TARGET_CFLAGS) $< -o $@

-include $(TARGET_DEP)
$(BUILD_DIR)/%.o: %.S
	$(TARGET_CC) -MMD -c $(TARGET_CFLAGS) $< -o $@

$(BUILD_DIR)/example.bin: example.lds example_start.o example.o simple_lib.o
	$(TARGET_LD) $(TARGET_LDFLAGS) -T $^ -Ttext $(TEXT_START) -o $(basename $@).elf
	$(CROSS_COMPILE)objcopy -Obinary $(basename $@).elf $@
	@echo truncate -s $$(($$(set -- $$(ls -l $@);echo "(($$5+3)/4)*4"))) $@
	@truncate -s $$(($$(set -- $$(ls -l $@);echo "(($$5+3)/4)*4"))) $@

ifdef BOOTLOADER
$(BUILD_DIR)/system.bin: bootloader.o
endif

$(BUILD_DIR)/system.bin: system.lds system.o system_start.o simple_lib.o
	$(TARGET_LD) $(TARGET_LDFLAGS) -T $^ -o $(basename $@).elf
	$(TARGET_OBJCOPY) -Obinary $(basename $@).elf $@
	truncate -s 65536 $@

$(BUILD_DIR)/linux.bin: linux/test.dts linux/vmlinux | $(BUILD_DIR) riscv
	dtc -I dts -O dtb -o $(BUILD_DIR)/test.dtb linux/test.dts
	$(TARGET_OBJCOPY) -Obinary linux/vmlinux $@
	truncate -s 2048 $(BUILD_DIR)/test.dtb # 0x800 round up to multiple of 4
	truncate -s 16777216 $@ # 0x1000000
	cat $(BUILD_DIR)/test.dtb >> $@

microop.hex: src/gen_microcode.py
	python3 src/gen_microcode.py

microop_no_en.hex: src/gen_microcode.py
	python3 src/gen_microcode.py -n

microcode: microop.hex microop_no_en.hex

tests: | $(BUILD_DIR) riscv
	@$(MAKE) -C tests CROSS_COMPILE=$(CROSS_COMPILE) --no-print-directory
	cp $(BUILD_DIR)/test.mem test.mem

bootloader: transfer | $(BUILD_DIR)
	rm -f $(BUILD_DIR)/system.bin
	@$(MAKE) system BOOTLOADER=1 --no-print-directory

example_:
	rm -f $(BUILD_DIR)/example.bin
	@$(MAKE) $(BUILD_DIR)/example.mem TEXT_START=$(TEXT_START) --no-print-directory

example: TEXT_START:=0x80000000
example: example_ $(BUILD_DIR)/example.mem
	cp $(BUILD_DIR)/example.mem test.mem

example_system: TEXT_START:=0x0
example_system: example_
	cp $(BUILD_DIR)/example.mem system.mem

system: $(BUILD_DIR)/system.mem
	cp $(BUILD_DIR)/system.mem system.mem

linux: $(BUILD_DIR)/linux.mem
	cp $(BUILD_DIR)/linux.mem test.mem

qemu: linux
	qemu-system-riscv32 -nographic -M virt -bios none -cpu rv32,mmu=off -kernel $(BUILD_DIR)/linux.bin -dtb $(BUILD_DIR)/test.dtb

quartus: bootloader opencores/opencores.zip microcode | $(BUILD_DIR)
	rm -rf KISCV.sof
	unzip -n opencores/opencores.zip -d opencores/
	cp microop.hex KISCV-quartus/microop.hex
	cp microop_no_en.hex KISCV-quartus/microop_no_en.hex
#endianess swap
	hexdump -v -e '1/4 "%08x"' -e '"\n"' $(BUILD_DIR)/system.bin | xxd -r -p > $(BUILD_DIR)/system_le.bin
	srec_cat $(BUILD_DIR)/system_le.bin -Binary -o KISCV-quartus/system.mif -MIF 32
	cd KISCV-quartus && $(QUARTUS_ROOTDIR)/bin/quartus_sh --flow compile KISCV
	cp KISCV-quartus/output_files/KISCV.sof .

transfer: src/transfer.cpp
	$(CXX) -o transfer src/transfer.cpp

clean_exe:
	rm -rf KISCV.sof $(PREFIX_NAME) *.mem

clean_mem:
	rm -rf *.mem

clean_toolchain:
	rm -rf riscv

clean:
	rm -rf KISCV.sof $(PREFIX_NAME) $(BUILD_DIR)/* *.mem
