module mux2_1(input wire in1, input wire in2, input wire select, output wire out);
    assign out = select ? in2 : in1;
endmodule
module mux4_1(input [1:0] sel, input [3:0] in, output out);
  assign out = in[sel];
endmodule
module mux8_1(input [2:0] sel, input [7:0] in, output out);
    wire [1:0] x0, x1;

    assign x0 = sel[0] ? in[5:4] : in[1:0];
    assign x1 = sel[0] ? in[7:6] : in[3:2];

    assign out = sel[2] ? (sel[1] ? in[3] : in[7]) : (sel[1] ? x0[0] : x1[0]);
endmodule
module mux16_1(input [3:0] sel, input [15:0] in, output out);
    assign out = in[sel];
endmodule
module mux32_1(input [4:0] sel, input [31:0] in, output out);
  assign out = in[sel];
endmodule
module mux64_1(input [5:0] sel, input [63:0] in, output out);
  wire [63:0] masked;
  assign masked = in & (1'b1 << sel);
  assign out = |masked;
endmodule
