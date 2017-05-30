### About

The rv8 simulator suite contains libraries and command line tools for creating instruction opcode maps, C headers and source containing instruction set metadata, instruction decoders, a JIT assembler, LaTeX documentation, a metadata based RISC-V disassembler, a histogram tool for generating statistics on RISC-V ELF executables, a RISC-V proxy syscall simulator, a RISC-V full system emulator that implements the RISC-V 1.9.1 privileged specification and an x86-64 binary translator.

### Getting Started

Build riscv-gnu-toolchain

```
sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
git clone https://github.com/riscv/riscv-gnu-toolchain.git
cd riscv-gnu-toolchain
git submodule update --init --recursive
./configure --prefix=/opt/riscv/toolchain
make
```

Build rv8

```
export RISCV=/opt/riscv/toolchain
git clone https://github.com/rv8-io/rv8.git
cd rv8
git submodule update --init --recursive
make
sudo make install
```

Run rv8

```
make test-build
rv-jit build/riscv64-unknown-elf/bin/test-dhrystone
```
