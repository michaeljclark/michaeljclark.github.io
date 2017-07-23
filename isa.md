### RISC-V Instruction Set Reference

The following tables describes the RISC-V RV32IM and RV64IM instruction sets.

_**RV32I Base Integer Instruction Set**_

Format                   |Name                                              |Pseudocode
:--                      |:--                                               |:--
`LUI rd, imm`            |<sub>Load Upper Immediate</sub>                   |<sub>rd ← imm</sub>
`AUIPC rd, offset`       |<sub>Add Upper Immediate to PC</sub>              |<sub>rd ← pc + imm</sub>
`JAL rd, offset`         |<sub>Jump and Link</sub>                          |<sub>rd ← pc + length(inst) ; pc ← pc + imm</sub>
`JALR rd, rs1, offset`   |<sub>Jump and Link Register</sub>                 |<sub>rd ← pc + length(inst) ; pc ← rs1 + imm</sub>
`BEQ rs1, rs2, offset`   |<sub>Branch Equal</sub>                           |<sub>if rs1 = rs2 then pc ← pc + imm</sub>
`BNE rs1, rs2, offset`   |<sub>Branch Not Equal</sub>                       |<sub>if rs1 ≠ rs2 then pc ← pc + imm</sub>
`BLT rs1, rs2, offset`   |<sub>Branch Less Than</sub>                       |<sub>if rs1 < rs2 then pc ← pc + imm</sub>
`BGE rs1, rs2, offset`   |<sub>Branch Greater than Equal</sub>              |<sub>if rs1 ≥ rs2 then pc ← pc + imm</sub>
`BLTU rs1, rs2, offset`  |<sub>Branch Less Than Unsigned</sub>              |<sub>if rs1 < rs2 then pc ← pc + imm</sub>
`BGEU rs1, rs2, offset`  |<sub>Branch Greater than Equal Unsigned</sub>     |<sub>if rs1 ≥ rs2 then pc ← pc + imm</sub>
`LB rd, offset(rs1)`     |<sub>Load Byte</sub>                              |<sub>rd ← s8[rs1 + imm]</sub>
`LH rd, offset(rs1)`     |<sub>Load Half</sub>                              |<sub>rd ← s16[rs1 + imm]</sub>
`LW rd, offset(rs1)`     |<sub>Load Word</sub>                              |<sub>rd ← s32[rs1 + imm]</sub>
`LBU rd, offset(rs1)`    |<sub>Load Byte Unsigned</sub>                     |<sub>rd ← u8[rs1 + imm]</sub>
`LHU rd, offset(rs1)`    |<sub>Load Half Unsigned</sub>                     |<sub>rd ← u16[rs1 + imm]</sub>
`SB rs2, offset(rs1)`    |<sub>Store Byte</sub>                             |<sub>u8[rs1 + imm] ← rs2</sub>
`SH rs2, offset(rs1)`    |<sub>Store Half</sub>                             |<sub>u16[rs1 + imm] ← rs2</sub>
`SW rs2, offset(rs1)`    |<sub>Store Word</sub>                             |<sub>u32[rs1 + imm] ← rs2</sub>
`ADDI rd, rs1, imm`      |<sub>Add Immediate</sub>                          |<sub>rd ← rs1 + sx(imm)</sub>
`SLTI rd, rs1, imm`      |<sub>Set Less Than Immediate</sub>                |<sub>rd ← sx(rs1) < sx(imm)</sub>
`SLTIU rd, rs1, imm`     |<sub>Set Less Than Immediate Unsigned</sub>       |<sub>rd ← ux(rs1) < ux(imm)</sub>
`XORI rd, rs1, imm`      |<sub>Xor Immediate</sub>                          |<sub>rd ← ux(rs1) ⊕ sx(imm)</sub>
`ORI rd, rs1, imm`       |<sub>Or Immediate</sub>                           |<sub>rd ← ux(rs1) ∨ sx(imm)</sub>
`ANDI rd, rs1, imm`      |<sub>And Immediate</sub>                          |<sub>rd ← ux(rs1) ∧ sx(imm)</sub>
`SLLI rd, rs1, imm`      |<sub>Shift Left Logical Immediate</sub>           |<sub>rd ← ux(rs1) « sx(imm)</sub>
`SRLI rd, rs1, imm`      |<sub>Shift Right Logical Immediate</sub>          |<sub>rd ← ux(rs1) » sx(imm)</sub>
`SRAI rd, rs1, imm`      |<sub>Shift Right Arithmetic Immediate</sub>       |<sub>rd ← sx(rs1) » sx(imm)</sub>
`ADD rd, rs1, rs2`       |<sub>Add</sub>                                    |<sub>rd ← sx(rs1) + sx(rs2)</sub>
`SUB rd, rs1, rs2`       |<sub>Subtract</sub>                               |<sub>rd ← sx(rs1) - sx(rs2)</sub>
`SLL rd, rs1, rs2`       |<sub>Shift Left Logical</sub>                     |<sub>rd ← ux(rs1) « rs2</sub>
`SLT rd, rs1, rs2`       |<sub>Set Less Than</sub>                          |<sub>rd ← sx(rs1) < sx(rs2)</sub>
`SLTU rd, rs1, rs2`      |<sub>Set Less Than Unsigned</sub>                 |<sub>rd ← ux(rs1) < ux(rs2)</sub>
`XOR rd, rs1, rs2`       |<sub>Xor</sub>                                    |<sub>rd ← ux(rs1) ⊕ ux(rs2)</sub>
`SRL rd, rs1, rs2`       |<sub>Shift Right Logical</sub>                    |<sub>rd ← ux(rs1) » rs2</sub>
`SRA rd, rs1, rs2`       |<sub>Shift Right Arithmetic</sub>                 |<sub>rd ← sx(rs1) » rs2</sub>
`OR rd, rs1, rs2`        |<sub>Or</sub>                                     |<sub>rd ← sx(rs1) ∨ sx(rs2)</sub>
`AND rd, rs1, rs2`       |<sub>And</sub>                                    |<sub>rd ← sx(rs1) ∧ sx(rs2)</sub>
`FENCE pred, succ`       |<sub>Fence</sub>                                  |<sub></sub>
`FENCE.I `               |<sub>Fence Instruction</sub>                      |<sub></sub>

