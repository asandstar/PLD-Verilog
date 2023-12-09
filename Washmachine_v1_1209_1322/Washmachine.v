module Washmachine(
	input wire clk_24M,//FPGA时钟24MHz
	input wire reset0,//复位，按键触发
	input wire start,//启动，按键触发
	input wire waterfull,//水满，按键触发
	input wire stop,//停止，按键触发
	output wire [5:0] state_display,//显示状态机所在状态
	output wire [3:0] enable,//使能,控制指定数码管（四个之一）点亮
	output wire [6:0] segment//七段译码管输出abcdefg
);

			//4MHz
	 		PrescalerSix prescalerSix_inst (
        .clk_in(clk_24M),
        .clk_out(clk_6M)
    );
			//1MHz
	 		PrescalerFour prescalerFour_inst (
        .clk_in(clk_6M),
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
	 
	 	 	 WashmachineControl washmachineControl_inst1 (
        .clk(clk),
        .reset(reset0),
        .start(start),
        .waterfull(waterfull),
        .stop(stop),
		  
        .wash(wash),
        .water(water),
        .dewater(dewater),
        .alarm(alarm),
		  
		  
        .state_display(state_show)
    );
	 
	 
    TimeCounter timeCounter_inst (
        .clk(clk7),
        .reset(reset0),
        .state_display(state_show),
		  
		  
        .wash(wash),
        .water(water),
        .dewater(dewater),
        .alarm(alarm),
        .seg3(seg3),
        .seg2(seg2),
        .seg1(seg1),
        .seg0(seg0)
    );
	 

    DynamicScan dynamicScan_inst (
        .clk(clk4),
        .seg3(seg3),
        .seg2(seg2),
        .seg1(seg1),
        .seg0(seg0),
        .seg(seg),
        .enable(enable)
    );

	 
	 SegDecode segDecode_inst (
        .seg(seg),
        .segment(segment)
    );
	 
	 

	 
endmodule




