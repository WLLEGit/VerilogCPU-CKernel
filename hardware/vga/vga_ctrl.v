module vga_ctrl (
    input pclk,             //25MHz, 60fps
    input reset,
    input [23:0] vga_data,  //VGA颜色数据
    output [9:0] h_addr,    //提供给上层的当前扫描像素点 h:x, v:y
    output [9:0] v_addr,    
    output hsync,           //同步信号
    output vsync,
    output valid,           //消隐信号
    output [7:0] vga_r,
    output [7:0] vga_g,
    output [7:0] vga_b
);

parameter h_frontporch = 96;    //场同步负脉冲数量
parameter h_active = 144;       //场消隐开始帧
parameter h_backporch = 784;    //末尾负脉冲开始帧
parameter h_total = 800;

parameter v_frontporch = 2;
parameter v_active = 35;
parameter v_backporch = 515;
parameter v_total = 525;

reg [9:0] x_cnt;
reg [9:0] y_cnt;
wire h_valid;
wire v_valid;

always @(posedge reset or posedge pclk) begin
    if(reset == 1'b1) begin
        x_cnt <= 1;
    end else begin
        if(x_cnt == h_total) 
            x_cnt <= 1;
        else
            x_cnt <= x_cnt + 10'd1;
    end
end

always @(posedge reset or posedge pclk) begin
    if(reset == 1'b1)
        y_cnt <= 1;
    else begin
		if(y_cnt == v_total & x_cnt == h_total)
            y_cnt <= 1;
		else if(x_cnt == h_total)
            y_cnt <= y_cnt + 10'd1;
    end
end

//同步信号
assign hsync = (x_cnt > h_frontporch);
assign vsync = (y_cnt > v_frontporch);

//消隐信号
assign h_valid = (x_cnt > h_active) & (x_cnt <= h_backporch); 
assign v_valid = (y_cnt > v_active) & (y_cnt <= v_backporch); 
assign valid = h_valid & v_valid;

//当前像素坐标
assign h_addr = h_valid ? (x_cnt - 10'd145) : 10'd0;
assign v_addr = v_valid ? (y_cnt - 10'd36) : 10'd0;

//设置输出的颜色
assign vga_r = vga_data[23:16];
assign vga_g = vga_data[15:8];
assign vga_b = vga_data[7:0];

endmodule