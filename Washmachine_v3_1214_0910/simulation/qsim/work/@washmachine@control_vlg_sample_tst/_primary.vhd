library verilog;
use verilog.vl_types.all;
entity WashmachineControl_vlg_sample_tst is
    port(
        alarm           : in     vl_logic;
        clk             : in     vl_logic;
        dewater         : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        stop            : in     vl_logic;
        wash            : in     vl_logic;
        water           : in     vl_logic;
        waterfull       : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end WashmachineControl_vlg_sample_tst;
