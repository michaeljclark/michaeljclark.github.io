<a href="https://rv8.io/"><img style="float: right;" src="/images/rv8.svg"></a>

## rv8 benchmark results

This document contains [rv8-bench](https://github.com/rv8-io/rv8-bench/)
benchmark results for GCC 7.1.0 and musl libc.

#### Benchmark source

The following sources have been used to run the benchmarks:

- rv8 - [https://github.com/rv8-io/rv8/](https://github.com/rv8-io/rv8/)
- rv8-bench - [https://github.com/rv8-io/rv8-bench/](https://github.com/rv8-io/rv8-bench/)
- qemu-riscv - [https://github.com/riscv/riscv-qemu/](https://github.com/riscv/riscv-qemu/)
- musl-riscv-toolchain - [https://github.com/rv8-io/musl-riscv-toolchain/](https://github.com/rv8-io/musl-riscv-toolchain/)

#### Benchmark metrics

The following benchmark metrics have been plotted and tabulated:

- [Runtimes](#runtimes)
- [Instructions Per Second](#instructions-per-second)
- [Macro-op Fusion](#macro-op-fusion)
- [Retired Micro-ops](#retired-micro-ops)
- [Executable File Sizes](#executable-file-sizes)
- [Dynamic Register Usage](#dynamic-register-usage)

#### Benchmark details

The [rv8-bench](https://github.com/rv8-io/rv8-bench/)
benchmark suite contains the following test programs:

Benchmark | Type        | Description
:--       | :--         | :--
aes       | crypto      | encrypt, decrypt and compare 30MiB of data
bigint    | numeric     | compute 23 ^ 111121 and count base 10 digits
dhrystone | synthetic   | synthetic integer workload
miniz     | compression | compress, decompress and compare 8MiB of data
norx      | crypto      | encrypt, decrypt and compare 30MiB of data
primes    | numeric     | calculate largest prime number below 33333333
qsort     | sorting     | sort array containing 50 million items
sha512    | digest      | calculate SHA-512 hash of 64MiB of data

#### Compiler details

The following compiler architectures, versions, compile options
and runtime libraries are used to run the benchmarks:

Architecture | Compiler  | C Library | Compile options
:--          | :--       | :--       | :--
x86-32       | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
x86-64       | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
riscv32      | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
riscv64      | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
aarch64      | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`

#### Measurement details

- rv8 benchmarks use `rv-jit`
- Dynamic instruction counts are measured using `rv-sim -E`
- QEMU benchmarks use `qemu-riscv32`, `qemu-riscv64` and `qemu-aarch64`
- Benchmarks are run 20 times and the best result is taken
- Intel® 6th-gen Core™ i7-5557U Broadwell (3.10GHz, 3.40GHz Turbo, 4MB cache)
- x86-64 μops measured with
  - `perf stat -e cycles,instructions,r1b1,r10e,r2c2,r1c2 <cmd>`


### Runtimes

Runtime results comparing qemu, rv8 and native x86:

![benchmark runtimes -O3 64-bit]({{ site.url }}/plots/runtime-O3-64.svg)
_Figure 1: Benchmark runtimes -O3 64-bit_

**Runtime 64-bit -O3 (seconds)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 1.31 | 2.16 | 1.53 | 0.32
bigint | 1.38 | 1.08 | 0.71 | 0.38
dhrystone | 0.98 | 0.57 | 0.20 | 0.10
miniz | 2.66 | 2.21 | 1.60 | 0.77
norx | 0.60 | 1.17 | 1.20 | 0.22
primes | 2.09 | 1.26 | 0.70 | 0.60
qsort | 7.38 | 4.76 | 1.22 | 0.64
sha512 | 0.64 | 1.24 | 0.81 | 0.24
_(Sum)_ | 17.04 | 14.45 | 7.97 | 3.27

**Performance Ratio 64-bit -O3 (smaller is better)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 4.12 | 6.76 | 4.81 | 1.00
bigint | 3.62 | 2.83 | 1.85 | 1.00
dhrystone | 9.96 | 5.87 | 2.05 | 1.00
miniz | 3.46 | 2.86 | 2.07 | 1.00
norx | 2.73 | 5.33 | 5.47 | 1.00
primes | 3.49 | 2.11 | 1.17 | 1.00
qsort | 11.55 | 7.46 | 1.91 | 1.00
sha512 | 2.66 | 5.13 | 3.36 | 1.00
_(Geomean)_ | 4.44 | 4.39 | 2.51 | 1.00

![benchmark runtimes -Os 64-bit]({{ site.url }}/plots/runtime-Os-64.svg)
_Figure 2: Benchmark runtimes -Os 64-bit_

**Runtime 64-bit -Os (seconds)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 1.22 | 1.91 | 1.31 | 0.37
bigint | 1.60 | 1.40 | 2.85 | 0.38
dhrystone | 5.42 | 2.59 | 1.31 | 0.39
miniz | 2.74 | 2.24 | 1.73 | 0.83
norx | 1.58 | 1.53 | 1.14 | 0.24
primes | 1.97 | 1.23 | 0.77 | 0.59
qsort | 7.99 | 5.27 | 0.90 | 0.66
sha512 | 0.64 | 1.14 | 0.67 | 0.25
_(Sum)_ | 23.16 | 17.31 | 10.68 | 3.71

**Performance Ratio 64-bit -Os (smaller is better)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 3.29 | 5.16 | 3.53 | 1.00
bigint | 4.22 | 3.70 | 7.53 | 1.00
dhrystone | 13.97 | 6.66 | 3.38 | 1.00
miniz | 3.30 | 2.70 | 2.08 | 1.00
norx | 6.59 | 6.36 | 4.74 | 1.00
primes | 3.31 | 2.07 | 1.29 | 1.00
qsort | 12.20 | 8.05 | 1.38 | 1.00
sha512 | 2.56 | 4.58 | 2.69 | 1.00
_(Geomean)_ | 5.07 | 4.49 | 2.84 | 1.00

![benchmark runtimes -O3 32-bit]({{ site.url }}/plots/runtime-O3-32.svg)
_Figure 3: Benchmark runtimes -O3 32-bit_

**Runtime 32-bit -O3 (seconds)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 1.89 | 1.62 | 0.48
bigint | 1.37 | 1.41 | 0.88
dhrystone | 1.11 | 0.39 | 0.28
miniz | 2.17 | 1.41 | 0.88
norx | 0.77 | 0.85 | 0.26
primes | 2.34 | 1.95 | 1.51
qsort | 4.56 | 1.15 | 0.70
sha512 | 2.91 | 2.20 | 0.63
_(Sum)_ | 17.12 | 10.98 | 5.62

**Performance Ratio 32-bit -O3 (smaller is better)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 3.97 | 3.40 | 1.00
bigint | 1.56 | 1.61 | 1.00
dhrystone | 3.91 | 1.38 | 1.00
miniz | 2.47 | 1.61 | 1.00
norx | 2.96 | 3.27 | 1.00
primes | 1.55 | 1.29 | 1.00
qsort | 6.54 | 1.65 | 1.00
sha512 | 4.60 | 3.47 | 1.00
_(Geomean)_ | 3.09 | 2.03 | 1.00

![benchmark runtimes -Os 32-bit]({{ site.url }}/plots/runtime-Os-32.svg)
_Figure 4: Benchmark runtimes -Os 32-bit_

**Runtime 32-bit -Os (seconds)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 1.57 | 1.25 | 0.50
bigint | 1.80 | 3.21 | 1.02
dhrystone | 2.31 | 1.42 | 0.58
miniz | 2.20 | 1.56 | 1.26
norx | 1.18 | 1.18 | 0.32
primes | 2.20 | 2.73 | 1.38
qsort | 5.01 | 0.82 | 0.77
sha512 | 2.69 | 2.49 | 0.79
_(Sum)_ | 18.96 | 14.66 | 6.62

**Performance Ratio 32-bit -Os (smaller is better)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 3.15 | 2.50 | 1.00
bigint | 1.76 | 3.14 | 1.00
dhrystone | 4.00 | 2.45 | 1.00
miniz | 1.74 | 1.24 | 1.00
norx | 3.70 | 3.69 | 1.00
primes | 1.59 | 1.97 | 1.00
qsort | 6.47 | 1.06 | 1.00
sha512 | 3.41 | 3.16 | 1.00
_(Geomean)_ | 2.90 | 2.22 | 1.00


### Instructions Per Second

Instructions per second in millions comparing qemu, rv8 and native x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/mips-O3-64.svg)
_Figure 5: Millions of Instructions Per Second -O3 64-bit_

**Instructions per second (MIPS) qemu, rv8 and native 64-bit -O3**

program | qemu-riscv64-mips | rv8-riscv64-mips | native-x86-mips
:-- | --: | --: | --:
aes | 2414 | 3395 | 11035
bigint | 3738 | 5712 | 10557
dhrystone | 1843 | 5274 | 8369
miniz | 2625 | 3622 | 5530
norx | 2223 | 2167 | 9112
primes | 2438 | 4421 | 6100
qsort | 644 | 2518 | 5780
sha512 | 2982 | 4556 | 12177
_(Geomean)_ | 2149 | 3769 | 8232

![operation counts -Os 64-bit]({{ site.url }}/plots/mips-Os-64.svg)
_Figure 6: Millions of Instructions Per Second -Os 64-bit_

**Instructions per second (MIPS) qemu, rv8 and native 64-bit -Os**

program | qemu-riscv64-mips | rv8-riscv64-mips | native-x86-mips
:-- | --: | --: | --:
aes | 2655 | 3879 | 10072
bigint | 3973 | 1955 | 12873
dhrystone | 1250 | 2462 | 9073
miniz | 2650 | 3427 | 5052
norx | 1817 | 2439 | 8852
primes | 2226 | 3555 | 6101
qsort | 572 | 3340 | 6063
sha512 | 3269 | 5567 | 12206
_(Geomean)_ | 2008 | 3175 | 8355

![operation counts -O3 32-bit]({{ site.url }}/plots/mips-O3-32.svg)
_Figure 7: Millions of Instructions Per Second -O3 32-bit_

**Instructions per second (MIPS) qemu, rv8 and native 32-bit -O3**

program | qemu-riscv32-mips | rv8-riscv32-mips | native-x86-mips
:-- | --: | --: | --:
aes | 2442 | 2851 | 9634
bigint | 3964 | 3835 | 9780
dhrystone | 1998 | 5667 | 3747
miniz | 2195 | 3379 | 4988
norx | 2824 | 2554 | 9146
primes | 3039 | 3652 | 6368
qsort | 671 | 2658 | 6259
sha512 | 2773 | 3671 | 11074
_(Geomean)_ | 2259 | 3428 | 7186

![operation counts -Os 32-bit]({{ site.url }}/plots/mips-Os-32.svg)
_Figure 8: Millions of Instructions Per Second -Os 32-bit_

**Instructions per second (MIPS) qemu, rv8 and native 32-bit -Os**

program | qemu-riscv32-mips | rv8-riscv32-mips | native-x86-mips
:-- | --: | --: | --:
aes | 2832 | 3565 | 9472
bigint | 3856 | 2166 | 9817
dhrystone | 1435 | 2345 | 8479
miniz | 2177 | 3062 | 4171
norx | 1965 | 1970 | 8129
primes | 2928 | 2355 | 7105
qsort | 576 | 3528 | 5892
sha512 | 2901 | 3131 | 8396
_(Geomean)_ | 2063 | 2702 | 7441


### Macro-op Fusion

Runtimes and ratios for rv8 macro-op fusion (fusion=on,off):

![fusion runtimes and ratios 64-bit]({{ site.url }}/plots/fusion-64.svg)
_Figure 9: Fusion disabled and enabled runtimes -Os 64-bit_

**Macro-op fusion performance 64-bit -O3**

program | rv8-fuse-off-O3 | rv8-fuse-on-O3 | rv8-fuse-ratio-O3
:-- | --: | --: | --:
aes | 1.49 | 1.53 | 1.03
bigint | 0.71 | 0.71 | 1.00
dhrystone | 0.20 | 0.20 | 1.00
miniz | 1.69 | 1.60 | 0.94
norx | 1.15 | 1.20 | 1.04
primes | 0.72 | 0.70 | 0.97
qsort | 0.93 | 1.22 | 1.32
sha512 | 0.82 | 0.81 | 1.00
_(Geomean)_ | 0.83 | 0.86 | 1.03

**Macro-op fusion performance 64-bit -Os**

program | rv8-fuse-off-Os | rv8-fuse-on-Os | rv8-fuse-ratio-Os
:-- | --: | --: | --:
aes | 1.31 | 1.31 | 1.00
bigint | 2.85 | 2.85 | 1.00
dhrystone | 1.46 | 1.31 | 0.90
miniz | 1.90 | 1.73 | 0.91
norx | 1.33 | 1.14 | 0.86
primes | 0.78 | 0.77 | 0.99
qsort | 0.90 | 0.90 | 1.00
sha512 | 0.69 | 0.67 | 0.97
_(Geomean)_ | 1.27 | 1.21 | 0.95

![fusion runtimes and ratios 32-bit]({{ site.url }}/plots/fusion-32.svg)
_Figure 10: Fusion disabled and enabled runtimes -Os 32-bit_

**Macro-op fusion performance 32-bit -O3**

program | rv8-fuse-off-O3 | rv8-fuse-on-O3 | rv8-fuse-ratio-O3
:-- | --: | --: | --:
aes | 1.49 | 1.62 | 1.08
bigint | 1.41 | 1.41 | 1.00
dhrystone | 0.40 | 0.39 | 0.98
miniz | 1.35 | 1.41 | 1.05
norx | 0.80 | 0.85 | 1.07
primes | 1.98 | 1.95 | 0.99
qsort | 0.84 | 1.15 | 1.36
sha512 | 2.20 | 2.20 | 1.00
_(Geomean)_ | 1.16 | 1.23 | 1.06

**Macro-op fusion performance 32-bit -Os**

program | rv8-fuse-off-Os | rv8-fuse-on-Os | rv8-fuse-ratio-Os
:-- | --: | --: | --:
aes | 1.25 | 1.25 | 1.00
bigint | 3.21 | 3.21 | 1.00
dhrystone | 1.44 | 1.42 | 0.98
miniz | 1.56 | 1.56 | 1.00
norx | 1.18 | 1.18 | 1.00
primes | 2.75 | 2.73 | 0.99
qsort | 0.82 | 0.82 | 1.00
sha512 | 2.49 | 2.49 | 1.00
_(Geomean)_ | 1.67 | 1.66 | 1.00


### Retired Micro-ops

The following table describes the measured x86 performance counters:

counter       | x86 event mask              | description
:------------ | :-------------------------- | :-----------------------------------
instret       | `INST_RETIRED`              | instructions retired
uops-executed | `UOPS_EXECUTED.THREAD`      | uops executed
uops-issued   | `UOPS_ISSUED.ANY`           | uops issued
uops-slots    | `UOPS_RETIRED.RETIRE_SLOTS` | uop retirement slots used
uops-retired  | `UOPS_RETIRED.ANY`          | uops retired

Total retired micro-op/instruction counts comparing RISC-V and x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/operations-O3-64.svg)
_Figure 11: Retired operation counts -O3 64-bit_

**Retired Operations (Mops) x86-64 vs riscv64 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3520 | 3855 | 3455 | 4335 | 3442 | 5205
bigint | 4033 | 3927 | 4033 | 4355 | 4045 | 4044
dhrystone | 820 | 1131 | 860 | 1151 | 854 | 1060
miniz | 4264 | 4151 | 4224 | 4232 | 3832 | 5791
norx | 2005 | 1970 | 2029 | 2230 | 2002 | 2607
primes | 3642 | 3151 | 3855 | 3650 | 3653 | 3077
qsort | 3694 | 5052 | 4036 | 4897 | 3546 | 3067
sha512 | 2947 | 2623 | 3073 | 3264 | 3045 | 3704
_(Sum)_ | 24925 | 25860 | 25565 | 28114 | 24419 | 28555

![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-64.svg)
_Figure 12: Retired operation counts -Os 64-bit_

**Retired Operations (Mops) x86-64 vs riscv64 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3737 | 4323 | 3711 | 4789 | 3697 | 5081
bigint | 4879 | 4617 | 4593 | 4896 | 4595 | 5579
dhrystone | 3520 | 5401 | 4293 | 5540 | 4257 | 3230
miniz | 4193 | 4519 | 4251 | 4446 | 3875 | 5928
norx | 2124 | 2294 | 2177 | 2459 | 2148 | 2775
primes | 3624 | 3161 | 3793 | 3633 | 3629 | 2734
qsort | 3972 | 4932 | 4243 | 4897 | 3858 | 3016
sha512 | 3039 | 2750 | 3155 | 3359 | 3155 | 3730
_(Sum)_ | 29088 | 31997 | 30216 | 34019 | 29214 | 32073

![operation counts -O3 32-bit]({{ site.url }}/plots/operations-O3-32.svg)
_Figure 13: Retired operation counts -O3 32-bit_

**Retired Operations (Mops) x86-32 vs riscv32 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4586 | 5246 | 4590 | 5864 | 4573 | 4618
bigint | 8587 | 9909 | 9219 | 11659 | 9203 | 5418
dhrystone | 1060 | 3151 | 2651 | 3251 | 2631 | 2210
miniz | 4389 | 5253 | 4587 | 5024 | 4097 | 4775
norx | 2369 | 2380 | 2361 | 2683 | 2347 | 2166
primes | 9591 | 14598 | 11931 | 14999 | 11612 | 7115
qsort | 4362 | 7313 | 5934 | 6512 | 4975 | 3062
sha512 | 7010 | 6841 | 7074 | 8110 | 7056 | 8073
_(Sum)_ | 41954 | 54691 | 48347 | 58102 | 46494 | 37437

![operation counts -Os 32-bit]({{ site.url }}/plots/operations-Os-32.svg)
_Figure 14: Retired operation counts -Os 32-bit_

**Retired Operations (Mops) x86-32 vs riscv32 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4717 | 5756 | 4775 | 6063 | 4737 | 4446
bigint | 10033 | 11596 | 11049 | 13471 | 11033 | 6953
dhrystone | 4901 | 7398 | 5669 | 7591 | 5634 | 3320
miniz | 5256 | 6571 | 5568 | 6460 | 4983 | 4783
norx | 2601 | 3120 | 2675 | 3268 | 2641 | 2325
primes | 9834 | 10948 | 10661 | 12072 | 10429 | 6429
qsort | 4560 | 7633 | 6052 | 7033 | 5226 | 2886
sha512 | 6624 | 6830 | 6655 | 7639 | 6671 | 7796
_(Sum)_ | 48526 | 59852 | 53104 | 63597 | 51354 | 38938


### Executable File Sizes

GCC stripped executable sizes comparing aarch64, riscv32, riscv64, x86-32 and x86-64:

![benchmark filesizes -O3]({{ site.url }}/plots/filesize-O3.svg)
_Figure 15: Compiled file sizes -O3_

**Compiled File Size (bytes) -O3**

program | aarch64 | riscv32 | riscv64 | x86-32 | x86-64
:-- | --: | --: | --: | --: | --:
aes | 46400 | 54100 | 42280 | 41856 | 38192
bigint | 661792 | 571180 | 572440 | 669216 | 612736
dhrystone | 30032 | 37756 | 25968 | 25476 | 21816
miniz | 116272 | 103420 | 95800 | 132128 | 120368
norx | 42544 | 46064 | 34336 | 33824 | 30256
primes | 30016 | 33620 | 25896 | 21376 | 17712
qsort | 42304 | 37716 | 29992 | 33664 | 34096
sha512 | 30256 | 37872 | 26144 | 25632 | 22064
_(Sum)_ | 999616 | 921728 | 852856 | 983172 | 897240

![benchmark filesizes -Os]({{ site.url }}/plots/filesize-Os.svg)
_Figure 16: Compiled file sizes -Os_

**Compiled File Size (bytes) -Os**

program | aarch64 | riscv32 | riscv64 | x86-32 | x86-64
:-- | --: | --: | --: | --: | --:
aes | 46400 | 50004 | 42280 | 41856 | 38192
bigint | 641312 | 562988 | 564248 | 648736 | 592256
dhrystone | 30032 | 37756 | 25968 | 25520 | 21816
miniz | 87600 | 87036 | 75320 | 95264 | 83504
norx | 38448 | 41968 | 30240 | 29728 | 30256
primes | 30016 | 33620 | 25896 | 21376 | 17712
qsort | 30016 | 37716 | 25896 | 21376 | 21808
sha512 | 30256 | 37872 | 26144 | 25632 | 22064
_(Sum)_ | 934080 | 888960 | 815992 | 909488 | 827608


### Dynamic Register Usage

Dynamic register usage results comparing riscv64 -O3 vs -Os

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-1.svg)
_Figure 17: Dynamic register usage - aes -O3 vs -Os (sorted by frequency)_

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-2.svg)
_Figure 18: Dynamic register usage - aes -O3 vs -Os (sorted by alphabetically)_

![bigint register usage -O3 vs -Os]({{ site.url }}/plots/registers-bigint-rv64-1.svg)
_Figure 19: Dynamic register usage - bigint -O3 vs -Os (sorted by frequency)_

![bigint register usage -O3 vs -Os]({{ site.url }}/plots/registers-bigint-rv64-2.svg)
_Figure 20: Dynamic register usage - bigint -O3 vs -Os (sorted by alphabetically)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-1.svg)
_Figure 21: Dynamic register usage - dhrystone -O3 vs -Os (sorted by frequency)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-2.svg)
_Figure 22: Dynamic register usage - dhrystone -O3 vs -Os (sorted by alphabetically)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-1.svg)
_Figure 23: Dynamic register usage - miniz -O3 vs -Os (sorted by frequency)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-2.svg)
_Figure 24: Dynamic register usage - miniz -O3 vs -Os (sorted by alphabetically)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-1.svg)
_Figure 25: Dynamic register usage - norx -O3 vs -Os (sorted by frequency)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-2.svg)
_Figure 26: Dynamic register usage - norx -O3 vs -Os (sorted by alphabetically)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-1.svg)
_Figure 27: Dynamic register usage - primes -O3 vs -Os (sorted by frequency)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-2.svg)
_Figure 28: Dynamic register usage - primes -O3 vs -Os (sorted by alphabetically)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-1.svg)
_Figure 29: Dynamic register usage - qsort -O3 vs -Os (sorted by frequency)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-2.svg)
_Figure 30: Dynamic register usage - qsort -O3 vs -Os (sorted by alphabetically)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-1.svg)
_Figure 31: Dynamic register usage - sha512 -O3 vs -Os (sorted by frequency)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-2.svg)
_Figure 32: Dynamic register usage - sha512 -O3 vs -Os (sorted by alphabetically)_
