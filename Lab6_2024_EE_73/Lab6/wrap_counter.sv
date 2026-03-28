module wrap_counter #(
    parameter N = 4 // number of bits
)(
    input  logic clk,
    input  logic reset,
    output logic [N-1:0] count
);

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        count <= 0; 
    else
        count <= count + 1; // automatic wrap
end

endmodule