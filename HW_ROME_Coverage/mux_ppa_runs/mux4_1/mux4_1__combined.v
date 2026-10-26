module mux2_1(input wire in1, input wire in2, input wire select, output wire out);
    assign out = select ? in2 : in1;
endmodule
module mux4_1(input [1:0] sel, input [3:0] in, output out);
  wire n0, n1, n2, n3;
  assign n0 = ~sel[1] & ~sel[0];
  assign n1 = ~sel[1] & sel[0];
  assign n2 = sel[1] & ~sel[0];
  assign n3 = sel[1] & sel[0];
  assign out = (in[0] & n0) | (in[1] & n1) | (in[2] & n2) | (in[3] & n3);
endmodule
