
`timescale 1ns/1ps

module full_addertb;
    reg a;
    reg b;
    reg cin;
    wire sum;
    wire cout;
    reg [1:0] expected;
    integer i;

    full_adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i;
            expected = {1'b0, a}
                     + {1'b0, b}
                     + {1'b0, cin};
            #10;

            if ({cout, sum} !== expected) begin
                $display(
                    "FAILED: a=%b b=%b cin=%b expected=%b actual=%b",
                    a, b, cin, expected, {cout, sum}
                );
                $fatal(1, "Functional mismatch");
            end
        end

        $display("full_adder: all 8 tests passed!");
        $finish;
    end
endmodule
