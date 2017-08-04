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

Runtime results comparing qemu, rv8 and native x86:

![benchmark runtimes -O3 64-bit]({{ site.url }}/plots/runtime-O3-64.svg)
_Figure 1: Benchmark runtimes -O3 64-bit_

**Runtime 64-bit -O3 (seconds)**

program | qemu-rv64 | qemu-arm64 | rv8-rv64 | x86-64
:-- | --: | --: | --: | --:
aes | 2.24 | 1.349 | 1.576 | 0.324
dhrystone | 0.593 | 0.998 | 0.206 | 0.101
miniz | 2.248 | 2.723 | 1.614 | 0.771
norx | 1.207 | 0.615 | 1.227 | 0.221
primes | 1.279 | 2.166 | 0.716 | 0.573
qsort | 4.948 | 7.646 | 1.256 | 0.657
sha512 | 1.282 | 0.663 | 0.835 | 0.245
_(Sum)_ | 13.797 | 16.16 | 7.43 | 2.892

**Performance Ratio 64-bit -O3 (smaller is better)**

program | qemu-rv64 | qemu-arm64 | rv8-rv64 | x86-64
:-- | --: | --: | --: | --:
aes | 6.914 | 4.164 | 4.864 | 1
dhrystone | 5.871 | 9.881 | 2.04 | 1
miniz | 2.916 | 3.532 | 2.093 | 1
norx | 5.462 | 2.783 | 5.552 | 1
primes | 2.232 | 3.78 | 1.25 | 1
qsort | 7.531 | 11.638 | 1.912 | 1
sha512 | 5.233 | 2.706 | 3.408 | 1
_(Geomean)_ | 4.778 | 4.666 | 2.659 | 1

![benchmark runtimes -Os 64-bit]({{ site.url }}/plots/runtime-Os-64.svg)
_Figure 2: Benchmark runtimes -Os 64-bit_

**Runtime 64-bit -Os (seconds)**

program | qemu-rv64 | qemu-arm64 | rv8-rv64 | x86-64
:-- | --: | --: | --: | --:
aes | 2.007 | 1.253 | 1.337 | 0.375
dhrystone | 2.692 | 5.603 | 1.325 | 0.402
miniz | 2.281 | 2.795 | 1.765 | 0.83
norx | 1.58 | 1.624 | 1.152 | 0.243
primes | 1.239 | 2.075 | 0.801 | 0.584
qsort | 5.484 | 8.223 | 0.929 | 0.672
sha512 | 1.177 | 0.659 | 0.686 | 0.252
_(Sum)_ | 16.46 | 22.232 | 7.995 | 3.358

**Performance Ratio 64-bit -Os (smaller is better)**

program | qemu-rv64 | qemu-arm64 | rv8-rv64 | x86-64
:-- | --: | --: | --: | --:
aes | 5.352 | 3.341 | 3.565 | 1
dhrystone | 6.697 | 13.938 | 3.296 | 1
miniz | 2.748 | 3.367 | 2.127 | 1
norx | 6.502 | 6.683 | 4.741 | 1
primes | 2.122 | 3.553 | 1.372 | 1
qsort | 8.161 | 12.237 | 1.382 | 1
sha512 | 4.671 | 2.615 | 2.722 | 1
_(Geomean)_ | 4.715 | 5.311 | 2.501 | 1

![benchmark runtimes -O3 32-bit]({{ site.url }}/plots/runtime-O3-32.svg)
_Figure 3: Benchmark runtimes -O3 32-bit_

**Runtime 32-bit -O3 (seconds)**

program | qemu-rv32 | rv8-rv32 | x86-32
:-- | --: | --: | --:
aes | 1.957  | 1.658 | 0.482
dhrystone | 1.149  | 0.399 | 0.298
miniz | 2.201  | 1.417 | 0.881
norx | 0.786  | 0.867 | 0.263
primes | 2.383  | 2.026 | 1.545
qsort | 4.734  | 1.18 | 0.719
sha512 | 2.998  | 2.243 | 0.648
_(Sum)_ | 16.208  | 9.79 | 4.836

**Performance Ratio 32-bit -O3 (smaller is better)**

