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

**Dynamic Operations x86-64 vs riscv64 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3536413272 | 3852274872 | 3443220487 | 4394664098 | 3433525309 | 5205137133
dhrystone | 821398309 | 1134628004 | 865182588 | 1150398521 | 838550035 | 1060005060
miniz | 4259857474 | 4155115377 | 4230911613 | 4233270708 | 3817672309 | 5791349634
norx | 2049734087 | 1981045052 | 2005869278 | 2217352824 | 2004204597 | 2607471070
primes | 3646623104 | 3165502415 | 3817247831 | 3659647396 | 3655366469 | 3076799886
qsort | 3734236952 | 5122409808 | 4055209159 | 4874558603 | 3563745833 | 3067191244
sha512 | 2936155317 | 2637181374 | 3089777165 | 3204709500 | 3056521326 | 3704064307
Sum | 20984418515 | 22048156902 | 21507418121 | 23734601650 | 20369585878 | 24512018334

![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-64.svg)
_Dynamic operation counts -Os 64-bit_

**Dynamic Operations x86-64 vs riscv64 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv64-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 3704695634 | 4329077514 | 3746208399 | 4788749285 | 3702954168 | 5081405284
dhrystone | 3524761650 | 5415213899 | 4297094079 | 5524913645 | 4287815964 | 3230005170
miniz | 4175483946 | 4508789005 | 4259771053 | 4447454486 | 3869326779 | 5928013101
norx | 2148457767 | 2284782904 | 2173645351 | 2449584169 | 2163012944 | 2775243702
primes | 3651534355 | 3124056312 | 3697246977 | 3643722440 | 3630883943 | 2734036234
qsort | 3978163379 | 4906392231 | 4238745450 | 4941294092 | 3862189257 | 3016075410
sha512 | 3029282174 | 2766360894 | 3174961703 | 3350994358 | 3111417800 | 3729564421
Sum | 24212378905 | 27334672759 | 25587673012 | 29146712475 | 24627600855 | 26494343322

![operation counts -O3 32-bit]({{ site.url }}/plots/operations-O3-32.svg)
_Dynamic operation counts -O3 32-bit_

**Dynamic Operations x86-32 vs riscv32 -O3**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4581479236 | 5249717929 | 4615361874 | 5877532977 | 4576436022 | 4617934394
dhrystone | 1059415824 | 3176523800 | 2645352585 | 3252978447 | 2635947092 | 2210005010
miniz | 4393381381 | 5250906340 | 4587714814 | 5026951458 | 4098338337 | 4774852136
norx | 2358188419 | 2381308119 | 2371895087 | 2684978010 | 2350439970 | 2165669277
primes | 9601938959 | 14560366971 | 11938282491 | 14998935654 | 11614863192 | 7114987439
qsort | 4363337035 | 7272347482 | 5932844294 | 6530712492 | 5006837360 | 3061610570
sha512 | 7012495640 | 6847562414 | 7077448609 | 8099845147 | 7056036595 | 8073074452
Sum | 33370236494 | 44738733055 | 39168899754 | 46471934185 | 37338898568 | 32018133278

![operation counts -Os 32-bit]({{ site.url }}/plots/operations-Os-32.svg)
_Dynamic operation counts -Os 32-bit_

**Dynamic Operations x86-32 vs riscv32 -Os**

program | x86-instret | x86-uops-executed | x86-uops-issued | x86-uops-retired | x86-uops-slots | riscv32-instret
:-- | --: | --: | --: | --: | --: | --:
aes | 4712060776 | 5768736563 | 4765413336 | 6094724121 | 4722966775 | 4445968109
dhrystone | 4902381499 | 7426175159 | 5650645714 | 7570037573 | 5627294493 | 3320005051
miniz | 5217804158 | 6544718172 | 5566781899 | 6496703542 | 5015791468 | 4783428209
norx | 2610530667 | 3127158532 | 2675620804 | 3256960555 | 2638689361 | 2325053087
primes | 9825610736 | 10940994552 | 10628426950 | 12071102162 | 10444000339 | 6429459543
qsort | 4570391471 | 7644009639 | 6049248195 | 7056976412 | 5201948896 | 2885718247
sha512 | 6627583019 | 6836570930 | 6669178380 | 7632754063 | 6666379065 | 7796073890
Sum | 38466362326 | 48288363547 | 42005315278 | 50179258428 | 40317070397 | 31985706136


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
