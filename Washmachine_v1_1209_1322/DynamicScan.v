module DynamicScan(
	input wire clk,
	input wire [3:0] seg3,
	input wire [3:0] seg2,
	input wire [3:0] seg1,
	input wire [3:0] seg0,
	output reg [3:0] seg,
	output reg [3:0] enable//使能,控制指定数码管（四个之一）点亮
);

reg [1:0] count = 2'b00;
reg [3:0] en;

always @(posedge clk)begin
	if(count == 2'b00)begin
		en <= 4'b0111;//使能信号低电平有效，从左到右是高到低，3-0
		seg <= seg3;
		count <= count + 1;
	end else if (count == 2'b01) begin
		en <= 4'b1011;
		seg <= seg2;
		count <= count + 1;
	end else if (count == 2'b10) begin
		en <= 4'b1101;
		seg <= seg1;
		count <= count + 1;
	end else if (count == 2'b11) begin
		en <= 4'b1110;
		seg <= seg0;
		count <= count + 1;
	end
		enable <= en;
end

endmodule


