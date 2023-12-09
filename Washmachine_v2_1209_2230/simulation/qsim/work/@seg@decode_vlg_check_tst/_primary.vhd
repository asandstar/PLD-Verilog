library verilog;
use verilog.vl_types.all;
entity SegDecode_vlg_check_tst is
    port(
        segment         : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end SegDecode_vlg_check_tst;
