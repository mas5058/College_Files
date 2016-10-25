vlib work
vcom -93 -work work ../../src/toplev.vhd
vcom -93 -work work ../../src/alu2bitoper.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../src/toplev_tb.vhd
vsim -novopt toplev_tb
do wave.do
run 300 ns
