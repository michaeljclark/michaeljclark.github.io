### RISC-V Instruction Set Reference

The following tables describes the RISC-V RV32IM and RV64IM instruction sets.

_**RV32I Base Integer Instruction Set**_

Format                   |Name                                    |Pseudocode
:--                      |:--                                     |:--
`LUI rd, imm`            |Load Upper Immediate                    |rd ← imm
`AUIPC rd, offset`       |Add Upper Immediate to PC               |rd ← pc + imm
`JAL rd, offset`         |Jump and Link                           |rd ← pc + length(inst) ; pc ← pc + imm
`JALR rd, rs1, offset`   |Jump and Link Register                  |rd ← pc + length(inst) ; pc ← rs1 + imm
`BEQ rs1, rs2, offset`   |Branch Equal                            |if rs1 = rs2 then pc ← pc + imm
`BNE rs1, rs2, offset`   |Branch Not Equal                        |if rs1 ≠ rs2 then pc ← pc + imm
`BLT rs1, rs2, offset`   |Branch Less Than                        |if rs1 < rs2 then pc ← pc + imm
`BGE rs1, rs2, offset`   |Branch Greater than Equal               |if rs1 ≥ rs2 then pc ← pc + imm
`BLTU rs1, rs2, offset`  |Branch Less Than Unsigned               |if rs1 < rs2 then pc ← pc + imm
`BGEU rs1, rs2, offset`  |Branch Greater than Equal Unsigned      |if rs1 ≥ rs2 then pc ← pc + imm
`LB rd, offset(rs1)`     |Load Byte                               |rd ← s8[rs1 + imm]
`LH rd, offset(rs1)`     |Load Half                               |rd ← s16[rs1 + imm]
`LW rd, offset(rs1)`     |Load Word                               |rd ← s32[rs1 + imm]
`LBU rd, offset(rs1)`    |Load Byte Unsigned                      |rd ← u8[rs1 + imm]
`LHU rd, offset(rs1)`    |Load Half Unsigned                      |rd ← u16[rs1 + imm]
`SB rs2, offset(rs1)`    |Store Byte                              |u8[rs1 + imm] ← rs2
`SH rs2, offset(rs1)`    |Store Half                              |u16[rs1 + imm] ← rs2
`SW rs2, offset(rs1)`    |Store Word                              |u32[rs1 + imm] ← rs2
`ADDI rd, rs1, imm`      |Add Immediate                           |rd ← rs1 + sx(imm)
`SLTI rd, rs1, imm`      |Set Less Than Immediate                 |rd ← sx(rs1) < sx(imm)
`SLTIU rd, rs1, imm`     |Set Less Than Immediate Unsigned        |rd ← ux(rs1) < ux(imm)
`XORI rd, rs1, imm`      |Xor Immediate                           |rd ← ux(rs1) ⊕ sx(imm)
`ORI rd, rs1, imm`       |Or Immediate                            |rd ← ux(rs1) ∨ sx(imm)
`ANDI rd, rs1, imm`      |And Immediate                           |rd ← ux(rs1) ∧ sx(imm)
`SLLI rd, rs1, imm`      |Shift Left Logical Immediate            |rd ← ux(rs1) « sx(imm)
`SRLI rd, rs1, imm`      |Shift Right Logical Immediate           |rd ← ux(rs1) » sx(imm)
`SRAI rd, rs1, imm`      |Shift Right Arithmetic Immediate        |rd ← sx(rs1) » sx(imm)
`ADD rd, rs1, rs2`       |Add                                     |rd ← sx(rs1) + sx(rs2)
`SUB rd, rs1, rs2`       |Subtract                                |rd ← sx(rs1) - sx(rs2)
`SLL rd, rs1, rs2`       |Shift Left Logical                      |rd ← ux(rs1) « rs2
`SLT rd, rs1, rs2`       |Set Less Than                           |rd ← sx(rs1) < sx(rs2)
`SLTU rd, rs1, rs2`      |Set Less Than Unsigned                  |rd ← ux(rs1) < ux(rs2)
`XOR rd, rs1, rs2`       |Xor                                     |rd ← ux(rs1) ⊕ ux(rs2)
`SRL rd, rs1, rs2`       |Shift Right Logical                     |rd ← ux(rs1) » rs2
`SRA rd, rs1, rs2`       |Shift Right Arithmetic                  |rd ← sx(rs1) » rs2
`OR rd, rs1, rs2`        |Or                                      |rd ← sx(rs1) ∨ sx(rs2)
`AND rd, rs1, rs2`       |And                                     |rd ← sx(rs1) ∧ sx(rs2)
`FENCE pred, succ`       |Fence                                   |
`FENCE.I `               |Fence Instruction                       |

