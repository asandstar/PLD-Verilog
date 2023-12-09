library verilog;
use verilog.vl_types.all;
entity Washmachine_vlg_check_tst is
    port(
        enable_out      : in     vl_logic_vector(3 downto 0);
        segment_out     : in     vl_logic_vector(6 downto 0);
        state_display_out: in     vl_logic_vector(5 downto 0);
        sampler_rx      : in     vl_logic
    );
end Washmachine_vlg_check_tst;
