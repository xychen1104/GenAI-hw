`timescale 1ns / 1ps

module tb_saturating_adder4;

    // Inputs
    reg [3:0] a;
    reg [3:0] b;

    // Outputs
    wire [3:0] y;

    // Instantiate the Unit Under Test (UUT)
    saturating_adder4 uut (
        .a(a), 
        .b(b), 
        .y(y)
    );

    initial begin
        // Test pattern 1: Corner case 0 + 0
        a = 4'b0000; b = 4'b0000;
        #10 $display("Test 1: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 2: Corner case 15 + 0
        a = 4'b1111; b = 4'b0000;
        #10 $display("Test 2: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 3: Corner case 15 + 15
        a = 4'b1111; b = 4'b1111;
        #10 $display("Test 3: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 4: Boundary value near saturation 8 + 8
        a = 4'b1000; b = 4'b1000;
        #10 $display("Test 4: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 5: Boundary value 7 + 8
        a = 4'b0111; b = 4'b1000;
        #10 $display("Test 5: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 6: Random value 10 + 5
        a = 4'b1010; b = 4'b0101;
        #10 $display("Test 6: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 7: Random value 3 + 12
        a = 4'b0011; b = 4'b1100;
        #10 $display("Test 7: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 8: Typical use case 5 + 5
        a = 4'b0101; b = 4'b0101;
        #10 $display("Test 8: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 9: Edge case 9 + 6
        a = 4'b1001; b = 4'b0110;
        #10 $display("Test 9: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 10: Edge case 2 + 14
        a = 4'b0010; b = 4'b1110;
        #10 $display("Test 10: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 11: Random value 6 + 6
        a = 4'b0110; b = 4'b0110;
        #10 $display("Test 11: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 12: Random value 4 + 7
        a = 4'b0100; b = 4'b0111;
        #10 $display("Test 12: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 13: Random value 11 + 3
        a = 4'b1011; b = 4'b0011;
        #10 $display("Test 13: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 14: Edge case 0 + 15
        a = 4'b0000; b = 4'b1111;
        #10 $display("Test 14: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 15: Edge case 13 + 2
        a = 4'b1101; b = 4'b0010;
        #10 $display("Test 15: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 16: Random value 7 + 4
        a = 4'b0111; b = 4'b0100;
        #10 $display("Test 16: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 17: Random value 8 + 3
        a = 4'b1000; b = 4'b0011;
        #10 $display("Test 17: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 18: Random value 12 + 1
        a = 4'b1100; b = 4'b0001;
        #10 $display("Test 18: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 19: Random value 14 + 1
        a = 4'b1110; b = 4'b0001;
        #10 $display("Test 19: a = %b, b = %b, y = %b", a, b, y);

        // Test pattern 20: Random value 5 + 9
        a = 4'b0101; b = 4'b1001;
        #10 $display("Test 20: a = %b, b = %b, y = %b", a, b, y);

        $finish;
    end
endmodule