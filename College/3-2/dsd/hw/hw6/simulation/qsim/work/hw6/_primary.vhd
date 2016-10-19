library verilog;
use verilog.vl_types.all;
entity hw6 is
    port(
        clk             : in     vl_logic;
        resetn          : in     vl_logic;
        j               : in     vl_logic;
        k               : in     vl_logic;
        q               : out    vl_logic;
        qn              : out    vl_logic
    );
end hw6;
