module testbench;
    // Declare testbench signals
    reg [3:0] a;
    reg [3:0] b;
    wire [3:0] sum;
    wire carry;

    // Instantiate the module under test
    adder4bit uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    // Testbench logic
    initial begin
        // Test pattern 1: Minimum input values (both zero)
        a = 4'b0000; b = 4'b0000;
        #10 $display("Test 1: a = %b, b = %b", a, b);

        // Test pattern 2: Maximum input values without carry
        a = 4'b0111; b = 4'b0111;
        #10 $display("Test 2: a = %b, b = %b", a, b);

        // Test pattern 3: Maximum input values with carry
        a = 4'b1111; b = 4'b0001;
        #10 $display("Test 3: a = %b, b = %b", a, b);

        // Test pattern 4: Boundary value just below carry
        a = 4'b1000; b = 4'b0111;
        #10 $display("Test 4: a = %b, b = %b", a, b);

        // Test pattern 5: Boundary value with carry
        a = 4'b1000; b = 4'b1000;
        #10 $display("Test 5: a = %b, b = %b", a, b);

        // Test pattern 6: Edge case with alternating bits
        a = 4'b1010; b = 4'b0101;
        #10 $display("Test 6: a = %b, b = %b", a, b);

        // Test pattern 7: Random value
        a = 4'b0011; b = 4'b1100;
        #10 $display("Test 7: a = %b, b = %b", a, b);

        // Test pattern 8: Random value
        a = 4'b1110; b = 4'b0011;
        #10 $display("Test 8: a = %b, b = %b", a, b);

        // Test pattern 9: Random value
        a = 4'b0100; b = 4'b1011;
        #10 $display("Test 9: a = %b, b = %b", a, b);

        // Test pattern 10: Random value
        a = 4'b0110; b = 4'b1001;
        #10 $display("Test 10: a = %b, b = %b", a, b);

        $finish;
    end
endmodule