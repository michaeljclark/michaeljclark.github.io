### RISC-V Instruction Set Reference

The following tables describes the RISC-V RV32IM and RV64IM instruction sets.

_**RV32I Base Integer Instruction Set**_

Opcode     | Instruction Name                         | Pseudocode
:--        | :--                                      | :--
`lui`        | Load Upper Immediate                     | rd ← imm
`auipc`      | Add Upper Immediate to PC                | rd ← pc + imm
jal        | Jump and Link                            | rd ← pc + length(inst) ; pc ← pc + imm
jalr       | Jump and Link Register                   | rd ← pc + length(inst) ; pc ← rs1 + imm
beq        | Branch Equal                             | if rs1 = rs2 then pc ← pc + imm
bne        | Branch Not Equal                         | if rs1 ≠ rs2 then pc ← pc + imm
blt        | Branch Less Than                         | if rs1 < rs2 then pc ← pc + imm
bge        | Branch Greater than Equal                | if rs1 ≥ rs2 then pc ← pc + imm
bltu       | Branch Less Than Unsigned                | if rs1 < rs2 then pc ← pc + imm
bgeu       | Branch Greater than Equal Unsigned       | if rs1 ≥ rs2 then pc ← pc + imm
lb         | Load Byte                                | rd ← s8[rs1 + imm]
lh         | Load Half                                | rd ← s16[rs1 + imm]
lw         | Load Word                                | rd ← s32[rs1 + imm]
lbu        | Load Byte Unsigned                       | rd ← u8[rs1 + imm]
lhu        | Load Half Unsigned                       | rd ← u16[rs1 + imm]
sb         | Store Byte                               | u8[rs1 + imm] ← rs2
sh         | Store Half                               | u16[rs1 + imm] ← rs2
sw         | Store Word                               | u32[rs1 + imm] ← rs2
addi       | Add Immediate                            | rd ← rs1 + sx(imm)
slti       | Set Less Than Immediate                  | rd ← sx(rs1) < sx(imm)
sltiu      | Set Less Than Immediate Unsigned         | rd ← ux(rs1) < ux(imm)
xori       | Xor Immediate                            | rd ← ux(rs1) ⊕ sx(imm)
ori        | Or Immediate                             | rd ← ux(rs1) ∨ sx(imm)
andi       | And Immediate                            | rd ← ux(rs1) ∧ sx(imm)
slli       | Shift Left Logical Immediate             | rd ← ux(rs1) « sx(imm)
srli       | Shift Right Logical Immediate            | rd ← ux(rs1) » sx(imm)
srai       | Shift Right Arithmetic Immediate         | rd ← sx(rs1) » sx(imm)
add        | Add                                      | rd ← sx(rs1) + sx(rs2)
sub        | Subtract                                 | rd ← sx(rs1) - sx(rs2)
sll        | Shift Left Logical                       | rd ← ux(rs1) « rs2
slt        | Set Less Than                            | rd ← sx(rs1) < sx(rs2)
sltu       | Set Less Than Unsigned                   | rd ← ux(rs1) < ux(rs2)
xor        | Xor                                      | rd ← ux(rs1) ⊕ ux(rs2)
srl        | Shift Right Logical                      | rd ← ux(rs1) » rs2
sra        | Shift Right Arithmetic                   | rd ← sx(rs1) » rs2
or         | Or                                       | rd ← sx(rs1) ∨ sx(rs2)
and        | And                                      | rd ← sx(rs1) ∧ sx(rs2)
fence      | Fence                                    | 
fence.i    | Fence Instruction                        | 

_**RV64I Base Integer Instruction Set (in addition to RV32I)**_

Opcode     | Instruction Name                         | Pseudocode
:--        | :--                                      | :--
lwu        | Load Word Unsigned                       | rd ← u32[rs1 + imm]
ld         | Load Double                              | rd ← u64[rs1 + imm]
sd         | Store Double                             | u64[rs1 + imm] ← rs2
addiw      | Add Immediate Word                       | rd ← s32(rs1) + imm
slliw      | Shift Left Logical Immediate Word        | rd ← s32(u32(rs1) « imm)
srliw      | Shift Right Logical Immediate Word       | rd ← s32(u32(rs1) » imm)
sraiw      | Shift Right Arithmetic Immediate Word    | rd ← s32(rs1) » imm
addw       | Add Word                                 | rd ← s32(rs1) + s32(rs2)
subw       | Subtract Word                            | rd ← s32(rs1) - s32(rs2)
sllw       | Shift Left Logical Word                  | rd ← s32(u32(rs1) « rs2)
srlw       | Shift Right Logical Word                 | rd ← s32(u32(rs1) » rs2)
sraw       | Shift Right Arithmetic Word              | rd ← s32(rs1) » rs2

_**RV32M Standard Extension for Integer Multiply and Divide**_

Opcode     | Instruction Name                         | Pseudocode
:--        | :--                                      | :--
mul        | Multiply                                 | rd ← ux(rs1) × ux(rs2)
mulh       | Multiply High Signed Signed              | rd ← (sx(rs1) × sx(rs2)) » xlen
mulhsu     | Multiply High Signed Unsigned            | rd ← (sx(rs1) × ux(rs2)) » xlen
mulhu      | Multiply High Unsigned Unsigned          | rd ← (ux(rs1) × ux(rs2)) » xlen
div        | Divide Signed                            | rd ← sx(rs1) ÷ sx(rs2)
divu       | Divide Unsigned                          | rd ← ux(rs1) ÷ ux(rs2)
rem        | Remainder Signed                         | rd ← sx(rs1) mod sx(rs2)
remu       | Remainder Unsigned                       | rd ← ux(rs1) mod ux(rs2)

_**RV64M Standard Extension for Integer Multiply and Divide (in addition to RV32M)**_

Opcode     | Instruction Name                         | Pseudocode
:--        | :--                                      | :--
mulw       | Multiple Word                            | rd ← u32(rs1) × u32(rs2)
divw       | Divide Signed Word                       | rd ← s32(rs1) ÷ s32(rs2)
divuw      | Divide Unsigned Word                     | rd ← u32(rs1) ÷ u32(rs2)
remw       | Remainder Signed Word                    | rd ← s32(rs1) mod s32(rs2)
remuw      | Remainder Unsigned Word                  | rd ← u32(rs1) mod u32(rs2)
