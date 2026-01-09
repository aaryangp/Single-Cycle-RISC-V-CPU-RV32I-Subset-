# Single-Cycle RISC-V CPU (RV32I Subset)

This repository contains a **single-cycle RISC-V processor** implemented in **Verilog HDL**.  
The design follows the classic single-cycle datapath and supports a functional subset of the **RV32I instruction set**.

Each instruction (fetch, decode, execute, memory access, write-back) completes in **one clock cycle**.

---

## Project Structure

PC.v                 – Program Counter  
PC_adder.v           – PC + 4 adder  
instruction_memory.v – Instruction memory (ROM)  
immedgenerator.v     – Immediate generator  
register_bank.v      – Register file (32 × 32)  
ALU_unit.v           – Arithmetic Logic Unit  
ALU_control.v        – ALU control logic  
controlunit.v        – Main control unit  
branch_adder.v       – Branch target adder  
data_memory.v        – Data memory  
mux.v                – 2:1 multiplexer  
top.v                – Top-level CPU module  

tb_top.v             – Testbench  
program.hex          – Instruction memory hex file  

---

## Supported Instruction Set

### R-Type Instructions
add, sub  
and, or, xor  
slt  
sll, srl, sra  

### I-Type Instructions
addi, andi, ori, xori, slti  
lw  

### S-Type Instructions
sw  

### B-Type Instructions
beq, bne, blt, bge  

Not implemented yet:
jal, jalr, lui, auipc, bltu, bgeu, multiply/divide

---

## Datapath Overview

- Single-cycle architecture
- PC is updated every cycle
- Default next PC = PC + 4
- Branch target = PC + 4 + (immediate << 1)
- Branch decision logic implemented at top level
- ALU reused for arithmetic, comparison, and branch conditions

---

## Design Highlights

- Modular Verilog design
- Clean separation of datapath and control
- Word-aligned instruction fetch
- Branch logic implemented as top-level glue logic
- Matches textbook single-cycle RISC-V datapath

---

## Future Work

- Add jal and jalr
- Add unsigned branches (bltu, bgeu)
- Add lui and auipc
- Illegal instruction detection
- Pipelined version of the CPU

