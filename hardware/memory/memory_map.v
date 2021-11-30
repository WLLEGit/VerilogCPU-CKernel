module memory_map (
	input clk,

	input [31:0] instr_addr,
	output [31:0] instr_data,

	input [31:0] cpu_addr,
	input [31:0] cpu_wrdata,
	output reg [31:0] cpu_rddata,
	input [2:0] cpu_memop,
	input cpu_we,

	input [31:0] vga_char_addr,
	output [31:0] vga_char_data,
	input [31:0] vga_color_addr,
	output [31:0] vga_color_data,
	
	output [31:0] vga_extra_line_cnt,
	output [15:0] vga_cursor_x,
	output [15:0] vga_cursor_y,

	input [31:0] kb_wraddr,
	input [31:0] kb_wrdata,
	input kb_we,

	input [31:0] irq_addr,
	output [31:0] irq_handler_addr
);

parameter INSTR_OFFSET        = 32'h00000000;
parameter DATA_OFFSET         = 32'h00100000;
parameter VGA_INFO_OFFSET     = 32'h00200000;
parameter VGA_CHAR_OFFSET     = 32'h00300000;
parameter VGA_COLOR_OFFSET    = 32'h00400000;
parameter KB_INFO_OFFSET      = 32'h00500000;
parameter IDT_OFFSET          = 32'h00600000;
parameter PREFIX_MASK 		  =	32'hfff00000;	
parameter ADDR_MASK 		  =	32'h000fffff;

wire [31:0] dram_dataout, kb_info_dataout;
wire dram_we, vga_we, idt_we, char_we, color_we;

assign dram_we = cpu_we & (cpu_addr & PREFIX_MASK == DATA_OFFSET);
assign vga_we = cpu_we & (cpu_addr & PREFIX_MASK == VGA_INFO_OFFSET);
assign idt_we = cpu_we & (cpu_addr & PREFIX_MASK == IDT_OFFSET);
assign char_we = cpu_we & (cpu_addr & PREFIX_MASK == VGA_CHAR_OFFSET);
assign color_we = cpu_we & (cpu_addr & PREFIX_MASK == VGA_COLOR_OFFSET);

always @(*) begin
	if(cpu_addr & PREFIX_MASK == DATA_OFFSET)
		cpu_rddata <= dram_dataout;
	else if(cpu_addr & PREFIX_MASK == KB_INFO_OFFSET)
		cpu_rddata <= kb_info_dataout;
	else
		cpu_rddata <= 0;
end

instr_rom instr_rom_instance(instr_addr&ADDR_MASK, clk, instr_data);														// 	read: cpu, 	write: none
dram dram_instance(cpu_addr&ADDR_MASK, dram_dataout, cpu_wrdata, clk, clk, cpu_memop, dram_we);							//	read: cpu, 	write: cpu
vga_info vga_info_instance(clk, cpu_addr&ADDR_MASK, cpu_wrdata, vga_we);												// 	read: vga, 	write: cpu
char_ram vga_ram_instance(cpu_wrdata, vga_char_addr&ADDR_MASK, clk, cpu_addr&ADDR_MASK, clk, char_we, vga_char_data);	//	read: vga, 	write: cpu
color_ram color_ram_instance(cpu_wrdata, vga_color_addr&ADDR_MASK, clk, cpu_addr&ADDR_MASK, clk, color_we, vga_color_data);	//	read: vga, 	write: cpu
kb_info kb_info_instance(clk, cpu_addr&ADDR_MASK, kb_info_dataout, kb_wraddr&ADDR_MASK, kb_wrdata, kb_we);				//	read: cpu, 	write: kb
idt idt_instance(clk, irq_addr&ADDR_MASK, irq_handler_addr&ADDR_MASK, cpu_addr&ADDR_MASK, cpu_wrdata, idt_we);						//	read: pipeline, write: cpu

endmodule

module vga_info (
	input clk,
	input [31:0] wraddr,
	input [31:0] wrdata,
	input wren,
	output [31:0] extra_line_cnt,
	output [15:0] cursor_x,
	output [15:0] cursor_y
);

reg [7:0] data[7:0];

assign extra_line_cnt = {data[0], data[1], data[2], data[3]};
assign cursor_x = {data[4], data[5]};
assign cursor_y = {data[6], data[7]};

always @(posedge clk) begin
	if(wren) begin
		if(wraddr == 0)
			{data[3], data[2], data[1], data[0]} <= wrdata;
		else if(wraddr == 4)
			{data[7], data[6], data[5], data[4]} <= wrdata;
	end
end
	
endmodule

module kb_info (
	input clk,
	input [31:0] kbinfo_rdaddr,
	output [31:0] kbinfo_rddata,
	input [31:0] kbinfo_wraddr,
	input [31:0] kbinfo_wrdata,
	input wren
);

reg [31:0] data;

assign kbinfo_rddata = data;
always @(posedge clk) begin
	if(wren) begin
		data <= kbinfo_wrdata;
	end
end
	
endmodule

module idt (
	input clk,
	input [31:0] irq_no,
	output [31:0] irq_handler_addr,
	input [31:0] wraddr,
	input [31:0] wrdata,
	input wren
);

reg [31:0] data[1:0];
assign irq_handler_addr = (irq_no == 0) ? data[0] : data[1];

always @(posedge clk) begin
	if(wren) begin
		if(wraddr == 0)
			data[0] <= wrdata;
		else if(wraddr == 4)
			data[1] <= wrdata;
	end	
end
	
endmodule