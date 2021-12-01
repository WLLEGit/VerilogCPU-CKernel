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

    output [31:0]   dbgdata, //debug pin for modelsim
    
    output          global_int_en_out,
    input  [`IRQ_PIN_BUS]    irq_pins    //device interrupt pins
    );

wire [31:0] nextpc_mem, pc, pc1, pc2, pc3, instr, instr1, instr2, instr3, busW, imm, imm2, rs1, rs12, rs2, rs22, rs23, rs2_forward, nextpc_pc, nextpc_pc3,
            nextpc_rs1, nextpc_rs13, aluresult, aluresult3, aluresult4, dmemdata, dmemdata4;
wire [4:0] rs1_addr, rs2_addr, rs1_addr2, rs2_addr2, rw, rd, rd2, rd3;
wire [3:0] ALUctr, ALUctr2;
wire [2:0] extop, extop2, branch, branch2, branch3, memop, memop2, memop3;
wire [1:0] ALUBsrc, ALUBsrc2;
wire regwr, regwr2, regwr3, regwr4, MemtoReg, MemtoReg2, MemtoReg3, MemtoReg4,
			stall, pc_branch, ALUAsrc, ALUAsrc2, memwr, memwr2, memwr3, less, zero, less3, zero3;

wire [1:0] forward_rs1, forward_rs2;

wire [`PL_STATUS_BUS_WIDTH] pl_ctrl_pc, pl_ctrl_ID, pl_ctrl_EX, pl_ctrl_MEM, pl_ctrl_WB;

//interrupt signals
wire we_ex, we_client, global_int_en, int_set_pl_pause, int_flag, csr2reg, csr2reg2, csr2reg3, csr2reg4, csr_we, csr_we2, csr_we3, csr_we4;
wire [31:0] waddr_ex, raddr_ex, wdata_ex, waddr_client, wdata_client, mtvec, mepc, mstatus, data_out_ex, int_pc, 
            csr_data, csr_data2, csr_aluresult, csr_aluresult3, csr_aluresult4, csr_waddr3, csr_waddr4;
wire [2:0] csr_aluctr, csr_aluctr2;

assign dbgdata = pc;
// cpu ctrl
forward_detecter f_d_i(regwr3, regwr4, rs1_addr2, rs2_addr2, rd3, rw, forward_rs1, forward_rs2);
load_store_detecter l_s_d(MemtoReg2, rd2, instr1[19:15], instr1[24:20], stall);
pipeline_status pipeline_status_ctrl(clr, clk, pc_branch, stall, int_set_pl_pause, int_flag,
                                             pl_ctrl_pc, pl_ctrl_ID, pl_ctrl_EX, pl_ctrl_MEM, pl_ctrl_WB);

// interrupt support
CSRs csrs(clr, clk, we_ex, waddr_ex, raddr_ex, wdata_ex, we_client, waddr_client, wdata_client, global_int_en, mtvec, mepc, mstatus, data_out_ex);
client client_instance(clr, clk, irq_pins, instr3, pc3, pc_branch, nextpc_mem, mtvec, mepc, mstatus, global_int_en,
                                int_set_pl_pause, we_client, waddr_client, wdata_client, int_pc, int_flag);

PC PC_instance(pl_ctrl_pc, clk, nextpc_mem, int_pc, pc);
IF IF_instance(clr, clk, pc, instr, imemdataout, imemaddr, imemclk);
IF_ID_reg IFIDreg_instance(pl_ctrl_ID, clk, pc, instr, pc1, instr1);
ID ID_instance(clr, clk, instr1, regwr4, rw, busW, imm, rs1_addr, rs2_addr, rs1, rs2, rd, extop, regwr, ALUAsrc, ALUBsrc, ALUctr, branch, MemtoReg, memwr, memop, raddr_ex, data_out_ex, csr_data, csr_aluctr, csr_we, csr2reg);
ID_EX_reg ID_EX_reg_instance(pl_ctrl_EX, clk, instr1, pc1, imm, rs1, rs2, rs1_addr, rs2_addr, rd, extop, regwr, ALUAsrc, ALUBsrc, ALUctr, branch, MemtoReg, memwr, memop, csr_data, csr_aluctr, csr_we, csr2reg,
                                        instr2, pc2, imm2, rs12, rs22, rs1_addr2, rs2_addr2, rd2, extop2, regwr2, ALUAsrc2, ALUBsrc2, ALUctr2, branch2, MemtoReg2, memwr2, memop2, csr_data2, csr_aluctr2, csr_we2, csr2reg2);
