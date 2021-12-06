`include "define.v"
module forward_detecter(
   input                regwr_mem,
   input                regwr_wb,
   input      [4 : 0]   rs1,
   input      [4 : 0]   rs2,
   input      [4 : 0]   rd_addr_mem,
   input      [4 : 0]   rd_addr_wb,
   // forward ctrl: 00 = no forward, 01 = forward from m/wb, 10 = forward from ex/mem
   output 	  [1 : 0]   forward_rs1,
   output     [1 : 0]   forward_rs2
  );

// forward rs1, mem first
wire tmp_rs1 = regwr_mem && (rs1 == rd_addr_mem);
assign forward_rs1[1] = rs1 != 5'h0 && tmp_rs1;
assign forward_rs1[0] = rs1 != 5'h0 && regwr_wb && !tmp_rs1 && (rs1 == rd_addr_wb);

// forward rs2
wire tmp_rs2 = regwr_mem && (rs2 == rd_addr_mem);
assign forward_rs2[1] = rs2 != 5'h0 && tmp_rs2;
assign forward_rs2[0] = rs2 != 5'h0 && regwr_wb && !tmp_rs2 && (rs2 == rd_addr_wb);

endmodule

module load_use_detecter (
   input            mem2reg_ex,
   input  [4 : 0]   rd_addr_ex,
   input  [4 : 0]   rs1_addr_id,
   input  [4 : 0]   rs2_addr_id,
   output           stall
);
assign stall = mem2reg_ex && ((rd_addr_ex == rs1_addr_id) || (rd_addr_ex == rs2_addr_id));
endmodule

module PC (
   input [`PL_STATUS_BUS_WIDTH] PL_status,
   input clk,

   input [31:0] nextpc_mem,
   input [31:0] nextpc_int,

   output [31:0] pc_out
);

reg [31:0] pc;
assign pc_out = pc;

always @(negedge clk) begin
   if(PL_status == `PL_FLUSH) 
      pc <= 0;
   else if(PL_status == `PL_PC_INT)
      pc <= nextpc_int;
   else if(PL_status == `PL_PC_BRANCH)
      pc <= nextpc_mem;
   else if(PL_status == `PL_PAUSE)
      pc <= pc;
   else if(PL_status == `PL_NORMAL)
      pc <= pc + 4;
   else
      pc <= 0;
end
   
endmodule

module pipeline_status (
   input clr,
   input clk,
   input branch,
   input stall,
   input int_set_pl_pause,
   input int_flag,

   input [31:0] int_pc,

   output [`PL_STATUS_BUS_WIDTH] pl_ctrl_pc_out,
   output [`PL_STATUS_BUS_WIDTH] pl_ctrl_ID_out,
   output [`PL_STATUS_BUS_WIDTH] pl_ctrl_EX_out,
   output [`PL_STATUS_BUS_WIDTH] pl_ctrl_MEM_out,
   output [`PL_STATUS_BUS_WIDTH] pl_ctrl_WB_out,

   output reg [31:0] int_pc_out
); 

reg [`PL_STATUS_BUS_WIDTH] pl_ctrl_pc;
reg [`PL_STATUS_BUS_WIDTH] pl_ctrl_ID;
reg [`PL_STATUS_BUS_WIDTH] pl_ctrl_EX;
reg [`PL_STATUS_BUS_WIDTH] pl_ctrl_MEM;
reg [`PL_STATUS_BUS_WIDTH] pl_ctrl_WB;

assign pl_ctrl_pc_out = clr ? `PL_FLUSH : pl_ctrl_pc;
assign pl_ctrl_ID_out = clr ? `PL_FLUSH : pl_ctrl_ID;
assign pl_ctrl_EX_out = clr ? `PL_FLUSH : pl_ctrl_EX;
assign pl_ctrl_MEM_out = clr ? `PL_FLUSH : pl_ctrl_MEM;
assign pl_ctrl_WB_out = clr ? `PL_FLUSH : pl_ctrl_WB; 

always @(posedge clk) begin
   int_pc_out <= int_pc;
   if(int_flag) begin
      pl_ctrl_pc <= `PL_PC_INT;
      pl_ctrl_ID <= `PL_FLUSH;
      pl_ctrl_EX <= `PL_FLUSH;
      pl_ctrl_MEM <= `PL_FLUSH;
      pl_ctrl_WB <= `PL_FLUSH;
   end else if(int_set_pl_pause) begin
      pl_ctrl_pc <= `PL_PAUSE;
      pl_ctrl_ID <= `PL_PAUSE;
      pl_ctrl_EX <= `PL_PAUSE;
      pl_ctrl_MEM <= `PL_PAUSE;
      pl_ctrl_WB <= `PL_PAUSE;
   end else if(branch) begin
      pl_ctrl_pc <= `PL_PC_BRANCH;
      pl_ctrl_ID <= `PL_FLUSH;
      pl_ctrl_EX <= `PL_FLUSH;
      pl_ctrl_MEM <= `PL_FLUSH;
      pl_ctrl_WB <= `PL_NORMAL;
   end else if(stall) begin
      pl_ctrl_pc <= `PL_PAUSE;
      pl_ctrl_ID <= `PL_PAUSE;
      pl_ctrl_EX <= `PL_FLUSH;
      pl_ctrl_MEM <= `PL_NORMAL;
      pl_ctrl_WB <= `PL_NORMAL;
   end else begin
      pl_ctrl_pc <= `PL_NORMAL;
      pl_ctrl_ID <= `PL_NORMAL;
      pl_ctrl_EX <= `PL_NORMAL;
      pl_ctrl_MEM <= `PL_NORMAL;
      pl_ctrl_WB <= `PL_NORMAL;
   end
end
   
endmodule