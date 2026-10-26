
`timescale 1ns/1ps

module adder8tb;
    reg [7:0] a;
    reg [7:0] b;
    reg cin;
    wire [7:0] sum;
    wire cout;
    integer test_count;

    adder8 dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task check;
        input [7:0] test_a;
        input [7:0] test_b;
        input test_cin;
        reg [8:0] expected;
        begin
            a = test_a;
            b = test_b;
            cin = test_cin;

            expected = {1'b0, test_a}
                     + {1'b0, test_b}
                     + {8'b0, test_cin};
            #10;

            if ({cout, sum} !== expected) begin
                $display(
                    "FAILED: a=%h b=%h cin=%b expected=%h actual=%h",
                    a, b, cin, expected, {cout, sum}
                );
                $fatal(1, "Functional mismatch");
            end

            test_count = test_count + 1;
        end
    endtask

    initial begin
        $dumpfile("adder8.vcd");
        $dumpvars(0, adder8tb);

        test_count = 0;

        check(8'h00, 8'h00, 1'b0);
        check(8'h01, 8'h00, 1'b0);
        check(8'h00, 8'h01, 1'b0);
        check(8'h03, 8'h04, 1'b0);
        check(8'h0F, 8'h01, 1'b0);
        check(8'h10, 8'h20, 1'b0);
        check(8'hFF, 8'h01, 1'b0);
        check(8'h00, 8'h00, 1'b1);

        $display("adder8: all %0d tests passed!", test_count);
        $finish;
    end
endmodule
