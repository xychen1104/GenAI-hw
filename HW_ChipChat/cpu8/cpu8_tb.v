
`timescale 1ns/1ps

module cpu8_tb;

    reg clk;
    reg reset_n;

    wire [7:0] mem_addr;
    wire [7:0] mem_wdata;
    wire       mem_rd;
    wire       mem_wr;
    wire       halted;

    wire [7:0] mem_rdata;

    reg [7:0] memory [0:255];

    cpu8 dut (
        .clk(clk),
        .reset_n(reset_n),

        .mem_addr(mem_addr),
        .mem_rdata(mem_rdata),
        .mem_wdata(mem_wdata),
        .mem_rd(mem_rd),
        .mem_wr(mem_wr),

        .halted(halted)
    );

    // Asynchronous read memory
    assign mem_rdata = memory[mem_addr];

    // Synchronous write memory
    always @(posedge clk) begin
        if (mem_wr)
            memory[mem_addr] <= mem_wdata;
    end

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    integer i;
    integer cycles;


    task clear_memory;
        integer j;
        begin
            for (j = 0; j < 256; j = j + 1)
                memory[j] = 8'h00;
        end
    endtask


    task reset_cpu;
        begin
            reset_n = 0;

            repeat (2) begin
                @(posedge clk);
                #1;
            end

            @(negedge clk);
            reset_n = 1;
        end
    endtask


    task run_until_halt;
        begin
            cycles = 0;

            while (!halted && cycles < 100) begin
                @(posedge clk);
                #1;
                cycles = cycles + 1;
            end

            if (!halted) begin
                $display("ERROR: CPU did not halt.");
                $finish;
            end
        end
    endtask


    // Safety check
    always @(posedge clk) begin
        if (mem_rd && mem_wr) begin
            $display("ERROR: mem_rd and mem_wr high simultaneously.");
            $finish;
        end
    end


    initial begin

        /*
        ============================================================
        PROGRAM 1
        Test:
        LDI4, TAX, TXA, STA, ADD, SUB, ORI4,
        INX, DEX, BZ, HALT
        ============================================================
        */

        clear_memory();

        memory[0]  = 8'h1F; // LDI4 0xF
        memory[1]  = 8'h30; // TAX
        memory[2]  = 8'h40; // TXA

        memory[3]  = 8'h13; // LDI4 3
        memory[4]  = 8'h60; // STA [X]

        memory[5]  = 8'h12; // LDI4 2
        memory[6]  = 8'h70; // ADD [X] -> 2 + 3 = 5
        memory[7]  = 8'h80; // SUB [X] -> 5 - 3 = 2

        memory[8]  = 8'h21; // ORI4 1 -> 3

        memory[9]  = 8'h90; // INX
        memory[10] = 8'hA0; // DEX

        memory[11] = 8'h10; // LDI4 0 -> Z = 1

        memory[12] = 8'hC1; // BZ +1
        memory[13] = 8'h1E; // MUST BE SKIPPED

        memory[14] = 8'hF0; // HALT

        reset_cpu();
        run_until_halt();

        if (memory[15] !== 8'h03) begin
            $display(
                "ERROR PROGRAM 1: STA failed. memory[15]=%h",
                memory[15]
            );
            $finish;
        end

        if (dut.A !== 8'h00) begin
            $display(
                "ERROR PROGRAM 1: branch failed. A=%h",
                dut.A
            );
            $finish;
        end

        if (dut.X !== 8'h0F) begin
            $display(
                "ERROR PROGRAM 1: X incorrect. X=%h",
                dut.X
            );
            $finish;
        end

        if (dut.Z !== 1'b1) begin
            $display(
                "ERROR PROGRAM 1: Z flag incorrect."
            );
            $finish;
        end

        if (dut.C !== 1'b1) begin
            $display(
                "ERROR PROGRAM 1: SUB carry/no-borrow incorrect."
            );
            $finish;
        end

        $display("PROGRAM 1 PASSED");


        /*
        ============================================================
        PROGRAM 2
        Test:
        JMP X, NOP, BNZ, BRA, HALT
        ============================================================
        */

        clear_memory();

        memory[0]  = 8'h18; // LDI4 8
        memory[1]  = 8'h30; // TAX -> X=8
        memory[2]  = 8'hE0; // JMP X

        // Addresses 3-7 intentionally skipped

        memory[8]  = 8'h00; // NOP
        memory[9]  = 8'h11; // LDI4 1 -> Z=0

        memory[10] = 8'hD1; // BNZ +1
        memory[11] = 8'h1F; // MUST BE SKIPPED

        memory[12] = 8'hB1; // BRA +1
        memory[13] = 8'h1E; // MUST BE SKIPPED

        memory[14] = 8'hF0; // HALT

        reset_cpu();
        run_until_halt();

        if (dut.A !== 8'h01) begin
            $display(
                "ERROR PROGRAM 2: branch/JMP behavior incorrect. A=%h",
                dut.A
            );
            $finish;
        end

        if (dut.X !== 8'h08) begin
            $display(
                "ERROR PROGRAM 2: JMP register incorrect. X=%h",
                dut.X
            );
            $finish;
        end

        $display("PROGRAM 2 PASSED");

        $display("");
        $display("====================================");
        $display("ALL CPU TESTS PASSED!");
        $display("====================================");

        $finish;
    end

endmodule
