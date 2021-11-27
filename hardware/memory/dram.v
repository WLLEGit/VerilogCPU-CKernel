module dram(
	input  [31:0] addr,
	output reg [31:0] dataout,
	input  [31:0] datain,
	input  rdclk,
	input  wrclk,
	input [2:0] memop,
	input we);

wire [3:0] byteena_a;
wire [31:0] ramq;
wire [31:0] q;
wire [31:0] din;
wire [31:0] offset;


assign byteena_a = |(memop&3'b010) ? 4'b1111 : (|(memop&3'b001) ? (addr[1:0] == 2'b00 ? 4'b0011 : 4'b1100) : (4'b0001 << addr[1:0]));
assign offset = ({30'b0, addr[1:0]} << 3);
assign q = ramq >> offset;
assign din = datain << offset;

always @(q or memop) begin
    case (memop)
        3'b000: dataout <= {{24{q[7]}}, q[7:0]};
        3'b001: dataout <= {{16{q[15]}}, q[15:0]};
        3'b010: dataout <= q;
        3'b100: dataout <= {24'b0, q[7:0]};
        3'b101: dataout <= {16'b0, q[15:0]};
        default: dataout <= 32'd0;
    endcase
end

data_ram ram_instance(byteena_a, din, addr[16:2], rdclk, addr[16:2], wrclk, we, ramq);

endmodule