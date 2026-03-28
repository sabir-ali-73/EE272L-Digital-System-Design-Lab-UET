module top(
    input  logic clk,
    input  logic reset,
    input  logic sel,   // 🔴 MUX select

    output logic [6:0] seg,
    output logic [7:0] an,
    output logic [3:0] leds
);

logic slow_clk;
logic [3:0] wrap_out;
logic [3:0] sat_out;
logic [3:0] mux_out;

// Frequency Divider
// freq_divider fd (
//     .clk(clk),
//     .reset(reset),
//     .clk_out(slow_clk)
// );
assign slow_clk = clk; // bypass freq divider for faster simulation

// Wrap Counter
wrap_counter #(4) wc (
    .clk(slow_clk),
    .reset(reset),
    .count(wrap_out)
);

// Saturated Counter
saturated_counter #(4) sc ( 
    .clk(slow_clk),
    .reset(reset),
    .count(sat_out)
);

// 🔴 2:1 MUX
assign mux_out = (sel == 0) ? wrap_out : sat_out;

// Outputs
assign leds = mux_out;

decoder dec (
    .in(mux_out),
    .seg(seg),
    .an(an)
);

endmodule