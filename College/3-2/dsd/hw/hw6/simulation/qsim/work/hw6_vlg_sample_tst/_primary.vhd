library verilog;
use verilog.vl_types.all;
entity hw6_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        j               : in     vl_logic;
        k               : in     vl_logic;
        resetn          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end hw6_vlg_sample_tst;
