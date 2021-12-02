`include "define.v"

//interrupt manager
module client (
    input clr,
    input clk,

    input [`IRQ_PIN_BUS]     irq_pins,

    input [31:0]    instr_MEM,
    input [31:0]    instr_addr_MEM,

    input           branch_MEM,
    input [31:0]    branch_addr_MEM,

    input [31:0]    mtvec,
    input [31:0]    mepc,
    input [31:0]    mstatus,
    input           global_int_en,

    output              set_pl_pause,

    output reg          csr_we,
    output reg [31:0]   csr_waddr,
    output reg [31:0]   csr_wdata,

    output reg [31:0]   int_addr,
    output reg          int_flag
);

reg [`INT_BUS_WIDTH] int_state;
reg [`CSR_STATE_BUS_WIDTH] csr_state;
reg [31:0] instr_addr;
reg [31:0] cause;

assign set_pl_pause = ((int_state != `INT_IDLE) | (csr_state != `CSR_STATE_IDLE));

always @(*) begin
    if(clr) begin
        int_state <= `INT_IDLE;
    end else begin
        if(instr_MEM == `INSTR_ECALL) begin
            int_state <= `INT_M_SYNC;
        end else if(instr_MEM == `INSTR_MRET) begin
            int_state <= `INT_MRET;
        end else if(|(irq_pins) && global_int_en) begin
            int_state <= `INT_M_ASYNC;
        end else
            int_state <= `INT_IDLE;
    end
end

// FSM for wrting CSRs
always @(posedge clk) begin
    if(clr) begin
        csr_state <= `CSR_STATE_IDLE;
        cause <= 32'd0;
        instr_addr <= 32'd0;
    end else begin
        case(csr_state)
        `CSR_STATE_IDLE:begin
            if(int_state == `INT_M_SYNC) begin
                csr_state <= `CSR_STATE_MEPC;
                if(branch_MEM)
                    instr_addr <= branch_addr_MEM - 32'd4;
                else
                    instr_addr <= instr_addr_MEM;

                if(instr_MEM == `INSTR_ECALL) 
                    cause <= `ECALL_MCAUSE;
                else
                    cause <= 0;
            end else if(int_state == `INT_M_ASYNC) begin
                csr_state <= `CSR_STATE_MEPC;
                if(irq_pins[`CLOCK_IRQ_PIN] == 1) begin
                    //clock irq
                    cause <= `CLOCK_INT_MCAUSE;
                    if(branch_MEM)
                        instr_addr <= branch_addr_MEM;
                    else
                        instr_addr <= instr_addr_MEM;                    
                end else begin
                    csr_state <= `CSR_STATE_IDLE;
                end
            end else if(int_state == `INT_MRET) begin
                csr_state <= `CSR_STATE_MRET;
            end else
                csr_state <= `CSR_STATE_IDLE;
        end `CSR_STATE_MEPC: begin
            csr_state <= `CSR_STATE_MSTATUS;
        end `CSR_STATE_MSTATUS: begin
            csr_state <= `CSR_STATE_MCAUSE;
        end `CSR_STATE_MCAUSE: begin
            csr_state <= `CSR_STATE_IDLE;
        end `CSR_STATE_MRET: begin
            csr_state <= `CSR_STATE_IDLE;
        end default: begin
            csr_state <= `CSR_STATE_IDLE;
        end
        endcase
    end
end

//write CSRs 
always @(negedge clk) begin
    if(clr) begin
        csr_we <= 0;
        csr_waddr <= 0;
        csr_wdata <= 0;
    end else begin
        csr_we <= 1'b1;
        case(csr_state)
        `CSR_STATE_MEPC: begin
            csr_waddr <= `CSR_MEPC;
            csr_wdata <= instr_addr;
        end `CSR_STATE_MSTATUS: begin
            csr_waddr <= `CSR_MSTATUS;
            csr_wdata <= {mstatus[31:4], 1'b0, mstatus[2:0]};   //disable global intr enable, mpie not considered
        end `CSR_STATE_MCAUSE: begin
            csr_waddr <= `CSR_MCAUSE;
            csr_wdata <= cause;
        end `CSR_STATE_MRET: begin
            csr_waddr <= `CSR_MSTATUS;
            csr_wdata <= {mstatus[31:4], 1'b1, mstatus[2:0]};
        end default: begin
            csr_we <= 0;
            csr_waddr <= 0;
            csr_wdata <= 0;
        end        
        endcase
    end
end

always @(negedge clk) begin
    if(clr) begin
        int_flag <= 1'b0;
        int_addr <= 32'b0;
    end else begin
        case(csr_state)
        `CSR_STATE_MCAUSE: begin    //the last state of writing CSRs
            int_flag <= 1'b1;
            int_addr <= mtvec;
        end `CSR_STATE_MRET: begin
            int_flag <= 1'b1;
            int_addr <= mepc;
        end default: begin
            int_flag <= 0;
            int_addr <= 32'd0;
        end
        endcase
    end
end
    
endmodule

module last_valid_pc (
    input [31:0] pc_IF,
    input [31:0] pc_ID,
    input [31:0] pc_EX,
    input [31:0] pc_MEM,

    output reg [31:0] valid_pc
);

always @(*) begin
    if(pc_MEM != 32'h0)
        valid_pc <= pc_MEM;
    else if(pc_EX != 32'h0)
        valid_pc <= pc_EX;
    else if(pc_ID != 32'h0)
        valid_pc <= pc_ID;
    else
        valid_pc <= pc_IF;
end
    
endmodule
    

module CSRs (
    input clr,
    input clk,

    input           we_ex,
    input [31:0]    waddr_ex,
    input [31:0]    raddr_ex,
    input [31:0]    wdata_ex,

    input           we_client,
    input [31:0]    waddr_client,
    input [31:0]    wdata_client,

    output global_int_en,

    output [31:0]   mtvec_out,
    output [31:0]   mepc_out,
    output [31:0]   mstatus_out,

    output reg [31:0]   data_out_ex
);

reg [63:0] cycle;   //inner clk timer
reg [31:0] mtvec;
reg [31:0] mcause;
reg [31:0] mepc;
reg [31:0] mie;
reg [31:0] mstatus;
reg [31:0] mscratch;

assign global_int_en = mstatus[3];
assign mtvec_out = mtvec;
assign mepc_out = mepc;
assign mstatus_out = mstatus;

always @(posedge clk) begin
    if(clr)
        cycle <= 64'd0;
    else
        cycle <= cycle + 64'd1;
end

//read
always @ (*) begin
    if ((waddr_ex[11:0] == raddr_ex[11:0]) && we_ex) begin
        data_out_ex <= wdata_ex;
    end else begin
        case (raddr_ex[11:0])
            `CSR_CYCLE:
                data_out_ex <= cycle[31:0];
            `CSR_CYCLEH:
                data_out_ex <= cycle[63:32];
            `CSR_MTVEC:
                data_out_ex <= mtvec;
            `CSR_MCAUSE: 
                data_out_ex <= mcause;
            `CSR_MEPC: 
                data_out_ex <= mepc;
            `CSR_MIE: 
                data_out_ex <= mie;
            `CSR_MSTATUS: 
                data_out_ex <= mstatus;
            `CSR_MSCRATCH: 
                data_out_ex <= mscratch;
            default: 
                data_out_ex <= 32'd0;
        endcase
    end
end


//write
always @(posedge clk) begin
    if(clr) begin
        mtvec <= 0;
        mcause <= 0;
        mepc <= 0;
        mie <= 0;
        mstatus <= 0;
        mscratch <= 0;        
    end else begin
        mtvec <= (waddr_ex[11:0]==`CSR_MTVEC&&we_ex==1) ? wdata_ex : ((waddr_client[11:0]==`CSR_MTVEC&&we_client==1) ? wdata_client : mtvec);
        mcause <= (waddr_ex[11:0]==`CSR_MCAUSE&&we_ex==1) ? wdata_ex : ((waddr_client[11:0]==`CSR_MCAUSE&&we_client==1) ? wdata_client : mcause);
        mepc <= (waddr_ex[11:0]==`CSR_MEPC&&we_ex==1) ? wdata_ex : ((waddr_client[11:0]==`CSR_MEPC&&we_client==1) ? wdata_client : mepc);
        mie <= (waddr_ex[11:0]==`CSR_MIE&&we_ex==1) ? wdata_ex : ((waddr_client[11:0]==`CSR_MIE&&we_client==1) ? wdata_client : mie);
        mstatus <= (waddr_ex[11:0]==`CSR_MSTATUS&&we_ex==1) ? wdata_ex : ((waddr_client[11:0]==`CSR_MSTATUS&&we_client==1) ? wdata_client : mstatus);
        mscratch <= (waddr_ex[11:0]==`CSR_MSCRATCH&&we_ex==1) ? wdata_ex : ((waddr_client[11:0]==`CSR_MSCRATCH&&we_client==1) ? wdata_client : mscratch);
    end
end
endmodule