module WashmachineControl(
	input wire clk,//系统时钟
	input wire reset,//系统复位
	//拨盘开关控制，低电平有效
	input wire start,//启动
	input wire waterfull,//水满
	input wire stop,//停止
	//时间到，高电平有效
	input wire wash,//漂洗
	input wire water,//放水
	input wire dewater,//脱水
	input wire alarm,//报警
	output [2:0] state_out,//状态送出
	output reg [5:0] state_led//显示状态
	
);
//定义状态,格雷码编码,每次只改变一位
parameter st0_idle = 	3'b000;//空闲态
parameter st1_supply =  3'b001;//供水态
parameter st2_wash =    3'b011;//漂洗态
parameter st3_water =   3'b010;//放水态
parameter st4_dewater = 3'b110;//脱水态
parameter st5_alarm =   3'b100;//报警态

//状态显示灯这里，需要按下按键后下一个上升沿才发生改变


//定义状态寄存器并赋初值
reg [2:0] state = st0_idle;
//always语句块
always @(posedge clk or negedge reset)begin
		if(!reset) begin
			state <= st0_idle;
			state_led <= 6'b111110;
		end else begin
		case(state)
			st0_idle: begin //空闲态
				state <= st0_idle;
				state_led <= 6'b111110;
				//state_led <= st0_idle;
				if(start == 1'b0) begin //启动低电平有效，转移到下一个状态
					state <= st1_supply;
				end 
//				else begin
//					state <= st0_idle;//其他情况，保持状态
//				end
			end
			st1_supply: begin //供水态
				state <= st1_supply;
				state_led <= 6'b111101;
				//state_led <= st1_supply;
				if(stop == 1'b0) begin //水满低电平有效，转移到下一个状态
					state <= st0_idle;
				end else if (waterfull == 1'b0) begin//停止低电平有效，回到空闲
					state <= st2_wash;
				end 
//				else begin
//					state <= st1_supply;	//其他情况，保持状态
//				end
			end
			st2_wash: begin //漂洗态
				state <= st2_wash;
				state_led <= 6'b111011;
				//state_led <= st2_wash;
				if(stop == 1'b0) begin //漂洗高电平有效，转移到下一个状态
					state <= st0_idle;
				end else if (wash == 1'b1) begin//停止低电平有效，回到空闲
					state <= st3_water;
				end 
//				else begin
//					state <= st2_wash; //其他情况，保持状态
//				end
			end
			st3_water: begin //放水态
				state <= st3_water;
				state_led <= 6'b110111;
				//state_led <= st3_water;
				if(stop == 1'b0) begin //放水高电平有效，转移到下一个状态
					state <= st0_idle;
				end else if (water == 1'b1) begin//停止低电平有效，回到空闲
					state <= st4_dewater;
				end 
//				else begin
//					state <= st3_water; //其他情况，保持状态
//				end
			end
			st4_dewater: begin //脱水态
				state <= st4_dewater;
				state_led <= 6'b101111;
				//state_led <= st4_dewater;
				if(stop == 1'b0) begin //脱水高电平有效，转移到下一个状态
					state <= st0_idle;
				end else if (dewater == 1'b1) begin//停止低电平有效，回到空闲
					state <= st5_alarm;
				end 
//				else begin
//					state <= st4_dewater; //其他情况，保持状态
//				end
			end
			st5_alarm: begin //报警态
				state <= st5_alarm;
				state_led <= 6'b011111;
				//state_led <= st5_alarm;
				if(stop == 1'b0) begin //报警高电平有效，转移到下一个状态
					state <= st0_idle;
				end else if (alarm == 1'b1) begin//停止低电平有效，回到空闲
					state <= st0_idle;
				end 
//				else begin
//					state <= st5_alarm; //其他情况，保持状态
//				end
			end
			default: begin //默认状态
				state <= st0_idle; //默认空闲
				//state_led <= st0_idle;
			end
		endcase
	end
end	



//parameter st0_idle 	= 6'b111110;//空闲态
//parameter st1_supply  = 6'b111101;//供水态
//parameter st2_wash    = 6'b111011;//漂洗态
//parameter st3_water   = 6'b110111;//放水态
//parameter st4_dewater = 6'b101111;//脱水态
//parameter st5_alarm   = 6'b011111;//报警态

//always@(posedge clk or negedge reset)begin 
//	if (!reset)begin
//		state_led <= 6'b111110;
//	end else begin
//			case(state) 
//				st0_idle:		state_led <= 6'b111110;
//				st1_supply:		state_led <= 6'b111101;
//				st2_wash:		state_led <= 6'b111011;
//				st3_water:		state_led <= 6'b110111;
//				st4_dewater:	state_led <= 6'b101111;
//				st5_alarm:		state_led <= 6'b011111;
//			endcase
//		end
//	end

//马上传递当前的状态值，准备输入给下一个状态，开始计时
assign state_out = state;

				
endmodule
