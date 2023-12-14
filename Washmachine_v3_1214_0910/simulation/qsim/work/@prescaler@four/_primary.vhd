library verilog;
use verilog.vl_types.all;
entity PrescalerFour is
    port(
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic
    );
end PrescalerFour;
