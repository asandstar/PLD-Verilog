module TimeCounter(
	input wire clk,
	input wire reset,//复位信号低电平有效
	input wire [2:0] state_display,
	//输入状态从而对特定状态计时，并输出相应计时结束信号
	//下面的信号为高电平有效
	output wire wash, //漂洗时间
	output wire water,//放水时间
	output wire dewater,//脱水时间
	output wire alarm,//报警时间
	//四位数码管当前输出，从3到0是高位到低位
	output wire [3:0] seg3,
	output wire [3:0] seg2,
	output wire [3:0] seg1,
	output wire [3:0] seg0
);
//定义状态
parameter ST0 = 3'b001;//空闲态
parameter ST1 = 3'b011;//供水态
parameter ST2 = 3'b111;//漂洗态
parameter ST3 = 3'b110;//放水态
parameter ST4 = 3'b100;//脱水态
parameter ST5 = 3'b000;//报警态

//四位计数，从3到0分别是分钟、10秒、秒、0.1秒，赋初值
//10，6，10，10（从高到低对应进制）
//2^4=16满足要记10和6的位数
reg [3:0] ctseg3 = 4'b0000;
reg [3:0] ctseg2 = 4'b0000;
reg [3:0] ctseg1 = 4'b0000;
reg [3:0] ctseg0 = 4'b0000;

//高电平时间到信号，赋初值
reg washsig = 1'b0;//漂洗时间到信号
reg watersig = 1'b0;//防水时间到信号
reg dewatersig = 1'b0;//脱水时间到信号
reg alarmsig = 1'b0;//报警时间到信号

