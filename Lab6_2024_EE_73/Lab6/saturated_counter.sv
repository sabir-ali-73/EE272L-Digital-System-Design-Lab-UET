module saturated_counter #(
    parameter N = 4  // number of bits
)(
    input  logic clk,
    input  logic reset, 
    output logic [N-1:0] count 
);

logic [N-1:0] max;

assign max = {N{1'b1}};// max value for N bits (e.g., 4'b1111 for N=4) ✅(concatenate N 1's)😉

always_ff @(posedge clk or posedge reset) begin 
    if (reset)
        count <= 0;
    else if (count != max)
        count <= count + 1;
    else
        count <= count; // hold at max
end

endmodule