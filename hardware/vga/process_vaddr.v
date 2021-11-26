module process_vaddr (
    input [9:0]vaddr,
    output reg [4:0] y,
    output reg [3:0] remain
);
    
always @(vaddr) begin
case(vaddr) 
10'd1: begin
	y<=5'd0; remain<=4'd0;
end 10'd2: begin
	y<=5'd0; remain<=4'd1;
end 10'd3: begin
	y<=5'd0; remain<=4'd2;
end 10'd4: begin
	y<=5'd0; remain<=4'd3;
end 10'd5: begin
	y<=5'd0; remain<=4'd4;
end 10'd6: begin
	y<=5'd0; remain<=4'd5;
end 10'd7: begin
	y<=5'd0; remain<=4'd6;
end 10'd8: begin
	y<=5'd0; remain<=4'd7;
end 10'd9: begin
	y<=5'd0; remain<=4'd8;
end 10'd10: begin
	y<=5'd0; remain<=4'd9;
end 10'd11: begin
	y<=5'd0; remain<=4'd10;
end 10'd12: begin
	y<=5'd0; remain<=4'd11;
end 10'd13: begin
	y<=5'd0; remain<=4'd12;
end 10'd14: begin
	y<=5'd0; remain<=4'd13;
end 10'd15: begin
	y<=5'd0; remain<=4'd14;
end 10'd16: begin
	y<=5'd0; remain<=4'd15;
end 10'd17: begin
	y<=5'd1; remain<=4'd0;
end 10'd18: begin
	y<=5'd1; remain<=4'd1;
end 10'd19: begin
	y<=5'd1; remain<=4'd2;
end 10'd20: begin
	y<=5'd1; remain<=4'd3;
end 10'd21: begin
	y<=5'd1; remain<=4'd4;
end 10'd22: begin
	y<=5'd1; remain<=4'd5;
end 10'd23: begin
	y<=5'd1; remain<=4'd6;
end 10'd24: begin
	y<=5'd1; remain<=4'd7;
end 10'd25: begin
	y<=5'd1; remain<=4'd8;
end 10'd26: begin
	y<=5'd1; remain<=4'd9;
end 10'd27: begin
	y<=5'd1; remain<=4'd10;
end 10'd28: begin
	y<=5'd1; remain<=4'd11;
end 10'd29: begin
	y<=5'd1; remain<=4'd12;
end 10'd30: begin
	y<=5'd1; remain<=4'd13;
end 10'd31: begin
	y<=5'd1; remain<=4'd14;
end 10'd32: begin
	y<=5'd1; remain<=4'd15;
end 10'd33: begin
	y<=5'd2; remain<=4'd0;
end 10'd34: begin
	y<=5'd2; remain<=4'd1;
end 10'd35: begin
	y<=5'd2; remain<=4'd2;
end 10'd36: begin
	y<=5'd2; remain<=4'd3;
end 10'd37: begin
	y<=5'd2; remain<=4'd4;
end 10'd38: begin
	y<=5'd2; remain<=4'd5;
end 10'd39: begin
	y<=5'd2; remain<=4'd6;
end 10'd40: begin
	y<=5'd2; remain<=4'd7;
end 10'd41: begin
	y<=5'd2; remain<=4'd8;
end 10'd42: begin
	y<=5'd2; remain<=4'd9;
end 10'd43: begin
	y<=5'd2; remain<=4'd10;
end 10'd44: begin
	y<=5'd2; remain<=4'd11;
end 10'd45: begin
	y<=5'd2; remain<=4'd12;
end 10'd46: begin
	y<=5'd2; remain<=4'd13;
end 10'd47: begin
	y<=5'd2; remain<=4'd14;
end 10'd48: begin
	y<=5'd2; remain<=4'd15;
end 10'd49: begin
	y<=5'd3; remain<=4'd0;
end 10'd50: begin
	y<=5'd3; remain<=4'd1;
end 10'd51: begin
	y<=5'd3; remain<=4'd2;
end 10'd52: begin
	y<=5'd3; remain<=4'd3;
end 10'd53: begin
	y<=5'd3; remain<=4'd4;
end 10'd54: begin
	y<=5'd3; remain<=4'd5;
end 10'd55: begin
	y<=5'd3; remain<=4'd6;
end 10'd56: begin
	y<=5'd3; remain<=4'd7;
end 10'd57: begin
	y<=5'd3; remain<=4'd8;