EX EX_instance(clr, clk, pc2, imm2, rs12, rs22, ALUAsrc2, ALUBsrc2, ALUctr2,
                        forward_rs1, forward_rs2, aluresult3, busW,
                        nextpc_pc, nextpc_rs1, less, zero, aluresult,
                        rs2_forward,
                        rs1_addr2, csr_data2, csr_aluctr2, csr_aluresult);
EX_M_reg EX_M_reg_instance(pl_ctrl_MEM, clk, instr2, pc2, nextpc_pc, nextpc_rs1, less, zero, rs2_forward, aluresult, rd2, branch2, MemtoReg2, memwr2, memop2, regwr2, csr_aluresult, csr_we2, csr2reg2, imm2,
                                        instr3, pc3, nextpc_pc3, nextpc_rs13, less3, zero3, rs23, aluresult3, rd3, branch3, MemtoReg3, memwr3, memop3, regwr3, csr_aluresult3, csr_we3, csr2reg3, csr_waddr3);
M M_instance(clr, clk, aluresult3, nextpc_pc3, nextpc_rs13, less3, zero3, branch3, memop3, memwr3, rs23, 
                        nextpc_mem, dmemdata, pc_branch,
                        dmemaddr, dmemdataout, dmemdatain, dmemrdclk, dmemwrclk, dmemop, dmemwe);
M_WB_reg M_WB_reg_instance(pl_ctrl_WB, clk, dmemdata, aluresult3, rd3, MemtoReg3, regwr3, csr_aluresult3, csr_we3, csr2reg3, csr_waddr3,
                                        dmemdata4, aluresult4, rw, MemtoReg4, regwr4, csr_aluresult4, csr_we4, csr2reg4, csr_waddr4);
WB WB_instance(clr, clk, dmemdata4, aluresult4, MemtoReg4, busW, csr_aluresult4, csr2reg4);

assign we_ex = csr_we4;
assign wdata_ex = csr_aluresult4;
assign waddr_ex = csr_waddr4;
assign global_int_en_out = global_int_en;

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
    input       [`PL_STATUS_BUS_WIDTH]   pl_ctrl_ID,
    input               clk,
    input       [31:0]  pc_in,
    input       [31:0]  instr_in,
    output  reg [31:0]  pc_out,
    output  reg [31:0]  instr_out
);

always @(negedge clk) begin
    if(pl_ctrl_ID == `PL_FLUSH) begin
        pc_out <= 32'd0;
        instr_out <= 32'd0;
    end else if(pl_ctrl_ID == `PL_PAUSE) begin
        pc_out <= pc_out;
        instr_out <= instr_out;
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
    output       [2:0]  memop,

    output       [31:0] csr_raddr,
    input        [31:0] csr_rdata,
    output       [31:0] csr_data_out,    
    output       [2:0]  csr_aluctr,
    output              csrwe,
    output              csr2reg

);

assign rd = instr[11:7];
assign rs1_addr = instr[19:15];
assign rs2_addr = instr[24:20];
contr_gen contr_gen_instance(instr, extop, regwr, ALUAsrc, ALUBsrc, ALUctr, branch, MemtoReg, memwr, memop, csr_aluctr, csrwe, csr2reg);
regfile myregfile(rs1_addr, rs2_addr, regaddr_wb, busW_wb, regwr_wb, clk, rs1, rs2);

imm_gen imm_gen_instance(instr, extop, imm);

assign csr_raddr = {20'd0, imm[11:0]};
assign csr_data_out = csr_rdata;
    
endmodule

module ID_EX_reg (
    input      [`PL_STATUS_BUS_WIDTH]    pl_ctrl_EX,
    input               clk,
    
    input      [31:0]   instr_in,
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
    input      [31:0]   csr_data_in,
    input      [2:0]    csr_aluctr_in,
    input               csrwe_in,
    input               csr2reg_in,
    
    output reg [31:0]   instr_out,
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
    output reg [2:0]    memop_out,
    output reg [31:0]   csr_data_out,
    output reg [2:0]   csr_aluctr_out,
    output reg          csrwe_out,
    output reg          csr2reg_out
);

