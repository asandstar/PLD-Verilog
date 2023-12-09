library verilog;
use verilog.vl_types.all;
entity PrescalerSix is
    port(
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic
    );
end PrescalerSix;
