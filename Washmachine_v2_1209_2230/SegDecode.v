module SegDecode(
	//指定的四个数码管之一输出0-9或0-5之间的数
	input wire [3:0] seg,
	//数码管段选
	output reg [6:0] segment  
);
//马上执行显示
always @(*)begin
	case(seg)
		4'b0000: segment = 7'b0000001;//0
		4'b0001: segment = 7'b1001111;//1
		4'b0010: segment = 7'b0010010;//2
		4'b0011: segment = 7'b0000110;//3
		4'b0100: segment = 7'b1001100;//4
		4'b0101: segment = 7'b0100100;//5
		4'b0110: segment = 7'b0100000;//6
		4'b0111: segment = 7'b0001111;//7
		4'b1000: segment = 7'b0000000;//8
		4'b1001: segment = 7'b0000100;//9
		default: segment = 7'b1111111;//全暗
	endcase

end

endmodule
