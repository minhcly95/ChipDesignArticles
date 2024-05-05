module pe_onehot #(
    parameter int N = 8
)(
    input logic[N-1:0] a,
    output logic[N-1:0] y
);
    logic[N-1:0] x;

    // Reversed prefix OR
    prefix_or_rev #(N) tree(a, x);

    // Edge detection
    assign y[N-1] = x[N-1];
    assign y[N-2:0] = x[N-2:0] & ~x[N-1:1];
endmodule

module prefix_or_rev #(
    parameter int N = 8
)(
    input logic[N-1:0] a,
    output logic[N-1:0] y
);
    localparam M = N/2;

    generate
        if (N === 1) begin
            // Base case
            assign y = a;
        end
        else begin
            // Recursive case
            logic[M-1:0] yhigh, ylow;

            prefix_or_rev #(M) hightree(a[N-1:M], yhigh);
            prefix_or_rev #(M) lowtree(a[M-1:0], ylow);

            assign y[M-1:0] = ylow | {M{yhigh[0]}};
            assign y[N-1:M] = yhigh;
        end
    endgenerate
endmodule
