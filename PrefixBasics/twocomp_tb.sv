module twocomp_tb();
    logic[7:0] a, y, y_exp;
    int num_errors = 0;

    twocomp dut(a, y);

    initial begin
        for (int i = 0; i < 256; i++) begin
            a = $urandom;
            y_exp = -a;

            #1;
            if (y_exp !== y) begin
                $display("Error: a = %b, result = %b, expected = %b", a, y, y_exp);
                num_errors++;
            end
            #1;
        end
        $display("Test finished with %3d errors.", num_errors);
    end
endmodule
