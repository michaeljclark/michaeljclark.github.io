## RISC-V Open Source Software Implementations

This document contains a list of Open Source RISC-V software
implementations (user mode simulator simulators, full system
emulators and dynamic binary translators.


__*Spike*__

URL: [https://github.com/riscv/riscv-isa-sim/](https://github.com/riscv/riscv-isa-sim/)

Spike is the official RISC-V Instruction Set Simulator. Spike
serves as the behavioral reference model for the RISC-V ISA.
Spike is easily extended to add new instructions. Spike
supports RV32GC and RV64GC, and has Debug and GDB support.


__*ANGEL*__

URL: [https://riscv.org/software-tools/riscv-angel/](https://riscv.org/software-tools/riscv-angel/)

ANGEL is a Javascript RISC-V ISA (RV64) Simulator that boots
and runs riscv-linux with BusyBox inside a web browser.


__*QEMU*__

URL: [https://github.com/riscv/riscv-qemu/](https://github.com/riscv/riscv-qemu/)

QEMU, the fast processor emulator, is a multiplatform user mode
simulator and a full system emulator that emulates CPUs via dynamic
binary translation. It supports a wide variety of architectures.
riscv-qemu supports RV32GC and RV64GC and has GDB support.


__*RISCVEMU*__

URL: [https://bellard.org/riscvemu/](https://bellard.org/riscvemu/)

RISCVEMU is a full system emulator for the RISC-V architecture.
RISCVEMU is notable in that it supports RV32GC, RV64GC and RV128GC
as well as VirtIO console, block and network devices.


__*Gem5*__

URL: [http://gem5.org/](http://gem5.org/)

The gem5 simulator is a modular platform for computer-system
architecture research, encompassing system-level architecture
as well as processor microarchitecture. It features a detailed
pipeline model for a wide variety of architectures.


__*rv8*__

URL: [https://github.com/michaeljclark/rv8/](https://github.com/michaeljclark/rv8/)

rv8 is a simulation suite that features a user mode simulator,
a full system emulator, a dynamic binary translator along with
metadata tools and a model for generating artifacts based on
instruction set metadata. rv8 implements an 16550-like UART
and supports RV32GC and RV64GC.
