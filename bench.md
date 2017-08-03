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

**Runtime 64-bit -O3 (seconds)**

program | qemu-rv64 | jit-rv64 | native
:-- | --: | --: | --:
aes | 2.053  | 1.671 | 0.501
dhrystone | 1.245  | 0.583 | 0.355
miniz | 2.207  | 1.432 | 0.904
norx | 0.958  | 1.07 | 0.306
primes | 2.744  | 2.342 | 1.65
qsort | 5.129  | 1.203 | 0.749
sha512 | 3.183  | 2.274 | 0.671
Sum | 17.519  | 10.575 | 5.136

**Performance Ratio 64-bit -O3 (smaller is better)**

program | qemu-rv64 | jit-rv64 | native
:-- | --: | --: | --:
aes | 4.098 | 3.335 | 1 
dhrystone | 3.507 | 1.642 | 1 
miniz | 2.441 | 1.584 | 1 
norx | 3.131 | 3.497 | 1 
primes | 1.663 | 1.419 | 1 
qsort | 6.848 | 1.606 | 1 
sha512 | 4.744 | 3.389 | 1 
Geomean | 3.46 | 2.18 | 1 

![benchmark runtimes -Os 64-bit]({{ site.url }}/plots/runtime-Os-64.svg)
_Benchmark runtimes -Os 64-bit_

**Runtime 64-bit -Os (seconds)**

program | qemu-rv64 | jit-rv64 | native
:-- | --: | --: | --:
aes | 1.704 | 1.322 | 0.536 
dhrystone | 3.096 | 2.266 | 0.989 
miniz | 2.227 | 1.581 | 1.269 
norx | 1.314 | 1.264 | 0.373 
primes | 3.017 | 2.886 | 1.652 
qsort | 5.566 | 0.859 | 0.801 
sha512 | 2.96 | 2.588 | 0.814 
Sum | 19.884 | 12.766 | 6.434 

**Performance Ratio 64-bit -Os (smaller is better)**

program | qemu-rv64 | jit-rv64 | native
:-- | --: | --: | --:
aes | 3.179 | 2.466 | 1
dhrystone | 3.13 | 2.291 | 1
miniz | 1.755 | 1.246 | 1
norx | 3.523 | 3.389 | 1
primes | 1.826 | 1.747 | 1
qsort | 6.949 | 1.072 | 1
sha512 | 3.636 | 3.179 | 1
Geomean | 3.114 | 2.03 | 1

![benchmark runtimes -O3 32-bit]({{ site.url }}/plots/runtime-O3-32.svg)
_Benchmark runtimes -O3 32-bit_

**Runtime 32-bit -O3 (seconds)**

program | qemu-rv64 | qemu-arm64 | rv-jit | native
:-- | --: | --: | --: | --:
aes | 2.27 | 1.358 | 1.608 | 0.34
dhrystone | 0.774 | 1.678 | 0.22 | 0.122
miniz | 2.256 | 2.736 | 1.646 | 0.774
norx | 1.47 | 0.944 | 1.263 | 0.253
primes | 1.733 | 2.458 | 0.79 | 0.624
qsort | 4.996 | 7.683 | 1.26 | 0.668
sha512 | 1.374 | 0.693 | 0.868 | 0.295
Sum | 14.873 | 17.55 | 7.655 | 3.076

**Performance Ratio 32-bit -O3 (smaller is better)**

program | qemu-rv64 | qemu-arm64 | rv-jit | native
:-- | --: | --: | --: | --:
aes | 6.676 | 3.994 | 4.729 | 1
dhrystone | 6.344 | 13.754 | 1.803 | 1
miniz | 2.915 | 3.535 | 2.127 | 1
norx | 5.81 | 3.731 | 4.992 | 1
primes | 2.777 | 3.939 | 1.266 | 1
qsort | 7.479 | 11.501 | 1.886 | 1
sha512 | 4.658 | 2.349 | 2.942 | 1
Geomean | 4.916 | 4.991 | 2.515 | 1

![benchmark runtimes -Os 32-bit]({{ site.url }}/plots/runtime-Os-32.svg)
_Benchmark runtimes -Os 32-bit_

**Runtime 32-bit -Os (seconds)**

program | qemu-rv64 | qemu-arm64 | rv-jit | native
:-- | --: | --: | --: | --:
aes | 2.081 | 1.258 | 1.364 | 0.384
dhrystone | 2.839 | 6.174 | 1.648 | 0.577
miniz | 2.288 | 2.802 | 1.798 | 0.836
norx | 1.864 | 1.861 | 1.163 | 0.307
primes | 1.276 | 2.527 | 1.019 | 0.944
qsort | 5.624 | 8.352 | 0.938 | 0.675
sha512 | 1.206 | 0.688 | 0.697 | 0.267
Sum | 17.178 | 23.662 | 8.627 | 3.99

**Performance Ratio 32-bit -Os (smaller is better)**

program | qemu-rv64 | qemu-arm64 | rv-jit | native
:-- | --: | --: | --: | --:
aes | 5.419 | 3.276 | 3.552 | 1
dhrystone | 4.92 | 10.7 | 2.856 | 1
miniz | 2.737 | 3.352 | 2.151 | 1
norx | 6.072 | 6.062 | 3.788 | 1
primes | 1.352 | 2.677 | 1.079 | 1
qsort | 8.332 | 12.373 | 1.39 | 1
sha512 | 4.517 | 2.577 | 2.61 | 1
Geomean | 4.187 | 4.824 | 2.283 | 1


