module lfsr (
    input  wire       clk,
    input  wire       reset_n,
    output reg  [7:0] data
);

    always @(negedge clk or negedge reset_n) begin
        if (!reset_n)
            data <= 8'b10001010;
        else
            data <= {data[6:0], data[0] ^ data[3] ^ data[5] ^ data[6]};
    end

endmodule