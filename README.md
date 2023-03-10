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
# To get running on the ARTY-Z7
```bash
unzip opencores/opencores.zip -d opencores/
vivado -mode batch -source ~/rv32_hdl/vivado/KISCV.tcl -tclargs --origin_dir ~/rv32_hdl/ -tclargs --project_name ${Your project name}
```


## TODOS
 - Get Linux running of acual FPGA

