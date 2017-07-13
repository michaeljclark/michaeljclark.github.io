### [About](#about)

**rv8** is a RISC-V simulation suite comprising a high performance
x86-64 binary translator, a user mode simulator, a full system
emulator, an ELF binary analysis tool and ISA metadata:

> * **rv-jit** - _user mode x86-64 binary translator_
> * **rv-sim** - _user mode system call proxy simulator_
> * **rv-sys** - _full system emulator with soft MMU_
> * **rv-bin** - _ELF disassembler and histogram tool_
> * **rv-meta** - _code and documentation generator_

The rv8 simulator suite contains libraries and command line tools for
creating instruction opcode maps, C headers and source containing
instruction set metadata, instruction decoders, a JIT assembler,
LaTeX documentation, a metadata based RISC-V disassembler, a
histogram tool for generating statistics on RISC-V ELF executables,
a RISC-V proxy syscall simulator, a RISC-V full system emulator that
implements the RISC-V 1.9.1 privileged specification and an x86-64
binary translator.

The current version is available [here](https://github.com/rv8-io/rv8).

![rv8 binary translation]({{ site.url }}/images/bintrans.png)

_**RISC-V to x86-64 binary translator**_

The rv8 binary translation engine works by interpreting code while
profiling it for hot paths. Hot paths are translated on the fly to
native code. The translation engine maintains a call stack to allow
runtime inlining of hot functions. A jump target cache is used to
accelerate returns and indirect calls through function pointers.
The translator supports hybrid binary translation and interpretation
to handle instructions that do not have native translations.
Currently ‘IM’ code is translated and ‘AFD’ is interpreted. The
translator supports RVC compressed code.

The rv8 binary translator supports a number of simple optimisations:

- Hybrid interpretation and compilation of hot code paths
- Incremental translation with dynamic trace linking
- Inline caching of function calls in hot code paths
- L1 jump target cache for indirect calls and returns
- Macro-op fusion for common RISC-V instruction sequences

_**RISC-V full system emulator**_

The rv8 suite includes a full system emulator that implements the
RISC-V privileged ISA with support for interrupts, MMIO (memory
mapped input output) devices, a soft MMU (memory management unit)
with separate instruction and data TLBs (translation lookaside
buffers). The full system emulator has a simple integrated debugger
that allows setting breakpoints, single stepping and disassembling
instructions as they are executed.

The rv8 full system emulator has the following features:

- RISC-V IMAFD Base plus Privileged ISA (riscv32 and riscv64)
- Simple integrated debug command line interface
- Histograms (instruction and program counter frequency)
- Soft MMU supporting sv32, sv39, sv48 page translation modes
- Abstract MMIO device interface for device emulation
- Extensible interpreter generated from ISA metadata
- Protected address space

_**RISC-V user mode simulator**_

The rv8 user mode simulator is a single address space
implementation of the RISC-V ISA that implements the RISC-V
Linux syscall ABI (application binary interface) and delegates
system calls to the underlying native host operating system.
The user mode simulator can run RISC-V Linux binaries on non-Linux
operating systems via system call emulation. The current user mode
simulator implements a small number of system calls to allow
running RISC-V Linux ELF static binaries.

The rv8 user mode simulator has the following features:

- RISC-V IMAFD Base ISA (riscv32 and riscv64)
- Simple integrated debug command line interface
- A small set of emulated Linux system calls for simple file IO
- Extensible interpreter generated from ISA metadata
- Instruction logging mode for tracing program execution 
- Shared address space
  - `0x000000000000 - 0x000000000fff` (zero)
  - `0x000000001000 - 0x7ffdffffffff` (guest)
  - `0x7ffe00000000 - 0x7fffffffffff` (host)

_**RISC-V instruction set metadata**_

The `rv-meta` tool is able to generate opcode maps, instruction
decoders, source, headers and instruction set listing LaTeX
from ISA metadata. The following is an example of PDF output:

[![RISC-V Instruction Set Listing]({{ site.url }}/images/riscv-instructions.png)](https://github.com/rv8-io/rv8/blob/master/doc/pdf/riscv-instructions.pdf)

RISC-V isnstruction set metadata is available [here](https://github.com/rv8-io/rv8/blob/master/meta/).

---

### [Supported Platforms](#supported-platforms)

- Target
  - RV32IMAFDC
  - RV64IMAFDC
  - Privilged ISA 1.9.1
- Host
  - Linux (Debian 9.0 x86-64, Ubuntu 16.04 x86-64, Fedora 25 x86-64) _(stable)_
  - macOS (Sierra 10.11 x86-64) _(stable)_
  - FreeBSD (11 x86-64) _(alpha)_

---

### [Getting Started](#getting-started)

Please read the RISC-V toolchain installtion instructions in the
[riscv-gnu-toolchain](https://github.com/riscv/riscv-gnu-toolchain/)
repository.

_Building riscv-gnu-toolchain_

```
$ sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
$ git clone https://github.com/riscv/riscv-gnu-toolchain.git
$ cd riscv-gnu-toolchain
$ git submodule update --init --recursive
$ ./configure --prefix=/opt/riscv/toolchain
$ make
```

rv8 has minimum external dependencies besides a C++14 compiler,
the C++ standard libraries and the `asmjit` submodule.

- gcc-5.4 or clang-3.4 (Linux minimum)
- gcc-6.3 or clang-3.8 (Linux recommended)

_Building rv8_

```
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

```
$ cd rv8
$ export RISCV=/opt/riscv/toolchain
$ make test-build
$ make test-sim
$ make test-sys
$ rv-jit build/riscv64-unknown-elf/bin/test-dhrystone
```

---

### [Optimisations](#optimisations)

The rv8 binary translator performs JIT (Just In Time) translation
of RISC-V code to X86-64 code. This is a challenging problem for
many reasons; with the principle challange due to RISC-V having
31 integer registers while x86-64 has only 16 integer registers.

_Register allocation_

rv8 solves the register set size problem by spilling registers
to memory (L1 cache) using a static register allocation (a future
versions may use dynamic register allocation). A large amount of
performance is lost due to register allocations that take advantage
of the larger number of physically available registers with less
frequent stack spills. It is not possible for the translator to
rearrange memory and registers for optimal stack spills as memory
accesses must be translated precisely. The additional registers are
translated as x86-64 memory operands (which produce load and store
micro-ops) or in some circumstances, explicit `mov` instructions.

RV | |x86|  |RV | |x86|  |RV | |x86|  |RV | | x86
--:| |:--|  |--:| |:--|  |--:| |:--|  |--:| |:--
ra |→|rdx|  |t1 |→|rdi|  |a2 |→|r10|  |a5 |→| r13
sp |→|rbx|  |a0 |→|r8 |  |a3 |→|r11|  |a6 |→| r14
t0 |→|rsi|  |a1 |→|r9 |  |a4 |→|r12|  |a7 |→| r1

_Translator temporaries_

The rv8 binary translator needs to use a few host registers to
point to translator internal structures and for use as temporary
registers for the emulation of various instructions, for example
a store instructions require the use of two temporary registers
if both register operands are in the spill area. The translator
uses the following x86-64 host registers as temporaries leaving
12 registers available for mapping to RISC-V registers:

- `rbp` - pointer to the register spill area and jump target cache
- `rsp` - pointer to the host stack to allow procedure calls
- `rax` - translator temporary register
- `rcx` - translator temporary register

_Indirect call acceleration_

Indirect calls through function pointers cannot be statically
translated as the target address of their translation is not
known at the time of translation. rv8 employs a trace cache
which is a hashtable of guest program addresses to native code
addresses. A full trace cache lookup is relatively slow because
it requires saving caller-save registers and calling into C++
code. To accelerate indirect calls through function pointers,
a small assembly stub looks up the target address in a sparse
1024 entry direct mapped L1 translation cache, and falls back
to a slow translation cache miss path that saves registers and
calls into the translator code to populate the L1 translation
cache so that the next indirect call can be accelerated.

The cache is indexed by `bits[10:1]` of the guest address:

RV code | |x86 code      | |RV code | |x86 code
---     |-|---           |-|---     |-|---
0x10000 |→|0x7FFF0000f380| |        | |
        | |              | |        | |
        | |              | |0x2b086 |→|0x7FFF0003f480
0x1a808 |→|0x7FFF0001f580| |        | |
        | |              | |        | |
        | |              | |0x1708b |→|0x7FFF0002fa80

_Inline caching_

Returns also make use of the L1 translation cache, however any
procedure call that is made inside of a hot trace can be inlined
and to do so the translator maintains a call stack. Upon
reaching an inlined procedures `RET` (_jalr zero, ra_)
instruction, the link register is compared against the callers
kown return address and if it matches, control flow continues
along the return path. In the case that the function is not
inlined, the regular L1 translation cache is used to lookup
the address of the translated code.

_Branch tail linking_

The translator performs lazy translation of the source program
during tracing and when it reaches branches, it can only link
both sides of the branch if there exists an existing translation
for the not taken side of the branch. To accelerate _branch
tail exits_, the translator  emits a relative branch to a
trampoline function that returns to the tracer main loop and
adds the branch to a table of branch fixup addresses indexed
by target guest address. If the branch target is hot, after
if has been translated, all relative branches that point to
tail exit trampolines will be relinked to branch directly
to the translated native code.

_Macro-op fusion_

The rv8 translator implements an optimisation known as macro-op
fusion whereby specific patterns of adjacent instructions are
translated into a single host instruction. The macro-op fusion
pattern matcher has potential to increase performance further
with the addition of common patterns. The following is a list
of macro-op fusion patterns that rv8 currently implements:

- `AUIPC rs, imm20; ADDI rd, rs1, imm12;` (where `rd=rs1`)
  - PC-relative address is resolved using a single `MOV` instruction.
- `AUIPC t0, imm20; JALR ra, imm12(t0);` (where `rd=rs1`)
  - Target address is constructed using a single `MOV` instruction.
- `AUIPC ra, imm20; JALR ra, imm12(ra);` (where `rd=rs1`)
  - Target address register write is elided.
- `SLLI rd, rs1, 32; SRLI rd, rs1, 32` (where `rd=rs1`)
  - Fused into a single `MOVZX` instruction.
- `ADDIW rd, rs1, imm12; SLLI rd, rs1, 32; SRLI rd, rs1, 32`
  (where `rd=rs1`)
  - Fused into 32-bit zero extending `ADD` instruction.

_Sign extension versus zero extension_

In addition to the register allocation problem, rv8 has to make
sure that 32-bit operations on registers are sign extended instead
of zero-extended. The normal behaviour of 32-bit operations on
x86-64 is to zero extend bit 31 to bit 63. It may be possible
in a future version of the JIT translation engine to elide
redundant sign extension operations, however it is important
that the register state precisely matches before executing an
instruction that may cause a fault e.g. loads and stores.

_Bit manipulation intrinsics_

Finally the bencharks below contain digest algorithms and ciphers
which can take advantage of bit manipulation instructions such as
rotate and bswap. Present day compilers are sophisticated enough
to detetc rotate and byte swap logical operations and translate
them into x86-64 bit manipulation instructions (`ROR`, `ROL`,
`BSWAP`). RISC-V currently lacks bit manipulation instructions
however there are proposals to add them in the B extension.

- _Rotate right or left pattern (2 shifts, 1 and)_
  - `(rs1 >> shamt) | (rs1 << (64 - shamt))`
- _32-bit integer byteswap pattern (4 constants, 4 shifts, 4 ands, 3 ors)_
  - `((rs1 >> 24) & 0x000000ff) | ((rs1 << 8 ) & 0x00ff0000) |
    ((rs1 >> 8 ) & 0x0000ff00) | ((rs1 << 24) & 0xff000000)`

_Conclusion_

The combination of the register allocation problem, sign extension
and the lack of bit manipulation intrinsics account for a large
proportion of the difference in instruction count and performance
between native x86-64 code and translated RISC-V code.

---

### [Benchmarks](#benchmarks)

The following benchmarks show QEMU, rv8 binary translation
and native x86-64 runtimes:

![rv-jit benchmark]({{ site.url }}/images/bench-v8-runtime.svg)

_Runtime (seconds)_

program         | rv8-sim | rv8-jit | qemu-user | native
---             | --:     | --:     | --:       | --:
primes          |  5.07   | 0.16    | 0.27      | 0.11
miniz           | 41.52   | 1.67    | 2.20      | 0.76
norx            | 22.51   | 1.10    | 1.44      | 0.21
SHA-512         | 23.69   | 0.70    | 1.12      | 0.24
AES             | 38.39   | 1.00    | 1.61      | 0.27
qsort           |  3.96   | 0.19    | 0.94      | 0.13
dhrystone       | 22.30   | 0.46    | 2.21      | 0.10
DMIPS (v1.1)    | 254     | 12492   | 2576      | 55132

_Performance Ratio (smaller is better)_

program         | rv8-sim | rv8-jit | qemu-user | native
---             | --:     | --:     | --:       | --:
primes          |  44.43  | 1.40    |  2.36     | 1.00
miniz           |  55.00  | 2.22    |  2.92     | 1.00
norx            | 109.80  | 5.39    |  7.00     | 1.00
SHA-512         | 100.39  | 2.95    |  4.76     | 1.00
AES             | 140.12  | 3.63    |  5.88     | 1.00
qsort           |  29.52  | 1.41    |  7.04     | 1.00
dhrystone       | 214.45  | 4.38    | 21.23     | 1.00
Ratio (average) |   99:1  | 3.0:1   | 7.3:1     | 1:1

The following chart shows the bencmark programs' RISC-V
total retired instructions and x86-64 total retired
instructions and total retired micro-ops in millions:

![RISC-V vs x86-64 retired instructions]({{ site.url }}/images/bench-v8-tops.svg)

_Total retired instructions and micro-ops in millions (RISC-V versus x86-64)_

program         | rv64 (inst–M) | x86 (inst–M) | x86 (μop–M) | x86:rv64 (inst:inst) | x86:rv64 (μop:inst)
---             | --:   | --:   | --:   | --:    | --:
primes          | 763   |  1025 |  1020 | 1.34   | 1.34
miniz           | 5899  |  4225 |  4275 | 0.72   | 0.72
norx            | 2638  |  1839 |  2111 | 0.70   | 0.80
SHA-512         | 3717  |  2946 |  3262 | 0.79   | 0.88
AES             | 4943  |  2894 |  3678 | 0.59   | 0.74
qsort           | 577   |   805 |  1132 | 1.40   | 1.96
dhrystone       | 2950  |   891 |  1201 | 0.30   | 0.41
Total/Ratio     | 21486 | 14625 | 16679 | 0.83:1 | 0.98:1

The following chart shows rv8 binary translation performance
in millions of RISC-V instructions per section and native
x86-64 performance in millions of instructions per second
and millions of micro-ops per second:

![rv-jit vs x86-64 operations per second]({{ site.url }}/images/bench-v8-mops.svg)

_Millions of instructions and micro-ops per second (rv-jit versus Intel i7-5557U x86-64)_

program         | rv-jit (MIPS) | x86 (MIPS) | rv-jit:x86 (MOPS) | x86:rv-jit (MIPS:MIPS) | rv-jit:x86 (MIPS:MOPS)
---             | --:   | --:   | --:   | --:    | --:
primes          | 4771  |  8987 |  8951 | 1.88   | 1.88
miniz           | 3526  |  5597 |  5662 | 1.59   | 1.61
norx            | 2389  |  8972 | 10299 | 3.76   | 4.31
SHA-512         | 5340  | 12484 | 13820 | 2.34   | 2.59
AES             | 4973  | 10561 | 13422 | 2.12   | 2.70
qsort           | 3054  |  6010 |  8448 | 1.97   | 2.77
dhrystone       | 6469  |  8564 | 11546 | 1.32   | 1.78
Average/Ratio   | 4360  |  8739 | 10307 | 2.14:1 | 2.52:1

Notes:

- riscv64 (gcc -Os) 7.0.1 20170321 (experimental)
- x86-64 (gcc -O3) (Debian 6.3.0-6) 6.3.0 20170205
- Intel® 6th-gen Core™ i7-5557U Broadwell (3.10GHz, 3.40GHz Turbo, 4MB cache)

---

### [Logging](#logging)

`rv-sim` and `rv-sys` support the ability to log instructions
(`--log-instructions`), register values (`--log-operands`) and
`rv-sys` can log page table walks (`--log-pagewalks`).

_Sample output from `rv-sim` with the `--log-instructions` option_

```
$ rv-sim -l build/riscv64-unknown-elf/bin/hello-world-pcrel
0000000000000000000 core-0   :0000000000010078 (4501    ) mv          a0, zero           
0000000000000000001 core-0   :000000000001007a (00000597) auipc       a1, pc + 0         
0000000000000000002 core-0   :000000000001007e (02658593) addi        a1, a1, 38         
0000000000000000003 core-0   :0000000000010082 (4631    ) addi        a2, zero, 12       
0000000000000000004 core-0   :0000000000010084 (4681    ) mv          a3, zero           
0000000000000000005 core-0   :0000000000010086 (04000893) addi        a7, zero, 64       
Hello World
0000000000000000006 core-0   :000000000001008a (00000073) ecall                          
0000000000000000007 core-0   :000000000001008e (4501    ) mv          a0, zero           
0000000000000000008 core-0   :0000000000010090 (4581    ) mv          a1, zero           
0000000000000000009 core-0   :0000000000010092 (4601    ) mv          a2, zero           
0000000000000000010 core-0   :0000000000010094 (4681    ) mv          a3, zero           
0000000000000000011 core-0   :0000000000010096 (05d00893) addi        a7, zero, 93       
```

---

### [Tracing](#tracing)

The `rv-jit` program supports the ability to log RISC-V instructions
along with the dynamically translated x86-64 assembly and machine code
(`--log-jit-trace`). This mode is useful for JIT translation debugging
and optimisation analysis.

_Sample output from `rv-jit` with the `--log-jit-trace` option_

```
	# 0x0000000000103d70	addi        a0, zero, 1
		mov r8, 1                               ; 41B801000000
		L3:
	# 0x0000000000103d74	slli        a0, a0, 28
		shl r8, 1C                              ; 49C1E01C
		L4:
	# 0x0000000000103d78	addi        a1, zero, -1
		mov r9, FFFFFFFFFFFFFFFF                ; 49C7C1FFFFFFFF
		L5:
	# 0x0000000000103d7c	sb          a1, 0(a0)
		rex mov byte [r8], r9b                  ; 458808
		L6:
	# 0x0000000000103d80	lbu         a2, 0(a0)
		movzx r10d, byte [r8]                   ; 450FB610
		L7:
```

---

### [Histograms](#histograms)

The `rv-sim` and `rv-sys` programs support the ability to record and
print histograms. Program counter frequency (`--pc-usage-histogram`),
dynamic instruction frequency (`--instruction-usage-histogram`) and
dynamic register usage (`--register-usage-histogram`) is supported.

The `rv-bin` program via the `histogram` subcommand has the ability
to print static instruction frequency and static register usage.

_Sample output from `rv-sim` with the `--register-usage-histogram`
and `--instruction-usage-histogram` options_

```
$ rv-sim --register-usage-histogram \
         --instruction-usage-histogram \
         build/riscv64-unknown-elf/bin/test-aes 

integer register file
~~~~~~~~~~~~~~~~~~~~~
ra       :0x00000000000197a4
sp       :0x000000007fffff68 gp       :0x0000000000020b18
tp       :0xe87f5200d8d3e2fd t0       :0x0000000000011808
t1       :0x0000000000040000 t2       :0x000000000000035c
s0       :0x0000000000000000 s1       :0x0e9e1c7894d54be1
a0       :0x0000000000000000 a1       :0x0000000000000000
a2       :0x0000000000000000 a3       :0x0000000000000000
a4       :0x0000000000000000 a5       :0x0000000000000000
a6       :0x0000000006021440 a7       :0x000000000000005d
s2       :0x94a7319b493ab93c s3       :0xb643788d224af6fb
s4       :0x7269d597ce6e1df9 s5       :0x5f9113739f9b0d72
s6       :0x404c0e868734cf0c s7       :0x2aea8c1ef338fa59
s8       :0xff41772b6673e771 s9       :0x7a5a4806d4a6fe41
s10      :0x0a595462adddb5a8 s11      :0xda895865c86e2f07
t3       :0x0000000000000001 t4       :0x0000000000000000
t5       :0x0000000004000000 t6       :0x0000000000000000

control and status registers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
instret  :        5148514055 time     :0x000290f90f8a9e3b
pc       :0x000000000001944e fcsr     :0x00000000

register usage histogram
~~~~~~~~~~~~~~~~~~~~~~~~
    1. a5         15.11% [1769998250] #######################################
    2. a2         13.35% [1564476600] ##################################
    3. a7         10.03% [1174405210] #########################
    4. a4          9.15% [1071646586] #######################
    5. a6          7.50% [878706827] ###################
    6. t4          5.12% [599785551] #############
    7. t6          4.91% [574619648] ############
    8. t1          4.65% [545259607] ############
    9. a1          2.26% [264241924] #####
   10. s1          2.15% [251658621] #####
   11. s0          2.02% [236978689] #####
   12. s8          2.01% [234881068] #####
   13. t5          1.79% [209715245] ####
   14. t0          1.68% [197132294] ####
   15. s2          1.63% [190840979] ####
   16. a0          1.61% [188744347] ####
   17. s4          1.50% [176160835] ###
   18. s5          1.50% [176160833] ###
   19. s3          1.47% [171966617] ###
   20. sp          1.43% [167773141] ###
   21. s6          1.43% [167772235] ###
   22. t3          1.43% [167772225] ###
   23. s7          1.43% [167772223] ###
   24. t2          1.36% [159383552] ###
   25. zero        0.86% [100664377] ##
   26. s9          0.75% [88080392 ] #
   27. a3          0.68% [79693333 ] #
   28. s11         0.68% [79691785 ] #
   29. s10         0.43% [50331663 ] #
   30. ra          0.07% [8388996  ] 
   31. gp          0.00% [90       ] 

instruction usage histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1. lw         16.37% [843055543] #######################################
    2. xor        13.85% [713031972] ################################
    3. add        13.69% [704643870] ################################
    4. slli       13.20% [679477645] ###############################
    5. srliw      10.75% [553648296] #########################
    6. andi        9.94% [511705332] #######################
    7. srli        3.05% [157286473] #######
    8. lbu         2.93% [150995155] ######
    9. addi        2.69% [138412722] ######
   10. addiw       2.44% [125829177] #####
   11. sd          1.79% [92275184 ] ####
   12. sb          1.47% [75497501 ] ###
   13. jal         1.14% [58720476 ] ##
   14. beq         1.06% [54526059 ] ##
   15. ld          0.98% [50332182 ] ##
   16. and         0.98% [50331715 ] ##
   17. slliw       0.98% [50331682 ] ##
   18. bne         0.90% [46137534 ] ##
   19. or          0.65% [33554442 ] #
   20. auipc       0.41% [20971539 ] 
   21. lui         0.24% [12583002 ] 
   22. mulw        0.16% [8388608  ] 
   23. lwu         0.16% [8388608  ] 
   24. jalr        0.08% [4194443  ] 
   25. sraiw       0.08% [4194314  ] 
   26. sw          0.00% [213      ] 
   27. bltu        0.00% [78       ] 
   28. bge         0.00% [39       ] 
   29. blt         0.00% [33       ] 
   30. bgeu        0.00% [33       ] 
   31. sub         0.00% [29       ] 
...
```

---

### [Linux](#linux)

This section describes how to build and boot a Linux image.

Please read the RISC-V toolchain installtion instructions in the
[riscv-gnu-toolchain](https://github.com/riscv/riscv-gnu-toolchain/)
repository. The `riscv64-unknown-elf` newlib toolchain is required
for building the rv8 test cases and the `riscv64-unknown-linux-gnu`
glibc toolchain is required for building `busybox` which is used to
create the Linux image that runs in the full system emulator.

The toolchain script will download any required dependencies.

_Building riscv-gnu-toolchain_ for linux

```
$ cd riscv-gnu-toolchain
$ make linux
```

The linux build script will download any required dependencies.

_Building linux, busybox and bbl-lite_

```
$ cd rv8
$ export RISCV=/opt/riscv/toolchain
$ export PATH=${PATH}:${RISCV}/bin
$ make linux
```

To start linux, we execute `bbl` (the Berkeley Boot Loader) which
performs early machine set up and then passes control to an
embedded linux kernel. After kernel initialisation, `busybox` is
then executed from the initramfs as pid 1 (init). The linux image
and the initramfs are combined together and linked into bbl as
the boot payload.

_Running the full system emulator_

```
$ rv-sys build/riscv64-unknown-elf/bin/bbl
              vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
                  vvvvvvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrrrr    vvvvvvvvvvvvvvvvvvvvvvvv
rrrrrrrrrrrrrrrr      vvvvvvvvvvvvvvvvvvvvvv  
rrrrrrrrrrrrr       vvvvvvvvvvvvvvvvvvvvvv    
rr                vvvvvvvvvvvvvvvvvvvvvv      
rr            vvvvvvvvvvvvvvvvvvvvvvvv      rr
rrrr      vvvvvvvvvvvvvvvvvvvvvvvvvv      rrrr
rrrrrr      vvvvvvvvvvvvvvvvvvvvvv      rrrrrr
rrrrrrrr      vvvvvvvvvvvvvvvvvv      rrrrrrrr
rrrrrrrrrr      vvvvvvvvvvvvvv      rrrrrrrrrr
rrrrrrrrrrrr      vvvvvvvvvv      rrrrrrrrrrrr
rrrrrrrrrrrrrr      vvvvvv      rrrrrrrrrrrrrr
rrrrrrrrrrrrrrrr      vv      rrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrr          rrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrr      rrrrrrrrrrrrrrrrrrrr
rrrrrrrrrrrrrrrrrrrrrr  rrrrrrrrrrrrrrrrrrrrrr

       INSTRUCTION SETS WANT TO BE FREE
[    0.000000] Linux version 4.6.2-00044-g250754b-dirty (mclark@minty) (gcc version 7.1.1 20170509 (GCC) ) #2 Sat Jul 1 22:42:14 NZST 2017
[    0.000000] bootconsole [early0] enabled
[    0.000000] Available physical memory: 1020MB
[    0.000000] Initial ramdisk at: 0xffffffff800100b0 (261728 bytes)
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080400000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080400000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x00000000bfffffff]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257550
[    0.000000] Kernel command line: earlyprintk=sbi-console rdinit=/sbin/init 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1025684K/1044480K available (1701K kernel code, 125K rwdata, 488K rodata, 324K init, 230K bss, 18796K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:0 nr_irqs:0 0
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 191126044627 ns
[    0.000000] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.010000] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.010000] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.010000] devtmpfs: initialized
[    0.010000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.010000] NET: Registered protocol family 16
[    0.010000] clocksource: Switched to clocksource riscv_clocksource
[    0.010000] NET: Registered protocol family 2
[    0.010000] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.010000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.010000] TCP: Hash tables configured (established 8192 bind 8192)
[    0.010000] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.010000] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.010000] NET: Registered protocol family 1
[    0.010000] Unpacking initramfs...
[    0.010000] console [sbi_console0] enabled
[    0.010000] console [sbi_console0] enabled
[    0.010000] bootconsole [early0] disabled
[    0.010000] bootconsole [early0] disabled
[    0.010000] futex hash table entries: 256 (order: 0, 6144 bytes)
[    0.010000] workingset: timestamp_bits=61 max_order=18 bucket_order=0
[    0.010000] 9p: Installing v9fs 9p2000 file system support
[    0.010000] io scheduler noop registered
[    0.010000] io scheduler cfq registered (default)
[    0.010000] 9pnet: Installing 9P2000 support
[    0.010000] Freeing unused kernel memory: 324K (ffffffff80000000 - ffffffff80051000)
[    0.010000] This architecture does not have kernel memory protection.


BusyBox v1.26.1 (2017-06-30 16:46:44 NZST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # 
```
