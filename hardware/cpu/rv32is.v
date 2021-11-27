module rv32is(
	input 	clock,
	input 	reset,
	output [31:0] imemaddr,
	input  [31:0] imemdataout,
	output 	imemclk,
	output [31:0] dmemaddr,
	input  [31:0] dmemdataout,
	output [31:0] dmemdatain,
	output 	dmemrdclk,
	output	dmemwrclk,
	output [2:0] dmemop,
	output	dmemwe,
	output [31:0] dbgdata);

wire [31:0] instr = imemdataout;

/*------------PC--------------*/
reg [31:0]pc;
reg [31:0]nextpc;

/*------------ContrGen--------------*/
wire  [2:0] extop;
wire  regwr;
wire  ALUAsrc;
wire  [1:0] ALUBsrc;
wire  [3:0] ALUctr;
wire  [2:0] branch;
wire  MemtoReg;
wire  memwr;
wire  [2:0] memop;

/*------------ALU--------------*/
wire [31:0] dataa;
wire [31:0] datab;
wire less;
wire zero;
wire [31:0] aluresult;

/*------------RegFile--------------*/
wire [31:0] busW = (MemtoReg ? dmemdataout : aluresult);
wire [31:0] rs1;
wire [31:0] rs2;

/*------------ImmGen--------------*/
wire [31:0] imm;

/*------------ContrGen--------------*/
wire PCAsrc, PCBsrc;



assign dbgdata = pc;
 
/*------------PC--------------*/
always @(*) begin
    if(reset)
        nextpc <= 32'd0;
    else
        nextpc <= (PCAsrc?imm:32'd4) + (PCBsrc?rs1:pc);
end
always @(negedge clock) begin
    if(reset)
        pc <= 32'd0;
	else
        pc <= nextpc;
end
assign imemaddr = nextpc;
assign imemclk = ~clock;

/*------------ALU--------------*/
assign dataa = ALUAsrc?pc:rs1;
assign datab = (ALUBsrc==2'b00 ? rs2 : (ALUBsrc==2'b01 ? imm : 32'd4));
alu alu_instance(dataa, datab, ALUctr, less, zero, aluresult);

/*------------RAM--------------*/
assign dmemaddr = aluresult;
assign dmemdatain = rs2;
assign dmemrdclk = clock;
assign dmemwrclk = ~clock;
assign dmemop = memop;
assign dmemwe = memwr;

/*------------RegFile--------------*/
regfile myregfile(instr[19:15], instr[24:20], instr[11:7], busW, regwr, ~clock, rs1, rs2);

/*------------ImmGen--------------*/
imm_gen imm_gen_instance(instr, extop, imm);

/*------------ContrGen--------------*/
contr_gen contr_gen_instance(instr, extop, regwr, ALUAsrc, ALUBsrc, ALUctr, branch, MemtoReg, memwr, memop);

/*------------ContrGen--------------*/
branch_cond branch_cond_instance(less, zero, branch, PCAsrc, PCBsrc);

endmodule