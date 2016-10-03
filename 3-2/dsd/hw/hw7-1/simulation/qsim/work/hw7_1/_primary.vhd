library verilog;
use verilog.vl_types.all;
entity hw7_1 is
    port(
        n_cp            : in     vl_logic;
        n_rd            : in     vl_logic;
        q               : out    vl_logic_vector(3 downto 0)
    );
end hw7_1;