end 10'd58: begin
	y<=5'd3; remain<=4'd9;
end 10'd59: begin
	y<=5'd3; remain<=4'd10;
end 10'd60: begin
	y<=5'd3; remain<=4'd11;
end 10'd61: begin
	y<=5'd3; remain<=4'd12;
end 10'd62: begin
	y<=5'd3; remain<=4'd13;
end 10'd63: begin
	y<=5'd3; remain<=4'd14;
end 10'd64: begin
	y<=5'd3; remain<=4'd15;
end 10'd65: begin
	y<=5'd4; remain<=4'd0;
end 10'd66: begin
	y<=5'd4; remain<=4'd1;
end 10'd67: begin
	y<=5'd4; remain<=4'd2;
end 10'd68: begin
	y<=5'd4; remain<=4'd3;
end 10'd69: begin
	y<=5'd4; remain<=4'd4;
end 10'd70: begin
	y<=5'd4; remain<=4'd5;
end 10'd71: begin
	y<=5'd4; remain<=4'd6;
end 10'd72: begin
	y<=5'd4; remain<=4'd7;
end 10'd73: begin
	y<=5'd4; remain<=4'd8;
end 10'd74: begin
	y<=5'd4; remain<=4'd9;
end 10'd75: begin
	y<=5'd4; remain<=4'd10;
end 10'd76: begin
	y<=5'd4; remain<=4'd11;
end 10'd77: begin
	y<=5'd4; remain<=4'd12;
end 10'd78: begin
	y<=5'd4; remain<=4'd13;
end 10'd79: begin
	y<=5'd4; remain<=4'd14;
end 10'd80: begin
	y<=5'd4; remain<=4'd15;
end 10'd81: begin
	y<=5'd5; remain<=4'd0;
end 10'd82: begin
	y<=5'd5; remain<=4'd1;
end 10'd83: begin
	y<=5'd5; remain<=4'd2;
end 10'd84: begin
	y<=5'd5; remain<=4'd3;
end 10'd85: begin
	y<=5'd5; remain<=4'd4;
end 10'd86: begin
	y<=5'd5; remain<=4'd5;
end 10'd87: begin
	y<=5'd5; remain<=4'd6;
end 10'd88: begin
	y<=5'd5; remain<=4'd7;
end 10'd89: begin
	y<=5'd5; remain<=4'd8;
end 10'd90: begin
	y<=5'd5; remain<=4'd9;
end 10'd91: begin
	y<=5'd5; remain<=4'd10;
end 10'd92: begin
	y<=5'd5; remain<=4'd11;
end 10'd93: begin
	y<=5'd5; remain<=4'd12;
end 10'd94: begin
	y<=5'd5; remain<=4'd13;
end 10'd95: begin
	y<=5'd5; remain<=4'd14;
end 10'd96: begin
	y<=5'd5; remain<=4'd15;
end 10'd97: begin
	y<=5'd6; remain<=4'd0;
end 10'd98: begin
	y<=5'd6; remain<=4'd1;
end 10'd99: begin
	y<=5'd6; remain<=4'd2;
end 10'd100: begin
	y<=5'd6; remain<=4'd3;
end 10'd101: begin
	y<=5'd6; remain<=4'd4;
end 10'd102: begin
	y<=5'd6; remain<=4'd5;
end 10'd103: begin
	y<=5'd6; remain<=4'd6;
end 10'd104: begin
	y<=5'd6; remain<=4'd7;
end 10'd105: begin
	y<=5'd6; remain<=4'd8;
end 10'd106: begin
	y<=5'd6; remain<=4'd9;
end 10'd107: begin
	y<=5'd6; remain<=4'd10;
end 10'd108: begin
	y<=5'd6; remain<=4'd11;
end 10'd109: begin
	y<=5'd6; remain<=4'd12;
end 10'd110: begin
	y<=5'd6; remain<=4'd13;
end 10'd111: begin
	y<=5'd6; remain<=4'd14;
end 10'd112: begin
	y<=5'd6; remain<=4'd15;
end 10'd113: begin
	y<=5'd7; remain<=4'd0;
end 10'd114: begin
	y<=5'd7; remain<=4'd1;
end 10'd115: begin
	y<=5'd7; remain<=4'd2;
end 10'd116: begin
	y<=5'd7; remain<=4'd3;
end 10'd117: begin
	y<=5'd7; remain<=4'd4;
end 10'd118: begin
	y<=5'd7; remain<=4'd5;
