module traffic_light_fsm (
    input  wire clk,
    input  wire reset_n,
    input  wire enable,
    output reg  red,
    output reg  yellow,
    output reg  green
);

    localparam [1:0] RED_STATE    = 2'b00;
    localparam [1:0] GREEN_STATE  = 2'b01;
    localparam [1:0] YELLOW_STATE = 2'b10;

    reg [1:0] state;
    reg [5:0] cycle_count;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state       <= RED_STATE;
            cycle_count <= 6'd0;
        end else if (enable) begin
            case (state)
                RED_STATE: begin
                    if (cycle_count == 6'd31) begin
                        state       <= GREEN_STATE;
                        cycle_count <= 6'd0;
                    end else begin
                        cycle_count <= cycle_count + 6'd1;
                    end
                end

                GREEN_STATE: begin
                    if (cycle_count == 6'd19) begin
                        state       <= YELLOW_STATE;
                        cycle_count <= 6'd0;
                    end else begin
                        cycle_count <= cycle_count + 6'd1;
                    end
                end

                YELLOW_STATE: begin
                    if (cycle_count == 6'd6) begin
                        state       <= RED_STATE;
                        cycle_count <= 6'd0;
                    end else begin
                        cycle_count <= cycle_count + 6'd1;
                    end
                end

                default: begin
                    state       <= RED_STATE;
                    cycle_count <= 6'd0;
                end
            endcase
        end
    end

    always @(*) begin
        red    = 1'b0;
        yellow = 1'b0;
        green  = 1'b0;

        case (state)
            RED_STATE:    red    = 1'b1;
            GREEN_STATE:  green  = 1'b1;
            YELLOW_STATE: yellow = 1'b1;
            default:      red    = 1'b1;
        endcase
    end

endmodule