always @(posedge clk or negedge reset) begin
	if(reset == 1'b0) begin //复位信号低电平有效
		ctseg3 <= 4'b0000;
		ctseg2 <= 4'b0000;
		ctseg1 <= 4'b0000;
		ctseg0 <= 4'b0000;
	end else begin
			case (state_display)
				ST0: begin //空闲态
				//不计时
					ctseg3 <= 4'b0000;
					ctseg2 <= 4'b0000;
					ctseg1 <= 4'b0000;
					ctseg0 <= 4'b0000;
				//信号清零
					washsig <= 1'b0;
					watersig <= 1'b0;
					dewatersig <= 1'b0;
					alarmsig <= 1'b0;	
				end
				ST1: begin //供水态
				//不计时
					ctseg3 <= 4'b0000;
					ctseg2 <= 4'b0000;
					ctseg1 <= 4'b0000;
					ctseg0 <= 4'b0000;
				//信号清零
					washsig <= 1'b0;
					watersig <= 1'b0;
					dewatersig <= 1'b0;
					alarmsig <= 1'b0;	
				end
				ST2: begin //漂洗态
				//计时10min
//				
//					if(ctseg0<1'd9)begin
//					ctseg0 <= ctseg0 + 1'b1;
//					end else if (ctseg0==1'd9) begin
//					ctseg0 <= 4'b0000;
//					end
//					
//				if(ctseg1<1'd2)begin
//					ctseg1 <= ctseg1 + 1'b1;
//					end else if (ctseg1==1'd2) begin
//					ctseg1 <= 4'b0000;
//					end
				if(ctseg0<1'd9)begin
					ctseg0 <= ctseg0 + 1'b1;
					end else if (ctseg0==1'd9) begin
					ctseg0 <= 4'b0000;
					end
					
				if(ctseg1<1'd9)begin
					ctseg1 <= ctseg1 + 1'b1;
					end else if (ctseg1==1'd9) begin
					ctseg1 <= 4'b0000;
					end
					
				if(ctseg2<1'd5)begin
					ctseg2 <= ctseg2 + 1'b1;
					end else if (ctseg2==1'd5) begin
					ctseg2 <= 4'b0000;
					end
					
				if(ctseg3<1'd9)begin
					ctseg3 <= ctseg3 + 1'b1;
					end else if (ctseg3==1'd9) begin
					ctseg3 <= 4'b0000;
					end

				//漂洗信号
					washsig <= 1'b1;
					watersig <= 1'b0;
					dewatersig <= 1'b0;
					alarmsig <= 1'b0;	
				end
				ST3: begin //放水态
				//计时30s
//				if(ctseg0<1'd9)begin
//					ctseg0 <= ctseg0 + 1'b1;
//					end else if (ctseg0==1'd9) begin
//					ctseg0 <= 4'b0000;
//					end
//					
//				if(ctseg1<1'd3)begin
//					ctseg1 <= ctseg1 + 1'b1;
//					end else if (ctseg1==1'd3) begin
//					ctseg1 <= 4'b0000;
//					end

					
					if(ctseg0<1'd9)begin
					ctseg0 <= ctseg0 + 1'b1;
					end else if (ctseg0==1'd9) begin
					ctseg0 <= 4'b0000;
					end
					
				if(ctseg1<1'd9)begin
					ctseg1 <= ctseg1 + 1'b1;
					end else if (ctseg1==1'd9) begin
					ctseg1 <= 4'b0000;
					end
					
				if(ctseg2<1'd2)begin
					ctseg2 <= ctseg2 + 1'b1;
					end else if (ctseg2==1'd2) begin
					ctseg2 <= 4'b0000;
					end		
				//放水信号
					washsig <= 1'b0;
					watersig <= 1'b1;
					dewatersig <= 1'b0;
					alarmsig <= 1'b0;	
				end
				ST4: begin //脱水态
				//计时5min
				
//				if(ctseg0<1'd9)begin
//					ctseg0 <= ctseg0 + 1'b1;
//					end else if (ctseg0==1'd9) begin
//					ctseg0 <= 4'b0000;
//					end
//					
//				if(ctseg1<1'd4)begin
//					ctseg1 <= ctseg1 + 1'b1;
//					end else if (ctseg1==1'd4) begin
//					ctseg1 <= 4'b0000;
//					end

				if(ctseg0<1'd9)begin
					ctseg0 <= ctseg0 + 1'b1;
					end else if (ctseg0==1'd9) begin
					ctseg0 <= 4'b0000;
					end
					
				if(ctseg1<1'd9)begin
					ctseg1 <= ctseg1 + 1'b1;
					end else if (ctseg1==1'd9) begin
					ctseg1 <= 4'b0000;
					end
					
				if(ctseg2<1'd5)begin
					ctseg2 <= ctseg2 + 1'b1;
					end else if (ctseg2==1'd5) begin
					ctseg2 <= 4'b0000;
					end
					
				if(ctseg3<1'd4)begin
					ctseg3 <= ctseg3 + 1'b1;
					end else if (ctseg3==1'd4) begin
					ctseg3 <= 4'b0000;
					end
				//脱水信号
					washsig <= 1'b0;
					watersig <= 1'b0;
					dewatersig <= 1'b1;
					alarmsig <= 1'b0;	
				end
				ST5: begin //报警态
				//计时10s
				if(ctseg0<1'd9)begin
					ctseg0 <= ctseg0 + 1'b1;
					end else if (ctseg0==1'd9) begin
					ctseg0 <= 4'b0000;
					end
					
				if(ctseg1<1'd9)begin
					ctseg1 <= ctseg1 + 1'b1;
					end else if (ctseg1==1'd9) begin
					ctseg1 <= 4'b0000;
					end

				//报警信号
					washsig <= 1'b0;
					watersig <= 1'b0;
					dewatersig <= 1'b0;
					alarmsig <= 1'b1;	
				end
				default:begin

				end
			endcase
		end
		
	end
	
	assign seg3 = ctseg3;
	assign seg2 = ctseg2;
	assign seg1 = ctseg1;
	assign seg0 = ctseg0;
	
	assign wash = washsig;
	assign water = watersig;
	assign dewater = dewatersig;
	assign alarm = alarmsig;
	
endmodule
		