program | qemu-rv32 | rv8-rv32 | x86-32
:-- | --: | --: | --:
aes | 4.06 | 3.44 | 1 
dhrystone | 3.856 | 1.339 | 1 
miniz | 2.498 | 1.608 | 1 
norx | 2.989 | 3.297 | 1 
primes | 1.542 | 1.311 | 1 
qsort | 6.584 | 1.641 | 1 
sha512 | 4.627 | 3.461 | 1 
_(Geomean)_ | 3.422 | 2.103 | 1 

![benchmark runtimes -Os 32-bit]({{ site.url }}/plots/runtime-Os-32.svg)
_Figure 4: Benchmark runtimes -Os 32-bit_

**Runtime 32-bit -Os (seconds)**

program | qemu-rv32 | rv8-rv32 | x86-32
:-- | --: | --: | --:
aes | 1.626 | 1.272 | 0.506 
dhrystone | 2.399 | 1.444 | 0.597 
miniz | 2.218 | 1.571 | 1.26 
norx | 1.218 | 1.194 | 0.325 
primes | 2.239 | 2.76 | 1.409 
qsort | 5.196 | 0.842 | 0.799 
sha512 | 2.757 | 2.545 | 0.8 
_(Sum)_ | 17.653 | 11.628 | 5.696 

**Performance Ratio 32-bit -Os (smaller is better)**

program | qemu-rv32 | rv8-rv32 | x86-32
:-- | --: | --: | --:
aes | 3.213 | 2.514 | 1
dhrystone | 4.018 | 2.419 | 1
miniz | 1.76 | 1.247 | 1
norx | 3.748 | 3.674 | 1
primes | 1.589 | 1.959 | 1
qsort | 6.503 | 1.054 | 1
sha512 | 3.446 | 3.181 | 1
_(Geomean)_ | 3.143 | 2.105 | 1


### [File Sizes](#file-sizes)

GCC filesize results comparing aarch64, riscv32, riscv64, x86-32 and x86-64:

![benchmark filesizes -O3]({{ site.url }}/plots/filesize-O3.svg)
_Figure 5: Compiled file sizes -O3_

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
_Figure 6: Compiled file sizes -Os_

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


### [Dynamic Micro-ops](#dynamic-micro-ops)

Dynamic micro-op/instruction counts comparing RISC-V and x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/operations-O3-64.svg)
_Figure 7: Dynamic operation counts -O3 64-bit_

**Dynamic Operations (Mops) x86-64 vs riscv64 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3539 | 3851 | 3444 | 4398 | 3431 | 5205
dhrystone | 820 | 1130 | 861 | 1132 | 860 | 1060
miniz | 4263 | 4154 | 4234 | 4230 | 3824 | 5791
norx | 2010 | 1971 | 2010 | 2232 | 2000 | 2607
primes | 3646 | 3149 | 3818 | 3661 | 3659 | 3077
qsort | 3717 | 5077 | 4032 | 4866 | 3590 | 3067
sha512 | 2946 | 2623 | 3072 | 3261 | 3012 | 3704
_(Geomean)_ | 2680 | 2841 | 2751 | 3097 | 2640 | 3125

![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-64.svg)
_Figure 8: Dynamic operation counts -Os 64-bit_

**Dynamic Operations (Mops) x86-64 vs riscv64 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3764 | 4325 | 3722 | 4797 | 3688 | 5081
dhrystone | 3518 | 5386 | 4290 | 5537 | 4288 | 3230
miniz | 4186 | 4523 | 4249 | 4445 | 3876 | 5928
norx | 2129 | 2264 | 2195 | 2464 | 2148 | 2775
primes | 3645 | 3153 | 3798 | 3610 | 3625 | 2734
qsort | 3954 | 4920 | 4226 | 4938 | 3877 | 3016
sha512 | 3039 | 2751 | 3157 | 3361 | 3155 | 3730
_(Geomean)_ | 3392 | 3737 | 3581 | 4036 | 3452 | 3630

![operation counts -O3 32-bit]({{ site.url }}/plots/operations-O3-32.svg)
_Figure 9: Dynamic operation counts -O3 32-bit_

