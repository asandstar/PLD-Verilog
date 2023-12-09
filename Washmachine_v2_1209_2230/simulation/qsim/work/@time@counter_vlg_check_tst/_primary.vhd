library verilog;
use verilog.vl_types.all;
entity TimeCounter_vlg_check_tst is
    port(
        alarm           : in     vl_logic;
        dewater         : in     vl_logic;
        seg0            : in     vl_logic_vector(3 downto 0);
        seg1            : in     vl_logic_vector(3 downto 0);
        seg2            : in     vl_logic_vector(3 downto 0);
        seg3            : in     vl_logic_vector(3 downto 0);
        wash            : in     vl_logic;
        water           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end TimeCounter_vlg_check_tst;
