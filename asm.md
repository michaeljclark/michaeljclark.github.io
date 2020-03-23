## RISC-V Assembler Reference

This document gives an overview of RISC-V assembly language.
First, an introduction to assembler and linker concepts,
then sections describing assembler directives, pseudo-
instructions, relocation functions, and assembler concepts
such as labels, relative and absolute addressing, immediate
values, constants and finally control and status registers.

The accompanying [RISC-V Instruction Set Reference](/isa)
contains a listing of instruction in the `I` _(Base Integer
Instruction Set)_ and `M` _(Multiply and Divide)_ extension.
For detailed information on the RISC-V instruction set refer to
the [RISC-V ISA Specification](http://riscv.org/specifications/).

### Concepts

This section briefly covers some high level concepts that
are required to understand the process of assembling and
linking executable code from source files.

#### Assembly file

An assembly file contains assembly language directives,
macros and instructions. It can be emitted by a compiler
or it can be handwritten. An assembly file is the input file
to the assembler. The standard extensions for assembly files
are `.s` and `.S`, with the later indicating that the assembly
file should be pre-processed using the C preprocessor.

#### Relocatable Object file

A relocatable object file contains compiled object code and
data emitted by the assembler. An object file cannot be run,
rather it is used as input to the linker. The standard extension
for object files is `.o`. The most common cross-platform file
format for RISC-V executables is the ELF _(Electronic Linker
Format)_ object file format. The `objdump` utility can be used
to disassemble an object file, `objcopy` can be used to copy
and extract sections from ELF files and the `nm` utility can
list symbols in an object file.

#### ELF Header

An ELF file has an ELF header that contains _magic_ to
indicate the file is ELF formatted, the architecture of the
binary, the endianness of the binary _(little-endian for RISC-V)_,
the ELF file type _(Relocatable Object File, Executable File,
Shared Library)_, the number of program headers and their offset
in the file, the number of section headers and their offset in
the file, fields indicating the ELF version and ABI _(Application
Binary Interface)_ version of the file and finally flags indicating
various ABI options such as RVC compression and which floating-
point ABI that the executable code in the binary conforms to.

#### Program Header

Program Headers provide size and offsets of loadable segments
within an executable file or shared object along with protection
attributes used by the operating system _(read, write and exec)_.
Program headers are not present in relocatable object files
and are primarily for use by the operating system to and dynamic
linker to map code and data into memory.

#### Section Header

Section Headers provice size, offset, type, alignment and
flags of the sections contained within the ELF file. Section
headers are not required to execute a static binary but are
necessary for dynamic linking as well as program linking.
Various section types refer to the location of the symbol
table, relocations and dynamic symbols in the ELF binary file.

#### Sections

An object file is made up of multiple sections, with each
section corresponding to distinct types of executable code
or data. There are a variety of different section types. This
list shows the four most common sections:

- `.text` is a read-only section containing executable code
- `.data` is a read-write section containing global or static variables
- `.rodata` is a read-only section containing const variables
- `.bss` is a read-write section containing uninitialised data

#### Program linking

Program linking is the process of reading multiple relocatable
object files, merging the sections from each of the source files,
calculating the new addresses for symbols and applying relocation
fixups to text or data that is pointed to in relocation entries.

#### Linker Script

A linker script is a text source file that is optionally input
to the linker and it contains rules for the linker to use when
calculating the load address and alignment of the various sections
when creating an executable output file. The standard extension
for linker scripts is `.ld`.

### Assembler Directives

The assembler implements a number of directives that control
the assembly of instructions into an object file. These directives
give the ability to include arbitrary data in the object file,
control exporting of symbols, selection of sections, alignment
of data, assembly options for compression, position dependent
and position independent code.

The following are assembler directives for emitting data:

Directive                            | Arguments                                 | Description
:----------------------------------- | :---------------------------------------- | :---------------
<code><sub>.2byte</sub></code>       |                                           | <sub>16-bit comma separated words (unaligned)</sub>
<code><sub>.4byte</sub></code>       |                                           | <sub>32-bit comma separated words (unaligned)</sub>
<code><sub>.8byte</sub></code>       |                                           | <sub>64-bit comma separated words (unaligned)</sub>
<code><sub>.half</sub></code>        |                                           | <sub>16-bit comma separated words (naturally aligned)</sub>
<code><sub>.word</sub></code>        |                                           | <sub>32-bit comma separated words (naturally aligned)</sub>
<code><sub>.dword</sub></code>       |                                           | <sub>64-bit comma separated words (naturally aligned)</sub>
<code><sub>.byte</sub></code>        |                                           | <sub>8-bit comma separated words</sub>
<code><sub>.dtpreldword</sub></code> |                                           | <sub>64-bit thread local word</sub>
<code><sub>.dtprelword</sub></code>  |                                           | <sub>32-bit thread local word</sub>
<code><sub>.sleb128</sub></code>     | <sub>expression</sub>                     | <sub>signed little endian base 128, DWARF</sub>
<code><sub>.uleb128</sub></code>     | <sub>expression</sub>                     | <sub>unsigned little endian base 128, DWARF</sub>
<code><sub>.asciz</sub></code>       | <sub>"string"</sub>                       | <sub>emit string (alias for .string)</sub>
<code><sub>.string</sub></code>      | <sub>"string"</sub>                       | <sub>emit string</sub>
<code><sub>.incbin</sub></code>      | <sub>"filename"</sub>                     | <sub>emit the included file as a binary sequence of octets</sub>
<code><sub>.zero</sub></code>        | <sub>integer</sub>                        | <sub>zero bytes</sub>

The following are assembler directives for control of alignment:

Directive                            | Arguments                                 | Description
:----------------------------------- | :---------------------------------------- | :---------------
<code><sub>.align</sub></code>       | <sub>integer</sub>                        | <sub>align to power of 2 (alias for .p2align)</sub>
<code><sub>.balign</sub></code>      | <sub>b,[pad_val=0]</sub>                  | <sub>byte align</sub>
<code><sub>.p2align</sub></code>     | <sub>p2,[pad_val=0],max</sub>             | <sub>align to power of 2</sub>

The following are assembler directives for definition and exporing of symbols:

Directive                            | Arguments                                 | Description
:----------------------------------- | :---------------------------------------- | :---------------
<code><sub>.globl</sub></code>       | <sub>symbol_name</sub>                    | <sub>emit symbol_name to symbol table (scope GLOBAL)</sub>
<code><sub>.local</sub></code>       | <sub>symbol_name</sub>                    | <sub>emit symbol_name to symbol table (scope LOCAL)</sub>
<code><sub>.equ</sub></code>         | <sub>name, value</sub>                    | <sub>constant definition</sub>

The following directives are for selection of sections:

Directive                            | Arguments                                 | Description
:----------------------------------- | :---------------------------------------- | :---------------
<code><sub>.text</sub></code>        |                                           | <sub>emit .text section (if not present) and make current</sub>
<code><sub>.data</sub></code>        |                                           | <sub>emit .data section (if not present) and make current</sub>
<code><sub>.rodata</sub></code>      |                                           | <sub>emit .rodata section (if not present) and make current</sub>
<code><sub>.bss</sub></code>         |                                           | <sub>emit .bss section (if not present) and make current</sub>
<code><sub>.comm</sub></code>        | <sub>symbol_name,size,align</sub>         | <sub>emit common object to .bss section</sub>
<code><sub>.common</sub></code>      | <sub>symbol_name,size,align</sub>         | <sub>emit common object to .bss section</sub>
<code><sub>.section</sub></code>     | <sub>[{.text,.data,.rodata,.bss}]</sub>   | <sub>emit section (if not present, default .text) and make current</sub>

The following directives includes options, macros and other miscellaneous functions:

Directive                            | Arguments                                 | Description
:----------------------------------- | :---------------------------------------- | :---------------
<code><sub>.option</sub></code>      | <sub>{rvc,norvc,pic,nopic,push,pop}</sub> | <sub>RISC-V options</sub>
<code><sub>.macro</sub></code>       | <sub>name arg1 [, argn]</sub>             | <sub>begin macro definition \argname to substitute</sub>
<code><sub>.endm</sub></code>        |                                           | <sub>end macro definition</sub>
<code><sub>.file</sub></code>        | <sub>"filename"</sub>                     | <sub>emit filename FILE LOCAL symbol table</sub>
<code><sub>.ident</sub></code>       | <sub>"string"</sub>                       | <sub>accepted for source compatibility</sub>
<code><sub>.size</sub></code>        | <sub>symbol, symbol</sub>                 | <sub>accepted for source compatibility</sub>
<code><sub>.type</sub></code>        | <sub>symbol, @function</sub>              | <sub>accepted for source compatibility</sub>


### Assembler Pseudo-instructions

The assembler implements a number of convenience psuedo-instructions
that are formed from instructions in the base ISA, but have implicit
arguments or in some case reversed arguments, that result in distinct
semantics.

The following table lists RISC-V assembler pseudo instructions:

Pesudo-instruction                          | Expansion                                      | Description
:------------------------------------------ | :--------------------------------------------- | :---------------
<code><sub>nop</sub></code>                 | <code><sub>addi zero,zero,0</sub></code>       | <sub>No operation</sub>
<code><sub>li rd, expression</sub></code>   | <sub>(several expansions)</sub>                | <sub>Load immediate</sub>
<code><sub>la rd, symbol</sub></code>       | <sub>(several expansions)</sub>                | <sub>Load address</sub>
<code><sub>mv rd, rs1</sub></code>          | <code><sub>addi rd, rs, 0</sub></code>         | <sub>Copy register</sub>
<code><sub>not rd, rs1</sub></code>         | <code><sub>xori rd, rs, -1</sub></code>        | <sub>One’s complement</sub>
<code><sub>neg rd, rs1</sub></code>         | <code><sub>sub rd, x0, rs</sub></code>         | <sub>Two’s complement</sub>
<code><sub>negw rd, rs1</sub></code>        | <code><sub>subw rd, x0, rs</sub></code>        | <sub>Two’s complement Word</sub>
<code><sub>sext.w rd, rs1</sub></code>      | <code><sub>addiw rd, rs, 0</sub></code>        | <sub>Sign extend Word</sub>
<code><sub>seqz rd, rs1</sub></code>        | <code><sub>sltiu rd, rs, 1</sub></code>        | <sub>Set if = zero</sub>
<code><sub>snez rd, rs1</sub></code>        | <code><sub>sltu rd, x0, rs</sub></code>        | <sub>Set if ≠ zero</sub>
<code><sub>sltz rd, rs1</sub></code>        | <code><sub>slt rd, rs, x0</sub></code>         | <sub>Set if < zero</sub>
<code><sub>sgtz rd, rs1</sub></code>        | <code><sub>slt rd, x0, rs</sub></code>         | <sub>Set if > zero</sub>
<code><sub>fmv.s frd, frs1</sub></code>     | <code><sub>fsgnj.s frd, frs, frs</sub></code>  | <sub>Single-precision move</sub>
<code><sub>fabs.s frd, frs1</sub></code>    | <code><sub>fsgnjx.s frd, frs, frs</sub></code> | <sub>Single-precision absolute value</sub>
<code><sub>fneg.s frd, frs1</sub></code>    | <code><sub>fsgnjn.s frd, frs, frs</sub></code> | <sub>Single-precision negate</sub>
<code><sub>fmv.d frd, frs1</sub></code>     | <code><sub>fsgnj.d frd, frs, frs</sub></code>  | <sub>Double-precision move</sub>
<code><sub>fabs.d frd, frs1</sub></code>    | <code><sub>fsgnjx.d frd, frs, frs</sub></code> | <sub>Double-precision absolute value</sub>
<code><sub>fneg.d frd, frs1</sub></code>    | <code><sub>fsgnjn.d frd, frs, frs</sub></code> | <sub>Double-precision negate</sub>
<code><sub>beqz rs1, offset</sub></code>    | <code><sub>beq rs, x0, offset</sub></code>     | <sub>Branch if = zero</sub>
<code><sub>bnez rs1, offset</sub></code>    | <code><sub>bne rs, x0, offset</sub></code>     | <sub>Branch if ≠ zero</sub>
<code><sub>blez rs1, offset</sub></code>    | <code><sub>bge x0, rs, offset</sub></code>     | <sub>Branch if ≤ zero</sub>
<code><sub>bgez rs1, offset</sub></code>    | <code><sub>bge rs, x0, offset</sub></code>     | <sub>Branch if ≥ zero</sub>
<code><sub>bltz rs1, offset</sub></code>    | <code><sub>blt rs, x0, offset</sub></code>     | <sub>Branch if < zero</sub>
<code><sub>bgtz rs1, offset</sub></code>    | <code><sub>blt x0, rs, offset</sub></code>     | <sub>Branch if > zero</sub>
<code><sub>bgt rs, rt, offset</sub></code>  | <code><sub>blt rt, rs, offset</sub></code>     | <sub>Branch if ></sub>
<code><sub>ble rs, rt, offset</sub></code>  | <code><sub>bge rt, rs, offset</sub></code>     | <sub>Branch if ≤</sub>
<code><sub>bgtu rs, rt, offset</sub></code> | <code><sub>bltu rt, rs, offset</sub></code>    | <sub>Branch if >, unsigned</sub>
<code><sub>bleu rs, rt, offset</sub></code> | <code><sub>bgeu rt, rs, offset</sub></code>    | <sub>Branch if ≤, unsigned</sub>
<code><sub>j offset</sub></code>            | <code><sub>jal x0, offset</sub></code>         | <sub>Jump</sub>
<code><sub>jr offset</sub></code>           | <code><sub>jal x1, offset</sub></code>         | <sub>Jump register</sub>
<code><sub>ret</sub></code>                 | <code><sub>jalr x0, x1, 0</sub></code>         | <sub>Return from subroutine</sub>


### Relocation Functions

The relocation function directives create synthesize operand values
that are resolved at program link time and are used as immediate parameters
to specific instructions. The sections on absolute and relative addressing
give examples of using the relocation functions.

The following table lists assembler functions used to generate relocations:

Assembler Notation                               | Description                            | Instructions
:----------------------------------------------  | :------------------------------------  | :-------------------
<code><sub>%hi(symbol)</sub></code>              | <sub>Absolute (HI20)</sub>             | <sub>lui</sub>
<code><sub>%lo(symbol)</sub></code>              | <sub>Absolute (LO12)</sub>             | <sub>loads, stores, adds</sub>
<code><sub>%pcrel_hi(symbol)</sub></code>        | <sub>PC-relative (HI20)</sub>          | <sub>auipc</sub>
<code><sub>%pcrel_lo(label)</sub></code>         | <sub>PC-relative (LO12)</sub>          | <sub>loads, stores, adds</sub>
<code><sub>%tprel_hi(symbol)</sub></code>        | <sub>TLS LE (Local Exec)</sub>         | <sub>auipc</sub>
<code><sub>%tprel_lo(label)</sub></code>         | <sub>TLS LE (Local Exec)</sub>         | <sub>loads, stores, adds</sub>
<code><sub>%tprel_add(offset)</sub></code>       | <sub>TLS LE (Local Exec)</sub>         | <sub>add</sub>


### Labels

Text labels are used as branch, unconditional jump targets and symbol offsets.
Text labels are added to the symbol table of the compiled module.

```
loop:
        j loop
```

Numeric labels are used for local references. References to local labels are
suffixed with 'f' for a forward reference or 'b' for a backwards reference.

```
1:
        j 1b
```


### Absolute Addressing

Absolute addresses are used in position dependent code. An
absolute address is formed using two instructions, the U-Type
`lui` _(Load Upper Immediate)_ instruction to load `bits[31:20]`
and an I-Type or S-Type instruction such as `addi` _(add
immediate)_, `lw` _(load word)_ or `sw` _(store word)_ that
fills in the low 12 bits relative to the upper immediate.

The following example shows how to load an absolute address:

```
.section .text
.globl _start
_start:
	    lui  a1,      %hi(msg)       # load msg(hi)
	    addi a1, a1,  %lo(msg)       # load msg(lo)
	    jalr ra, puts
2:	    j    2b

.section .rodata
msg:
	    .string "Hello World\n"
```

which generates the following assembler output and relocations
as seen by objdump:

```
0000000000000000 <_start>:
   0:	000005b7          	lui	a1,0x0
			0: R_RISCV_HI20	msg
   4:	00858593          	addi	a1,a1,8 # 8 <.L21>
			4: R_RISCV_LO12_I	msg
```


### Relative Addressing

Relative addresses are used in position independent code. A
PC-relative address is formed using two instructions, the U-Type
`auipc` _(Add Upper Immediate Program Counter)_ instruction to
load `bits[31:20]` relative to the program counter of the `auipc`
instruction followed by an I-Type or S-Type instruction such as
`addi` _(add immediate)_, `lw` _(load word)_ or `sw` _(store word)_.

The following example shows how to load a PC-relative address:

```
.section .text
.globl _start
_start:
1:	    auipc a1,     %pcrel_hi(msg) # load msg(hi)
	    addi  a1, a1, %pcrel_lo(1b)  # load msg(lo)
	    jalr  ra, puts
2:	    j     2b

.section .rodata
msg:
	    .string "Hello World\n"
```

which generates the following assembler output and relocations
as seen by objdump:

```
0000000000000000 <_start>:
   0:	00000597          	auipc	a1,0x0
			0: R_RISCV_PCREL_HI20	msg
   4:	00858593          	addi	a1,a1,8 # 8 <.L21>
			4: R_RISCV_PCREL_LO12_I	.L11
```

### Load Immediate

The `li` _(load immediate)_ instruction is an assembler pseudo
instruction that is used to synthesize constants. The `li` pseudo
instruction will emit a sequence starting with `lui` followed by
`addi` and `slli` _(shift left logical immediate)_ to construct
constants by shifting and adding.

The following example shows the `li` psuedo instruction being used
to load an immediate value:

```
.section .text
.globl _start
_start:

.equ CONSTANT, 0xcafebabe

        li a0, CONSTANT
```

which generates the following assembler output as seen by objdump:

```
0000000000000000 <_start>:
   0:	00032537          	lui     a0,0x32
   4:	bfb50513          	addi    a0,a0,-1029
   8:	00e51513          	slli    a0,a0,0xe
   c:	abe50513          	addi    a0,a0,-1346
```


### Load Address

The `la` _(load address)_ instruction is an assembler pseudo-
instruction used to load the address of a symbol or label. The
instruction can emit absolute or relative addresses depending
on the `-fpic` or `-fno-pic` assembler command line options or
an `.options pic` or `.options nopic` assembler directive. The
pseduo-instruction emits a relocation so that the address of
the symbol can be fixed up during program linking.

The following example uses the `la` psuedo instruction to load
a symbol address:

```
.section .text
.globl _start
_start:

        la a0, msg

.section .rodata
msg:
	    .string "Hello World\n"
```

which generates the following assembler output and relocations
as seen by objdump:

```
0000000000000000 <_start>:
   0:	00000517          	auipc	a0,0x0
			0: R_RISCV_PCREL_HI20	msg
   4:	00850513          	addi	a0,a0,8 # 8 <_start+0x8>
			4: R_RISCV_PCREL_LO12_I	.L11
```


### Constants

Constants are emitted to the symbol table of the object but they
do not take any space in the code or data sections. Constants
can be referenced in expressions which emit relocations.

The following example shows loading a constant using the `%hi` and
`%lo` assembler functions.

```
.equ UART_BASE, 0x40003000

        lui a0,      %hi(UART_BASE)
        addi a0, a0, %lo(UART_BASE)
```

This example uses the `li` pseudo instruction to load a constant
and writes a string using polled IO to a UART:

```
.equ UART_BASE,  0x40003000
.equ REG_RBR,    0
.equ REG_TBR,    0
.equ REG_IIR,    2
.equ IIR_TX_RDY, 2
.equ IIR_RX_RDY, 4

.section .text
.globl _start
_start:
1:      auipc a0, %pcrel_hi(msg)    # load msg(hi)
        addi  a0, a0, %pcrel_lo(1b)  # load msg(lo)
2:      jal   ra, puts
3:      j     3b

puts:
        li    a2, UART_BASE
1:      lbu   a1, (a0)
        beqz  a1, 3f
2:      lbu   a3, REG_IIR(a2)
        andi  a3, a3, IIR_TX_RDY
        beqz  a3, 2b
        sb    a1, REG_TBR(a2)
        addi  a0, a0, 1
        j     1b
3:      ret

.section .rodata
msg:
	    .string "Hello World\n"
```


### Control and Status Registers

Control and status registers are typically used to update
privileged processor state however there are a few non-privileged
instructions that access control and status registers such
as the CSR pseudo-instructions `rdcycle`, `rdtime`, `rdinstret`
for access to counters and `frcsr`, `frrm`, `frflags`, `fscsr`,
`fsrm`, `fsflags`, `fsrmi` and `fsflagsi` for controling round
mode and accessing floating point accrued exception state. 

The following instructions allow reading, writing, setting and
clearing bits in CSRs _(control and status registers)_:

CSR Operation                                | Description
:------------------------------------------  | :------------------------------------------------------
<code><sub>CSRRW rd, csr, rs1</sub></code>   | <sub>Control and Status Register Atomic Read and Write</sub>
<code><sub>CSRRS rd, csr, rs1</sub></code>   | <sub>Control and Status Register Atomic Read and Set Bits</sub>
<code><sub>CSRRC rd, csr, rs1</sub></code>   | <sub>Control and Status Register Atomic Read and Clear Bits</sub>
<code><sub>CSRRWI rd, csr, imm5</sub></code> | <sub>Control and Status Register Atomic Read and Write Immediate</sub>
<code><sub>CSRRSI rd, csr, imm5</sub></code> | <sub>Control and Status Register Atomic Read and Set Bits Immediate</sub>
<code><sub>CSRRCI rd, csr, imm5</sub></code> | <sub>Control and Status Register Atomic Read and Write Immediate</sub>

The following code sample shows how to enable interrupts, enable
timer interuppts, and then set and wait for a timer interrupt to
occur. The example uses CSR instructions and access to a platform
specific MMIO _(memory mapped input output)_ region:

```
.equ RTC_BASE,      0x40000000
.equ TIMER_BASE,    0x40004000

# setup machine trap vector
1:      auipc   t0, %pcrel_hi(mtvec)        # load mtvec(hi)
        addi    t0, t0, %pcrel_lo(1b)       # load mtvec(lo)
        csrrw   zero, mtvec, t0

# set mstatus.MIE=1 (enable M mode interrupt)
        li      t0, 8
        csrrs   zero, mstatus, t0

# set mie.MTIE=1 (enable M mode timer interrupts)
        li      t0, 128
        csrrs   zero, mie, t0

# read from mtime
        li      a0, RTC_BASE
        ld      a1, 0(a0)

# write to mtimecmp
        li      a0, TIMER_BASE
        li      t0, 1000000000
        add     a1, a1, t0
        sd      a1, 0(a0)

# loop
loop:
        wfi
        j loop

# break on interrupt
mtvec:
        csrrc   t0, mcause, zero
        bgez    t0, fail       # interrupt causes are less than zero
        slli    t0, t0, 1      # shift off high bit
        srli    t0, t0, 1
        li      t1, 7          # check this is an m_timer interrupt
        bne t0, t1, fail
        j pass

pass:
        la      a0, pass_msg
        jal     puts
        j       shutdown

fail:
        la      a0, fail_msg
        jal     puts
        j       shutdown

.section .rodata

pass_msg:
        .string "PASS\n"

fail_msg:
        .string "FAIL\n"
```

### References

- [RISC-V Foundation](http://riscv.org/)
- [RISC-V ISA Specification](http://riscv.org/specifications/)
- [RISC-V GNU Toolchain](https://github.com/riscv/riscv-gnu-toolchain/)
