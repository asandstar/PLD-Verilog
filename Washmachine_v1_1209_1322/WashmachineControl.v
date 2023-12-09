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
	output reg [2:0] state_display//状态显示	
);
//定义状态
parameter ST0 = 3'b001;//空闲态
parameter ST1 = 3'b011;//供水态
parameter ST2 = 3'b111;//漂洗态
parameter ST3 = 3'b110;//放水态
parameter ST4 = 3'b100;//脱水态
parameter ST5 = 3'b000;//报警态
//定义状态寄存器并赋初值
reg [2:0] state = ST0;
//always语句块
always @(posedge clk)begin	
	case(state)
		ST0: begin //空闲态
			state_display <= ST0;
			if(start == 1'b0) begin //启动低电平有效，转移到下一个状态
				state <= ST1;
			end else begin
				state <= ST0;//其他情况，保持状态
			end
		end
		ST1: begin //供水态
			state_display <= ST1;
			if(waterfull == 1'b0) begin //水满低电平有效，转移到下一个状态
				state <= ST2;
			end else if (stop == 1'b0) begin//停止低电平有效，回到空闲
				state <= ST0;
			end else begin
				state <= ST1;	//其他情况，保持状态
			end
		end
		ST2: begin //漂洗态
			state_display <= ST2;
			if(wash == 1'b1) begin //漂洗高电平有效，转移到下一个状态
				state <= ST3;
			end else if (stop == 1'b0) begin//停止低电平有效，回到空闲
				state <= ST0;
			end else begin
				state <= ST2; //其他情况，保持状态
			end
		end
		ST3: begin //放水态
			state_display <= ST3;
			if(water == 1'b1) begin //放水高电平有效，转移到下一个状态
				state <= ST4;
			end else if (stop == 1'b0) begin//停止低电平有效，回到空闲
				state <= ST0;
			end else begin
				state <= ST3; //其他情况，保持状态
			end
		end
		ST4: begin //脱水态
			state_display <= ST4;
			if(dewater == 1'b1) begin //脱水高电平有效，转移到下一个状态
				state <= ST5;
			end else if (stop == 1'b0) begin//停止低电平有效，回到空闲
				state <= ST0;
			end else begin
				state <= ST4; //其他情况，保持状态
			end
		end
		ST5: begin //报警态
			state_display <= ST5;
			if(alarm == 1'b1) begin //报警高电平有效，转移到下一个状态
				state <= ST0;
			end else if (stop == 1'b0) begin//停止低电平有效，回到空闲
				state <= ST0;
			end else begin
				state <= ST5; //其他情况，保持状态
			end
		end
		default: begin //默认状态
			state_display <= ST0; //默认空闲
			state <= ST0; //默认空闲
		end
	endcase
end	
				
endmodule
