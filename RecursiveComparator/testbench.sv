module testbench();
    logic[7:0] a, b;
    logic eq, lt;

    logic[1:0] set_eq;
    logic[1:0] expected;
    int num_errors = 0;

    comparator #(8) dut(a, b, eq, lt);

    initial begin
        for (int i = 0; i < 256; i++) begin
            {a, b, set_eq} = $urandom;
            if (set_eq === 0)     // 25% chance to set b = a
                b = a;

            expected = {a == b, a < b};
            #1;
            if (expected !== {eq, lt}) begin
                $display("Error: a = %b, b = %b, result = %b, expected = %b",
                        a, b, {eq, lt}, expected);
                num_errors++;
            end
            #1;
        end
        $display("Test finished with %3d errors.", num_errors);
    end
endmodule
