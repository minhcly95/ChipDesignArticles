module priority_enc_tb();
    logic[7:0] a;
    logic[2:0] y;
    logic none;

    logic[7:0] b;
    int shift;
    logic[2:0] y_expected;
    logic none_expected;
    int num_errors = 0;

    priority_enc dut(a, y, none);

    initial begin
        for (int i = 0; i < 256; i++) begin
            b = $urandom;
            b[7] = 1;
            shift = $urandom_range(8);
            a = b >> shift;

            if (shift < 8) begin
                y_expected = 7 - shift;
                none_expected = 0;
            end
            else begin
                y_expected = 0;
                none_expected = 1;
            end

            #1;
            if (y_expected !== y || none_expected !== none) begin
                $display("Error: a = %b, result = %b, expected = %b",
                        a, {y, none}, {y_expected, none_expected});
                num_errors++;
            end
            #1;
        end
        $display("Test finished with %3d errors.", num_errors);
    end
endmodule
