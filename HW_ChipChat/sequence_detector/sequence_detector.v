module sequence_detector (
    input  wire       clk,
    input  wire       reset_n,
    input  wire [2:0] data,
    output reg        sequence_found
);

    localparam [2:0]
        S0 = 3'd0,
        S1 = 3'd1,
        S2 = 3'd2,
        S3 = 3'd3,
        S4 = 3'd4,
        S5 = 3'd5,
        S6 = 3'd6,
        S7 = 3'd7;

    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state     = state;
        sequence_found = 1'b0;

        if (!reset_n) begin
            next_state     = S0;
            sequence_found = 1'b0;
        end
        else begin
            case (state)
                S0: begin
                    if (data == 3'b001)
                        next_state = S1;
                    else
                        next_state = S0;
                end

                S1: begin
                    if (data == 3'b101)
                        next_state = S2;
                    else if (data == 3'b001)
                        next_state = S1;
                    else
                        next_state = S0;
                end

                S2: begin
                    if (data == 3'b110)
                        next_state = S3;
                    else if (data == 3'b001)
                        next_state = S1;
                    else
                        next_state = S0;
                end

                S3: begin
                    if (data == 3'b000)
                        next_state = S4;
                    else if (data == 3'b001)
                        next_state = S1;
                    else
                        next_state = S0;
                end

                S4: begin
                    if (data == 3'b110)
                        next_state = S5;
                    else if (data == 3'b001)
                        next_state = S1;
                    else
                        next_state = S0;
                end

                S5: begin
                    if (data == 3'b110)
                        next_state = S6;
                    else if (data == 3'b001)
                        next_state = S1;
                    else
                        next_state = S0;
                end

                S6: begin
                    if (data == 3'b011)
                        next_state = S7;
                    else if (data == 3'b001)
                        next_state = S1;
                    else
                        next_state = S0;
                end

                S7: begin
                    if (data == 3'b101) begin
                        sequence_found = 1'b1;
                        next_state     = S0;
                    end
                    else if (data == 3'b001) begin
                        next_state = S1;
                    end
                    else begin
                        next_state = S0;
                    end
                end

                default: begin
                    next_state     = S0;
                    sequence_found = 1'b0;
                end
            endcase
        end
    end

endmodule