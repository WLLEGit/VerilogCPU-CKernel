module process_haddr (
    input [9:0]haddr,
    output reg [6:0] x,
    output reg [3:0] remain
);
    
always @(haddr) begin
case(haddr) 
10'd1: begin
	x<=7'd0; remain<=4'd0;
end 10'd2: begin
	x<=7'd0; remain<=4'd1;
end 10'd3: begin
	x<=7'd0; remain<=4'd2;
end 10'd4: begin
	x<=7'd0; remain<=4'd3;
end 10'd5: begin
	x<=7'd0; remain<=4'd4;
end 10'd6: begin
	x<=7'd0; remain<=4'd5;
end 10'd7: begin
	x<=7'd0; remain<=4'd6;
end 10'd8: begin
	x<=7'd0; remain<=4'd7;
end 10'd9: begin
	x<=7'd0; remain<=4'd8;
end 10'd10: begin
	x<=7'd1; remain<=4'd0;
end 10'd11: begin
	x<=7'd1; remain<=4'd1;
end 10'd12: begin
	x<=7'd1; remain<=4'd2;
end 10'd13: begin
	x<=7'd1; remain<=4'd3;
end 10'd14: begin
	x<=7'd1; remain<=4'd4;
end 10'd15: begin
	x<=7'd1; remain<=4'd5;
end 10'd16: begin
	x<=7'd1; remain<=4'd6;
end 10'd17: begin
	x<=7'd1; remain<=4'd7;
end 10'd18: begin
	x<=7'd1; remain<=4'd8;
end 10'd19: begin
	x<=7'd2; remain<=4'd0;
end 10'd20: begin
	x<=7'd2; remain<=4'd1;
end 10'd21: begin
	x<=7'd2; remain<=4'd2;
end 10'd22: begin
	x<=7'd2; remain<=4'd3;
end 10'd23: begin
	x<=7'd2; remain<=4'd4;
end 10'd24: begin
	x<=7'd2; remain<=4'd5;
end 10'd25: begin
	x<=7'd2; remain<=4'd6;
end 10'd26: begin
	x<=7'd2; remain<=4'd7;
end 10'd27: begin
	x<=7'd2; remain<=4'd8;
end 10'd28: begin
	x<=7'd3; remain<=4'd0;
end 10'd29: begin
	x<=7'd3; remain<=4'd1;
end 10'd30: begin
	x<=7'd3; remain<=4'd2;
end 10'd31: begin
	x<=7'd3; remain<=4'd3;
end 10'd32: begin
	x<=7'd3; remain<=4'd4;
end 10'd33: begin
	x<=7'd3; remain<=4'd5;
end 10'd34: begin
	x<=7'd3; remain<=4'd6;
end 10'd35: begin
	x<=7'd3; remain<=4'd7;
end 10'd36: begin
	x<=7'd3; remain<=4'd8;
end 10'd37: begin
	x<=7'd4; remain<=4'd0;
end 10'd38: begin
	x<=7'd4; remain<=4'd1;
end 10'd39: begin
	x<=7'd4; remain<=4'd2;
end 10'd40: begin
	x<=7'd4; remain<=4'd3;
end 10'd41: begin
	x<=7'd4; remain<=4'd4;
end 10'd42: begin
	x<=7'd4; remain<=4'd5;
end 10'd43: begin
	x<=7'd4; remain<=4'd6;
end 10'd44: begin
	x<=7'd4; remain<=4'd7;
end 10'd45: begin
	x<=7'd4; remain<=4'd8;
end 10'd46: begin
	x<=7'd5; remain<=4'd0;
end 10'd47: begin
	x<=7'd5; remain<=4'd1;
end 10'd48: begin
	x<=7'd5; remain<=4'd2;
end 10'd49: begin
	x<=7'd5; remain<=4'd3;
end 10'd50: begin
	x<=7'd5; remain<=4'd4;
end 10'd51: begin
	x<=7'd5; remain<=4'd5;
end 10'd52: begin
	x<=7'd5; remain<=4'd6;
end 10'd53: begin
	x<=7'd5; remain<=4'd7;
end 10'd54: begin
	x<=7'd5; remain<=4'd8;
end 10'd55: begin
	x<=7'd6; remain<=4'd0;
end 10'd56: begin
	x<=7'd6; remain<=4'd1;
end 10'd57: begin
	x<=7'd6; remain<=4'd2;
end 10'd58: begin
	x<=7'd6; remain<=4'd3;
end 10'd59: begin
	x<=7'd6; remain<=4'd4;
end 10'd60: begin
	x<=7'd6; remain<=4'd5;
end 10'd61: begin
	x<=7'd6; remain<=4'd6;
end 10'd62: begin
	x<=7'd6; remain<=4'd7;
end 10'd63: begin
	x<=7'd6; remain<=4'd8;
end 10'd64: begin
	x<=7'd7; remain<=4'd0;
end 10'd65: begin
	x<=7'd7; remain<=4'd1;
end 10'd66: begin
	x<=7'd7; remain<=4'd2;
end 10'd67: begin
	x<=7'd7; remain<=4'd3;
end 10'd68: begin
	x<=7'd7; remain<=4'd4;
end 10'd69: begin
	x<=7'd7; remain<=4'd5;
end 10'd70: begin
	x<=7'd7; remain<=4'd6;
end 10'd71: begin
	x<=7'd7; remain<=4'd7;
end 10'd72: begin
	x<=7'd7; remain<=4'd8;
end 10'd73: begin
	x<=7'd8; remain<=4'd0;
end 10'd74: begin
	x<=7'd8; remain<=4'd1;
end 10'd75: begin
	x<=7'd8; remain<=4'd2;
end 10'd76: begin
	x<=7'd8; remain<=4'd3;
