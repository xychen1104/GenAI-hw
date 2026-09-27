
module traffic_light_fsm (
    input  wire clk,
    input  wire reset_n,
    input  wire enable,
    output reg  red,
    output reg  yellow,
    output reg  green
);

    localparam RED_STATE    = 2'd0;
    localparam GREEN_STATE  = 2'd1;
    localparam YELLOW_STATE = 2'd2;

    reg [1:0] state;
    reg [5:0] counter;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state   <= RED_STATE;
            counter <= 6'd0;
        end else if (enable) begin
            case (state)
                RED_STATE: begin
                    if (counter == 6'd31) begin
                        state   <= GREEN_STATE;
                        counter <= 6'd0;
                    end else
                        counter <= counter + 6'd1;
                end

                GREEN_STATE: begin
                    if (counter == 6'd19) begin
                        state   <= YELLOW_STATE;
                        counter <= 6'd0;
                    end else
                        counter <= counter + 6'd1;
                end

                YELLOW_STATE: begin
                    if (counter == 6'd6) begin
                        state   <= RED_STATE;
                        counter <= 6'd0;
                    end else
                        counter <= counter + 6'd1;
                end

                default: begin
                    state   <= RED_STATE;
                    counter <= 6'd0;
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
