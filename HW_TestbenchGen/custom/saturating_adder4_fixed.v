
module saturating_adder4 (
    input wire [3:0] a,
    input wire [3:0] b,
    output wire [3:0] y
);

    wire [4:0] sum_ext;

    assign sum_ext = a + b;
    assign y = (sum_ext > 5'd15) ? 4'd15 : sum_ext[3:0];

endmodule
