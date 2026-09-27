
module shift_register (
    input wire clk,
    input wire reset_n,
    input wire data_in,
    input wire shift_enable,
    output reg [7:0] data_out
);

initial begin
    data_out = 8'b00010100;
end

always @(negedge clk or negedge reset_n) begin
    if (!reset_n) begin
        data_out <= 8'b00000000;
    end
    else begin
        data_out <= data_out >> 1;
    end
end

endmodule
