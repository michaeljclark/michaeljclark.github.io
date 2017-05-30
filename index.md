### About

rv8 is a RISC-V simulation suite comprising a high performance x86-64 binary translator, a user mode simulator, a full system emulator and an ELF binary analysis tool:

> * rv-jit - _user mode x86-64 binary translator_
> * rv-sim - _user mode system call proxy simulator_
> * rv-sys - _full system emulator with soft MMU_
> * rv-bin - _ELF disassembler and histogram tool_

The rv8 simulator suite contains libraries and command line tools for creating instruction opcode maps, C headers and source containing instruction set metadata, instruction decoders, a JIT assembler, LaTeX documentation, a metadata based RISC-V disassembler, a histogram tool for generating statistics on RISC-V ELF executables, a RISC-V proxy syscall simulator, a RISC-V full system emulator that implements the RISC-V 1.9.1 privileged specification and an x86-64 binary translator.

The current version is available [here](https://github.com/rv8-io/rv8).

---

### Getting Started

_Building riscv-gnu-toolchain_

{% highlight bash %}
$ sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
$ git clone https://github.com/riscv/riscv-gnu-toolchain.git
$ cd riscv-gnu-toolchain
$ git submodule update --init --recursive
$ ./configure --prefix=/opt/riscv/toolchain
$ make
{% endhighlight %}

_Building rv8_

{% highlight bash %}
$ export RISCV=/opt/riscv/toolchain
$ git clone https://github.com/rv8-io/rv8.git
$ cd rv8
$ git submodule update --init --recursive
$ make
$ sudo make install
{% endhighlight %}

_Running rv8_

{% highlight bash %}
$ make test-build
$ rv-jit build/riscv64-unknown-elf/bin/test-dhrystone
{% endhighlight %}

---

### Benchmarks

_Runtime (seconds)_

program         | rv8-sim | rv8-jit | qemu-user | native
---             | ---     | ---     | ---       | ---
primes          |  5.07   | 0.17    | 0.27      | 0.11
miniz           | 41.52   | 2.09    | 2.20      | 0.76
SHA-512         | 23.69   | 0.70    | 1.12      | 0.24
AES             | 38.39   | 1.00    | 1.61      | 0.27
qsort           |  3.96   | 0.28    | 0.94      | 0.13
dhrystone       | 22.30   | 0.49    | 2.21      | 0.10
DMIPS (v1.1)    | 254     | 11547   | 2576      | 55132

_Performance Ratio (smaller is better)_

program         | rv8-sim | rv8-jit | qemu-user | native
---             | ---     | ---     | ---       | ---
primes          |  44.43  | 1.52    |  2.36     | 1.00
miniz           |  55.00  | 2.77    |  2.92     | 1.00
SHA-512         | 100.39  | 2.97    |  4.76     | 1.00
AES             | 140.12  | 3.66    |  5.88     | 1.00
qsort           |  29.52  | 2.05    |  7.04     | 1.00
dhrystone       | 214.45  | 4.75    | 21.23     | 1.00
Ratio (average) |   97:1  |  3:1    | 7.4:1     | 1:1

Notes:

- riscv32/riscv64 (gcc -Os) 7.0.1 20170321 (experimental)
- x86-32/x86-64 (gcc -O3) (Debian 6.3.0-6) 6.3.0 20170205
- native Intel(R) Core(TM) i7-5557U CPU @ 3.10GHz

---
