library verilog;
use verilog.vl_types.all;
entity DynamicScan is
    port(
        clk             : in     vl_logic;
        seg3            : in     vl_logic_vector(3 downto 0);
        seg2            : in     vl_logic_vector(3 downto 0);
        seg1            : in     vl_logic_vector(3 downto 0);
        seg0            : in     vl_logic_vector(3 downto 0);
        seg             : out    vl_logic_vector(3 downto 0);
        segment         : out    vl_logic_vector(6 downto 0);
        enable          : out    vl_logic_vector(3 downto 0)
    );
end DynamicScan;
