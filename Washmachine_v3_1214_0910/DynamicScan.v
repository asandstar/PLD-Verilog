module DynamicScan(
	input wire clk,
	input wire [3:0] seg3,
	input wire [3:0] seg2,
	input wire [3:0] seg1,
	input wire [3:0] seg0,
   //output [3:0] seg,
	output wire [6:0] segment,
	output [3:0] enable//使能,控制指定数码管（四个之一）点亮
);
reg [3:0] enable_temp = 4'b1111;
reg [3:0] seg_temp;
reg [1:0] count = 2'b00;
reg [6:0] segment_temp;


always @(posedge clk)begin
	if(count == 2'b00)begin
		enable_temp <= 4'b0111;//使能信号低电平有效，从左到右是高到低，3-0
		seg_temp <= seg3;
		count <= count + 2'b1;
	end else if (count == 2'b01) begin
		enable_temp <= 4'b1011;
		seg_temp <= seg2;
		count <= count + 2'b1;
	end else if (count == 2'b10) begin
		enable_temp <= 4'b1101;
		seg_temp <= seg1;
		count <= count + 2'b1;
	end else if (count == 2'b11) begin
		enable_temp <= 4'b1110;
		seg_temp <= seg0;
		count <= count + 2'b1;
	end
end

always @(*)begin
	case(seg_temp)
		4'b0000: segment_temp = 7'b0000001;//0
		4'b0001: segment_temp = 7'b1001111;//1
		4'b0010: segment_temp = 7'b0010010;//2
		4'b0011: segment_temp = 7'b0000110;//3
		4'b0100: segment_temp = 7'b1001100;//4
		4'b0101: segment_temp = 7'b0100100;//5
		4'b0110: segment_temp = 7'b0100000;//6
		4'b0111: segment_temp = 7'b0001111;//7
		4'b1000: segment_temp = 7'b0000000;//8
		4'b1001: segment_temp = 7'b0000100;//9
		default: segment_temp = 7'b1111111;//全暗
	endcase

end
assign enable = enable_temp;
assign segment = segment_temp;
//assign seg = seg_temp;
endmodule