end 10'd119: begin
	y<=5'd7; remain<=4'd6;
end 10'd120: begin
	y<=5'd7; remain<=4'd7;
end 10'd121: begin
	y<=5'd7; remain<=4'd8;
end 10'd122: begin
	y<=5'd7; remain<=4'd9;
end 10'd123: begin
	y<=5'd7; remain<=4'd10;
end 10'd124: begin
	y<=5'd7; remain<=4'd11;
end 10'd125: begin
	y<=5'd7; remain<=4'd12;
end 10'd126: begin
	y<=5'd7; remain<=4'd13;
end 10'd127: begin
	y<=5'd7; remain<=4'd14;
end 10'd128: begin
	y<=5'd7; remain<=4'd15;
end 10'd129: begin
	y<=5'd8; remain<=4'd0;
end 10'd130: begin
	y<=5'd8; remain<=4'd1;
end 10'd131: begin
	y<=5'd8; remain<=4'd2;
end 10'd132: begin
	y<=5'd8; remain<=4'd3;
end 10'd133: begin
	y<=5'd8; remain<=4'd4;
end 10'd134: begin
	y<=5'd8; remain<=4'd5;
end 10'd135: begin
	y<=5'd8; remain<=4'd6;
end 10'd136: begin
	y<=5'd8; remain<=4'd7;
end 10'd137: begin
	y<=5'd8; remain<=4'd8;
end 10'd138: begin
	y<=5'd8; remain<=4'd9;
end 10'd139: begin
	y<=5'd8; remain<=4'd10;
end 10'd140: begin
	y<=5'd8; remain<=4'd11;
end 10'd141: begin
	y<=5'd8; remain<=4'd12;
end 10'd142: begin
	y<=5'd8; remain<=4'd13;
end 10'd143: begin
	y<=5'd8; remain<=4'd14;
end 10'd144: begin
	y<=5'd8; remain<=4'd15;
end 10'd145: begin
	y<=5'd9; remain<=4'd0;
end 10'd146: begin
	y<=5'd9; remain<=4'd1;
end 10'd147: begin
	y<=5'd9; remain<=4'd2;
end 10'd148: begin
	y<=5'd9; remain<=4'd3;
end 10'd149: begin
	y<=5'd9; remain<=4'd4;
end 10'd150: begin
	y<=5'd9; remain<=4'd5;
end 10'd151: begin
	y<=5'd9; remain<=4'd6;
end 10'd152: begin
	y<=5'd9; remain<=4'd7;
end 10'd153: begin
	y<=5'd9; remain<=4'd8;
end 10'd154: begin
	y<=5'd9; remain<=4'd9;
end 10'd155: begin
	y<=5'd9; remain<=4'd10;
end 10'd156: begin
	y<=5'd9; remain<=4'd11;
end 10'd157: begin
	y<=5'd9; remain<=4'd12;
end 10'd158: begin
	y<=5'd9; remain<=4'd13;
end 10'd159: begin
	y<=5'd9; remain<=4'd14;
end 10'd160: begin
	y<=5'd9; remain<=4'd15;
end 10'd161: begin
	y<=5'd10; remain<=4'd0;
end 10'd162: begin
	y<=5'd10; remain<=4'd1;
end 10'd163: begin
	y<=5'd10; remain<=4'd2;
end 10'd164: begin
	y<=5'd10; remain<=4'd3;
end 10'd165: begin
	y<=5'd10; remain<=4'd4;
end 10'd166: begin
	y<=5'd10; remain<=4'd5;
end 10'd167: begin
	y<=5'd10; remain<=4'd6;
end 10'd168: begin
	y<=5'd10; remain<=4'd7;
end 10'd169: begin
	y<=5'd10; remain<=4'd8;
end 10'd170: begin
	y<=5'd10; remain<=4'd9;
end 10'd171: begin
	y<=5'd10; remain<=4'd10;
end 10'd172: begin
	y<=5'd10; remain<=4'd11;
end 10'd173: begin
	y<=5'd10; remain<=4'd12;
end 10'd174: begin
	y<=5'd10; remain<=4'd13;
end 10'd175: begin
	y<=5'd10; remain<=4'd14;
end 10'd176: begin
	y<=5'd10; remain<=4'd15;
end 10'd177: begin
	y<=5'd11; remain<=4'd0;
end 10'd178: begin
	y<=5'd11; remain<=4'd1;
