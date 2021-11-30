`include "cpu/define.v"
module riscv_hardware(

	//////////// CLOCK //////////
//	input 		          		CLOCK2_50,
//	input 		          		CLOCK3_50,
//	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		     [9:0]		LEDR,
//
	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

//	//////////// Audio //////////
//	input 		          		AUD_ADCDAT,
//	inout 		          		AUD_ADrstCK,
//	inout 		          		AUD_BCLK,
//	output		          		AUD_DACDAT,
//	inout 		          		AUD_DArstCK,
//	output		          		AUD_XCK,

	//////////// PS2 //////////
	inout 		          		PS2_CLK,
//	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT
//	inout 		          		PS2_DAT2,

//	//////////// I2C for Audio and Video-In //////////
//	output		          		FPGA_I2C_SCLK,
//	inout 		          		FPGA_I2C_SDAT
);
parameter S0 = 3'b0001, S1=4'b0010, S2=4'b0100, S3=4'b1000;
parameter MS500 = 25000000, MS250=12500000, MS1000=50000000;

wire tmp_clk = ~KEY[0];

/*=====Pipeline=====*/
wire [31:0] imemaddr;
wire [31:0] imemdataout;
wire 		imemclk;
wire [31:0] dmemaddr;
wire [31:0]	dmemdataout;
wire [31:0] dmemdatain;
wire 		dmemrdclk;
wire		dmemwrclk;
wire [2:0] 	dmemop;
wire		dmemwe;

wire rst = SW[0];


/*=====vga=====*/
//	640*480
//	9*16
//	64*64
wire [9:0] h_addr;
wire [9:0] v_addr;
wire [31:0] vga_addr, vga_extra_line_cnt, vga_char_data, vga_color_data;
wire [23:0] vga_data, vga_color;	
wire valid;  

wire [9:0] cursor_x, cursor_y;
wire [6:0] x;
wire [4:0] y;
wire [7:0] x_remain, y_remain;
wire [191:0] font_out;
integer cursor_cnt;
wire [11:0] tmp_y;

/*=====keyboard=====*/
wire is_shift;
wire is_ctrl;
wire is_capital;
wire is_error;
wire is_special;
wire [7:0] ascii;
reg [3:0] kb_state;
integer kb_timer;


/*=====irq=====*/
wire [`IRQ_PIN_BUS] irq_pins={3'b0, timer_irq};
wire global_int_en, timer_irq;

clkgen #(25200000) vgaclk_generator(CLOCK_50, rst, 1'b1, VGA_CLK);
color_map color_gen(vga_color_data, vga_color);
vga_ctrl vga(VGA_CLK, rst, vga_data, h_addr, v_addr, VGA_HS, VGA_VS, valid, VGA_R, VGA_G, VGA_B);
assign VGA_SYNC_N = 1'b0;
assign VGA_BLANK_N = valid;

assign vga_addr = x + (((y + vga_extra_line_cnt) & 32'h3F) << 6);
process_haddr haddr_pro(h_addr, x, x_remain[3:0]);
process_vaddr vaddr_pro(v_addr, y, y_remain[3:0]);
font_rom font_rom_instance(vga_char_data, CLOCK_50, font_out);
assign tmp_y = 12'd15 - y_remain;
assign vga_data = (h_addr == cursor_x && v_addr >= cursor_y && v_addr <= cursor_y + 15 && cursor_cnt >= MS500) ? {24{1'b1}} : (h_addr >= 576 ? 24'd0 : (font_out[(mul12(tmp_y))+(x_remain)] ? vga_color : 32'd0));

timer_device timer_device_instance(rst, tmp_clk, global_int_en, timer_irq);
pipeline cpu(tmp_clk, rst, imemaddr, imemdataout, imemclk, dmemaddr, dmemdataout, dmemdatain, dmemrdclk, dmemwrclk, dmemop, dmemwe, pc, global_int_en, irq_pins);

kb_driver keyboard(CLOCK_50, rst, PS2_CLK, PS2_DAT, is_shift, is_ctrl, is_capital, is_error, is_special, ascii);

memory_map mm_instance(CLOCK_50, imemaddr, imemdataout, dmemaddr, dmemdatain, dmemdataout, dmemop, dmemwe, 
							vga_addr, vga_char_data, vga_addr, vga_color_data, 
							vga_extra_line_cnt, cursor_x, cursor_y,
							32'd0, {16'd0, 3'd0, is_error, is_special, is_capital, is_ctrl, is_shift, ascii}, 1'b1);

always @(posedge CLOCK_50) begin
	if(cursor_cnt >= MS1000)
		cursor_cnt <= 1;
	else
		cursor_cnt <= cursor_cnt + 1;
end

always @(posedge CLOCK_50) begin
	if(rst) begin
		kb_timer = 1;
		kb_state <= S0;
	end else begin
		case(kb_state)
		S0: begin
			if(ascii != 8'd0) begin
				kb_state <= S1;
				kb_timer <= 1;
			end else
				kb_state <= S0;
		end S1: begin
			kb_state <= ascii == 0 ? S0 : S1;
			if(kb_timer >= MS250) 
				kb_timer <= 1;
			else
				kb_timer <= kb_timer + 1;
		end S2: begin
			kb_state <= S0;
		end S3: begin
			kb_state <= S0;
		end
		endcase
	end
end

wire [31:0] pc;
assign LEDR[0] = global_int_en;
assign LEDR[9] = is_error;
display7seg seg0(pc[3:0], HEX0, 1'b0);
display7seg seg1(pc[7:4], HEX1, 1'b0);
display7seg seg2(pc[11:8], HEX2, 1'b0);
display7seg seg3(pc[15:12], HEX3, 1'b0);
display7seg seg4(ascii[3:0], HEX4, 1'b0);
display7seg seg5(ascii[7:4], HEX5, 1'b0);

function [11:0] mul12;
	input [11:0]x;
	begin
		mul12 = (x<<3)+(x<<2);
	end
endfunction
endmodule