_**RV64I Base Integer Instruction Set (in addition to RV32I)**_

Format                   |Name                                    |Pseudocode
:--                      |:--                                     |:--
`LWU rd, offset(rs1)`    |Load Word Unsigned                      |rd ← u32[rs1 + imm]
`LD rd, offset(rs1)`     |Load Double                             |rd ← u64[rs1 + imm]
`SD rs2, offset(rs1)`    |Store Double                            |u64[rs1 + imm] ← rs2
`SLLI rd, rs1, imm`      |Shift Left Logical Immediate            |rd ← ux(rs1) « sx(imm)
`SRLI rd, rs1, imm`      |Shift Right Logical Immediate           |rd ← ux(rs1) » sx(imm)
`SRAI rd, rs1, imm`      |Shift Right Arithmetic Immediate        |rd ← sx(rs1) » sx(imm)
`ADDIW rd, rs1, imm`     |Add Immediate Word                      |rd ← s32(rs1) + imm
`SLLIW rd, rs1, imm`     |Shift Left Logical Immediate Word       |rd ← s32(u32(rs1) « imm)
`SRLIW rd, rs1, imm`     |Shift Right Logical Immediate Word      |rd ← s32(u32(rs1) » imm)
`SRAIW rd, rs1, imm`     |Shift Right Arithmetic Immediate Word   |rd ← s32(rs1) » imm
`ADDW rd, rs1, rs2`      |Add Word                                |rd ← s32(rs1) + s32(rs2)
`SUBW rd, rs1, rs2`      |Subtract Word                           |rd ← s32(rs1) - s32(rs2)
`SLLW rd, rs1, rs2`      |Shift Left Logical Word                 |rd ← s32(u32(rs1) « rs2)
`SRLW rd, rs1, rs2`      |Shift Right Logical Word                |rd ← s32(u32(rs1) » rs2)
`SRAW rd, rs1, rs2`      |Shift Right Arithmetic Word             |rd ← s32(rs1) » rs2

_**RV32M Standard Extension for Integer Multiply and Divide**_

Format                   |Name                                    |Pseudocode
:--                      |:--                                     |:--
`MUL rd, rs1, rs2`       |Multiply                                |rd ← ux(rs1) × ux(rs2)
`MULH rd, rs1, rs2`      |Multiply High Signed Signed             |rd ← (sx(rs1) × sx(rs2)) » xlen
`MULHSU rd, rs1, rs2`    |Multiply High Signed Unsigned           |rd ← (sx(rs1) × ux(rs2)) » xlen
`MULHU rd, rs1, rs2`     |Multiply High Unsigned Unsigned         |rd ← (ux(rs1) × ux(rs2)) » xlen
`DIV rd, rs1, rs2`       |Divide Signed                           |rd ← sx(rs1) ÷ sx(rs2)
`DIVU rd, rs1, rs2`      |Divide Unsigned                         |rd ← ux(rs1) ÷ ux(rs2)
`REM rd, rs1, rs2`       |Remainder Signed                        |rd ← sx(rs1) mod sx(rs2)
`REMU rd, rs1, rs2`      |Remainder Unsigned                      |rd ← ux(rs1) mod ux(rs2)

_**RV64M Standard Extension for Integer Multiply and Divide (in addition to RV32M)**_

Format                   |Name                                    |Pseudocode
:--                      |:--                                     |:--
`MULW rd, rs1, rs2`      |Multiple Word                           |rd ← u32(rs1) × u32(rs2)
`DIVW rd, rs1, rs2`      |Divide Signed Word                      |rd ← s32(rs1) ÷ s32(rs2)
`DIVUW rd, rs1, rs2`     |Divide Unsigned Word                    |rd ← u32(rs1) ÷ u32(rs2)
`REMW rd, rs1, rs2`      |Remainder Signed Word                   |rd ← s32(rs1) mod s32(rs2)
`REMUW rd, rs1, rs2`     |Remainder Unsigned Word                 |rd ← u32(rs1) mod u32(rs2)
