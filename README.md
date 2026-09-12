# 8-bit-ALU

An 8-bit Arithmetic Logic Unit (ALU) is a fundamental digital circuit used in processors to perform arithmetic and logical operations on 8-bit binary data. It operates on two 8-bit operands and can perform operations such as addition, subtraction, AND, OR, XOR, and other bitwise functions. The ALU forms a core part of a CPU datapath, working with registers and control logic to execute instructions and process data.


## Project Overview

The 8-bit ALU processes two 8-bit operands, `A` and `B`, and performs a selected operation based on a 4-bit control signal, `ALU_Sel`. The design supports 16 different operations, including arithmetic operations such as addition, subtraction, multiplication, and division; shift and rotate operations; bitwise logic operations; and comparison operations.

The ALU generates an 8-bit main result along with an additional 8-bit high result for multiplication, a carry/borrow output, and a zero-result flag.

## Features

- 8-bit datapath
- 16 selectable operations
- Addition and subtraction
- 8-bit × 8-bit multiplication with 16-bit result
- Division with divide-by-zero protection
- Logical shift left and right
- Rotate left and right
- AND, OR, XOR, NOR, NAND, and XNOR operations
- Greater-than and equality comparison
- Carry/Borrow output
- Zero-result detection
- Behavioral-level Verilog implementation
- Combinational ALU architecture
- RTL simulation and waveform verification
- RTL synthesis using Yosys

## Operation / Opcode Table

| ALU_Sel | Operation | Description |
|:-------:|-----------|-------------|
| `0000` | ADD | `A + B` |
| `0001` | SUB | `A - B` |
| `0010` | MUL | `A × B` |
| `0011` | DIV | `A ÷ B` |
| `0100` | LSL | Logical Shift Left |
| `0101` | LSR | Logical Shift Right |
| `0110` | ROL | Rotate Left |
| `0111` | ROR | Rotate Right |
| `1000` | AND | `A & B` |
| `1001` | OR | `A \| B` |
| `1010` | XOR | `A ^ B` |
| `1011` | NOR | `~(A \| B)` |
| `1100` | NAND | `~(A & B)` |
| `1101` | XNOR | `~(A ^ B)` |
| `1110` | Greater Than | `A > B` |
| `1111` | Equality | `A == B` |

## Tools Used

| Tool | Purpose |
|------|---------|
| Verilog HDL | RTL design |
| Icarus Verilog | RTL simulation |
| GTKWave | Waveform analysis |
| Yosys | RTL synthesis |
| GitHub | Version control and documentation |
