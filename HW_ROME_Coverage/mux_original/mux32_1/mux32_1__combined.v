module mux2_1(input wire in1, input wire in2, input wire select, output wire out);
    assign out = select ? in2 : in1;
endmodule
module mux4_1(input [1:0] sel, input [3:0] in, output reg out);
    always @(*) begin
        case (sel)
            2'b00: out = in[0];
            2'b01: out = in[1];
            2'b10: out = in[2];
            2'b11: out = in[3];
            default: out = 1'b0;
        endcase
    end
endmodule
module mux8_1(input [2:0] sel, input [7:0] in, output reg out);
    always @(*) begin
        case (sel)
            3'b000: out = in[0];
            3'b001: out = in[1];
            3'b010: out = in[2];
            3'b011: out = in[3];
            3'b100: out = in[4];
            3'b101: out = in[5];
            3'b110: out = in[6];
            3'b111: out = in[7];
            default: out = 1'b0;
        endcase
    end
endmodule
module mux16_1(input [3:0] sel, input [15:0] in, output out);
    wire out1, out2;

    mux8_1 mux1(.sel(sel[2:0]), .in(in[7:0]), .out(out1));
    mux8_1 mux2(.sel(sel[2:0]), .in(in[15:8]), .out(out2));

    mux2_1 mux3(.in1(out1), .in2(out2), .select(sel[3]), .out(out));
endmodule
module mux32_1(input [4:0] sel, input [31:0] in, output wire out);

    wire out0, out1;

    mux16_1 mux1 (.sel(sel[3:0]), .in(in[15:0]), .out(out0));
    mux16_1 mux2 (.sel(sel[3:0]), .in(in[31:16]), .out(out1));
    mux2_1 mux3 (.in1(out0), .in2(out1), .select(sel[4]), .out(out));

endmodule
