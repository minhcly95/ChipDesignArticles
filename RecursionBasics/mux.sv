module mux #(
    parameter N = 8,
    parameter K = 3
)(
    input logic[N-1:0] a,
    input logic[K-1:0] s,
    output logic y
);
    localparam M = N/2;
    localparam L = K-1;

    generate
        if (N === 2) begin
            // Base case: MUX 2:1
            assign y = s[0] ? a[1] : a[0];
        end
        else begin
            // Recursive case
            logic yhigh, ylow;
            mux #(M,L) highmux(a[N-1:M], s[L-1:0], yhigh);
            mux #(M,L) lowmux(a[M-1:0], s[L-1:0], ylow);
            assign y = s[K-1] ? yhigh : ylow;
        end
    endgenerate
endmodule
