module forward_detecter(
   input                regwr_ex,
   input                regwr_mem,
   input                regwr_wb,
   input      [4 : 0]   rs1,
   input      [4 : 0]   rs2,
   input      [4 : 0]   rd_addr_mem,
   input      [4 : 0]   rd_addr_wb,
   // forward ctrl: 00 = no forward, 01 = forward from m/wb, 10 = forward from ex/mem
   output reg [1 : 0]   forward_rs1,
   output reg [1 : 0]   forward_rs2
  );

// forward rs1, mem first
wire tmp_rs1 = regwr_mem && (rs1 == rd_addr_mem);
assign forward_rs1[1] = regwr_ex && tmp_rs1;
assign forward_rs1[0] = regwr_ex && regwr_wb && !tmp_rs1 && (rs1 == rd_addr_wb);

// forward rs2
wire tmp_rs2 = regwr_mem && (rs2 == rd_addr_mem);
assign forward_rs2[1] = regwr_ex && tmp_rs2;
assign forward_rs2[0] = regwr_ex && regwr_wb && !tmp_rs2 && (rs2 == rd_addr_wb);

endmodule

module load_store_detecter (
   input            mem2reg_ex,
   input  [4 : 0]   rd_addr_ex,
   input  [4 : 0]   rs1_addr_id,
   input  [4 : 0]   rs2_addr_id,
   output           stall
);
assign stall = mem2reg_ex && ((rd_addr_ex == rs1_addr_id) || (rd_addr_ex == rs2_addr_id));
endmodule

module PC (
   input clr,
   input clk,

   input [31:0] nextpc_mem,
   input pc_branch,

   input stall,

   output [31:0] pc_out;
);

reg [31:0] pc;
assign pc_out = pc;

always @(negedge clk) begin
   if(clr) 
      pc <= 0;
   else begin
      if(stall)
         pc <= pc;
      else begin
         if(pc_branch)
            pc <= nextpc_mem;
         else
            pc <= pc + 4;
      end
   end
end
   
endmodule