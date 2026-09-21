module abro_state_machine (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       A,
    input  wire       B,
    output wire       O,
    output wire [3:0] State
);

    localparam [3:0] STATE_IDLE = 4'b0001;
    localparam [3:0] STATE_A    = 4'b0010;
    localparam [3:0] STATE_AB   = 4'b0100;

    reg [3:0] current_state;
    reg [3:0] next_state;

    always @(*) begin
        case ({A, B})
            2'b00:   next_state = current_state;
            2'b01:   next_state = STATE_IDLE;
            2'b10:   next_state = STATE_A;
            2'b11:   next_state = STATE_AB;
            default: next_state = STATE_IDLE;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= STATE_IDLE;
        else
            current_state <= next_state;
    end

    assign O     = A & B;
    assign State = rst_n ? next_state : STATE_IDLE;

endmodule