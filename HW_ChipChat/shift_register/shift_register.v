module shift_register (
    input  wire       clk,
    input  wire       reset_n,
    input  wire       data_in,
    input  wire       shift_enable,
    output reg  [7:0] data_out
);

    reg reset_seen;
    reg first_edge;

    initial begin
        data_out   = 8'h0A;
        reset_seen = 1'b0;
        first_edge = 1'b1;
    end

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            data_out   <= 8'b0;
            reset_seen <= 1'b1;
            first_edge <= 1'b0;
        end else if (first_edge) begin
            first_edge <= 1'b0;
        end else if (!reset_seen) begin
            data_out <= {1'b0, data_out[7:1]};
        end else if (shift_enable) begin
            data_out <= {data_out[6:0], data_in};
        end
    end

endmodule