end 10'd179: begin
	y<=5'd11; remain<=4'd2;
end 10'd180: begin
	y<=5'd11; remain<=4'd3;
end 10'd181: begin
	y<=5'd11; remain<=4'd4;
end 10'd182: begin
	y<=5'd11; remain<=4'd5;
end 10'd183: begin
	y<=5'd11; remain<=4'd6;
end 10'd184: begin
	y<=5'd11; remain<=4'd7;
end 10'd185: begin
	y<=5'd11; remain<=4'd8;
end 10'd186: begin
	y<=5'd11; remain<=4'd9;
end 10'd187: begin
	y<=5'd11; remain<=4'd10;
end 10'd188: begin
	y<=5'd11; remain<=4'd11;
end 10'd189: begin
	y<=5'd11; remain<=4'd12;
end 10'd190: begin
	y<=5'd11; remain<=4'd13;
end 10'd191: begin
	y<=5'd11; remain<=4'd14;
end 10'd192: begin
	y<=5'd11; remain<=4'd15;
end 10'd193: begin
	y<=5'd12; remain<=4'd0;
end 10'd194: begin
	y<=5'd12; remain<=4'd1;
end 10'd195: begin
	y<=5'd12; remain<=4'd2;
end 10'd196: begin
	y<=5'd12; remain<=4'd3;
end 10'd197: begin
	y<=5'd12; remain<=4'd4;
end 10'd198: begin
	y<=5'd12; remain<=4'd5;
end 10'd199: begin
	y<=5'd12; remain<=4'd6;
end 10'd200: begin
	y<=5'd12; remain<=4'd7;
end 10'd201: begin
	y<=5'd12; remain<=4'd8;
end 10'd202: begin
	y<=5'd12; remain<=4'd9;
end 10'd203: begin
	y<=5'd12; remain<=4'd10;
end 10'd204: begin
	y<=5'd12; remain<=4'd11;
end 10'd205: begin
	y<=5'd12; remain<=4'd12;
end 10'd206: begin
	y<=5'd12; remain<=4'd13;
end 10'd207: begin
	y<=5'd12; remain<=4'd14;
end 10'd208: begin
	y<=5'd12; remain<=4'd15;
end 10'd209: begin
	y<=5'd13; remain<=4'd0;
end 10'd210: begin
	y<=5'd13; remain<=4'd1;
end 10'd211: begin
	y<=5'd13; remain<=4'd2;
end 10'd212: begin
	y<=5'd13; remain<=4'd3;
end 10'd213: begin
	y<=5'd13; remain<=4'd4;
end 10'd214: begin
	y<=5'd13; remain<=4'd5;
end 10'd215: begin
	y<=5'd13; remain<=4'd6;
end 10'd216: begin
	y<=5'd13; remain<=4'd7;
end 10'd217: begin
	y<=5'd13; remain<=4'd8;
end 10'd218: begin
	y<=5'd13; remain<=4'd9;
end 10'd219: begin
	y<=5'd13; remain<=4'd10;
end 10'd220: begin
	y<=5'd13; remain<=4'd11;
end 10'd221: begin
	y<=5'd13; remain<=4'd12;
end 10'd222: begin
	y<=5'd13; remain<=4'd13;
end 10'd223: begin
	y<=5'd13; remain<=4'd14;
end 10'd224: begin
	y<=5'd13; remain<=4'd15;
end 10'd225: begin
	y<=5'd14; remain<=4'd0;
end 10'd226: begin
	y<=5'd14; remain<=4'd1;
end 10'd227: begin
	y<=5'd14; remain<=4'd2;
end 10'd228: begin
	y<=5'd14; remain<=4'd3;
end 10'd229: begin
	y<=5'd14; remain<=4'd4;
end 10'd230: begin
	y<=5'd14; remain<=4'd5;
end 10'd231: begin
	y<=5'd14; remain<=4'd6;
end 10'd232: begin
	y<=5'd14; remain<=4'd7;
end 10'd233: begin
	y<=5'd14; remain<=4'd8;
end 10'd234: begin
	y<=5'd14; remain<=4'd9;
end 10'd235: begin
	y<=5'd14; remain<=4'd10;
end 10'd236: begin
	y<=5'd14; remain<=4'd11;
end 10'd237: begin
	y<=5'd14; remain<=4'd12;
end 10'd238: begin
	y<=5'd14; remain<=4'd13;
end 10'd239: begin
	y<=5'd14; remain<=4'd14;
