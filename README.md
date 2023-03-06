# Super simple microcodedd RISCV32I cpu.

 - 3(LUI/AUIPC/JAL), 4(ALU/BRANCH/JALR), 6(STORE/LOAD) clocks cycles per instrution.
 - No fence or CSR instructions (emulated with system rom)
 - No MMU.
 - Uses APB bus.
 - Runs Linux
 - Uses Verilator

## To try out yourself
```bash
git submodule update --init --recursive
make CROSS_COMPILE=riscv32-unknown-elf- run_tests
make CROSS_COMPILE=riscv32-unknown-elf- testkern
```
## TODOS
 - Get running of acual FPGA

