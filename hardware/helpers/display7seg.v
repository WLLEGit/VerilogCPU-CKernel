module display7seg(in, sseg, empty);
	input [3:0] in;
	input empty;
	output reg [6:0]sseg;


	 always@ * begin
		if(empty)
			sseg[6:0] <= 7'b1111111;
		else
		  case(in)
			4'h0: sseg[6:0] <= 7'b1000000;
			4'h1: sseg[6:0] <= 7'b1111001;
			4'h2: sseg[6:0] <= 7'b0100100;
			4'h3: sseg[6:0] <= 7'b0110000;
			4'h4: sseg[6:0] <= 7'b0011001;
			4'h5: sseg[6:0] <= 7'b0010010;
			4'h6: sseg[6:0] <= 7'b0000010;
			4'h7: sseg[6:0] <= 7'b1111000;
			4'h8: sseg[6:0] <= ~7'h7f;
			4'h9: sseg[6:0] <= ~7'h6f;
			4'ha: sseg[6:0] <= ~7'h77;
			4'hb: sseg[6:0] <= ~7'h7c;
			4'hc: sseg[6:0] <= ~7'h39;
			4'hd: sseg[6:0] <= ~7'h5e;
			4'he: sseg[6:0] <= ~7'h79;
			4'hf: sseg[6:0] <= ~7'h71;
			default: sseg[6:0] <= 7'b1010101; //empty
		  endcase
	 end

endmodule