always @(negedge clk) begin
    if(pl_ctrl_EX == `PL_FLUSH) begin
        instr_out <= 32'd0;
        pc_out <= 32'd0;
        imm_out <= 32'd0;
        rs1_out <= 32'd0;
        rs2_out <= 32'd0;
        rs1_addr_out <= 4'd0;
        rs2_addr_out <= 4'd0;
        rd_out <= 4'd0;
        extop_out <= 2'd0;
        regwr_out <= 1'b0;
        ALUAsrc_out <= 1'b0;
        ALUBsrc_out <= 2'd0;
        ALUctr_out <= 3'd0;
        branch_out <= 2'd0;
        MemtoReg_out <= 1'b0;
        memwr_out <= 1'b0;
        memop_out <= 2'd0;
        csr_data_out <= 32'd0;
        csr_aluctr_out <= 2'd0;
        csrwe_out <= 1'b0;
        csr2reg_out <= 1'b0;        
    end else if(pl_ctrl_EX == `PL_PAUSE) begin
        instr_out <= instr_out;
        pc_out <= pc_out;
        imm_out <= imm_out;
        rs1_out <= rs1_out;
        rs2_out <= rs2_out;
        rs1_addr_out <= rs1_addr_out;
        rs2_addr_out <= rs2_addr_out;
        rd_out <= rd_out;
        extop_out <= extop_out;
        regwr_out <= regwr_out;
        ALUAsrc_out <= ALUAsrc_out;
        ALUBsrc_out <= ALUBsrc_out;
        ALUctr_out <= ALUctr_out;
        branch_out <= branch_out;
        MemtoReg_out <= MemtoReg_out;
        memwr_out <= memwr_out;
        memop_out <= memop_out;
        csr_data_out <= csr_data_out;
        csr_aluctr_out <= csr_aluctr_out;
        csrwe_out <= csrwe_out;
        csr2reg_out <= csr2reg_out;
    end else begin
        instr_out <= instr_in;
        pc_out <= pc_in;
        imm_out <= imm_in;
        rs1_out <= rs1_in;
        rs2_out <= rs2_in;
        rs1_addr_out <= rs1_addr_in;
        rs2_addr_out <= rs2_addr_in;
        rd_out <= rd_in;
        extop_out <= extop_in;
        regwr_out <= regwr_in;
        ALUAsrc_out <= ALUAsrc_in;
        ALUBsrc_out <= ALUBsrc_in;
        ALUctr_out <= ALUctr_in;
        branch_out <= branch_in;
        MemtoReg_out <= MemtoReg_in;
        memwr_out <= memwr_in;
        memop_out <= memop_in;
        csr_data_out <= csr_data_in;
        csr_aluctr_out <= csr_aluctr_in;
        csrwe_out <= csrwe_in;
        csr2reg_out <= csr2reg_in;
    end

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
    output      [31:0]  aluresult,
    output      [31:0]  rs2_forward,

    input       [4:0]   zimm,
    input       [31:0]  csr_data,
    input       [2:0]   csr_aluctr,
    output      [31:0]  csr_aluresult
);

wire [31:0] dataa;
wire [31:0] datab;

wire [31:0] rs1_proc = forward_rs1[0] ? aluresult_wb : (forward_rs1[1] ? aluresult_mem : rs1);
wire [31:0] rs2_proc = forward_rs2[0] ? aluresult_wb : (forward_rs2[1] ? aluresult_mem : rs2);

