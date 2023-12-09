library verilog;
use verilog.vl_types.all;
entity TimeCounter_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        state_in        : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end TimeCounter_vlg_sample_tst;
