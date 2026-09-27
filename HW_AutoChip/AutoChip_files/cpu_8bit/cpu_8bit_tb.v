
`timescale 1ns/1ps

module cpu_8bit_tb;

    reg clk;
    reg reset_n;
    reg [7:0] instruction;

    wire [7:0] pc;
    wire [7:0] accumulator;
    wire [7:0] out_port;
    wire halted;

    cpu_8bit dut (
        .clk(clk),
        .reset_n(reset_n),
        .instruction(instruction),
        .pc(pc),
        .accumulator(accumulator),
        .out_port(out_port),
        .halted(halted)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    always @(*) begin
        case (pc)
            8'd0: instruction = 8'h13; // LDI 3
            8'd1: instruction = 8'h22; // ADD 2 -> 5
            8'd2: instruction = 8'h31; // SUB 1 -> 4
            8'd3: instruction = 8'h63; // XOR 3 -> 7
            8'd4: instruction = 8'hA0; // OUT
            8'd5: instruction = 8'hF0; // HALT
            default: instruction = 8'h00;
        endcase
    end

    initial begin
        reset_n = 0;

        #12;
        reset_n = 1;

        repeat (10) @(posedge clk);
        #1;

        if (halted !== 1'b1) begin
            $display("FAIL: CPU did not halt.");
            $finish;
        end

        if (accumulator !== 8'd7) begin
            $display(
                "FAIL: Expected accumulator=7, got %0d",
                accumulator
            );
            $finish;
        end

        if (out_port !== 8'd7) begin
            $display(
                "FAIL: Expected out_port=7, got %0d",
                out_port
            );
            $finish;
        end

        $display("PASS: CPU test completed successfully.");
        $display(
            "Final accumulator=%0d, out_port=%0d",
            accumulator,
            out_port
        );

        $finish;
    end

endmodule