end 10'd77: begin
	x<=7'd8; remain<=4'd4;
end 10'd78: begin
	x<=7'd8; remain<=4'd5;
end 10'd79: begin
	x<=7'd8; remain<=4'd6;
end 10'd80: begin
	x<=7'd8; remain<=4'd7;
end 10'd81: begin
	x<=7'd8; remain<=4'd8;
end 10'd82: begin
	x<=7'd9; remain<=4'd0;
end 10'd83: begin
	x<=7'd9; remain<=4'd1;
end 10'd84: begin
	x<=7'd9; remain<=4'd2;
end 10'd85: begin
	x<=7'd9; remain<=4'd3;
end 10'd86: begin
	x<=7'd9; remain<=4'd4;
end 10'd87: begin
	x<=7'd9; remain<=4'd5;
end 10'd88: begin
	x<=7'd9; remain<=4'd6;
end 10'd89: begin
	x<=7'd9; remain<=4'd7;
end 10'd90: begin
	x<=7'd9; remain<=4'd8;
end 10'd91: begin
	x<=7'd10; remain<=4'd0;
end 10'd92: begin
	x<=7'd10; remain<=4'd1;
end 10'd93: begin
	x<=7'd10; remain<=4'd2;
end 10'd94: begin
	x<=7'd10; remain<=4'd3;
end 10'd95: begin
	x<=7'd10; remain<=4'd4;
end 10'd96: begin
	x<=7'd10; remain<=4'd5;
end 10'd97: begin
	x<=7'd10; remain<=4'd6;
end 10'd98: begin
	x<=7'd10; remain<=4'd7;
end 10'd99: begin
	x<=7'd10; remain<=4'd8;
end 10'd100: begin
	x<=7'd11; remain<=4'd0;
end 10'd101: begin
	x<=7'd11; remain<=4'd1;
end 10'd102: begin
	x<=7'd11; remain<=4'd2;
end 10'd103: begin
	x<=7'd11; remain<=4'd3;
end 10'd104: begin
	x<=7'd11; remain<=4'd4;
end 10'd105: begin
	x<=7'd11; remain<=4'd5;
end 10'd106: begin
	x<=7'd11; remain<=4'd6;
end 10'd107: begin
	x<=7'd11; remain<=4'd7;
end 10'd108: begin
	x<=7'd11; remain<=4'd8;
end 10'd109: begin
	x<=7'd12; remain<=4'd0;
end 10'd110: begin
	x<=7'd12; remain<=4'd1;
end 10'd111: begin
	x<=7'd12; remain<=4'd2;
end 10'd112: begin
	x<=7'd12; remain<=4'd3;
end 10'd113: begin
	x<=7'd12; remain<=4'd4;
end 10'd114: begin
	x<=7'd12; remain<=4'd5;
end 10'd115: begin
	x<=7'd12; remain<=4'd6;
end 10'd116: begin
	x<=7'd12; remain<=4'd7;
end 10'd117: begin
	x<=7'd12; remain<=4'd8;
end 10'd118: begin
	x<=7'd13; remain<=4'd0;
end 10'd119: begin
	x<=7'd13; remain<=4'd1;
end 10'd120: begin
	x<=7'd13; remain<=4'd2;
end 10'd121: begin
	x<=7'd13; remain<=4'd3;
end 10'd122: begin
	x<=7'd13; remain<=4'd4;
end 10'd123: begin
	x<=7'd13; remain<=4'd5;
end 10'd124: begin
	x<=7'd13; remain<=4'd6;
end 10'd125: begin
	x<=7'd13; remain<=4'd7;
end 10'd126: begin
	x<=7'd13; remain<=4'd8;
end 10'd127: begin
	x<=7'd14; remain<=4'd0;
end 10'd128: begin
	x<=7'd14; remain<=4'd1;
end 10'd129: begin
	x<=7'd14; remain<=4'd2;
end 10'd130: begin
	x<=7'd14; remain<=4'd3;
end 10'd131: begin
	x<=7'd14; remain<=4'd4;
end 10'd132: begin
	x<=7'd14; remain<=4'd5;
end 10'd133: begin
	x<=7'd14; remain<=4'd6;
end 10'd134: begin
	x<=7'd14; remain<=4'd7;
end 10'd135: begin
	x<=7'd14; remain<=4'd8;
end 10'd136: begin
	x<=7'd15; remain<=4'd0;
end 10'd137: begin
	x<=7'd15; remain<=4'd1;
end 10'd138: begin
	x<=7'd15; remain<=4'd2;
end 10'd139: begin
	x<=7'd15; remain<=4'd3;
end 10'd140: begin
	x<=7'd15; remain<=4'd4;
end 10'd141: begin
	x<=7'd15; remain<=4'd5;
end 10'd142: begin
	x<=7'd15; remain<=4'd6;
end 10'd143: begin
	x<=7'd15; remain<=4'd7;
end 10'd144: begin
	x<=7'd15; remain<=4'd8;
end 10'd145: begin
	x<=7'd16; remain<=4'd0;
end 10'd146: begin
	x<=7'd16; remain<=4'd1;
end 10'd147: begin
	x<=7'd16; remain<=4'd2;
end 10'd148: begin
	x<=7'd16; remain<=4'd3;
end 10'd149: begin
	x<=7'd16; remain<=4'd4;
end 10'd150: begin
	x<=7'd16; remain<=4'd5;
end 10'd151: begin
	x<=7'd16; remain<=4'd6;
end 10'd152: begin
	x<=7'd16; remain<=4'd7;
end 10'd153: begin
	x<=7'd16; remain<=4'd8;
end 10'd154: begin
	x<=7'd17; remain<=4'd0;
end 10'd155: begin
	x<=7'd17; remain<=4'd1;
end 10'd156: begin
	x<=7'd17; remain<=4'd2;