end 10'd240: begin
	y<=5'd14; remain<=4'd15;
end 10'd241: begin
	y<=5'd15; remain<=4'd0;
end 10'd242: begin
	y<=5'd15; remain<=4'd1;
end 10'd243: begin
	y<=5'd15; remain<=4'd2;
end 10'd244: begin
	y<=5'd15; remain<=4'd3;
end 10'd245: begin
	y<=5'd15; remain<=4'd4;
end 10'd246: begin
	y<=5'd15; remain<=4'd5;
end 10'd247: begin
	y<=5'd15; remain<=4'd6;
end 10'd248: begin
	y<=5'd15; remain<=4'd7;
end 10'd249: begin
	y<=5'd15; remain<=4'd8;
end 10'd250: begin
	y<=5'd15; remain<=4'd9;
end 10'd251: begin
	y<=5'd15; remain<=4'd10;
end 10'd252: begin
	y<=5'd15; remain<=4'd11;
end 10'd253: begin
	y<=5'd15; remain<=4'd12;
end 10'd254: begin
	y<=5'd15; remain<=4'd13;
end 10'd255: begin
	y<=5'd15; remain<=4'd14;
end 10'd256: begin
	y<=5'd15; remain<=4'd15;
end 10'd257: begin
	y<=5'd16; remain<=4'd0;
end 10'd258: begin
	y<=5'd16; remain<=4'd1;
end 10'd259: begin
	y<=5'd16; remain<=4'd2;
end 10'd260: begin
	y<=5'd16; remain<=4'd3;
end 10'd261: begin
	y<=5'd16; remain<=4'd4;
end 10'd262: begin
	y<=5'd16; remain<=4'd5;
end 10'd263: begin
	y<=5'd16; remain<=4'd6;
end 10'd264: begin
	y<=5'd16; remain<=4'd7;
end 10'd265: begin
	y<=5'd16; remain<=4'd8;
end 10'd266: begin
	y<=5'd16; remain<=4'd9;
end 10'd267: begin
	y<=5'd16; remain<=4'd10;
end 10'd268: begin
	y<=5'd16; remain<=4'd11;
end 10'd269: begin
	y<=5'd16; remain<=4'd12;
end 10'd270: begin
	y<=5'd16; remain<=4'd13;
end 10'd271: begin
	y<=5'd16; remain<=4'd14;
end 10'd272: begin
	y<=5'd16; remain<=4'd15;
end 10'd273: begin
	y<=5'd17; remain<=4'd0;
end 10'd274: begin
	y<=5'd17; remain<=4'd1;
end 10'd275: begin
	y<=5'd17; remain<=4'd2;
end 10'd276: begin
	y<=5'd17; remain<=4'd3;
end 10'd277: begin
	y<=5'd17; remain<=4'd4;
end 10'd278: begin
	y<=5'd17; remain<=4'd5;
end 10'd279: begin
	y<=5'd17; remain<=4'd6;
end 10'd280: begin
	y<=5'd17; remain<=4'd7;
end 10'd281: begin
	y<=5'd17; remain<=4'd8;
end 10'd282: begin
	y<=5'd17; remain<=4'd9;
end 10'd283: begin
	y<=5'd17; remain<=4'd10;
end 10'd284: begin
	y<=5'd17; remain<=4'd11;
end 10'd285: begin
	y<=5'd17; remain<=4'd12;
end 10'd286: begin
	y<=5'd17; remain<=4'd13;
end 10'd287: begin
	y<=5'd17; remain<=4'd14;
end 10'd288: begin
	y<=5'd17; remain<=4'd15;
end 10'd289: begin
	y<=5'd18; remain<=4'd0;
end 10'd290: begin
	y<=5'd18; remain<=4'd1;
end 10'd291: begin
	y<=5'd18; remain<=4'd2;
end 10'd292: begin
	y<=5'd18; remain<=4'd3;
end 10'd293: begin
	y<=5'd18; remain<=4'd4;
end 10'd294: begin
	y<=5'd18; remain<=4'd5;
end 10'd295: begin
	y<=5'd18; remain<=4'd6;
end 10'd296: begin
	y<=5'd18; remain<=4'd7;
end 10'd297: begin
	y<=5'd18; remain<=4'd8;
end 10'd298: begin
	y<=5'd18; remain<=4'd9;
end 10'd299: begin
	y<=5'd18; remain<=4'd10;
