library verilog;
use verilog.vl_types.all;
entity hw7_1_vlg_check_tst is
    port(
        q               : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end hw7_1_vlg_check_tst;
