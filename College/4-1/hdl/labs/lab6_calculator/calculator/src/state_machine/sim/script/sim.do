vlib work
vcom -93 -work work ../../src/state_machine.vhd
vcom -93 -work work ../src/state_machine_tb.vhd
vsim -novopt state_machine_tb
do wave.do
run 1 us
