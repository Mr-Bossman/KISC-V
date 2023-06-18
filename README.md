# Super simple microcodedd RISCV32I cpu.

 - 3(LUI/AUIPC/JAL), 4(ALU/BRANCH/JALR), 6(STORE/LOAD) clocks cycles per instrution.
 - No fence or CSR instructions (emulated with system rom)
 - No MMU.
 - Uses APB bus.
 - Runs Linux
 - Uses Verilator

## To try out yourself
 - Download and compile the latest Verilator
 - Download and compile the lastest Binutils and gcc
```bash
git submodule update --init --recursive
make CROSS_COMPILE=riscv32-unknown-elf- run_tests
make CROSS_COMPILE=riscv32-unknown-elf- testkern
```
## TODOS
 - Get running of actual FPGA

## Notes
### Tested on
 - GNU Binutils: 2.40.0.20230214
 - riscv32-unknown-elf-gcc (g2ee5e430018) 12.2.0
 - Verilator v5.012

Used precompiled:

https://github.com/riscv-collab/riscv-gnu-toolchain/releases/tag/2023.06.09

riscv32-elf-ubuntu-22.04-nightly-2023.06.09-nightly.tar.gz

### To use older verilators':
Remove `--assert` from verilator's paramaters in the Makefile


### Older version of binutils:
objcopy doesnt work when using `--verilog-data-width=4 --reverse-bytes=4` when converting from
elf to verilog mem files.

To get around this we first copy to raw binary then use the folowing to convert to verilog memfile.
`objcopy -Ibinary -O verilog --verilog-data-width=4 --reverse-bytes=4 test.bin test.mem`
