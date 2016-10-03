onerror {quit -f}
vlib work
vlog -work work lab3.vo
vlog -work work lab3.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.lab3_vlg_vec_tst
vcd file -direction lab3.msim.vcd
vcd add -internal lab3_vlg_vec_tst/*
vcd add -internal lab3_vlg_vec_tst/i1/*
add wave /*
run -all
