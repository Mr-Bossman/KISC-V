
TESTS_PATH=riscv-tests/isa/rv32ui
BUILD_DIR = ../build
CROSS_COMPILE = riscv32-unknown-elf-
CLFAGS = -march=rv32izicsr -mabi=ilp32 -I$(TESTS_PATH)/../macros/scalar -I$(TESTS_PATH)/../../env -Icustom/
#include $(TESTS_PATH)/Makefrag
rv32ui_sc_tests = \
	simple \
	add addi \
	and andi \
	auipc \
	beq bge bgeu blt bltu bne \
	jal jalr \
	lb lbu lh lhu lw \
	lui \
	or ori \
	ma_data \
	sb sh sw \
	sll slli \
	slt slti sltiu \
	sra srai \
	srl srli \
	sub \
	xor xori \

S_SOURCES = custom/start.S
S_SOURCES += $(addprefix $(TESTS_PATH)/,$(addsuffix .S, $(rv32ui_sc_tests)))
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(S_SOURCES:.S=.o)))

vpath %.S $(sort $(dir $(S_SOURCES)))

all: $(BUILD_DIR)/test.mem

$(BUILD_DIR)/%.o: %.S
	$(CROSS_COMPILE)gcc $(CLFAGS) -c -o $@ -DTEST_FUNC_NAME=$(notdir $(<:.S=)) -DTEST_FUNC_TXT='"$(notdir $(<:.S=))"' -DTEST_FUNC_RET=$(notdir $(<:.S=))_ret $<

$(BUILD_DIR)/tests.elf: $(OBJECTS) custom/linker.ld
	$(CROSS_COMPILE)gcc $(CLFAGS) -Os -ffreestanding -nostdlib -Wl,-Bstatic,-T,custom/linker.ld $(OBJECTS) -lgcc -o $@

$(BUILD_DIR)/test.mem: $(BUILD_DIR)/tests.elf
	$(CROSS_COMPILE)objcopy -O verilog --gap-fill 0 --verilog-data-width=4 -j .text -j .data $^ $@
	sed -i s/@.*//g $@

clean:
	rm -rf $(OBJECTS) $(BUILD_DIR)/start.o $(BUILD_DIR)/tests.elf $(BUILD_DIR)/test.mem
