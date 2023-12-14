library verilog;
use verilog.vl_types.all;
entity SegDecode_vlg_sample_tst is
    port(
        seg             : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end SegDecode_vlg_sample_tst;
