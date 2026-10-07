module mux2to1_tb;
    // Declare input signals as reg type
    reg a;
    reg b;
    reg sel;

    // Declare output signal as wire type
    wire y;

    // Instantiate the module under test
    mux2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    // Testbench initial block
    initial begin
        // Initialize test counters
        integer passed_tests = 0;
        integer failed_tests = 0;

        // Test case 1: sel=0, a=0, b=0
        a = 0; b = 0; sel = 0;
        #10;
        $display("Test case 1: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 0) begin
            $display("✓ Pass: Expected y=0");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=0, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 2: sel=0, a=0, b=1
        a = 0; b = 1; sel = 0;
        #10;
        $display("Test case 2: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 0) begin
            $display("✓ Pass: Expected y=0");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=0, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 3: sel=0, a=1, b=0
        a = 1; b = 0; sel = 0;
        #10;
        $display("Test case 3: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 1) begin
            $display("✓ Pass: Expected y=1");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=1, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 4: sel=0, a=1, b=1
        a = 1; b = 1; sel = 0;
        #10;
        $display("Test case 4: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 1) begin
            $display("✓ Pass: Expected y=1");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=1, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 5: sel=1, a=0, b=0
        a = 0; b = 0; sel = 1;
        #10;
        $display("Test case 5: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 0) begin
            $display("✓ Pass: Expected y=0");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=0, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 6: sel=1, a=0, b=1
        a = 0; b = 1; sel = 1;
        #10;
        $display("Test case 6: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 1) begin
            $display("✓ Pass: Expected y=1");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=1, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 7: sel=1, a=1, b=0
        a = 1; b = 0; sel = 1;
        #10;
        $display("Test case 7: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 0) begin
            $display("✓ Pass: Expected y=0");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=0, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 8: sel=1, a=1, b=1
        a = 1; b = 1; sel = 1;
        #10;
        $display("Test case 8: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        if (y === 1) begin
            $display("✓ Pass: Expected y=1");
            passed_tests = passed_tests + 1;
        end else begin
            $display("✗ Fail: Expected y=1, Got y=%b", y);
            failed_tests = failed_tests + 1;
        end

        // Test summary
        $display("Total tests run: %0d", passed_tests + failed_tests);
        $display("Number passed: %0d", passed_tests);
        $display("Number failed: %0d", failed_tests);

        $finish;
    end
endmodule