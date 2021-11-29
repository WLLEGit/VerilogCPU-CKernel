`include "define.v"

module pipeline(
	input 	        clk,
	input 	        clr,
	output [31:0]   imemaddr,
	input  [31:0]   imemdataout,
	output 	        imemclk,
	output [31:0]   dmemaddr,
	input  [31:0]   dmemdataout,
	output [31:0]   dmemdatain,
	output 	        dmemrdclk,
	output	        dmemwrclk,
	output [2:0]    dmemop,
	output	        dmemwe,

    output [31:0]   dbgdata
    );

wire [31:0] nextpc_mem, pc, pc1, pc2, instr, instr1, busW, imm, imm2, rs1, rs12, rs2, rs22, rs23, nextpc_pc, nextpc_pc3,
            nextpc_rs1, nextpc_rs13, aluresult, aluresult3, aluresult4, dmemdata, dmemdata4;
wire [4:0] rs1_addr, rs2_addr, rs1_addr2, rs2_addr2, rw, rd, rd2, rd3;
wire [3:0] ALUctr, ALUctr2;
wire [2:0] extop, extop2, branch, branch2, branch3, memop, memop2, memop3;
wire [1:0] ALUBsrc, ALUBsrc2;
wire regwr, regwr2, regwr3, regwr4, MemtoReg, MemtoReg2, MemtoReg3, MemtoReg4,
			stall, pc_branch, ALUAsrc, ALUAsrc2, memwr, memwr2, memwr3, less, zero, less3, zero3;

wire [1:0] forward_rs1, forward_rs2;

wire flush;

assign dbgdata = pc;
// cpu ctrl
forward_detecter f_d_i(/*regwr2,*/ regwr3, regwr4, rs1_addr2, rs2_addr2, rd3, rw, forward_rs1, forward_rs2);
load_store_detecter l_s_d(MemtoReg2, rd2, instr1[19:15], instr1[24:20], stall);

pipeline_status pipeline_status_ctrl(clr, clk, pc_branch, flush);
PC PC_instance(clr, clk, nextpc_mem, pc_branch, stall, pc);
IF IF_instance(clr, clk, pc, instr, imemdataout, imemaddr, imemclk);
IF_ID_reg IFIDreg_instance(flush, clk, pc, instr, pc1, instr1);
ID ID_instance(clr, clk, instr1, regwr4, rw, busW, imm, rs1_addr, rs2_addr, rs1, rs2, rd, extop, regwr, ALUAsrc, ALUBsrc, ALUctr, branch, MemtoReg, memwr, memop);
ID_EX_reg ID_EX_reg_instance(flush, clk, pc1, imm, rs1, rs2, rs1_addr, rs2_addr, rd, extop, regwr, ALUAsrc, ALUBsrc, ALUctr, branch, MemtoReg, memwr, memop,
                                        pc2, imm2, rs12, rs22, rs1_addr2, rs2_addr2, rd2, extop2, regwr2, ALUAsrc2, ALUBsrc2, ALUctr2, branch2, MemtoReg2, memwr2, memop2);
EX EX_instance(clr, clk, pc2, imm2, rs12, rs22, ALUAsrc2, ALUBsrc2, ALUctr2,
                        forward_rs1, forward_rs2, aluresult3, aluresult4,
                        nextpc_pc, nextpc_rs1, less, zero, aluresult);
EX_M_reg EX_M_reg_instance(flush, clk, nextpc_pc, nextpc_rs1, less, zero, rs22, aluresult, rd2, branch2, MemtoReg2, memwr2, memop2, regwr2,
                                        nextpc_pc3, nextpc_rs13, less3, zero3, rs23, aluresult3, rd3, branch3, MemtoReg3, memwr3, memop3, regwr3);
M M_instance(clr, clk, aluresult3, nextpc_pc3, nextpc_rs13, less3, zero3, branch3, memop3, memwr3, rs23, 
                        nextpc_mem, dmemdata, pc_branch,
                        dmemaddr, dmemdataout, dmemdatain, dmemrdclk, dmemwrclk, dmemop, dmemwe);
M_WB_reg M_WB_reg_instance(clr, clk, dmemdata, aluresult3, rd3, MemtoReg3, regwr3,
                                        dmemdata4, aluresult4, rw, MemtoReg4, regwr4);
WB WB_instance(clr, clk, dmemdata4, aluresult4, MemtoReg4, busW);
    
endmodule

module IF (
    input               clr,
    input               clk,
    
    input       [31:0]  pc,
    output      [31:0]  instr,

    input       [31:0]  imemdataout,
    output      [31:0]  imemaddr,
    output              imemclk
);

assign imemaddr = pc;
assign instr = imemdataout;
assign imemclk = clk;
    
endmodule

module IF_ID_reg (
    input               clr,
    input               clk,
    input       [31:0]  pc_in,
    input       [31:0]  instr_in,
    output  reg [31:0]  pc_out,
    output  reg [31:0]  instr_out
);

always @(negedge clk) begin
    if(clr) begin
        pc_out <= 32'd0;
        instr_out <= 32'd0;
    end else begin
        pc_out <= pc_in;
        instr_out <= instr_in;
    end
end
    
endmodule

module ID (
    input               clr,
    input               clk,
    input       [31:0]  instr,

    //write back
    input               regwr_wb,   
    input       [4:0]   regaddr_wb,
    input       [31:0]  busW_wb,
    
    output      [31:0]  imm,
    
    output      [4:0]   rs1_addr,
    output      [4:0]   rs2_addr,
    output      [31:0]  rs1,
    output      [31:0]  rs2,
    output      [4:0]   rd,
    
    output       [2:0]  extop,
    output              regwr,
    output              ALUAsrc,
    output       [1:0]  ALUBsrc,
    output       [3:0]  ALUctr,
    output       [2:0]  branch,
    output              MemtoReg,
    output              memwr,
    output       [2:0]  memop    
);

assign rd = instr[11:7];
assign rs1_addr = instr[19:15];
assign rs2_addr = instr[24:20];
contr_gen contr_gen_instance(instr, extop, regwr, ALUAsrc, ALUBsrc, ALUctr, branch, MemtoReg, memwr, memop);
regfile myregfile(rs1_addr, rs2_addr, regaddr_wb, busW_wb, regwr_wb, clk, rs1, rs2);
imm_gen imm_gen_instance(instr, extop, imm);
    
endmodule

module ID_EX_reg (
    input               clr,
    input               clk,
    
    input      [31:0]   pc_in,
    input      [31:0]   imm_in,
    input      [31:0]   rs1_in,
    input      [31:0]   rs2_in,
    input      [4:0]    rs1_addr_in,
    input      [4:0]    rs2_addr_in,
    input      [4:0]    rd_in,
    input      [2:0]    extop_in,
    input               regwr_in,
    input               ALUAsrc_in,
    input      [1:0]    ALUBsrc_in,
    input      [3:0]    ALUctr_in,
    input      [2:0]    branch_in,
    input               MemtoReg_in,
    input               memwr_in,
    input      [2:0]    memop_in,
    
    output reg [31:0]   pc_out,
    output reg [31:0]   imm_out,
    output reg [31:0]   rs1_out,
    output reg [31:0]   rs2_out,
    output reg [4:0]    rs1_addr_out,
    output reg [4:0]    rs2_addr_out,
    output reg [4:0]    rd_out,
    output reg [2:0]    extop_out,
    output reg          regwr_out,
    output reg          ALUAsrc_out,
    output reg [1:0]    ALUBsrc_out,
    output reg [3:0]    ALUctr_out,
    output reg [2:0]    branch_out,
    output reg          MemtoReg_out,
    output reg          memwr_out,
    output reg [2:0]    memop_out
);

always @(negedge clk) begin
    pc_out <= clr ? 32'd0 : pc_in;
    imm_out <= clr ? 32'd0 : imm_in;
    rs1_out <= clr ? 32'd0 : rs1_in;
    rs2_out <= clr ? 32'd0 : rs2_in;
    rs1_addr_out <= clr ? 4'd0 : rs1_addr_in;
    rs2_addr_out <= clr ? 4'd0 : rs2_addr_in;
    rd_out <= clr ? 4'd0 : rd_in;
    extop_out <= clr ? 2'd0 : extop_in;
    regwr_out <= clr ? 1'b0 : regwr_in;
    ALUAsrc_out <= clr ? 1'b0 : ALUAsrc_in;
    ALUBsrc_out <= clr ? 2'd0 : ALUBsrc_in;
    ALUctr_out <= clr ? 4'd0 : ALUctr_in;
    branch_out <= clr ? 2'd0 : branch_in;
    MemtoReg_out <= clr ? 1'b0 : MemtoReg_in;
    memwr_out <= clr ? 1'b0 : memwr_in;
    memop_out <= clr ? 2'd0 : memop_in;
end
    
endmodule

module EX (
    input               clr,
    input               clk,
    input       [31:0]  pc,
    input       [31:0]  imm,
    input       [31:0]  rs1,
    input       [31:0]  rs2,
    input               ALUAsrc,
    input       [1:0]   ALUBsrc,
    input       [3:0]   ALUctr,

    input       [1:0]   forward_rs1,
    input       [1:0]   forward_rs2,
    input       [31:0]  aluresult_mem,
    input       [31:0]  aluresult_wb,

    output      [31:0]  nextpc_pc,
    output      [31:0]  nextpc_rs1,
    output              less,
    output              zero,
    output      [31:0]  aluresult
);

wire [31:0] dataa;
wire [31:0] datab;

wire [31:0] rs1_proc = forward_rs1[0] ? aluresult_wb : (forward_rs1[1] ? aluresult_mem : rs1);
wire [31:0] rs2_proc = forward_rs2[0] ? aluresult_wb : (forward_rs2[1] ? aluresult_mem : rs2);

assign nextpc_pc = pc + imm;
assign nextpc_rs1 = rs1_proc + imm;
assign dataa = ALUAsrc?pc:rs1_proc;
assign datab = (ALUBsrc==2'b00 ? rs2_proc : (ALUBsrc==2'b01 ? imm : 32'd4));
alu alu_instance(dataa, datab, ALUctr, less, zero, aluresult);
    
endmodule

module EX_M_reg (
    input               clr,
    input               clk,

    input      [31:0]   nextpc_pc,
    input      [31:0]   nextpc_rs1,
    input               less,
    input               zero,
    input      [31:0]   rs2,
    input      [31:0]   aluresult,
    input      [4:0]    rd_in,    
    input      [2:0]    branch_in,
    input               MemtoReg_in,
    input               memwr_in,
    input      [2:0]    memop_in,
    input               regwr_in,

    output reg  [31:0]  nextpc_pc_out,
    output reg  [31:0]  nextpc_rs1_out,
    output reg          less_out,
    output reg          zero_out,
    output reg  [31:0]  rs2_out,
    output reg  [31:0]  aluresult_out,
    output reg  [4:0]   rd_out,   
    output reg  [2:0]   branch_out,
    output reg          MemtoReg_out,
    output reg          memwr_out,
    output reg  [2:0]   memop_out,
    output reg          regwr_out
);

always @(negedge clk) begin
    nextpc_pc_out <= clr ? 32'd0 : nextpc_pc;
    nextpc_rs1_out <= clr ? 32'd0 : nextpc_rs1;
    less_out <= clr ? 1'b0 : less;
    zero_out <= clr ? 1'b0 : zero;
    rs2_out <= clr ? 32'd0 : rs2;
    aluresult_out <= clr ? 32'd0 : aluresult;
    rd_out <= clr ? 4'd0 : rd_in;
    branch_out <= clr ? 2'd0 : branch_in;
    MemtoReg_out <= clr ? 1'b0 : MemtoReg_in;
    memwr_out <= clr ? 1'b0 : memwr_in;
    memop_out <= clr ? 2'd0 : memop_in;
    regwr_out <= clr ? 1'b0 : regwr_in;
end
    
endmodule

module M (
    input               clr,
    input               clk,

    input       [31:0]  aluresult,
    input       [31:0]  nextpc_pc,
    input       [31:0]  nextpc_rs1,
    input               less,
    input               zero,
    input       [2:0]   branch,
    input       [2:0]   memop,
    input               memwr,
    input       [31:0]  rs2,
    
    output      [31:0]  nextpc,
    output      [31:0]  dmemdata,
    output              pc_branch,


    output      [31:0]  dmemaddr,
	input       [31:0]  dmemdataout,
	output      [31:0]  dmemdatain,
	output      	    dmemrdclk,
	output      	    dmemwrclk,
	output      [2:0]   dmemop,
	output      	    dmemwe
);

assign dmemaddr = aluresult;
assign dmemdatain = rs2;
assign dmemrdclk = clk;
assign dmemwrclk = clk;
assign dmemop = memop;
assign dmemwe = memwr;

assign dmemdata = dmemdataout;

wire PCAsrc, PCBsrc;
branch_cond branch_cond_instance(less, zero, branch, PCAsrc, PCBsrc);
assign nextpc = PCBsrc?nextpc_rs1:nextpc_pc;
assign pc_branch = PCAsrc?1'b1:1'b0;
endmodule

module M_WB_reg (
    input               clr,
    input               clk,
    input    [31:0]     dmemdata,
    input    [31:0]     aluresult,
    input    [4:0]      rd,
    input               MemtoReg,
    input               regwr,

    output reg[31:0]    dmemdata_out,
    output reg[31:0]    aluresult_out,
    output reg[4:0]     rd_out,
    output reg          MemtoReg_out,
    output reg          regwr_out
);

always @(negedge clk) begin
    dmemdata_out <= clr ? 32'd0 : dmemdata;
    aluresult_out <= clr ? 32'd0 : aluresult;
    rd_out <= clr ? 4'd0 : rd;
    MemtoReg_out <= clr ? 1'b0 : MemtoReg;
    regwr_out <= clr ? 1'b0 : regwr;
end
    
endmodule

module WB (
    input               clr,
    input               clk,
    input      [31:0]   dmemdata,
    input      [31:0]   aluresult,
    input               MemtoReg,

    output     [31:0]   busW
);

assign busW = MemtoReg?dmemdata:aluresult;
    
endmodule