
module sequence_detector (
    input clk,
    input reset_n,
    input [2:0] data,
    output sequence_found
);

    reg [3:0] state;

    localparam S0 = 4'd0,
               S1 = 4'd1,
               S2 = 4'd2,
               S3 = 4'd3,
               S4 = 4'd4,
               S5 = 4'd5,
               S6 = 4'd6,
               S7 = 4'd7;

    assign sequence_found = (state == S7 && data == 3'b101);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= S0;
        end else begin
            case (state)
                S0: if (data == 3'b001) state <= S1; else state <= S0;
                S1: if (data == 3'b101) state <= S2; else state <= S0;
                S2: if (data == 3'b110) state <= S3; else state <= S0;
                S3: if (data == 3'b000) state <= S4; else state <= S0;
                S4: if (data == 3'b110) state <= S5; else state <= S0;
                S5: if (data == 3'b110) state <= S6; else state <= S0;
                S6: if (data == 3'b011) state <= S7; else state <= S0;
                S7: state <= S0;
                default: state <= S0;
            endcase
        end
    end

endmodule
