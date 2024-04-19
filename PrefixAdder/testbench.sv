module testbench();
    logic[7:0] a, b, s;
    logic cin, cout;

    int unsigned expected;
    int num_errors = 0;

    prefix_adder dut(a, b, cin, s, cout);

    initial begin
        for (int i = 0; i < 256; i++) begin
            a = $urandom;
            b = $urandom;
            cin = $urandom;
            expected = a + b + cin;
            #1;
            if (expected !== {cout, s}) begin
                $display("Error: a = %b, b = %b, cin = %b, result = %b, expected = %b",
                        a, b, cin, {cout, s}, expected[8:0]);
                num_errors++;
            end
            #1;
        end
        $display("Test finished with %3d errors.", num_errors);
    end
endmodule
