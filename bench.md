<a href="https://rv8.io/"><img style="float: right;" src="/images/rv8.svg"></a>

## rv8 benchmarks

This document contains [rv8-bench](https://github.com/rv8-io/rv8-bench/)
benchmark results for GCC 7.1.0 and musl libc on an Intel Core i7 Broadwell CPU.

The following sources are used:

- rv8 - [https://github.com/rv8-io/rv8/](https://github.com/rv8-io/rv8/)
- rv8-bench - [https://github.com/rv8-io/rv8-bench/](https://github.com/rv8-io/rv8-bench/)
- qemu-riscv - [https://github.com/riscv/riscv-qemu/](https://github.com/riscv/riscv-qemu/)
- musl-riscv-toolchain - [https://github.com/rv8-io/musl-riscv-toolchain/](https://github.com/rv8-io/musl-riscv-toolchain/)

The following results have been plotted:

- [Runtimes](#runtimes)
- [File Sizes](#file-sizes)
- [Dynamic Micro-ops](#dynamic-micro-ops)
- [Dynamic Register Usage](#dynamic-register-usage)

**Compiler details**

Architecture | Compiler  | C Library | Compile options
:--          | :--       | :--       | :--
x86-32       | GCC 7.1.0 | musl libc | `-O3, -Os`
x86-64       | GCC 7.1.0 | musl libc | `-O3, -Os`
riscv32      | GCC 7.1.0 | musl libc | `-O3, -Os`
riscv64      | GCC 7.1.0 | musl libc | `-O3, -Os`
aarch64      | GCC 7.1.0 | musl libc | `-O3, -Os`

**Host details**

- Intel® 6th-gen Core™ i7-5557U Broadwell (3.10GHz, 3.40GHz Turbo, 4MB cache)
- x86-64 μops measured with
  - `perf stat -e cycles,instructions,r1b1,r10e,r2c2,r1c2 <cmd>`

### [Runtimes](#runtimes)

Runtime results comparing qemu, rv-jit and native x86:

![benchmark runtimes -O3 64-bit]({{ site.url }}/plots/runtime-O3-64.svg)
_Benchmark runtimes -O3 64-bit_

![benchmark runtimes -Os 64-bit]({{ site.url }}/plots/runtime-Os-64.svg)
_Benchmark runtimes -Os 64-bit_

![benchmark runtimes -O3 32-bit]({{ site.url }}/plots/runtime-O3-32.svg)
_Benchmark runtimes -O3 32-bit_

![benchmark runtimes -Os 32-bit]({{ site.url }}/plots/runtime-Os-32.svg)
_Benchmark runtimes -Os 32-bit_

### [File Sizes](#file-sizes)

GCC filesize results comparing aarch64, riscv32, riscv64, x86-32 and x86-64:

![benchmark filesizes -O3]({{ site.url }}/plots/filesize-O3.svg)
_Compiled file sizes -O3_

![benchmark filesizes -Os]({{ site.url }}/plots/filesize-Os.svg)
_Compiled file sizes -Os_

### [Dynamic Micro-ops](#dynamic-micro-ops)

Dynamic micro-op/instruction counts comparing RISC-V and x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/operations-O3-64.svg)
_Dynamic operation counts -O3 64-bit_

![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-64.svg)
_Dynamic operation counts -Os 64-bit_

![operation counts -O3 32-bit]({{ site.url }}/plots/operations-O3-32.svg)
_Dynamic operation counts -O3 32-bit_

![operation counts -Os 32-bit]({{ site.url }}/plots/operations-Os-32.svg)
_Dynamic operation counts -Os 32-bit_

### [Dynamic Register Usage](#dynamic-register-usage)

Dynamic register usage results comparing riscv64 -O3 vs -Os

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-1.svg)
_Dynamic register usage - aes -O3 vs -Os (sorted by frequency)_

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-2.svg)
_Dynamic register usage - aes -O3 vs -Os (sorted by alphabetically)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-1.svg)
_Dynamic register usage - dhrystone -O3 vs -Os (sorted by frequency)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-2.svg)
_Dynamic register usage - dhrystone -O3 vs -Os (sorted by alphabetically)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-1.svg)
_Dynamic register usage - miniz -O3 vs -Os (sorted by frequency)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-2.svg)
_Dynamic register usage - miniz -O3 vs -Os (sorted by alphabetically)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-1.svg)
_Dynamic register usage - norx -O3 vs -Os (sorted by frequency)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-2.svg)
_Dynamic register usage - norx -O3 vs -Os (sorted by alphabetically)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-1.svg)
_Dynamic register usage - primes -O3 vs -Os (sorted by frequency)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-2.svg)
_Dynamic register usage - primes -O3 vs -Os (sorted by alphabetically)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-1.svg)
_Dynamic register usage - qsort -O3 vs -Os (sorted by frequency)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-2.svg)
_Dynamic register usage - qsort -O3 vs -Os (sorted by alphabetically)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-1.svg)
_Dynamic register usage - sha512 -O3 vs -Os (sorted by frequency)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-2.svg)
_Dynamic register usage - sha512 -O3 vs -Os (sorted by alphabetically)_
