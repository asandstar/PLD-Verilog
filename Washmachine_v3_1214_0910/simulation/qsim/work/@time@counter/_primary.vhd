library verilog;
use verilog.vl_types.all;
entity TimeCounter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        state_in        : in     vl_logic_vector(2 downto 0);
        wash            : out    vl_logic;
        water           : out    vl_logic;
        dewater         : out    vl_logic;
        alarm           : out    vl_logic;
        seg3            : out    vl_logic_vector(3 downto 0);
        seg2            : out    vl_logic_vector(3 downto 0);
        seg1            : out    vl_logic_vector(3 downto 0);
        seg0            : out    vl_logic_vector(3 downto 0)
    );
end TimeCounter;
