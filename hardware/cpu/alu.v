module alu(
	input [31:0] dataa,
	input [31:0] datab,
	input [3:0]  ALUctr,
	output reg less,
	output zero,
	output reg [31:0] aluresult);
wire addsub;
wire [31:0] F;
wire cf,zf,of;

assign zero = zf;
assign addsub = (ALUctr == 4'b1000 || ALUctr[2:0] == 3'b010);
adder alu_addr(dataa, datab, addsub, F, cf, zf, of);

always @(*) begin
	less <= 1'b0;
	casex(ALUctr) 
	4'b0000: begin
		aluresult <= F;
	end 4'b1000: begin
		aluresult <= F;
	end 4'b?001: begin
		aluresult <= (dataa << datab[4:0]);
	end 4'b0010: begin
		less <= (of ^ F[31]) & ~zf;
		aluresult <= {31'd0, (of ^ F[31]) & ~zf};
	end 4'b1010: begin
		less <= cf & ~zf;
		aluresult <= {31'd0, cf & ~zf};
	end 4'b?011: begin
		aluresult <= datab;
	end 4'b?100: begin
		aluresult <= dataa ^ datab;
	end 4'b0101: begin
		aluresult <= (dataa >> datab[4:0]);
	end 4'b1101: begin
		aluresult <= ($signed(dataa) >>> datab[4:0]);
	end 4'b?110: begin
		aluresult <= dataa | datab;
	end 4'b?111: begin
		aluresult <= dataa & datab;
	end default:
		aluresult <= 32'd0;
	endcase
end

endmodule

module adder(
	input  [31:0] A,
	input  [31:0] B,
	input  addsub,
	output [31:0] F,
	output cf,
	output zero,
	output of
	);

	
wire cout;
wire [31:0]add_b;

assign add_b = {32{addsub}} ^ B;
assign {cout, F} = A + add_b + addsub;

assign of = (A[31] == add_b[31]) && (F[31] != A[31]);
assign zero = ~(|F);
assign cf = cout ^ addsub;


endmodule