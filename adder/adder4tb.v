
`timescale 1ns/1ps

module adder4tb;
    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    wire [3:0] sum;
    wire cout;
    reg [4:0] expected;
    integer i;
    integer j;
    integer k;
    integer test_count;

    adder4 dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        test_count = 0;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    a = i;
                    b = j;
                    cin = k;
                    expected = {1'b0, a}
                             + {1'b0, b}
                             + {4'b0000, cin};
                    #10;

                    if ({cout, sum} !== expected) begin
                        $display(
                            "FAILED: a=%d b=%d cin=%b expected=%d actual=%d",
                            a, b, cin, expected, {cout, sum}
                        );
                        $fatal(1, "Functional mismatch");
                    end

                    test_count = test_count + 1;
                end
            end
        end

        $display("adder4: all %0d tests passed!", test_count);
        $finish;
    end
endmodule
