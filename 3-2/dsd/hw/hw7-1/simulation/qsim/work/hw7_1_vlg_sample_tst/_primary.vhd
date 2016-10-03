library verilog;
use verilog.vl_types.all;
entity hw7_1_vlg_sample_tst is
    port(
        n_cp            : in     vl_logic;
        n_rd            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end hw7_1_vlg_sample_tst;
