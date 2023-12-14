module Washmachine(
	input wire clk_24M,//FPGA时钟24MHz
	input wire reset0,//复位，按键触发
	input wire start,//启动，按键触发
	input wire waterfull,//水满，按键触发
	input wire stop,//停止，按键触发
	output wire [5:0] state_display_out,//显示状态机所在状态
	output wire [3:0] enable_out,//使能,控制指定数码管（四个之一）点亮
	output wire [6:0] segment_out//七段译码管输出abcdefg
);

wire clk_4M;
wire clk_1M;
wire clk_100K;
wire clk_10K;
wire clk_1K;
wire clk_100;
wire clk_10;

wire washsig;
wire watersig;
wire dewatersig;
wire alarmsig;

wire [3:0] DySeg3;
wire [3:0] DySeg2;
wire [3:0] DySeg1;
wire [3:0] DySeg0;
wire [3:0] DySeg;

wire [2:0] state;

wire [5:0] state_display_led;
wire [3:0] en;
wire [6:0] se;

			//4MHz
	 		PrescalerSix prescalerSix_inst (
        .clk_in(clk_24M),
        .clk_out(clk_4M)
    );
			//1MHz
	 		PrescalerFour prescalerFour_inst (
        .clk_in(clk_4M),
        .clk_out(clk_1M)
    );	
			//100kHz
	 		PrescalerTen prescalerTen_inst1 (
        .clk_in(clk_1M),
        .clk_out(clk_100K)
    );	//10kHz
	 	 	PrescalerTen prescalerTen_inst2 (
        .clk_in(clk_100K),
        .clk_out(clk_10K)
    );
			//1kHz
	 	 	PrescalerTen prescalerTen_inst3 (
        .clk_in(clk_10K),
        .clk_out(clk_1K)
    );
			//100Hz
	 	 	PrescalerTen prescalerTen_inst4 (
        .clk_in(clk_1K),
        .clk_out(clk_100)
    );
			//10Hz
	 	 	PrescalerTen prescalerTen_inst5 (
        .clk_in(clk_100),
        .clk_out(clk_10)
    );
	 
	 WashmachineControl washmachineControl_inst (
        //in
		  .clk(clk_24M),
        .reset(reset0),
		  //拨盘开关控制，低电平有效
        .start(start),
        .waterfull(waterfull),
        .stop(stop),
		  //时间到，高电平有效
        .wash(washsig),
        .water(watersig),
        .dewater(dewatersig),
        .alarm(alarmsig),
		  //out
		  .state_led(state_display_led),
		  .state_out(state)
    );
	 
	 
    TimeCounter timeCounter_inst (
        //in
		  //.clk(clk_10),
		  //.clk(clk_1K),//正常时间
		  .clk(clk_10K),//加速10倍
        .reset(reset0),
        .state_in(state),
		  //out 传递到control里
        .wash(washsig),
        .water(watersig),
        .dewater(dewatersig),
        .alarm(alarmsig),
		  //四位数码管当前输出，从3到0是高位到低位
        .seg3(DySeg3),
        .seg2(DySeg2),
        .seg1(DySeg1),
        .seg0(DySeg0)
    );
	 

    DynamicScan dynamicScan_inst (
		  //in
		  //验收时动态扫描频率
        .clk(clk_10K),
		  //仿真时查看频率
		  //.clk(clk_1M),
		  //四位数码管当前输入，从3到0是高位到低位
        .seg3(DySeg3),
        .seg2(DySeg2),
        .seg1(DySeg1),
        .seg0(DySeg0),
		  //out
        //.seg(DySeg),
		  .segment(se),
        .enable(en)
    );

//	 
//	 SegDecode segDecode_inst1 (
//		  //in
//        .seg(DySeg),
//		  //out
//        .segment(se)
//    );
	 
assign state_display_out = state_display_led;
assign enable_out = en;
assign segment_out = se;
	 
endmodule