_**RV64I Base Integer Instruction Set (in addition to RV32I)**_

Format                   |Name                                              |Pseudocode
:--                      |:--                                               |:--
`LWU rd, offset(rs1)`    |<sub>Load Word Unsigned</sub>                     |<sub>rd ← u32[rs1 + imm]</sub>
`LD rd, offset(rs1)`     |<sub>Load Double</sub>                            |<sub>rd ← u64[rs1 + imm]</sub>
`SD rs2, offset(rs1)`    |<sub>Store Double</sub>                           |<sub>u64[rs1 + imm] ← rs2</sub>
`SLLI rd, rs1, imm`      |<sub>Shift Left Logical Immediate</sub>           |<sub>rd ← ux(rs1) « sx(imm)</sub>
`SRLI rd, rs1, imm`      |<sub>Shift Right Logical Immediate</sub>          |<sub>rd ← ux(rs1) » sx(imm)</sub>
`SRAI rd, rs1, imm`      |<sub>Shift Right Arithmetic Immediate</sub>       |<sub>rd ← sx(rs1) » sx(imm)</sub>
`ADDIW rd, rs1, imm`     |<sub>Add Immediate Word</sub>                     |<sub>rd ← s32(rs1) + imm</sub>
`SLLIW rd, rs1, imm`     |<sub>Shift Left Logical Immediate Word</sub>      |<sub>rd ← s32(u32(rs1) « imm)</sub>
`SRLIW rd, rs1, imm`     |<sub>Shift Right Logical Immediate Word</sub>     |<sub>rd ← s32(u32(rs1) » imm)</sub>
`SRAIW rd, rs1, imm`     |<sub>Shift Right Arithmetic Immediate Word</sub>  |<sub>rd ← s32(rs1) » imm</sub>
`ADDW rd, rs1, rs2`      |<sub>Add Word</sub>                               |<sub>rd ← s32(rs1) + s32(rs2)</sub>
`SUBW rd, rs1, rs2`      |<sub>Subtract Word</sub>                          |<sub>rd ← s32(rs1) - s32(rs2)</sub>
`SLLW rd, rs1, rs2`      |<sub>Shift Left Logical Word</sub>                |<sub>rd ← s32(u32(rs1) « rs2)</sub>
`SRLW rd, rs1, rs2`      |<sub>Shift Right Logical Word</sub>               |<sub>rd ← s32(u32(rs1) » rs2)</sub>
`SRAW rd, rs1, rs2`      |<sub>Shift Right Arithmetic Word</sub>            |<sub>rd ← s32(rs1) » rs2</sub>

_**RV32M Standard Extension for Integer Multiply and Divide**_

Format                   |Name                                              |Pseudocode
:--                      |:--                                               |:--
`MUL rd, rs1, rs2`       |<sub>Multiply</sub>                               |<sub>rd ← ux(rs1) × ux(rs2)</sub>
`MULH rd, rs1, rs2`      |<sub>Multiply High Signed Signed</sub>            |<sub>rd ← (sx(rs1) × sx(rs2)) » xlen</sub>
`MULHSU rd, rs1, rs2`    |<sub>Multiply High Signed Unsigned</sub>          |<sub>rd ← (sx(rs1) × ux(rs2)) » xlen</sub>
`MULHU rd, rs1, rs2`     |<sub>Multiply High Unsigned Unsigned</sub>        |<sub>rd ← (ux(rs1) × ux(rs2)) » xlen</sub>
`DIV rd, rs1, rs2`       |<sub>Divide Signed</sub>                          |<sub>rd ← sx(rs1) ÷ sx(rs2)</sub>
`DIVU rd, rs1, rs2`      |<sub>Divide Unsigned</sub>                        |<sub>rd ← ux(rs1) ÷ ux(rs2)</sub>
`REM rd, rs1, rs2`       |<sub>Remainder Signed</sub>                       |<sub>rd ← sx(rs1) mod sx(rs2)</sub>
`REMU rd, rs1, rs2`      |<sub>Remainder Unsigned</sub>                     |<sub>rd ← ux(rs1) mod ux(rs2)</sub>

_**RV64M Standard Extension for Integer Multiply and Divide (in addition to RV32M)**_

Format                   |Name                                              |Pseudocode
:--                      |:--                                               |:--
`MULW rd, rs1, rs2`      |<sub>Multiple Word</sub>                          |<sub>rd ← u32(rs1) × u32(rs2)</sub>
`DIVW rd, rs1, rs2`      |<sub>Divide Signed Word</sub>                     |<sub>rd ← s32(rs1) ÷ s32(rs2)</sub>
`DIVUW rd, rs1, rs2`     |<sub>Divide Unsigned Word</sub>                   |<sub>rd ← u32(rs1) ÷ u32(rs2)</sub>
`REMW rd, rs1, rs2`      |<sub>Remainder Signed Word</sub>                  |<sub>rd ← s32(rs1) mod s32(rs2)</sub>
`REMUW rd, rs1, rs2`     |<sub>Remainder Unsigned Word</sub>                |<sub>rd ← u32(rs1) mod u32(rs2)</sub>

