`timescale 1ns / 1ps

module SUB_8bit_tb;

    reg  [7:0] a;
    reg  [7:0] b;
    reg        bin;

    wire [7:0] diff;
    wire       bout;

    // Instantiate Unit Under Test
    SUB_8bit uut (
        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)
    );

    initial begin
        $dumpfile("SUB_8bit.vcd");
        $dumpvars(0, SUB_8bit_tb);

        $monitor("Time=%0t | a=%3d b=%3d bin=%b | bout=%b diff=%3d (signed=%0d)",
                 $time, a, b, bin, bout, diff, $signed(diff));

        // Test 1: Standard subtraction without borrow (40 - 15 = 25, bout = 0)
        a = 8'd40; b = 8'd15; bin = 1'b0; #10;

        // Test 2: Standard subtraction with borrow-in (40 - 15 - 1 = 24, bout = 0)
        a = 8'd40; b = 8'd15; bin = 1'b1; #10;

        // Test 3: Subtraction yielding zero (100 - 100 = 0, bout = 0)
        a = 8'd100; b = 8'd100; bin = 1'b0; #10;

        // Test 4: Underflow condition (A < B -> 10 - 20 = -10 = 246 in 2's complement, bout = 1)
        a = 8'd10; b = 8'd20; bin = 1'b0; #10;

        // Test 5: Boundary condition (0 - 1 = 255, bout = 1)
        a = 8'd0; b = 8'd1; bin = 1'b0; #10;

        // Test 6: Max value minus min (255 - 0 = 255, bout = 0)
        a = 8'd255; b = 8'd0; bin = 1'b0; #10;

        $finish;
    end

endmodule