end 10'd300: begin
	y<=5'd18; remain<=4'd11;
end 10'd301: begin
	y<=5'd18; remain<=4'd12;
end 10'd302: begin
	y<=5'd18; remain<=4'd13;
end 10'd303: begin
	y<=5'd18; remain<=4'd14;
end 10'd304: begin
	y<=5'd18; remain<=4'd15;
end 10'd305: begin
	y<=5'd19; remain<=4'd0;
end 10'd306: begin
	y<=5'd19; remain<=4'd1;
end 10'd307: begin
	y<=5'd19; remain<=4'd2;
end 10'd308: begin
	y<=5'd19; remain<=4'd3;
end 10'd309: begin
	y<=5'd19; remain<=4'd4;
end 10'd310: begin
	y<=5'd19; remain<=4'd5;
end 10'd311: begin
	y<=5'd19; remain<=4'd6;
end 10'd312: begin
	y<=5'd19; remain<=4'd7;
end 10'd313: begin
	y<=5'd19; remain<=4'd8;
end 10'd314: begin
	y<=5'd19; remain<=4'd9;
end 10'd315: begin
	y<=5'd19; remain<=4'd10;
end 10'd316: begin
	y<=5'd19; remain<=4'd11;
end 10'd317: begin
	y<=5'd19; remain<=4'd12;
end 10'd318: begin
	y<=5'd19; remain<=4'd13;
end 10'd319: begin
	y<=5'd19; remain<=4'd14;
end 10'd320: begin
	y<=5'd19; remain<=4'd15;
end 10'd321: begin
	y<=5'd20; remain<=4'd0;
end 10'd322: begin
	y<=5'd20; remain<=4'd1;
end 10'd323: begin
	y<=5'd20; remain<=4'd2;
end 10'd324: begin
	y<=5'd20; remain<=4'd3;
end 10'd325: begin
	y<=5'd20; remain<=4'd4;
end 10'd326: begin
	y<=5'd20; remain<=4'd5;
end 10'd327: begin
	y<=5'd20; remain<=4'd6;
end 10'd328: begin
	y<=5'd20; remain<=4'd7;
end 10'd329: begin
	y<=5'd20; remain<=4'd8;
end 10'd330: begin
	y<=5'd20; remain<=4'd9;
end 10'd331: begin
	y<=5'd20; remain<=4'd10;
end 10'd332: begin
	y<=5'd20; remain<=4'd11;
end 10'd333: begin
	y<=5'd20; remain<=4'd12;
end 10'd334: begin
	y<=5'd20; remain<=4'd13;
end 10'd335: begin
	y<=5'd20; remain<=4'd14;
end 10'd336: begin
	y<=5'd20; remain<=4'd15;
end 10'd337: begin
	y<=5'd21; remain<=4'd0;
end 10'd338: begin
	y<=5'd21; remain<=4'd1;
end 10'd339: begin
	y<=5'd21; remain<=4'd2;
end 10'd340: begin
	y<=5'd21; remain<=4'd3;
end 10'd341: begin
	y<=5'd21; remain<=4'd4;
end 10'd342: begin
	y<=5'd21; remain<=4'd5;
end 10'd343: begin
	y<=5'd21; remain<=4'd6;
end 10'd344: begin
	y<=5'd21; remain<=4'd7;
end 10'd345: begin
	y<=5'd21; remain<=4'd8;
end 10'd346: begin
	y<=5'd21; remain<=4'd9;
end 10'd347: begin
	y<=5'd21; remain<=4'd10;
end 10'd348: begin
	y<=5'd21; remain<=4'd11;
end 10'd349: begin
	y<=5'd21; remain<=4'd12;
end 10'd350: begin
	y<=5'd21; remain<=4'd13;
end 10'd351: begin
	y<=5'd21; remain<=4'd14;
end 10'd352: begin
	y<=5'd21; remain<=4'd15;
end 10'd353: begin
	y<=5'd22; remain<=4'd0;
end 10'd354: begin
	y<=5'd22; remain<=4'd1;
end 10'd355: begin
	y<=5'd22; remain<=4'd2;
end 10'd356: begin
	y<=5'd22; remain<=4'd3;
end 10'd357: begin
	y<=5'd22; remain<=4'd4;
end 10'd358: begin
	y<=5'd22; remain<=4'd5;
end 10'd359: begin
	y<=5'd22; remain<=4'd6;
end 10'd360: begin
	y<=5'd22; remain<=4'd7;
