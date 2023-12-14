library verilog;
use verilog.vl_types.all;
entity Washmachine is
    port(
        clk_24M         : in     vl_logic;
        reset0          : in     vl_logic;
        start           : in     vl_logic;
        waterfull       : in     vl_logic;
        stop            : in     vl_logic;
        state_display_out: out    vl_logic_vector(5 downto 0);
        enable_out      : out    vl_logic_vector(3 downto 0);
        segment_out     : out    vl_logic_vector(6 downto 0)
    );
end Washmachine;
