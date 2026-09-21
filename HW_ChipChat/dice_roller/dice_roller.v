module dice_roller (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [1:0] die_select,
    input  wire       roll,
    output reg  [7:0] rolled_number
);

    reg [15:0] lfsr;
    reg        roll_d;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr          <= 16'hACE1;
            roll_d        <= 1'b0;
            rolled_number <= 8'd1;
        end else begin
            roll_d <= roll;

            // 16-bit pseudo-random linear-feedback shift register
            lfsr <= {lfsr[14:0],
                     lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]};

            // Generate a new result on the rising edge of roll
            if (roll && !roll_d) begin
                case (die_select)
                    2'b00: rolled_number <= (lfsr % 16'd4)  + 8'd1;
                    2'b01: rolled_number <= (lfsr % 16'd6)  + 8'd1;
                    2'b10: rolled_number <= (lfsr % 16'd8)  + 8'd1;
                    2'b11: rolled_number <= (lfsr % 16'd20) + 8'd1;
                    default: rolled_number <= 8'd1;
                endcase
            end
        end
    end

endmodule