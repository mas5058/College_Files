vlib work
vcom -93 -work work ../../src/toplevelcount.vhd
vcom -93 -work work ../../src/generic_adder_beh.vhd
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../src/toplevelcount_tb.vhd
vsim -novopt toplevelcount_tb
do wave.do
run 2000 ns
