module mux_tb();
    logic[7:0] a;
    logic[2:0] s;
    logic y;

    logic expected;
    int num_errors = 0;

    mux dut(a, s, y);

    initial begin
        for (int i = 0; i < 256; i++) begin
            {a, s} = $urandom;
            expected = a[s];
            #1;
            if (expected !== y) begin
                $display("Error: a = %b, s = %d, result = %b, expected = %b",
                        a, s, y, expected);
                num_errors++;
            end
            #1;
        end
        $display("Test finished with %3d errors.", num_errors);
    end
endmodule
