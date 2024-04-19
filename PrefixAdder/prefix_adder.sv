module prefix_adder(
    input logic[7:0] a, b,
    input logic cin,
    output logic [7:0] s,
    output logic cout
);

    // g[i] = G[i], trong khi gg[i] = G[i:0]
    logic[7:0] g, p, gg, pp;
    logic[8:0] c;

    // Buoc 1: Tinh G[i] va P[i]
    assign g = a & b;
    assign p = a | b;

    // Buoc 2: Tinh G[i:0] va P[i:0] su dung module prefix
    prefix #(8) pref(g, p, gg, pp);

    // Buoc 3: Tinh C[i]
    assign c[0] = cin;
    assign cout = c[8];
    assign c[8:1] = gg | pp & {8{c[0]}};

    // Buoc 4: Tinh S[i]
    assign s = a ^ b ^ c[7:0];
endmodule

module prefix #(parameter N = 8)(
    input logic[N-1:0] g, p,
    output logic[N-1:0] gg, pp
);
    localparam M = N/2;

    genvar i;
    generate
        if (N === 1) begin
            // Base case: chi con 1 bit, noi truc tiep
            assign gg = g;
            assign pp = p;
        end
        else begin
            // Recursive case: tao 2 cay prefix co do rong M
            logic[M-1:0] ghigh, phigh, glow, plow;
            prefix #(M) highpref(g[N-1:M], p[N-1:M], ghigh, phigh);
            prefix #(M) lowpref(g[M-1:0], p[M-1:0], glow, plow);
            // Merge
            assign gg[M-1:0] = glow;
            assign pp[M-1:0] = plow;
            for (i = 0; i < M; i++)
                merge m(ghigh[i], phigh[i], glow[M-1], plow[M-1], gg[M+i], pp[M+i]);
        end
    endgenerate
endmodule

module merge(input logic ga, pa, gb, pb,
             output logic go, po);
    assign go = ga | pa & gb;
    assign po = pa & pb;
endmodule

