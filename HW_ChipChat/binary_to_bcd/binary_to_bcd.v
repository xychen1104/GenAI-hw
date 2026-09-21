module binary_to_bcd_converter(
    input      [4:0] binary_input,
    output reg [7:0] bcd_output
);

    integer i;

    always @(*) begin
        bcd_output = 8'b0;

        for (i = 4; i >= 0; i = i - 1) begin
            if (bcd_output[3:0] >= 4'd5)
                bcd_output[3:0] = bcd_output[3:0] + 4'd3;

            if (bcd_output[7:4] >= 4'd5)
                bcd_output[7:4] = bcd_output[7:4] + 4'd3;

            bcd_output = {bcd_output[6:0], binary_input[i]};
        end
    end

endmodule