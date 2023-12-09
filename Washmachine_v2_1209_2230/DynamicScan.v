module DynamicScan(
	input wire clk,
	input wire [3:0] seg3,
	input wire [3:0] seg2,
	input wire [3:0] seg1,
	input wire [3:0] seg0,
   output reg [3:0] seg,
//	output reg [6:0] segment,
	output [3:0] enable//使能,控制指定数码管（四个之一）点亮
);
reg [3:0] en;

initial begin
	en = 4'b1110;
end

always @(posedge clk)begin
	case (en)
		4'b0111:begin
		seg <= seg3;
		en <= 4'b1110;
		end
		4'b1011:begin 
		seg <= seg2;
		en <= 4'b0111;
		end 
		4'b1101:begin 
		seg <= seg1;
		en <= 4'b1011;
		end
		4'b1110:	begin 
		seg <= seg0;
		en <= 4'b1101;
		end
	endcase
end
//马上传递需要点亮的数码管值
assign enable = en;

endmodule


//reg [1:0] count = 2'b00;


//reg [3:0] en = 4'b1110;
//reg [3:0] seg = 4'b0000;

//always @(posedge clk)begin
//	case(en)
//	4'b0111:begin seg <= seg3; en <= 4'b1011; end 
//	4'b1011:begin seg <= seg2; en <= 4'b1101; end
//	4'b1101:begin seg <= seg1; en <= 4'b1011; end
//	4'b1110:begin seg <= seg0; en <= 4'b0111; end
//	endcase
//
//end

//always @(posedge clk)begin
//	case(seg)
//		4'b0000: segment <= 7'b0000001;//0
//		4'b0001: segment <= 7'b1001111;//1
//		4'b0010: segment <= 7'b0010010;//2
//		4'b0011: segment <= 7'b0000110;//3
//		4'b0100: segment <= 7'b1001100;//4
//		4'b0101: segment <= 7'b0100100;//5
//		4'b0110: segment <= 7'b0100000;//6
//		4'b0111: segment <= 7'b0001111;//7
//		4'b1000: segment <= 7'b0000000;//8
//		4'b1001: segment <= 7'b0000100;//9
//		default: segment <= 7'b1111111;//全暗
//	endcase
//end
//
//assign enable = en;



//always @(posedge clk)begin
//	if(count == 2'b00)begin
//		enable <= 4'b0111;//使能信号低电平有效，从左到右是高到低，3-0
//		seg <= seg3;
//		count <= count + 1'b1;
//	end else if (count == 2'b01) begin
//		enable <= 4'b1011;
//		seg <= seg2;
//		count <= count + 1'b1;
//	end else if (count == 2'b10) begin
//		enable <= 4'b1101;
//		seg <= seg1;
//		count <= count + 1'b1;
//	end else if (count == 2'b11) begin
//		enable <= 4'b1110;
//		seg <= seg0;
//		count <= count + 1'b1;
//	end
//	//enable <= en;
//end



