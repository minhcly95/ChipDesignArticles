module twocomp #(
    parameter int N = 8
)(
    input logic[N-1:0] a,
    output logic[N-1:0] y
);
    logic[N-2:0] x;

    // Prefix OR
    prefix_or #(N-1) tree(a[N-2:0], x);

    // Use `x << 1` to flip bits in `a`
    assign y[0] = a[0];
    assign y[N-1:1] = x ^ a[N-1:1];
endmodule

module prefix_or #(
    parameter int N = 7
)(
    input logic[N-1:0] a,
    output logic[N-1:0] y
);
    localparam MH = N / 2;      // Smaller half (high half)
    localparam ML = N - MH;     // Bigger half (low half)

    generate
        if (N === 1) begin
            // Base case
            assign y = a;
        end
        else begin
            // Recursive case
            logic[MH-1:0] yhigh;
            logic[ML-1:0] ylow;

            prefix_or #(MH) hightree(a[N-1:ML], yhigh);
            prefix_or #(ML) lowtree(a[ML-1:0], ylow);

            assign y[N-1:ML] = yhigh | {MH{ylow[ML-1]}};
            assign y[ML-1:0] = ylow;
        end
    endgenerate
endmodule
