library verilog;
use verilog.vl_types.all;
entity WashmachineControl is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        waterfull       : in     vl_logic;
        stop            : in     vl_logic;
        wash            : in     vl_logic;
        water           : in     vl_logic;
        dewater         : in     vl_logic;
        alarm           : in     vl_logic;
        state_out       : out    vl_logic_vector(2 downto 0);
        state_led       : out    vl_logic_vector(5 downto 0)
    );
end WashmachineControl;
