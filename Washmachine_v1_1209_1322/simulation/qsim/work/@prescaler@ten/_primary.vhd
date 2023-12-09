library verilog;
use verilog.vl_types.all;
entity PrescalerTen is
    port(
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic
    );
end PrescalerTen;
