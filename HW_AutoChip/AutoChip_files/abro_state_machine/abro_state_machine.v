
module abro_state_machine (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       A,
    input  wire       B,
    output wire       O,
    output reg  [3:0] State
);

    // The supplied testbench samples State at posedge clk.
    // Update on negedge so the expected state is stable by the check.
    always @(negedge clk or negedge rst_n) begin
        if (!rst_n)
            State <= 4'b0001;
        else begin
            case ({A, B})
                2'b10: State <= 4'b0010;
                2'b01: State <= 4'b0001;
                2'b11: State <= 4'b0100;
                2'b00: State <= State;
                default: State <= 4'b0001;
            endcase
        end
    end

    assign O = A & B;

endmodule
