module t_ff (
    input logic clk, 
    input logic reset,
    output logic clk_out
);
logic q;
assign clk_out = q;    // output is the current state of the T flip-flop        
always_ff @(posedge clk or posedge reset)
begin
    if (reset)
        q <= 0; // reset sets output to 0
    else
        q <= !q; // toggle output on each clock edge
end
endmodule // t_ff means toggle flip-flop 