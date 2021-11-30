`include "../cpu/define.v"
module color_map (
    input [7:0] color,
    output reg [23:0] rgb
);

always @(*) begin
    case(color)
    `COLOR_INDEX_RED: rgb <= `COLOR_RED;
    `COLOR_INDEX_GREEN: rgb <= `COLOR_GREEN;
    `COLOR_INDEX_BLUE: rgb <= `COLOR_BLUE;
    `COLOR_INDEX_WHITE: rgb <= `COLOR_WHITE;
    `COLOR_INDEX_BLACK: rgb <= `COLOR_BLACK;
    default: rgb <= `COLOR_BLACK;
    endcase
end
    
endmodule