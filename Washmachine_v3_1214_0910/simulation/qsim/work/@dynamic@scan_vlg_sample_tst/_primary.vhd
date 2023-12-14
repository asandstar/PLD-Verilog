library verilog;
use verilog.vl_types.all;
entity DynamicScan_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        seg0            : in     vl_logic_vector(3 downto 0);
        seg1            : in     vl_logic_vector(3 downto 0);
        seg2            : in     vl_logic_vector(3 downto 0);
        seg3            : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end DynamicScan_vlg_sample_tst;
