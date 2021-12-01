module kb_driver(
	input CLOCK_50,
	input clrn,
	inout PS2_CLK,
	inout PS2_DAT,
	output reg is_shift,
	output reg is_ctrl,
	output reg is_capital,
	output reg is_error,
	output reg is_special,
	output [7:0] out
);
	
parameter SHIFT = 8'h12, CTRL = 8'h14, CAPS = 8'h58, BREAK_CODE = 8'hF0, SPECIAL_CODE = 8'hE0;
parameter UP=8'h75, DOWN=8'h72, LEFT=8'h6B, RIGHT=8'h74;

wire [7:0] ps2_data;
reg nextdata_n;
wire ready;
reg [7:0] data;
reg empty;

wire [7:0] ascii;
reg [7:0] special_out;

wire overflow;

reg [7:0] cnt;

reg [7:0] state;	//FSM
parameter S0 = 8'b0000_0001, 	//空闲状态
			S1 = 8'b0000_0010, 	//按键按下状态
			S2 = 8'b0000_0100, 	//断码输入状态
			S3 = 8'b0000_1000,	//E0状态
			S4 = 8'b0001_0000, 	
			S5 = 8'b0010_0000, 
			S6 = 8'b0100_0000, 
			S7 = 8'b1000_0000;	//错误状态


initial begin
	state <= S0; cnt <= 0; nextdata_n <= 1'b1; empty <= 1'b1; is_shift <= 1'b0;  is_ctrl = 1'b0;
	data <= 8'd0; is_capital <= 1'b0; is_error <= 1'b0;
end


ps2_keyboard keyboard(CLOCK_50, ~clrn, PS2_CLK, PS2_DAT, ps2_data, ready, nextdata_n, overflow);
kb2ascii data2ascii(~CLOCK_50, data, is_capital, is_shift, ascii);

assign out = is_special ? special_out : ascii;

always @(negedge CLOCK_50) begin
	if(clrn) begin
		state <= S0; cnt <= 0; nextdata_n <= 1'b1; empty <= 1'b1; is_shift <= 1'b0;  is_ctrl = 1'b0;
		data <= 8'd0; is_capital <= 1'b0; is_error = 1'b0; is_special <= 1'b0;
	end else begin
		if(nextdata_n == 0)
			nextdata_n <= 1;
			
		if(ready) begin
			case(state)
				S0: if (ps2_data == BREAK_CODE) 
						state <= S7;
					else if (ps2_data == SPECIAL_CODE)
						state <= S3;
					else begin
						state <= S1;
						if(ps2_data == SHIFT)
							is_shift <= 1;
						else if(ps2_data == CTRL)
							is_ctrl <= 1;
						else if(ps2_data == CAPS)
							state <= S1;
						else begin
							cnt <= cnt + 1'b1;
							empty <= 0;
							data <= ps2_data;
						end
					end	
				S1: if (ps2_data == BREAK_CODE) 
						state <= S2; 
					else if(ps2_data == SPECIAL_CODE)
						state <= S3;
					else if(ps2_data == SHIFT) 
						is_shift <= 1'b1;
					else if(ps2_data == CTRL)
						is_ctrl <= 1'b1;
					else if(data == 8'd0) begin
						cnt <= cnt + 1'b1;
						empty <= 0;
						data <= ps2_data;
					end else if(ps2_data != data) //不允许多字母输入
						state <= S7;	
					else begin //保持按下状态
						state <= S1; 
						data <= ps2_data; 
					end
				S2: begin 
					if(ps2_data == SHIFT) begin
						is_shift <= 1'b0;
						state <= (data == 8'd0 && is_ctrl == 1'b0) ? S0 : S1;
					end else if(ps2_data == CTRL) begin
						is_ctrl <= 1'b0;
						state <= (data == 8'd0 && is_shift == 1'b0) ? S0 : S1;
					end else if(ps2_data == CAPS) begin	//在CAPS键松开时检查
						is_capital <= ~is_capital;
						state <= (data == 8'd0 && is_ctrl == 1'b0 && is_shift == 1'b0) ? S0 : S1;
					end else if(ps2_data == data) begin
						empty <= 1'b1;
						data <= 8'd0;
						state <= (is_ctrl == 1'b0 && is_shift == 1'b0) ? S0 : S1;
					end else	//未知操作
						state <= S7;
				end
				S3: begin
					case (ps2_data)
						UP: begin state <= S1; data <= ps2_data; special_out <= UP; is_special<=1'b1; end
						DOWN: begin state <= S1; data <= ps2_data; special_out <= DOWN; is_special<=1'b1;  end
						LEFT: begin state <= S1; data <= ps2_data; special_out <= LEFT; is_special<=1'b1;  end
						RIGHT: begin state <= S1; data <= ps2_data; special_out <= RIGHT; is_special<=1'b1;  end 
						BREAK_CODE: begin state <= S2; is_special<=1'b0;  end
						default: state <= S7;
					endcase
				end
				S7: is_error <= 1'b1;
			endcase
			nextdata_n <= 1'b0;
		end
	end
end

endmodule