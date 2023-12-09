library verilog;
use verilog.vl_types.all;
entity DynamicScan_vlg_check_tst is
    port(
        enable          : in     vl_logic_vector(3 downto 0);
        seg             : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end DynamicScan_vlg_check_tst;
