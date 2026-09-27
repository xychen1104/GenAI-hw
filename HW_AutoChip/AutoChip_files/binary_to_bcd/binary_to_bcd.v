
module binary_to_bcd_converter (
    input [4:0] binary_input,
    output reg [7:0] bcd_output
);

    integer i;

    always @* begin
        // Initialize BCD output to 0
        bcd_output = 8'b0;

        // Convert binary to BCD
        for (i = 0; i < 5; i = i + 1) begin
            if (bcd_output[3:0] > 4'd4) 
                bcd_output[3:0] = bcd_output[3:0] + 3; // Adjust for BCD

            if (bcd_output[7:4] > 4'd4) 
                bcd_output[7:4] = bcd_output[7:4] + 3; // Adjust for BCD

            bcd_output = bcd_output << 1; // Shift left to make room for the next bit
            bcd_output[0] = binary_input[4 - i]; // Add the next bit from binary input
        end
    end

endmodule
