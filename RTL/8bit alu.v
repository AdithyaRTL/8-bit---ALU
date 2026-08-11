module alu_8bit (
  input wire [7:0] a,
  input wire [7:0] b,
  input wire [3:0] Alu_sel,
  output reg [7:0] Alu_out,
  output reg  [7:0] ALU_Out_High,
  output reg carry_out,
  output reg zero,
);
  reg [8:0]  temp;     // 9-bit register to capture addition/subtraction carry
    reg [15:0] mul_temp; // 16-bit register to capture full multiplication result

    // Zero Flag: High if main output is zero
    assign Zero = (ALU_Out == 8'b00000000) ? 1'b1 : 1'b0;

    always @(*) begin
        // Default values to prevent transparent latches
        CarryOut     = 1'b0;
        ALU_Out_High = 8'b00000000;

        case (ALU_Sel)
            // --- Arithmetic Operations ---
            4'b0000: begin // Addition
                temp     = A + B;
                ALU_Out  = temp[7:0];
                CarryOut = temp[8]; // 9th bit captures Carry Out
            end

            4'b0001: begin // Subtraction
                temp     = A - B;
                ALU_Out  = temp[7:0];
                CarryOut = temp[8]; // Borrow/Carry bit
            end

            4'b0010: begin // Multiplication (16-bit Full Result)
                mul_temp     = A * B;
                ALU_Out      = mul_temp[7:0];  // Lower 8 bits
                ALU_Out_High = mul_temp[15:8]; // Upper 8 bits
            end

            4'b0011: begin // Division (Protected against divide-by-zero)
                ALU_Out = (B != 8'b00000000) ? (A / B) : 8'b00000000;
            end

            // --- Shift and Rotate Operations ---
            4'b0100: begin // Logical Shift Left (LSL)
                CarryOut = A[7]; // Bit shifted out becomes Carry
                ALU_Out  = A << 1;
            end

            4'b0101: begin // Logical Shift Right (LSR)
                CarryOut = A[0]; // Bit shifted out becomes Carry
                ALU_Out  = A >> 1;
            end

            4'b0110: begin // Rotate Left (ROL)
                CarryOut = A[7];
                ALU_Out  = {A[6:0], A[7]};
            end

            4'b0111: begin // Rotate Right (ROR)
                CarryOut = A[0];
                ALU_Out  = {A[0], A[7:1]};
            end

            // --- Bitwise Logic Operations ---
            4'b1000: ALU_Out = A & B;           // AND
            4'b1001: ALU_Out = A | B;           // OR
            4'b1010: ALU_Out = A ^ B;           // XOR
            4'b1011: ALU_Out = ~(A | B);        // NOR
            4'b1100: ALU_Out = ~(A & B);        // NAND
            4'b1101: ALU_Out = ~(A ^ B);        // XNOR

            // --- Comparison Operations ---
            4'b1110: ALU_Out = (A > B)  ? 8'b00000001 : 8'b00000000; // Greater Than
            4'b1111: ALU_Out = (A == B) ? 8'b00000001 : 8'b00000000; // Equality

            default: begin
                ALU_Out      = 8'b00000000;
                ALU_Out_High = 8'b00000000;
                CarryOut     = 1'b0;
            end
        endcase
    end

endmodule
  
