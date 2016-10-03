vlib work
vcom -93 -work work ../../src/toplevelcount.vhd
vcom -93 -work work ../src/toplevelcount_tb.vhd
vsim -novopt seven_seg_tb
do wave.do
run 500 ns
