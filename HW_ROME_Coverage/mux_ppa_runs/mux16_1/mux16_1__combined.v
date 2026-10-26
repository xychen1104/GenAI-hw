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
    wire [15:0] selected;
    assign selected = {16{1'b0}} | (sel == 4'd0  ? in[0]  :
                                      sel == 4'd1  ? in[1]  :
                                      sel == 4'd2  ? in[2]  :
                                      sel == 4'd3  ? in[3]  :
                                      sel == 4'd4  ? in[4]  :
                                      sel == 4'd5  ? in[5]  :
                                      sel == 4'd6  ? in[6]  :
                                      sel == 4'd7  ? in[7]  :
                                      sel == 4'd8  ? in[8]  :
                                      sel == 4'd9  ? in[9]  :
                                      sel == 4'd10 ? in[10] :
                                      sel == 4'd11 ? in[11] :
                                      sel == 4'd12 ? in[12] :
                                      sel == 4'd13 ? in[13] :
                                      sel == 4'd14 ? in[14] :
                                      in[15]);
    assign out = |selected;
endmodule
