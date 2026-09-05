`timescale 1ns / 1ps

module RCA_8bit_tb;

    reg  [7:0] a;
    reg  [7:0] b;
    reg        cin;

    wire [7:0] sum;
    wire       cout;

    // Instantiate Unit Under Test
    RCA_8bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $dumpfile("RCA_8bit.vcd");
        $dumpvars(0, RCA_8bit_tb);

        $monitor("Time=%0t | a=%3d b=%3d cin=%b | cout=%b sum=%3d (Total=%3d)",
                 $time, a, b, cin, cout, sum, {cout, sum});

        // Test 1: 25 + 15 with cin = 0 -> sum = 40, cout = 0
        a = 8'd25; b = 8'd15; cin = 1'b0; #10;

        // Test 2: 25 + 15 with cin = 1 -> sum = 41, cout = 0
        a = 8'd25; b = 8'd15; cin = 1'b1; #10;

        // Test 3: Carry propagation across full chain (255 + 0 + 1 = 256 -> sum = 0, cout = 1)
        a = 8'hFF; b = 8'h00; cin = 1'b1; #10;

        // Test 4: Alternating bit patterns (85 + 170 = 255 -> sum = 255, cout = 0)
        a = 8'h55; b = 8'hAA; cin = 1'b0; #10;

        // Test 5: Full saturation (255 + 255 + 1 = 511 -> sum = 255, cout = 1)
        a = 8'd255; b = 8'd255; cin = 1'b1; #10;

        // Test 6: Zero addition (0 + 0 + 0 = 0)
        a = 8'd0; b = 8'd0; cin = 1'b0; #10;

        $finish;
    end

endmodule
