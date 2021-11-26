module kb2ascii (
	input clk,
    input [7:0]key_code,
    input is_capital,
    input is_shift,
    output reg [7:0]ascii
);

wire[7:0] data;
wire[7:0] data_shift;
kb2ascii_rom rom_instance(key_code, clk, data);
kb2ascii_shift rom_shift(key_code, clk, data_shift);

always @(*) begin
    if(data <= 122 && data >= 97) begin
        if(is_capital ^ is_shift)
            ascii <= data - 8'd32;
        else 
            ascii <= data;
    end else if(is_shift) begin
        ascii <= data_shift;
    end else
        ascii <= data;
end

endmodule