end 10'd157: begin
	x<=7'd17; remain<=4'd3;
end 10'd158: begin
	x<=7'd17; remain<=4'd4;
end 10'd159: begin
	x<=7'd17; remain<=4'd5;
end 10'd160: begin
	x<=7'd17; remain<=4'd6;
end 10'd161: begin
	x<=7'd17; remain<=4'd7;
end 10'd162: begin
	x<=7'd17; remain<=4'd8;
end 10'd163: begin
	x<=7'd18; remain<=4'd0;
end 10'd164: begin
	x<=7'd18; remain<=4'd1;
end 10'd165: begin
	x<=7'd18; remain<=4'd2;
end 10'd166: begin
	x<=7'd18; remain<=4'd3;
end 10'd167: begin
	x<=7'd18; remain<=4'd4;
end 10'd168: begin
	x<=7'd18; remain<=4'd5;
end 10'd169: begin
	x<=7'd18; remain<=4'd6;
end 10'd170: begin
	x<=7'd18; remain<=4'd7;
end 10'd171: begin
	x<=7'd18; remain<=4'd8;
end 10'd172: begin
	x<=7'd19; remain<=4'd0;
end 10'd173: begin
	x<=7'd19; remain<=4'd1;
end 10'd174: begin
	x<=7'd19; remain<=4'd2;
end 10'd175: begin
	x<=7'd19; remain<=4'd3;
end 10'd176: begin
	x<=7'd19; remain<=4'd4;
end 10'd177: begin
	x<=7'd19; remain<=4'd5;
end 10'd178: begin
	x<=7'd19; remain<=4'd6;
end 10'd179: begin
	x<=7'd19; remain<=4'd7;
end 10'd180: begin
	x<=7'd19; remain<=4'd8;
end 10'd181: begin
	x<=7'd20; remain<=4'd0;
end 10'd182: begin
	x<=7'd20; remain<=4'd1;
end 10'd183: begin
	x<=7'd20; remain<=4'd2;
end 10'd184: begin
	x<=7'd20; remain<=4'd3;
end 10'd185: begin
	x<=7'd20; remain<=4'd4;
end 10'd186: begin
	x<=7'd20; remain<=4'd5;
end 10'd187: begin
	x<=7'd20; remain<=4'd6;
end 10'd188: begin
	x<=7'd20; remain<=4'd7;
end 10'd189: begin
	x<=7'd20; remain<=4'd8;
end 10'd190: begin
	x<=7'd21; remain<=4'd0;
end 10'd191: begin
	x<=7'd21; remain<=4'd1;
end 10'd192: begin
	x<=7'd21; remain<=4'd2;
end 10'd193: begin
	x<=7'd21; remain<=4'd3;
end 10'd194: begin
	x<=7'd21; remain<=4'd4;
end 10'd195: begin
	x<=7'd21; remain<=4'd5;
end 10'd196: begin
	x<=7'd21; remain<=4'd6;
end 10'd197: begin
	x<=7'd21; remain<=4'd7;
end 10'd198: begin
	x<=7'd21; remain<=4'd8;
end 10'd199: begin
	x<=7'd22; remain<=4'd0;
end 10'd200: begin
	x<=7'd22; remain<=4'd1;
end 10'd201: begin
	x<=7'd22; remain<=4'd2;
end 10'd202: begin
	x<=7'd22; remain<=4'd3;
end 10'd203: begin
	x<=7'd22; remain<=4'd4;
end 10'd204: begin
	x<=7'd22; remain<=4'd5;
end 10'd205: begin
	x<=7'd22; remain<=4'd6;
end 10'd206: begin
	x<=7'd22; remain<=4'd7;
end 10'd207: begin
	x<=7'd22; remain<=4'd8;
end 10'd208: begin
	x<=7'd23; remain<=4'd0;
end 10'd209: begin
	x<=7'd23; remain<=4'd1;
end 10'd210: begin
	x<=7'd23; remain<=4'd2;
end 10'd211: begin
	x<=7'd23; remain<=4'd3;
end 10'd212: begin
	x<=7'd23; remain<=4'd4;
end 10'd213: begin
	x<=7'd23; remain<=4'd5;
end 10'd214: begin
	x<=7'd23; remain<=4'd6;
end 10'd215: begin
	x<=7'd23; remain<=4'd7;
end 10'd216: begin
	x<=7'd23; remain<=4'd8;
end 10'd217: begin
	x<=7'd24; remain<=4'd0;
end 10'd218: begin
	x<=7'd24; remain<=4'd1;
end 10'd219: begin
	x<=7'd24; remain<=4'd2;
end 10'd220: begin
	x<=7'd24; remain<=4'd3;
end 10'd221: begin
	x<=7'd24; remain<=4'd4;
end 10'd222: begin
	x<=7'd24; remain<=4'd5;
end 10'd223: begin
	x<=7'd24; remain<=4'd6;
end 10'd224: begin
	x<=7'd24; remain<=4'd7;
end 10'd225: begin
	x<=7'd24; remain<=4'd8;
end 10'd226: begin
	x<=7'd25; remain<=4'd0;
end 10'd227: begin
	x<=7'd25; remain<=4'd1;
end 10'd228: begin
	x<=7'd25; remain<=4'd2;
end 10'd229: begin
	x<=7'd25; remain<=4'd3;
end 10'd230: begin
	x<=7'd25; remain<=4'd4;
end 10'd231: begin
	x<=7'd25; remain<=4'd5;
end 10'd232: begin
	x<=7'd25; remain<=4'd6;
end 10'd233: begin
	x<=7'd25; remain<=4'd7;
end 10'd234: begin
	x<=7'd25; remain<=4'd8;
end 10'd235: begin
	x<=7'd26; remain<=4'd0;
