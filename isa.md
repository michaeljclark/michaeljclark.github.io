## RISC-V Instruction Set Reference

This document contains a brief listing of instructions and pseudocode
for the RISC-V "I" _(Integer)_ and "M" _(Multiply-Divide)_
extensions. The [RISC-V Assembler Reference](/asm) contains
information on programming in assembly language for RISC-V.
For detailed information on the instruction set refer to the
[RISC-V ISA Specification](http://riscv.org/specifications/).

The following tables list the RISC-V RV32IM and RV64IM instructions.

#### RV32I Base Integer Instruction Set

Format | Name | Pseudocode
:-- | :-- | :--
<code><sub>LUI rd,imm</sub></code> | <sub>Load Upper Immediate</sub> | <sub>rd ← imm</sub>
<code><sub>AUIPC rd,offset</sub></code> | <sub>Add Upper Immediate to PC</sub> | <sub>rd ← pc + imm</sub>
<code><sub>JAL rd,offset</sub></code> | <sub>Jump and Link</sub> | <sub>rd ← pc + length(inst);<br/>pc ← pc + imm</sub>
<code><sub>JALR rd,rs1,offset</sub></code> | <sub>Jump and Link Register</sub> | <sub>rd ← pc + length(inst);<br/>pc ← (rs1 + imm) ∧ -2</sub>
<code><sub>BEQ rs1,rs2,offset</sub></code> | <sub>Branch Equal</sub> | <sub>if rs1 = rs2 then pc ← pc + imm</sub>
<code><sub>BNE rs1,rs2,offset</sub></code> | <sub>Branch Not Equal</sub> | <sub>if rs1 ≠ rs2 then pc ← pc + imm</sub>
<code><sub>BLT rs1,rs2,offset</sub></code> | <sub>Branch Less Than</sub> | <sub>if rs1 < rs2 then pc ← pc + imm</sub>
<code><sub>BGE rs1,rs2,offset</sub></code> | <sub>Branch Greater than Equal</sub> | <sub>if rs1 ≥ rs2 then pc ← pc + imm</sub>
<code><sub>BLTU rs1,rs2,offset</sub></code> | <sub>Branch Less Than Unsigned</sub> | <sub>if rs1 < rs2 then pc ← pc + imm</sub>
<code><sub>BGEU rs1,rs2,offset</sub></code> | <sub>Branch Greater than Equal Unsigned</sub> | <sub>if rs1 ≥ rs2 then pc ← pc + imm</sub>
<code><sub>LB rd,offset(rs1)</sub></code> | <sub>Load Byte</sub> | <sub>rd ← s8[rs1 + imm]</sub>
<code><sub>LH rd,offset(rs1)</sub></code> | <sub>Load Half</sub> | <sub>rd ← s16[rs1 + imm]</sub>
<code><sub>LW rd,offset(rs1)</sub></code> | <sub>Load Word</sub> | <sub>rd ← s32[rs1 + imm]</sub>
<code><sub>LBU rd,offset(rs1)</sub></code> | <sub>Load Byte Unsigned</sub> | <sub>rd ← u8[rs1 + imm]</sub>
<code><sub>LHU rd,offset(rs1)</sub></code> | <sub>Load Half Unsigned</sub> | <sub>rd ← u16[rs1 + imm]</sub>
<code><sub>SB rs2,offset(rs1)</sub></code> | <sub>Store Byte</sub> | <sub>u8[rs1 + imm] ← rs2</sub>
<code><sub>SH rs2,offset(rs1)</sub></code> | <sub>Store Half</sub> | <sub>u16[rs1 + imm] ← rs2</sub>
<code><sub>SW rs2,offset(rs1)</sub></code> | <sub>Store Word</sub> | <sub>u32[rs1 + imm] ← rs2</sub>
<code><sub>ADDI rd,rs1,imm</sub></code> | <sub>Add Immediate</sub> | <sub>rd ← rs1 + sx(imm)</sub>
<code><sub>SLTI rd,rs1,imm</sub></code> | <sub>Set Less Than Immediate</sub> | <sub>rd ← sx(rs1) < sx(imm)</sub>
<code><sub>SLTIU rd,rs1,imm</sub></code> | <sub>Set Less Than Immediate Unsigned</sub> | <sub>rd ← ux(rs1) < ux(imm)</sub>
<code><sub>XORI rd,rs1,imm</sub></code> | <sub>Xor Immediate</sub> | <sub>rd ← ux(rs1) ⊕ sx(imm)</sub>
<code><sub>ORI rd,rs1,imm</sub></code> | <sub>Or Immediate</sub> | <sub>rd ← ux(rs1) ∨ sx(imm)</sub>
<code><sub>ANDI rd,rs1,imm</sub></code> | <sub>And Immediate</sub> | <sub>rd ← ux(rs1) ∧ sx(imm)</sub>
<code><sub>SLLI rd,rs1,imm</sub></code> | <sub>Shift Left Logical Immediate</sub> | <sub>rd ← ux(rs1) « sx(imm)</sub>
<code><sub>SRLI rd,rs1,imm</sub></code> | <sub>Shift Right Logical Immediate</sub> | <sub>rd ← ux(rs1) » sx(imm)</sub>
<code><sub>SRAI rd,rs1,imm</sub></code> | <sub>Shift Right Arithmetic Immediate</sub> | <sub>rd ← sx(rs1) » sx(imm)</sub>
<code><sub>ADD rd,rs1,rs2</sub></code> | <sub>Add</sub> | <sub>rd ← sx(rs1) + sx(rs2)</sub>
<code><sub>SUB rd,rs1,rs2</sub></code> | <sub>Subtract</sub> | <sub>rd ← sx(rs1) - sx(rs2)</sub>
<code><sub>SLL rd,rs1,rs2</sub></code> | <sub>Shift Left Logical</sub> | <sub>rd ← ux(rs1) « rs2</sub>
<code><sub>SLT rd,rs1,rs2</sub></code> | <sub>Set Less Than</sub> | <sub>rd ← sx(rs1) < sx(rs2)</sub>
<code><sub>SLTU rd,rs1,rs2</sub></code> | <sub>Set Less Than Unsigned</sub> | <sub>rd ← ux(rs1) < ux(rs2)</sub>
<code><sub>XOR rd,rs1,rs2</sub></code> | <sub>Xor</sub> | <sub>rd ← ux(rs1) ⊕ ux(rs2)</sub>
<code><sub>SRL rd,rs1,rs2</sub></code> | <sub>Shift Right Logical</sub> | <sub>rd ← ux(rs1) » rs2</sub>
<code><sub>SRA rd,rs1,rs2</sub></code> | <sub>Shift Right Arithmetic</sub> | <sub>rd ← sx(rs1) » rs2</sub>
<code><sub>OR rd,rs1,rs2</sub></code> | <sub>Or</sub> | <sub>rd ← sx(rs1) ∨ sx(rs2)</sub>
<code><sub>AND rd,rs1,rs2</sub></code> | <sub>And</sub> | <sub>rd ← sx(rs1) ∧ sx(rs2)</sub>
<code><sub>FENCE pred,succ</sub></code> | <sub>Fence</sub> | <sub></sub>
<code><sub>FENCE.I </sub></code> | <sub>Fence Instruction</sub> | <sub></sub>

#### RV64I Base Integer Instruction Set (in addition to RV32I)

Format | Name | Pseudocode
:-- | :-- | :--
<code><sub>LWU rd,offset(rs1)</sub></code> | <sub>Load Word Unsigned</sub> | <sub>rd ← u32[rs1 + imm]</sub>
<code><sub>LD rd,offset(rs1)</sub></code> | <sub>Load Double</sub> | <sub>rd ← u64[rs1 + imm]</sub>
<code><sub>SD rs2,offset(rs1)</sub></code> | <sub>Store Double</sub> | <sub>u64[rs1 + imm] ← rs2</sub>
<code><sub>SLLI rd,rs1,imm</sub></code> | <sub>Shift Left Logical Immediate</sub> | <sub>rd ← ux(rs1) « sx(imm)</sub>
<code><sub>SRLI rd,rs1,imm</sub></code> | <sub>Shift Right Logical Immediate</sub> | <sub>rd ← ux(rs1) » sx(imm)</sub>
<code><sub>SRAI rd,rs1,imm</sub></code> | <sub>Shift Right Arithmetic Immediate</sub> | <sub>rd ← sx(rs1) » sx(imm)</sub>
<code><sub>ADDIW rd,rs1,imm</sub></code> | <sub>Add Immediate Word</sub> | <sub>rd ← s32(rs1) + imm</sub>
<code><sub>SLLIW rd,rs1,imm</sub></code> | <sub>Shift Left Logical Immediate Word</sub> | <sub>rd ← s32(u32(rs1) « imm)</sub>
<code><sub>SRLIW rd,rs1,imm</sub></code> | <sub>Shift Right Logical Immediate Word</sub> | <sub>rd ← s32(u32(rs1) » imm)</sub>
<code><sub>SRAIW rd,rs1,imm</sub></code> | <sub>Shift Right Arithmetic Immediate Word</sub> | <sub>rd ← s32(rs1) » imm</sub>
<code><sub>ADDW rd,rs1,rs2</sub></code> | <sub>Add Word</sub> | <sub>rd ← s32(rs1) + s32(rs2)</sub>
<code><sub>SUBW rd,rs1,rs2</sub></code> | <sub>Subtract Word</sub> | <sub>rd ← s32(rs1) - s32(rs2)</sub>
<code><sub>SLLW rd,rs1,rs2</sub></code> | <sub>Shift Left Logical Word</sub> | <sub>rd ← s32(u32(rs1) « rs2)</sub>
<code><sub>SRLW rd,rs1,rs2</sub></code> | <sub>Shift Right Logical Word</sub> | <sub>rd ← s32(u32(rs1) » rs2)</sub>
<code><sub>SRAW rd,rs1,rs2</sub></code> | <sub>Shift Right Arithmetic Word</sub> | <sub>rd ← s32(rs1) » rs2</sub>

#### RV32M Standard Extension for Integer Multiply and Divide

Format | Name | Pseudocode
:-- | :-- | :--
<code><sub>MUL rd,rs1,rs2</sub></code> | <sub>Multiply</sub> | <sub>rd ← ux(rs1) × ux(rs2)</sub>
<code><sub>MULH rd,rs1,rs2</sub></code> | <sub>Multiply High Signed Signed</sub> | <sub>rd ← (sx(rs1) × sx(rs2)) » xlen</sub>
<code><sub>MULHSU rd,rs1,rs2</sub></code> | <sub>Multiply High Signed Unsigned</sub> | <sub>rd ← (sx(rs1) × ux(rs2)) » xlen</sub>
<code><sub>MULHU rd,rs1,rs2</sub></code> | <sub>Multiply High Unsigned Unsigned</sub> | <sub>rd ← (ux(rs1) × ux(rs2)) » xlen</sub>
<code><sub>DIV rd,rs1,rs2</sub></code> | <sub>Divide Signed</sub> | <sub>rd ← sx(rs1) ÷ sx(rs2)</sub>
<code><sub>DIVU rd,rs1,rs2</sub></code> | <sub>Divide Unsigned</sub> | <sub>rd ← ux(rs1) ÷ ux(rs2)</sub>
<code><sub>REM rd,rs1,rs2</sub></code> | <sub>Remainder Signed</sub> | <sub>rd ← sx(rs1) mod sx(rs2)</sub>
<code><sub>REMU rd,rs1,rs2</sub></code> | <sub>Remainder Unsigned</sub> | <sub>rd ← ux(rs1) mod ux(rs2)</sub>

#### RV64M Standard Extension for Integer Multiply and Divide (in addition to RV32M)

Format | Name | Pseudocode
:-- | :-- | :--
<code><sub>MULW rd,rs1,rs2</sub></code> | <sub>Multiple Word</sub> | <sub>rd ← u32(rs1) × u32(rs2)</sub>
<code><sub>DIVW rd,rs1,rs2</sub></code> | <sub>Divide Signed Word</sub> | <sub>rd ← s32(rs1) ÷ s32(rs2)</sub>
<code><sub>DIVUW rd,rs1,rs2</sub></code> | <sub>Divide Unsigned Word</sub> | <sub>rd ← u32(rs1) ÷ u32(rs2)</sub>
<code><sub>REMW rd,rs1,rs2</sub></code> | <sub>Remainder Signed Word</sub> | <sub>rd ← s32(rs1) mod s32(rs2)</sub>
<code><sub>REMUW rd,rs1,rs2</sub></code> | <sub>Remainder Unsigned Word</sub> | <sub>rd ← u32(rs1) mod u32(rs2)</sub>

### [References](#references)

- [RISC-V Foundation](http://riscv.org/)
- [RISC-V ISA Specification](http://riscv.org/specifications/)
