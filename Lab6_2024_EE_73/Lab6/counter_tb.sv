module tb;

logic clk;
logic reset;
logic sel;

logic [3:0] leds;
logic [6:0] seg;
logic [7:0] an;

// DUT
top DUT(
    .clk(clk),
    .reset(reset),
    .sel(sel),
    .seg(seg),
    .an(an),
    .leds(leds)
);

// Clock generation
always #5 clk = ~clk;


// 🔷 Convert 7-seg to readable character
function string seg_to_char(input logic [6:0] seg);
    case(seg)
        7'b0000001: return "0";
        7'b1001111: return "1";
        7'b0010010: return "2";
        7'b0000110: return "3";
        7'b1001100: return "4";
        7'b0100100: return "5";
        7'b0100000: return "6";
        7'b0001111: return "7";
        7'b0000000: return "8";
        7'b0000100: return "9";
        7'b0001000: return "A";
        7'b1100000: return "b";
        7'b0110001: return "C";
        7'b1000010: return "d";
        7'b0110000: return "E";
        7'b0111000: return "F";
        default:    return "?";
    endcase
endfunction


// 🔷 Simulation sequence
initial begin
    clk = 0;
    reset = 1;
    sel = 0;

    #10 reset = 0;

    // 🔵 Wrap Counter Mode
    $display("---- WRAP COUNTER MODE ----");
    repeat (20) begin
        #10;
        $display("LEDs = %4b | 7-Seg = %s", leds, seg_to_char(seg));
    end

    // 🔴 Saturated Counter Mode
    sel = 1;
    $display("---- SATURATED COUNTER MODE ----");
    repeat (20) begin
        #10;
        $display("LEDs = %4b | 7-Seg = %s", leds, seg_to_char(seg));
    end

    $finish;
end

endmodule