end 10'd236: begin
	x<=7'd26; remain<=4'd1;
end 10'd237: begin
	x<=7'd26; remain<=4'd2;
end 10'd238: begin
	x<=7'd26; remain<=4'd3;
end 10'd239: begin
	x<=7'd26; remain<=4'd4;
end 10'd240: begin
	x<=7'd26; remain<=4'd5;
end 10'd241: begin
	x<=7'd26; remain<=4'd6;
end 10'd242: begin
	x<=7'd26; remain<=4'd7;
end 10'd243: begin
	x<=7'd26; remain<=4'd8;
end 10'd244: begin
	x<=7'd27; remain<=4'd0;
end 10'd245: begin
	x<=7'd27; remain<=4'd1;
end 10'd246: begin
	x<=7'd27; remain<=4'd2;
end 10'd247: begin
	x<=7'd27; remain<=4'd3;
end 10'd248: begin
	x<=7'd27; remain<=4'd4;
end 10'd249: begin
	x<=7'd27; remain<=4'd5;
end 10'd250: begin
	x<=7'd27; remain<=4'd6;
end 10'd251: begin
	x<=7'd27; remain<=4'd7;
end 10'd252: begin
	x<=7'd27; remain<=4'd8;
end 10'd253: begin
	x<=7'd28; remain<=4'd0;
end 10'd254: begin
	x<=7'd28; remain<=4'd1;
end 10'd255: begin
	x<=7'd28; remain<=4'd2;
end 10'd256: begin
	x<=7'd28; remain<=4'd3;
end 10'd257: begin
	x<=7'd28; remain<=4'd4;
end 10'd258: begin
	x<=7'd28; remain<=4'd5;
end 10'd259: begin
	x<=7'd28; remain<=4'd6;
end 10'd260: begin
	x<=7'd28; remain<=4'd7;
end 10'd261: begin
	x<=7'd28; remain<=4'd8;
end 10'd262: begin
	x<=7'd29; remain<=4'd0;
end 10'd263: begin
	x<=7'd29; remain<=4'd1;
end 10'd264: begin
	x<=7'd29; remain<=4'd2;
end 10'd265: begin
	x<=7'd29; remain<=4'd3;
end 10'd266: begin
	x<=7'd29; remain<=4'd4;
end 10'd267: begin
	x<=7'd29; remain<=4'd5;
end 10'd268: begin
	x<=7'd29; remain<=4'd6;
end 10'd269: begin
	x<=7'd29; remain<=4'd7;
end 10'd270: begin
	x<=7'd29; remain<=4'd8;
end 10'd271: begin
	x<=7'd30; remain<=4'd0;
end 10'd272: begin
	x<=7'd30; remain<=4'd1;
end 10'd273: begin
	x<=7'd30; remain<=4'd2;
end 10'd274: begin
	x<=7'd30; remain<=4'd3;
end 10'd275: begin
	x<=7'd30; remain<=4'd4;
end 10'd276: begin
	x<=7'd30; remain<=4'd5;
end 10'd277: begin
	x<=7'd30; remain<=4'd6;
end 10'd278: begin
	x<=7'd30; remain<=4'd7;
end 10'd279: begin
	x<=7'd30; remain<=4'd8;
end 10'd280: begin
	x<=7'd31; remain<=4'd0;
end 10'd281: begin
	x<=7'd31; remain<=4'd1;
end 10'd282: begin
	x<=7'd31; remain<=4'd2;
end 10'd283: begin
	x<=7'd31; remain<=4'd3;
end 10'd284: begin
	x<=7'd31; remain<=4'd4;
end 10'd285: begin
	x<=7'd31; remain<=4'd5;
end 10'd286: begin
	x<=7'd31; remain<=4'd6;
end 10'd287: begin
	x<=7'd31; remain<=4'd7;
end 10'd288: begin
	x<=7'd31; remain<=4'd8;
end 10'd289: begin
	x<=7'd32; remain<=4'd0;
end 10'd290: begin
	x<=7'd32; remain<=4'd1;
end 10'd291: begin
	x<=7'd32; remain<=4'd2;
end 10'd292: begin
	x<=7'd32; remain<=4'd3;
end 10'd293: begin
	x<=7'd32; remain<=4'd4;
end 10'd294: begin
	x<=7'd32; remain<=4'd5;
end 10'd295: begin
	x<=7'd32; remain<=4'd6;
end 10'd296: begin
	x<=7'd32; remain<=4'd7;
end 10'd297: begin
	x<=7'd32; remain<=4'd8;
end 10'd298: begin
	x<=7'd33; remain<=4'd0;
end 10'd299: begin
	x<=7'd33; remain<=4'd1;
end 10'd300: begin
	x<=7'd33; remain<=4'd2;
end 10'd301: begin
	x<=7'd33; remain<=4'd3;
end 10'd302: begin
	x<=7'd33; remain<=4'd4;
end 10'd303: begin
	x<=7'd33; remain<=4'd5;
end 10'd304: begin
	x<=7'd33; remain<=4'd6;
end 10'd305: begin
	x<=7'd33; remain<=4'd7;
end 10'd306: begin
	x<=7'd33; remain<=4'd8;
end 10'd307: begin
	x<=7'd34; remain<=4'd0;
end 10'd308: begin
	x<=7'd34; remain<=4'd1;
end 10'd309: begin
	x<=7'd34; remain<=4'd2;
end 10'd310: begin
	x<=7'd34; remain<=4'd3;
end 10'd311: begin
	x<=7'd34; remain<=4'd4;
end 10'd312: begin
	x<=7'd34; remain<=4'd5;
end 10'd313: begin
	x<=7'd34; remain<=4'd6;
end 10'd314: begin
	x<=7'd34; remain<=4'd7;
