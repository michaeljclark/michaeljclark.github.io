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
- [Instructions Per Second](#instructions-per-second)
- [Macro-op Fusion](#macro-op-fusion)
- [Retired Micro-ops](#retired-micro-ops)
- [Executable File Sizes](#executable-file-sizes)
- [Dynamic Register Usage](#dynamic-register-usage)

**Compiler details**

Architecture | Compiler  | C Library | Compile options
:--          | :--       | :--       | :--
x86-32       | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
x86-64       | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
riscv32      | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
riscv64      | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`
aarch64      | GCC 7.1.0 | musl libc | `'-O3 -fPIE'`, `'-Os -fPIE'`

**Measurement details**

- Intel® 6th-gen Core™ i7-5557U Broadwell (3.10GHz, 3.40GHz Turbo, 4MB cache)
- x86-64 μops measured with
  - `perf stat -e cycles,instructions,r1b1,r10e,r2c2,r1c2 <cmd>`
- Benchmarks are run 20 times and the best result is taken


### Runtimes

Runtime results comparing qemu, rv8 and native x86:

![benchmark runtimes -O3 64-bit]({{ site.url }}/plots/runtime-O3-64.svg)
_Figure 1: Benchmark runtimes -O3 64-bit_

**Runtime 64-bit -O3 (seconds)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 1.31 | 2.16 | 1.53 | 0.32
dhrystone | 0.98 | 0.57 | 0.20 | 0.10
miniz | 2.66 | 2.21 | 1.60 | 0.77
norx | 0.60 | 1.17 | 1.20 | 0.22
primes | 2.09 | 1.26 | 0.70 | 0.60
qsort | 7.38 | 4.76 | 1.22 | 0.64
sha512 | 0.64 | 1.24 | 0.81 | 0.24
_(Sum)_ | 15.66 | 13.37 | 7.26 | 2.89

**Performance Ratio 64-bit -O3 (smaller is better)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 4.12 | 6.76 | 4.81 | 1.00
dhrystone | 9.96 | 5.87 | 2.05 | 1.00
miniz | 3.46 | 2.86 | 2.07 | 1.00
norx | 2.73 | 5.33 | 5.47 | 1.00
primes | 3.49 | 2.11 | 1.17 | 1.00
qsort | 11.55 | 7.46 | 1.91 | 1.00
sha512 | 2.66 | 5.13 | 3.36 | 1.00
_(Geomean)_ | 4.57 | 4.68 | 2.62 | 1.00

![benchmark runtimes -Os 64-bit]({{ site.url }}/plots/runtime-Os-64.svg)
_Figure 2: Benchmark runtimes -Os 64-bit_

**Runtime 64-bit -Os (seconds)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 1.22 | 1.91 | 1.31 | 0.37
dhrystone | 5.42 | 2.59 | 1.31 | 0.39
miniz | 2.74 | 2.24 | 1.73 | 0.83
norx | 1.58 | 1.53 | 1.14 | 0.24
primes | 1.97 | 1.23 | 0.77 | 0.59
qsort | 7.99 | 5.27 | 0.90 | 0.66
sha512 | 0.64 | 1.14 | 0.67 | 0.25
_(Sum)_ | 21.56 | 15.91 | 7.83 | 3.33

**Performance Ratio 64-bit -Os (smaller is better)**

program | qemu-aarch64 | qemu-riscv64 | rv8-riscv64 | native-x86-64
:-- | --: | --: | --: | --:
aes | 3.29 | 5.16 | 3.53 | 1.00
dhrystone | 13.97 | 6.66 | 3.38 | 1.00
miniz | 3.30 | 2.70 | 2.08 | 1.00
norx | 6.59 | 6.36 | 4.74 | 1.00
primes | 3.31 | 2.07 | 1.29 | 1.00
qsort | 12.20 | 8.05 | 1.38 | 1.00
sha512 | 2.56 | 4.58 | 2.69 | 1.00
_(Geomean)_ | 5.20 | 4.62 | 2.47 | 1.00

![benchmark runtimes -O3 32-bit]({{ site.url }}/plots/runtime-O3-32.svg)
_Figure 3: Benchmark runtimes -O3 32-bit_

**Runtime 32-bit -O3 (seconds)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 1.89 | 1.62 | 0.48
dhrystone | 1.11 | 0.39 | 0.28
miniz | 2.17 | 1.41 | 0.88
norx | 0.77 | 0.85 | 0.26
primes | 2.34 | 1.95 | 1.51
qsort | 4.56 | 1.15 | 0.70
sha512 | 2.91 | 2.20 | 0.63
_(Sum)_ | 15.75 | 9.57 | 4.74

**Performance Ratio 32-bit -O3 (smaller is better)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 3.97 | 3.40 | 1.00
dhrystone | 3.91 | 1.38 | 1.00
miniz | 2.47 | 1.61 | 1.00
norx | 2.96 | 3.27 | 1.00
primes | 1.55 | 1.29 | 1.00
qsort | 6.54 | 1.65 | 1.00
sha512 | 4.60 | 3.47 | 1.00
_(Geomean)_ | 3.40 | 2.10 | 1.00

![benchmark runtimes -Os 32-bit]({{ site.url }}/plots/runtime-Os-32.svg)
_Figure 4: Benchmark runtimes -Os 32-bit_

**Runtime 32-bit -Os (seconds)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 1.57 | 1.25 | 0.50
dhrystone | 2.31 | 1.42 | 0.58
miniz | 2.20 | 1.56 | 1.26
norx | 1.18 | 1.18 | 0.32
primes | 2.20 | 2.73 | 1.38
qsort | 5.01 | 0.82 | 0.77
sha512 | 2.69 | 2.49 | 0.79
_(Sum)_ | 17.16 | 11.45 | 5.60

**Performance Ratio 32-bit -Os (smaller is better)**

program | qemu-riscv32 | rv8-riscv32 | native-x86-32
:-- | --: | --: | --:
aes | 3.15 | 2.50 | 1.00
dhrystone | 4.00 | 2.45 | 1.00
miniz | 1.74 | 1.24 | 1.00
norx | 3.70 | 3.69 | 1.00
primes | 1.59 | 1.97 | 1.00
qsort | 6.47 | 1.06 | 1.00
sha512 | 3.41 | 3.16 | 1.00
_(Geomean)_ | 3.11 | 2.11 | 1.00


### Instructions Per Second

Instructions per second in millions comparing rv8 and native x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/mips-O3-64.svg)
_Figure 5: Millions of Instructions Per Second -O3 64-bit_

**Instructions per second (MIPS) native vs rv8 64-bit -O3**

program | native-x86-mips | rv8-riscv64-mips
:-- | --: | --:
aes | 11035 | 3395
dhrystone | 8369 | 5274
miniz | 5530 | 3622
norx | 9112 | 2167
primes | 6100 | 4421
qsort | 5780 | 2518
sha512 | 12177 | 4556
_(Geomean)_ | 7945 | 3552

![operation counts -Os 64-bit]({{ site.url }}/plots/mips-Os-64.svg)
_Figure 6: Millions of Instructions Per Second -Os 64-bit_

**Instructions per second (MIPS) native vs rv8 64-bit -Os**

program | native-x86-mips | rv8-riscv64-mips
:-- | --: | --:
aes | 10072 | 3879
dhrystone | 9073 | 2462
miniz | 5052 | 3427
norx | 8852 | 2439
primes | 6101 | 3555
qsort | 6063 | 3340
sha512 | 12206 | 5567
_(Geomean)_ | 7855 | 3402

![operation counts -O3 32-bit]({{ site.url }}/plots/mips-O3-32.svg)
_Figure 7: Millions of Instructions Per Second -O3 32-bit_

**Instructions per second (MIPS) native vs rv8 32-bit -O3**

program | native-x86-mips | rv8-riscv32-mips
:-- | --: | --:
aes | 9634 | 2851
dhrystone | 3747 | 5667
miniz | 4988 | 3379
norx | 9146 | 2554
primes | 6368 | 3652
qsort | 6259 | 2658
sha512 | 11074 | 3671
_(Geomean)_ | 6876 | 3373

![operation counts -Os 32-bit]({{ site.url }}/plots/mips-Os-32.svg)
_Figure 8: Millions of Instructions Per Second -Os 32-bit_

**Instructions per second (MIPS) native vs rv8 32-bit -Os**

program | native-x86-mips | rv8-riscv32-mips
:-- | --: | --:
aes | 9472 | 3565
dhrystone | 8479 | 2345
miniz | 4171 | 3062
norx | 8129 | 1970
primes | 7105 | 2355
qsort | 5892 | 3528
sha512 | 8396 | 3131
_(Geomean)_ | 7152 | 2789


### Macro-op Fusion

Runtimes and ratios for rv8 macro-op fusion (disabled and enabled):

![fusion runtimes and ratios 64-bit]({{ site.url }}/plots/fusion-64.svg)
_Figure 9: Fusion disabled and enabled runtimes -Os 64-bit_

**Macro-op fusion performance 64-bit -O3**

program | rv8-no-fuse-O3 | rv8-fuse-on-O3 | rv8-fuse-ratio-O3
:-- | --: | --: | --:
aes | 1.49 | 1.53 | 1.03
dhrystone | 0.20 | 0.20 | 1.00
miniz | 1.69 | 1.60 | 0.94
norx | 1.15 | 1.20 | 1.04
primes | 0.72 | 0.70 | 0.97
qsort | 0.93 | 1.22 | 1.32
sha512 | 0.82 | 0.81 | 1.00
_(Geomean)_ | 0.85 | 0.88 | 1.04

**Macro-op fusion performance 64-bit -Os**

program | rv8-no-fuse-Os | rv8-fuse-on-Os | rv8-fuse-ratio-Os
:-- | --: | --: | --:
aes | 1.31 | 1.31 | 1.00
dhrystone | 1.46 | 1.31 | 0.90
miniz | 1.90 | 1.73 | 0.91
norx | 1.33 | 1.14 | 0.86
primes | 0.78 | 0.77 | 0.99
qsort | 0.90 | 0.90 | 1.00
sha512 | 0.69 | 0.67 | 0.97
_(Geomean)_ | 1.13 | 1.07 | 0.95

![fusion runtimes and ratios 32-bit]({{ site.url }}/plots/fusion-32.svg)
_Figure 10: Fusion disabled and enabled runtimes -Os 32-bit_

**Macro-op fusion performance 32-bit -O3**

program | rv8-no-fuse-O3 | rv8-fuse-on-O3 | rv8-fuse-ratio-O3
:-- | --: | --: | --:
aes | 1.49 | 1.62 | 1.08
dhrystone | 0.40 | 0.39 | 0.98
miniz | 1.35 | 1.41 | 1.05
norx | 0.80 | 0.85 | 1.07
primes | 1.98 | 1.95 | 0.99
qsort | 0.84 | 1.15 | 1.36
sha512 | 2.20 | 2.20 | 1.00
_(Geomean)_ | 1.13 | 1.21 | 1.07

**Macro-op fusion performance 32-bit -Os**

program | rv8-no-fuse-Os | rv8-fuse-on-Os | rv8-fuse-ratio-Os
:-- | --: | --: | --:
aes | 1.25 | 1.25 | 1.00
dhrystone | 1.44 | 1.42 | 0.98
miniz | 1.56 | 1.56 | 1.00
norx | 1.18 | 1.18 | 1.00
primes | 2.75 | 2.73 | 0.99
qsort | 0.82 | 0.82 | 1.00
sha512 | 2.49 | 2.49 | 1.00
_(Geomean)_ | 1.52 | 1.51 | 1.00


### Retired Micro-ops

The following table describes the measured x86 performance counters:

Counter       | x86 event mask              | description
:------------ | :-------------------------- | :-----------------------------------
instret       | `INST_RETIRED`              | total number of instructions retired
uops-executed | `UOPS_EXECUTED.THREAD`      | uops executed _(unfused domain)_
uops-issued   | `UOPS_ISSUED.ANY`           | uops issued _(fused domain)_
uops-slots    | `UOPS_RETIRED.RETIRE_SLOTS` | uop retirement slots used _(fused domain)_
uops-retired  | `UOPS_RETIRED.ANY`          | uops retired _(unfused domain)_

Total retired micro-op/instruction counts comparing RISC-V and x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/operations-O3-64.svg)
_Figure 11: Retired operation counts -O3 64-bit_

**Retired Operations (Mops) x86-64 vs riscv64 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3520 | 3855 | 3455 | 4335 | 3442 | 5205
dhrystone | 820 | 1131 | 860 | 1151 | 854 | 1060
miniz | 4264 | 4151 | 4224 | 4232 | 3832 | 5791
norx | 2005 | 1970 | 2029 | 2230 | 2002 | 2607
primes | 3642 | 3151 | 3855 | 3650 | 3653 | 3077
qsort | 3694 | 5052 | 4036 | 4897 | 3546 | 3067
sha512 | 2947 | 2623 | 3073 | 3264 | 3045 | 3704
_(Sum)_ | 20892 | 21933 | 21532 | 23759 | 20374 | 24511

![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-64.svg)
_Figure 12: Retired operation counts -Os 64-bit_

**Retired Operations (Mops) x86-64 vs riscv64 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3737 | 4323 | 3711 | 4789 | 3697 | 5081
dhrystone | 3520 | 5401 | 4293 | 5540 | 4257 | 3230
miniz | 4193 | 4519 | 4251 | 4446 | 3875 | 5928
norx | 2124 | 2294 | 2177 | 2459 | 2148 | 2775
primes | 3624 | 3161 | 3793 | 3633 | 3629 | 2734
qsort | 3972 | 4932 | 4243 | 4897 | 3858 | 3016
sha512 | 3039 | 2750 | 3155 | 3359 | 3155 | 3730
_(Sum)_ | 24209 | 27380 | 25623 | 29123 | 24619 | 26494

![operation counts -O3 32-bit]({{ site.url }}/plots/operations-O3-32.svg)
_Figure 13: Retired operation counts -O3 32-bit_

**Retired Operations (Mops) x86-32 vs riscv32 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4586 | 5246 | 4590 | 5864 | 4573 | 4618
dhrystone | 1060 | 3151 | 2651 | 3251 | 2631 | 2210
miniz | 4389 | 5253 | 4587 | 5024 | 4097 | 4775
norx | 2369 | 2380 | 2361 | 2683 | 2347 | 2166
primes | 9591 | 14598 | 11931 | 14999 | 11612 | 7115
qsort | 4362 | 7313 | 5934 | 6512 | 4975 | 3062
sha512 | 7010 | 6841 | 7074 | 8110 | 7056 | 8073
_(Sum)_ | 33367 | 44782 | 39128 | 46443 | 37291 | 32019

![operation counts -Os 32-bit]({{ site.url }}/plots/operations-Os-32.svg)
_Figure 14: Retired operation counts -Os 32-bit_

**Retired Operations (Mops) x86-32 vs riscv32 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4717 | 5756 | 4775 | 6063 | 4737 | 4446
dhrystone | 4901 | 7398 | 5669 | 7591 | 5634 | 3320
miniz | 5256 | 6571 | 5568 | 6460 | 4983 | 4783
norx | 2601 | 3120 | 2675 | 3268 | 2641 | 2325
primes | 9834 | 10948 | 10661 | 12072 | 10429 | 6429
qsort | 4560 | 7633 | 6052 | 7033 | 5226 | 2886
sha512 | 6624 | 6830 | 6655 | 7639 | 6671 | 7796
_(Sum)_ | 38493 | 48256 | 42055 | 50126 | 40321 | 31985


### Executable File Sizes

GCC executable file sizes comparing aarch64, riscv32, riscv64, x86-32 and x86-64:

![benchmark filesizes -O3]({{ site.url }}/plots/filesize-O3.svg)
_Figure 15: Compiled file sizes -O3_

**Compiled File Size (bytes) -O3**

program | aarch64 | riscv32 | riscv64 | x86-32 | x86-64
:-- | --: | --: | --: | --: | --:
aes | 55392 | 59436 | 49144 | 47824 | 44624
dhrystone | 38440 | 42520 | 32128 | 31008 | 27680
miniz | 135544 | 116428 | 112024 | 147384 | 136288
norx | 51976 | 51492 | 41320 | 39884 | 36808
primes | 37336 | 37792 | 31264 | 26200 | 22688
qsort | 49712 | 41932 | 35424 | 38536 | 39128
sha512 | 38264 | 42380 | 31944 | 30804 | 27432
_(Sum)_ | 406664 | 391980 | 333248 | 361640 | 334648

![benchmark filesizes -Os]({{ site.url }}/plots/filesize-Os.svg)
_Figure 16: Compiled file sizes -Os_

**Compiled File Size (bytes) -O3**

program | aarch64 | riscv32 | riscv64 | x86-32 | x86-64
:-- | --: | --: | --: | --: | --:
aes | 55368 | 55340 | 49144 | 47824 | 44624
dhrystone | 38528 | 42584 | 32216 | 31132 | 27768
miniz | 106632 | 99956 | 91392 | 110268 | 99168
norx | 48016 | 47540 | 37416 | 35932 | 37000
primes | 37312 | 37792 | 31264 | 26200 | 22688
qsort | 37456 | 41980 | 31384 | 26292 | 26904
sha512 | 38240 | 42380 | 31944 | 30764 | 27432
_(Sum)_ | 361552 | 367572 | 304760 | 308412 | 285584


### Dynamic Register Usage

Dynamic register usage results comparing riscv64 -O3 vs -Os

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-1.svg)
_Figure 17: Dynamic register usage - aes -O3 vs -Os (sorted by frequency)_

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-2.svg)
_Figure 18: Dynamic register usage - aes -O3 vs -Os (sorted by alphabetically)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-1.svg)
_Figure 19: Dynamic register usage - dhrystone -O3 vs -Os (sorted by frequency)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-2.svg)
_Figure 20: Dynamic register usage - dhrystone -O3 vs -Os (sorted by alphabetically)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-1.svg)
_Figure 21: Dynamic register usage - miniz -O3 vs -Os (sorted by frequency)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-2.svg)
_Figure 22: Dynamic register usage - miniz -O3 vs -Os (sorted by alphabetically)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-1.svg)
_Figure 23: Dynamic register usage - norx -O3 vs -Os (sorted by frequency)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-2.svg)
_Figure 24: Dynamic register usage - norx -O3 vs -Os (sorted by alphabetically)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-1.svg)
_Figure 25: Dynamic register usage - primes -O3 vs -Os (sorted by frequency)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-2.svg)
_Figure 26: Dynamic register usage - primes -O3 vs -Os (sorted by alphabetically)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-1.svg)
_Figure 27: Dynamic register usage - qsort -O3 vs -Os (sorted by frequency)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-2.svg)
_Figure 28: Dynamic register usage - qsort -O3 vs -Os (sorted by alphabetically)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-1.svg)
_Figure 29: Dynamic register usage - sha512 -O3 vs -Os (sorted by frequency)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-2.svg)
_Figure 30: Dynamic register usage - sha512 -O3 vs -Os (sorted by alphabetically)_
