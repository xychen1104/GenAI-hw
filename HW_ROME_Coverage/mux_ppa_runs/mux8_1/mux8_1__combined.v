module mux2_1(input wire in1, input wire in2, input wire select, output wire out);
    assign out = select ? in2 : in1;
endmodule
module mux4_1(input [1:0] sel, input [3:0] in, output out);
  assign out = in[sel];
endmodule
module mux8_1(input [2:0] sel, input [7:0] in, output out);
    wire [1:0] x0, x1;

    assign x0 = sel[0] ? in[7:6] : in[3:2];
    assign x1 = sel[0] ? in[5:4] : in[1:0];

    assign out = sel[2] ? (sel[1] ? x0[1] : x1[1]) : (sel[1] ? x0[0] : x1[0]);
endmodule
