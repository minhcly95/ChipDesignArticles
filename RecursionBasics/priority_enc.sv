module priority_enc #(
    parameter N = 8,
    parameter K = 3
)(
    input logic[N-1:0] a,
    output logic[K-1:0] y,
    output logic none
);
    localparam M = N/2;
    localparam L = K-1;

    generate
        if (N === 2) begin
            // Base case
            assign y = a[1];
            assign none = ~(a[1] | a[0]);
        end
        else begin
            // Recursive case
            logic[L-1:0] yhigh, ylow;
            logic nonehigh, nonelow;

            priority_enc #(M,L) highenc(a[N-1:M], yhigh, nonehigh);
            priority_enc #(M,L) lowenc(a[M-1:0], ylow, nonelow);

            assign y = nonehigh ? {1'b0, ylow} : {1'b1, yhigh};
            assign none = nonehigh & nonelow;
        end
    endgenerate
endmodule