end 10'd315: begin
	x<=7'd34; remain<=4'd8;
end 10'd316: begin
	x<=7'd35; remain<=4'd0;
end 10'd317: begin
	x<=7'd35; remain<=4'd1;
end 10'd318: begin
	x<=7'd35; remain<=4'd2;
end 10'd319: begin
	x<=7'd35; remain<=4'd3;
end 10'd320: begin
	x<=7'd35; remain<=4'd4;
end 10'd321: begin
	x<=7'd35; remain<=4'd5;
end 10'd322: begin
	x<=7'd35; remain<=4'd6;
end 10'd323: begin
	x<=7'd35; remain<=4'd7;
end 10'd324: begin
	x<=7'd35; remain<=4'd8;
end 10'd325: begin
	x<=7'd36; remain<=4'd0;
end 10'd326: begin
	x<=7'd36; remain<=4'd1;
end 10'd327: begin
	x<=7'd36; remain<=4'd2;
end 10'd328: begin
	x<=7'd36; remain<=4'd3;
end 10'd329: begin
	x<=7'd36; remain<=4'd4;
end 10'd330: begin
	x<=7'd36; remain<=4'd5;
end 10'd331: begin
	x<=7'd36; remain<=4'd6;
end 10'd332: begin
	x<=7'd36; remain<=4'd7;
end 10'd333: begin
	x<=7'd36; remain<=4'd8;
end 10'd334: begin
	x<=7'd37; remain<=4'd0;
end 10'd335: begin
	x<=7'd37; remain<=4'd1;
end 10'd336: begin
	x<=7'd37; remain<=4'd2;
end 10'd337: begin
	x<=7'd37; remain<=4'd3;
end 10'd338: begin
	x<=7'd37; remain<=4'd4;
end 10'd339: begin
	x<=7'd37; remain<=4'd5;
end 10'd340: begin
	x<=7'd37; remain<=4'd6;
end 10'd341: begin
	x<=7'd37; remain<=4'd7;
end 10'd342: begin
	x<=7'd37; remain<=4'd8;
end 10'd343: begin
	x<=7'd38; remain<=4'd0;
end 10'd344: begin
	x<=7'd38; remain<=4'd1;
end 10'd345: begin
	x<=7'd38; remain<=4'd2;
end 10'd346: begin
	x<=7'd38; remain<=4'd3;
end 10'd347: begin
	x<=7'd38; remain<=4'd4;
end 10'd348: begin
	x<=7'd38; remain<=4'd5;
end 10'd349: begin
	x<=7'd38; remain<=4'd6;
end 10'd350: begin
	x<=7'd38; remain<=4'd7;
end 10'd351: begin
	x<=7'd38; remain<=4'd8;
end 10'd352: begin
	x<=7'd39; remain<=4'd0;
end 10'd353: begin
	x<=7'd39; remain<=4'd1;
end 10'd354: begin
	x<=7'd39; remain<=4'd2;
end 10'd355: begin
	x<=7'd39; remain<=4'd3;
end 10'd356: begin
	x<=7'd39; remain<=4'd4;
end 10'd357: begin
	x<=7'd39; remain<=4'd5;
end 10'd358: begin
	x<=7'd39; remain<=4'd6;
end 10'd359: begin
	x<=7'd39; remain<=4'd7;
end 10'd360: begin
	x<=7'd39; remain<=4'd8;
end 10'd361: begin
	x<=7'd40; remain<=4'd0;
end 10'd362: begin
	x<=7'd40; remain<=4'd1;
end 10'd363: begin
	x<=7'd40; remain<=4'd2;
end 10'd364: begin
	x<=7'd40; remain<=4'd3;
end 10'd365: begin
	x<=7'd40; remain<=4'd4;
end 10'd366: begin
	x<=7'd40; remain<=4'd5;
end 10'd367: begin
	x<=7'd40; remain<=4'd6;
end 10'd368: begin
	x<=7'd40; remain<=4'd7;
end 10'd369: begin
	x<=7'd40; remain<=4'd8;
end 10'd370: begin
	x<=7'd41; remain<=4'd0;
end 10'd371: begin
	x<=7'd41; remain<=4'd1;
end 10'd372: begin
	x<=7'd41; remain<=4'd2;
end 10'd373: begin
	x<=7'd41; remain<=4'd3;
end 10'd374: begin
	x<=7'd41; remain<=4'd4;
end 10'd375: begin
	x<=7'd41; remain<=4'd5;
end 10'd376: begin
	x<=7'd41; remain<=4'd6;
end 10'd377: begin
	x<=7'd41; remain<=4'd7;
end 10'd378: begin
	x<=7'd41; remain<=4'd8;
end 10'd379: begin
	x<=7'd42; remain<=4'd0;
end 10'd380: begin
	x<=7'd42; remain<=4'd1;
end 10'd381: begin
	x<=7'd42; remain<=4'd2;
end 10'd382: begin
	x<=7'd42; remain<=4'd3;
end 10'd383: begin
	x<=7'd42; remain<=4'd4;
end 10'd384: begin
	x<=7'd42; remain<=4'd5;
end 10'd385: begin
	x<=7'd42; remain<=4'd6;
end 10'd386: begin
	x<=7'd42; remain<=4'd7;
end 10'd387: begin
	x<=7'd42; remain<=4'd8;
end 10'd388: begin
	x<=7'd43; remain<=4'd0;
end 10'd389: begin
	x<=7'd43; remain<=4'd1;
end 10'd390: begin
	x<=7'd43; remain<=4'd2;
end 10'd391: begin
	x<=7'd43; remain<=4'd3;
end 10'd392: begin
	x<=7'd43; remain<=4'd4;
end 10'd393: begin
	x<=7'd43; remain<=4'd5;