**Dynamic Operations (Mops) x86-32 vs riscv32 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4580 | 5258 | 4611 | 5862 | 4570 | 4618
dhrystone | 1059 | 3237 | 2720 | 3254 | 2632 | 2210
miniz | 4389 | 5245 | 4589 | 5041 | 4100 | 4775
norx | 2364 | 2403 | 2351 | 2692 | 2351 | 2166
primes | 9616 | 14605 | 11941 | 15008 | 11590 | 7115
qsort | 4358 | 7309 | 5942 | 6560 | 4943 | 3062
sha512 | 7011 | 6845 | 7047 | 8110 | 7061 | 8073
_(Geomean)_ | 3942 | 5523 | 4898 | 5746 | 4648 | 4072

![operation counts -Os 32-bit]({{ site.url }}/plots/operations-Os-32.svg)
_Figure 10: Dynamic operation counts -Os 32-bit_

**Dynamic Operations (Mops) x86-32 vs riscv32 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4714 | 5773 | 4744 | 6092 | 4739 | 4446
dhrystone | 4902 | 7401 | 5658 | 7595 | 5641 | 3320
miniz | 5251 | 6568 | 5567 | 6479 | 4999 | 4783
norx | 2599 | 3123 | 2677 | 3249 | 2641 | 2325
primes | 9832 | 10949 | 10679 | 12058 | 10427 | 6429
qsort | 4565 | 7643 | 6065 | 7030 | 5191 | 2886
sha512 | 6623 | 6833 | 6669 | 7641 | 6673 | 7796
_(Geomean)_ | 5132 | 6520 | 5600 | 6738 | 5362 | 4218


### [Dynamic Register Usage](#dynamic-register-usage)

Dynamic register usage results comparing riscv64 -O3 vs -Os

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-1.svg)
_Figure 11: Dynamic register usage - aes -O3 vs -Os (sorted by frequency)_

![aes register usage -O3 vs -Os]({{ site.url }}/plots/registers-aes-rv64-2.svg)
_Figure 12: Dynamic register usage - aes -O3 vs -Os (sorted by alphabetically)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-1.svg)
_Figure 13: Dynamic register usage - dhrystone -O3 vs -Os (sorted by frequency)_

![dhrystone register usage -O3 vs -Os]({{ site.url }}/plots/registers-dhrystone-rv64-2.svg)
_Figure 14: Dynamic register usage - dhrystone -O3 vs -Os (sorted by alphabetically)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-1.svg)
_Figure 15: Dynamic register usage - miniz -O3 vs -Os (sorted by frequency)_

![miniz register usage -O3 vs -Os]({{ site.url }}/plots/registers-miniz-rv64-2.svg)
_Figure 16: Dynamic register usage - miniz -O3 vs -Os (sorted by alphabetically)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-1.svg)
_Figure 17: Dynamic register usage - norx -O3 vs -Os (sorted by frequency)_

![norx register usage -O3 vs -Os]({{ site.url }}/plots/registers-norx-rv64-2.svg)
_Figure 18: Dynamic register usage - norx -O3 vs -Os (sorted by alphabetically)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-1.svg)
_Figure 19: Dynamic register usage - primes -O3 vs -Os (sorted by frequency)_

![primes register usage -O3 vs -Os]({{ site.url }}/plots/registers-primes-rv64-2.svg)
_Figure 20: Dynamic register usage - primes -O3 vs -Os (sorted by alphabetically)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-1.svg)
_Figure 21: Dynamic register usage - qsort -O3 vs -Os (sorted by frequency)_

![qsort register usage -O3 vs -Os]({{ site.url }}/plots/registers-qsort-rv64-2.svg)
_Figure 22: Dynamic register usage - qsort -O3 vs -Os (sorted by alphabetically)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-1.svg)
_Figure 23: Dynamic register usage - sha512 -O3 vs -Os (sorted by frequency)_

![sha512 register usage -O3 vs -Os]({{ site.url }}/plots/registers-sha512-rv64-2.svg)
_Figure 24: Dynamic register usage - sha512 -O3 vs -Os (sorted by alphabetically)_