end 10'd361: begin
	y<=5'd22; remain<=4'd8;
end 10'd362: begin
	y<=5'd22; remain<=4'd9;
end 10'd363: begin
	y<=5'd22; remain<=4'd10;
end 10'd364: begin
	y<=5'd22; remain<=4'd11;
end 10'd365: begin
	y<=5'd22; remain<=4'd12;
end 10'd366: begin
	y<=5'd22; remain<=4'd13;
end 10'd367: begin
	y<=5'd22; remain<=4'd14;
end 10'd368: begin
	y<=5'd22; remain<=4'd15;
end 10'd369: begin
	y<=5'd23; remain<=4'd0;
end 10'd370: begin
	y<=5'd23; remain<=4'd1;
end 10'd371: begin
	y<=5'd23; remain<=4'd2;
end 10'd372: begin
	y<=5'd23; remain<=4'd3;
end 10'd373: begin
	y<=5'd23; remain<=4'd4;
end 10'd374: begin
	y<=5'd23; remain<=4'd5;
end 10'd375: begin
	y<=5'd23; remain<=4'd6;
end 10'd376: begin
	y<=5'd23; remain<=4'd7;
end 10'd377: begin
	y<=5'd23; remain<=4'd8;
end 10'd378: begin
	y<=5'd23; remain<=4'd9;
end 10'd379: begin
	y<=5'd23; remain<=4'd10;
end 10'd380: begin
	y<=5'd23; remain<=4'd11;
end 10'd381: begin
	y<=5'd23; remain<=4'd12;
end 10'd382: begin
	y<=5'd23; remain<=4'd13;
end 10'd383: begin
	y<=5'd23; remain<=4'd14;
end 10'd384: begin
	y<=5'd23; remain<=4'd15;
end 10'd385: begin
	y<=5'd24; remain<=4'd0;
end 10'd386: begin
	y<=5'd24; remain<=4'd1;
end 10'd387: begin
	y<=5'd24; remain<=4'd2;
end 10'd388: begin
	y<=5'd24; remain<=4'd3;
end 10'd389: begin
	y<=5'd24; remain<=4'd4;
end 10'd390: begin
	y<=5'd24; remain<=4'd5;
end 10'd391: begin
	y<=5'd24; remain<=4'd6;
end 10'd392: begin
	y<=5'd24; remain<=4'd7;
end 10'd393: begin
	y<=5'd24; remain<=4'd8;
end 10'd394: begin
	y<=5'd24; remain<=4'd9;
end 10'd395: begin
	y<=5'd24; remain<=4'd10;
end 10'd396: begin
	y<=5'd24; remain<=4'd11;
end 10'd397: begin
	y<=5'd24; remain<=4'd12;
end 10'd398: begin
	y<=5'd24; remain<=4'd13;
end 10'd399: begin
	y<=5'd24; remain<=4'd14;
end 10'd400: begin
	y<=5'd24; remain<=4'd15;
end 10'd401: begin
	y<=5'd25; remain<=4'd0;
end 10'd402: begin
	y<=5'd25; remain<=4'd1;
end 10'd403: begin
	y<=5'd25; remain<=4'd2;
end 10'd404: begin
	y<=5'd25; remain<=4'd3;
end 10'd405: begin
	y<=5'd25; remain<=4'd4;
end 10'd406: begin
	y<=5'd25; remain<=4'd5;
end 10'd407: begin
	y<=5'd25; remain<=4'd6;
end 10'd408: begin
	y<=5'd25; remain<=4'd7;
end 10'd409: begin
	y<=5'd25; remain<=4'd8;
end 10'd410: begin
	y<=5'd25; remain<=4'd9;
end 10'd411: begin
	y<=5'd25; remain<=4'd10;
end 10'd412: begin
	y<=5'd25; remain<=4'd11;
end 10'd413: begin
	y<=5'd25; remain<=4'd12;
end 10'd414: begin
	y<=5'd25; remain<=4'd13;
end 10'd415: begin
	y<=5'd25; remain<=4'd14;
end 10'd416: begin
	y<=5'd25; remain<=4'd15;
end 10'd417: begin
	y<=5'd26; remain<=4'd0;
end 10'd418: begin
	y<=5'd26; remain<=4'd1;
end 10'd419: begin
	y<=5'd26; remain<=4'd2;
end 10'd420: begin
	y<=5'd26; remain<=4'd3;
end 10'd421: begin
	y<=5'd26; remain<=4'd4;