end 10'd394: begin
	x<=7'd43; remain<=4'd6;
end 10'd395: begin
	x<=7'd43; remain<=4'd7;
end 10'd396: begin
	x<=7'd43; remain<=4'd8;
end 10'd397: begin
	x<=7'd44; remain<=4'd0;
end 10'd398: begin
	x<=7'd44; remain<=4'd1;
end 10'd399: begin
	x<=7'd44; remain<=4'd2;
end 10'd400: begin
	x<=7'd44; remain<=4'd3;
end 10'd401: begin
	x<=7'd44; remain<=4'd4;
end 10'd402: begin
	x<=7'd44; remain<=4'd5;
end 10'd403: begin
	x<=7'd44; remain<=4'd6;
end 10'd404: begin
	x<=7'd44; remain<=4'd7;
end 10'd405: begin
	x<=7'd44; remain<=4'd8;
end 10'd406: begin
	x<=7'd45; remain<=4'd0;
end 10'd407: begin
	x<=7'd45; remain<=4'd1;
end 10'd408: begin
	x<=7'd45; remain<=4'd2;
end 10'd409: begin
	x<=7'd45; remain<=4'd3;
end 10'd410: begin
	x<=7'd45; remain<=4'd4;
end 10'd411: begin
	x<=7'd45; remain<=4'd5;
end 10'd412: begin
	x<=7'd45; remain<=4'd6;
end 10'd413: begin
	x<=7'd45; remain<=4'd7;
end 10'd414: begin
	x<=7'd45; remain<=4'd8;
end 10'd415: begin
	x<=7'd46; remain<=4'd0;
end 10'd416: begin
	x<=7'd46; remain<=4'd1;
end 10'd417: begin
	x<=7'd46; remain<=4'd2;
end 10'd418: begin
	x<=7'd46; remain<=4'd3;
end 10'd419: begin
	x<=7'd46; remain<=4'd4;
end 10'd420: begin
	x<=7'd46; remain<=4'd5;
end 10'd421: begin
	x<=7'd46; remain<=4'd6;
end 10'd422: begin
	x<=7'd46; remain<=4'd7;
end 10'd423: begin
	x<=7'd46; remain<=4'd8;
end 10'd424: begin
	x<=7'd47; remain<=4'd0;
end 10'd425: begin
	x<=7'd47; remain<=4'd1;
end 10'd426: begin
	x<=7'd47; remain<=4'd2;
end 10'd427: begin
	x<=7'd47; remain<=4'd3;
end 10'd428: begin
	x<=7'd47; remain<=4'd4;
end 10'd429: begin
	x<=7'd47; remain<=4'd5;
end 10'd430: begin
	x<=7'd47; remain<=4'd6;
end 10'd431: begin
	x<=7'd47; remain<=4'd7;
end 10'd432: begin
	x<=7'd47; remain<=4'd8;
end 10'd433: begin
	x<=7'd48; remain<=4'd0;
end 10'd434: begin
	x<=7'd48; remain<=4'd1;
end 10'd435: begin
	x<=7'd48; remain<=4'd2;
end 10'd436: begin
	x<=7'd48; remain<=4'd3;
end 10'd437: begin
	x<=7'd48; remain<=4'd4;
end 10'd438: begin
	x<=7'd48; remain<=4'd5;
end 10'd439: begin
	x<=7'd48; remain<=4'd6;
end 10'd440: begin
	x<=7'd48; remain<=4'd7;
end 10'd441: begin
	x<=7'd48; remain<=4'd8;
end 10'd442: begin
	x<=7'd49; remain<=4'd0;
end 10'd443: begin
	x<=7'd49; remain<=4'd1;
end 10'd444: begin
	x<=7'd49; remain<=4'd2;
end 10'd445: begin
	x<=7'd49; remain<=4'd3;
end 10'd446: begin
	x<=7'd49; remain<=4'd4;
end 10'd447: begin
	x<=7'd49; remain<=4'd5;
end 10'd448: begin
	x<=7'd49; remain<=4'd6;
end 10'd449: begin
	x<=7'd49; remain<=4'd7;
end 10'd450: begin
	x<=7'd49; remain<=4'd8;
end 10'd451: begin
	x<=7'd50; remain<=4'd0;
end 10'd452: begin
	x<=7'd50; remain<=4'd1;
end 10'd453: begin
	x<=7'd50; remain<=4'd2;
end 10'd454: begin
	x<=7'd50; remain<=4'd3;
end 10'd455: begin
	x<=7'd50; remain<=4'd4;
end 10'd456: begin
	x<=7'd50; remain<=4'd5;
end 10'd457: begin
	x<=7'd50; remain<=4'd6;
end 10'd458: begin
	x<=7'd50; remain<=4'd7;
end 10'd459: begin
	x<=7'd50; remain<=4'd8;
end 10'd460: begin
	x<=7'd51; remain<=4'd0;
end 10'd461: begin
	x<=7'd51; remain<=4'd1;
end 10'd462: begin
	x<=7'd51; remain<=4'd2;
end 10'd463: begin
	x<=7'd51; remain<=4'd3;
end 10'd464: begin
	x<=7'd51; remain<=4'd4;
end 10'd465: begin
	x<=7'd51; remain<=4'd5;
end 10'd466: begin
	x<=7'd51; remain<=4'd6;
end 10'd467: begin
	x<=7'd51; remain<=4'd7;
end 10'd468: begin
	x<=7'd51; remain<=4'd8;
end 10'd469: begin
	x<=7'd52; remain<=4'd0;
end 10'd470: begin
	x<=7'd52; remain<=4'd1;
end 10'd471: begin
	x<=7'd52; remain<=4'd2;
end 10'd472: begin
	x<=7'd52; remain<=4'd3;
end 10'd473: begin
	x<=7'd52; remain<=4'd4;
