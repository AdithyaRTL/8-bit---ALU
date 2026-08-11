module alu_8bit_tb;

    // 1. Inputs to the ALU (reg)
    reg [7:0] A;
    reg [7:0] B;
    reg [3:0] ALU_Sel;

    // 2. Outputs from the ALU (wire)
    wire [7:0] ALU_Out;
    wire [7:0] ALU_Out_High;
    wire       CarryOut;
    wire       Zero;

    // 3. Instantiate Unit Under Test (UUT)
    alu_8bit uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .ALU_Out_High(ALU_Out_High),
        .CarryOut(CarryOut),
        .Zero(Zero)
    );

    // 4. Test Script
    initial begin
        // Save waveform file for GTKWave
        $dumpfile("alu_8bit.vcd");
        $dumpvars(0, alu_8bit_tb);

        // =========================================================
        // CATEGORY 1: ARITHMETIC OPERATIONS
        // =========================================================

        // --- Test 1: Addition (10 + 5 = 15) ---
        A = 8'd10;
        B = 8'd5;
        ALU_Sel = 4'b0000;
        #10;

        // --- Test 2: Subtraction (10 - 5 = 5) ---
        A = 8'd10;
        B = 8'd5;
        ALU_Sel = 4'b0001;
        #10;

        // --- Test 3: Large Multiplication (200 * 100 = 20,000) ---
        // Expected ALU_Out = 32, ALU_Out_High = 78 (78*256 + 32 = 20000)
        A = 8'd200;
        B = 8'd100;
        ALU_Sel = 4'b0010;
        #10;

        // --- Test 4: Division (20 / 5 = 4) ---
        A = 8'd20;
        B = 8'd5;
        ALU_Sel = 4'b0011;
        #10;

        // =========================================================
        // CATEGORY 2: SHIFT AND ROTATE OPERATIONS
        // =========================================================
        A = 8'b10000001; // Input pattern with Bit 7 = 1 and Bit 0 = 1
        B = 8'b00000000;

        // --- Test 5: Logical Shift Left (LSL) ---
        // Expected ALU_Out = 8'b00000010, CarryOut = 1
        ALU_Sel = 4'b0100;
        #10;

        // --- Test 6: Logical Shift Right (LSR) ---
        // Expected ALU_Out = 8'b01000000, CarryOut = 1
        ALU_Sel = 4'b0101;
        #10;

        // --- Test 7: Rotate Left (ROL) ---
        // Expected ALU_Out = 8'b00000011, CarryOut = 1
        ALU_Sel = 4'b0110;
        #10;

        // --- Test 8: Rotate Right (ROR) ---
        // Expected ALU_Out = 8'b11000000, CarryOut = 1
        ALU_Sel = 4'b0111;
        #10;

        // =========================================================
        // CATEGORY 3: BITWISE LOGIC OPERATIONS
        // =========================================================
        A = 8'b11110000;
        B = 8'b10101010;

        // --- Test 9: Bitwise AND ---
        // Expected ALU_Out = 8'b10100000
        ALU_Sel = 4'b1000;
        #10;

        // --- Test 10: Bitwise OR ---
        // Expected ALU_Out = 8'b11111010
        ALU_Sel = 4'b1001;
        #10;

        // --- Test 11: Bitwise XOR ---
        // Expected ALU_Out = 8'b01011010
        ALU_Sel = 4'b1010;
        #10;

        // =========================================================
        // CATEGORY 4: COMPARISON OPERATIONS & FLAGS
        // =========================================================

        // --- Test 12: Comparison (Greater Than: 20 > 5) ---
        // Expected ALU_Out = 8'b00000001
        A = 8'd20;
        B = 8'd5;
        ALU_Sel = 4'b1110;
        #10;

        // --- Test 13: CarryOut Flag Test (250 + 20 = 270 > 255) ---
        // Expected ALU_Out = 14, CarryOut = 1
        A = 8'd250;
        B = 8'd20;
        ALU_Sel = 4'b0000;
        #10;

        // --- Test 14: Zero Flag Test (10 - 10 = 0) ---
        // Expected ALU_Out = 0, Zero = 1
        A = 8'd10;
        B = 8'd10;
        ALU_Sel = 4'b0001;
        #10;

        $finish; // End simulation
    end

endmodule
