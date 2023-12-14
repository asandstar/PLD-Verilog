library verilog;
use verilog.vl_types.all;
entity Washmachine_vlg_sample_tst is
    port(
        clk_24M         : in     vl_logic;
        reset0          : in     vl_logic;
        start           : in     vl_logic;
        stop            : in     vl_logic;
        waterfull       : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Washmachine_vlg_sample_tst;
