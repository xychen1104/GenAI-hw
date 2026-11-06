`timescale 1ns/1ps
`default_nettype none

module spi_baseline_tb;
    // Match MicroPython SoftSPI at 50 kHz, CPOL=0, CPHA=0, MSB first.
    localparam integer HALF_PERIOD = 10_000;
    localparam [31:0] PLAINTEXT = 32'h59C359C3;
    localparam [31:0] CIPHERTEXT = 32'h9CD84392;

    reg sck = 0;
    reg rst_n = 1;
    reg mosi = 0;
    reg cs_n = 1;
    reg start = 0;
    reg enc_dec = 0;
    wire miso;
    wire busy;
    wire ice_led;
    reg [31:0] readback;
    integer failures = 0;

    qualifier_core dut (
        .pin_36(sck), .pin_34(rst_n), .pin_32(mosi), .pin_31(miso),
        .pin_28(cs_n), .pin_27(start), .pin_25(enc_dec),
        .pin_38(busy), .pin_23(ice_led)
    );

    task clock_cycle;
        begin
            #(HALF_PERIOD) sck = 1;
            #(HALF_PERIOD) sck = 0;
        end
    endtask

    task reset_core;
        begin
            rst_n = 0;
            clock_cycle;
            rst_n = 1;
            clock_cycle;
        end
    endtask

    task transfer_word;
        input [31:0] tx;
        output [31:0] rx;
        integer bit_index;
        begin
            cs_n = 0;
            for (bit_index = 31; bit_index >= 0; bit_index = bit_index - 1) begin
                mosi = tx[bit_index];
                #(HALF_PERIOD) sck = 1;
                // MISO is registered on the rising edge. Let it settle
                // before sampling within the same high phase.
                #1 rx[bit_index] = miso;
                #(HALF_PERIOD - 1) sck = 0;
            end
            cs_n = 1;
        end
    endtask

    task run_crypto;
        output timing_ok;
        integer cycle;
        begin
            start = 1;
            clock_cycle;
            start = 0;
            #1 timing_ok = (busy === 1'b1);
            // Use the same seven additional clocks as the reference script.
            for (cycle = 0; cycle < 7; cycle = cycle + 1)
                clock_cycle;
            timing_ok = timing_ok && (busy === 1'b0);
        end
    endtask

    task check_word;
        input [127:0] label;
        input [31:0] actual;
        input [31:0] expected;
        input timing_ok;
        begin
            if ((actual === expected) && timing_ok)
                $display("PASS %-16s got 0x%08h, expected 0x%08h",
                         label, actual, expected);
            else begin
                failures = failures + 1;
                $display("FAIL %-16s got 0x%08h, expected 0x%08h, BUSY check=%0b",
                         label, actual, expected, timing_ok);
            end
        end
    endtask

    reg timing_ok;
    initial begin
        if ($test$plusargs("vcd")) begin
            $dumpfile("spi_baseline.vcd");
            $dumpvars(1, spi_baseline_tb);
        end

        reset_core;
        transfer_word(PLAINTEXT, readback);
        transfer_word(PLAINTEXT, readback);
        check_word("SPI readback", readback, PLAINTEXT, 1'b1);

        enc_dec = 0;
        run_crypto(timing_ok);
        transfer_word(PLAINTEXT, readback);
        check_word("Encryption", readback, CIPHERTEXT, timing_ok);

        enc_dec = 1;
        reset_core;
        transfer_word(CIPHERTEXT, readback);
        run_crypto(timing_ok);
        transfer_word(CIPHERTEXT, readback);
        check_word("Decryption", readback, PLAINTEXT, timing_ok);

        if (failures != 0)
            $fatal(1, "%0d of 3 baseline checks failed", failures);
        $display("PASS all 3 baseline checks");
        $finish;
    end
endmodule

`default_nettype wire
