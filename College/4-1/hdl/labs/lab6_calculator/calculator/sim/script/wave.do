onerror {resume}
radix define States {
    "11'b0000" "WAIT" -color "orange",
    "11'b0001" "SAVE" -color "blue",
    "11'b0010" "LOAD" -color "red",
    "11'b0100" "EXECUTE0" -color "yellow",
    "11'b1000" "EXECUTE1" -color "yellow",
    -default hexadecimal
    -defaultcolor white
}
radix define radix_ssd {
    "7'b1000000" "0" -color "yellow",
    "7'b1111001" "1" -color "yellow",
    "7'b0100100" "2" -color "yellow",
    "7'b0110000" "3" -color "yellow",
    "7'b0011001" "4" -color "yellow",
    "7'b0010010" "5" -color "yellow",
    "7'b0000010" "6" -color "yellow",
    "7'b1111000" "7" -color "yellow",
    "7'b0000000" "8" -color "yellow",
    "7'b0010000" "9" -color "yellow",
    "7'b0001000" "A" -color "yellow",
    "7'b0000011" "B" -color "yellow",
    "7'b1000110" "C" -color "yellow",
    "7'b0100001" "D" -color "yellow",
    "7'b0000110" "E" -color "yellow",
    "7'b0001110" "F" -color "yellow",
    "7'b0111111" "dash" -color "yellow",
    "7'b1111111" "blank" -color "yellow",
    -default hexadecimal
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /toplev_tb/clk
add wave -noupdate /toplev_tb/reset
add wave -noupdate -radix binary -radixshowbase 0 /toplev_tb/switches
add wave -noupdate -radix binary -radixshowbase 0 /toplev_tb/op
add wave -noupdate -radix radix_ssd -radixshowbase 0 /toplev_tb/seven_seg_out1
add wave -noupdate -radix radix_ssd -radixshowbase 0 /toplev_tb/seven_seg_out2
add wave -noupdate -radix radix_ssd -radixshowbase 0 /toplev_tb/seven_seg_out3
add wave -noupdate /toplev_tb/uut/clk
add wave -noupdate /toplev_tb/uut/reset
add wave -noupdate /toplev_tb/uut/execute
add wave -noupdate /toplev_tb/uut/memsave
add wave -noupdate /toplev_tb/uut/memrecall
add wave -noupdate /toplev_tb/uut/switches
add wave -noupdate /toplev_tb/uut/op
add wave -noupdate /toplev_tb/uut/seven_seg_out1
add wave -noupdate /toplev_tb/uut/seven_seg_out2
add wave -noupdate /toplev_tb/uut/seven_seg_out3
add wave -noupdate /toplev_tb/uut/rezsig
add wave -noupdate /toplev_tb/uut/switchsig
add wave -noupdate /toplev_tb/uut/ones
add wave -noupdate /toplev_tb/uut/tens
add wave -noupdate /toplev_tb/uut/hundreds
add wave -noupdate /toplev_tb/uut/result_padded
add wave -noupdate /toplev_tb/uut/addr_sig
add wave -noupdate /toplev_tb/uut/exsig
add wave -noupdate /toplev_tb/uut/savesig
add wave -noupdate /toplev_tb/uut/recallsig
add wave -noupdate /toplev_tb/uut/wesig
add wave -noupdate /toplev_tb/uut/ssd1/inputs
add wave -noupdate /toplev_tb/uut/ssd1/clk
add wave -noupdate /toplev_tb/uut/ssd1/reset
add wave -noupdate /toplev_tb/uut/ssd1/hex0
add wave -noupdate /toplev_tb/uut/ssd2/inputs
add wave -noupdate /toplev_tb/uut/ssd2/clk
add wave -noupdate /toplev_tb/uut/ssd2/reset
add wave -noupdate /toplev_tb/uut/ssd2/hex0
add wave -noupdate /toplev_tb/uut/ssd3/inputs
add wave -noupdate /toplev_tb/uut/ssd3/clk
add wave -noupdate /toplev_tb/uut/ssd3/reset
add wave -noupdate /toplev_tb/uut/ssd3/hex0
add wave -noupdate /toplev_tb/uut/alu/a
add wave -noupdate /toplev_tb/uut/alu/b
add wave -noupdate /toplev_tb/uut/alu/oper
add wave -noupdate /toplev_tb/uut/alu/result
add wave -noupdate /toplev_tb/uut/alu/rez
add wave -noupdate /toplev_tb/uut/alu/reztemp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {106 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 163
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1050 ns}
