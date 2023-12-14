module TimeCounter(
	input wire clk,
	input wire reset,//复位信号低电平有效
	//输入状态，对特定状态计时
	input wire [2:0] state_in,
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
//定义状态,格雷码编码,每次只改变一位
parameter st0_idle = 	3'b000;//空闲态
parameter st1_supply =  3'b001;//供水态
parameter st2_wash =    3'b011;//漂洗态
parameter st3_water =   3'b010;//放水态
parameter st4_dewater = 3'b110;//脱水态
parameter st5_alarm =   3'b100;//报警态

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
	if(!reset) begin //复位信号低电平有效
		ctseg3 <= 4'b0000;
		ctseg2 <= 4'b0000;
		ctseg1 <= 4'b0000;
		ctseg0 <= 4'b0000;
		washsig <= 1'b0;
		watersig <= 1'b0;
		dewatersig <= 1'b0;
		alarmsig <= 1'b0;	
	end else begin
			case (state_in)
				st0_idle: begin //空闲态
				//不计时
					ctseg3 <= 4'b0000;
					ctseg2 <= 4'b0000;
					ctseg1 <= 4'b0000;
					ctseg0 <= 4'b0000;
				//信号清零
					washsig 		<= 1'b0;
					watersig 	<= 1'b0;
					dewatersig 	<= 1'b0;
					alarmsig 	<= 1'b0;	
				end
				st1_supply: begin //供水态
				//不计时
					ctseg3 <= 4'b0000;
					ctseg2 <= 4'b0000;
					ctseg1 <= 4'b0000;
					ctseg0 <= 4'b0000;
				//信号清零
					washsig 		<= 1'b0;
					watersig 	<= 1'b0;
					dewatersig 	<= 1'b0;
					alarmsig 	<= 1'b0;	
				end
				st2_wash: begin //漂洗态
				//计时10min
				if(ctseg0<4'b1001)
				begin
					ctseg0 <= ctseg0 + 1'b1;
				end 
				else begin
					ctseg0 <= 4'b0000;
						if(ctseg1<4'b1001)
						begin ctseg1 <= ctseg1 + 1'b1; end 
						else begin
						ctseg1 <= 4'b0000;
							if(ctseg2<4'b0101)
							begin ctseg2 <= ctseg2 + 1'b1; end
							else begin
							ctseg2 <= 4'b0000;
								if(ctseg3<4'b1001)
								begin ctseg3 <= ctseg3 + 1'b1; end 
								else begin ctseg3 <= 4'b0000;
								//漂洗时间到的信号  
								washsig 		<= 1'b1;
								watersig 	<= 1'b0;
								dewatersig 	<= 1'b0;
								alarmsig 	<= 1'b0;	
													end
											end				
								end				
					  end
				end
				st3_water: begin //放水态
				//计时30s
				if(ctseg0<4'b1001)
				begin
					ctseg0 <= ctseg0 + 1'b1;
				end 
				else begin
					ctseg0 <= 4'b0000;
						if(ctseg1<4'b1001)
						begin ctseg1 <= ctseg1 + 1'b1; end 
						else begin
						ctseg1 <= 4'b0000;
							if(ctseg2<4'b0010)
							begin ctseg2 <= ctseg2 + 1'b1; end
							else begin
							ctseg2 <= 4'b0000;
									//放水时间到的信号 
									washsig		<= 1'b0;
									watersig 	<= 1'b1;
									dewatersig 	<= 1'b0;
									alarmsig 	<= 1'b0;	
												 end				
								  end				
					  end

				end
				st4_dewater: begin //脱水态
				//计时5min
				if(ctseg0<4'b1001)
				begin
					ctseg0 <= ctseg0 + 1'b1;
				end 
				else begin
					ctseg0 <= 4'b0000;
						if(ctseg1<4'b1001)
						begin ctseg1 <= ctseg1 + 1'b1; end 
						else begin
						ctseg1 <= 4'b0000;
								if(ctseg2<4'b0101)
								begin ctseg2 <= ctseg2 + 1'b1; end
								else begin
								ctseg2 <= 4'b0000;
										if(ctseg3<4'b0100)
										begin ctseg3 <= ctseg3 + 1'b1; end 
										else begin ctseg3 <= 4'b0000;
													//脱水信号
												washsig 		<= 1'b0;
												watersig 	<= 1'b0;
												dewatersig 	<= 1'b1;
												alarmsig 	<= 1'b0;	
											end
									end				
							 end				
					  end
	
				end
				st5_alarm: begin //报警态
				//计时10s
				if(ctseg0<4'b1001)
				begin
					ctseg0 <= ctseg0 + 1'b1;
				end 
				else begin
					ctseg0 <= 4'b0000;
						if(ctseg1<4'b1001)
						begin ctseg1 <= ctseg1 + 1'b1; end 
							else begin
								ctseg1 <= 4'b0000;
								//报警信号
								washsig 		<= 1'b0;
								watersig 	<= 1'b0;
								dewatersig 	<= 1'b0;
								alarmsig 	<= 1'b1;	
							 end				
					  end				
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