end 10'd474: begin
	x<=7'd52; remain<=4'd5;
end 10'd475: begin
	x<=7'd52; remain<=4'd6;
end 10'd476: begin
	x<=7'd52; remain<=4'd7;
end 10'd477: begin
	x<=7'd52; remain<=4'd8;
end 10'd478: begin
	x<=7'd53; remain<=4'd0;
end 10'd479: begin
	x<=7'd53; remain<=4'd1;
end 10'd480: begin
	x<=7'd53; remain<=4'd2;
end 10'd481: begin
	x<=7'd53; remain<=4'd3;
end 10'd482: begin
	x<=7'd53; remain<=4'd4;
end 10'd483: begin
	x<=7'd53; remain<=4'd5;
end 10'd484: begin
	x<=7'd53; remain<=4'd6;
end 10'd485: begin
	x<=7'd53; remain<=4'd7;
end 10'd486: begin
	x<=7'd53; remain<=4'd8;
end 10'd487: begin
	x<=7'd54; remain<=4'd0;
end 10'd488: begin
	x<=7'd54; remain<=4'd1;
end 10'd489: begin
	x<=7'd54; remain<=4'd2;
end 10'd490: begin
	x<=7'd54; remain<=4'd3;
end 10'd491: begin
	x<=7'd54; remain<=4'd4;
end 10'd492: begin
	x<=7'd54; remain<=4'd5;
end 10'd493: begin
	x<=7'd54; remain<=4'd6;
end 10'd494: begin
	x<=7'd54; remain<=4'd7;
end 10'd495: begin
	x<=7'd54; remain<=4'd8;
end 10'd496: begin
	x<=7'd55; remain<=4'd0;
end 10'd497: begin
	x<=7'd55; remain<=4'd1;
end 10'd498: begin
	x<=7'd55; remain<=4'd2;
end 10'd499: begin
	x<=7'd55; remain<=4'd3;
end 10'd500: begin
	x<=7'd55; remain<=4'd4;
end 10'd501: begin
	x<=7'd55; remain<=4'd5;
end 10'd502: begin
	x<=7'd55; remain<=4'd6;
end 10'd503: begin
	x<=7'd55; remain<=4'd7;
end 10'd504: begin
	x<=7'd55; remain<=4'd8;
end 10'd505: begin
	x<=7'd56; remain<=4'd0;
end 10'd506: begin
	x<=7'd56; remain<=4'd1;
end 10'd507: begin
	x<=7'd56; remain<=4'd2;
end 10'd508: begin
	x<=7'd56; remain<=4'd3;
end 10'd509: begin
	x<=7'd56; remain<=4'd4;
end 10'd510: begin
	x<=7'd56; remain<=4'd5;
end 10'd511: begin
	x<=7'd56; remain<=4'd6;
end 10'd512: begin
	x<=7'd56; remain<=4'd7;
end 10'd513: begin
	x<=7'd56; remain<=4'd8;
end 10'd514: begin
	x<=7'd57; remain<=4'd0;
end 10'd515: begin
	x<=7'd57; remain<=4'd1;
end 10'd516: begin
	x<=7'd57; remain<=4'd2;
end 10'd517: begin
	x<=7'd57; remain<=4'd3;
end 10'd518: begin
	x<=7'd57; remain<=4'd4;
end 10'd519: begin
	x<=7'd57; remain<=4'd5;
end 10'd520: begin
	x<=7'd57; remain<=4'd6;
end 10'd521: begin
	x<=7'd57; remain<=4'd7;
end 10'd522: begin
	x<=7'd57; remain<=4'd8;
end 10'd523: begin
	x<=7'd58; remain<=4'd0;
end 10'd524: begin
	x<=7'd58; remain<=4'd1;
end 10'd525: begin
	x<=7'd58; remain<=4'd2;
end 10'd526: begin
	x<=7'd58; remain<=4'd3;
end 10'd527: begin
	x<=7'd58; remain<=4'd4;
end 10'd528: begin
	x<=7'd58; remain<=4'd5;
end 10'd529: begin
	x<=7'd58; remain<=4'd6;
end 10'd530: begin
	x<=7'd58; remain<=4'd7;
end 10'd531: begin
	x<=7'd58; remain<=4'd8;
end 10'd532: begin
	x<=7'd59; remain<=4'd0;
end 10'd533: begin
	x<=7'd59; remain<=4'd1;
end 10'd534: begin
	x<=7'd59; remain<=4'd2;
end 10'd535: begin
	x<=7'd59; remain<=4'd3;
end 10'd536: begin
	x<=7'd59; remain<=4'd4;
end 10'd537: begin
	x<=7'd59; remain<=4'd5;
end 10'd538: begin
	x<=7'd59; remain<=4'd6;
end 10'd539: begin
	x<=7'd59; remain<=4'd7;
end 10'd540: begin
	x<=7'd59; remain<=4'd8;
end 10'd541: begin
	x<=7'd60; remain<=4'd0;
end 10'd542: begin
	x<=7'd60; remain<=4'd1;
end 10'd543: begin
	x<=7'd60; remain<=4'd2;
end 10'd544: begin
	x<=7'd60; remain<=4'd3;
end 10'd545: begin
	x<=7'd60; remain<=4'd4;
end 10'd546: begin
	x<=7'd60; remain<=4'd5;
end 10'd547: begin
	x<=7'd60; remain<=4'd6;
end 10'd548: begin
	x<=7'd60; remain<=4'd7;
end 10'd549: begin
	x<=7'd60; remain<=4'd8;
end 10'd550: begin
	x<=7'd61; remain<=4'd0;
end 10'd551: begin
	x<=7'd61; remain<=4'd1;
end 10'd552: begin
	x<=7'd61; remain<=4'd2;
