//pipeline ctrl
`define PL_NORMAL   2'b00 
`define PL_PAUSE    2'b01
`define PL_FLUSH    2'b10


//csr addrs 
`define CSR_MSTATUS     12'h300
`define CSR_MIE         12'h304
`define CSR_MTVEC       12'h305
`define CSR_MSCRATCH    12'h340
`define CSR_MEPC        12'h341
`define CSR_MCAUSE      12'h342
`define CSR_CYCLE       12'hc00
`define CSR_CYCLEH      12'hc80

//interupt status
`define INT_BUS_WIDTH   4
`define INT_IDLE        4'b0001
`define INT_M_SYNC      4'b0010
`define INT_M_ASYNC     4'b0100
`define INT_MRET        4'b1000

//interupt/exception code
`define CLOCK_INT_MCAUSE  32'h80000007
`define ECALL_MCAUSE  32'h0000000b

//csr process status
`define CSR_STATE_BUS_WIDTH    5
`define CSR_STATE_IDLE                5'b00001;
`define CSR_STATE_MSTATUS             5'b00010;
`define CSR_STATE_MEPC                5'b00100;
`define CSR_STATE_MRET                5'b01000;
`define CSR_STATE_MCAUSE              5'b10000;

//special instrs
`define INSTR_ECALL            32'h00000073
`define INSTR_MRET             32'h30200073