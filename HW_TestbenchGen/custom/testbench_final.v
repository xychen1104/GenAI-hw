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

    integer passed_tests = 0;
    integer failed_tests = 0;

    initial begin
        // Test pattern 1: Corner case 0 + 0
        a = 4'b0000; b = 4'b0000;
        #10 $display("Test 1: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b0000) begin
            $display("✓ Test 1 Passed: Expected y = 0000, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 1 Failed: Expected y = 0000, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 2: Corner case 15 + 0
        a = 4'b1111; b = 4'b0000;
        #10 $display("Test 2: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 2 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 2 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 3: Corner case 15 + 15
        a = 4'b1111; b = 4'b1111;
        #10 $display("Test 3: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 3 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 3 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 4: Boundary value near saturation 8 + 8
        a = 4'b1000; b = 4'b1000;
        #10 $display("Test 4: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 4 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 4 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 5: Boundary value 7 + 8
        a = 4'b0111; b = 4'b1000;
        #10 $display("Test 5: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 5 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 5 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 6: Random value 10 + 5
        a = 4'b1010; b = 4'b0101;
        #10 $display("Test 6: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 6 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 6 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 7: Random value 3 + 12
        a = 4'b0011; b = 4'b1100;
        #10 $display("Test 7: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 7 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 7 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 8: Typical use case 5 + 5
        a = 4'b0101; b = 4'b0101;
        #10 $display("Test 8: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1010) begin
            $display("✓ Test 8 Passed: Expected y = 1010, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 8 Failed: Expected y = 1010, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 9: Edge case 9 + 6
        a = 4'b1001; b = 4'b0110;
        #10 $display("Test 9: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 9 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 9 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 10: Edge case 2 + 14
        a = 4'b0010; b = 4'b1110;
        #10 $display("Test 10: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 10 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 10 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 11: Random value 6 + 6
        a = 4'b0110; b = 4'b0110;
        #10 $display("Test 11: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1100) begin
            $display("✓ Test 11 Passed: Expected y = 1100, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 11 Failed: Expected y = 1100, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 12: Random value 4 + 7
        a = 4'b0100; b = 4'b0111;
        #10 $display("Test 12: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1011) begin
            $display("✓ Test 12 Passed: Expected y = 1011, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 12 Failed: Expected y = 1011, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 13: Random value 11 + 3
        a = 4'b1011; b = 4'b0011;
        #10 $display("Test 13: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1110) begin
            $display("✓ Test 13 Passed: Expected y = 1110, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 13 Failed: Expected y = 1110, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 14: Edge case 0 + 15
        a = 4'b0000; b = 4'b1111;
        #10 $display("Test 14: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 14 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 14 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 15: Edge case 13 + 2
        a = 4'b1101; b = 4'b0010;
        #10 $display("Test 15: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 15 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 15 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 16: Random value 7 + 4
        a = 4'b0111; b = 4'b0100;
        #10 $display("Test 16: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1011) begin
            $display("✓ Test 16 Passed: Expected y = 1011, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 16 Failed: Expected y = 1011, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 17: Random value 8 + 3
        a = 4'b1000; b = 4'b0011;
        #10 $display("Test 17: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1011) begin
            $display("✓ Test 17 Passed: Expected y = 1011, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 17 Failed: Expected y = 1011, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 18: Random value 12 + 1
        a = 4'b1100; b = 4'b0001;
        #10 $display("Test 18: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1101) begin
            $display("✓ Test 18 Passed: Expected y = 1101, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 18 Failed: Expected y = 1101, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 19: Random value 14 + 1
        a = 4'b1110; b = 4'b0001;
        #10 $display("Test 19: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1111) begin
            $display("✓ Test 19 Passed: Expected y = 1111, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 19 Failed: Expected y = 1111, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 20: Random value 5 + 9
        a = 4'b0101; b = 4'b1001;
        #10 $display("Test 20: a = %b, b = %b, y = %b", a, b, y);
        #10;
        if (y == 4'b1110) begin
            $display("✓ Test 20 Passed: Expected y = 1110, Got y = %b", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Test 20 Failed: Expected y = 1110, Got y = %b", y);
            failed_tests = failed_tests + 1;
        end

        $display("Test Summary: Total Tests = 20, Passed = %0d, Failed = %0d", passed_tests, failed_tests);

        $finish;
    end
endmodule