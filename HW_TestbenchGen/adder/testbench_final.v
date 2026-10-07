module testbench;
    // Declare testbench signals
    reg [3:0] a;
    reg [3:0] b;
    wire [3:0] sum;
    wire carry;
    integer passed_tests;
    integer failed_tests;

    // Instantiate the module under test
    adder4bit uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    // Testbench logic
    initial begin
        passed_tests = 0;
        failed_tests = 0;

        // Test pattern 1: Minimum input values (both zero)
        a = 4'b0000; b = 4'b0000;
        #10 $display("Test 1: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b0000 && carry === 1'b0) begin
            $display("  Sum: Expected 0000, Got %b ✓", sum);
            $display("  Carry: Expected 0, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b0000) begin
                $display("  Sum: Expected 0000, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 0000, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b0) begin
                $display("  Carry: Expected 0, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 0, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 2: Maximum input values without carry
        a = 4'b0111; b = 4'b0111;
        #10 $display("Test 2: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b1110 && carry === 1'b0) begin
            $display("  Sum: Expected 1110, Got %b ✓", sum);
            $display("  Carry: Expected 0, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b1110) begin
                $display("  Sum: Expected 1110, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 1110, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b0) begin
                $display("  Carry: Expected 0, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 0, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 3: Maximum input values with carry
        a = 4'b1111; b = 4'b0001;
        #10 $display("Test 3: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b0000 && carry === 1'b1) begin
            $display("  Sum: Expected 0000, Got %b ✓", sum);
            $display("  Carry: Expected 1, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b0000) begin
                $display("  Sum: Expected 0000, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 0000, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b1) begin
                $display("  Carry: Expected 1, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 1, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 4: Boundary value just below carry
        a = 4'b1000; b = 4'b0111;
        #10 $display("Test 4: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("  Sum: Expected 1111, Got %b ✓", sum);
            $display("  Carry: Expected 0, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b1111) begin
                $display("  Sum: Expected 1111, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 1111, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b0) begin
                $display("  Carry: Expected 0, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 0, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 5: Boundary value with carry
        a = 4'b1000; b = 4'b1000;
        #10 $display("Test 5: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b0000 && carry === 1'b1) begin
            $display("  Sum: Expected 0000, Got %b ✓", sum);
            $display("  Carry: Expected 1, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b0000) begin
                $display("  Sum: Expected 0000, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 0000, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b1) begin
                $display("  Carry: Expected 1, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 1, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 6: Edge case with alternating bits
        a = 4'b1010; b = 4'b0101;
        #10 $display("Test 6: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("  Sum: Expected 1111, Got %b ✓", sum);
            $display("  Carry: Expected 0, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b1111) begin
                $display("  Sum: Expected 1111, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 1111, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b0) begin
                $display("  Carry: Expected 0, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 0, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 7: Random value
        a = 4'b0011; b = 4'b1100;
        #10 $display("Test 7: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("  Sum: Expected 1111, Got %b ✓", sum);
            $display("  Carry: Expected 0, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b1111) begin
                $display("  Sum: Expected 1111, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 1111, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b0) begin
                $display("  Carry: Expected 0, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 0, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 8: Random value
        a = 4'b1110; b = 4'b0011;
        #10 $display("Test 8: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b0001 && carry === 1'b1) begin
            $display("  Sum: Expected 0001, Got %b ✓", sum);
            $display("  Carry: Expected 1, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b0001) begin
                $display("  Sum: Expected 0001, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 0001, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b1) begin
                $display("  Carry: Expected 1, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 1, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 9: Random value
        a = 4'b0100; b = 4'b1011;
        #10 $display("Test 9: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("  Sum: Expected 1111, Got %b ✓", sum);
            $display("  Carry: Expected 0, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b1111) begin
                $display("  Sum: Expected 1111, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 1111, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b0) begin
                $display("  Carry: Expected 0, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 0, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        // Test pattern 10: Random value
        a = 4'b0110; b = 4'b1001;
        #10 $display("Test 10: a = %b, b = %b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("  Sum: Expected 1111, Got %b ✓", sum);
            $display("  Carry: Expected 0, Got %b ✓", carry);
            passed_tests = passed_tests + 2;
        end else begin
            if (sum !== 4'b1111) begin
                $display("  Sum: Expected 1111, Got %b ✗", sum);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Sum: Expected 1111, Got %b ✓", sum);
                passed_tests = passed_tests + 1;
            end
            if (carry !== 1'b0) begin
                $display("  Carry: Expected 0, Got %b ✗", carry);
                failed_tests = failed_tests + 1;
            end else begin
                $display("  Carry: Expected 0, Got %b ✓", carry);
                passed_tests = passed_tests + 1;
            end
        end

        $display("Test Summary:");
        $display("  Total Tests Run: %d", passed_tests + failed_tests);
        $display("  Number Passed: %d", passed_tests);
        $display("  Number Failed: %d", failed_tests);

        $finish;
    end
endmodule