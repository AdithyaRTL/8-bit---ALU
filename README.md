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

## RTL Implementation

The ALU is implemented using behavioral-level Verilog HDL as a combinational design.
The main operation-selection logic is implemented using a case statement controlled by ALU_Sel.

always @(*) begin
    case (ALU_Sel)
        // ALU operations
    endcase
end

Internal registers are used to capture extended arithmetic results:

reg [8:0]  temp;
reg [15:0] mul_temp;

The 9-bit temporary register allows the design to capture carry information during addition and subtraction, while the 16-bit multiplication register preserves the complete multiplication result.

## Verification

The ALU functionality can be verified by applying different combinations of:
- A
- B
- ALU_Sel
and observing:
- ALU_Out
- ALU_Out_High
- CarryOut
- Zero

The testbench exercises the supported ALU operations and the resulting waveforms can be analyzed using GTKWave.
Simulation

## The design was simulated using:

## Icarus Verilog
Icarus Verilog is used to compile and execute the Verilog RTL and testbench.
The generated waveform can then be viewed using:

## GTKWave
Simulation Flow

Verilog RTL
     |
     v
Testbench
     |
     v
Icarus Verilog
     |
     v
VCD Waveform
     |
     v
GTKWave
     |
     v
Functional Verification

## Synthesis
The RTL design is synthesized using Yosys.
The synthesis flow converts the behavioral Verilog description into a synthesized hardware representation.

Verilog RTL
     |
     v
   Yosys
     |
     v
RTL Synthesis
     |
     v
Synthesized Hardware

This provides an additional validation step by confirming that the RTL description can be synthesized into digital hardware.

## Project Structure

8-bit-ALU/
│
├── rtl/
│   └── alu_8bit.v
│
├── testbench/
│   └── alu_8bit_tb.v
│
├── simulation/
│   └── alu_8bit.vcd
│
├── Architecture/
│   └── alu_architecture.png
│
└── README.md

## Tools Used

| Tool | Purpose |
|------|---------|
| Verilog HDL | RTL design |
| Icarus Verilog | RTL simulation |
| GTKWave | Waveform analysis |
| Yosys | RTL synthesis |
| GitHub | Version control and documentation |

## How to Run

## Compile the Design

iverilog -o alu_sim rtl/alu_8bit.v testbench/alu_8bit_tb.v

## Run the Simulation

vvp alu_sim

## Open the Waveform

gtkwave alu_8bit.vcd

## Key Learning Outcomes

Through this project, I gained practical experience in:
- Behavioral Verilog modeling
- RTL design
- Combinational logic design
- ALU architecture
- Arithmetic datapath design
- Shift and rotate operations
- Bitwise logic operations
- Comparison logic
- Status flag generation
- Testbench development
- Functional verification
- Waveform analysis
- RTL synthesis using Yosys

## Future Enhancements

Possible extensions to this ALU include:
- Parameterized ALU width
- Additional comparison operations
- Arithmetic shift operations
- More advanced multiplication and division architectures
- Integration with a register file
- Integration into a processor datapath
- FPGA implementation
- Physical design using an RTL-to-GDSII flow

## Conclusion

This project demonstrates the design and implementation of an 8-bit Arithmetic Logic Unit using Verilog HDL with 16 selectable operations across arithmetic, shift/rotate, bitwise logic, and comparison categories. The project provides practical exposure to RTL design, functional verification, waveform analysis, and synthesis, forming a foundation for larger digital processor and datapath designs.
