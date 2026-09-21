module sequence_generator (
    input  wire       clk,
    input  wire       reset_n,  // asynchronous active-low reset
    input  wire       enable,
    output reg  [7:0] data
);

    reg [2:0] index;

    // Advance through the sequence while enabled
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            index <= 3'd0;
        else if (enable) begin
            if (index == 3'd7)
                index <= 3'd0;
            else
                index <= index + 3'd1;
        end
    end

    // Sequence lookup table
    always @(*) begin
        case (index)
            3'd0: data = 8'hAF;
            3'd1: data = 8'hBC;
            3'd2: data = 8'hE2;
            3'd3: data = 8'h78;
            3'd4: data = 8'hFF;
            3'd5: data = 8'hE2;
            3'd6: data = 8'h0B;
            3'd7: data = 8'h8D;
            default: data = 8'hAF;
        endcase
    end

endmodule