### [File Sizes](#file-sizes)

GCC filesize results comparing aarch64, riscv32, riscv64, x86-32 and x86-64:

![benchmark filesizes -O3]({{ site.url }}/plots/filesize-O3.svg)
_Compiled file sizes -O3_

**Compiled File Size -O3**

program | aarch64 | riscv32 | riscv64 | x86-32 | x86-64
:-- | --: | --: | --: | --: | --:
aes | 55392 | 59436 | 49144 | 47824 | 44624
dhrystone | 38440 | 42520 | 32128 | 31008 | 27680
miniz | 135544 | 116428 | 112024 | 147384 | 136288
norx | 51976 | 51492 | 41320 | 39884 | 36808
primes | 37336 | 37792 | 31264 | 26200 | 22688
qsort | 49712 | 41932 | 35424 | 38536 | 39128
sha512 | 38264 | 42380 | 31944 | 30804 | 27432
Sum | 406664 | 391980 | 333248 | 361640 | 334648

![benchmark filesizes -Os]({{ site.url }}/plots/filesize-Os.svg)
_Compiled file sizes -Os_

**Compiled File Size -O3**

program | aarch64 | riscv32 | riscv64 | x86-32 | x86-64
:-- | --: | --: | --: | --: | --:
aes | 55368 | 55340 | 49144 | 47824 | 44624
dhrystone | 38528 | 42584 | 32216 | 31132 | 27768
miniz | 106632 | 99956 | 91392 | 110268 | 99168
norx | 48016 | 47540 | 37416 | 35932 | 37000
primes | 37312 | 37792 | 31264 | 26200 | 22688
qsort | 37456 | 41980 | 31384 | 26292 | 26904
sha512 | 38240 | 42380 | 31944 | 30764 | 27432
Sum | 361552 | 367572 | 304760 | 308412 | 285584


### [Dynamic Micro-ops](#dynamic-micro-ops)

Dynamic micro-op/instruction counts comparing RISC-V and x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/operations-O3-64.svg)
_Dynamic operation counts -O3 64-bit_

**Dynamic Operations (Mops) x86-64 vs riscv64 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3536 | 3852 | 3443 | 4395 | 3434 | 5205
dhrystone | 821 | 1135 | 865 | 1150 | 839 | 1060
miniz | 4260 | 4155 | 4231 | 4233 | 3818 | 5791
norx | 2050 | 1981 | 2006 | 2217 | 2004 | 2607
primes | 3647 | 3166 | 3817 | 3660 | 3655 | 3077
qsort | 3734 | 5122 | 4055 | 4875 | 3564 | 3067
sha512 | 2936 | 2637 | 3090 | 3205 | 3057 | 3704
Geomean | 2688 | 2853 | 2756 | 3094 | 2633 | 3125

![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-64.svg)
_Dynamic operation counts -Os 64-bit_

**Dynamic Operations (Mops) x86-64 vs riscv64 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3705 | 4329 | 3746 | 4789 | 3703 | 5081
dhrystone | 3525 | 5415 | 4297 | 5525 | 4288 | 3230
miniz | 4175 | 4509 | 4260 | 4447 | 3869 | 5928
norx | 2148 | 2285 | 2174 | 2450 | 2163 | 2775
primes | 3652 | 3124 | 3697 | 3644 | 3631 | 2734
qsort | 3978 | 4906 | 4239 | 4941 | 3862 | 3016
sha512 | 3029 | 2766 | 3175 | 3351 | 3111 | 3730
Geomean | 3391 | 3740 | 3572 | 4034 | 3448 | 3630

![operation counts -O3 32-bit]({{ site.url }}/plots/operations-O3-32.svg)
_Dynamic operation counts -O3 32-bit_

**Dynamic Operations (Mops) x86-32 vs riscv32 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4581 | 5250 | 4615 | 5878 | 4576 | 4618
dhrystone | 1059 | 3177 | 2645 | 3253 | 2636 | 2210
miniz | 4393 | 5251 | 4588 | 5027 | 4098 | 4775
norx | 2358 | 2381 | 2372 | 2685 | 2350 | 2166
primes | 9602 | 14560 | 11938 | 14999 | 11615 | 7115
qsort | 4363 | 7272 | 5933 | 6531 | 5007 | 3062
sha512 | 7012 | 6848 | 7077 | 8100 | 7056 | 8073
Geomean | 3941 | 5495 | 4887 | 5738 | 4659 | 4072

![operation counts -Os 32-bit]({{ site.url }}/plots/operations-Os-32.svg)
_Dynamic operation counts -Os 32-bit_

**Dynamic Operations (Mops) x86-32 vs riscv32 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4712 | 5769 | 4765 | 6095 | 4723 | 4446
dhrystone | 4902 | 7426 | 5651 | 7570 | 5627 | 3320
miniz | 5218 | 6545 | 5567 | 6497 | 5016 | 4783
norx | 2611 | 3127 | 2676 | 3257 | 2639 | 2325
primes | 9826 | 10941 | 10628 | 12071 | 10444 | 6429
qsort | 4570 | 7644 | 6049 | 7057 | 5202 | 2886
sha512 | 6628 | 6837 | 6669 | 7633 | 6666 | 7796
Geomean | 5131 | 6521 | 5597 | 6745 | 5362 | 4218


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
