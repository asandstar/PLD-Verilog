library verilog;
use verilog.vl_types.all;
entity WashmachineControl_vlg_check_tst is
    port(
        state_led       : in     vl_logic_vector(5 downto 0);
        state_out       : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end WashmachineControl_vlg_check_tst;
