#!/bin/bash
set -e
wget https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2023.06.09/riscv32-elf-ubuntu-22.04-nightly-2023.06.09-nightly.tar.gz
tar -xf riscv32-elf-ubuntu-22.04-nightly-2023.06.09-nightly.tar.gz
rm riscv32-elf-ubuntu-22.04-nightly-2023.06.09-nightly.tar.gz