end 10'd422: begin
	y<=5'd26; remain<=4'd5;
end 10'd423: begin
	y<=5'd26; remain<=4'd6;
end 10'd424: begin
	y<=5'd26; remain<=4'd7;
end 10'd425: begin
	y<=5'd26; remain<=4'd8;
end 10'd426: begin
	y<=5'd26; remain<=4'd9;
end 10'd427: begin
	y<=5'd26; remain<=4'd10;
end 10'd428: begin
	y<=5'd26; remain<=4'd11;
end 10'd429: begin
	y<=5'd26; remain<=4'd12;
end 10'd430: begin
	y<=5'd26; remain<=4'd13;
end 10'd431: begin
	y<=5'd26; remain<=4'd14;
end 10'd432: begin
	y<=5'd26; remain<=4'd15;
end 10'd433: begin
	y<=5'd27; remain<=4'd0;
end 10'd434: begin
	y<=5'd27; remain<=4'd1;
end 10'd435: begin
	y<=5'd27; remain<=4'd2;
end 10'd436: begin
	y<=5'd27; remain<=4'd3;
end 10'd437: begin
	y<=5'd27; remain<=4'd4;
end 10'd438: begin
	y<=5'd27; remain<=4'd5;
end 10'd439: begin
	y<=5'd27; remain<=4'd6;
end 10'd440: begin
	y<=5'd27; remain<=4'd7;
end 10'd441: begin
	y<=5'd27; remain<=4'd8;
end 10'd442: begin
	y<=5'd27; remain<=4'd9;
end 10'd443: begin
	y<=5'd27; remain<=4'd10;
end 10'd444: begin
	y<=5'd27; remain<=4'd11;
end 10'd445: begin
	y<=5'd27; remain<=4'd12;
end 10'd446: begin
	y<=5'd27; remain<=4'd13;
end 10'd447: begin
	y<=5'd27; remain<=4'd14;
end 10'd448: begin
	y<=5'd27; remain<=4'd15;
end 10'd449: begin
	y<=5'd28; remain<=4'd0;
end 10'd450: begin
	y<=5'd28; remain<=4'd1;
end 10'd451: begin
	y<=5'd28; remain<=4'd2;
end 10'd452: begin
	y<=5'd28; remain<=4'd3;
end 10'd453: begin
	y<=5'd28; remain<=4'd4;
end 10'd454: begin
	y<=5'd28; remain<=4'd5;
end 10'd455: begin
	y<=5'd28; remain<=4'd6;
end 10'd456: begin
	y<=5'd28; remain<=4'd7;
end 10'd457: begin
	y<=5'd28; remain<=4'd8;
end 10'd458: begin
	y<=5'd28; remain<=4'd9;
end 10'd459: begin
	y<=5'd28; remain<=4'd10;
end 10'd460: begin
	y<=5'd28; remain<=4'd11;
end 10'd461: begin
	y<=5'd28; remain<=4'd12;
end 10'd462: begin
	y<=5'd28; remain<=4'd13;
end 10'd463: begin
	y<=5'd28; remain<=4'd14;
end 10'd464: begin
	y<=5'd28; remain<=4'd15;
end 10'd465: begin
	y<=5'd29; remain<=4'd0;
end 10'd466: begin
	y<=5'd29; remain<=4'd1;
end 10'd467: begin
	y<=5'd29; remain<=4'd2;
end 10'd468: begin
	y<=5'd29; remain<=4'd3;
end 10'd469: begin
	y<=5'd29; remain<=4'd4;
end 10'd470: begin
	y<=5'd29; remain<=4'd5;
end 10'd471: begin
	y<=5'd29; remain<=4'd6;
end 10'd472: begin
	y<=5'd29; remain<=4'd7;
end 10'd473: begin
	y<=5'd29; remain<=4'd8;
end 10'd474: begin
	y<=5'd29; remain<=4'd9;
end 10'd475: begin
	y<=5'd29; remain<=4'd10;
end 10'd476: begin
	y<=5'd29; remain<=4'd11;
end 10'd477: begin
	y<=5'd29; remain<=4'd12;
end 10'd478: begin
	y<=5'd29; remain<=4'd13;
end 10'd479: begin
	y<=5'd29; remain<=4'd14;
end 10'd480: begin
	y<=5'd29; remain<=4'd15;
end default: begin y<=5'd0; remain<=4'd0; end
endcase
end
endmodule