end 10'd553: begin
	x<=7'd61; remain<=4'd3;
end 10'd554: begin
	x<=7'd61; remain<=4'd4;
end 10'd555: begin
	x<=7'd61; remain<=4'd5;
end 10'd556: begin
	x<=7'd61; remain<=4'd6;
end 10'd557: begin
	x<=7'd61; remain<=4'd7;
end 10'd558: begin
	x<=7'd61; remain<=4'd8;
end 10'd559: begin
	x<=7'd62; remain<=4'd0;
end 10'd560: begin
	x<=7'd62; remain<=4'd1;
end 10'd561: begin
	x<=7'd62; remain<=4'd2;
end 10'd562: begin
	x<=7'd62; remain<=4'd3;
end 10'd563: begin
	x<=7'd62; remain<=4'd4;
end 10'd564: begin
	x<=7'd62; remain<=4'd5;
end 10'd565: begin
	x<=7'd62; remain<=4'd6;
end 10'd566: begin
	x<=7'd62; remain<=4'd7;
end 10'd567: begin
	x<=7'd62; remain<=4'd8;
end 10'd568: begin
	x<=7'd63; remain<=4'd0;
end 10'd569: begin
	x<=7'd63; remain<=4'd1;
end 10'd570: begin
	x<=7'd63; remain<=4'd2;
end 10'd571: begin
	x<=7'd63; remain<=4'd3;
end 10'd572: begin
	x<=7'd63; remain<=4'd4;
end 10'd573: begin
	x<=7'd63; remain<=4'd5;
end 10'd574: begin
	x<=7'd63; remain<=4'd6;
end 10'd575: begin
	x<=7'd63; remain<=4'd7;
end 10'd576: begin
	x<=7'd63; remain<=4'd8;
end 10'd577: begin
	x<=7'd64; remain<=4'd0;
end 10'd578: begin
	x<=7'd64; remain<=4'd1;
end 10'd579: begin
	x<=7'd64; remain<=4'd2;
end 10'd580: begin
	x<=7'd64; remain<=4'd3;
end 10'd581: begin
	x<=7'd64; remain<=4'd4;
end 10'd582: begin
	x<=7'd64; remain<=4'd5;
end 10'd583: begin
	x<=7'd64; remain<=4'd6;
end 10'd584: begin
	x<=7'd64; remain<=4'd7;
end 10'd585: begin
	x<=7'd64; remain<=4'd8;
end 10'd586: begin
	x<=7'd65; remain<=4'd0;
end 10'd587: begin
	x<=7'd65; remain<=4'd1;
end 10'd588: begin
	x<=7'd65; remain<=4'd2;
end 10'd589: begin
	x<=7'd65; remain<=4'd3;
end 10'd590: begin
	x<=7'd65; remain<=4'd4;
end 10'd591: begin
	x<=7'd65; remain<=4'd5;
end 10'd592: begin
	x<=7'd65; remain<=4'd6;
end 10'd593: begin
	x<=7'd65; remain<=4'd7;
end 10'd594: begin
	x<=7'd65; remain<=4'd8;
end 10'd595: begin
	x<=7'd66; remain<=4'd0;
end 10'd596: begin
	x<=7'd66; remain<=4'd1;
end 10'd597: begin
	x<=7'd66; remain<=4'd2;
end 10'd598: begin
	x<=7'd66; remain<=4'd3;
end 10'd599: begin
	x<=7'd66; remain<=4'd4;
end 10'd600: begin
	x<=7'd66; remain<=4'd5;
end 10'd601: begin
	x<=7'd66; remain<=4'd6;
end 10'd602: begin
	x<=7'd66; remain<=4'd7;
end 10'd603: begin
	x<=7'd66; remain<=4'd8;
end 10'd604: begin
	x<=7'd67; remain<=4'd0;
end 10'd605: begin
	x<=7'd67; remain<=4'd1;
end 10'd606: begin
	x<=7'd67; remain<=4'd2;
end 10'd607: begin
	x<=7'd67; remain<=4'd3;
end 10'd608: begin
	x<=7'd67; remain<=4'd4;
end 10'd609: begin
	x<=7'd67; remain<=4'd5;
end 10'd610: begin
	x<=7'd67; remain<=4'd6;
end 10'd611: begin
	x<=7'd67; remain<=4'd7;
end 10'd612: begin
	x<=7'd67; remain<=4'd8;
end 10'd613: begin
	x<=7'd68; remain<=4'd0;
end 10'd614: begin
	x<=7'd68; remain<=4'd1;
end 10'd615: begin
	x<=7'd68; remain<=4'd2;
end 10'd616: begin
	x<=7'd68; remain<=4'd3;
end 10'd617: begin
	x<=7'd68; remain<=4'd4;
end 10'd618: begin
	x<=7'd68; remain<=4'd5;
end 10'd619: begin
	x<=7'd68; remain<=4'd6;
end 10'd620: begin
	x<=7'd68; remain<=4'd7;
end 10'd621: begin
	x<=7'd68; remain<=4'd8;
end 10'd622: begin
	x<=7'd69; remain<=4'd0;
end 10'd623: begin
	x<=7'd69; remain<=4'd1;
end 10'd624: begin
	x<=7'd69; remain<=4'd2;
end 10'd625: begin
	x<=7'd69; remain<=4'd3;
end 10'd626: begin
	x<=7'd69; remain<=4'd4;
end 10'd627: begin
	x<=7'd69; remain<=4'd5;
end 10'd628: begin
	x<=7'd69; remain<=4'd6;
end 10'd629: begin
	x<=7'd69; remain<=4'd7;
end 10'd630: begin
	x<=7'd69; remain<=4'd8;
end default: begin x<=7'd0; remain<=4'd0; end
endcase
end

endmodule