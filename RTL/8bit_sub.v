`timescale 1ns / 1ps

module SUB_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire       bin,    // Borrow-in (set to 0 for standard A - B)
    output wire [7:0] diff,   // Difference = A - B - bin
    output wire       bout    // Borrow-out (1 if A < (B + bin) in unsigned)
);

    wire [7:0] b_inv;
    wire [8:0] c;

    // 1. Bitwise NOT of B for 2's complement subtraction
    assign b_inv = ~b;

    // 2. Active-low borrow setup:
    // For standard subtraction A - B (bin = 0), we feed carry-in = 1.
    // If an external borrow-in occurs (bin = 1), carry-in becomes 0.
    assign c[0] = ~bin;

    // 3. Full Adder stages performing A + (~B) + (~bin)
    assign diff[0] = a[0] ^ b_inv[0] ^ c[0];
    assign c[1]    = (a[0] & b_inv[0]) | (b_inv[0] & c[0]) | (c[0] & a[0]);

    assign diff[1] = a[1] ^ b_inv[1] ^ c[1];
    assign c[2]    = (a[1] & b_inv[1]) | (b_inv[1] & c[1]) | (c[1] & a[1]);

    assign diff[2] = a[2] ^ b_inv[2] ^ c[2];
    assign c[3]    = (a[2] & b_inv[2]) | (b_inv[2] & c[3-1]) | (c[3-1] & a[2]);

    assign diff[3] = a[3] ^ b_inv[3] ^ c[3];
    assign c[4]    = (a[3] & b_inv[3]) | (b_inv[3] & c[3]) | (c[3] & a[3]);

    assign diff[4] = a[4] ^ b_inv[4] ^ c[4];
    assign c[5]    = (a[4] & b_inv[4]) | (b_inv[4] & c[4]) | (c[4] & a[4]);

    assign diff[5] = a[5] ^ b_inv[5] ^ c[5];
    assign c[6]    = (a[5] & b_inv[5]) | (b_inv[5] & c[5]) | (c[5] & a[5]);

    assign diff[6] = a[6] ^ b_inv[6] ^ c[6];
    assign c[7]    = (a[6] & b_inv[6]) | (b_inv[6] & c[6]) | (c[6] & a[6]);

    assign diff[7] = a[7] ^ b_inv[7] ^ c[7];
    assign c[8]    = (a[7] & b_inv[7]) | (b_inv[7] & c[7]) | (c[7] & a[7]);

    // In 2's complement, carry_out = 1 means NO borrow needed.
    // Therefore, Borrow_out = ~Carry_out.
    assign bout = ~c[8];

endmodule
