
`timescale 1ns/1ps

module half_addertb;
    reg a;
    reg b;
    wire sum;
    wire carry;
    reg [1:0] expected;
    integer i;

    half_adder dut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            {a, b} = i;
            expected = {1'b0, a} + {1'b0, b};
            #10;

            if ({carry, sum} !== expected) begin
                $display(
                    "FAILED: a=%b b=%b expected=%b actual=%b",
                    a, b, expected, {carry, sum}
                );
                $fatal(1, "Functional mismatch");
            end
        end

        $display("half_adder: all 4 tests passed!");
        $finish;
    end
endmodule
