
module dice_roller (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [1:0] die_select,
    input  wire       roll,
    output reg  [7:0] rolled_number
);

    reg [7:0] lfsr;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr <= 8'hA5;
            rolled_number <= 8'd1;
        end else begin
            // Simple pseudo-random state update.
            lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3]};

            if (roll) begin
                case (die_select)
                    2'b00: rolled_number <= (lfsr % 4)  + 1;
                    2'b01: rolled_number <= (lfsr % 6)  + 1;
                    2'b10: rolled_number <= (lfsr % 8)  + 1;
                    2'b11: rolled_number <= (lfsr % 20) + 1;
                    default: rolled_number <= 8'd1;
                endcase
            end
        end
    end

endmodule