assign rs2_forward = rs2_proc;
assign nextpc_pc = pc + imm;
assign nextpc_rs1 = rs1_proc + imm;
assign dataa = ALUAsrc?pc:rs1_proc;
assign datab = (ALUBsrc==2'b00 ? rs2_proc : (ALUBsrc==2'b01 ? imm : 32'd4));
alu alu_instance(dataa, datab, ALUctr, less, zero, aluresult);
CSRALU csr_alu_instance(csr_data, rs1_proc, {27'd0, zimm}, csr_aluctr, csr_aluresult);
    
endmodule

module EX_M_reg (
    input      [`PL_STATUS_BUS_WIDTH]    pl_ctrl_MEM,
    input               clk,

    input      [31:0]   instr_in,
    input      [31:0]   pc,
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
    input      [31:0]   csr_aluresult_in,
    input               csr_we_in,
    input               csr2reg_in,
    input      [31:0]   csr_waddr_in,

    output reg  [31:0]  instr_out,
    output reg  [31:0]  pc_out,
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
    output reg          regwr_out,
    output reg  [31:0]  csr_aluresult_out,
    output reg          csr_we_out,
    output reg          csr2reg_out,
    output reg  [31:0]  csr_waddr_out
);

always @(negedge clk) begin
    if(pl_ctrl_MEM == `PL_FLUSH) begin
        instr_out <= 32'd0;
        pc_out <= 32'd0;
        nextpc_pc_out <= 32'd0;
        nextpc_rs1_out <= 32'd0;
        less_out <= 1'b0;
        zero_out <= 1'b0;
        rs2_out <= 32'd0;
        aluresult_out <= 32'd0;
        rd_out <= 4'd0;
        branch_out <= 2'd0;
        MemtoReg_out <= 1'b0;
        memwr_out <= 1'b0;
        memop_out <= 2'd0;
        regwr_out <= 1'b0;
        csr_aluresult_out <= 32'd0;
        csr_we_out <= 1'b0;
        csr2reg_out <= 1'b0;
        csr_waddr_out <= 32'd0;
    end else if(pl_ctrl_MEM == `PL_PAUSE) begin
        instr_out <= instr_out;
        pc_out <= pc_out;
        nextpc_pc_out <= nextpc_pc_out;
        nextpc_rs1_out <= nextpc_rs1_out;
        less_out <= less_out;
        zero_out <= zero_out;
        rs2_out <= rs2_out;
        aluresult_out <= aluresult_out;
        rd_out <= rd_out;
        branch_out <= branch_out;
        MemtoReg_out <= MemtoReg_out;
        memwr_out <= memwr_out;
        memop_out <= memop_out;
        regwr_out <= regwr_out;
        csr_aluresult_out <= csr_aluresult_out;
        csr_we_out <= csr_we_out;
        csr2reg_out <= csr2reg_out;
        csr_waddr_out <= csr_waddr_out;
    end else begin
        instr_out <= instr_in;
        pc_out <= pc;
        nextpc_pc_out <= nextpc_pc;
        nextpc_rs1_out <= nextpc_rs1;
        less_out <= less;
        zero_out <= zero;
        rs2_out <= rs2;
        aluresult_out <= aluresult;
        rd_out <= rd_in;
        branch_out <= branch_in;
        MemtoReg_out <= MemtoReg_in;
        memwr_out <= memwr_in;
        memop_out <= memop_in;
        regwr_out <= regwr_in;
        csr_aluresult_out <= csr_aluresult_in;
        csr_we_out <= csr_we_in;
        csr2reg_out <= csr2reg_in;
        csr_waddr_out <= csr_waddr_in;
    end
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
    input    [`PL_STATUS_BUS_WIDTH]      pl_ctrl_WB,
    input               clk,
    input    [31:0]     dmemdata,
    input    [31:0]     aluresult,
    input    [4:0]      rd,
    input               MemtoReg,
    input               regwr,
    input    [31:0]     csr_aluresult_in,
    input               csr_we_in,
    input               csr2reg_in,
    input    [31:0]     csr_waddr_in,

    output reg[31:0]    dmemdata_out,
    output reg[31:0]    aluresult_out,
    output reg[4:0]     rd_out,
    output reg          MemtoReg_out,
    output reg          regwr_out,
    output reg[31:0]    csr_aluresult_out,
    output reg          csr_we_out,
    output reg          csr2reg_out,
    output reg[31:0]    csr_waddr_out
);

always @(negedge clk) begin
    if(pl_ctrl_WB == `PL_FLUSH) begin
        dmemdata_out <= 32'd0;
        aluresult_out <= 32'd0;
        rd_out <= 4'd0;
        MemtoReg_out <= 1'b0;
        regwr_out <= 1'b0;
        csr_aluresult_out <= 32'd0;
        csr_we_out <= 1'b0;
        csr2reg_out <= 1'b0;
        csr_waddr_out <= 32'd0;
    end else if(pl_ctrl_WB == `PL_PAUSE) begin
        dmemdata_out <= dmemdata_out;
        aluresult_out <= aluresult_out;
        rd_out <= rd_out;
        MemtoReg_out <= MemtoReg_out;
        regwr_out <= regwr_out;
        csr_aluresult_out <= csr_aluresult_out;
        csr_we_out <= csr_we_out;
        csr2reg_out <= csr2reg_out;
        csr_waddr_out <= csr_waddr_out;
    end else begin
        dmemdata_out <= dmemdata;
        aluresult_out <= aluresult;
        rd_out <= rd;
        MemtoReg_out <= MemtoReg;
        regwr_out <= regwr;
        csr_aluresult_out <= csr_aluresult_in;
        csr_we_out <= csr_we_in;
        csr2reg_out <= csr2reg_in;
        csr_waddr_out <= csr_waddr_in;
    end
end
    
endmodule

module WB (
    input               clr,
    input               clk,
    input      [31:0]   dmemdata,
    input      [31:0]   aluresult,
    input               MemtoReg,

    output     [31:0]   busW,

    input      [31:0]   csr_aluresult,
    input              csr2reg
);

assign busW = csr2reg ? csr_aluresult : (MemtoReg?dmemdata:aluresult);
    
endmodule