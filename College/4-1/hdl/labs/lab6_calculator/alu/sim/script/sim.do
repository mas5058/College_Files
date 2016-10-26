vlib work
vcom -93 -work work ../../src/alu2bitoper.vhd
vcom -93 -work work ../src/Tb_alu.vhd
vsim -novopt toplev_tb
do wave.do
run 300 ns
