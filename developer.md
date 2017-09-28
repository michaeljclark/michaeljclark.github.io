## Developer information

This page contains information on rv8 git repositories and the rv8 developer mailing list.


### rv8 git repositories

- git clone [https://github.com/rv8-io/rv8.git](https://github.com/rv8-io/rv8)
- git clone [https://github.com/rv8-io/rv8-bench.git](https://github.com/rv8-io/rv8-bench)
- git clone [https://github.com/rv8-io/musl-riscv-toolchain.git](https://github.com/rv8-io/musl-riscv-toolchain)


### rv8 mailing list

To post a message to the list members, send email to
[rv8-dev@lists.anarch128.org](mailto:rv8-dev@lists.anarch128.org)

To subscribe to the mailing list, send email to
[rv8-dev-subscribe@lists.anarch128.org](mailto:rv8-dev-subscribe@lists.anarch128.org)

To visit the mailing list information page follow this link:

- [lists.anarch128.org/mailman/listinfo/rv8-dev](https://lists.anarch128.org/mailman/listinfo/rv8-dev)


### rv8 quick start

_Building riscv-gnu-toolchain_

``` bash
$ sudo apt-get install autoconf automake autotools-dev curl \
  libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
  bison flex texinfo gperf libtool patchutils bc zlib1g-dev
$ git clone https://github.com/riscv/riscv-gnu-toolchain.git
$ cd riscv-gnu-toolchain
$ git submodule update --init --recursive
$ ./configure --prefix=/opt/riscv/toolchain
$ make
```

rv8 has minimal external dependencies besides a C++14 compiler,
the C/C++ standard libraries and the `asmjit` submodule.

- gcc-5.4 or clang-3.4 (Linux minimum)
- gcc-6.3 or clang-3.8 (Linux recommended)

_Building rv8_

``` bash
$ git clone https://github.com/rv8-io/rv8.git
$ cd rv8
$ git submodule update --init --recursive
$ make
$ sudo make install
```

_Running rv8_

The `riscv64-unknown-elf` newlib toolchain is required for building
the rv8 test cases and this build step depends on the `RISCV`
environment variable.

``` bash
$ cd rv8
$ export RISCV=/opt/riscv/toolchain
$ make test-build
$ make test-sim
$ make test-sys
$ rv-jit build/riscv64-unknown-elf/bin/test-dhrystone
```

### musl libc RISC-V toolchain

_Building musl-riscv-toolchain_

The `riscv64-linux-musl` musl libc toolchain is required to compile
and run the benchmarks in the [rv8-bench](/bench) repository.

```
$ git clone https://github.com/rv8-io/musl-riscv-toolchain.git
$ cd musl-riscv-toolchain
$ sh bootstrap.sh rv64
$ export PATH=$PATH:/opt/riscv/musl-riscv-toolchain-7.2.0-5/bin
$ riscv64-linux-musl-gcc --version
riscv64-linux-musl-gcc (GCC) 7.2.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions. There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
```